Return-Path: <linux-kernel+bounces-247696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC5C92D34B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 144AEB26FAD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9D8193067;
	Wed, 10 Jul 2024 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kZjJ8VbB"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDB24A3F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619146; cv=none; b=l3DafOedFkIsvPbhNMlvk0Jeh2yHcR2jorAHOKG8goJKUlLBUa24n74f+dTbjSh6SKx6j3bp+ttAwvNgI9w5JQMjy8BAO1xoLRf6ubOHMEzTnHcZm8pAXR9cayH/YhfGM/UvJz6AvGNTeNUy+KIRVYnUmYGK6DQPWlkk87ap5mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619146; c=relaxed/simple;
	bh=nBZya76Wm86h/8wItky+O7Gdjz38LBYG63PU9pDmJVg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CbaJBFzYKXSqGIe1luWub2fPl87GM+3ECxj7cbcgkoabh2IE0z7Jxet2ueaaAbMVgYWS0kfPvjbAspw0/3X7udj2IvZz9/LPT6wy9iOkiuW+7oZPV0tquB1hpIigd99xbDUh/Q8fBGnkMd91a/YWrTkgCP9H1YaVEkqBwu9cLjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kZjJ8VbB; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so84516281fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 06:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720619143; x=1721223943; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nBZya76Wm86h/8wItky+O7Gdjz38LBYG63PU9pDmJVg=;
        b=kZjJ8VbBhaQmH4TwuB/VUbxUBREwgkq51axvF1ENBmfHyhbX0n+8X7teGOtvVPEczi
         tKJRRICI5t7lKRMoAuRG6aiV8AiWMzAmU9cZYuji1xJL915tEl0aVagM92N4h57EnUAx
         xDjj1WJ0rIdUUnp/pWzTnt9gCjvBojPLOkghpmTlgIJ9dwsFcxEl2Pal54LkWyht3k71
         3y/8JSIG1HcxOdyvuPYLzAjFptYtHGFk4t/V1/FQlwv6R8Nj85sXI4JnZd3befDjb0zd
         OXa3Smgp5MQDjUIqDTPtF19JmaGJph+TVhpCX+c0w1xOakNu2YFs3rIX9Ldlnp21TXeA
         5HEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720619143; x=1721223943;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nBZya76Wm86h/8wItky+O7Gdjz38LBYG63PU9pDmJVg=;
        b=aEDZKj+UmuWAZU+W4WmUHkZh21JM6bq3qc0TwAvsi5kfrVeiJgsOjSZneAQHYU62Hj
         QvK+vdcEL3Oi1g8d0N+eDSqiHT4Y0rPkChX/t7FGdgtF4st0M3QdkjxeSkpBR/k8z0ji
         so+bmwqfMyLTCZL5Y/HwC0c/6pmFk1YSCQZ+J406IleZEh4ZeFDZB56zaGw1t8A0pwd3
         jtfmhn3xOZiMNTWLV7fHbFHJjkaWyoPCHbI97YGossplSltM3XnQSoBQlk0uxz22pDzT
         5iZLgr7ydmhC83Vleke7vq7UASbZHWOYMKg0zB4HzD78wKnk7j1yRPfiV/2EdKsXWKrM
         r2+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUU1eldmy+1njvgrg5N8hSXdoka4/I/QccHVKRy1uGWe0qcz/LkDdP8Lj3d77XeIPYT1C8zW3mGJ0OXZe48QLo8vwvGx4lPUPnPEwkB
X-Gm-Message-State: AOJu0YxFYm/q03bbitZ0x3yaK3uoaXMIgb4KrpKaB5dwq7vJZzSDWsVj
	oqkIQ2NcwmZyxkdK7MD1siRSyZq9Izx0iA75Hmv6Md9VduQItj0iulY4fS49qqw=
X-Google-Smtp-Source: AGHT+IFxVH7DKj1n67o5WR7wEDepIOdPrqplzYbVbu533HXdOYfMvD2fJtNIVNrSrVq4QHOwvZojNA==
X-Received: by 2002:a2e:a4d8:0:b0:2ee:92ea:8d0a with SMTP id 38308e7fff4ca-2eeb3102734mr31637631fa.23.1720619143259;
        Wed, 10 Jul 2024 06:45:43 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6e09e5sm83564695e9.5.2024.07.10.06.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 06:45:42 -0700 (PDT)
Message-ID: <0a47f15062ed65048fbf8ffb902e28fe13a625c0.camel@linaro.org>
Subject: Re: [PATCH] tty: serial: samsung: add clock comment for earlycon on
 gs101
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>,  Jiri Slaby <jirislaby@kernel.org>, Peter
 Griffin <peter.griffin@linaro.org>, Tudor Ambarus
 <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, Sam
 Protsenko <semen.protsenko@linaro.org>, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org,  linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-serial@vger.kernel.org
Date: Wed, 10 Jul 2024 14:45:41 +0100
In-Reply-To: <2024071030-gravy-backwater-88ec@gregkh>
References: 
	<20240710-samsung_tty-gs101earlycon-v1-1-bd0f8481542a@linaro.org>
	 <2024071030-gravy-backwater-88ec@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Greg,

On Wed, 2024-07-10 at 15:40 +0200, Greg Kroah-Hartman wrote:
> [...]
> That should also be in the comment in the .c file, right?=C2=A0 Along wit=
h
> the git id that you feel should be reverted?

Thanks for the review!

I didn't really want to put all that text into the .c file as I thought it
to be quite a lot, but sure, will do :-) and also wait until we have a sha1
that I can reference before resubmitting.

Cheers
A.

