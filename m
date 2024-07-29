Return-Path: <linux-kernel+bounces-264951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666D193EA83
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26551281A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142C63BBED;
	Mon, 29 Jul 2024 01:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OF/tl4am"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D95E374DD;
	Mon, 29 Jul 2024 01:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722215796; cv=none; b=qAGrf57+W3N/XI3bcwkS4itV4G9yiiuIx2eIWt5acvtu53+DG2KtPyr6CVspuqOgPC1k6Fm3nUZka/RmMA35nY+apmHt8pDqDANJBGqjLbM7J819K8uEm14f2IjABk1fLbvF36GFMQRa+JUqaCbBABf45amUytORIj2k6Pmpf7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722215796; c=relaxed/simple;
	bh=Yirb6mO810eYfbcYmkN4njXdtt+W9NzNSj9ntvYA8Jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+iIph1WUwXryjn9JyHiPpwIJWBfA5RKnK+mbOXqMiP/ltXlhDGXLEyQf9uWiKeI7BcYFRT9kLtp/5zTtCBRiphzCXdIW+jpIBbzcaLW7ErWpyoT/eyzofhkT+ZIDVoFL6RpqJpESlz1gYQS0W5Lb3H+xMhysoaBMvK6F7/q9V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OF/tl4am; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5c691c6788eso1594262eaf.2;
        Sun, 28 Jul 2024 18:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722215794; x=1722820594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yirb6mO810eYfbcYmkN4njXdtt+W9NzNSj9ntvYA8Jc=;
        b=OF/tl4amctav8S6s+uz/8ucVASU2JbDVi2vZqMFZNJLMw6yagCx9vmtnlY2EPMHkNs
         mBFr+a5pi0T6+apZhl/d7WvzQwI8N2429es2TuEPQ1GpaxANKkUYntjUAA1+0SLjflNl
         1PhbeNPcV3tNQ402R0hU94Dz5fF39y30ZB9J6HVFiGFErb7iSCDaXBBNiNo/oZTCZB1U
         mQjlRm/piogGwtrHCWn5nBYi1t10WhwFNoeSmQdEIzOt9wpZuZ0OyTudnR/Rj2brRX4J
         9zDZ+zpi6Usmcwj1CvmHSKFUyrkkcmtq6JFgqMyLm1s08N1sZ8Kts0A+dB0qQ5RaGxLJ
         2Q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722215794; x=1722820594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yirb6mO810eYfbcYmkN4njXdtt+W9NzNSj9ntvYA8Jc=;
        b=oExsKyNaS4JY6ykiWvUstMV/rJbO3kq0AumxVkGnO57bG8n2PqhKiXjAGKrIcZU3n0
         WMX1PzAiOfPEINpO4X55lA/z5pwbJz9B+eMgaHTRAqw8TYk+nGmtMVEzg8kobHouvo7b
         SsJyjLHjRp6ALhlGyt6XXOZhSk0KDvUB10zrM6x4gnXbvbagBtBBKjySREmpTG/9vjVn
         Gao1NYKYMlrFLab399vNPH4UWPfDthZUuLjmc0ISPkQ8bVtejvVhNMqQZGejdfUMk6QB
         sQYQ/N363QGeekXrc9P+3rX23topub7MCgCqnJLJW2WtaIzag6XYdQiovAGgsA8t1xcO
         j0ag==
X-Forwarded-Encrypted: i=1; AJvYcCXNk9tZgfRyH0yUBloZ25oQglh7gPqQGheb/XOaDxcufIVTJJavCsKxr9ZqM2V9ZoUEGcw2etp3SbDC5gGHGiWIp9AmmJ+TkqJrN9K2Uu1wGMmafrdG7gA+jkYi020T64oafwtFuF7saLYwQcPGLUCwfMrBr3H/BZI3UHCDMLS8S/RpMvk=
X-Gm-Message-State: AOJu0YyqCbONoH7N+LbnV+JwJTK7D8OxFJ2Zb6Jpsf90QSVBtib2DkCv
	dmtevB6U6phQ9iZXix3mf4vbIxcKoM77BcA4/1khcQlOon2EP4nTJvikK3PtDc8nWNBEHv02es8
	ozXJuJhd9T+16m/wcBhInDrxSGMs=
X-Google-Smtp-Source: AGHT+IEy+gd4y0tlIgxMmT1QC60Ph83hhbmoOHc9H8tx9mq5XIZeKfQ2X3R3OeUDOCuxjEtroWQRl0dM4VsmZ+ZdIk4=
X-Received: by 2002:a05:6358:9d8b:b0:1aa:b9f2:a0cf with SMTP id
 e5c5f4694b2df-1adc0686329mr526948355d.17.1722215793649; Sun, 28 Jul 2024
 18:16:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726-typo-v1-1-3ca3f07f93e9@gmail.com> <e4f93c17-be7f-405b-babb-2b4aef709537@roeck-us.net>
In-Reply-To: <e4f93c17-be7f-405b-babb-2b4aef709537@roeck-us.net>
From: Cryolitia PukNgae <Cryolitia@gmail.com>
Date: Mon, 29 Jul 2024 09:16:22 +0800
Message-ID: <CAANcMPk1uQ3zOQdNX-UXBLjzFZzBMVS7aj7t4N_ggzCXwLjQrA@mail.gmail.com>
Subject: Re: [PATCH] hwmon: document: fix typo in oxp-sensors
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Plus, having your Signed-off-by: tag after '---' drops it
> when applying the patch. _Please_ be more careful when submitting
> patches, even more so for minor ones like this one.
>
> Thanks,
> Guenter

Sincerely thank you for your guidance

=E9=A1=BA=E9=A2=82=E6=97=B6=E7=A5=BA
Cryolitia

