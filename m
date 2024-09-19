Return-Path: <linux-kernel+bounces-333637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C195F97CBB1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20E61C2244E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A734D19FA72;
	Thu, 19 Sep 2024 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYqt7dCq"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB131EF1D
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726760601; cv=none; b=uSGXw0d1QzYsD6dxhJUaT7uRlWiTNjmQL9MIlKU/320UebYnFrN1Py6dD6HjhQ8OW0PLWSpnDJLVNWXqG9i6QNGbrUjIPjVDHZ4XRwt7CFHGHjeQD3qDzrCDEb1EWiQLFFUkHlfux1QsfQb4Z8bY1ZPxqoZZ2s4iLwSDPmo1+J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726760601; c=relaxed/simple;
	bh=+uyUP8RAXzeRn+SrBmp+ge+0w7u+WLv2y/JfSUMOM74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAgOrvSIG+1QsAgCgSpP9X8AY9lDvtNsB2ROdtMwIe4tzKFAnA4P2AG6CL1sv8pz7hja2CqMZfUEL38ckqgb0h8JI/V7AZRoWQ8i18ujgwQvaU/GMB3xMjT2TxqM2Gwo/ZjmhPe24U+OOhpJTbGjLsxNYOzZs1CD6gFbXku1lV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYqt7dCq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-205909afad3so13016675ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726760599; x=1727365399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HqsnqwC1PrkCF7/HjaIiyI+sbxed0gBfIuuZtBtDmjg=;
        b=SYqt7dCq7+2gvthUDPBJAj1r/5arXIxcKlt1dgiys/d6urbMA2l5HC0HebDvGfRX4D
         qSONtIzZl1CuQ2h9pANmGEeL0ynCAi3K1kXcVPegqKQFIBpzGRrBXyMIIWCivQAVY+P1
         5DPpQjtz1+6mn6WAvRL8HggSefDixSX31iKCRzH+LFeI9/SbWP2WVM5/LN6tebGaXBqU
         A+j3niTxZl6fF7POeXlGutWU5g1PzazgTftwzrmI60YWPxWXyrfq554fufY//JVpHvii
         vlsi/O88tvVOH2UhwD7/UuFEQMpw9mnoiQQw8Fs22JB8ZNzy6yLQJL0RoVdjjxFT0urW
         XMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726760599; x=1727365399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqsnqwC1PrkCF7/HjaIiyI+sbxed0gBfIuuZtBtDmjg=;
        b=PDZacd66Zg6LbFABzs/W/dSsEW/ZYLJHKL4cevq62ckzTsAeyU2AsoUnWfg4hel8KH
         qyhULZV33FHojCejepjLRfR3c5cCGT8OgwTKeAJWTmgRchz6MASpAxO891afJ+oiozYW
         J4nkkB7nlb88Uou5qhfLUCmteazV1Y9kx3LFUxEVPkPbLqacWykijoAddO8k6IdMFNuH
         9YTdTIIqbtymrIqIwD/+XABP2FS2KzZoZ43ar1UhPgMzhDQBaaDcO/rtStjmVo43P7mJ
         zA23Y3dJRGpIMavDrs4X2CmHQqy4lXtYwmBWXHyU+4EkPJWcq869s3STGADo9WvKuzHd
         4DmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUzMlqhQpFKN93HeAiosTQHUW8CngUUKH8+43jHNnV/kGvOgnUUl8TWHxD26/LpcGu829V8PS4+qlFjCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy592M9Yc6smB384dGhWSmpDtOMVh2PHBG4bzsVg57dHdAdY8rn
	Roo/Hz7mofNTj0bcKZJ+seuQQJ7ycVry01cmIw6WkYq3wBCWXztI
X-Google-Smtp-Source: AGHT+IEtzAZZugx9MhnUBuNtbjUv5qQxpvhuBGZU+xn5Qp/63haEI8WsPefe906nOGC9wba5hdUzhQ==
X-Received: by 2002:a17:903:2452:b0:207:5d33:a1b8 with SMTP id d9443c01a7336-2076e3eab23mr375171115ad.38.1726760598835;
        Thu, 19 Sep 2024 08:43:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794601379sm81323155ad.95.2024.09.19.08.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 08:43:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 19 Sep 2024 08:43:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, irogers@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] perf: Generic hotplug support for a PMU with a scope
Message-ID: <dacb08c6-dc38-4292-93cd-12cdfba3972f@roeck-us.net>
References: <20240802151643.1691631-1-kan.liang@linux.intel.com>
 <20240802151643.1691631-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802151643.1691631-2-kan.liang@linux.intel.com>

On Fri, Aug 02, 2024 at 08:16:37AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The perf subsystem assumes that the counters of a PMU are per-CPU. So
> the user space tool reads a counter from each CPU in the system wide
> mode. However, many PMUs don't have a per-CPU counter. The counter is
> effective for a scope, e.g., a die or a socket. To address this, a
> cpumask is exposed by the kernel driver to restrict to one CPU to stand
> for a specific scope. In case the given CPU is removed,
> the hotplug support has to be implemented for each such driver.
> 
> The codes to support the cpumask and hotplug are very similar.
> - Expose a cpumask into sysfs
> - Pickup another CPU in the same scope if the given CPU is removed.
> - Invoke the perf_pmu_migrate_context() to migrate to a new CPU.
> - In event init, always set the CPU in the cpumask to event->cpu
> 
> Similar duplicated codes are implemented for each such PMU driver. It
> would be good to introduce a generic infrastructure to avoid such
> duplication.
> 
> 5 popular scopes are implemented here, core, die, cluster, pkg, and
> the system-wide. The scope can be set when a PMU is registered. If so, a
> "cpumask" is automatically exposed for the PMU.
> 
> The "cpumask" is from the perf_online_<scope>_mask, which is to track
> the active CPU for each scope. They are set when the first CPU of the
> scope is online via the generic perf hotplug support. When a
> corresponding CPU is removed, the perf_online_<scope>_mask is updated
> accordingly and the PMU will be moved to a new CPU from the same scope
> if possible.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

This patch results in build failures in the mainline kernel.

Building arm:allmodconfig ... failed
Building arm64:allmodconfig ... failed
Building loongarch:allmodconfig ... failed
Building mips:allmodconfig ... failed
Building parisc:allmodconfig ... failed

[ and more ]

--------------
Error log:
kernel/events/core.c: In function 'perf_event_setup_cpumask':
kernel/events/core.c:14012:13: error: the comparison will always evaluate as 'true' for the address of 'thread_sibling' will never be NULL


