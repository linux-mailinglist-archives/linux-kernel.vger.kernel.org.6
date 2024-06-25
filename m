Return-Path: <linux-kernel+bounces-229788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EC291742B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 00:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265701F23733
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 22:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF3A17E911;
	Tue, 25 Jun 2024 22:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XxxtbFFP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD30149C53
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 22:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719354114; cv=none; b=PpNd/LV+bBExU4WaKKG7fZq6GL3R8yvowSH3bscQFsb6VgzBpHDEJpQ/IxD5vWLTv3jklcOteJ/u8wb+t3JjlhkCB/2lWQGVHCpFbzFmg3vqSRRkaZz/eXH0JKqtlmdCcmuN0wIupxZ+GyUu0uxuiuAAlyz8gc4BYif59VWE2bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719354114; c=relaxed/simple;
	bh=IWOi2HaQdIy+DK2/fP1UtD4ZDDZLRzBu5H/o9BGRBhA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uRY2kIgTa1jq3CdT5sVuFx+fba5ix41y6dLWH2+RbEYZTTcIygrolvVTLTH7iX1TbR/7rYFhoiJCJyut41TLrFrBPnVPBkHr40eQJlLNhHxtzc57mDgp7YQmy0OyMvzKLq0jXFhxq3QreovInVmIGX1qlHX2FE7Ic7ezMsUATAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XxxtbFFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797B4C32781;
	Tue, 25 Jun 2024 22:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719354113;
	bh=IWOi2HaQdIy+DK2/fP1UtD4ZDDZLRzBu5H/o9BGRBhA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XxxtbFFP3AHRu2SnTKvNoVWOL7ZsHc19Rgbnv9soq0CdHpPJIYzb7x1qXh87E+S6k
	 T4W/ZKg3GhGSjismlc+1zv8zivTlohdjjCDT12HZyo5mF1VQqK8TONIoVuEdf2VBAp
	 aA54DFSQBqDd7tf9za5kbeO+3rQzQwDY7o+YCTj4=
Date: Tue, 25 Jun 2024 15:21:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Oleg Nesterov <oleg@redhat.com>, alexjlzheng@gmail.com,
 "Eric W. Biederman" <ebiederm@xmission.com>, brauner@kernel.org,
 axboe@kernel.dk, tandersen@netflix.com, willy@infradead.org,
 mjguzik@gmail.com, alexjlzheng@tencent.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: optimize the redundant loop of
 mm_update_next_owner()
Message-Id: <20240625152152.89381ebd8f3fda856a320f72@linux-foundation.org>
In-Reply-To: <ZnU-wlFE5usvo9ah@tiehlicka>
References: <20240620152744.4038983-1-alexjlzheng@tencent.com>
	<20240620172958.GA2058@redhat.com>
	<ZnU-wlFE5usvo9ah@tiehlicka>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jun 2024 10:50:10 +0200 Michal Hocko <mhocko@suse.com> wrote:

> On Thu 20-06-24 19:30:19, Oleg Nesterov wrote:
> > Can't review, I forgot everything about mm_update_next_owner().
> > So I am sorry for the noise I am going to add, feel free to ignore.
> > Just in case, I see nothing wrong in this patch.
> > 
> > I think this deserves a comment to explain that this is optimization
> > for the case we race with the pending mmput(). mm_update_next_owner()
> > checks mm_users at the start.
> > 
> > And. Can we drop tasklist and use rcu_read_lock() before for_each_process?
> > Yes, this will probably need more changes even if possible...
> > 
> > 
> > Or even better. Can't we finally kill mm_update_next_owner() and turn the
> > ugly mm->owner into mm->mem_cgroup ?
> 
> Yes, dropping the mm->owner should be a way to go. Replacing that by
> mem_cgroup sounds like an improvemnt. I have a vague recollection that
> this has some traps on the way. E.g. tasks sharing the mm but living in
> different cgroups. Things have changes since the last time I've checked
> and for example memcg charge migration on task move will be deprecated
> soon so chances are that there are less roadblocks on the way.

I think this was alexjlzheng's first kernel contribution and as such we
might not be hearing from him(?) again.  And that's OK, thanks for the
bug report - it helps Linux.

Meanwhile we have a stalled patch in mm-unstable.  If someone could add
this issue to their todo list, that would be great.


