Return-Path: <linux-kernel+bounces-544964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2E3A4E724
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCBD119C7044
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A0A298CD5;
	Tue,  4 Mar 2025 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="UNO9JsI2"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B577A276048
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105792; cv=none; b=WyzvNvMm1RN8GcQwzqi7gl758ZG6BJCXX5uXTfzOVz26LrPoIs+rHt24CAKXLnJ6+p5X9onjuFpeJ89mZddgOnjQWx/wxLUlkJaNoQZ4H2dZan/xoqUAHKxtFNdDd2jZ0/7PAJzJwGxtCu8zk/7cy5MkdDBeNjJj1SLRouCd078=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105792; c=relaxed/simple;
	bh=kiv6AaqSpJxAijF0/1SHB3o+7J9EXmFBMjz6bN80ws4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqoPCFzm5mNRIJemPXsijlKelV/zfna8L+4W7biemSFsOnwcCzubShfqMGoF7U7sM/n5ByK8LFzCzMvVHZktOkIE5EJ60sfPIsMhhsyp70V9OAF06Bc2S78UXvvVkQLo3TO/FY8ShbqqoknictiF4UKMUeyne3+7pH3CzWe+kUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=UNO9JsI2; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e895f3365aso44733076d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 08:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741105789; x=1741710589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8UWPCN4uO5+hoNKPd6bzLCSnzU/reuMIMfkocTwKPZQ=;
        b=UNO9JsI2ekO7uia3Q2AxFQvfoaTlJ2yb9sa8+ARAA78Zgio3x3nQuwsGVmzwEEsfFZ
         sZNcSCZNgOYtvFN+m38sIvG4cP046vGXjQPdzKCUhnZyNTd96+h2sxXoepbixbHO6umu
         /Os6Jfb3s5u92wBu3vCO1TfzBYcLfIbNWkjHGDn+BCBlHVZ4e0IjaQWBlix7nmwKPUob
         1CpvglWlP9RzrUwj/2JdwvygUoFvP0tYBJw7+cIYPrhWzvc0LuhgZQK3wlUGUNRUNh6D
         RdjOU/eHVKHeBNOs8b5ZXykilLBh81QNhtVnKYgzfmRYgzwMB09NwjEWDxl7b3JKA7bZ
         DR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741105789; x=1741710589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UWPCN4uO5+hoNKPd6bzLCSnzU/reuMIMfkocTwKPZQ=;
        b=su6l/M7Qx6S16XRTQNI9gi0k9CUmNnTw91z58Khigit/C1qNjkKgR4+Ljwif/tzO2u
         IFbQ0xDAw6UA+ujirIvBlfk6iQHA1/yqNBb5Gn2xdZCG/Zc1SNq5EIxwkKeH5VbfmTSH
         2rKoUBt+K2JL5FUJtG/o+CkVHNbjVpjwbwcCjHFXRYzN9dFnofiTQ1xNaGrIZ2c22huW
         3oa/4x7gCTlSREslN6ez/rn7HjwIFeUS3bZUR3fQXH/Sim+ZZSEvyeZfd9vRYMpn7wit
         XEmqLGgg9IkjFwZaPVg18DDSy3v9efdQNkvQ+rpDamSaRwZclCauTKRtoKRTfVU+MLab
         jr5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsIa8LDYr1tOph/g1KQsy4NX3RBSInyPaZYD4LgcLxLt/EU8J4TMZonEYtBU6OlB9wZ59qf2JBJrS146w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7GW95+EluEtM52u0/5tdohwxomPKVXZYX9vIKB1zvVM9UTo/l
	u2sEQyJOAfKnbijum+Ryl/b/DILOf851n8yh+A6JeT2BDV4YLtvqgRX7ChCCvyLa728r12/2PFy
	0
X-Gm-Gg: ASbGncu0xDUlfakgFcZCJtD2hLDXDbrNEPhkgL914TPG87bru2uVW6Yc6gDgqaknVUw
	LuT1Ng+iJc5DjKOgoEjahmSJNk/FB6XHyOLpz20wpQpCC7/cEnb72gW2eAdukhSKiiUzQTMylUB
	lnwVU/XJsGtViKX4QjbMJCo2pnbSI4cbav9Cd8zlb+/tf6XXnLTb5LB4S/brhJU2LQDVW2l8nlJ
	QTetWqkis/Ef+duSOZXRzZYWFJXKJsLRHqAYJEhdDLpz9hAoTOqzcPwrP1JyxHaqmy4E6y1TMJx
	iL8n5B9ZyV+2/lwcAeFKd/ki6KlEkyVXFN7scoXPwNnnGeuS6Fro+czAKBI25/9CHpzGTDPVJUX
	mUze2gVWO135QSIlsics5nKxKXw0=
X-Google-Smtp-Source: AGHT+IG9pNkV8/om2bZpdkllwH5Qnrkj8fkgcns8KwfxMTIBktUTXJgujzar75xsqgH+g9ThSEfa3Q==
X-Received: by 2002:a05:6214:19cd:b0:6d8:b371:6a0f with SMTP id 6a1803df08f44-6e8a0d8f94fmr290391966d6.31.1741105789533;
        Tue, 04 Mar 2025 08:29:49 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8b0af29ebsm43033196d6.89.2025.03.04.08.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:29:49 -0800 (PST)
Date: Tue, 4 Mar 2025 11:29:47 -0500
From: Gregory Price <gourry@gourry.net>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, harry.yoo@oracle.com,
	ying.huang@linux.alibaba.com, kernel_team@skhynix.com,
	gregkh@linuxfoundation.org, rakie.kim@sk.com,
	akpm@linux-foundation.org, rafael@kernel.org, lenb@kernel.org,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com, yunjeong.mun@sk.com
Subject: Re: [PATCH 2/2 v6] mm/mempolicy: Don't create weight sysfs for
 memoryless nodes
Message-ID: <Z8cqe3BCdobsV4-2@gourry-fedora-PF4VCD3F>
References: <20250226213518.767670-1-joshua.hahnjy@gmail.com>
 <20250226213518.767670-2-joshua.hahnjy@gmail.com>
 <b8ac8654-92bd-4c08-a3fc-e28a7be5e0e6@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8ac8654-92bd-4c08-a3fc-e28a7be5e0e6@sk.com>

On Thu, Feb 27, 2025 at 11:32:26AM +0900, Honggyu Kim wrote:
> Actually, we're aware of this issue and currently trying to fix this.
> In our system, we've attached 4ch of CXL memory for each socket as
> follows.
> 
>         node0             node1
>       +-------+   UPI   +-------+
>       | CPU 0 |-+-----+-| CPU 1 |
>       +-------+         +-------+
>       | DRAM0 |         | DRAM1 |
>       +---+---+         +---+---+
>           |                 |
>       +---+---+         +---+---+
>       | CXL 0 |         | CXL 4 |
>       +---+---+         +---+---+
>       | CXL 1 |         | CXL 5 |
>       +---+---+         +---+---+
>       | CXL 2 |         | CXL 6 |
>       +---+---+         +---+---+
>       | CXL 3 |         | CXL 7 |
>       +---+---+         +---+---+
>         node2             node3
> 
> The 4ch of CXL memory are detected as a single NUMA node in each socket,
> but it shows as follows with the current N_POSSIBLE loop.
> 
> $ ls /sys/kernel/mm/mempolicy/weighted_interleave/
> node0 node1 node2 node3 node4 node5
> node6 node7 node8 node9 node10 node11

This is insufficient information for me to assess the correctness of the
configuration. Can you please show the contents of your CEDT/CFMWS and
SRAT/Memory Affinity structures?

mkdir acpi_data && cd acpi_data
acpidump -b
iasl -d *
cat cedt.dsl  <- find all CFMWS entries
cat srat.dsl  <- find all Memory Affinity entries

Basically I need to know:
1) Is each CXL device on a dedicated Host Bridge?
2) Is inter-host-bridge interleaving configured?
3) Is intra-host-bridge interleaving configured?
4) Do SRAT entries exist for all nodes?
5) Why are there 12 nodes but only 10 sources? Are there additional
   devices left out of your diagram? Are there 2 CFMWS but and 8 Memory
   Affinity records - resulting in 10 nodes? This is strange.

By default, Linux creates a node for each proximity domain ("PXM")
detected in the SRAT Memory Affinity tables. If SRAT entries for a
memory region described in a CFMWS is absent, it will also create an
node for that CFMWS.

Your reported configuration and results lead me to believe you have
a combination of CFMWS/SRAT configurations that are unexpected.

~Gregory

