Return-Path: <linux-kernel+bounces-421584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F1B9D8D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 21:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18415B23F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EA61C07FA;
	Mon, 25 Nov 2024 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="WfxkfVhJ"
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E421BBBD4
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 20:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732564960; cv=none; b=SZ5S17PXeHjvkMo0JPmZ58Fyg4grvq7zyVW1dzhR3f1pKi7uQ6QdTDmCMnie4SJGxfhf65Qmg333hVJZcClO+OiY5OTlh/0Bxr3lOOARfcAywYyXSWTREelEBh3x6K+PLf14oRuwMlR/vaxo6hCCwkk120N/5jCw1IBifytpo+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732564960; c=relaxed/simple;
	bh=64RW15P/f4U3niThLQ7ZTuLweL9cI7oNP+DvQVNJ9Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=MOYoTNKBs3R7+pmVC3qAr8RmyvAOobOCXHul1yT1q/u8ieTLpXebbO5HDU3FDOd8veGJANAU9ZS1c5Wp9qgnv73I5LY09uJsclV+zfUuyP3FtEKCGuzhxMdnyigd5flaGAYXycAvdGeMiMvHGJI8R3gBmPVLVMoJkvJTvc07LzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=WfxkfVhJ; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1732564950; bh=7cKmBtGYZs9NVjBUD0MdkFIIrOhtFk6MBLGLSc+nzk0=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=WfxkfVhJf89F6yhcXFS8YaHKPlGwcf1sLvUPqrXZmt1wZlvXGzvBKya5qLVPYMX4w
	 mg+yJlsoPktdbXLK2Q9L0e7Z9KmSGMhTYIlEyVHeXe3fk8gobttpstccroxVAQxSVw
	 odZYfydBwuEh55YdEN2GsclhI5dddZ01yH8zAIKM=
Received: from [IPV6:2409:875e:a030:1001:14::e66] ([2409:875e:a030:1001:14::e66])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id B439408D; Tue, 26 Nov 2024 03:45:03 +0800
X-QQ-mid: xmsmtpt1732563903t4lyv5end
Message-ID: <tencent_52B8009E65148BE7B93C42479E6E642C0409@qq.com>
X-QQ-XMAILINFO: M465k96S+ahuh98II/Gmqk/gedihYW0scNWWKMuz0Rqj19yYFnqiNiYbrgZrSP
	 1yOM8ncmKhJJrtLWRW9r7EsRTEqhO0MchcT0jBNFUcD2XAJp2M4s/t7gLYs3dncX4qY1lwyWvYbp
	 vifc3k5Vek7H3f0gCbIp7Ulti9CRzTOPdM3vc+ZTbvA0cIcZ9gPSgrcVFrhM7t2Q5X6y4IRZxM4o
	 Gg+rJBsEH/pY+9HHnq/OdgA7wnq1dXDoQUGEjrjG5ixqnTCcsm9xXOviKvXnbj64GpYnJgLvBRBE
	 BYrRA/o6SuyQmb5KsT5yLiTx8YaZp2nYTufNO/TVMufOtgDYv7syOHQQYaXIp998eEvKhW/smOhG
	 3xItFG5QarKLMfuqZcKNM7+P36yUGKm3gqxW08L7p1FceoFW4cQL5PE7Bw2DtptrJy9RDc01M+Aw
	 sBurOFmRs9SGbwBJJ/8/fs/Ze4f+slGnIJ0Oc88O7mKAoy4nsgZGJxcx7jeFpbAbr8EwET8oCUsq
	 zZ5Xs5zn84Xt01w19Q395Xhi8pF2j/3ssrmTaG21951t8NEYh9pfugq52f09I6piegNWsI+U+iBC
	 D9pdtYW1EAoFje2Ok2vqLK1+hd1aU1fOmtEJZRumSp85YGnMNnDAXM1WyF2pnJzKh/RnVS+1Quwh
	 OgfFY67uyQgjFRjsF0txvmMrLHIhwXW7cUgpTMXk1ZPI5EIvWv9uHZttayD5myLIzR3n2hh0PBH2
	 prMoCAWdAyPebFnDYFG9ottfGaIudZ2DihWnavvWt7BklmbYFO5ap8NJB6o9SIaj9G+dTwJizhpT
	 uO562UUPY5kyhdH2NGBuEj7cxm6pppgjvyMksb1w7YJw+wNdwOWbAOIZYCDSOOBUnViVYcmoflHp
	 b/4C5yCQgrEBWsggZtnMc1Sw0Jwm4SZiXVYPA1tuGIGlmyB78C/70AVLEd7XbmQh1wg2G28BBjWs
	 Sc8QMJ4es9+5VglqHiaoHGQtjeGCkDmmhSMguBr7A=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-OQ-MSGID: <43f489d2-1019-4d5c-a0d9-600729388731@qq.com>
Date: Tue, 26 Nov 2024 03:45:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/mempolicy: Fix decision-making issues for memory
 migration during NUMA balancing
To: Michal Hocko <mhocko@suse.com>
References: <tencent_57D6CF437AF88E48DD5C5BD872753C43280A@qq.com>
 <Z0RgoOHMRFCTM1JB@tiehlicka>
From: Junjie Fu <fujunjie1@qq.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 akpm@linux-foundation.org, dave.hansen@intel.com, gourry@gourry.net
In-Reply-To: <Z0RgoOHMRFCTM1JB@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On November 25, 2024 at 19:33, Michal Hocko wrote:
> On Sun 24-11-24 03:09:35, Junjie Fu wrote:
>> When handling a page fault caused by NUMA balancing (do_numa_page), it is
>> necessary to decide whether to migrate the current page to another node or
>> keep it on its current node. For pages with the MPOL_PREFERRED memory
>> policy, it is sufficient to check whether the first node set in the
>> nodemask is the same as the node where the page is currently located. If
>> this is the case, the page should remain in its current state. Otherwise,
>> migration to another node should be attempted.
>>
>> Because the definition of MPOL_PREFERRED is as follows: "This mode sets the
>> preferred node for allocation. The kernel will try to allocate pages from
>> this node first and fall back to nearby nodes if the preferred node is low
>> on free memory. If the nodemask specifies more than one node ID, the first
>> node in the mask will be selected as the preferred node."
>>
>> Thus, if the node where the current page resides is not the first node in
>> the nodemask, it is not the PREFERRED node, and memory migration can be
>> attempted.
>>
>> However, in the original code, the check only verifies whether the current
>> node exists in the nodemask (which may or may not be the first node in the
>> mask). This could lead to a scenario where, if the current node is not the
>> first node in the nodemask, the code incorrectly decides not to attempt
>> migration to other nodes.
>>
>> This behavior is clearly incorrect. If the target node for migration and
>> the page's current NUMA node are both within the nodemask but neither is
>> the first node, they should be treated with the same priority, and
>> migration attempts should proceed.
> 
> The code is clearly confusing but is there any actual problem to be
> solved? IIRC although we do keep nodemask for MPOL_PREFERRED
> policy we do not allow to set more than a single node to be set there.
> Have a look at mpol_new_preferred
> 

I apologize for the oversight when reviewing the code regarding the 
process of setting only the first node in the nodemask for the 
MPOL_PREFERRED memory policy. After reviewing the mpol_new_preferred 
function, I realized that when setting the memory policy, only the first 
node from the user's nodemask is copied into the corresponding memory 
policy instance's nodemask, as shown in the following code:

static int mpol_new_preferred(struct mempolicy *pol, const nodemask_t 
*nodes)
{
     if (nodes_empty(*nodes))
         return -EINVAL;

     nodes_clear(pol->nodes);
     node_set(first_node(*nodes), pol->nodes); //only the first node to 
be set
     return 0;
}

Due to my previous oversight, I mistakenly assumed that multiple nodes 
could be set in pol->nodes, leading to my incorrect understanding. 
Therefore, the original code is correct. Thank you all for your responses.


