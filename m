Return-Path: <linux-kernel+bounces-279929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9E194C385
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F0A1C2222E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF7D190679;
	Thu,  8 Aug 2024 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mi4Qqzlm"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042C418FC9C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137581; cv=none; b=jY4yUrpql0X3SEep8BgsYsLx7vDS8iFtkLJruCoudll7V2IaUsEJa11UR6R+eONMaQzj2KpBi7YAJ15/7HGH4WKQrEcistpAhWAIpKINjMlPC3kwkmbP0YFCICoYuXNzESLUchl4GcyfH1yFiC67ubeftajYHUt7yvTBPATcRAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137581; c=relaxed/simple;
	bh=lsuG+EZA1Vx6q/Fv+7s0/FIoUtMR0zl1+rBKVZ9ncjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PjSKe9B7jHg31lR+pWVoTwCamXRud0yHfPYWmjoBhsazWwfBnHnDJtVK0Q3dLKnhk/6D5JJ1ukkMinmME5JJq/VkEPjC1mw7L9I6aNR7ebIK7vLAUkSVdzppQAtV4DUvy0ZnuLWyCulHp9BggWzcd/3C0ZESdJBMLK5gMYEY1cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Mi4Qqzlm; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a1f9bc80e3so468651a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 10:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723137576; x=1723742376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsuG+EZA1Vx6q/Fv+7s0/FIoUtMR0zl1+rBKVZ9ncjk=;
        b=Mi4QqzlmnWnYrsL/30VZ0EmSEMy46eBdPIqWbgldrMQkp7SCz7aafBKTybKcR2szIS
         GdH2pZ3SjIIIl6zc17+CY9O8NVErW32AqBUXzsnVBlrC+sVyLWR6JIbXkbS+upIKlZzC
         UBljqI6kYVRn43kP2zgSIRYKizLZopUAzRQ74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723137576; x=1723742376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsuG+EZA1Vx6q/Fv+7s0/FIoUtMR0zl1+rBKVZ9ncjk=;
        b=kbe9SOGKLxN12xha/VkRpKybjQ+nLsFte9zbBGvGnwhYPITKHpy2bAWsOu1KnyTmKG
         80KMDLvPcTqDGduZ7q/QwDZ/M2Bg8r4xsOF6FuBn6YCbTm4oDru6+dTOZFnqQ4xI8qKO
         oX9KfJ1SocrB9+WQLBwgNjvSSBBG3x8q5kdW6yfpp8EvcFGw5uO6zp8nF7JLhnjv6yYJ
         6AWAzlCQha5szyS3LJw329CCuiHP/FsXIj/xfFqoqHtA9pFsZGqOeeEtYs4nPB7VXDiv
         mh/1PCKgUmmQJprqtBOpVAW9FRCcKEcVolFL/ghP5+cUFEpZMOCZ2Jcgrh596DGfFObO
         8G4A==
X-Forwarded-Encrypted: i=1; AJvYcCUrDwmVBDP/B3wrkNkzLg0ul7JF8R+3oRl/e2ST/bBbmG+ps3pK/2Jz5YfXO3FaTNVpAFw1tH5Oc5VYqyRe3TRFCaYR6qdVETdStmfM
X-Gm-Message-State: AOJu0YyBoVa6vSIh5oIc2uEVtVgHJyoBqekgidYGQV+BsMICnMl7pkT3
	ctcEwJAM86CoYfNY55gYxwpp0rcQBvFwIbn2CZkIxlTdh4nleOzRbWV97/VT4M0ks2kf1E7i8d9
	v5Q==
X-Google-Smtp-Source: AGHT+IHrbmk3nW6qMeO4hZp4b9RUSUZrcD+JbZLtAIkxk6ZLjuc/n4V0h2JU5SwqcWen+NbL8SAMRw==
X-Received: by 2002:a05:6402:358f:b0:5a2:e73f:1528 with SMTP id 4fb4d7f45d1cf-5bbb234435dmr2988647a12.12.1723137575831;
        Thu, 08 Aug 2024 10:19:35 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2a5d2a9sm837097a12.0.2024.08.08.10.19.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 10:19:35 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428063f4d71so445e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 10:19:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX1DqDvR5eVGaqHDKA4zsxnYcs2Xjs5v3dUQzXYBnOYwzR/n4aSqvYr/gzS8SWcS4k78EmO7yetbazIrrrl8OjF4W2mgqgKf1sX9UAl
X-Received: by 2002:a05:600c:c14:b0:426:6edd:61a7 with SMTP id
 5b1f17b1804b1-4290aa8f28emr1775535e9.7.1723137574029; Thu, 08 Aug 2024
 10:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618084455.1451461-1-charles.goodix@gmail.com> <ZnlGDCcNch475wWA@ux-UP-WHL01>
In-Reply-To: <ZnlGDCcNch475wWA@ux-UP-WHL01>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 8 Aug 2024 10:19:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UkHaH_oUojLCozh-C27GUaCgr_6V16_0XKJw86p5wmFQ@mail.gmail.com>
Message-ID: <CAD=FV=UkHaH_oUojLCozh-C27GUaCgr_6V16_0XKJw86p5wmFQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] HID: add initial support for Goodix HID-over-SPI touchscreen
To: Charles Wang <charles.goodix@gmail.com>
Cc: dmitry.torokhov@gmail.com, dan.carpenter@linaro.org, conor@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, jikos@kernel.org, bentiss@kernel.org, 
	hbarnor@chromium.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 24, 2024 at 3:10=E2=80=AFAM Charles Wang <charles.goodix@gmail.=
com> wrote:
>
> Gentle ping...

Looks like Dmitry had some small nits on patch #1. Maybe folks are
assuming that you'll send a v6 or at least respond to him about the
nits?

-Doug

