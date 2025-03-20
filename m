Return-Path: <linux-kernel+bounces-569978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E545A6AA65
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C019E485866
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34081EDA06;
	Thu, 20 Mar 2025 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PFPfBrxQ"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A90D1EC013
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486124; cv=none; b=CHpUC16pxvCuITWHInjdhB7G3xW9rAtKjULtSm0ut5Gj8k3JmzvQxcfhJDr1GK87wsRITAdfvPbqkU18O0SP9fmXIcm4O2xXWBX4vHpQPED3JTwSbEsMdec5ypeHzUfSjS6PJcFGhHrCHm0xgMPswzqaxMYgqX6E7aRVq1ek6O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486124; c=relaxed/simple;
	bh=HJtqYAcwATaJYemmG3x2qLIknVjNk1biuCODLgnKDjI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J78US0+hf5fuq/Df90PpTgayUSH1Y8eq+uFHXDGy4EA5aZNJO38XgyExU22vg5UsggDrLkp0DyiYwe7F6Kwn5NTsT1+EPdsedx3YxCweWaRvINOUMbm2du2mtaBB6fsLxxCZGCgzxrTT3QmCd+cA1ErM0n591X8dBlT6Y4K5uZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PFPfBrxQ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d01024089so6955695e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742486121; x=1743090921; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vcc0p+m6ptiz1K0U14vYh5p8Vi322BofjVMo05sdNMM=;
        b=PFPfBrxQ4yAC5NsD7cj8jKS7W3+km6ucGUjawCVICRsgpjUbRQNGNt6qg+0V5edhJ1
         9kYNrB6xNeOzZdqXqW/jT/A3XrAi+pD+WpYcKiOXls3KM58wXk4U/nZwjBHOc8Jr7ZM2
         wdXiHA9v0riHzg/huH4FTSMHE0cN5vMNJ7z2VbCpX+aL61i8u2xp/bL+kYcrvZyoP/Qv
         Ar3QnC2XoSx/LdaXNDLq8mLmeyJENfcENfWWpUsoFTIfCHgnopXXD0qLfXsAu31WI/rj
         blrbzI4AYIn5R1LhbR8bh6o5Rka2wXkmLSOaGWnr3KjCArMC/IjDn1Dyn1+3gsJK5gnX
         M3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742486121; x=1743090921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vcc0p+m6ptiz1K0U14vYh5p8Vi322BofjVMo05sdNMM=;
        b=XJGEunABdrDxGpdQPeaT+nwq1gCRD4IjZ8dTRQIPIsrj1Xa/oo4QTu+l50t7giT4AF
         Y1iGsmjdqzJBivljGN7weE6xITD2830+/OZRrTTALGuRqfcpXEUq/scSPrFM9H6SSNbW
         LpLmTLk54Aj+lVxORqyw3Jj3jvP7HtdqyG0Anff+G8gFbZyn3+rjYeQ/fWrAEzm+AA62
         qfDuKfHjzxpfWcPi++nFV2NTXeEUDVCezsjAEevNabM5DU2IcyWa0OvO/INxUgaihTBh
         zxfZIc9eMWaKAZTKA6evLOJil0VToQeMpfrLE8hfYXdmBbskbBknAUuatEnIERiMu+Gi
         Briw==
X-Forwarded-Encrypted: i=1; AJvYcCXWimEC7x/WfvJTT9bk0z6qBmu78xYRryFGe/TF/z1EOAoqpT5t4QzBSIeJHPtSy7036okTT8S4xFZuT6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL7oWrivObtQpAzqDTyImcqzLy2QQbeJX1XLhRJiPiU8T7zY4x
	Xr5/nC8qKiT/TFJvIdUSiDgVgVZSiBBP20VictxsGQqkyy9cGJtvYSdKxWaQgZdUUamHx4Dj5Qv
	BcY5xB/tnXg==
X-Google-Smtp-Source: AGHT+IEOByC6pEoxVmRfYb9u/TzapHyajZ5rs3x/xhPHpW7ZWckNMUPvZfQzvFAPdcBAY1ySv9n0piLX7/zoPg==
X-Received: from wmbeq10.prod.google.com ([2002:a05:600c:848a:b0:43c:ef7b:ffac])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3845:b0:43c:f969:13c0 with SMTP id 5b1f17b1804b1-43d438a66afmr75908535e9.29.1742486121041;
 Thu, 20 Mar 2025 08:55:21 -0700 (PDT)
Date: Thu, 20 Mar 2025 15:55:19 +0000
In-Reply-To: <20250110-asi-rfc-v2-v2-25-8419288bc805@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com> <20250110-asi-rfc-v2-v2-25-8419288bc805@google.com>
X-Mailer: aerc 0.18.2
Message-ID: <D8L7S0DIVJ9K.1DJSDD0RIJAEV@google.com>
Subject: Re: [PATCH RFC v2 25/29] mm: asi: Restricted execution fore
 bare-metal processes
From: Brendan Jackman <jackmanb@google.com>
To: Brendan Jackman <jackmanb@google.com>
Cc: <x86@kernel.org>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

On Fri Jan 10, 2025 at 6:40 PM UTC, Brendan Jackman wrote:
>  noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
> diff --git a/kernel/fork.c b/kernel/fork.c
> index bb73758790d08112265d398b16902ff9a4c2b8fe..54068d2415939b92409ca8a45111176783c6acbd 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -917,6 +917,7 @@ void __mmdrop(struct mm_struct *mm)
>  	/* Ensure no CPUs are using this as their lazy tlb mm */
>  	cleanup_lazy_tlbs(mm);
>  
> +	asi_destroy_userspace(mm);

We can't do this here, it takes a mutex.

The lifecycle of struct asi needs to be reworked anyway as Yosry discussed here:

https://lore.kernel.org/linux-kernel/Z9sRQ0cK0rupEiT-@google.com/

