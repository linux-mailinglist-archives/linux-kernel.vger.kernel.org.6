Return-Path: <linux-kernel+bounces-551501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E2AA56D3A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72E73AAC39
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC78A227B88;
	Fri,  7 Mar 2025 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Htf8B15p"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A58226CEF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363843; cv=none; b=ihPKWFnBssXqDtH6krccyUceUi/HsjQrvL95M2/1BTkdgo4QhfA+emiwDK6+uWmyiAADNnx0u9EXH2fwbKEI8s7vfmRd5A98aP99G/g3WKW4UpmCxwdzY/+tjCyIqWHlDfDjYEyhPF81S8LzHqlodHG+ISxfQJE19bIZJMv9lAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363843; c=relaxed/simple;
	bh=v/nq6HBZ2lU9Xc1u8ZCgXjk0gRvXn4xSypXmjssXxpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DpJ0oFfvp9IwNpl9pyAEWjAbBhlJ4TYzNoMaujNR6QxF6zSnI2cLLJsbgd7pPG1u+qf08/94K/1n5wKOsFwlSrcce6BGz8o7PD11Jb2KkuevPio4EdGrvVlbjNUZw3HCcmxsg1roU4ws+kkn+KlVjThPl9S7rQkTVsPnCxK4rbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Htf8B15p; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5495888f12eso2487747e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741363837; x=1741968637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6NHyRlIoZDrEU0qlwqQjUZyDB0+knmZI3hR4ckIPm4=;
        b=Htf8B15pdsMxT2Rc9LJ7Cj118gPwNR/p+b2mv8YIEU1UAuAa6zv5gJDDd1BXnpWyuj
         Wn5hhcW/V9PjarWR05/cPbcI+Hk26ECNpvGBxX72AJZPs23lAqjxYe1NXkpMia0beGHz
         Tfot+oG+OTdfWEAQ+jf8glrr0OTtbGYgNUd0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741363837; x=1741968637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6NHyRlIoZDrEU0qlwqQjUZyDB0+knmZI3hR4ckIPm4=;
        b=oIGRcM4ImJLdldtUDb5Jg4tKDQmPol0HT6FPW2kHslzHQkfQoW657iTJeeeK7YCFr9
         edlGBKIuMHXAV1zvswMtDiXZYU9b5LgzRzktX/pWwZHmG0ImSDwuBMLHIUPGjhepznw3
         MNyq2clAtFk0su0tHZVsk2OkRaYMn46ebaBlLuURpZhdANsSfsBRn6QGY7qtsC50pX0Q
         tsKj7ACG/NO9JQNODYmQ6UhpsPeVMeiKSnytoQR5YFvv1OuCyoL6EdCV3ZBUE8nGJORx
         Tj+zsoevZgaf7rNJx/nZ1FG/L2nsI34PydFC7UQlrNeBOdnLSrbDRZG4c94sRjwsuccY
         O45g==
X-Forwarded-Encrypted: i=1; AJvYcCUm2ldnyh7qeAZqpuYU4+EP55zwMmy+4uUFDk+sfMpzrnx5ijQGgsVQL+8Qu3Mw9ExnfwHr8iLkzfs/wrM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy02NMg8BragbLSiocIEcn+5jiuwXOiAKiRKMXFOLGjSXmALMK+
	/IDNLZba6W0qqyjcBwjkL8k/saQbXNCimER0AB8Smfk/LMvXgwzxXzqZB4+z14yCqJ1+QxZBENE
	y3A==
X-Gm-Gg: ASbGncv9qGp1wKI3mjtJ18xjrsMZXQ/+0fedobvgkvPly3VntHZ2rFkXcC/4i929AXz
	LXiSg0wtEQISycTB4zwnAbfaGjtir6rmz91og2xcnIu8hR7icNS7jUkZMReK2RN0JAA4awM5edd
	2mrapvtTLCSGxz6z8s4aOxzTEngh8+CBlcatPtk+XKJNUFhFp6griqO2ivhjoplM419tFtr0b9u
	JeeKJ1xHEo2toFglzjbkGLu58dOuAyeN6maCxHE5yXdY1XawTsS2dVmbAxkfNob2lYWfHb5dYrT
	vUWbhhyd9vmreAR1tZvZQLFGVC9eK9VsuTQ3TpbXeFFlDzPL2LlTFqfEYMuLW+ou+hIcSKjAm2s
	q2o+A3sy2
X-Google-Smtp-Source: AGHT+IFYR9Dse/MgafZLv5PQVQGW8GquvRx1NjmV64fOUMZPiGSEeM18a5178lA1mCLY9qi1UqIklA==
X-Received: by 2002:a05:6512:220a:b0:545:d35:6be2 with SMTP id 2adb3069b0e04-54990eacf31mr1564874e87.34.1741363836815;
        Fri, 07 Mar 2025 08:10:36 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1bc53bsm526232e87.191.2025.03.07.08.10.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 08:10:36 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-548430564d9so2219944e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:10:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUTT7/Dx7w0X1QcD8RETjFwWkUVdEckmHpQtl5Vxe9uVz6UsS6rZwt8dfEDOUL0nTwbWNwYDu8XTByC0jE=@vger.kernel.org
X-Received: by 2002:a05:6512:2342:b0:549:8fd0:b44c with SMTP id
 2adb3069b0e04-54990ec5bbfmr1722953e87.49.1741363835007; Fri, 07 Mar 2025
 08:10:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-uvc-eprobedefer-v2-0-be7c987cc3ca@chromium.org> <20250303-uvc-eprobedefer-v2-2-be7c987cc3ca@chromium.org>
In-Reply-To: <20250303-uvc-eprobedefer-v2-2-be7c987cc3ca@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 7 Mar 2025 08:10:23 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wc8MZJCMa0oVz+2ANcZa7FMzkgyKj44PtASJCWbjA4jw@mail.gmail.com>
X-Gm-Features: AQ5f1JrYE6wNhWN1IQoJ4WiDPzV24CvveUbAD2Aadpoa94lyFox1wzlIVOJObxM
Message-ID: <CAD=FV=Wc8MZJCMa0oVz+2ANcZa7FMzkgyKj44PtASJCWbjA4jw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] media: uvcvideo: Use dev_err_probe for devm_gpiod_get_optional
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 3, 2025 at 11:07=E2=80=AFAM Ricardo Ribalda <ribalda@chromium.o=
rg> wrote:
>
> Use the dev_err_probe() helper for devm_gpiod_get_optional(), like we do
> with gpiod_to_irq()
>
> That eventually calls device_set_deferred_probe_reason() which can be
> helpful for tracking down problems.
>
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

NOTE: If it were up to me, I would have also changed the caller of
uvc_gpio_parse() to no longer print an error message in the case of
errors. After your patch here all causes of errors in uvc_gpio_parse()
will have already printed something, so the extra print is not
terribly useful and just clutters the code and logs. That being said,
it's not a huge deal and I'm happy to let owners of this code indicate
what they like. :-)

-Doug

