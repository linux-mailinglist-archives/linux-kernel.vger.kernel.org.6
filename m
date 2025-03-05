Return-Path: <linux-kernel+bounces-547092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BD4A502E8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0BB73A8D3A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA1D24EA9A;
	Wed,  5 Mar 2025 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="031W06Mi"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E7E24FBFB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186412; cv=none; b=XdJP8K9UoOv7vTUD3OrvWBilLWJuE8+CECTJgjztjA5+0QYQPAdf4ruOGC8hd+A6i9o9m/qtKFIY0QqM7kPRZ47jgYpqDbDbk4YtsrURiZbpyx8eIvP7sOo9OpDQ9H+WLYZXfmrXNoxHoZdT+PWtSybZwkJXOJV85gTNvUhszDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186412; c=relaxed/simple;
	bh=+mQ/wRt0yQOk9Bnyf8iQoG2axRHlZtv4LSbgYEq4dKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAZB3PBf/TpcDNLZCNSTp6KjBcApJtPwWosudQvR8UHzF84qcnRgeji6f/j1yYUaYrOlTNcmREw7MFJT6wrfpGNIz9wTf41hDKLphyWSDlw9r7XIr5pfkhKD3fNaxJ+YcrpeULVrsVQDnftXLgCwG9ma8OCUgnRgTJIAIiuF3UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=031W06Mi; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8e8da098eso5853326d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 06:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741186409; x=1741791209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ONXOEdockKdHhTfqSAFsPbDgfPvHNHsMHk1hOcOegik=;
        b=031W06MiVvdVpZTBxRUuj6VpCunLkMW+N8cMSD3TzGD4ofPyDhQU97ApllPyGGMzmt
         pU4gZVPjAzW+lFECnVPPJFQrSV6gUAl6HqjHroYLFNBWzxf8YwZMyJSxSUmFpnMRgZb2
         8iEhwlswNvGsXs6Hokd0wP5yN17NnX+ZBVCe8BQVp7fqV8pdLa+r5xGK5Q//bSyDk1El
         hl8rO8zzZ7iD/EZlVcxqima2k7JOmtr81D+ZCqm/3SKCVAwXk/kRJU0dTPWTpNIFqZaw
         8eKvnc9gBISWw6Zb+abnkI1hlHvULhZE15gYNMW4NvRoM+E88CmxbKhLVtklkan4dVZQ
         hEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741186409; x=1741791209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONXOEdockKdHhTfqSAFsPbDgfPvHNHsMHk1hOcOegik=;
        b=anSMXbexhL++omt95aHVMwOBt6ULUJqv2aAbpujQMkMXDRrPKErkB/WKfezpE91CUl
         Et4WkePaZ92tV/nwH+cDwB1P+u7b7sMHzqpNZCbq4nW9WUplEG0fshzg7qaUtuUfWymo
         n4OacfVX7bvXS9rP+SWDLUGohT6AQQ2ECion0lbNhU/2gmrD6WZq6r1xtrLOx7DqSeYH
         6PmXkm7lxFEkv5QjQOV9YeCvoX3gOA3+ykra++i5M9JzLQl7WN+fEWwdsNjMvNM/fmHD
         J6fwX4PHzUGCbWZZaG/UsS1nreKtORZhFukXTj156sz/Lf8Gw/QkfttAT9b//KIfc3hZ
         mhxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR1YONBbz0GVNCwMdpv06mHc7bJ8KoXJfI6A2Ty23VbpyvD3lr84lB04ynwil2tdbXHN5EwxgyQord46Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkKArMI97fLOFDlfGAn00LALxb/tAWlbaDRufITEgQlxtgV8Ep
	kkwQtB9rIOPDFJh5medKHceABMgX6G2LS0PZAlp9T8+lNx2ayR2pG5LyyHa2lzM=
X-Gm-Gg: ASbGncsrofbO9U9/KnO0WZubUsEYpuY1YfzxFsiihro3B97jBPJ7L8z2FDNrUygDtzF
	CkLm6XvOHp9D9fmDYuwjmR6qj5FfK05Oy1WotFCmWe8/Jh8tBDLRQ++yzmmD20RtyfljPilWF7K
	GgYs0wSoTSpMGYacaU+GpX1t6d0Mxq/zvR+19UxYKXaAYubZjl7CZ4Ak9Xf4osvA5j10qUtxdl9
	2DynB03EgRkxemuNvGYx2xf10yjgTNDNebaa/PYuSSRUzNf/UHP0tEGPCIALq07sTC4gISSXh3l
	kalTAggW7Iv9xFHUXyOl68xYJsSzHKXjMb60lWy8n/U=
X-Google-Smtp-Source: AGHT+IGCenBDc2Fsy6T0dVcsVCJ3L8dr9JxoA9aOAo6mVTFn/Kba3M5IpAjpfnxaiyHoOLAMJqe//g==
X-Received: by 2002:ad4:5c87:0:b0:6e8:ebfa:42f9 with SMTP id 6a1803df08f44-6e8ebfa4b46mr31866186d6.16.1741186409507;
        Wed, 05 Mar 2025 06:53:29 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e8976cc74asm79656786d6.76.2025.03.05.06.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 06:53:28 -0800 (PST)
Date: Wed, 5 Mar 2025 09:53:27 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable 5/5] mm: zpool: Remove
 zpool_malloc_support_movable()
Message-ID: <20250305145327.GE185622@cmpxchg.org>
References: <20250305061134.4105762-1-yosry.ahmed@linux.dev>
 <20250305061134.4105762-6-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305061134.4105762-6-yosry.ahmed@linux.dev>

On Wed, Mar 05, 2025 at 06:11:33AM +0000, Yosry Ahmed wrote:
> zpool_malloc_support_movable() always returns true for zsmalloc, the
> only remaining zpool driver. Remove it and set the gfp flags in
> zswap_compress() accordingly. Opportunistically use GFP_NOWAIT instead
> of __GFP_NOWARN | __GFP_KSWAPD_RECLAIM for conciseness as they are
> equivalent.
> 
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

