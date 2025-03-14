Return-Path: <linux-kernel+bounces-561651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E573A6148C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02797460879
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE8F201032;
	Fri, 14 Mar 2025 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfjPVKzJ"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E9528DB3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965103; cv=none; b=F7SQ/EfyDnzTwBDv4HIbH0H2gu91MIkDfWkd2m9n/TZzCmh0K5V2dpqiOB0Qf4E7sIXgSeDP1egGwUwlC4eHlmZZEUuKdiJYQZtsgo8Dd6SHp9+6u8c05jpWJHUAzdU3EKXDgWlDQP7bNPcfdf1uBTqSWjFQCx6wBuMOPXarmTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965103; c=relaxed/simple;
	bh=nszDmn0l/5FZTLm6ot8QzDpHnUvSSjMpUdPnNuNUhiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPMG2fMakkqiBXT88bIw6HSMKfSrPqg/2CIIeMnNwLZpB36IOG5O03wwBdWSRJR16IeJe5A6amnJN1scHStv/RexMpc0MCRndFddnJbu2+LjXprE2qLopm2OX4vTjabwOZyeKRgDCheE05bWxNRG3FL2cl4BsOZ5T2i2jEVSsIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfjPVKzJ; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e60aef2711fso1675659276.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741965101; x=1742569901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVFdW0JzvmKVfiJgTP3XByL6LpPYI/HB61BI1n8otAI=;
        b=DfjPVKzJ4WbBJTtTVlJp8fITkcYIjHQVGfTj1zOnBGchwxH5kAUjx1YfdU7tfg1ady
         nxwHoxsQjOndMxvChZOylNUSdBMZRwN7/Z1iJA8VswS3apA2AaHSr8ohIe8bJCsb8z1/
         bsucgrsKBd87UTcPC+ShK9i37+HeqYCtdth7sqY6dhbPRhVQ4dccXvTzg7/8CNCYmKHb
         hfJkxgUGK5c9nmIly4r45s1vZfmEkrHMrZDs4LstYjdz6cmJCqypYOB6Pp0so7uc1WWg
         waafuH+gFGq+rHzecexBmObf/+7Taga7HftukRQ++8S63bEfSXHQYvkKvhbbffrCg/gM
         YK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741965101; x=1742569901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVFdW0JzvmKVfiJgTP3XByL6LpPYI/HB61BI1n8otAI=;
        b=f6gxGrbwwwlDKJ9txAiJXr1E65GKbp0EpO0HFOe/5OeQzsugUvDmfH5+NpIuJ56V04
         JerTMeNWfOc5HxP2zU3YBhMsosOTmCp4Q6E/wKsx+SbtSKtMVPxGHYNrj5In33Ucvsdc
         jhW6Adznq6mcnwlgqZtFMEdqQo8F/PZEdgDxfxFpmKjUEDPLzyeZcHeH+WCA3OuUCzBJ
         BkLHT6er20zIPPYgogVHKozGce5lwnINTM72p9Q4LEBN7bp2GALB0y7qoQu1FXuRSw9g
         rZpDv9z0lB7cPilCeWbPxeL25jlVXbGOW9QIeuSziOvcaAPhWf00eVRlu6IATSdJFuID
         9eKA==
X-Forwarded-Encrypted: i=1; AJvYcCXwcYm5d50JeYXvUR3oZvlSfm/WT+/T2XCIjs2UQ5GaOUzXc3P1/J33pZDume0IQl49NbF9hp3zQSzlaUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4fS92O6tZxzkhPFYvftb2vY8zMlrPbtcvPMa2uar57O2n3Muk
	up7M7O8iGUTj7T6Pp4/nuvpuLbd8zasX7tFconB+CeGQiO9ilsU6
X-Gm-Gg: ASbGncsHdz/X7gKOQfibzvNZGZwIUwIBW2XK+3GZWNzb8aHGbxw7Kha1KEi1rTptXlM
	MFAWdshUsG8Qc6o/LRnBbX9irWRZEOGH6tZB2FNzKbYu0fccHiTvAyhA75+BV2nRNcYQ44foIB9
	STFi6wbs/3g2p8jaV1NW9x27KrvdhGqcHda9quA5W/RjAnv9Qca1kMRLqC3sjCliF71SAQFVfyH
	BnasIaBLbPDOvfmtR/IwEy7po9zKVuURKqpPdW2uVf4wVTwcEJdmS3mecNw5WYOHDyK6al2bs70
	d53j+Cp46zRbVcTKaAD33He8z2lvAFZYoMxbWQX+Au4=
X-Google-Smtp-Source: AGHT+IFirqbnNxGBvRNLFT2ybNgJhdhoVirc5Y8Fuawrx63X0CEMuMxGSQYqtGq8V4vAow53ZLKMjA==
X-Received: by 2002:a05:6902:e03:b0:e5d:dd0a:7fdb with SMTP id 3f1490d57ef6-e63f6533cf8mr3008971276.28.1741965100614;
        Fri, 14 Mar 2025 08:11:40 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:1::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e742889csm874660276.40.2025.03.14.08.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 08:11:39 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>,
	lsf-pc@lists.linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gourry@gourry.net,
	hyeonggon.yoo@sk.com,
	honggyu.kim@sk.com,
	kernel-team@meta.com
Subject: Re: [LSF/MM/BPF TOPIC] Weighted interleave auto-tuning
Date: Fri, 14 Mar 2025 08:11:16 -0700
Message-ID: <20250314151137.892379-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250314141541.00003fad@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 14 Mar 2025 14:15:41 +0000 Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Fri, 14 Mar 2025 18:08:35 +0800
> "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:
> 
> > Joshua Hahn <joshua.hahnjy@gmail.com> writes:
> > 
> > > On Thu,  9 Jan 2025 13:50:48 -0500 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> > >  
> > >> Hello everyone, I hope everyone has had a great start to 2025!
> > >> 
> > >> Recently, I have been working on a patch series [1] with
> > >> Gregory Price <gourry@gourry.net> that provides new default interleave
> > >> weights, along with dynamic re-weighting on hotplug events and a series
> > >> of UAPIs that allow users to configure how they want the defaults to behave.
> > >> 
> > >> In introducing these new defaults, discussions have opened up in the
> > >> community regarding how best to create a UAPI that can provide
> > >> coherent and transparent interactions for the user. In particular, consider
> > >> this scenario: when a hotplug event happens and a node comes online
> > >> with new bandwidth information (and therefore changing the bandwidth
> > >> distributions across the system), should user-set weights be overwritten
> > >> to reflect the new distributions? If so, how can we justify overwriting
> > >> user-set values in a sysfs interface? If not, how will users manually
> > >> adjust the node weights to the optimal weight?
> > >> 
> > >> I would like to revisit some of the design choices made for this patch,
> > >> including how the defaults were derived, and open the conversation to
> > >> hear what the community believes is a reasonable way to allow users to
> > >> tune weighted interleave weights. More broadly, I hope to get gather
> > >> community insight on how they use weighted interleave, and do my best to
> > >> reflect those workflows in the patch.  
> > >
> > > Weighted interleave has since moved onto v7 [1], and a v8 is currently being
> > > drafted. Through feedback from reviewers, we have landed on a coherent UAPI
> > > that gives users two options: auto mode, which leaves all weight calculation
> > > decisions to the system, and manual mode, which leaves weighted interleave
> > > the same as it is without the patch.
> > >
> > > Given that the patch's functionality is mostly concrete and that the questions
> > > I hoped to raise during this slot were answered via patch feedback, I hope to
> > > ask another question during the talk:
> > >
> > > Should the system dynamically change what metrics it uses to weight the nodes,
> > > based on what bottlenecks the system is currently facing?
> > >
> > > In the patch, min(read_bandwidth, write_bandwidth) is used as the heuristic
> > > to determine what a node's weight should be. However, what if the system is
> > > not bottlenecked by bandwidth, but by latency? A system could also be
> > > bottlenecked by read bandwidth, but not by write bandwidth.
> > >
> > > Consider a scenario where a system has many memory nodes with varying
> > > latencies and bandwidths. When the system is not bottlenecked by bandwidth,
> > > it might prefer to allocate memory from nodes with lower latency. Once the
> > > system starts feeling pressured by bandwidth, the weights for high bandwidth
> > > (but also high latency) nodes would slowly increase to alleviate pressure
> > > from the system. Once the system is back in a manageable state, weights for
> > > low latency nodes would start increasing again. Users would not have to be
> > > aware of any of this -- they would just see the system take control of the
> > > weight changes as the system's needs continue to change.  
> > 
> > IIUC, this assumes the capacity of all kinds of memory is large enough.
> > However, this may be not true in some cases.  So, another possibility is
> > that, for a system with DRAM and CXL memory nodes.
> > 
> > - There is free space on DRAM node, the bandwidth of DRAM node isn't
> >   saturated, memory is allocated on DRAM node.
> > 
> > - There is no free space on DRAM node, the bandwidth of DRAM node isn't
> >   saturated, cold pages are migrated to CXL memory nodes, while hot
> >   pages are migrated to DRAM memory nodes.
> > 
> > - The bandwidth of DRAM node is saturated, hot pages are migrated to CXL
> >   memory nodes.
> > 
> > In general, I think that the real situation is complex and this makes it
> > hard to implement a good policy in kernel.  So, I suspect that it's
> > better to start with the experiments in user space.
> > 
> > > This proposal also has some concerns that need to be addressed:
> > > - How reactive should the system be, and how aggressively should it tune the
> > >   weights? We don't want the system to overreact to short spikes in pressure.
> > > - Does dynamic weight adjusting lead to pages being "misplaced"? Should those
> > >   "misplaced" pages be migrated? (probably not)
> > > - Does this need to be in the kernel? A userspace daemon that monitors kernel
> > >   metrics has the ability to make the changes (via the nodeN interfaces).
> 
> If this was done in kernel, what metrics would make sense to drive this?
> Similar to hot page tracking we may run into contention with PMUs or similar and
> their other use cases. 

Hello Jonathan, thank you for your interest in this proposal!

Yes, I think you and Ying both bring up great points about how this is
probably something more suitable for a userspace program. Usespace probably
has more information about the characteristics of the workload, and I agree
with your point about contention.

If the kernel thread doesn't probe frequently, then it would be making poor
allocation decisions based on stale data, but if it does probe frequently,
it would incur lots of overhead from the contention (and make other contending
threads slower as well). Not to mention, there is also the overhead of
probing itself : -)

I will keep thinking about these questions, and see if I can come up with
any interesting ideas to discuss during LSFMMBPF. Thank you again for your
interest, I hope you have a great day!
Joshua

> > >
> > > Thoughts & comments are appreciated! Thank you, and have a great day!
> > > Joshua
> > >
> > > [1] https://lore.kernel.org/all/20250305200506.2529583-1-joshua.hahnjy@gmail.com/
> > >
> > > Sent using hkml (https://github.com/sjp38/hackermail)  
> > 
> > ---
> > Best Regards,
> > Huang, Ying
> >

Sent using hkml (https://github.com/sjp38/hackermail)


