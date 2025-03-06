Return-Path: <linux-kernel+bounces-549488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5937BA55328
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83FEA188CC2A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DC025BACB;
	Thu,  6 Mar 2025 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ERTZkf+6"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE820255252
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741282368; cv=none; b=DJDwj7OBY5+f2/Vx8w72M1DVxKJnOH15P6tLQaxcLpSPH56a01QUE+1lE2FkT4G/nXMvXtlTCDBHN/6qjA2MRKSHj+W0m9QYScYrRAvYq67a6dcK6sgOaRViDhehHkO8khBa2rkYMgpL79ASUp67fmicEKbrT/fpNOivPf+4nYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741282368; c=relaxed/simple;
	bh=irrH0Nkt3I+c252civKxAxCD3obGOmF/TVZC9QZZlbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5uIouA667uoKAgLMDVkTt8JbE9gQsD41F9q0B/rwo3LaJhXSJV+aYgIfqzXgsvcdCOTnZdAY+Krpel2Lqt845nM+U8peUYv3S61+iFrxH3j51aD+OM6cBQWfbDw0bign6pIydbQfaVONhyHUSd0vH1s23wXUHIcsYDl8xzg4e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ERTZkf+6; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7be8f28172dso61899385a.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 09:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741282366; x=1741887166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l7+tMCJ7OtJK9Gd69u8t1lDx/CAaXYSFNmDt21Z+gis=;
        b=ERTZkf+66q/XA/GxjOvX8a6tqZC1jx3c1V+clHzksrBc61iOFluWmZ2i2knIZ/Yw4q
         oe1sMudhFQrTEgvrWkhEKPx9VJXLbZtucFWgFrWJJTl4tRy7F7YcbASI5lhuhwc7vAZJ
         hj/eTSJDGqocWphTScFUN+X9B5Ynhg3uZLqhEguLt5OEI7vGE5I2Q2csZ783NtDLlbBw
         PlDdWBnUskvk0j64vBnWu91CzkAAuA+qcyNu9d8H9zwVsZgspgpd5ijMZrTTVSIha1cW
         Rja1pFnbEsLvD0KndyOIvo4tfNcY6iCDBSjwQeHramt35cgnY85C1/Lo/wIR5cc3NPJw
         M5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741282366; x=1741887166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7+tMCJ7OtJK9Gd69u8t1lDx/CAaXYSFNmDt21Z+gis=;
        b=QG+c1t7+MrdXEMvy/S3pHSnHTIR4NmsyTKtlijDch9Evb8QvxB1HvuWviXw98GTXeE
         g0sHEVk/o23www0tK739694liCHl+nu6Kl18LthHBlcfE3QVPuLFklGQ1YL+vl/97Dye
         YVAJg8FWmAyMQ5vjR/UHXhRfUaR0Ullvwi4UcNzWMQzhMQsYE0jXE+O6+hYJDWr2GBn3
         3kQuh0yqhNCzYpIdRQcAs5MQ+BahFOAvtBNLOabKPWV45vJzWMa+93MXq4Cj68ZC8PZ7
         JW/PZyQjGggEBPCRysyYo8TLlkykkz7r9bCRwqIL6+Hh54WQom7sttEEdv/bvXx6khjn
         hEIA==
X-Forwarded-Encrypted: i=1; AJvYcCXRZHD81eSWsaHklzvDh7ev1PBusM3qMFjBC19ftD1ug6v5+demAvWfKF4mqsiloR8VluJ2AY9cqOLJYmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw79kpFnSJi9uhyrNUasSPnkvnoRy4CfXGHE+K30pNpLzhXvwEC
	jSwNF7uRFNHgKJDUlVrrMJyRqaHeuwFHT4g7dg5RFmbquMGTs8TafdcW2aH5fWM=
X-Gm-Gg: ASbGncs6sub3LNh7Kl9Fj+9Zj6tGurM/lAvrFZcYYdcrQDg1Xa1tI5mEld6RgJXIunP
	DsZ/199fQ6eL7QXquwWvgCm/AVyHpHHg5hCJe0wolnCin8YiG+yfuea07HWk4MGfF8XNFFju82g
	UHOiDncB3mD1Vo1K97skpw0jVy/mqdomiOKb3f4CTHWhDrg27AqdKRL1MdVRAB9GhlVLLWl3ntZ
	oYmqIiYRVcYdjcUqFkoOQBNgHz7UgaKkuA/zqsMVda73GGRtvuw54sItpwxgG9wfmYaC+3q+SBA
	32d0uqJIWFMueGeM4o3XBjAZtt+Ih4pceNPLxoViKmzFWKz5Lz5B5zUm6pAhLK3jdkBpH/BI1Ee
	VWQaF616HNH5n94NlMRDBirbvSCI=
X-Google-Smtp-Source: AGHT+IH3uOwByyoyn3W77J1zHy8yvZSK7GPQs26EVjZnZhtHSMaY2DHWv6MJlU0FC/UTf0LREW6zUw==
X-Received: by 2002:a05:620a:1d08:b0:7c0:b24c:c3c8 with SMTP id af79cd13be357-7c3d8e46551mr1097540185a.42.1741282365669;
        Thu, 06 Mar 2025 09:32:45 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e533a032sm115790185a.21.2025.03.06.09.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 09:32:44 -0800 (PST)
Date: Thu, 6 Mar 2025 12:32:42 -0500
From: Gregory Price <gourry@gourry.net>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: kernel_team@skhynix.com, Joshua Hahn <joshua.hahnjy@gmail.com>,
	harry.yoo@oracle.com, ying.huang@linux.alibaba.com,
	gregkh@linuxfoundation.org, rakie.kim@sk.com,
	akpm@linux-foundation.org, rafael@kernel.org, lenb@kernel.org,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com, yunjeong.mun@sk.com
Subject: Re: [PATCH 2/2 v6] mm/mempolicy: Don't create weight sysfs for
 memoryless nodes
Message-ID: <Z8ncOp2H54WE4C5s@gourry-fedora-PF4VCD3F>
References: <20250226213518.767670-1-joshua.hahnjy@gmail.com>
 <20250226213518.767670-2-joshua.hahnjy@gmail.com>
 <b8ac8654-92bd-4c08-a3fc-e28a7be5e0e6@sk.com>
 <Z8cqe3BCdobsV4-2@gourry-fedora-PF4VCD3F>
 <f64819e2-8dc6-4907-b8bf-faec66eecd0e@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f64819e2-8dc6-4907-b8bf-faec66eecd0e@sk.com>

On Thu, Mar 06, 2025 at 09:39:26PM +0900, Honggyu Kim wrote:
> 
> The memoryless nodes are printed as follows after those ACPI, SRAT,
> Node N PXM M messages.
> 
>   [    0.010927] Initmem setup node 0 [mem
> 0x0000000000001000-0x000000207effffff]
>   [    0.010930] Initmem setup node 1 [mem
> 0x0000060f80000000-0x0000064f7fffffff]
>   [    0.010992] Initmem setup node 2 as memoryless
>   [    0.011055] Initmem setup node 3 as memoryless
>   [    0.011115] Initmem setup node 4 as memoryless
>   [    0.011177] Initmem setup node 5 as memoryless
>   [    0.011238] Initmem setup node 6 as memoryless
>   [    0.011299] Initmem setup node 7 as memoryless
>   [    0.011361] Initmem setup node 8 as memoryless
>   [    0.011422] Initmem setup node 9 as memoryless
>   [    0.011484] Initmem setup node 10 as memoryless
>   [    0.011544] Initmem setup node 11 as memoryless
> 
> This is related why the 12 nodes at sysfs knobs are provided with the
> current N_POSSIBLE loop.
> 

This isn't actually why, this is another symptom.  This gets printed
because someone is marking nodes 4-11 as possible and setup_nr_node_ids
reports 12 total nodes

void __init setup_nr_node_ids(void)
{
        unsigned int highest;

        highest = find_last_bit(node_possible_map.bits, MAX_NUMNODES);
        nr_node_ids = highest + 1;
}

Given your configuration data so far, we may have a bug somewhere (or
i'm missing a configuration piece).

> > Basically I need to know:
> > 1) Is each CXL device on a dedicated Host Bridge?
> > 2) Is inter-host-bridge interleaving configured?
> > 3) Is intra-host-bridge interleaving configured?
> > 4) Do SRAT entries exist for all nodes?
> 
> Are there some simple commands that I can get those info?
> 

The content of the CEDT would be sufficient - that will show us the
number of CXL host bridges.

> > 5) Why are there 12 nodes but only 10 sources? Are there additional
> >     devices left out of your diagram? Are there 2 CFMWS but and 8 Memory
> >     Affinity records - resulting in 10 nodes? This is strange.
> 
> My blind guess is that there could be a logic node that combines 4ch of
> CXL memory so there are 5 nodes per each socket.  Adding 2 nodes for
> local CPU/DRAM makes 12 nodes in total.
>

The issue is that nodes have associated memory regions.  If there are
multiple nodes with overlapping memory regions, that seems problematic.

If there are "possible nodes" without memory and no real use case
(because the memory is associated with the aggregate node) then those
nodes probably shouldn't be reported as possible.

the tl;dr here is we should figure out what is marking those nodes as
possible.

> Not sure about this part but our approach with hotplug_memory_notifier()
> resolves this problem.  Rakie will submit an initial working patchset
> soonish.

This may just be a bandaid on the issue.  We should get our node
configuration correct from the get-go.

~Gregory

