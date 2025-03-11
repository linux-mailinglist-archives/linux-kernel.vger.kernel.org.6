Return-Path: <linux-kernel+bounces-555467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35636A5B80B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 05:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0E3171F1F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 04:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62211EB19F;
	Tue, 11 Mar 2025 04:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CSMQ1Si0"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6950F1EB182
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 04:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741668176; cv=none; b=nvn2bPIk5M473GHOkywEEcAWl8OOz0AZ91SFSHZyBByPP6r39Ce2AMi44Q0jNjGb2TbcvrqcW1aVhSxoza64I3ZGmPRYGg+G9rDwHWFhovCeFcr1A0i+WSRTTwaHTl2dubNvLU3zE5ib58uJiVUbLlXexH0OMfqwYVedxNeMbd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741668176; c=relaxed/simple;
	bh=ZIXYbx99GWcU3m4RbCBFujbcjDEGf3CVOkhBYhq9nNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dcf4PfNwpgThI1gLw0Y8K0kbkpZPzQ9dGXIGoRNf1OX77fI2R2DSdHFaXz+3BilNxoiGD+8+BjU2CLURycm6kMrEQ0xIxSQ8I9fAM1j6fL8AKG+F2+zJI8aydXokPoD3mLZRDABvVXuHNHYWobt8PL1oXAMZkzgw6JdKzbcFCmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CSMQ1Si0; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c54b651310so280491285a.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 21:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741668173; x=1742272973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yggy5E5nMEcdAw0yO3eFHyu+/DXmHOC/abpMBj8KMA4=;
        b=CSMQ1Si0EPmH1myUT/xTUEJNDQtbsFa+EkdCIcvRHdbPDFFvp5GzhqUwD1LzfgBi8h
         4JevWIXTINuSYmHiPoQ9ZAiuM1OSOMdUArcheEPaE1ohNsJIUTdY6Svhfl8uNKcFY3XU
         WgJF2GeNw6poz0LD7AKGBy1K204CrMG/19SxejUJ3LvvbCokf6YEm49qdio2w7/Z3iMB
         cetCBqExqiwtqnnMj43SIGv8fknh9dV7gTfacfEFbsO6mHxETaf/sCco1XGYKlr8Yk8t
         eB+vYQs27SbFNI0tycydh0RT/7EY8Ra0izY+k+u9JMXlsZmR+++v2LlvdlsgTyJPrMvp
         5y6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741668173; x=1742272973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yggy5E5nMEcdAw0yO3eFHyu+/DXmHOC/abpMBj8KMA4=;
        b=uXfOhK5FUMOrWgUHEu8Rm/tnVevpGUdE+ePkVu5eA8RZ/gpHT+16tEdCGjQZ2Y9iPd
         8r9+NoZ4mTEqyw2X/aJ6If+3MlijRX6QB1QyO3HRqVy+3yD+1cDOXZrIzZRn6E1utcGV
         SAElOiZjXbzSwAyVERFipPIZGVQVlJruUs0Wa+5hEv5M1oCDqtR4lhilhKQzsf77fXyH
         GBCscdBCNWicGt9tyPdWPcpdwF3k0VtDycy+21wLDN31muhCgJ2QAVORXq3JUPIjQ2zf
         cOvEBysoBOrfFKsnz5DO3WdZpA+i8UX2m3Xhjh7ugViTF6nch3CYcHFZuQPKlUj8s/0z
         Yusw==
X-Forwarded-Encrypted: i=1; AJvYcCXoCzifZZaF2U7WhERAFYAareePDlwgcpQq/jVbUBhqrhVH+scgyZ+lHl8o8rZsOJlHyctO6drw5NYLU6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgPLuJLcADsUKKb16K02JcAbOwbu1V85v6shhca4zxcrszSw72
	7vbk/g0L6OL50x8Q1af4pZocm0EVSRJE/Rmq4wQyxjqQD2O2csY2Xrl68tGszkc=
X-Gm-Gg: ASbGnct8Zu6ISvyLJ3rH1CDC8DDPNy+K3o7F0qlsywHEGgtADt3wNsiW1GI351oN74L
	GKPpKIJJiSLdxoOR1qFTjDpNMDac+DWtDmCyqf/k+8pBr9WyYFbbeY7lFE2mM9ztEzX8wtKKHxc
	bXJRAWqG9yAcAOS0wjA/CrFt3mGAbad+tzW6fqDu/fHsZhjWHGsG79iqraMhCOqbV7YQYnh9F+5
	zkFfJSkNwONtV0LyEMuWw6V/Lmtd9CpA7PHlBqsGn7vR+Tw6ylQCkEWn5qro+tQY+4w6DlaWaev
	mrEPLBWCpix2T9cmp/V8hB48lUqR5suI9NR7vTdSA8yJb+syDV+vkpmlO6QZIAUy4mdZmKluFJw
	HeJU3Qsbrlqu3Qtx/R/rLQiR1RAk=
X-Google-Smtp-Source: AGHT+IE3DXDoXpaGabxCNGVv6brJLbyVLodPXFyApwSTWHeoS6ie+LPjHb7T5fwZkKUirni5TTUSjw==
X-Received: by 2002:a05:620a:8803:b0:7c5:5a97:f784 with SMTP id af79cd13be357-7c55a97f9fbmr560057085a.33.1741668173210;
        Mon, 10 Mar 2025 21:42:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c54f33d3bbsm324043985a.45.2025.03.10.21.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 21:42:52 -0700 (PDT)
Date: Tue, 11 Mar 2025 00:42:49 -0400
From: Gregory Price <gourry@gourry.net>
To: Yunjeong Mun <yunjeong.mun@sk.com>
Cc: kernel_team@skhynix.com, Joshua Hahn <joshua.hahnjy@gmail.com>,
	harry.yoo@oracle.com, ying.huang@linux.alibaba.com,
	gregkh@linuxfoundation.org, rakie.kim@sk.com,
	akpm@linux-foundation.org, rafael@kernel.org, lenb@kernel.org,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [PATCH 2/2 v6] mm/mempolicy: Don't create weight sysfs for
 memoryless nodes
Message-ID: <Z8-_SXm0JGjXTegL@gourry-fedora-PF4VCD3F>
References: <Z8-jLIugrb86KBSZ@gourry-fedora-PF4VCD3F>
 <20250311040252.425-1-yunjeong.mun@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311040252.425-1-yunjeong.mun@sk.com>

On Tue, Mar 11, 2025 at 01:02:07PM +0900, Yunjeong Mun wrote:

forenote - Hi Andrew, please hold off on the auto-configuration patch
for now, the sk group has identified a hotplug issue we need to work out
and we'll likely need to merge these two patch set together.  I really
appreciate your patience with this feature.

> Hi Gregory,
>
> In my understanding, the reason we are seeing 12 NUMA node is because
> it loops through node_states[N_POSSIBLE] and its value is 4095 (twelves ones)
> in the code [1]  below:
> 
... snip ...

Appreciated, so yes this confirms what i thought was going on.  There's
4 host bridges, 2 devices on each host bridge, and an extra CFMWS per
socket that is intended to interleave across the host bridges.

As you mention below, the code in acpi/numa/srat.c will create 1 NUMA
node per SRAT Memory Affinity Entry - and then also 1 NUMA node per
CFMWS that doesn't have a matching SRAT entry (with a known corner case
for a missing SRAT which doesn't apply here).

So essentialy what the system is doing is marking that it's absolutely
possible to create 1 region per device and also 1 region that
interleaves across host each pair of host bridges (I presume this is a
dual socket system?).

So, tl;dr: All these nodes are valid and this configuration is correct.

Weighted interleave presently works fine as intended, but with the
inclusion of the auto-configuration, there will be issues for your
system configuration. This means we probably need to consider
merging these as a group.

During boot, the following will occur

1) drivers/acpi/numa/srat.c marks 12 nodes as possible
   0-1) Socket nodes
   2-3) Cross-host-bridge interleave nodes
   4-11) single region nodes

2) drivers/cxl/* will probe the various devices and create
   a root decoder for each CXL Fixed Memory Window
   decoder0.0 - decoder11.0  (or maybe decoder0.0 - decoder0.11)

3) during probe auto-configuration of wieghted interleave occurs as a
   result of this code being called with hmat or cdat data:

void node_set_perf_attrs() {
...
	/* When setting CPU access coordinates, update mempolicy */
	if (access == ACCESS_COORDINATE_CPU) {
		if (mempolicy_set_node_perf(nid, coord)) {
			pr_info("failed to set mempolicy attrs for node %d\n",
				nid);
		}
	}
...
}

under the current system, since we calculate with N_POSSIBLE, all nodes
will be assigned weights (assuming HMAT or CDAT data is available for
all of them).

We actually have a few issues here

1) If all nodes are included in the weighting reduction, we're actually
   over-representing a particular set of hardware.  The interleave node
   and the individual device nodes would actually over-represent the
   bandwidth available (comparative to the CPU nodes).

2) As stated on this patch line, just switching to N_MEMORY causes
   issues with hotplug - where the bandwidth can be reported, but if
   memory hasn't been added yet then we'll end up with wrong weights
   because it wasn't included in the calculation.

3) However, not exposing the nodes because N_MEMORY isn't set yet
   a) prevents pre-configuration before memory is onlined, and
   b) hides the implications of hotplugging memory into a node from the
      user (adding memory causes a re-weight and may affect an
      interleave-all configuration).

but - i think it's reasonable that anyone using weighted-interleave is
*probably* not going to have nodes come and go.  It just seems like a
corner case that isn't reasonable to spend time supporting.

So coming back around to the hotplug patch line, I do think it's
reasonable hide nodes marked !N_MEMORY, but consider two issues:

1) In auto mode, we need to re-weight on hotplug to only include
   onlined nodes.  This is because the reduction may be sensitive
   to the available bandwidth changes.

   This behavior needs to be clearly documented.

2) We need to clearly define what the weight of a node will be when
   in manual mode and a node goes (memory -> no memory -> memory)
   a) does it retain it's old, manually set weight?
   b) does it revert to 1?

Sorry for the long email, just working through all the implications.

I think the proposed hotplug patch is a requirement for the
auto-configuration patch set.

~Gregory

