Return-Path: <linux-kernel+bounces-263765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FC993DA42
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61E21F24148
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B4414A09A;
	Fri, 26 Jul 2024 21:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BEMQLpsx"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDC928DCC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722030489; cv=none; b=uZ+zcEzPEcTQFiK28lww+opn1ZgD43w3uHmeDpUlloV1nwzPYqDnvP4bHMmaZ2MoqqYUP9ySJH3U3O/Ip0LxbkFZE3TA4Sh83KKb7rL40vJS5ieiXvablpCwaMNv7XmpvwGc1JcBv3dLEi6afCHy/8M9pSJO4nKWUh3gJDnHtXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722030489; c=relaxed/simple;
	bh=+NEXPdLEYbaVxyaWs1Jns90v/Q9HGvkbAb9KiTOPDtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6X3CmUgL1EYHbooyMTfI4Z/aGO9Z8V64QZJ7jo0FLarszdBRNK1Ubav/fb7rg8/l2VxlwBOe87J8AEiVmuhKY+3rwCwOemmLnruWrdEhQ1M82B8aEvfxuxq8GZum22XiW6lBCcxPshfkpb9ZRkmHcZT1FIiuHa5iwoLAEnd3w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BEMQLpsx; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52ed9b802ceso2144886e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722030485; x=1722635285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pKuq6rb4iJjs6ClolIl+rhXCF6batvvgHN1Egz6YFgs=;
        b=BEMQLpsx4q9eJZmBNDY5yZtuKE0nOFOoiLmHC2zS6EK7rVwXSVFdQgYREx9VXIoLgr
         Mefbd82SAHu/1Hcw2VYAXNNvt92znX1vD23BN7j1Z73FYGrf2pUlHXmw85uRB1c2O5gs
         QojqQRbHO4fZUOBAthlhZ9RnOKEv+jRKYWynw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722030485; x=1722635285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKuq6rb4iJjs6ClolIl+rhXCF6batvvgHN1Egz6YFgs=;
        b=fI6iUfRCNsFKlfpu3KFT4vFki7BOgUihQL8iIvGHC0PJkjvuIELpGxtnKKrIyKw4bj
         ZSsVbZk7i5gIE/askaqacq3255Qjtvli6GEYGloUOdY5e4tY9Dc0srJYdM8dK8wiZfuv
         ZOYXG41ccuE3CaDPGNcLgzuEYS1IEy5GIHN4edZA46Xz9Tx4ftTMU8JnE/lWXTGmn8o/
         am/QAjF5rr7u6ylwkQ0gk5LZWImMke/XxH0B1Qase9dZy91yRuJtcP420prp2ZIE/q0c
         P4iq1n7tFRdL8wR6b+pqMuGewYv1GUdZJoL/2yJreolXM70I/zoIXhqEdg5Pf5BumvDd
         wZOA==
X-Forwarded-Encrypted: i=1; AJvYcCWYHRqJ237c3u9Kh2lu2Y24UtKSDfzixTWzlUILH5Wnv07BRR4PM+Mr2+3GIqohPXji8AyfS/w95APMc709F2oCOpI+7N/pStpkLv2s
X-Gm-Message-State: AOJu0Yy7WFmEudev9Du8cl7O6j+gvbUbEuRbEeetf9iUiw7CSAct/b7T
	nJEEPSgnqMRFDKB6bBjfjfCcjbzyczgDGyXmH8Ir7dKXyp2TIIVBEj9Wb1dIxogopBk282azbkG
	tRFBibg==
X-Google-Smtp-Source: AGHT+IF655QyxBTscsdYXG4sfLSbSX+kChTQ2YLjlMuN8dvPUrcHMVR+BsZawGqckoX/KQeMNbzC+w==
X-Received: by 2002:ac2:5210:0:b0:52c:df83:ad52 with SMTP id 2adb3069b0e04-5309b2809acmr736910e87.36.1722030485073;
        Fri, 26 Jul 2024 14:48:05 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c2d111sm580773e87.279.2024.07.26.14.48.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 14:48:04 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f025b94e07so20928841fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:48:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyEYx38KHLAG0q7gyO4svmov/Tud9+xhoRd1bgsIsrLC4oe19/EwhF//LxozhMXhZGF7BlA5jkiiKJy97kWdpt7ywwcBHe+Wr2TSEY
X-Received: by 2002:a2e:9acb:0:b0:2ef:17f7:6e1d with SMTP id
 38308e7fff4ca-2f12ebcaefdmr6019161fa.4.1722030483957; Fri, 26 Jul 2024
 14:48:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726195044.18004-1-sedat.dilek@gmail.com> <CAHk-=wgEhoxDM7T+Ko-NgAC5X8etF0aL3fGsUXFeqnwggNXgCA@mail.gmail.com>
 <CA+icZUWUdq-xR9nOB_c_8=pfwn8J062hiurFXcrF7zvmaNg8PA@mail.gmail.com>
In-Reply-To: <CA+icZUWUdq-xR9nOB_c_8=pfwn8J062hiurFXcrF7zvmaNg8PA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jul 2024 14:47:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiruM9sWeOM8FKvGTetiWgSaGZF31YmdzS3_s=0bw0Ekg@mail.gmail.com>
Message-ID: <CAHk-=wiruM9sWeOM8FKvGTetiWgSaGZF31YmdzS3_s=0bw0Ekg@mail.gmail.com>
Subject: Re: [v2] arm64: Rename to KERNEL_IMAGE_COMPRESSED_INSTALL kconfig for
 compressed kernel image
To: sedat.dilek@gmail.com
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jul 2024 at 13:54, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> And when you check a diff of two of your ARM64 .config?
> What says COMPRESSED_INSTALL to other than the author w/o context :-)?

Even without any context, I think it says "compressed install".

Which seems sensible. Because THAT'S EXACTLY WHAT IT IS.

Now, admittedly I would have preferred not having a config option for
this at all, but we have a sad historical situation of doing something
odd on arm (and parisc).

The RISC-V people used to do the same, but they decided to just make
'install' do whatever image was built, so they base it on a
combination of different config variables: CONFIG_XIP_KERNEL,
CONFIG_RISCV_M_MODE, CONFIG_SOC_CANAAN_K210, and CONFIG_EFI_ZBOOT.

I considered just using our pre-existing CONFIG_EFI_ZBOOT variable,
but without knowing what the different boot loaders do...

               Linus

