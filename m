Return-Path: <linux-kernel+bounces-188463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AB98CE250
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E852283058
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC1A128829;
	Fri, 24 May 2024 08:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H+pJCFuf"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D333A29C
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716539329; cv=none; b=mP6RVFoOCpAcBeAONutKcwFrua36kY/rOo+SCiB+uD+jCourf6JFd/bdJ9NPcfVyWbV0L0n+a2wfkqKK/zcj5VaEDoheZhXnH/iXKouHy9qb6uM93nEwyRXs/ITfT2kC8P373VNueM4KYG22EHLEsnkWKTyh16xgKst45CRqSyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716539329; c=relaxed/simple;
	bh=q54jWehm6D0NKJU6RXOGEDssE+ymCHStnW0K2QTOJ1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYzi/qaHFqeI3g3O5LtQbz6a0nsKlYUGE6qKCfp92kqM9BcS+bQHkFD5SfX4Lg4bl2We8FXeHoJusm94qjBb8Ohctza99IMayY4tQgDFJhw0p4rhE+/coOMK+xlptmv3PemsDjPWElGBNrlD+hoX8EwQadHZg90+n0QlfW0armM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H+pJCFuf; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6a919a4bb83so29434696d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 01:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716539327; x=1717144127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q54jWehm6D0NKJU6RXOGEDssE+ymCHStnW0K2QTOJ1I=;
        b=H+pJCFufBaRt+7nosz/HQkpL8/vzmCgAdkDpzwqlVbK0EGBfbEUt3XgpW7U4HEaoS0
         9YTP9TU4FuxFUC4F11dSn5meNEFz7g41/gObKLlYxHLgLvmvPYfAeMk5POsybnFzpxH4
         FrCHjg6eXxFJi+eWc52L9kwZh7oAiwVYalwhg6r4UF4MJb4Ia7iVbhBUPn64gE+whTdK
         yPkTwB1AZA8Spsl5FEqvgRKM8NmEv0j0G/bt47VUI0oSBYMoS8+w8Dkmp0XY5AHAHNqG
         x4KjtMpuW8iuO2L9c5Zlfwm3uM3auwWHdS+O8tmJXc3V6T2BOcZav/ml+g4zs5PYf9Pd
         UYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716539327; x=1717144127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q54jWehm6D0NKJU6RXOGEDssE+ymCHStnW0K2QTOJ1I=;
        b=fmmIE9A4MrCBNr7Fvk5bM3rEFDd3i7bRVy5QZAfyFtLorE6JpmDpsJZGSzVUqC4L3R
         KJWkhzumuHes32hPDpF72IvjqVRhwVFlnrfqiikh5Ur39o2QQyCU//Xnw4g4yyk90wzU
         OD/Y2n8ddN7Hl5LMeQrBHXLFLGKPqOlynDXfvLP2zBYHTKLc+DTcb/dOrQB3IM4QhC0w
         AtL+aBDAeGF6zD3X8HqLxpnfHS7dMk45VzCmCZmLbhWhltJKhKNymca+XfLvMn0Zp78s
         2HepFbfLoSqoTdJVVg6iRbtWtE86XHJILtMBJx7CSgDo1ydjsoOtQ0Mx+tUZSV0nIj0v
         e5vg==
X-Forwarded-Encrypted: i=1; AJvYcCWGdURuLPCC8qt9/jJo4sGu1v/5vywom9xrBPnCrAAMtH5Y6WATWZktQIb5VbkVZrwearsCyZsaCx+eaoebJXLc3bhoW8UyRuCrTUQc
X-Gm-Message-State: AOJu0YzbhzPSEPqZt9oXwGu8C5MhUDQNOw9DmD/DoqqGM6T22NN1ztss
	Ueb+oH+qWwX5dHC1fVMRP0Lrc47R2uCqLotXZM1WcDHo1UgL7mazkEm9kXDVYLcQHsBFC50OQeY
	w1gQDPdlm6nF57BfPWIzA/EQhAelV+jFsNPDA
X-Google-Smtp-Source: AGHT+IHFX6BLG6gStI5mGJe8kD5iHHOGF4/Un66b6V0pmO7shQqI26eQsamvdYGJ3CG+Ua8RPpXvkMXqkHnDAqYCv7M=
X-Received: by 2002:a05:6214:4a86:b0:6ab:710a:d84a with SMTP id
 6a1803df08f44-6abc3e88e06mr16373676d6.23.1716539326544; Fri, 24 May 2024
 01:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523215029.4160518-1-bjohannesmeyer@gmail.com>
In-Reply-To: <20240523215029.4160518-1-bjohannesmeyer@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 24 May 2024 10:28:05 +0200
Message-ID: <CAG_fn=XR6KVQ=DbKZW3kNXsCHgULm2J7i6GCm8CZUjpjuk-d2A@mail.gmail.com>
Subject: Re: [PATCH] x86: kmsan: Fix hook for unaligned accesses
To: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Cc: Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 11:50=E2=80=AFPM Brian Johannesmeyer
<bjohannesmeyer@gmail.com> wrote:
>
> When called with a 'from' that is not 4-byte-aligned,
> string_memcpy_fromio() calls the movs() macro to copy the first few bytes=
,
> so that 'from' becomes 4-byte-aligned before calling rep_movs(). This
> movs() macro modifies 'to', and the subsequent line modifies 'n'.
>
> As a result, on unaligned accesses, kmsan_unpoison_memory() uses the
> updated (aligned) values of 'to' and 'n'. Hence, it does not unpoison the
> entire region.
>
> This patch saves the original values of 'to' and 'n', and passes those to
> kmsan_unpoison_memory(), so that the entire region is unpoisoned.

Nice catch! Does it fix any known bugs?

> Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

