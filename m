Return-Path: <linux-kernel+bounces-357405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0963F9970E9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DF3FB23565
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFB01E571A;
	Wed,  9 Oct 2024 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j0vNgKjn"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B291E3797
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489238; cv=none; b=AvXCYisFomVfVPuZGl++cjHyjpKhd/3AVZq9NYZ9BkggWFJ7TeMiAVAluGEiCGcD0w80r5MEQHmCeelChJw8WaXFa2uPWJAHvEuY7/jXjvQnTTJ/romGLAtzxQd5voUf94VrKkYnF1TFvDoWY47THCu4SEc8keKHtJDTOrowfZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489238; c=relaxed/simple;
	bh=NJ3E7SiyoRumtSue3+YxGg4JRiaY7WIm5XxcTZL8d9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dI4nHDD/H1j1aM1Z02fRwYWWlNyrJhgFInM1puLNCXvAs5ncA1/gavDb7WjjyqM3W1zuAIuYd4YScCBHHTlflnTRRNJeYnlXdhhC1DdoqMAZ4nISooB4Q695oSooZTMt73zwKCiO00Pc07xuG5SznmyKmiKYPlCLBiWYjqVGcik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j0vNgKjn; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fabfc06de3so78022751fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 08:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728489235; x=1729094035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJ3E7SiyoRumtSue3+YxGg4JRiaY7WIm5XxcTZL8d9E=;
        b=j0vNgKjndvWXO1+ogWjyD3d9GmvQUiaMjN4S7Y32pT3teHh9as0KD5JIUafAE06btM
         mnPFPs3tNewx4ndnzw2lTovdavg4k8CSHE9KW7iRHN5tjhyadnSDqrfWa5yh6gbNk852
         cyg8R8ARiC8mjoKVNMQK3dQ2W/Bi4teXNrNvC3A8N6Hz+YB/9mk6bFg6jdgoH4YUGHvY
         s6lPNlf9FXiui+IUeByhvyX1E7foqt6wq0O7DKlChe7yx0Dt6485UDRcTJESeitpRbr3
         FR/+3U5pN5cZoTgfN+T0mtxzu0W96Xa87bCT74OjN3MPYMUjMWeAd8LmGrwG241Ij2bJ
         8Sew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489235; x=1729094035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJ3E7SiyoRumtSue3+YxGg4JRiaY7WIm5XxcTZL8d9E=;
        b=EaJprDZAJjdTnSexDvE5vHTtBs9gzd7tnV3d43gtb318rBOKti7pEr72QtJYJ4pTU/
         GA92WYSISqRzNbdkeu7dFu4lEV+cyYwFVVhM3Ho6fk7Rn1ZrXF5BwypX15IJoNiXbf6E
         6ykVh16T7DI/IF79QhkwN0zXJoo9tzukmWw3kSa17L7QFEiW1fACYTqtlCsH3TsBxBjD
         Rlx9UB4Tb37IIE7DaXR9xnefU1GMMkWHHrOocuA4ef8B/YBKdyIr+/i5QDCbGlZxla+7
         4zW1ELH/BGBY+XMY5CDzeFbusz2eAteipj09CI1/dvI1UZOhd+E4nMh1sHn4VBxTIVT1
         W2wg==
X-Forwarded-Encrypted: i=1; AJvYcCXrC2TtqdcttyaNBJpWVbDFMivZwfqGHunP5CmwH8nPCkGaC0/h75YuJZyAoYj9Tv5ILSKkG4uVCa+flwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6kEI92I9wWAy88GbtpfWEzVXhcLpKiaaMzqaxDxoPUahAaPdX
	wHZQWCXMiu/pOa8IAcTfPPQhDKJjda0GS38KDixmd0cTrc9axGTfu3+02Z9+DPP9Ms1UobUuR30
	D7DtuUUEwoXxRUi2eKthIg/JOnmvT4FchjoiKtw==
X-Google-Smtp-Source: AGHT+IF1Lv/76V+RyjJ3lzcXIdhaFKwqua1nbpbFn/1KRFIOa6rU81jScDSr5dJe6IpSIdWWq5KQKVGGqaDkj0Vt1Dc=
X-Received: by 2002:a2e:5152:0:b0:2f7:6519:9a01 with SMTP id
 38308e7fff4ca-2fb1873ea07mr15960721fa.24.1728489234904; Wed, 09 Oct 2024
 08:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009144135.12453-1-zpenya1314@gmail.com>
In-Reply-To: <20241009144135.12453-1-zpenya1314@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 9 Oct 2024 17:53:43 +0200
Message-ID: <CACRpkdbVOOvrXiZQ2pSQn7ar5S8j824pu9gnnrN_+7+YHTUwiQ@mail.gmail.com>
Subject: Re: [PATCH v2] Docs/mm: Fix a mistake for pfn in page_tables.rst
To: Pengyu Zhang <zpenya1314@gmail.com>
Cc: corbet@lwn.net, rppt@kernel.org, fmdefrancesco@gmail.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yaxin_wang_uestc@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 4:41=E2=80=AFPM Pengyu Zhang <zpenya1314@gmail.com> =
wrote:

> The documentation incorrectly calculate the pfn value as 0x3fffff,
> which should be 0x3ffff instead. It is obtained by right-shifting
> 0xffffc000 by 14 bits.
>
> This patch corrects the value to prevent any potential confusion
> for developers referencing this document.
>
> Signed-off-by: Pengyu Zhang <zpenya1314@gmail.com>

Thanks, I love attention to detail yet make mistakes all the
time!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

