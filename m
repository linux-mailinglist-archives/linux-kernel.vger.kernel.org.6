Return-Path: <linux-kernel+bounces-555398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10781A5B6E2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 03:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D8C13AF409
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 02:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973B11E7C2B;
	Tue, 11 Mar 2025 02:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CG4ikMwu"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0271E5B65
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 02:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741660978; cv=none; b=gUmO8ALEc7g/gEOybZH9gp7agVACgYHvndlstAGNFCwjKv54g6gmIZZX9bRG0YgyLvVMonZC/H7D3vPs10hysE9Hjk43WVPiWtEK/n+JJLaYLXvv/PMnILwBHktRlWfqaWyj+xVatr8NjGVPxEvtYwlzhx6aMWbh10HFco2ohro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741660978; c=relaxed/simple;
	bh=ayQn7cmaD8ZHN9iSLJD53bXwzVAe2nRg8K/OGfo4ezo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qb4AkW2Ku3TWyULxOhNCPTdo/cAvlczhPRcA0g824GDdBh1CRey1MZ9kZXVxh6NUIMjMMNXGiLZ9LXJBuL4EmYUGxxD9EzzG6rx4aqpJ9/pA258IuIQXwhZt7bDWqdm8BdSrSgEIfOF97PcTgMV73+b8eq9xfz6OHX6el3ndq/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CG4ikMwu; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8f94c2698so21970806d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 19:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741660975; x=1742265775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fLhmxVekInszSwRuSq/Qrb92RROhWIHehhP9/GN0v/o=;
        b=CG4ikMwu2iEPORK+r0N/+WPG41vfWr93SdVgh9etRT3XMExYcmyVlJIvUYzpGeg4Yg
         uYZrYwKx2twSbZAp7jSmjazqOcxcrsLsDPbuXpIw2PFRcpwqSXG3rwfAhk6Nx3kDcOVE
         mPsTnYobH2rsEO/HR8n+o8IGobgxFwO6/aNTrbzFffDUHFXwTO2A/ZG4jsnRJpsyGa5u
         00sv7+JTY1H7nGqun6gB5fXZEIUFK05huskVaG1K2drbroTyvsshoG62i7ueBJkoxuVt
         ZjRAeOaE82WQBw5H8NTFPFXY6rg5ScYDPOIPxplZr9ubz+/zB2oOzpmreWLibxu3qnPL
         tJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741660975; x=1742265775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLhmxVekInszSwRuSq/Qrb92RROhWIHehhP9/GN0v/o=;
        b=UbIf+yyNEGf9h3tE/kqtDKjHG/IavnV4A21ivFUIBEiXnHt79JOjwuUaulDejlgQPp
         UmGZ1vEwQXtHHEx9kbCBPy/VKlR9tZQFX1vw+cnDwzjqKJZrnBNAbrh0epAeCUkV9doK
         e+W5mWIcwPkHSzv9SLqQtU3+ObLWztz+FDP38mi5mA+uXLqi7EVlYmCxB1zPJjX+8b5b
         gYvg+hns9qkUbx2fjI26G/qxf8IdfnBdAIez3P6+CXnkRENaRH8wQ3ciw8UomS6X5jdL
         zAV/tABgPU6QA19140O1wrmCJiVhw3ds793NEH+jLTG6I6g4PGQVpoFVpmYGaIJF5dPa
         Pspg==
X-Forwarded-Encrypted: i=1; AJvYcCU0UsnAPtldz+RVMk/Ut4NKqF48hY3wzSrbHAUWnXm/f7LWtxVNuPbXtXGpeVfZVki/UVGQOAnCUdKc6Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqxH689XVP7JKOmTSCnBAWLk5COKg6D7/rRyYhlnKaSPJkECFT
	JpJT9DLrLXfcrB2+328jqOGg5vhZBaic1g5zfX/yIwOYWxisYs93z0eSCah7cb8=
X-Gm-Gg: ASbGnctvNgIOcoMCHeJMsMw78+vOuj6vrlbGvIQxDIJQplDQxenPHCDJRfPW/7CVEAD
	BPZUPRxhTwQmG5y+kViWsMiVomZH+UADAeXdvWWEtm4T6PfX//fuHMaHa+v86xlQOMnXYB+Z/a/
	RtSXBke/cP0yD/0xDWBritsKRISDCCMIsRqrm71AcPb/p1RJNM8mDYWFSArVMIgJ/7tmfcABexy
	U0DBXBuOWS1HW+acBI8DZrE4zY0zhClOlbXxlQDcE4qeM3M1Ohpk1uh4xlTXYY1gSbYI6X9gOk3
	xFkftFXzewICwhRM+fqJSRogczay97UUyrFsjGb7MLQfiXfHmIbYs6Dleub53t3lj5382hfSAoE
	I7M/JiufnEHnjx1zsqlgtAQv76pRhIxSyrZWZ/w==
X-Google-Smtp-Source: AGHT+IHlLnx/8yc1KdPJ5zdTyNSTraZ5mmTbBV9D2H2GKIWW4SnnOdBFw0C3+8mYsLbkz/bwItoSuQ==
X-Received: by 2002:ad4:5d49:0:b0:6e8:f4f6:9311 with SMTP id 6a1803df08f44-6e9006019c7mr233583136d6.1.1741660975278;
        Mon, 10 Mar 2025 19:42:55 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f7090cf8sm65776146d6.34.2025.03.10.19.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 19:42:54 -0700 (PDT)
Date: Mon, 10 Mar 2025 22:42:52 -0400
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
Message-ID: <Z8-jLIugrb86KBSZ@gourry-fedora-PF4VCD3F>
References: <Z871k085e-Th-jTz@gourry-fedora-PF4VCD3F>
 <20250311020806.404-1-yunjeong.mun@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311020806.404-1-yunjeong.mun@sk.com>

On Tue, Mar 11, 2025 at 11:07:27AM +0900, Yunjeong Mun wrote:
> Hi Gregory,
> 
> In my understanding, both SRAT and CFMWS have the above device and interleave setup.
> 
> and below are the CFMWS configurations (with some unnecessary lines removed):
> 
> [0A4h 0164 001h]               Subtable Type : 01 [CXL Fixed Memory Window Structure]
> [0ACh 0172 008h]         Window base address : 0000002080000000 <- Memory region
> [0B4h 0180 008h]                 Window size : 0000032780000000
> [0BCh 0188 001h]          Interleave Members : 01           <-- 2-way interleave
> [0BDh 0189 001h]       Interleave Arithmetic : 01
> [0C8h 0200 004h]                First Target : 00000043     <-- host bridge id  
> [0CCh 0204 004h]                 Next Target : 00000053     <-- host bridge id 
> 
> ...
> 
> [170h 0368 001h]               Subtable Type : 01 [CXL Fixed Memory Window Structure]
> [178h 0376 008h]         Window base address : 0000064F80000000
> [180h 0384 008h]                 Window size : 0000033000000000
> [188h 0392 001h]          Interleave Members : 01          <-- 2-way interleave
> [189h 0393 001h]       Interleave Arithmetic : 01
> [194h 0404 004h]                First Target : 00000143    <-- host bridge id
> [198h 0408 004h]                 Next Target : 00000153    <-- host bridge id
>

Are you able to share all CXL Fixed Memory Window Structures in the
CEDT?  Just want to confirm some suspicions here about why we're seeing
12 NUMA nodes.  This explains 2 and suggests there's at least 4 host
bridges - but not the other 8.

~Gregory

