Return-Path: <linux-kernel+bounces-301055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C13B95EBE2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325211F23904
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B191465A1;
	Mon, 26 Aug 2024 08:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YizJB7Cn"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C09EAC7
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660600; cv=none; b=JutWJ1tCE6xzyOQULAZ2NC+hxyIrwhOM0NGK/I4hDgOJgTzrfjcb+naOHJIAoSKrdKEY1w2mUmx9d25xL7J0TqaHGcIUJ0N0ZIw3DGyMdnX4j6rrU+68tXeWMNl7/0s4Y5DMMpJdzA+dT2tq2F5Js5qWIf8m/Sq3F8XmR8QBTA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660600; c=relaxed/simple;
	bh=9nAlXzL3FCsDNJIv02ej/syTb5joWtGfbOwSnDgKRLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHvhGrAfaoCk0WSpurMK98S1rc1TL2U1CdeTXJiTREbIT5kOS1T1XdCUf3byOMohlnL/2WRmf1OoLNwLb5YkF3xmnTGVivD84FhTV45wUDloGlVZ9cYo92riGIaIQT+aY/0TBAOWFOjzZSw+3did1BZGCT8pwQHnCMdQmwGHnCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YizJB7Cn; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5334a8a1af7so3928301e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 01:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724660597; x=1725265397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nAlXzL3FCsDNJIv02ej/syTb5joWtGfbOwSnDgKRLc=;
        b=YizJB7CntvHZ9Uh9ReQZ855p2Roeh/fpWf/a28naZOUSo763bDBT7XsGxhbgkNXlCl
         auinHfM2kD+W26xAjPCfOMxIgVFmMHAJCPhWCRJnYPQfeNJV4A2y/1vHbcfoCecraNE3
         wHAHe8QgSrPczox04VuFFoKryjThpIHDAHHFbq8/+eZ7lvymCmQrWGOo9cg82sXXKPN+
         QhghcCE/xDYSWLqtEM4w2nEMxtN4v9VAoNJZC+U2VDY90N8e/xhTWFxvbZbXwVZkH8K8
         /MI/oDfhOmaT8SflwLEhfsXfAnGnkNUOk0BlfU7wNtgOtV1LSvBFD0pM773uN/tOOBWi
         t6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724660597; x=1725265397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nAlXzL3FCsDNJIv02ej/syTb5joWtGfbOwSnDgKRLc=;
        b=noPqMZhtuS7zRbhFWv7XLPWgIBYDLCWHgts53m9yo/+IwvHNEB7Qe+wEml2M73+0IC
         wMVvY7gppgUj6QNpFzTPa8ydwOTHse0Pr7vXztbegM53bIjyDO3lhWBxwwJppxH7dc9L
         ZXpGKCIrS6k72tqBSGT61k93mqDC6snJ127cMwak5VpBZOhjZIQTcbGyBcm7NOyY7Sr/
         wDE7+rULUye8vQuts02rucmnn82isMvfdUHrTcKjW1ovKkhtuJTF3EaB4SQRzanVDvrn
         tCGxjl25kvRjL3/9B3lqlMyLXEZ6KowzoMob4WkS1K/8UbQqLJDF3r6BooyNkvZKwvV6
         1k4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7dFVSPaQC4rIccdAmE2hCm4EOq04kqhcrSuOo51JMg5ZU9nrcLAxiixg7YfEC+zHKLbAhD+V5Lsk7/ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFhbIPZz1SKcQeTTEN2nqDJ+hGQcgrmr8l40okAF2f645ITQ8v
	ouoPvRbUEkqgK8mve9Y7hF+snNGedowboIXepshitBeeDWZaNSthgaI3AzplQ5M4Gzr9X442l/g
	/ubTEzQPbcB2JqRQ25Ki41l09vfj1LfTRGMtX4w==
X-Google-Smtp-Source: AGHT+IFD0cIvY5sWI0VrRFAVUnk0R6NAc1wx03gNBoGtjwDEW2puIzCfiSlZLDp8w6H4FGoOxcSVb8VWj1PQLkd0LUc=
X-Received: by 2002:a05:6512:ac1:b0:530:c2f0:4a98 with SMTP id
 2adb3069b0e04-534387c1ad0mr5852453e87.51.1724660596476; Mon, 26 Aug 2024
 01:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821121456.19553-1-brgl@bgdev.pl>
In-Reply-To: <20240821121456.19553-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Aug 2024 10:23:05 +0200
Message-ID: <CACRpkdadD=GPKKrS-=51BdKc5gZcUBJKxJpkZWYpfeN+ipCANA@mail.gmail.com>
Subject: Re: [PATCH 1/4] gpio: ath79: order headers alphabetically
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Alban Bedel <albeu@free.fr>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 2:15=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Put all headers in alphabetical order.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

