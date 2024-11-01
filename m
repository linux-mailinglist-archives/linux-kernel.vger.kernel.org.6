Return-Path: <linux-kernel+bounces-392369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 468D39B9332
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B6B28301F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA97C1A4F21;
	Fri,  1 Nov 2024 14:29:29 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6EA1A2C06
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471369; cv=none; b=VtzSRR6ee59K861iFmlmlj8tYfSVSZ3V48rd3y7Ou7UFKuuDN7/X4/5BWydIqoU958RBv2n3DDxG55TIcsOUcuX8t9XSATW6+AqNU5hFWTNG9By2mScfyJJeNgTr4ZjVRD3aDpsg2+LDkTtYGiIruI4TCULaVHiEulVxuT2qo74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471369; c=relaxed/simple;
	bh=VmHz5nlZIWqqvEKJFo1Nsn0vzxPDgXYMjLtwHruwULw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZA9kqN0DeYwt7mxCkyCHxWRSsv8eigoMFuaJ+VZaMC6jAcrsrBYHFVdK3jcs3jaqmQo2CZV3Sf6NDllTSTbygUrQrIh1Ru7+ufBJ95WL6SzjRrXE9akWJo85DwtwzT0lfw0aKFrcwHe/0xcztcvjR7Knj1qpjwIVXc1NAJ+SBWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c77459558so18301665ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 07:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730471367; x=1731076167;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ERLYvyPbKZ8JxkIbrL8+Ki3TJhm1EhtXm+s7krpp5vc=;
        b=hd8B8E3ETrS0/mTR4BvgGpLcmy0UTpIrmz+jYVSMyt4NRh+BS7N74J89FAILm+83ZV
         /jomkjGej1Ms8d8MwNq4sO/O/TGBYmwKSOuibGy/RcMi3gu8WcUw/HaAG2nxLMzlrR8s
         Ydea+tyMeN9i7DibDCnHGgBdkOurnvOUP17YlDNB+dk8k6348fV2tvyly0JvKDb13nNU
         r4kpY6QmeQ7LbjPRD9mp7Wc3f7dL9QRn1yo3R4NEl07mqJJ/KOODWdeSt6abBDMJfXy7
         VLAnNdaEQ9An0XMIjgd3xZE0HJoBt0yUB4yamknqvXgUlJq1vJtaRI+DtGbEYlGaMEls
         SUyA==
X-Forwarded-Encrypted: i=1; AJvYcCV8Rb5AqU55PYIWaUnc9pFp2dzzGtrwaWMakKzi1aYwauRiDO+xnmPwOrrJ4iCjRoZS2JNxXcan7Qs2L4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoIVBkZ9w67Ppmikdyptc2/EXEzhJxaoS6aJxxch1OaJGGZz64
	j4UkaAlhP3Oqgigoe2YVDSk7Lwa1zdjDUN0Xhicia+aJ69RnADRaRFMrUywhvm4=
X-Google-Smtp-Source: AGHT+IEjuPaRXDmIHKxmEM1MgXCWCoRlSILQEUVyaX7oKcUJxOvSkElErAbt27tTtHIX1LTt/c1JlQ==
X-Received: by 2002:a17:902:ce10:b0:20c:a97d:cc5c with SMTP id d9443c01a7336-210f74f6256mr147030695ad.6.1730471366846;
        Fri, 01 Nov 2024 07:29:26 -0700 (PDT)
Received: from localhost ([97.126.177.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056eeaa9sm22092685ad.47.2024.11.01.07.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 07:29:26 -0700 (PDT)
From: Kevin Hilman <khilman@kernel.org>
To: Judith Mendez <jm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bin Liu <b-liu@ti.com>, Judith Mendez
 <jm@ti.com>
Subject: Re: [PATCH RESEND v2] gpio: omap: Add omap_gpio_disable/enable_irq
 calls
In-Reply-To: <20241031145652.342696-1-jm@ti.com>
References: <20241031145652.342696-1-jm@ti.com>
Date: Fri, 01 Nov 2024 07:29:25 -0700
Message-ID: <7h5xp7owmy.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Judith,

Judith Mendez <jm@ti.com> writes:

> From: Bin Liu <b-liu@ti.com>
>
> Add omap_gpio_disable_irq and omap_gpio_enable_irq
> calls in gpio-omap.
>
> Currently, kernel cannot disable gpio interrupts in
> case of a irq storm, so add omap_gpio_disable/enable_irq
> so that interrupts can be disabled/enabled.
>
> Signed-off-by: Bin Liu <b-liu@ti.com>
> [Judith: Add commit message]
> Signed-off-by: Judith Mendez <jm@ti.com>

Thanks for this patch.  Can you give a bit more context on the
problem(s) this solves and on which SoCs/platforms it was
developed/validated?

Thanks,

Kevin

