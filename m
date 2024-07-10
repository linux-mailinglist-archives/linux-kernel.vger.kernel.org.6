Return-Path: <linux-kernel+bounces-248122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C1E92D899
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958B01F24D78
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04C2194C96;
	Wed, 10 Jul 2024 18:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ry2woesN"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A00C74416
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720637363; cv=none; b=XABJvlfGybH4PXaBrx1K6ljy2tvqlSMYHZRovU9GJvDKMfbecTnMiQm+Ors8qcuFJt4IVRLR9/bMENulqX8NTopFYhFwy6U+IIs0/D9vROEDXO2kVJh3f/W1Ha6GVMXnSqC5+f34Oj6tOLXWPMXlq73pW8AoOgzJmtlICUWYkhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720637363; c=relaxed/simple;
	bh=CDzDoDBPrI9O45fu4nDGF7EewD4QPEbaHsgpGnRS9bA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=naUfXVECZjMO+qefxwLE+l4T/QpuqOscMaKIK0Z74TtP9YQxYGE3qIfKmic9Nvzfuz3hG4iMSgDRpvHh/HPLys9szX0cd3B9Hsuk0aDLagE4/dTe8CI/+gzdizzvR/zunAcUtDsDfakr+k1/qcOsIbU68a4QwvcAXqjcNuWmlFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ry2woesN; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-25e04a7d9f1so66301fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720637360; x=1721242160; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CDzDoDBPrI9O45fu4nDGF7EewD4QPEbaHsgpGnRS9bA=;
        b=Ry2woesNsrEM5z0/O7KvhVLpWh2uONfiZbkgPoMPqvCI5hOZ4yDnjsJNRcVan3oPNi
         hD+1n3RZweSar48kevvltDqywH2WnxPt4R2SLVyzxXeT/p1p/6kbRHEX8HfMatQR2OB6
         wzgxD0x37VaIjtgRVQxh+rA7aHg+6P1eRyIIYvHmg3cIZoLtPvLEbbtLeaIX8HujDhBP
         khpYtW/Ef0e5+cpuzz/t/cruOyb95yaY22C0bVTaC7IMCg4zBJUooMP+QQKPp6Zknt8h
         YKuCyzWKtQgyAX8KxQUHQMWO3DfMqX1WRIqBH76X0l2vtmsEv+V5MGkV9+0kNeh9g50h
         kchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720637360; x=1721242160;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CDzDoDBPrI9O45fu4nDGF7EewD4QPEbaHsgpGnRS9bA=;
        b=Txh4kopu3YeEmkIkksapHoV1RfbJ7MnBK8y+od3WJ8uDLQa6ThsJQ+nIyD6VTOk7GH
         +lSwevmAIn8Js+1ozUlO0+XifFwuVTRpS++F5hdIdD/iYNcsTVdcekKJxxtlQiIdqIPP
         4Ro9ujtl0BlGi2FgLpck/XV42IZ6xHmBEhVWAbHuM2V1+7UkPQ9rDg6To7GwCTPuauZD
         wZsWWQBVuDF4fc6iBvgDWDK+6x1wxVexP0OnJrVF9uKgwxVVo7nE5P2Mqt5EDcEEeU7X
         H77u5jY2kLGjETJI/06L8izr0tK4D4BcKvluZB+UciOT+tvI4A9TAfmVPrUiVuf9lHyo
         +JuA==
X-Forwarded-Encrypted: i=1; AJvYcCUTmndMRnk7414WX/vmztijowllDShevt3mZ4FJ2cZHjwlFSeeXxh+z7SnW9LrWx2lC8w1Mh8ENVpbLUMfZgLIYYmThCKrl7R/reo0U
X-Gm-Message-State: AOJu0YxWpW2yXsdvQepsev1EqTbsaE05kBVjjSrTzefLbuwCTM1LH56y
	DvdrQBIbR0aA96HgXyZSuMd5t2ZpRO3ZnYtGzlBeVDKe4j0LTj94iEi11TeCPw==
X-Google-Smtp-Source: AGHT+IGpNu9mEuoMmeAlVedGx8Nyw0EmBMtvokuZhBygl5S2JzWgS4Wea6kyWyOlMeLcWyY/SXZaig==
X-Received: by 2002:a05:6870:71c4:b0:254:d147:f256 with SMTP id 586e51a60fabf-25eae749f6dmr5489335fac.8.1720637360470;
        Wed, 10 Jul 2024 11:49:20 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25eaa078407sm1336933fac.27.2024.07.10.11.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 11:49:19 -0700 (PDT)
Date: Wed, 10 Jul 2024 11:49:09 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Usama Arif <usamaarif642@gmail.com>
cc: kernel test robot <oliver.sang@intel.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Johannes Weiner <hannes@cmpxchg.org>, oe-lkp@lists.linux.dev, 
    lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>, 
    Chengming Zhou <chengming.zhou@linux.dev>, 
    Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
    David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>, 
    Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, 
    Shakeel Butt <shakeel.butt@linux.dev>, Andi Kleen <ak@linux.intel.com>, 
    linux-kernel@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [linux-next:master] [mm] 47325a5c88:
 WARNING:at_mm/slub.c:#free_large_kmalloc
In-Reply-To: <4bc6400e-6199-4147-9399-4a54c94613fd@gmail.com>
Message-ID: <612af749-0a59-f91d-693a-43d6217ffebb@google.com>
References: <202407101031.c6c3c651-lkp@intel.com> <dd08adbb-6df5-4556-9fc4-cf37b6234aa1@gmail.com> <053bd429-ae19-4beb-a733-a7a838b1e010@gmail.com> <4bc6400e-6199-4147-9399-4a54c94613fd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

It's a long time since I was active hereabouts, but the bot report
and your flurry of updates make me think that you should step back,
slow down, and look more carefully at the precedents here.

IIRC, the main problem is that parts of the swap_info_struct can
still be in use from before while you're wanting to set up new values.
Observe how alloc_swap_info() may return a fresh or an old allocation.
Observe how enable_swap_info() is called after getting swapon_mutex
late in swapon(), once past all possiblities of error.

I expect that your new zeromap needs to be taking the same care as is
taken with swap_map and cluster_info: to be safe, follow their example
in both swapon() and swapoff().

Hugh

