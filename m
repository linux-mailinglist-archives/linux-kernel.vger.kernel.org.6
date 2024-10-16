Return-Path: <linux-kernel+bounces-368512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9C69A10AA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216F21C21520
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C7918B48F;
	Wed, 16 Oct 2024 17:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JiOvf8Rl"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1F917B425
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729099921; cv=none; b=tEd41Rzy2WfbAy4tidWPT6xkF/7xNANnHOq+tUJ9Q/9o+gJjVfdwqMPT9W6VcskcOvuNRWjPAFaW4MmOCjxeex/7gtl70D7RfxBHMgTok4yROe532ju1r8e8RJ57sA3xP/vmfSMJO0tV1XBVOFwe9szHgPg1uR8VQWG4yvMusiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729099921; c=relaxed/simple;
	bh=vIuBufLHBjYGSmqjDwQOOrSfIT5PRhkXrvYOoWS2cp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bksCk9xOik3KXt8P0B4C24GNe0hMVd6hR4yYpMoiNNNMg2PkGpoOO5LAyrtcw6Ng1gYpYON1nia/5RmcVGDiUaY2VdWop5IvQGmM3eabdJyX2b5MwAaIzNVLEc3mZU49OBblj7awKU6a8iVqT3wfofyrARv+Yzgo0mJEy+NDw88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JiOvf8Rl; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 16 Oct 2024 17:31:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729099916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=km8BLia+/1QmGj2vLcf5Wy4/X9EH2zW/5AUiwrRAFjM=;
	b=JiOvf8Rlw38c/tVZlBExWa+ZinE6bDR4PoUtxelv2iWPsWxEn0IUivgSK8fTVzdF1hj5Lw
	N5jSFD8txpbTU6k1pfiB3H7scAWIOB/DpJzqB1hNgrnrwqzb1iM17l5YBE+C66YzjL5t2y
	9yusky4vH74HCE4CcY4SDJ7dG4gBFBU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Muchun Song <muchun.song@linux.dev>, chenridong <chenridong@huawei.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	"Kirill A. Shutemov" <kirill@shutemov.name>,
	akpm@linux-foundation.org, david@fromorbit.com,
	zhengqi.arch@bytedance.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, wangweiyang2@huawei.com
Subject: Re: [PATCH v2] mm: shrinker: avoid memleak in alloc_shrinker_info
Message-ID: <Zw_4fOm_4ifT1uft@google.com>
References: <fff87be9-fdc8-4c27-8335-17b0c7e16413@suse.cz>
 <1BD74B20-879A-4159-B957-1223553217C1@linux.dev>
 <0b883f9e-451f-41c2-805f-7f5bc7eebee2@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b883f9e-451f-41c2-805f-7f5bc7eebee2@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 16, 2024 at 07:02:23PM +0200, Vlastimil Babka wrote:
> On 10/16/24 16:08, Muchun Song wrote:
> > 
> > 
> >> On Oct 16, 2024, at 19:43, Vlastimil Babka <vbabka@suse.cz> wrote:
> >> ﻿On 10/16/24 04:21, Muchun Song wrote:
> >>> 
> >>> 
> >>>> On Oct 16, 2024, at 09:25, chenridong <chenridong@huawei.com> wrote:
> >>>> On 2024/10/15 14:55, Anshuman Khandual wrote:
> >>>>> On 10/14/24 16:59, Kirill A. Shutemov wrote:
> >>>>>> On Mon, Oct 14, 2024 at 03:23:36AM +0000, Chen Ridong wrote:
> >>>>>>> From: Chen Ridong <chenridong@huawei.com>
> >>>>>>> A memleak was found as bellow:
> >>>>>>> unreferenced object 0xffff8881010d2a80 (size 32):
> >>>>>>>  comm "mkdir", pid 1559, jiffies 4294932666
> >>>>>>>  hex dump (first 32 bytes):
> >>>>>>>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >>>>>>>    40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  @...............
> >>>>>>>  backtrace (crc 2e7ef6fa):
> >>>>>>>    [<ffffffff81372754>] __kmalloc_node_noprof+0x394/0x470
> >>>>>>>    [<ffffffff813024ab>] alloc_shrinker_info+0x7b/0x1a0
> >>>>>>>    [<ffffffff813b526a>] mem_cgroup_css_online+0x11a/0x3b0
> >>>>>>>    [<ffffffff81198dd9>] online_css+0x29/0xa0
> >>>>>>>    [<ffffffff811a243d>] cgroup_apply_control_enable+0x20d/0x360
> >>>>>>>    [<ffffffff811a5728>] cgroup_mkdir+0x168/0x5f0
> >>>>>>>    [<ffffffff8148543e>] kernfs_iop_mkdir+0x5e/0x90
> >>>>>>>    [<ffffffff813dbb24>] vfs_mkdir+0x144/0x220
> >>>>>>>    [<ffffffff813e1c97>] do_mkdirat+0x87/0x130
> >>>>>>>    [<ffffffff813e1de9>] __x64_sys_mkdir+0x49/0x70
> >>>>>>>    [<ffffffff81f8c928>] do_syscall_64+0x68/0x140
> >>>>>>>    [<ffffffff8200012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>>>>>> In the alloc_shrinker_info function, when shrinker_unit_alloc return
> >>>>>>> err, the info won't be freed. Just fix it.
> >>>>>>> Fixes: 307bececcd12 ("mm: shrinker: add a secondary array for shrinker_info::{map, nr_deferred}")
> >>>>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> >>>>>>> ---
> >>>>>>> mm/shrinker.c | 1 +
> >>>>>>> 1 file changed, 1 insertion(+)
> >>>>>>> diff --git a/mm/shrinker.c b/mm/shrinker.c
> >>>>>>> index dc5d2a6fcfc4..92270413190d 100644
> >>>>>>> --- a/mm/shrinker.c
> >>>>>>> +++ b/mm/shrinker.c
> >>>>>>> @@ -97,6 +97,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
> >>>>>>>   err:
> >>>>>>>  mutex_unlock(&shrinker_mutex);
> >>>>>>> + kvfree(info);
> >>>>>>>  free_shrinker_info(memcg);
> >>>>>>>  return -ENOMEM;
> >>>>>>> }
> >>>>>> NAK. If in the future there going to one more error case after
> >>>>>> rcu_assign_pointer() we will end up with double free.
> >>>>>> This should be safer:
> >>>>>> diff --git a/mm/shrinker.c b/mm/shrinker.c
> >>>>>> index dc5d2a6fcfc4..763fd556bc7d 100644
> >>>>>> --- a/mm/shrinker.c
> >>>>>> +++ b/mm/shrinker.c
> >>>>>> @@ -87,8 +87,10 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
> >>>>>>  if (!info)
> >>>>>>  goto err;
> >>>>>>  info->map_nr_max = shrinker_nr_max;
> >>>>>> - if (shrinker_unit_alloc(info, NULL, nid))
> >>>>>> + if (shrinker_unit_alloc(info, NULL, nid)) {
> >>>>>> + kvfree(info);
> >>>>>>  goto err;
> >>>>>> + }
> >>>>>>  rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
> >>>>>>  }
> >>>>>>  mutex_unlock(&shrinker_mutex);
> >>>>> Agreed, this is what I mentioned earlier as well.
> >>>>> ------------------------------------------------------------------
> >>>>> I guess kvfree() should be called just after shrinker_unit_alloc()
> >>>>> fails but before calling into "goto err"
> >>>>> ------------------------------------------------------------------
> >>>> After discussion, it seems that v1 is acceptable.
> >>>> Hi, Muchun, do you have any other opinions?
> >>> 
> >>> I insist on my opinion, not mixing two different approaches
> >>> to do release resources.
> >> 
> >> So instead we mix the cleanup of the whole function with the cleanup of what
> >> is effectively a per-iteration temporary variable?
> >> 
> >> The fact there was already a confusion in this thread about whether it's
> >> safe and relies on kvfree(NULL) to be a no-op, should be a hint.
> > 
> > Yes. I think someone is confused about my opinion.
> > I don’t care about whether we should apply this hit.
> > If we think the hint is tricky, we could add another
> > label to fix it like I suggested previously. Because
> > we already use goto-based approaches to
> > cleanup the resources, why not keeping
> > consistent?
> 
> I think we're rather pragmatic than striving to be consistent for the sake
> of consistency. goto is not the nicest thing in the world, but we (unlike
> other projects) use it where it makes sense to avoid if/else nesting
> explosion. Here for the info it's not the most pragmatic option.
> 
> > It will be easier for us to add a new
> > "if" statement and handle the failure case in the future.
> 
> Let's not overengineer things for hypothetical future.
> 
> > For example, if we use his v1 proposal, we should do
> > the cleanups again for info. But for goto-based
> > version, we just add another label to do the
> > cleanups and go to the new label for failure case. goto-based fix is what I insisted on. I copied my previous suggested fix here to clarify my opinion.
> 
> Again, info is a loop-iteration-local variable, v1 fix making it truly local
> is the way to go. If there are further cleanups added in the loop itself in
> the future, they could hopefully keep being local to the loop as well.
> Cleanup of info outside the loop iteration is breaking its real scope.

+1 to that.

I don't think it's such a big deal and both versions are ok, but I strongly
prefer the original version (without introduction of a new label).

Please, feel free to use
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
with the original version.

Thanks!

