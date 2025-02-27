Return-Path: <linux-kernel+bounces-536380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C7DA47EF3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CFFA179274
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0213E22F38E;
	Thu, 27 Feb 2025 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cmo0FOmm"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF9422D4F4
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662448; cv=none; b=KOCPimC1BRA0O+OUKdfO4w8oBd/bXN3eyXxH0ySZ8tWzL7jqz72nDaA6/xQ6iql0hzwxoBf0i0ntpQhLRJp/1o6CVVHjv+g3+4EfAg3bNWEv1FLJgCNuR0BK34aa57HXbM2+CoJruW4Mhh485fkXdO+Md99+7DP9wEKnbdARqcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662448; c=relaxed/simple;
	bh=4B317E33tuHgdv4ZtlRKJE7smFPGAFVLSWP8bLWNHVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UL9pfmpNrDXOALSqUiSA6pURioxse1YndOsEHWL3VTDTUlbSinnhRJkRxmqElCOUYS4X8i2HvmJl09VNOQclY+VSk11PjysnRS0ZN+fRT9E+9CHvQy4dVz/j0FuoLs6QCNMm3QHKwe//aSyHqG1jofSxaGe3tKFLVkRiyicQJXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Cmo0FOmm; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-222e8d07dc6so17063035ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740662446; x=1741267246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k0X5NRD7qbqiDiJP/6CHajV83B5iot3wBBgQ9wxynos=;
        b=Cmo0FOmm42yJEi9XFzkGwBoGSwAGvjXWT7PItoxoSvf/CWwj/hs7HvzAIcNzhBihJJ
         zN6vyVkPrp9f3xuaVWdhF/32UfbWvPbgZYyAw+upICHXliMcJgILlp+D/oRe3GVNAJRM
         o7FBPj89rynq1obKomR88CMQVstInnJNi47yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740662446; x=1741267246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0X5NRD7qbqiDiJP/6CHajV83B5iot3wBBgQ9wxynos=;
        b=mltZhb9ngAzsLB6k/qqDZmxqDiu/kIdlgQ3fnkOsMe6L1xZkEbuAS5PcbPmUSQoOsH
         RriwNicPkoeXCcSnzzTCIex9nrU1M5Mm4NFVYlaa8Sq03Z4hYg4DbcrSmr9EuxB6tIDf
         nkf+8wy74dak3S3cYjdMPUJrLumDDLtApz9+SqXQdEusxDnZQFqsowlRbWW6TW/kxQSY
         +3MiNAHjdd528xRK9kBOqeUG+oJGc9eQJiPOPNgqfqii5dUXYu3pGwbEYqvxti+tvGAH
         LV0zkxGyDK2VUTUvVbaUUwHhyjoOamScOgmVKLwzg/5IWt45KDrgTFLhagxIVHzel6DE
         pp/A==
X-Forwarded-Encrypted: i=1; AJvYcCXU9FOAx8+z70pwo1AXsbiRQdEfc9FRf0g4jzUrR/8BvhDoU4iphlFbbu29KvlpYok5wXymg2byUTcQQAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyADSLGcNDFeyCucF72IqAqdz6K/l8tC2EXHTG40/3eJzUYIee
	Bcjd30Jn1+2em2a30sqnh3F0V1DHm/DWzD/1lF+BRMGQlyEKFqf4wyZSPHZprg==
X-Gm-Gg: ASbGncsEOxsEOkdaFFCRKqzry1bqWHF3zYwlcIfbxgDD/FIGYhDnP/rvc7WHKoDY4/o
	aO1DoOc97AIR5xEBqDfH/AstzZHtNGv6Aet9WXDCfV2tPqW7ExOu3Xj3ypxRAqVuJxcv7kVMpQV
	4fRStlM56s2761sivsayxAorXHC9l8ful+0JW/GonBkOdU1Xo/WDceaInHqp7+onNv+cqhA3tC7
	gB3zcYVjetbj7FEDXKrQxn/ubr7LzrTiKA07AssYf5w/hkru+erHQShrbNS+ZPH6ZBq6Rcwt4Xd
	OoQyUuQ6zgrAodXHtN8SYEDx/a7Lug==
X-Google-Smtp-Source: AGHT+IG++fNxUGLMn5iiBI3kkDvuQHaieV5JWml7A7GasfzSnf9frDmJlQk1q3iU9FLDaJxew95ddA==
X-Received: by 2002:a17:903:1984:b0:221:751f:cfbe with SMTP id d9443c01a7336-2234ad4e189mr61357585ad.19.1740662446124;
        Thu, 27 Feb 2025 05:20:46 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:a9c0:1bc1:74e3:3e31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fae29sm13965295ad.95.2025.02.27.05.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 05:20:45 -0800 (PST)
Date: Thu, 27 Feb 2025 22:20:39 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Hillf Danton <hdanton@sina.com>, Kairui Song <ryncsn@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 01/17] zram: sleepable entry locking
Message-ID: <toahcdrrcijxi5atfblz5q6o47j4mbkpe2lpvbbp5yczsdj6j2@2lbc43nhdbgt>
References: <20250221222958.2225035-1-senozhatsky@chromium.org>
 <20250221222958.2225035-2-senozhatsky@chromium.org>
 <20250224081956.knanS8L_@linutronix.de>
 <i2kgeeehfwzwo22vazakcq4at2m223nebb2xfrqfvsgawpmqya@zjhqhjshvhi3>
 <20250227120532.OsZr4v2A@linutronix.de>
 <irpjhnu7utkhf4dds5ghklsbdug6nf32ulsp52ibvym6t3wqfg@pqu7w6uvgbvw>
 <mwpl64zfj4zlv5bwysfzryjpnh6lg5tridhya3t7ly2ax2vt7x@jhmdmh7gwrmn>
 <20250227131253.T_S_Icyt@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227131253.T_S_Icyt@linutronix.de>

On (25/02/27 14:12), Sebastian Andrzej Siewior wrote:
> > > I see.  I thought that they key was "shared" between zram meta table
> > > entries because the key is per-zram device, which sort of made sense
> > > (we can have different zram devices in a system - one swap, a bunch
> > > mounted with various file-systems on them).
> 
> Yes. So usually you do spin_lock_init() and this creates a key at _this_
> very position. So every lock initialized at this position shares the
> same class/ the same pattern.
> 
> > So the lock class is registered dynamically for each zram device
> > 
> > zram_add()
> > 	lockdep_register_key(&zram->lock_class);
> > 
> > and then we use that zram->lock_class to init zram->table entries.
> > 
> > We unregister the lock_class during each zram device destruction
> > 
> > zram_remove()
> > 	lockdep_unregister_key(&zram->lock_class);
> > 
> > Does this still put zram->table entries into different lock classes?
> 
> You shouldn't need to register and unregister the lock_class. What you
> do should match for instance j_trans_commit_map in fs/jbd2/journal.c or
> __key in include/linux/rhashtable.h & lib/rhashtable.c.

I see, thank you.

Let me try static keys then (in zram and in zsmalloc).  Will need
a day or two to re-run the tests, and then will send out an updated
series.

