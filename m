Return-Path: <linux-kernel+bounces-244010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40504929DD4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED62B2831C7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8347D3BBCE;
	Mon,  8 Jul 2024 07:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHluF3Ik"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B21738FA1;
	Mon,  8 Jul 2024 07:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425595; cv=none; b=flr7KlRg4ADKnoH64yI9B0RjOS7XG5Lh/ZxkhnK5YDEoA1s/EpRqDmHTrdzbx+jnJLaaX3lkHbmYaq8JjaFTKjgl9UeA0I0YBDQnmuudHmUDRNh410Y9vVryGr9dpn7kKc8JbXwU//cAv1a+IJCWYMa0+UKXTYcyargFOtXtdu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425595; c=relaxed/simple;
	bh=rs6JcL6vNDmIMyLHr4sEqjRKenwYOM5DCBPg4j4VF0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbhIWXFqovhXuZ8a1nQjKAh8LsH18XScYsCRvlW8sbgwVwCH5mI6/YMCG8KjPaapYX/18HP3KeuJc7Ye8bL2GowJvsKzlM46XHc/03byB8TMtlN/SnQ4t3c1Xyy6Exsn+YMErxHytzOWmd1uQdPqKlc/kb7RBpoo4u8rXPkC85g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHluF3Ik; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-447f0a76a08so4402231cf.0;
        Mon, 08 Jul 2024 00:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720425593; x=1721030393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rs6JcL6vNDmIMyLHr4sEqjRKenwYOM5DCBPg4j4VF0E=;
        b=UHluF3IkE2J56VNAsUetfBF/yrOEyAN605DgzzkZ7Csux8PkQqlE05Wqbg81a8LZjo
         qCPlOJyQi3phRrpOHrqb4FNnC2iA3C2qnv50ocr+rvyu6xSgvwgFOhr7vp6zpDD9u06I
         N2fn9NBw4eejwxNTziDE36VQJLSDp+psSsVFfh8+CcwF5tjWODbsekl9no9g1kNRP4/V
         u4MWkzwhsGa5704t+JNLMrrlAhXNIn89+pWS8FX6LPyMVWNbXMtbT0BxmPHic2Tds9Kk
         yW+Mk9PcB0TQ5xTCDenEAdJPE8bwBELHZ+Vx3I2xA3y7YFkuYfh0tLh6zeYecwmHBDmx
         dw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720425593; x=1721030393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rs6JcL6vNDmIMyLHr4sEqjRKenwYOM5DCBPg4j4VF0E=;
        b=ZMiDu8pav/DwJN+IWoAOhl3ZrwG3m2O8CdppWOVDp3kFrBqzHsB/jjx+WloGCR5VkR
         aSM8wgtNRYXjfzUnsxvk6wpH3Gk2EI1TgCoebHjg+DTdi1E4WxWXi6DUE+gjif6dFl3n
         8EbHYZ++Qn7i1scUr2YQuBazzuh0lM0vJhU7t/m9hVVlyVKwsj2nsNfLbDzTM9/iyO0r
         Caeg2/6k7ROTMhxIerD6FRlX2uT6bUWDts6iVVDvSAIQNogG5HX1KIciJ+hxxw49dcAn
         cPHfQ+Re123LYrUQ5dFR3r0tk06iaw4E3uEG372i8ciq4Rcjx2Wpp+4jTCaRiyWHB9/+
         oeeg==
X-Forwarded-Encrypted: i=1; AJvYcCWHpie7PiXWoDwaZfOBts01GazD3XQ0fv7NdHUFvFW0d0jogCX2YxNbzAZHCfaFhH6TqfdnSMT8MY2LLZcmA9OQwzCLkZruF1ff5ottmcepNu7pgh6YFB4EKMR+X6P0YmScx/tlcZx+uQ==
X-Gm-Message-State: AOJu0YzRlf8wWmiHngNnMhyeVO8jff/6kqP/11ffY4ZZhjyzasCckzhG
	QHcnSn/vg5afpWitYaUBw/csM9XLkFza2mIoPbIEuDe06S1XUXps6wC49p8jOSHpOkIYZLpVBg+
	gSlMGWoXp3YQweN2AMR3iQOuK+D6VXkrnkCOVvg==
X-Google-Smtp-Source: AGHT+IH/VkfDIhs6MN4moaEli4OluWsChfXFbrXfH1W4zaZXzfmzxCus8rkkzYzz2iIioaZ3+7DwykAmfvpfNMasWUw=
X-Received: by 2002:a05:622a:40c:b0:446:6824:166a with SMTP id
 d75a77b69052e-447cced7b40mr172582011cf.10.1720425593179; Mon, 08 Jul 2024
 00:59:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
 <0418B5BB-6759-4BFA-BE6E-F5C7FA0CBF4F@gmail.com> <2236519.ZfL8zNpBrT@diego>
 <1E6ED98C-BD49-485D-9FE9-9E7CAEDB4564@gmail.com> <503ECE3A-CA1C-43A7-AEB2-C0000A930B3A@gmail.com>
In-Reply-To: <503ECE3A-CA1C-43A7-AEB2-C0000A930B3A@gmail.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 8 Jul 2024 10:59:42 +0300
Message-ID: <CABjd4YyY68dcA+Z0nWAUq1UmVLeLw52Pg6NGpzcW=WMNX8ioqA@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] RK3588 and Rock 5B dts additions: thermal, OPP and fan
To: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Dragan Simic <dsimic@manjaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Diederik de Haas <didi.debian@cknow.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	"open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Piotr,

On Sun, Jul 7, 2024 at 9:32=E2=80=AFPM Piotr Oniszczuk
<piotr.oniszczuk@gmail.com> wrote:
>
> Heiko, Alexey,
>
> After some more tests: is varying fan-speeds working stable for you?

Yes, in my testing on Rock 5B it's been stable.

> In my case - 1 per few reboots results with board enters state with: cons=
tant full speed and no any reaction for cpu temp.
> In such state - I need multiple hw poweroffs (remove usb-c plug) to get f=
an-speeds working again.
> When board is such state - all seems to work ok (frequency scaling, etc) =
except fan is constantly full speed=E2=80=A6

One thought: could you please check which thermal governor gets
loaded? I used stepwise in my testing.

Best regards,
Alexey

