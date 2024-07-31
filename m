Return-Path: <linux-kernel+bounces-269875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4506A9437F4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F9E1C244C6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B3816CD09;
	Wed, 31 Jul 2024 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BabB0a/a"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993826EB5C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722461165; cv=none; b=PnMGNcOBhAZoiEf2mEsmnyqgFH10uSvNslwdcUJ1apcOPsiHgzH4Z26HpStL5Eacmm/ZytysLtoI2wjreCSL1ZuTnnhH7il9uXRhuSRe99trDpB9CF06WyHUfqnznYDTDM6j5Hw0S3iIiXnnl41S+T4vD32zBFxLR7NvBDtvwzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722461165; c=relaxed/simple;
	bh=YzqqHah0Kpz3UbF2fztwMnEVk3VdHYrzvKgv3Lijiuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BY9jI3IDEGv55lDimy7YRTMGohwhQaEIckqG//wleGkyWnO/bkdUNDXiwc5EkiBIfpxAg7SC36PuuVUGaVWLMe0Dar7M4QhAZW0n6UiNTw9guF7kHZ2LeK11atobnWnrVx8PzbwL++3Pb3aaboRtCgH4cwKKTWjg2ZoZmZ77j2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BabB0a/a; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc34431so4934082a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722461162; x=1723065962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MGjVAGa4JRMfmw8pQbwqMF8JcxKRovPXiCHMReymGtc=;
        b=BabB0a/aONdksS6sZLDd3WMjgSACJ1gXvlokJFvVIoi+wityWJU6GtiCqB8tzKjU0m
         OL7/FnJ5YAmQMKL8DWw3nyz5t7uZWSMoGVjyMMb274Ew7t7Wat56ix13aB06waoHc0rD
         ROZLAreff1Af06sGG0p9fS8cdAo9l9vlWhkQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722461162; x=1723065962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MGjVAGa4JRMfmw8pQbwqMF8JcxKRovPXiCHMReymGtc=;
        b=d6M6Es9FonasRk2fdQ0LALXolb5NIgdBdSqED5CqDmpxX2A+RbU182QbpmAGBHt1l1
         sTFyGBrW77yGfRk4I8HEdN73ww24ylcI7cmnHmOaGvxJX3fElLz0sFFMGwEIQrGTiWKB
         29dgIVtIYmvWrfgsSCyDWBjZKm6CXWO4rNbb1iiK53fKUrCPLAchTj+TdIPcw1GIH2Nh
         TsOqcsGi9dIp/hrD1pc+jjo+0RxZEfRLOl5yB3W3Pid0iXxcbjymVn6KeB/w/4HIxQCR
         YH3QxvP+otkxZjv1x4271gCr8IENIj1WVjJUemO9z4v6Hmc/Sq8YXrvJRrXKYH4UGIha
         tG3w==
X-Forwarded-Encrypted: i=1; AJvYcCVbfK35+r5wgPxPcJvDq9t/gaQTMdSqseDXbikd1XKUaMxbVzYg/UC74BByPjlNrFHaswlmERKov68XwByBiC0EGOyFIGha7MWzFVK6
X-Gm-Message-State: AOJu0Yy8mJ6OCGSL6KrQE0KMnvKy5N5d7ieLlqx2xcIrTS369oy5IHEJ
	C64vZL7okPFQn5yJQ64S+Dd7IYAZEJOj6gRxQmwHFXuDECvfTmXl7+pPUMIrdZhMrPzl+klOJzW
	zaWPJAg==
X-Google-Smtp-Source: AGHT+IGWi9OZZ6X+LMyAAfX29s6zdMo6Pzv31CB5WoTOeWAcHq/lrvPQPKigVv3Ke3pU98CrOkhXGw==
X-Received: by 2002:a05:6402:125a:b0:58e:2f7c:a9c with SMTP id 4fb4d7f45d1cf-5b7008ae6e3mr285115a12.26.1722461161875;
        Wed, 31 Jul 2024 14:26:01 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b494cd5676sm2738282a12.13.2024.07.31.14.26.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 14:26:01 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a1f9bc80e3so5189876a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:26:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyphzZ+3Cco3DqmbK5vLdytCpTOMhEpCicxIrWWVpk+3Pc6+55DOoKSVV2xJMAYNqg5lkg6fyGr1wrN8Ba2zx2TQ5agt4GabKkbA6r
X-Received: by 2002:a05:6402:a41:b0:5a1:2ce9:f416 with SMTP id
 4fb4d7f45d1cf-5b700f83fc8mr263651a12.37.1722461160632; Wed, 31 Jul 2024
 14:26:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-runtime-constants-refactor-v1-1-90c2c884c3f8@google.com>
In-Reply-To: <20240730-runtime-constants-refactor-v1-1-90c2c884c3f8@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 31 Jul 2024 14:25:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjB621UfJiUBVU+FuiuzL=_Nhv60moO=_2F0YWmRq6+VA@mail.gmail.com>
Message-ID: <CAHk-=wjB621UfJiUBVU+FuiuzL=_Nhv60moO=_2F0YWmRq6+VA@mail.gmail.com>
Subject: Re: [PATCH] runtime constants: move list of constants to vmlinux.lds.h
To: Jann Horn <jannh@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jul 2024 at 13:15, Jann Horn <jannh@google.com> wrote:
>
> Refactor the list of constant variables into a macro.
> This should make it easier to add more constants in the future.

LGTM too.

          Linus

