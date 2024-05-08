Return-Path: <linux-kernel+bounces-173828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE388C060D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14AC4B2298E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5E614A9F;
	Wed,  8 May 2024 21:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NKzU9+SN"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2466612C497
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715202603; cv=none; b=TPzaSDN++oDN/Vb4HxVnbrIAEu52Go8waRj1mMleb4T/XQVzjkIB+B/3f92a/UivqWmnkdxw6Qsd8J/K1GCmJwINC8jbG84PwsVkpMZknMW3NcnW74TyFFUFdX4EgKZn0xa/CWS+fchbFLyCSYxV1dQbRUgT02F/qknFzU9Hu5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715202603; c=relaxed/simple;
	bh=vFL4B3wK6V0zyeCGMUE/eo8ppygLhYYUWQCOaznNGKA=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6Ye5T1a4qkR2a7POL09PID9E1K1umfUVxNWM4oH8gL+JXesiijUVXQIVtEt58OOztCiRrOPVdf6ZOE5tNCQf0E9+r/YAVQlMmWhsU3zRHSk/zTNKXJ3JS51F4D9x2ppQsISQ4J67H+PqQX096s6zEtyLnOvS3/EsZiDo3IIqS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NKzU9+SN; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c97a485733so151795b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 14:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715202601; x=1715807401; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=malKjFparRZHby6p2gcvIikID9eemr65ODf87siiN6w=;
        b=NKzU9+SNHU4gmkfECNrn+IB9sOoXSd4NtcHgBrmp+w2E2ynUDHqRVS/FaGLIPaEt7e
         wS+uFPZAepuSK4ldrMU2CrhXGDNuDPxFn6bBOEIpoq6ylGyxuDDK402Jy6Xa+07XVwZS
         bRQgd0aaOjXzg0sQlp67b0n+PAtyFq4sRMWlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715202601; x=1715807401;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=malKjFparRZHby6p2gcvIikID9eemr65ODf87siiN6w=;
        b=oFAuQXE/CUaxh4PnUt1mFxT4w71shvsQngNE2bd+F0b5J8x1KzV6uLevPDsrHMBO6g
         YdlUCjMjoldmtXaDLUIuHS1AQVZzozauBk/uO1vxzP9OOJ9JtDnxu70ekCScPqeRO6OD
         SPDve5A26Tly/D8qKhxNOOgDziUpt+RaYb2YlleH1YbOHFrLdLARPPxyynz1t2U5CrJq
         WRQ6GsLP2u7DxJoVsCu41S8uwWFBwRg4RAvkm5p0AzZ2NJzki3TN2rX4V2s7gboq52JA
         bTNA7h6edqsVXxyihgMBOeWsfZhQvnTrNMcYYq8OHxIhR/+iLpk8g0RMTOvqbrDu2mH3
         m31g==
X-Forwarded-Encrypted: i=1; AJvYcCWYua36W28/C32eDC3DJDAoy5DhNzdwyu0JZOTu0WKr1rITsnGZ6GE/VLW6lWJigNOYWk6s42dw7z4DAOc3n/BQMflDCHJx8oJWFBx1
X-Gm-Message-State: AOJu0Yx+dubvzYKG7ZJ/nUixw/uVMsU3VZsG/bqwIsdeqQyKjImt4ifP
	z9Ro2T+b0DzTSTcsBo0bWFwYA5RzGhH/SHVgG2NcqSHCNZRtLfq8KPLVELInMO4/L2oB+jD6nmA
	+mrhERU43K+cRuAdbgcKuO9pD4c3IB4QGBAh5ty2K2BndVWo=
X-Google-Smtp-Source: AGHT+IEdt693kG5CsvJhhJKxEwutqN4U04lOEMxarSx84uS+eZ/8glpfYJEhQ71dRPpHXu+PbW6nNTnvO6fe3wEXqgw=
X-Received: by 2002:a54:4604:0:b0:3c9:6cfb:bf4e with SMTP id
 5614622812f47-3c9852927aamr4063549b6e.7.1715202601233; Wed, 08 May 2024
 14:10:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 May 2024 17:10:00 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240503171847.68267-1-puranjay@kernel.org>
References: <20240503171847.68267-1-puranjay@kernel.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 8 May 2024 17:10:00 -0400
Message-ID: <CAE-0n50Pcmjq7b3F7OiU066FR3vk9avU22H0OEcoGcbGVd14dw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] arm64/arch_timer: include <linux/percpu.h>
To: Catalin Marinas <catalin.marinas@arm.com>, Douglas Anderson <dianders@chromium.org>, 
	Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Content-Type: text/plain; charset="UTF-8"

Quoting Puranjay Mohan (2024-05-03 10:18:46)
> arch_timer.h includes linux/smp.h since the commit:
>
>   6acc71ccac7187fc ("arm64: arch_timer: Allows a CPU-specific erratum to only affect a subset of CPUs")
>
> It was included to use DEFINE_PER_CPU(), etc. But It should have
> included <linux/percpu.h> rather than <linux/smp.h>. It worked because
> smp.h includes percpu.h.
>
> The next commit will remove percpu.h from smp.h and it will break this
> usage.
>
> Explicitly include percpu.h and remove smp.h
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

