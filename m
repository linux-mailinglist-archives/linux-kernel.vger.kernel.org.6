Return-Path: <linux-kernel+bounces-174577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9C88C1106
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04AD51C214FD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9254015E5B1;
	Thu,  9 May 2024 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DFE1vbZu"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B39815CD7D
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715263931; cv=none; b=baqP6Ai2o9LY52IBOj6KBdow5x73ZMWPqFJfj3NkQBoDrSOmGLbhqPdZ/Rb6VZwjCUUaysKxlmS2MahCyhf+4+8hWEpy3WkNAWaPkZgxPwyC3FX/8NvYrDyJOWm57WaYp6ffTTK7qaU/8UYer/Yi1J94rYCbpYJ/qW7C9Q8uQUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715263931; c=relaxed/simple;
	bh=0JbJpB7AKjp4/Tkn2k5aUr2Jt6ncTbt/GkloqD6biXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlPDn1xys/qdn7XibX2whNuZR6yEDJLBy4JFBFE+zDP4rr+1QKaI8z70jSP8aCXpRABlqXtG+x6dE1No3nD6RBn3WeEUTqaLCta2EtXP4FAIJreGbDvIXmYwVOG0877DHIyXaenETxxEThzO1K6waVrlphRnOhlJBfW/ZniodtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DFE1vbZu; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43df9ac3ebcso112051cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 07:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715263928; x=1715868728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKYgk1K/0ztKVNzQLQfhwN4cnvKJTriQx0hD8c+rjW8=;
        b=DFE1vbZumbNPJLEmPItIxZNyGyb+dhxkYQQZrXBLWAejKDzgkLGu7g1CHJOBhCnclf
         wOu8fZWahjJn7LMPrgGjyOZ2YyaQyCKx93OS8XwDfMokRYAqYziFS9TGZrKTc/F8sDm7
         JAGS/EHzCSK844dLTTR2Sju6yLhwspOvHJgCtmLoTeSNQEfXyft+iAb+U/pDaME4tzoP
         1ZDlIeYNoAzaNxql+QOHJTqODZ8+27tg/yoJhKk92L2d7Et+9XJp6A0gf1ype4Dggd11
         3lnpvhAg0NiHFmioWDCY7lg7zK3k7GgE2MdDBK7oO58D1s2nA/HRiW83KUF3B6WpGKao
         U7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715263928; x=1715868728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKYgk1K/0ztKVNzQLQfhwN4cnvKJTriQx0hD8c+rjW8=;
        b=g/cjYr2a6j95055y/E+wIPbbZHyVzg5gx+IHoN8KDZl+3FX8BuyeL0hPiblIm+xBBv
         uuYc05SS/ZCmHKZekqTAcgek7XvmRt6rdaE/SFV59rgTfKaNhrzIeXWQWvdwpUzlNHBL
         OPA2k3ilBed+KDfp6+Gi9mki78yUQK5EOT1Yj/8WUQUrZqGfFgFQvdJX0jGUJC1Z94Ao
         UoRS7kj8ryKSo7JSxOl4wOzmjv2JPzOpB2WdGJWD62laT/36nYtV2Rt5N1EDglRwy2l9
         lUo0xUV6YvjRQYZzWP77V8Ek4ZQOlzLkUHkIHcHFz7vfZ4AcAwq/9jXZs1QKDmMfXMIZ
         0Mbw==
X-Forwarded-Encrypted: i=1; AJvYcCUF61BpQtASxhlI341PQihwfd6Ziv28qGgnOwSLAQuE28gYCcNaCcOc1Si5W7M27ZzcnOyRh3rPNaYqPKtZ93IhaLuiN41qyMPWhuRv
X-Gm-Message-State: AOJu0YxTccv7M9vCYr8C5YVycJ9bh/rJSkEh1Cp+uJVk1y7bMs+CjUfo
	3gErr2rBH+fO+SbrfXc0emabLW3oowcqC3VNC5PX4c9nvjjZSCHa+vOQ+q2uHzmJuu08OYc1Q8S
	y5bvBmuXVEZsOUwinzYJpRqp7D4xs+7llyQuP
X-Google-Smtp-Source: AGHT+IFvuSQcG22Ig7DeauYZsrwsp+uIqjXGQRfJ1VPnduyNbUdPF39bvdjed/XkNswMRuYX8cDshnhVQDZ7qNQZMCY=
X-Received: by 2002:a05:622a:580b:b0:43a:b977:d611 with SMTP id
 d75a77b69052e-43def960973mr4096621cf.24.1715263928208; Thu, 09 May 2024
 07:12:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509083453.14073-1-lvzhaoxiong@huaqin.corp-partner.google.com>
In-Reply-To: <20240509083453.14073-1-lvzhaoxiong@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@google.com>
Date: Thu, 9 May 2024 07:11:52 -0700
Message-ID: <CAD=FV=VfBXjgYTzNEj+szHX9-wGig9XUFVt+CkG6mXzHwZjduw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add starry bindings and driver
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.co, hsinyi@google.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	cong yang <yangcong5@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 9, 2024 at 1:35=E2=80=AFAM Zhaoxiong Lv
<lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
>
> Add bindings and driver for starry.
> ---
> Modifications between V1 and V2:
> Kconfig and Makefile configurations added for starry driver
>
> ---
>
> Zhaoxiong Lv (2):
>   dt-bindings: display: panel: Add Starry-er88577 support
>   drm/panel: starry: add new panel driver
>
>  .../display/panel/starry,er88577.yaml         |  59 +++
>  drivers/gpu/drm/panel/Kconfig                 |   9 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  drivers/gpu/drm/panel/panel-starry-er88577.c  | 444 ++++++++++++++++++
>  4 files changed, 513 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/starr=
y,er88577.yaml
>  create mode 100644 drivers/gpu/drm/panel/panel-starry-er88577.c

I don't think anyone is going to look at this series since it's not
taking into account previous feedback. Please talk to Cong Yang (CCed)
who is also working at Huaquin and is also sending MIPI panel patches.
Hopefully he should be able to pre-review your patches with you so
that you can learn from what he learned. If for some reason you are
unable to work with Cong Yang then let me know and we can figure out
the next steps here.

-Doug

