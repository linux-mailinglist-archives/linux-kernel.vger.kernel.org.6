Return-Path: <linux-kernel+bounces-201574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EC28FC034
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B491C223EA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C5614D712;
	Tue,  4 Jun 2024 23:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SGCUNjfk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57D914D6E1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717545005; cv=none; b=NL3xGo7xcOW8GkHohyXuXSwtk/5YXhx0CECIT41RV64Th2OQ4VdY/sLYa6Kz2kVRfWzIX3uCdKH/Aldq64dDXR4BkXrsameE6K4YnGDowbib3n7p1xrIcgDhL49ozJWZnMOIi0Eh87w+QAxdrmtI3s5ZyVPEr/eHiYwYNN5FZIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717545005; c=relaxed/simple;
	bh=con71CX0BGDmlwUBYWKByZ1lhtlJ/vmyoSVfDZzoJd4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tg2a+aP1hfBCl3mQQwjeYOtWajJOHTvV+ofctzacZ56x2BCkAWsH3KSqyxmQzo5lBMjICUd5pPmX7ubZvVhCrviPtu3fzdmdDFe0DrzStqtwabTYVUISJVp8Iitk4AUjTGXju0XZ/XY8zprchk9mJ9UtRoPG0/kZG7RaSek9BKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SGCUNjfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6963C2BBFC;
	Tue,  4 Jun 2024 23:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1717545005;
	bh=con71CX0BGDmlwUBYWKByZ1lhtlJ/vmyoSVfDZzoJd4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SGCUNjfkcp/cAiWs3B3g3hUaE4zGB+hmg5uXoKcApNs7PPhpfdqKwrcrQVEIIQiGb
	 6i9AiaqM0Y9KoXujRZlQspBHQcdhmJyoA68HRbSxlVoDljW5zoyeP1z/1d7q3O3Bis
	 aY0VTMtJo/Lt6o5IIGfOghqCB7JnwufVf+8CvMNk=
Date: Tue, 4 Jun 2024 16:50:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: hughd@google.com, willy@infradead.org, david@redhat.com,
 wangkefeng.wang@huawei.com, ying.huang@intel.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com,
 ioworker0@gmail.com, da.gomez@samsung.com, p.raghav@samsung.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] add mTHP support for anonymous shmem
Message-Id: <20240604165004.7d6057d9192399eef8d19078@linux-foundation.org>
In-Reply-To: <cover.1717495894.git.baolin.wang@linux.alibaba.com>
References: <cover.1717495894.git.baolin.wang@linux.alibaba.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Jun 2024 18:17:44 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> base: mm-unstable
> user-time    sys_time    faults_per_sec_per_cpu     faults_per_sec
> 0.04s        3.10s         83516.416                  2669684.890
>
> ...
>
> mm-unstable + patchset, anon shmem 64K mTHP enabled
> user-time    sys_time    faults_per_sec_per_cpu     faults_per_sec
> 0.08s        0.31s         678630.231                 17082522.495
> 

Geeze, is that the best you can do ;)

It's early and there's review work to be done.  But I'll queue this up
for testing now, as it's clearly something we should finish off and
get merged.


