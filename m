Return-Path: <linux-kernel+bounces-561557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F88CA61372
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5029169909
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CB5200BBB;
	Fri, 14 Mar 2025 14:15:51 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217F1200B98
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741961751; cv=none; b=DMOhVEQGHHFuLCflx64aFz98z3tczDkWxgB6NbUu+WzoLeLjgOdA7o80IDec2rFkbieVW+bfIIkBMJVWMRLn0hVD1K6D6QHE82nwTPq7+EBCGSru0sqI3XX9PBKsJLkiNHd2wTkTLPpzNbaKl3hzREuVVBxSYenX0QvoXdLIxJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741961751; c=relaxed/simple;
	bh=oJlanc5LhG+i3de+lB1x2lNtf0Zxg543ShTg2sKdoUk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DqifZ/dZtuMN0wrxP/lygeQB1xFu4tg1Rm1LQ8eerJMkG3d2ihYy6SObxrPvsrVRD7lKXE94e6wKjfutNqmmbC/WYgTmTBkzjsyUyFXjvFLFvYGJ+whjrj0LWy3x3eIJnrq0KfBX4O9UAstzeudWucKYNQyWYkGb2NpYfsaxbkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDmXf0Zm4z6K8wt;
	Fri, 14 Mar 2025 22:12:34 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 60DA41403D2;
	Fri, 14 Mar 2025 22:15:45 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Mar
 2025 15:15:44 +0100
Date: Fri, 14 Mar 2025 14:15:41 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
CC: Joshua Hahn <joshua.hahnjy@gmail.com>,
	<lsf-pc@lists.linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <gourry@gourry.net>, <hyeonggon.yoo@sk.com>,
	<honggyu.kim@sk.com>, <kernel-team@meta.com>
Subject: Re: [LSF/MM/BPF TOPIC] Weighted interleave auto-tuning
Message-ID: <20250314141541.00003fad@huawei.com>
In-Reply-To: <87frjfx6u4.fsf@DESKTOP-5N7EMDA>
References: <20250313155705.1943522-1-joshua.hahnjy@gmail.com>
	<87frjfx6u4.fsf@DESKTOP-5N7EMDA>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 14 Mar 2025 18:08:35 +0800
"Huang, Ying" <ying.huang@linux.alibaba.com> wrote:

> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
> 
> > On Thu,  9 Jan 2025 13:50:48 -0500 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> >  
> >> Hello everyone, I hope everyone has had a great start to 2025!
> >> 
> >> Recently, I have been working on a patch series [1] with
> >> Gregory Price <gourry@gourry.net> that provides new default interleave
> >> weights, along with dynamic re-weighting on hotplug events and a series
> >> of UAPIs that allow users to configure how they want the defaults to behave.
> >> 
> >> In introducing these new defaults, discussions have opened up in the
> >> community regarding how best to create a UAPI that can provide
> >> coherent and transparent interactions for the user. In particular, consider
> >> this scenario: when a hotplug event happens and a node comes online
> >> with new bandwidth information (and therefore changing the bandwidth
> >> distributions across the system), should user-set weights be overwritten
> >> to reflect the new distributions? If so, how can we justify overwriting
> >> user-set values in a sysfs interface? If not, how will users manually
> >> adjust the node weights to the optimal weight?
> >> 
> >> I would like to revisit some of the design choices made for this patch,
> >> including how the defaults were derived, and open the conversation to
> >> hear what the community believes is a reasonable way to allow users to
> >> tune weighted interleave weights. More broadly, I hope to get gather
> >> community insight on how they use weighted interleave, and do my best to
> >> reflect those workflows in the patch.  
> >
> > Weighted interleave has since moved onto v7 [1], and a v8 is currently being
> > drafted. Through feedback from reviewers, we have landed on a coherent UAPI
> > that gives users two options: auto mode, which leaves all weight calculation
> > decisions to the system, and manual mode, which leaves weighted interleave
> > the same as it is without the patch.
> >
> > Given that the patch's functionality is mostly concrete and that the questions
> > I hoped to raise during this slot were answered via patch feedback, I hope to
> > ask another question during the talk:
> >
> > Should the system dynamically change what metrics it uses to weight the nodes,
> > based on what bottlenecks the system is currently facing?
> >
> > In the patch, min(read_bandwidth, write_bandwidth) is used as the heuristic
> > to determine what a node's weight should be. However, what if the system is
> > not bottlenecked by bandwidth, but by latency? A system could also be
> > bottlenecked by read bandwidth, but not by write bandwidth.
> >
> > Consider a scenario where a system has many memory nodes with varying
> > latencies and bandwidths. When the system is not bottlenecked by bandwidth,
> > it might prefer to allocate memory from nodes with lower latency. Once the
> > system starts feeling pressured by bandwidth, the weights for high bandwidth
> > (but also high latency) nodes would slowly increase to alleviate pressure
> > from the system. Once the system is back in a manageable state, weights for
> > low latency nodes would start increasing again. Users would not have to be
> > aware of any of this -- they would just see the system take control of the
> > weight changes as the system's needs continue to change.  
> 
> IIUC, this assumes the capacity of all kinds of memory is large enough.
> However, this may be not true in some cases.  So, another possibility is
> that, for a system with DRAM and CXL memory nodes.
> 
> - There is free space on DRAM node, the bandwidth of DRAM node isn't
>   saturated, memory is allocated on DRAM node.
> 
> - There is no free space on DRAM node, the bandwidth of DRAM node isn't
>   saturated, cold pages are migrated to CXL memory nodes, while hot
>   pages are migrated to DRAM memory nodes.
> 
> - The bandwidth of DRAM node is saturated, hot pages are migrated to CXL
>   memory nodes.
> 
> In general, I think that the real situation is complex and this makes it
> hard to implement a good policy in kernel.  So, I suspect that it's
> better to start with the experiments in user space.
> 
> > This proposal also has some concerns that need to be addressed:
> > - How reactive should the system be, and how aggressively should it tune the
> >   weights? We don't want the system to overreact to short spikes in pressure.
> > - Does dynamic weight adjusting lead to pages being "misplaced"? Should those
> >   "misplaced" pages be migrated? (probably not)
> > - Does this need to be in the kernel? A userspace daemon that monitors kernel
> >   metrics has the ability to make the changes (via the nodeN interfaces).

If this was done in kernel, what metrics would make sense to drive this?
Similar to hot page tracking we may run into contention with PMUs or similar and
their other use cases. 

> >
> > Thoughts & comments are appreciated! Thank you, and have a great day!
> > Joshua
> >
> > [1] https://lore.kernel.org/all/20250305200506.2529583-1-joshua.hahnjy@gmail.com/
> >
> > Sent using hkml (https://github.com/sjp38/hackermail)  
> 
> ---
> Best Regards,
> Huang, Ying
> 


