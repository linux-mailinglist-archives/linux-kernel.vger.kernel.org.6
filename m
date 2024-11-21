Return-Path: <linux-kernel+bounces-417057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2462C9D4E61
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37FD1F230A8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A6F1D9A60;
	Thu, 21 Nov 2024 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LYs+IO1a"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC0B1D9A79
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732198340; cv=none; b=fb5CSb/UPUThZvgAx4CM9uxSWFOBrJhYhZYOgO7MBlT6aTiDZn7ooaMXoPBdg49B77TQFMFZUrcOACnXqixaVEy4RfYHMLJOhKMBdbBDTvyfAW6k6xyvKo9efCEcpeXXfJ17Y3WtBkjnOA4fEtvzqnI/dFOXgyknpvB5UF1mDsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732198340; c=relaxed/simple;
	bh=aivyQMPMYdcek9UTr2/mGQTkOks6tzNJ0DhZj1hoM3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HO7CI8Z2ZFwojJpQ4KMD/eOciGLMp65OEUGh1WwDmIl/5z0BH5kYXBxADUeXYCwD+tH/giJZ5maHbApQ3XoAiNE81G0G3UA3gfTo21MphKfebHTL9eCFtXF9q7n9XOl9uugA0WuAdjcgUlIH50Zomr+lFFbn4jpCatlfWkcZCV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LYs+IO1a; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e52582cf8so721719b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 06:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732198337; x=1732803137; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aivyQMPMYdcek9UTr2/mGQTkOks6tzNJ0DhZj1hoM3k=;
        b=LYs+IO1aHkjsRsj3dE8vV59MtzSsAGARrPROOiosyZaAMqASUU6IVppSSLsAFyoWWX
         V7Y62n3JI329Bd3h5m4V5tRcIzu/nvGXzaANJnaOkSS6ZdHTZqPSvUhpUqgN8WuIZy24
         WjxYD+N0B9VM6i3sVKEzLf57Isc34ksvRCcLMhCgAkKzDFXIebuVNstfWhipVc8owjQ5
         NERQgE9AHhC2i07e8v4D7WRcFSCCmVVh+FpMdt/H07NwTotbPBWjNBK8B49rAHc+5Lo2
         j1jB/x3D+EoBLDRa6rPlYhkRMhrhTrBrVaav36DCZoVsGswwQFnhFbPInvIKIa+4UMBi
         ulrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732198337; x=1732803137;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aivyQMPMYdcek9UTr2/mGQTkOks6tzNJ0DhZj1hoM3k=;
        b=S94EZiR3WDfzZeUJSY9njXyMPyY/b/Ma0F4dfFR7JtL25EmI0TQZ6d0siZJrCXs0am
         li7U3qnap0NKldVs5x4wLcgqeJp1jcctPa4CNIHtmiMBtD53qiJtVf5j61L4xkNt6hfx
         iU0QOenoQsxoukYdnUZTam4a7ClmaQzId2rW5GSgSYCsAffn2EKVJR0k9Lrkr73cf89k
         vvRygrUa4+VQo4qbfcQks3+U2wLc5MB6+lVY1hx2HqKT4qO1cjVxuS80saz/2z8L70xl
         AQ9aUqC7UOgly8exYrEAG8QwYmViDe+VgyaqLDGVtvzSPNtbJJuI1vYPlDoD4vqCNUs4
         qkig==
X-Forwarded-Encrypted: i=1; AJvYcCU17voZhZlCxYzlFsYaRQcP+GpRbdAb73TrsI0labRgx+Hysn+1BxBcMtmcVDhJvARoe8ra5yJzTmGX+3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyacbWWOhBxx54qCrUcS14nFG32KvIbInGisSDC/JoqghSCl1MS
	x5XIiyxhAdaz8Ztb6TI2+c47IRnRCwzuB/79gLmdDJJ4yfJl6i4PWpj8xLBaFvltVUH5rNN+Eqq
	2Ni14AicrxnLrfgp7bycqncNWcIGjJdIKf7zR+3DHXIkd1ejF2n8YxKc=
X-Gm-Gg: ASbGncvF2mprEYa0s2ikV6HEhV8ZO1I/arglx/M/JGhmw7dVQhmpBzwtLil+MMB2BYy
	Sh90oouzPecNNjD2UE2kZIi9vAoD7pW1uweCJsrValM5IRqOcmA7DwUDNniqyMQ==
X-Google-Smtp-Source: AGHT+IHnYhZchWKMQsLu+PnTBmaqKW/BOReT6edPrO3vxVwp2BUIJhC3zr6Az54KvgMXXMeJwCRqTFfKp2UHdg62zWc=
X-Received: by 2002:a05:6a00:cc7:b0:724:5815:5e62 with SMTP id
 d2e1a72fcca58-724beca4220mr10479357b3a.8.1732198337134; Thu, 21 Nov 2024
 06:12:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121135834.103015-1-andriy.shevchenko@linux.intel.com> <CANpmjNNzFykVmjM+P_1JWc=39cf7LPuYsp0ds0_HQBCzR+xOvQ@mail.gmail.com>
In-Reply-To: <CANpmjNNzFykVmjM+P_1JWc=39cf7LPuYsp0ds0_HQBCzR+xOvQ@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Thu, 21 Nov 2024 15:11:41 +0100
Message-ID: <CANpmjNO8CRXPxBDFVa5XLYpPuU8Zof=7uvUam9ZFVPP9j8+TEQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] kcsan: debugfs: Use krealloc_array() to replace krealloc()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Nov 2024 at 15:04, Marco Elver <elver@google.com> wrote:
>
> On Thu, 21 Nov 2024 at 14:58, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Use krealloc_array() to replace krealloc() with multiplication.
> > krealloc_array() has multiply overflow check, which will be safer.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Reviewed-by: Marco Elver <elver@google.com>

Unreview.

> Do you have a tree to take this through? Otherwise I'll take it.

Whoops. We got rid of that krealloc() in 59458fa4ddb4 ("kcsan: Turn
report_filterlist_lock into a raw_spinlock"). And the replacement
kmalloc() is already a kmalloc_array(). I suppose this patch is
therefore obsolete.

