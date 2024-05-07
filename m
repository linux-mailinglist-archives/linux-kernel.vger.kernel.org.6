Return-Path: <linux-kernel+bounces-171909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDD58BEA6C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7C6284705
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE73A2576E;
	Tue,  7 May 2024 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rSDqox2E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0077D15FD03
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 17:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715102563; cv=none; b=uqE4AijLI48OVc+PCPPwTPVUc+Ict7KJoWrSEsogYM32uugvtKzoV+8DVIwOUpbjKFPZH5RT3X5WzP71H+OoLtDC0misu+mTcr3v/Oupe+IcChiM3XHoJrUswoRXQzfK5c7KKku6ZckZOxnAivtdo78yunzEYoMOk0YZKi3EHU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715102563; c=relaxed/simple;
	bh=jsKpgfNXCcSTLHP8MOPapGa4X0VcGRUo2Nh6pYraQAY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SF3CLeyalrlSaAub1a9m3BUikeUdh7Hbr0CVcns4Y05Z2TfaWtaezFJsBFuxRgH5BVzCT3VtUPEsW15VjWzWSTyYXhPhKZnlWjRTHvYrWIlWHHmOjWr50yvEP56y4ZrMEuZPPwsGEG/CVooW7N/nu+LLXmQRWIe8xIxVIA72fR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=rSDqox2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03D9C2BBFC;
	Tue,  7 May 2024 17:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1715102562;
	bh=jsKpgfNXCcSTLHP8MOPapGa4X0VcGRUo2Nh6pYraQAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rSDqox2EySg1GaW8XcSqE8TrDabLDqoXt8Uo3hd6f1x96PX4EapBLLbFYlze+TusE
	 Cwz84nldp/4jolFfPC9/+u0+7fr2XoQvL7sQiE9UgSfBXxgSopk0YU0eohHDDdIXSp
	 YzyWtNXnUSagh2Blmy+ZRUURWwIm452Dk/24yc2w=
Date: Tue, 7 May 2024 10:22:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lance Yang <ioworker0@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, willy@infradead.org, sj@kernel.org,
 maskray@google.com, ziy@nvidia.com, ryan.roberts@arm.com,
 21cnbao@gmail.com, mhocko@suse.com, fengwei.yin@intel.com,
 zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com,
 libang.li@antgroup.com, wangkefeng.wang@huawei.com,
 songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] mm/rmap: integrate PMD-mapped folio splitting
 into pagewalk loop
Message-Id: <20240507102241.0a09db69afd62efb5ce84f17@linux-foundation.org>
In-Reply-To: <CAK1f24=rWdgscbDa6pMqOmTEDOHVLo5NQ=7jOo9TdyJRXahHZg@mail.gmail.com>
References: <20240501042700.83974-1-ioworker0@gmail.com>
	<20240501042700.83974-3-ioworker0@gmail.com>
	<cc9fd23f-7d87-48a7-a737-acbea8e95fb7@linux.alibaba.com>
	<CAK1f24kyCj2Svguuu07wDuVEWYYbcmRc_18ihgVAzSjoJ9ox2A@mail.gmail.com>
	<a8f7a8da-c2e1-443c-9220-a224d97b1c81@redhat.com>
	<CAK1f24=rWdgscbDa6pMqOmTEDOHVLo5NQ=7jOo9TdyJRXahHZg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 May 2024 16:38:07 +0800 Lance Yang <ioworker0@gmail.com> wrote:

> > > Yep, I'll also set pvmw.ptl to NULL here if any corner cases arise.
> > >
> >
> > This series already resides in mm-stable. I asked Andrew to remove it
> > for now. If that doesn't work, we'll need fixup patches to address any
> > review feedback.
> 
> I'll patiently wait Andrew's response, and then submit the next version or
> fixup patches accordingly.

Well, which series are we talking about?  "mm/madvise: enhance
lazyfreeing with mTHP in madvise_free v10" or ""Reclaim lazyfree THP
without splitting v4" or both?

And how significant are the needed fixup patches?

And what is our confidence level after those fixups are in place?

