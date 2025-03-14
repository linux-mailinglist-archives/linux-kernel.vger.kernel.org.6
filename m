Return-Path: <linux-kernel+bounces-561168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A81BCA60E40
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6B316F707
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1911F30C3;
	Fri, 14 Mar 2025 10:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rFynGN1y"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A3126AFC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946952; cv=none; b=UohXchYD+rK62KQ536RSD0A+d3KwxbTWz/e7jWWci1Y1BDsG7E9P1noXMUH1eEqaYxb4/+CtzsFe+IxvFVGgNO9uo2H+vWHQ5/3CBPKxOcE/9dHEbW3NqEEkCPn3h1Neka/I64iHT0e+d/ZgGJFPNkwwdqP2D0RnDir+Qje+gY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946952; c=relaxed/simple;
	bh=MdhCjsSoBBo+hlrfuVURtMqfPH5ZX1hqPqPqrEjcg7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o75bdE9A4f35RrPC9FIcHR1c1wDACur4oE3PmGJea7M3CufhIpr8SfD+/gbK2dTI9aHBQuKbMbzhD2Lhl40S9XwWplULrbAOWyXthwz/GzrQCncCGQwD1wT3cqyawECQ1zG0rPMkRQkhVhx3k8CcOhIPu90Fzo7bq6vKmxRybjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rFynGN1y; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741946939; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=GXpuf2zCQBIft9x2gUmG/KFcbS1j8hexE39eKg82HKw=;
	b=rFynGN1ygrp1WqcAh/MbYjT29N9xT4rY3hOS4C8iNVOZuVwJz0i6ZlkqtyMZXFFIjBWxCiXUZ6jaAzAbQisBJ6MwZsdUG2WxPUba/uvXodJrW0qS66OnXpsahwgkyNFz8QaDuTLblujfXZxRIUTDWNNSyXVUP4modDEpHKKDY6o=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WRKiii9_1741946917 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 14 Mar 2025 18:08:58 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  gourry@gourry.net,  hyeonggon.yoo@sk.com,
  honggyu.kim@sk.com,  kernel-team@meta.com
Subject: Re: [LSF/MM/BPF TOPIC] Weighted interleave auto-tuning
In-Reply-To: <20250313155705.1943522-1-joshua.hahnjy@gmail.com> (Joshua Hahn's
	message of "Thu, 13 Mar 2025 08:57:04 -0700")
References: <20250313155705.1943522-1-joshua.hahnjy@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Fri, 14 Mar 2025 18:08:35 +0800
Message-ID: <87frjfx6u4.fsf@DESKTOP-5N7EMDA>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Joshua Hahn <joshua.hahnjy@gmail.com> writes:

> On Thu,  9 Jan 2025 13:50:48 -0500 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
>
>> Hello everyone, I hope everyone has had a great start to 2025!
>> 
>> Recently, I have been working on a patch series [1] with
>> Gregory Price <gourry@gourry.net> that provides new default interleave
>> weights, along with dynamic re-weighting on hotplug events and a series
>> of UAPIs that allow users to configure how they want the defaults to behave.
>> 
>> In introducing these new defaults, discussions have opened up in the
>> community regarding how best to create a UAPI that can provide
>> coherent and transparent interactions for the user. In particular, consider
>> this scenario: when a hotplug event happens and a node comes online
>> with new bandwidth information (and therefore changing the bandwidth
>> distributions across the system), should user-set weights be overwritten
>> to reflect the new distributions? If so, how can we justify overwriting
>> user-set values in a sysfs interface? If not, how will users manually
>> adjust the node weights to the optimal weight?
>> 
>> I would like to revisit some of the design choices made for this patch,
>> including how the defaults were derived, and open the conversation to
>> hear what the community believes is a reasonable way to allow users to
>> tune weighted interleave weights. More broadly, I hope to get gather
>> community insight on how they use weighted interleave, and do my best to
>> reflect those workflows in the patch.
>
> Weighted interleave has since moved onto v7 [1], and a v8 is currently being
> drafted. Through feedback from reviewers, we have landed on a coherent UAPI
> that gives users two options: auto mode, which leaves all weight calculation
> decisions to the system, and manual mode, which leaves weighted interleave
> the same as it is without the patch.
>
> Given that the patch's functionality is mostly concrete and that the questions
> I hoped to raise during this slot were answered via patch feedback, I hope to
> ask another question during the talk:
>
> Should the system dynamically change what metrics it uses to weight the nodes,
> based on what bottlenecks the system is currently facing?
>
> In the patch, min(read_bandwidth, write_bandwidth) is used as the heuristic
> to determine what a node's weight should be. However, what if the system is
> not bottlenecked by bandwidth, but by latency? A system could also be
> bottlenecked by read bandwidth, but not by write bandwidth.
>
> Consider a scenario where a system has many memory nodes with varying
> latencies and bandwidths. When the system is not bottlenecked by bandwidth,
> it might prefer to allocate memory from nodes with lower latency. Once the
> system starts feeling pressured by bandwidth, the weights for high bandwidth
> (but also high latency) nodes would slowly increase to alleviate pressure
> from the system. Once the system is back in a manageable state, weights for
> low latency nodes would start increasing again. Users would not have to be
> aware of any of this -- they would just see the system take control of the
> weight changes as the system's needs continue to change.

IIUC, this assumes the capacity of all kinds of memory is large enough.
However, this may be not true in some cases.  So, another possibility is
that, for a system with DRAM and CXL memory nodes.

- There is free space on DRAM node, the bandwidth of DRAM node isn't
  saturated, memory is allocated on DRAM node.

- There is no free space on DRAM node, the bandwidth of DRAM node isn't
  saturated, cold pages are migrated to CXL memory nodes, while hot
  pages are migrated to DRAM memory nodes.

- The bandwidth of DRAM node is saturated, hot pages are migrated to CXL
  memory nodes.

In general, I think that the real situation is complex and this makes it
hard to implement a good policy in kernel.  So, I suspect that it's
better to start with the experiments in user space.

> This proposal also has some concerns that need to be addressed:
> - How reactive should the system be, and how aggressively should it tune the
>   weights? We don't want the system to overreact to short spikes in pressure.
> - Does dynamic weight adjusting lead to pages being "misplaced"? Should those
>   "misplaced" pages be migrated? (probably not)
> - Does this need to be in the kernel? A userspace daemon that monitors kernel
>   metrics has the ability to make the changes (via the nodeN interfaces).
>
> Thoughts & comments are appreciated! Thank you, and have a great day!
> Joshua
>
> [1] https://lore.kernel.org/all/20250305200506.2529583-1-joshua.hahnjy@gmail.com/
>
> Sent using hkml (https://github.com/sjp38/hackermail)

---
Best Regards,
Huang, Ying

