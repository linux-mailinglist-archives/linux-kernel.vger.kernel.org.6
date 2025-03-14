Return-Path: <linux-kernel+bounces-561640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F78BA61474
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5371B62437
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6200E2010E1;
	Fri, 14 Mar 2025 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITJnl+hB"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF67517579
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741964587; cv=none; b=muWKVtTvagRGZiHimgrmrIUG7iMQDe8L1MXxH2LADbnv0O9ydG2752SqB08jFQKsVfibjgEsMOlJ62cUc8qOn58a33zKIuABXpwm2ThoqEYOjq0bIVoUPOQsXCByoOl2ZeOmhBXLaShokOL4XfqQG6111+zUDGWZ1E121yqOOwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741964587; c=relaxed/simple;
	bh=tv+7DzCz+s30EAn9SGXc6g346I55cKS6FH/4F9AI8Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHFtOoKqh3xasYHlLyjydlTfl31QerpCP8+yEPQR7PgfrDgmTz8zYwhx91u4+4vXONqV/j93WO000705S/St/dA51AZ+EY7fMC/dR5ebWkF9Unej/SeOzBe/VJekVJKJ2RX0ev3sFZGqxSBnrC7Jid7Dz9hEMZqmAapSwV4clnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITJnl+hB; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6feaa0319d8so17893917b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741964585; x=1742569385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8Mh+zNRbdESRoS2HW+2cc1xUCiitiPCLc+BEAGgj/s=;
        b=ITJnl+hBlVCZ3OPATGh3XeAFg1h+y2rXny6iYAASdym2sSZ+oEjJdlWH3PgpKf9QG1
         mMHouIdkPN65zGRLW6F7+oYFoP0G3MXmFq1Y357lQuVfFGAbZ9PcTnBCQftrujXQWFeX
         gvNF9In1oyPqu1rxz7T1XK2aoIncoE6/F02MZP9YC8UmCseEwa012kqG8nllE8HXblXY
         kTaCOd0MNm/41eLhjHLctGh26EvrQEoBAd+82w6NQz5vumKfUAGbiNis986a62c81gkl
         V7SKmUeIRJG/Lrnj/PjkJX/YVvJ/8KXOUlLZD5b78X7mLOXNVpGkwarLA6TWjEkadreK
         8J9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741964585; x=1742569385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8Mh+zNRbdESRoS2HW+2cc1xUCiitiPCLc+BEAGgj/s=;
        b=kfTTD2L2Zkg98F8WFYkmPXZpFopK+AVUZDysLYfo01h8Ins2naDtw6i82q7jDGrRg5
         PnNbeaS/X4OXCSIhLa0mP2pV6n654CGrN1uTIqzolJaChN4R6FZi34+QA8ULs+9iNItw
         lKLSuuUKotUUHiWkykBEio8m4ZI/0LFCBJKAAXXttnTeZtdFyGbgp/fIIMOleXXvnKsr
         LDs80XS65sAu876vuE0uo3sGsIUyYb4atvc29H66vepZu5WyEYIE4qdSGmJBQUQyx18r
         IkOJT2NOlbyvC/4h4ueGNzzplPhPkZecRSygS607+ESKg04rNhOgwoK5FO2e5QxwSJ1O
         Nadw==
X-Forwarded-Encrypted: i=1; AJvYcCXSxSnpsI6n723/2Jtfecpap7z6uqNEZw1VopKZ1a9Y3rhDyjWh5F71ETCvDnCj7KpERMzVHErvzvNGTug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsfWQjkb8K8Kv8RBEc10O/y2+HoeYtE/oLYaONd4drw5tQfsrp
	f7IeG5mhWDsZhEcUe0PCBJUZs2kk7W8KFhqeAwjKQGJRp6Sc68MA34lsZw==
X-Gm-Gg: ASbGnctcseHQYCSJtECUUmi1lS9nirDEgHpe6oqWMC3Ln9VPFfY8j20dmjYGiX/pzyx
	4Mmc7b9d17NhHr3hUc5kJbFwCEah+e+nX3baZrRWn7tPJlRx8hWOx0W0LWnXxNYpPcod02Vkrh0
	oREWEqxCRcAVilxBWHx4SzFDn/03DDI/QWzgUojJZNbS+NLOjNGd2uI3+Z7hcLQD0iyAqeuBd6I
	/e6K5Qx3dwWVFB/m/ajMKwkvoxG/4Zs6eZRoJ/g0qKuIpdDbOwW2VQwvCs89tp7z8UXYVA4YDeY
	VzhXWrh40LltIBnLTy/WLgcZz+jVAyQH1ZG6q21ugjY=
X-Google-Smtp-Source: AGHT+IE+D9FHDvmZwJbouWTnYO6AS9XZR2u1G0EsBqmlS3REqDyB2KtiDOFymqzhzy+NK6BpdQ6cxg==
X-Received: by 2002:a05:690c:3513:b0:6fb:9c08:4980 with SMTP id 00721157ae682-6ff460cd3e7mr32953877b3.27.1741964584903;
        Fri, 14 Mar 2025 08:03:04 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:1::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff32840d76sm9253857b3.25.2025.03.14.08.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 08:03:04 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: lsf-pc@lists.linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gourry@gourry.net,
	hyeonggon.yoo@sk.com,
	honggyu.kim@sk.com,
	kernel-team@meta.com
Subject: Re: [LSF/MM/BPF TOPIC] Weighted interleave auto-tuning
Date: Fri, 14 Mar 2025 08:02:46 -0700
Message-ID: <20250314150248.774524-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <87frjfx6u4.fsf@DESKTOP-5N7EMDA>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 14 Mar 2025 18:08:35 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:

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

Hi Ying, thank you so much for your feedback, as always!

Yes, I agree. I brought up this idea out of curiosity, since I thought that
there might be room to experiment with different configurations for weighted
interleave auto-tuning. As you know, we use min(read_bw, write_bw), which I
think is a good heuristic that works for the intent of the weighted interleave
auto-tuning patch-- I wanted to know what a system might look like, that might
use different heuristics given the system's state. But I think you are right
that it is difficult to implement in kernel.

Thanks again, Ying! Will you be attending LSFMMBPF this year? I would love to
say hello in person : -)

Have a great day!
Joshua
 
> > This proposal also has some concerns that need to be addressed:
> > - How reactive should the system be, and how aggressively should it tune the
> >   weights? We don't want the system to overreact to short spikes in pressure.
> > - Does dynamic weight adjusting lead to pages being "misplaced"? Should those
> >   "misplaced" pages be migrated? (probably not)
> > - Does this need to be in the kernel? A userspace daemon that monitors kernel
> >   metrics has the ability to make the changes (via the nodeN interfaces).
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

Sent using hkml (https://github.com/sjp38/hackermail)


