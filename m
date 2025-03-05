Return-Path: <linux-kernel+bounces-546924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D50BCA500BA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73CB67A8C20
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB14248898;
	Wed,  5 Mar 2025 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y8TNQ5yq"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF23638DE1
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741181919; cv=none; b=qSRcLimN70f4bpI7d6m+utCGuGmGJTpoFSzpKnjlGrQSObJ265n3hTPHOtYNe82bB3j+xJxV8tRz990LGfNHM7g3U83F1NuR/zoADwcFaNObuPaCGrn07KJ281HQWWqBXni7/1Ge9UtysmO2sULZYk9MTv+HiFOd0LcY6Y8fJuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741181919; c=relaxed/simple;
	bh=9v4zA4NK4TvFvR7nq6a0lC7go06+PikluQEpyOjJaUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gobBeO3OesDl3qQ5s0GX4v0HQJbBxr7xvYdm+hfjvTqVRS2j9R/jzX4KICbAXFi++EynA1H9dSC8J3wTBs5s9s2IM7A00eC7wlU25q+IdNcB2thAGo5yxIOzJ5bq3PnMnc6W2J4YXjQmSVxojYUtWaiP6OfiZa7RiBOy74Oqdb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y8TNQ5yq; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-307325f2436so67515591fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 05:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741181916; x=1741786716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9v4zA4NK4TvFvR7nq6a0lC7go06+PikluQEpyOjJaUA=;
        b=Y8TNQ5yqDDsQdLmeCmX+6ItDIIBm0f8n8zUnAF4sR8fAhJpr4BZoRv06tMr4Djcxkd
         jOQBoDCOiChYXhq3S8H6FJcA/2IdRKHgRT+7HvK0GL++y2NB3EM6Brrmqb1T7TbgH1Nl
         HDCS436Knd731SyX4wxSC1BXl1YAVA9kQe63m7C2FupBcaFwUuejwIDy5VIz5ebi39Dr
         Po2Pmn1TLd9yTf8qkYXxjEyySXK84oNHazapeV3anjwGKs6kem2XEE+qNSkGvDAnnnF2
         YqGz98djzt++n6JeFOLRenOj29FncOURQaOc4NKnpvYsshKuAATmwmYGXa+ocnTcEIeK
         eH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741181916; x=1741786716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9v4zA4NK4TvFvR7nq6a0lC7go06+PikluQEpyOjJaUA=;
        b=UJQ60nYkmqSBuOK1gNy23AjJUR/n2v4ZJZW+cbmQATlnBYpzrk4oCNOMXOPbuC9vsL
         rzGLVJwkcuYutWXuCAyo1WbCXrrzJ7zytLJsemqaZVcCLWfmOc1fhjBw7OgaNZLnz/f2
         zKEMzpVs7KOov2Zh+mxKOmGeKja9lMINbyrh468s061nboAAtPuM+lgDuc9jxqkM9RWq
         xm9ix6bw0iwOMx4o0eRmgLqU2JnHgqeQG5ndc7GS3tF4gQYcSCKcxlJQwlADWjiryMvN
         ZaI8ABa+kedIZq82bupIeG/+gtNhdiSse9tNrqFd0HLEBKCaVPLSXU3sPqAfE2htxZHz
         dbeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSVgQxHFv1aX0KCXAXnPMTYEB7Zc6n67scynf3W7zZPFIq2CiQy0fSREOjOtM8fAJrUgqezuI913r3NDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH3256keQmncuWLRnSPXsfZ7OEpwR/JvdGo4vi0GViiM62Bmju
	5dvPqd/LpXuVO6cFbBIbVdlfn9+/MLQyFOuiWuOAR4BBQOY1FJCULBowvRuCYxQ3l9fuG05B4UH
	+XS2wk/3JgzY+kqgapGsbiEpgvWu6aDCZjmIUFg==
X-Gm-Gg: ASbGncvqXHd/RQnxg3uqNRdXyNk6pEmWJxxcyk0BmWvXLkL2Zz0bNQyklWha58MXGTv
	kxDtLE5LFtLdYGqjMBsMQPsPNdIXB1ipHrf3DwfxZ7nb2rsUdn8NZcOnHovF8h+K35HcVfOugRk
	eA2ORRvbxGqFx6Wj/gkYWu5Q4Dtw==
X-Google-Smtp-Source: AGHT+IFqoDHkYxWaQwmHuzchjBmcCKsR5ZjqqnQyH+MSBdWdtscFT12gqRzo5qHrszKqvOhBzQ0PEgiQBiJ4WwOzLbw=
X-Received: by 2002:a2e:a585:0:b0:30b:b8e6:86d7 with SMTP id
 38308e7fff4ca-30bd7a76f81mr13080761fa.22.1741181915589; Wed, 05 Mar 2025
 05:38:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305094939.40011-1-brgl@bgdev.pl>
In-Reply-To: <20250305094939.40011-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 5 Mar 2025 14:38:23 +0100
X-Gm-Features: AQ5f1Jp3pzrHJgyw0lF2vcGcobVKtdapbGZLx8P6WtKn2aU2kSOcP25uqamMc2Y
Message-ID: <CACRpkdY3Dzcn2QSQ_ChP+buJ23oG6=BXd5H3wZ8BgKR4ej2NKA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: fix kerneldoc
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 10:49=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Add missing '@' to the kernel doc for the new of_node_instance_match
> field of struct gpio_chip.
>
> Fixes: bd3ce71078bd ("gpiolib: of: Handle threecell GPIO chips")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/all/20250305203929.70283b9b@canb.auug.org=
.au/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Sorry for the mess!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

