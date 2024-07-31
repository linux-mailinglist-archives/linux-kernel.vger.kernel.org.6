Return-Path: <linux-kernel+bounces-269499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCB5943385
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8781C21EF2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7734A1BBBEE;
	Wed, 31 Jul 2024 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="hxtbbpEN"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9971BB6B2
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722440522; cv=none; b=IiWGGQtuTQmXGcPSluxgDP2EAoihUZQ9rjylqt+i8890x8q0x+fjGrapMtNAvfG4tWuxWdobNuxPMh97MZ0qqheK6sgOstbl8fOOx181pJ4xrBJ3f8m/B7BuA7qrS0L/WNoAjGWS2Dv2CwHBENBTKWccMO7+h1Es+p41MQqHLEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722440522; c=relaxed/simple;
	bh=v5vaRlpTTd21X7XtxD7BVDxM5CtrMc34R7AxFqKMdcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiYI2ugnLs5Bg4YE48wm2PbIZ1on4hpEWfDINsbL64qB2Qvan2JGvD2dJtSuA1FexIel1ps7S8UXZ/TMLkMCMQYtFRwplrO72yj169MqHB3FZp83Kjve12VoIzplMyEz32qEHr3MZh2zuxqHmFWCYEDn/Eap0LhaPP2Uwo8DG9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=hxtbbpEN; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7d89bb07e7so264214866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722440519; x=1723045319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UYT2Cc0DbDwz0EHSJcGoeWCUyU6S/hmw9Y4vANMOf9c=;
        b=hxtbbpENYvcRgcLOLNUO2/KLHrc2ar4y25zbjldojDRo0RktvL76BJSE4IfodtpuN+
         Ub9nhi456AdqYb9FFk1qMoVk9dA3eqBgHprxzhySP++meCDsFOON5QaQC5lav4663lTs
         hdA652uV1KEq/18jRX8HtaY84TcIUD90L12QDjo0t6FlyQsUpB7u5K8x/F11MhFLzFIH
         pZp0AOzWwacizXnAXkRxWv7rRQijc3KEi7PuBRNO2RpiI1+hr2qqyaptIm/UO4zgehpc
         XQhqsIV48b1Zbayi0dkusZIgS8GvNh4kkV1U3FUMEL6t8PbnKK2oSDu+zawrnZSMLJY9
         4cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722440519; x=1723045319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYT2Cc0DbDwz0EHSJcGoeWCUyU6S/hmw9Y4vANMOf9c=;
        b=U1DV6UlUesBViaFDyPWyxaSbho5Z9taOcOjGtpguG2zEpvELG+NfXrzuJg5Ua1AMp0
         v0w3V3L/YmMD2xnt/Sds51lDQ26CXMFAFhura/2Xv71YxzNyH4mPIyPCY/rbxH0KoVyH
         bZKjp0qqksH6sY0IhOs5XwKkOGiwZvQg8q8+vA7OfTXbIdnQAOm/pM2qVmbGXyroIrS8
         NrESF6IgeQ2PqIiucNj4YaE8oNwmzx6ibmPCZCODOrC+X2ra7UnwbdiVsXJT44OiADL9
         ndWAZpl6TC4Mey5jJRnzZxa/oWAaHp9fYWOngnr6B6fbsbasGmwnZHLSA5Yz1sfl+Tcq
         sKiA==
X-Forwarded-Encrypted: i=1; AJvYcCXyvXJRwkKkBojZGN2+ABKOIf3dm8oZHKhAnMQehd8u56mfzKA71ZCMZe+izL9dmIH9TkBhSKCiklCXkaOYKhTPmGCAjMD+mgKXXmIF
X-Gm-Message-State: AOJu0YydMjpzP4zdR+FsWmqIqXnZ7vCEGeTBoAX7sISVDYhR2fcK/8mA
	Olfc8pLC55Q0O0Nu+Wy3jB5ghljFNQYJre65gByJG/XLjm9uyMy9NvTT+stGA8o=
X-Google-Smtp-Source: AGHT+IEBk2d0ul2kTsNJSlKbs/TvRwodD3XnxLeAClb0/bTlm8Fcz5PpHV1kex7uf9VNsTgb5Tg1BA==
X-Received: by 2002:a17:907:728c:b0:a7a:a892:8e0b with SMTP id a640c23a62f3a-a7d40015a95mr1067366266b.19.1722440518929;
        Wed, 31 Jul 2024 08:41:58 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb82f2sm784530866b.204.2024.07.31.08.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 08:41:58 -0700 (PDT)
Date: Wed, 31 Jul 2024 17:41:57 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v4 07/13] riscv: Implement arch_cmpxchg128() using Zacas
Message-ID: <20240731-98a368a296fa83a2e8ff8bec@orel>
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-8-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731072405.197046-8-alexghiti@rivosinc.com>

On Wed, Jul 31, 2024 at 09:23:59AM GMT, Alexandre Ghiti wrote:
> Now that Zacas is supported in the kernel, let's use the double word
> atomic version of amocas to improve the SLUB allocator.
> 
> Note that we have to select fixed registers, otherwise gcc fails to pick
> even registers and then produces a reserved encoding which fails to
> assemble.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/Kconfig               |  1 +
>  arch/riscv/include/asm/cmpxchg.h | 38 ++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

