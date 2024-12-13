Return-Path: <linux-kernel+bounces-444096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C319E9F00B1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 01:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D3D16954E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 00:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F351373;
	Fri, 13 Dec 2024 00:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zvqpn9IH"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5322D621
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 00:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734049006; cv=none; b=WxwsH1rXNyYDa/09IsRlgrkLo9joD6UHU8Wf/dE4Ub2bAHhmCYALXZdHdlb0TGKvMxPKRybLGxb0XUVvB3VRAoXv+l9WFHHg21cP9MrEfvuL7M0a8nNemwbT5RcEkVqkx6MQ19ILmS45ph+HD3C5PMPdLCzOwLuVZmFDhf/JTTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734049006; c=relaxed/simple;
	bh=f/AfbZ/Lcv4MV6u2NordctibWy0sKFCNN77jSaCoPD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4f3fPIxP0HtERIRprzQmqejZP/c6kfQDGDbfsfgJJxMoVmfWnWfYh/lOKdB9j98Ouo0uD7GzgC2OgezyL0L6DdVECR0c4nsQLOZX+sFW4LzI7sf1MzGDDla01wBNh6eB4oC1kpFTySQY+0QYTrJiMlblrazKjrH+W9yYYn4d60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zvqpn9IH; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3003c82c95cso8951191fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734049002; x=1734653802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/AfbZ/Lcv4MV6u2NordctibWy0sKFCNN77jSaCoPD8=;
        b=Zvqpn9IH4+yjPyG4VwYwYfb9hNgN+OEn/u9/wOFMGvsn/4c2xC8QJ3okSBf4aJr8RW
         xN0WEPL9et9KXnde18fLOuissXQKe2andnUUyZOsxwPAPEcjHhUbtRzh8zuTtLi8f09d
         yfpGYbJd+16eKtkc9SSzFWwfDRdmokIBm7zZ6eo+KOgjMamB03IX6FUFr0uQictiZfu7
         iDawbIT2gGfa4bzchSLV+uYEK4p6pUzmmB4napD6QaYsGKviHWpgy9jAk7HUBJngzj/0
         ++Mvs9xwxbsv8WNCV/D+sKzdO3dT6uDHhp3X3UmzwjgzqRHraKci4KmlZ4K4vA18QriM
         nDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734049002; x=1734653802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/AfbZ/Lcv4MV6u2NordctibWy0sKFCNN77jSaCoPD8=;
        b=YRQ1fw8TrAWWJb9A34lCGvNsRtbselK2R0FY5RogxYLf9TunsFyxHpPlhZkMUqa+tM
         eSgdSlOc/e8YfS3Zz+CN/a6grJd0qFNSXNIfpNlB6UpIwQNywbHjJG3scpd3bbkNTS4T
         fZhPSHq3EAooCs25KB2+i7sEIhnzmStmV9WAIqOYJaOeZIiZqlWx5Pz0+eBdx4TAUNRK
         4F0dCg7fIQbrDCGPhXixOEUo+M15NVu9iFmy3Nf/u4KYoTAPq8dU9PVp668YHJl2M4+p
         DmDqSz9sDicsWhsLmdjgt/HrZJxIQZVVOmRiDEl8hgT26SytpigE80IIQ2Uw0xCF+XZa
         gvtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXONlDw/kYZvG28k1JzFBeaAWe3SFkD+urjbIlC8lxvZYkl5/CjmG/qXPX2RljfcVknIYJQLUc6vQu1EYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlB4G33eBBwyLET75mqsJ20/uFOvcoWV4Yyov6XHE0XhPu5yaf
	QKKOf9cA/n4O8NgLOGwzril6U02LXTyXqd+Hor+X5gCuznBycmcbZrue4mSjsJ3XBE6Va8I/J1u
	idZqp8UhXBWApqurQFxYTgu+NEL9DwodFytnuWw==
X-Gm-Gg: ASbGncsdoiqT6mHPhIcZoc5AkvsitSvTboDnFN4Bwh9E9KQhfUW6p2TJ2QynHgRBL/V
	e5y7TzoxCGINqWezrQOfogs1XJmvwsZfr6IUG
X-Google-Smtp-Source: AGHT+IHi5gVwXNphSa9p28n7Muex507AwVByLNdIpXjj9BE+fLY6ChX+4Tt3eZWYhZJFsSxV2AGCweYvOxT65izvamI=
X-Received: by 2002:a05:6512:3b89:b0:53e:24fa:ce2 with SMTP id
 2adb3069b0e04-5409059508fmr88078e87.38.1734049002474; Thu, 12 Dec 2024
 16:16:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211235250.136985-1-linux@treblig.org>
In-Reply-To: <20241211235250.136985-1-linux@treblig.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 13 Dec 2024 01:16:31 +0100
Message-ID: <CACRpkdaAfRjF6rDB5u+-g3c53Cby0FO93z_iGuxNxXF-mMywGg@mail.gmail.com>
Subject: Re: [PATCH] ata: sata_gemini: Remove remaining reset glue
To: linux@treblig.org
Cc: dlemoal@kernel.org, cassel@kernel.org, p.zabel@pengutronix.de, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 12:52=E2=80=AFAM <linux@treblig.org> wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> Now that gemini_sata_reset_bridge() is gone, we can remove
> the sata0/1_reset members and the code that creates them.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

