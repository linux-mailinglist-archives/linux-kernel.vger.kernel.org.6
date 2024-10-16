Return-Path: <linux-kernel+bounces-367791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F08519A06DF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748DA1F22171
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBBE206071;
	Wed, 16 Oct 2024 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="F4DXBdQ4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CSR/e5nZ"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F347421E3CB
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729073820; cv=none; b=N8nN7sQ0soG4qRAYuJiL7LWQHCWFBDvyEBoycrzKZWfShZe5KimOgUiKp6djH7SK6/rM8i1q1IWS5gawoXQ9cqmwdVQCQYMf2blM60bnArMrspOOh80kNNkH4eJGKbD7fiCoJ8a09gu3epUcjogo19093A7nQ5IGPJSilrp55I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729073820; c=relaxed/simple;
	bh=4TZlPDdYbpnwR1bVzWilx/FDwOyZh6KnoHZ5aR1DrC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vkq/fN67iFOFcS9z8IfBXlfUTog1NH6QDF29KNL8nSH5XoCRxDwkOYlm4+wR31Qy62FC+ffQV2dm7a9ZeAahk+sWcKmxJBKJaT0nTskQbeD+Y2nrc1SQHqA3kWF7nnmdnOEgspc40wmksMi0OOCDhuNCdUilIJCA09cUNzDjheg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=F4DXBdQ4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CSR/e5nZ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 185311380167;
	Wed, 16 Oct 2024 06:16:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 16 Oct 2024 06:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729073816; x=
	1729160216; bh=I0jjL1dUByTAPJLWxibZQUAh1Cxn8zTwcDHx7s3FQJQ=; b=F
	4DXBdQ4L63cEECudCAjaPmz4dKzKgbVwlL+fM9T6CTJ3pbmNRFaOpZV1AkJx4WLo
	qiUrWIRMxEAcmUJXlFmSiNt9e9dyGW9IFswsUbQ0v34FVIygWPM7oBjAIcR0HKjj
	Vxbvg3yq5bZkE1m6Bc1DDrQsdlpgMu4wudZHY3RnYMC3F0eKzywWol8p4kOtdIiV
	UkAGyn/TmAoDJXDRYnRAV2oKz1LU2WHC3PhnXKyFyOZwB+vPzQi11Kx83Od4IajX
	EITwde4amfOfkSR7OfAp1/jnTH5wCNBDC2FcYNaK8ltwVgzJbfsytFmD+viqZd8W
	aBGiy9Yr/DLuEA+UFIMjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729073816; x=1729160216; bh=I0jjL1dUByTAPJLWxibZQUAh1Cxn
	8zTwcDHx7s3FQJQ=; b=CSR/e5nZNBZ+9RBMcM5OvTo5qh74/TnhyM4NPPt3JpDe
	J8IzYhz5NBzCD4h/gpuCREBygxqsgRszcC42iPQNfjRnQYeSPxoYOQGEHkSfH8rd
	7rQtGzS0FryrS//FrAPMmaF1GBNBBGQXlT1LorJboiED4qxuPQoJOZiD25xAxpxi
	Jsu7X6xNaaiwjIQYQWbxEyO0WjafL9IMgLZCEKh0WyPgzVJ5rG9WX+Bb9myQEpQS
	FbbDckStNL4SpnyQiSYXhFZEfqQ4gwC2JCdZRWcZ/lw9z8EMvvy4BlSqlqHAW1x4
	zS3g9TpOyFxmCLTd3SXHQlDDxNbR535YYbzXFVlyRA==
X-ME-Sender: <xms:l5IPZ2xp0vm1Tisl3YZ6AgzuQoH_psBbRDZwVLs9Xwpeen5v_LmzuA>
    <xme:l5IPZyQH1IiwxV2Kg-nk_BOpAHaHqpYiFgF3B7XjxBMOtjOSND8C7Pv6WtTfFfSun
    8DXKG-PABtuq__BvZU>
X-ME-Received: <xmr:l5IPZ4W6QYW1efbMydvQtUceLXhdkOQL4XUcVU809b4nH1rScIgJXVohYT8C8l_FfqNJcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehmuhgthhhunhdrshhonhhgsehlihhnuhigrdguvghvpdhrtghpthhtoheptghh
    vghnrhhiughonhhgsehhuhgrfigvihdrtghomhdprhgtphhtthhopegrnhhshhhumhgrnh
    drkhhhrghnughurghlsegrrhhmrdgtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhig
    qdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegurghvihgusehfrhhomhhorh
    gsihhtrdgtohhmpdhrtghpthhtohepiihhvghnghhqihdrrghrtghhsegshihtvggurghn
    tggvrdgtohhmpdhrtghpthhtoheprhhomhgrnhdrghhushhhtghhihhnsehlihhnuhigrd
    guvghvpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:l5IPZ8hUD1hHaUbKORFMELfd3q73DAwk6SWaJwQBJMCzlHqfKPPKtg>
    <xmx:l5IPZ4CNVhnaSSFcOOe4nNXhogs-tNEwqOuGs-eKQK0lBLGmNX7dpQ>
    <xmx:l5IPZ9Lb4X9oLZHgMWCoaM5aP4Tq5IDlxBuCcyhqkwsn-H_SNQaEgQ>
    <xmx:l5IPZ_DV3pIlSd3KKV57FiHIO9w7mZWGpfIWyFyWfIHsxY21HiJylQ>
    <xmx:mJIPZ85_e8rMeZF556Mxh0A902uUuV_0zhAbuHsTlveUptRLk59Hp-zr>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 06:16:51 -0400 (EDT)
Date: Wed, 16 Oct 2024 13:16:46 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Muchun Song <muchun.song@linux.dev>
Cc: chenridong <chenridong@huawei.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, akpm@linux-foundation.org, david@fromorbit.com, 
	zhengqi.arch@bytedance.com, roman.gushchin@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, wangweiyang2@huawei.com
Subject: Re: [PATCH v2] mm: shrinker: avoid memleak in alloc_shrinker_info
Message-ID: <w7x2gzrpluandokbym2y7sbmfshbfb5wgh4lt4d72bnorb26la@cyavgpacqwhh>
References: <20241014032336.482088-1-chenridong@huaweicloud.com>
 <m3cjozicivz4ydv6ovzkupuzpcvc7uptlhjd3bndpsak3z7ill@6txhj7tpejir>
 <cbf8475d-5c79-4fa4-b2a1-f553166b0afd@arm.com>
 <4a18e997-3a94-4248-8923-c3764d12b0d6@huawei.com>
 <FD2AA126-5885-41C7-ACFD-85C764170B9E@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FD2AA126-5885-41C7-ACFD-85C764170B9E@linux.dev>

On Wed, Oct 16, 2024 at 10:21:30AM +0800, Muchun Song wrote:
> 
> 
> > On Oct 16, 2024, at 09:25, chenridong <chenridong@huawei.com> wrote:
> > 
> > 
> > 
> > On 2024/10/15 14:55, Anshuman Khandual wrote:
> >> On 10/14/24 16:59, Kirill A. Shutemov wrote:
> >>> On Mon, Oct 14, 2024 at 03:23:36AM +0000, Chen Ridong wrote:
> >>>> From: Chen Ridong <chenridong@huawei.com>
> >>>> 
> >>>> A memleak was found as bellow:
> >>>> 
> >>>> unreferenced object 0xffff8881010d2a80 (size 32):
> >>>>   comm "mkdir", pid 1559, jiffies 4294932666
> >>>>   hex dump (first 32 bytes):
> >>>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >>>>     40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  @...............
> >>>>   backtrace (crc 2e7ef6fa):
> >>>>     [<ffffffff81372754>] __kmalloc_node_noprof+0x394/0x470
> >>>>     [<ffffffff813024ab>] alloc_shrinker_info+0x7b/0x1a0
> >>>>     [<ffffffff813b526a>] mem_cgroup_css_online+0x11a/0x3b0
> >>>>     [<ffffffff81198dd9>] online_css+0x29/0xa0
> >>>>     [<ffffffff811a243d>] cgroup_apply_control_enable+0x20d/0x360
> >>>>     [<ffffffff811a5728>] cgroup_mkdir+0x168/0x5f0
> >>>>     [<ffffffff8148543e>] kernfs_iop_mkdir+0x5e/0x90
> >>>>     [<ffffffff813dbb24>] vfs_mkdir+0x144/0x220
> >>>>     [<ffffffff813e1c97>] do_mkdirat+0x87/0x130
> >>>>     [<ffffffff813e1de9>] __x64_sys_mkdir+0x49/0x70
> >>>>     [<ffffffff81f8c928>] do_syscall_64+0x68/0x140
> >>>>     [<ffffffff8200012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>>> 
> >>>> In the alloc_shrinker_info function, when shrinker_unit_alloc return
> >>>> err, the info won't be freed. Just fix it.
> >>>> 
> >>>> Fixes: 307bececcd12 ("mm: shrinker: add a secondary array for shrinker_info::{map, nr_deferred}")
> >>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> >>>> ---
> >>>>  mm/shrinker.c | 1 +
> >>>>  1 file changed, 1 insertion(+)
> >>>> 
> >>>> diff --git a/mm/shrinker.c b/mm/shrinker.c
> >>>> index dc5d2a6fcfc4..92270413190d 100644
> >>>> --- a/mm/shrinker.c
> >>>> +++ b/mm/shrinker.c
> >>>> @@ -97,6 +97,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
> >>>>    err:
> >>>>   mutex_unlock(&shrinker_mutex);
> >>>> + kvfree(info);
> >>>>   free_shrinker_info(memcg);
> >>>>   return -ENOMEM;
> >>>>  }
> >>> 
> >>> NAK. If in the future there going to one more error case after
> >>> rcu_assign_pointer() we will end up with double free.
> >>> 
> >>> This should be safer:
> >>> 
> >>> diff --git a/mm/shrinker.c b/mm/shrinker.c
> >>> index dc5d2a6fcfc4..763fd556bc7d 100644
> >>> --- a/mm/shrinker.c
> >>> +++ b/mm/shrinker.c
> >>> @@ -87,8 +87,10 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
> >>>   if (!info)
> >>>   goto err;
> >>>   info->map_nr_max = shrinker_nr_max;
> >>> - if (shrinker_unit_alloc(info, NULL, nid))
> >>> + if (shrinker_unit_alloc(info, NULL, nid)) {
> >>> + kvfree(info);
> >>>   goto err;
> >>> + }
> >>>   rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
> >>>   }
> >>>   mutex_unlock(&shrinker_mutex);
> >> Agreed, this is what I mentioned earlier as well.
> >> ------------------------------------------------------------------
> >> I guess kvfree() should be called just after shrinker_unit_alloc()
> >> fails but before calling into "goto err"
> >> ------------------------------------------------------------------
> > 
> > After discussion, it seems that v1 is acceptable.
> > Hi, Muchun, do you have any other opinions?
> 
> I insist on my opinion, not mixing two different approaches
> to do release resources.

It makes no sense.

This kvfree() is specifically to handle the case when 'info' is allocated,
but not yet assigned to ->shrinker_info. And 'err:' block handles all
other error cases. Putting kvfree() in 'err:' section is double-free
timebomb.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

