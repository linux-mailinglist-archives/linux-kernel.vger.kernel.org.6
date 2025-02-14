Return-Path: <linux-kernel+bounces-515646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB34FA3673D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D29716CC78
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 21:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B821DACA7;
	Fri, 14 Feb 2025 21:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CfkFnYqS"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B3F1DB125
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 21:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739567280; cv=none; b=nKEioNm0U3KTysen28c2JJEQF3FUZa3vxZuSgdzpcFBxb3FJNr0FwKDYrTAkNE4j33ewjfgzNOYQNzeDKxjoGUVqisECYq2J/AuI+wPRI06A89FZhD/+Cr4wZjSoyrAEXljCVP/8bfkpucafIDAS3qor6df3Vwcywizid7xJZlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739567280; c=relaxed/simple;
	bh=cTD0YGxM7C/r8VmscZOvQcLrBnZIJ/Bl8PiAHhMhK5s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DI46sG/VLaip52S9tWTGAn1+rOxQRSekPPztme1u8CS83zGTJ2D8g/ej0Zw0HubU/BNHIvDQQb4uujJP4JjHf9I5z9gxFkTp7/ldVYVWLk6MvOynVt3Tfrk8x8L9aKY7/SH8Pd4vUL0hLRuJTnUzUdE+dbGCu7dqJtM3Q7tVL7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CfkFnYqS; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220ee2e7746so23260785ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739567278; x=1740172078; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fK9Grk2+mxUxJmbNSyLNP4j/EN3bbR5J+pxd4ldMHvY=;
        b=CfkFnYqSuxjoUgaDCgJA2MIXe+8G9DbmV7yG8Jsu4YXkiJVTBCkObzvBjJYf6fRu0o
         9ow4ZgkFRLH8JaGTytYkb9a1Zc52JSB8Zxrs/byGBGO7GJFg4kjcI7QlUoDttbySGUrX
         jvgW98GeozYwa8671Ks1yTb6PGihFZsltsg0lVArp6W+OXDGtLZaBI9YZ3eXfGvlV2ow
         azFsljwdQdJJc2kot0GXCF4jv8fX5A5mACffAZlDtNTs/auVJ3oZnDuPBcDWUzg1+9IP
         LfsEFrHcDx788Tv8gcxkbKePH05kSIVbgcXuC1u/X5mpqsHdmOHBG5rf0PcuLyhM1OsO
         +zAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739567278; x=1740172078;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fK9Grk2+mxUxJmbNSyLNP4j/EN3bbR5J+pxd4ldMHvY=;
        b=LUpdf+mZ+W60pWhJQcsVALGNhrIMvJQLFUxDN+SL5ycOZLSNnTY3GeaQgG2l2hqE/R
         9PwG2CY6NQXPvXFUBtr8JvN66UtXM8jaYkTAWO8UxhDn+KvMmEq0FP6eB9Lna3jjHEjA
         bPd2E/loaXO59X8Gxpx/j7qwky8dujUmp72zwqbntfFJKmjtKyXZa7aON8RD6SI4u/N5
         Qx2xD+/lbib4fGImNy0ULgfIn5WiNkwVedQwBR9/T0ErOA3tnxkRc5Zz+njJpMyCHb0J
         +7jwXNfqLu5PhVz13kEAK3LRgzagUqTSKExohhZZVgjAILBiPg9PX/v88ySBCWsbURP/
         G/KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf+L02BDP3Q2Oa3AnuEgDPG4h5/VaCR9CVKyHkQbShcRcKdkhhN4hSAT6t83065NRQ0DRv+J2hNgdye1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyklpHIujXZboe3uOGDw86WuW7JOu/yWC4Oc+CPORrnUxTFiMo+
	S7xljKL66clnioihm8LApisCQpPpxH99rDDCJufkw2w9g4DX9fagPPE38+KcB0MpxfHZxdxjTG/
	j0w==
X-Google-Smtp-Source: AGHT+IEB9kfMbLqDRiIWrvbRpSDJvL2ukP7ELBGl34NRPGn22tun5wCq6W7V3vW6ase9xSQ5LQ5KsjA0YD0=
X-Received: from pfbga8.prod.google.com ([2002:a05:6a00:6208:b0:725:e4b6:901f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:394b:b0:1ee:1af5:86a9
 with SMTP id adf61e73a8af0-1ee8cb17bbcmr2046257637.22.1739567278334; Fri, 14
 Feb 2025 13:07:58 -0800 (PST)
Date: Fri, 14 Feb 2025 13:07:57 -0800
In-Reply-To: <20240914101728.33148-9-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240914101728.33148-1-dapeng1.mi@linux.intel.com> <20240914101728.33148-9-dapeng1.mi@linux.intel.com>
Message-ID: <Z6-wrVaVSiI9ZKkD@google.com>
Subject: Re: [kvm-unit-tests patch v6 08/18] x86: pmu: Fix cycles event
 validation failure
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Like Xu <like.xu.linux@gmail.com>, Jinrong Liang <cloudliang@tencent.com>, 
	Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, Sep 14, 2024, Dapeng Mi wrote:
> +static void warm_up(void)
> +{
> +	int i = 8;
> +
> +	/*
> +	 * Since cycles event is always run as the first event, there would be
> +	 * a warm-up state to warm up the cache, it leads to the measured cycles
> +	 * value may exceed the pre-defined cycles upper boundary and cause
> +	 * false positive. To avoid this, introduce an warm-up state before
> +	 * the real verification.
> +	 */
> +	while (i--)
> +		loop();

Use a for-loop.

> +}
> +
>  static void check_counters(void)
>  {
>  	if (is_fep_available())
>  		check_emulated_instr();
>  
> +	warm_up();
>  	check_gp_counters();
>  	check_fixed_counters();
>  	check_rdpmc();
> -- 
> 2.40.1
> 

