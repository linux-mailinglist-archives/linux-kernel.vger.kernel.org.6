Return-Path: <linux-kernel+bounces-401321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F36CB9C18CE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95E828452E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8D31E0DE2;
	Fri,  8 Nov 2024 09:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ke1fw9pI"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87911E0DAA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056964; cv=none; b=d3wUmhOPbMyOzhued06o3AnUjYhiiVZG2r8BfiRx8aD9pZUtOkTEyXvzDCTtiO+wbsNDg4VGc95W7EQn8MEqrGn7XALVtjXrC1xutFfW65rcpkzrYntaVCL8j3EO3pIrQhItAtyFbVi2WjNGDXSOljsnmg3ZlDUqYzdTjzKjTms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056964; c=relaxed/simple;
	bh=FA4vkNb/mitqyAciN2f5UTCEggzC8PzDjAk9Yl3f00E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhCb2zEW0nkZ8twWDDLg8WlUd4J0/0ctzN25n4TV1okqnhDn3rrTz+piCcKvI8lUzsAJRtfTa1OZkrWRa0fc587rBpTV40n8aAPRFXb/Hw4pgi05KsaPleuKzYv2Vs8MmglfL/TCRT9Zi1thp6mOE94cIMPERz4KHT9mFIa/66Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ke1fw9pI; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb4ec17f5cso16026661fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 01:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731056961; x=1731661761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FA4vkNb/mitqyAciN2f5UTCEggzC8PzDjAk9Yl3f00E=;
        b=Ke1fw9pIz5UfqKUPmgbYSC5Qa8sfPp1I7nVcrq4XW2W12/DHpbfnDpygH7X0mjaSvp
         xFlIGMw2bB/qTC/ky79qW7v4QA+2wqDtbSxShDyFmk1iCkXuxQb/EpNMW2SfGglhQWYn
         La088s1PWHi62Trnac4JXAvu+ryJ6QGA1mjcrDexEicB/qlIPS+jXN/FNpOLXebxhvFN
         UZJYaWNP1EfStZclagbmRV41+O3jDcNt/BHnL0JhPJ0MHjqu5sPGFL2TCsgRjtFAL99p
         sBZVIiKcoulsMDisxHUG8Lo8s9HimEvJN2LdoOCEW7iy/4XO7TXPEOLrtStvfv9+sQhz
         7mpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731056961; x=1731661761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FA4vkNb/mitqyAciN2f5UTCEggzC8PzDjAk9Yl3f00E=;
        b=ff0Ou8jDW8+Es++Gtxxjd8OR7EDz9igM14hUku5Kq1F91AQ9stIagjxKU0EeAM+bWx
         rD/c/Lc39coAR5SAAqqBfSYsp+1cwuaEn1cZTNn5Sxnc/Ql+DBhclglzTLsB3f9P5Cnv
         95+iReGo9DvIQxOuE/vKNzW4bWIMZnvd3uvtBE7GKBNgtw0IKm3i9FbXJv3kFuYf/x8j
         J5dH8VCSCgb6H8IFD3MToTeNzMscwRTnkhv/a34bHYU0LMS2KVKQX9s/9/aDQJIwtd6M
         +zB9M0jlFhvBEu7ckMrS2JkiNxnfAPerut3254uTZOplpCLg2qptyKd0fKD3PpoMrJP/
         +eFg==
X-Gm-Message-State: AOJu0YxQb29EcbwyvG69pQxJxxStWmojDca4uBXxS2JR9yXbVCrThZiF
	tOriBAeh8Uybi7v3uOJ8dxCOgPd27dLjQfchToLAhuBdzEsTLjoRoi+YdVrvpEbl9vUT50JVf7m
	65ZEnIQ+L2wxms0KmcP0oajWwWCOMSHsqaIRYOg==
X-Google-Smtp-Source: AGHT+IHhr+fMSbLe+Spkx6S2HAMA1BNkht2ZD+kKrNtINXG0wH4E9HYyfyu1IwPxOm2Qn/Xqfjd2BS52cNcB5ulPJ58=
X-Received: by 2002:a05:651c:211f:b0:2f6:62a1:25fe with SMTP id
 38308e7fff4ca-2ff2028ea31mr8862541fa.23.1731056960773; Fri, 08 Nov 2024
 01:09:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105064206.43626-1-hs@denx.de> <20241105064206.43626-3-hs@denx.de>
In-Reply-To: <20241105064206.43626-3-hs@denx.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Nov 2024 10:09:09 +0100
Message-ID: <CACRpkdZWDZcekXBJcW7XkfrmPiQqAiECVF_S9DMcFMMgRg8qsQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: pinctrl: sx150xq: allow gpio line naming
To: Heiko Schocher <hs@denx.de>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 7:42=E2=80=AFAM Heiko Schocher <hs@denx.de> wrote:

> Adding gpio-line-names property works fine for this
> device node, but dtb check drops warning:
>
> 'gpio-line-names' does not match any of the regexes: '-cfg$', 'pinctrl-[0=
-9]+'
> from schema $id: http://devicetree.org/schemas/pinctrl/semtech,sx1501q.ya=
ml#
>
> Allow to add property gpio-line-names for this devices.
>
> Signed-off-by: Heiko Schocher <hs@denx.de>

This patch 2/3 applied for v6.13.

Yours,
Linus Walleij

