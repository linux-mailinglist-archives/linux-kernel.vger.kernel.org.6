Return-Path: <linux-kernel+bounces-514673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5C3A35A07
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64411614BA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E947422DFB1;
	Fri, 14 Feb 2025 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bjs5ncKC"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAB422A4C3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524676; cv=none; b=fP4zwYmM7ZP4kx+isLr7iFa5Kx7FbQ3q3ul5s2pIyG77dtvrvrRudlA64TwhqSZZiFjs1/FeUOhiVxMeLfTqqWGQUbkYiTMd8owrfCRQ6UwTCLUiYWQVoBSxZFkbceh4uHXbZL3c2s+JXrbzrh/Wk2SA9VF+d6xbjGkMWE9wIAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524676; c=relaxed/simple;
	bh=Bo8I3XX9LPITIfZX8OU9yU3bK3eSvNWJ4YAU8ADPqHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grdnj1RKKqypPuotrmY5v6UfTyHwCyz93l8KiqbHqroqH/KTzQcljS8BCteL9NXjHjil2tzzTyckg+bX/SNf6aCMmEzEHfLAZMJE2tyypPChAr9krANl1Sg67QSV1HmSvkuu4c39lGdSWk2kD7kaQ/n5JW6xh9NP1Qdq3UdRLwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bjs5ncKC; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3078fb1fa28so18495491fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739524672; x=1740129472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bo8I3XX9LPITIfZX8OU9yU3bK3eSvNWJ4YAU8ADPqHs=;
        b=Bjs5ncKC0Sm1OW87CpjNqSw2atNE1VEf0oxRMFA4tGvzg4N5ydc2wbwr3sMwjiAxVc
         Gx7hXnweznrhBHH62PfsPgsu7hnYET7lcfD9ZJdPrWu0I7murs7rF1iZnutAkRXWrbP+
         Dr5zzJ+obE94fYN8q/OBFZBrg1dVzsCFQJUuXbdUN6da9ErwkfNFhm5IJvpF2lipFxLb
         HXjMRVfPVp7cE3fJzddOShcl/RzTO5ENJXBuBh9LGjF28HTXbrDGbtmV+xpX6vFUrryY
         KpO4Gc6peVPCkQgcJ9QMZ0Z7YG6YibZVSI4UZX/vcYd7H66ZEaiuKea6Td9eGupDbaMl
         J4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739524672; x=1740129472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bo8I3XX9LPITIfZX8OU9yU3bK3eSvNWJ4YAU8ADPqHs=;
        b=e8I0pFcydDFPn/6Cnd07mlv2i3+0XlEb9nL1dJJq2+NcOWa8yRORwcjGMFtFwtEJL+
         ldD9gIwFiKcqs9JCSFM6+u2jYpfY6+oh8InUGfZSlW0EnXZSF/nYdc3ZKWyka+0AVCmF
         Je9GbjI2NJJ9PJAPl7UnjOp1P7aNVjWbr3dNhmqd/dnvekabARHJnD+hXVzD1ocVeITw
         TL2Nw8ZcxUwIj1YsmIGWoRLI4aGvC6VCNWQhziPe9ah8GqEBr4SYDVCHYaOJIBGD3mF6
         O8NKQodS87mc91Iy6GhpnhrDBKuLjqZycBomeSKltaX712kZxE5ebg6nYoJf/NyJBy+P
         g2ew==
X-Forwarded-Encrypted: i=1; AJvYcCWfxOaU4+3XdXuRur5pXAdh3SPWqyNqQHFayiROOHwZ7mxxKU8LbmkzFNhFNcQ+uwxo4Oen/zlTRBAsj3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHP9VZwgpZGZt5oYPPThrJrdjRbsu6sRqDT6PYgpDIk8cfHO/v
	1s7xKid0GLIb02vNF4lVfHE3gF75kGaknykcrX4exZH6XrrZVV01me566FSIRoCZgh4Q4TTFPuf
	jVJ11RODOgmpE4+QTwOV+dEtedl+H+FbaCtyVzQ==
X-Gm-Gg: ASbGncuweY6hvmUeJAzuFfv4tVX8MjiAzQUTnFp7wfIC0M0h2cDno5dKW/7vjOqbA92
	UTCmrmYZppfI/j9c6TA0OFICx9S0DMueq0kuhGo9JpJ1vOe++BA03AhNSuY4u1tcu4IvfSBN8
X-Google-Smtp-Source: AGHT+IHU5qdxOkAv6Jae66t0wsng6vO5Xv6NqwmPurl4ZG9bzfn/Nn7m6QtQAS5dFQYWnG1i7HzkF8bimm8nUdlf/ps=
X-Received: by 2002:a2e:7c14:0:b0:308:f580:72a8 with SMTP id
 38308e7fff4ca-309037c2656mr33034541fa.11.1739524672511; Fri, 14 Feb 2025
 01:17:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210102353.83132-1-brgl@bgdev.pl>
In-Reply-To: <20250210102353.83132-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Feb 2025 10:17:40 +0100
X-Gm-Features: AWEUYZlcSfYNN_k-IfmuIzqakV5f_5CU2wOYEMTl8r3_lvKU6RLwUpovGzqEbF0
Message-ID: <CACRpkda9M9cPpg2_8EgbPUZ5-gqCCg=BZ47d1y7p9Uf6HKjZHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpiolib: move all includes to the top of gpio/consumer.h
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 11:23=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We have several conditional includes depending on !CONFIG_GPIOLIB. This
> is supposed to reduce compilation time with CONFIG_GPIOLIB=3Dy but in
> practice there's no difference on modern machines. It makes adding new
> stubs that depend on more than just GPIOLIB harder so move them all to
> the top, unduplicate them and replace asm/ with preferred linux/
> alternatives.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

