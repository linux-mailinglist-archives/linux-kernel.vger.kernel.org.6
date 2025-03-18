Return-Path: <linux-kernel+bounces-566397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4393A67761
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D143D1784DB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572FB20E702;
	Tue, 18 Mar 2025 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qoVWqPUF"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8081EB5F8
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310799; cv=none; b=uoJO7eGlbBuLMpacBSGFhWCy5IxiCc/rOBz/sDg5tf6NRAESN/Z4TnwM+Eg6C0U2WKobls6/88NwcsmOrFG2CDtOJH+JcEi3/44zXZNurQQ8BTq/JCZu12W7axiYrcRXjuA9YQk0cyhAWYuBUyicaQNfvWJlEeVQFyJy67JLjt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310799; c=relaxed/simple;
	bh=EeDs3BIQGtKIFiUdLNLAGZaKA1a2dW7BiHIddDYGJGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfUBxQMbyI2awey3kPGVNvkDVpzqVsJp36hLMRQBw14q2hpqqzVibkQVeqm2EVRLxCmaTUAn0ts9HdINXStLWS4j0r7zuYrXkQCT5NxIy1KKU1lEVzxfeDIcBoRPBeyPWJQ0sWoMq71rdnPG0Ui8EM1VelZlgn9ClvdBAi5cPSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qoVWqPUF; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c559b3eb0bso327836985a.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1742310796; x=1742915596; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fq4YIdfyvH3D38tBVB9O/pfTAXZmUQ3xOYQLXZJY38E=;
        b=qoVWqPUFSe0dKI7mmBZxT/BTFvujfxisrax8gVMpOiwFP4ySflNeaHLWBKhLb9dcDr
         CLKczP+qnQqoQsmKhHvDpQGI6JrgWSEWkFzCJ6N38r/s1EiyT7uQ2jgWEOGZPJQLlvjb
         gEkST1y0DEoW7samWJJ1fSLRC5FeGrWIIT+vDXD8RM1jvu3xX4cVty6/eCiDCuEo2oNr
         NV55+/kzoybd3GN0LQ9qyO7Oq8+aVLZdQc8QcXbJrMhrN4NG+2JaudEt+0ZXFpOWyyQE
         ZhkKGZkQwaETIKnWsnEfTZ1HYBHPavANqUQhvnataKw7Aw0BT1K839TMD2eOQ1rmLgoL
         TeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742310796; x=1742915596;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fq4YIdfyvH3D38tBVB9O/pfTAXZmUQ3xOYQLXZJY38E=;
        b=bdizMUtBLaa1t97VeBed+toJM8S0Lwu7nxM3dY4eXVfuIkpzrORz3z2AVrKjEZfPti
         V0DQu0YKNVutT6XMokIJIxerQQj7oNr4a8riJ/tOvzN5oA16uFi8lbb8Ug780TsHOc9u
         GnxHstJGA7np7P9YcnoBDt96Q1KDdmf9lxkQDtevDC4JIrh5lqrunFhVafI/U565VRTA
         Fnvds3R4DdupIceWFNRej6idV5yIT/fXy/YRVdoOG8lVEMtf2w0thTK/TgWRsNY9hl82
         yGDTD5VPCgaNi5iZJUvFnPInoSn/CxEIsGKBeA9ruOt1gwwRn4jrDoY7bnOOSn6UGMeL
         OlCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU9yG/NlldVzAJ6DgZuKHz7I8V0Di6syCYESIltZy6ripMGXWXms1WXvXUrwF3eVx+86/yI2AQqlx1Jow=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm5b+lQl+WSOmzntiouiDuaR974YIVMLizql0wvXyJZYcHQqj8
	hmQJIWipsATLxoYtMUiijrUhHk4E+eK4OC6KCdNTwTPZL5v/cueXIXEEqfVtJks=
X-Gm-Gg: ASbGncstubEpihxOR4oVyqkcxRRHGdf7aTQO+r6B2nLyBezmgKIysK9DiYCSH6RS76W
	d11Op2tFvcZnoegSx+SCEgwIDDR9QrQ9hbUss6PlfR8EVs8ZRnKljJG32PrruwKkiTufP/pWksS
	MollH3Rpn2rOMWjZVS8K1v81ck0ec9FB/0cHoLX9hivyP22CU9sPBUUk6TNVro6XHVGm2qw5zYg
	2XWffCFz9uRhdbM3o/H7yOqKpGQHjxKATMzPB1YRVOH1EWnetnLUkAlE2We6x7DHi9qAnHlKr5Z
	/m9xa5BFKNqqmT4u/siomFZnSOjvyf6lZIuLC+bTFfhnYPERNFJFs97Z19V+MdzZ9IuIVhUvV6R
	TBNOVBmnaWt6XCFEH3XCCXguvRfE=
X-Google-Smtp-Source: AGHT+IHeMQ4TK7mWZ8ZCPZ0HfjaVy2CNDBY+DoggANGCjpN0TVfqxk3IlMuRg8yeq+gDT6U2kTi9hA==
X-Received: by 2002:a05:620a:470f:b0:7c5:5008:436a with SMTP id af79cd13be357-7c57c73da02mr2385055785a.1.1742310796559;
        Tue, 18 Mar 2025 08:13:16 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d8aecfsm730776785a.100.2025.03.18.08.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:13:15 -0700 (PDT)
Date: Tue, 18 Mar 2025 11:13:13 -0400
From: Gregory Price <gourry@gourry.net>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: Yunjeong Mun <yunjeong.mun@sk.com>, kernel_team@skhynix.com,
	Joshua Hahn <joshua.hahnjy@gmail.com>, harry.yoo@oracle.com,
	ying.huang@linux.alibaba.com, gregkh@linuxfoundation.org,
	rakie.kim@sk.com, akpm@linux-foundation.org, rafael@kernel.org,
	lenb@kernel.org, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
	horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH 2/2 v6] mm/mempolicy: Don't create weight sysfs for
 memoryless nodes
Message-ID: <Z9mNiWm1pNIxiu0t@gourry-fedora-PF4VCD3F>
References: <20250318080246.1058-1-yunjeong.mun@sk.com>
 <ed0004ea-c8d6-4ba9-ba40-0c9a97d98db6@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed0004ea-c8d6-4ba9-ba40-0c9a97d98db6@sk.com>

On Tue, Mar 18, 2025 at 08:02:46PM +0900, Honggyu Kim wrote:
> 
> 
> On 3/18/2025 5:02 PM, Yunjeong Mun wrote:
> 
> Some simple corrections here.  host-bridge{0-3} above aren't detected from CEDT.
> The corrected structure is as follows.
> 
> rootport/
> ├── socket0
> │   ├── cross-host-bridge0 -> SRAT && CEDT (interleave on) --> NODE 2
> │   │   ├── host-bridge0
> │   │   │   ├── cxl0 -> CEDT
                          node 4
> │   │   │   └── cxl1-> CEDT
                          node 5
> │   │   └── host-bridge1
> │   │       ├── cxl2 -> CEDT
                          node 6
> │   │       └── cxl3 -> CEDT
                          node 7
> │   └── dram0 -> SRAT ---------------------------------------> NODE 0
> └── socket1
>      ├── cross-host-bridge1 -> SRAT && CEDT (interleave on)---> NODE 3
>      │   ├── host-bridge2
>      │   │   ├── cxl4 -> CEDT
                           node 8
>      │   │   └── cxl5 -> CEDT
                           node 9
>      │   └── host-bridge3
>      │       ├── cxl6 -> CEDT
                           node 10
>      │       └── cxl7 -> CEDT
                           node 11
>      └── dram1 -> SRAT ---------------------------------------> NODE 1
> 

This is correct and expected.

All of these nodes are "possible" depending on how the user decides to
program the CXL decoders and expose memory to the page allocator.

In your /sys/bus/cxl/devices/ you should have something like

  decoder0.0  decoder0.1  decoder0.2   decoder0.3
  decoder0.4  decoder0.5  decoder0.6   decoder0.7
  decoder0.8  decoder0.9

These are the root decoders that should map up directly with each CEDT
CFMWS entry.

2 of them should have interleave settings.

If you were to then program the endpoint and hostbridge decoders with
the matching non-interleave address values from the other CEDT entries,
you could bring each individual device online in its own NUMA node.

Or, you can do what you're doing now, and program the endpoints to map
to the 2 cross-host bridge interleave root decoders.

So your platform is giving you the option of how to online your devices,
and as such it needs to mark nodes as "possible" even if they're unused.

~Gregory

