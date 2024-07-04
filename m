Return-Path: <linux-kernel+bounces-240457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA430926DF0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 05:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84236B214A9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BA21946B;
	Thu,  4 Jul 2024 03:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z4iByv/z"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16691AAD7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 03:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720062724; cv=none; b=aOT32EczGzPq2HJSbymtbq0AlFn2AsR7Y7myp8hM7b+4h6i5NWVjiXfi/JB/8ndwLe+UXswm3YtTVdPxKT1R0j03S/KF2aH5NBctF3BDrfyxCSfYYG4JrQLZw7kgZs+iJrEU2UzVgvww4MbU+DeFzODbxpLZmVETKK0BKuez6N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720062724; c=relaxed/simple;
	bh=/UiwJ7vry61dcxTQxjF50Ei9WLGwz7HSh/uxSqg+XYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7AsXzUAsVHOXNG899TLn+mFORQRZLZ6IQloYI31eUwvZz13hU1BHG+TJVII/UoMEoEdWVDqgDtzso1m4hM4kA3BmlzAiRUmuIk5jqPwQVe+f8KKikj4V7ks0CT9SiDFWcNvjfUDmBdeoGnGutJ63xNwDpLwN66W9GFl25f+lvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z4iByv/z; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-424a3cb87f1so24445e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 20:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720062721; x=1720667521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hnV4ceST/LkaHatjT0/UaxHlRuB0JU9sQidd8Wmj6I=;
        b=Z4iByv/zXiVDuaheyR+bt6aCY8mWaSpcLkxQH2yEocRuAplkyNUg+xmibxIWellg57
         TprFBItVSsGSfJJxafUIdeitftSPMqWxod9ZbgkwRqMibeBqg351ToGXOnq1/tGviLkm
         GfqTmvQnvFlU3bWmYrmzYM8S9ySvw0ItWiUy0QOvP6VZBsEJgdQxMHTtjVeai+sUKrVS
         m8WlQxUwpGi/Vp8lADElhljxhiq32ptYKARnJfXWfr0lRz9NhOPCqOt2hBxWBBOetf2S
         OeRtT0r9Wx4EolbYje2E2Ct+WVWW12HM2faTFPPK46cOyYxio/koiRuZiGSbITZhUBp4
         T1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720062721; x=1720667521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hnV4ceST/LkaHatjT0/UaxHlRuB0JU9sQidd8Wmj6I=;
        b=GDi8ZAJZ/YOvT/Lp74riHo2uQoM4JiZMu6NAKbm+h3K8QMAjQHkjPe/NEhcMLkMA1p
         aXC+b89rMfFDje5t88qeU4scA4wl2d8jAaYiPErlSgc9zqjzebdP6tvJp0jky4isPK5c
         QM3fXiAX1TUnh5Ji1oc/zI9+0l+4CAv+FFMdUXKsuJCeGovl9YRmE7d6cEB1MZT+QXYT
         uuMCFUer+CnObS2wGN/NaqSW6nuYs/q2tc3e4SXUaBq07yg4v0mJiBL1UTPNxrKkzznT
         K5iwKMlIUhxB8zRCOf1j9aATytloSVc7KKAAWfcXiTyVJEoLl88sFomoYxSmlhbAi4mb
         Jg+g==
X-Forwarded-Encrypted: i=1; AJvYcCVGKlUCUkYMMJbBLhHyGdoforg694XNJfVnkuhSSv3fk1vNyBNbBB7DIPOEc4tQ95JZGSXZIJ3Ok0oU3vf8p8wSIpGWSOmM10mqEnE3
X-Gm-Message-State: AOJu0YwsHm2IiEmMSWd3we5lDzYzOxg94tlTv3o8RtHBoMPjvWwD0kWM
	hsO62AJkkCR1gA0IEGvG+/osIJgzsQirKWiUEvN6WUkZLdbhe2qFW6UISnCUoBSZa10v25b4DK+
	oUa2Qksc8o5huQ16y+DfAXAL5yz+KAG8/ijg=
X-Google-Smtp-Source: AGHT+IEuX2Qz/ogfT5gJgXQfb0LHWMxBUBN7AnqQd97K/HY1a2IRM5fhYc2R9zomHzZzKODquS0fRmSqFZrrC30XS4c=
X-Received: by 2002:a05:600c:45c8:b0:422:ff8d:5d25 with SMTP id
 5b1f17b1804b1-42649a552b0mr614825e9.5.1720062720857; Wed, 03 Jul 2024
 20:12:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704024202.84726-1-jhubbard@nvidia.com>
In-Reply-To: <20240704024202.84726-1-jhubbard@nvidia.com>
From: John Stultz <jstultz@google.com>
Date: Wed, 3 Jul 2024 20:11:49 -0700
Message-ID: <CANDhNCpEvPL+b1mve-YJp4+yzQU-BAaAQLr1-G6Br7i83zaQaw@mail.gmail.com>
Subject: Re: [PATCH v3] selftests/timers: remove unused irqcount variable
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Valentin Obst <kernel@valentinobst.de>, 
	linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 7:42=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> When building with clang, via:
>
>     make LLVM=3D1 -C tools/testing/selftest
>
> ...clang warns about an unused irqcount variable. clang is correct: the
> variable is incremented and then ignored.
>
> Fix this by deleting the irqcount variable.
>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Acked-by: John Stultz <jstultz@google.com>

