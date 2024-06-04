Return-Path: <linux-kernel+bounces-201381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3658FBDD0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AAE21F235CB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69BC14B965;
	Tue,  4 Jun 2024 21:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OUD580zT"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3028714B94E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717535439; cv=none; b=SUnPvrcU0Hb547SgDP2OCt5WXFZm9VmuBcXhhVjYN1YmIfyardP15ZQ+O/jZrVr5OvZXJ2MvX4Jyl1ViJ289qPTYhbD8NZyLPxr9YVJXs25DEUn7PSj2JjpVF7ub6FvEpMX5yNQ+kHMam8IOeINJNsU4OWKeRq2KPobYoj/pJkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717535439; c=relaxed/simple;
	bh=QwkLdGWGXc3dV0VnyDppk/LIjqPvWihGXXTlSWtr16A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHdUx3HC/fia8d7YALPR2qsTjGyHtiqIntg4kf1TAcxrJJXZMj0cWIQE6P6Aq8jDDCsmEyjldZtJyrAvAN+UpWEz+KAPQymfgv0g3NN1QHSzL+IHMglgg/EDyze2iVOEnSVBJ5CRE0lBkxFfnFm4JxOAojm0h+vwD/67BntVMNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=OUD580zT; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Vv3CZ2kHfz9sc8;
	Tue,  4 Jun 2024 23:10:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1717535434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ChI+yt8V0Gl1mMMTHjPeyIlN3h4hp6Dd5NAHjZ6KwIY=;
	b=OUD580zTq8/H4qyz+P5JohhY0kAu7iXKJDv0C6wt0BJfi3KjvvmDmlwRPrZgoLBDRmvpRU
	XWgKshcqT19gNqvoF1Nkfl+a61zolKVl9clcq2k5XXH7RcxyMbI2QXr5gDWDz1a9BA1K0i
	frWheHNDXhBJ572LRpNeJhMCLeHdyWCeHPBeSPKekCw8ja/GOkp6Nsw+sSZAiHtk0zNTQQ
	geuPFZBooJTMhUWQyEibF4iJGdFwUruw1vnfbab2cFaAPU/nSjBLOtGvrAssqv7OUphBrL
	BcFIHQciY68BdiwxszmYcYl42MLjAZ4ua1Y74KAWS3jB2SZKc2OmUEfWVUTH+w==
Date: Tue, 4 Jun 2024 23:10:19 +0200
From: Erhard Furtner <erhard_f@mailbox.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Johannes
 Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, Chengming Zhou
 <chengming.zhou@linux.dev>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Minchan Kim <minchan@kernel.org>
Subject: Re: kswapd0: page allocation failure: order:0,
 mode:0x820(GFP_ATOMIC), nodemask=(null),cpuset=/,mems_allowed=0 (Kernel
 v6.5.9, 32bit ppc)
Message-ID: <20240604231019.18e2f373@yea>
In-Reply-To: <CAJD7tkZ+QY55GTzW9A7ZCm=rxAEfrW76cWXf8o5nwiKSXp8z=w@mail.gmail.com>
References: <20240508202111.768b7a4d@yea>
	<20240515224524.1c8befbe@yea>
	<CAOUHufZ-9NmzOKjLedvZFp0=N0LvRZn77qC6k1WXK+NHtKr=0w@mail.gmail.com>
	<CAOUHufZ36rQc8AfLtRv2QrEareysdvbprAEO5XkcG-FeDOxFLA@mail.gmail.com>
	<20240602200332.3e531ff1@yea>
	<20240604001304.5420284f@yea>
	<CAJD7tkbCRLdy0vD2Pd17fNrxHgkzW1VucN4qMkohLFLBLaaeCQ@mail.gmail.com>
	<20240604134458.3ae4396a@yea>
	<CAJD7tkYjJJGthQ_8NukGw6Q9EYbLA=8sAH_7=B90KXEL6HWdSw@mail.gmail.com>
	<CAOUHufa0Fpj6SjNgB-z0n5Jg63q1ewkbOAU65forpDwQVs45qg@mail.gmail.com>
	<CAJD7tkb=5GJ9SNUwDsu1Zy3Tus4rjsNo60Hg9N7=gGth409Diw@mail.gmail.com>
	<CAOUHufb6zXr14Wm3T-4-OJh7iAq+vzDKwVYfHLhMMt96SpiZXg@mail.gmail.com>
	<CAJD7tkZ+QY55GTzW9A7ZCm=rxAEfrW76cWXf8o5nwiKSXp8z=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 602f3f677966dc7d20e
X-MBO-RS-META: kfdi7qzihg3shght4uhztepa48pub5am

On Tue, 4 Jun 2024 11:01:39 -0700
Yosry Ahmed <yosryahmed@google.com> wrote:

> How many CPUs does this machine have? I am wondering if 32 can be an
> overkill for small machines, perhaps the number of pools should be
> max(nr_cpus, 32)?

This PowerMac G4 DP got 2 CPUs. Not much for a desktop machine by todays standards but some SoCs have less. ;)

 # lscpu 
Architecture:          ppc
  CPU op-mode(s):      32-bit
  Byte Order:          Big Endian
CPU(s):                2
  On-line CPU(s) list: 0,1
Model name:            7455, altivec supported
  Model:               3.3 (pvr 8001 0303)
  Thread(s) per core:  1
  Core(s) per socket:  1
  Socket(s):           2
  BogoMIPS:            83.78
Caches (sum of all):   
  L1d:                 64 KiB (2 instances)
  L1i:                 64 KiB (2 instances)
  L2:                  512 KiB (2 instances)
  L3:                  4 MiB (2 instances)

Regards,
Erhard

