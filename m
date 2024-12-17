Return-Path: <linux-kernel+bounces-449750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E749F559E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7FF1890FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7B81F9AAF;
	Tue, 17 Dec 2024 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a183yPZS"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E681F8F03;
	Tue, 17 Dec 2024 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734458473; cv=none; b=Gmeyc79rC4b76pMw9ytlLtRqSQbq5BED9fC/8vRP7h6gPSm2urXu2rw7kcE8DHtIYAWC+vfHHoeqG0aaxaJDTft9+oQHstw5n1btWxilfynUvSDZ9cwsyrB9iR0fsNHPqI71bvPnOGPQAhldr/xTVwtBZHZQ6zVEFXaysFvZNQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734458473; c=relaxed/simple;
	bh=QC/c1n5Jks7m2uW84qsP/rNoe34vEW18ChfBNCtXubc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P5ov4lN7fSC5OJzZdWJKwbLkhujz8HAmf9efICQNtqyyrfc9eFf6HrK0q026XWitimrRitcLLzYY8q6pSr/sECpjmLJQrjTV5ksa5KMNSO4bkpUbsxOPRAF3TZE2C4e0+1yS+OLezzE2lBYQ1Ciet0viCWf/LBnWdQXHC4ZE4wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a183yPZS; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5f1dfb0b44dso1255501eaf.2;
        Tue, 17 Dec 2024 10:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734458471; x=1735063271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiwHnId7iQeGUr8OsM8sKryugiv1jIm1WvtUfh1wJ+Y=;
        b=a183yPZSNTFegk4wKgQ1DfY5H/zESXErRxmTJRZlnWa1z9xShD3/rMfeYm3QMFSZ/5
         TO0aFM0Wykf8Bdv5LPDkzbkMLU/ATbgPgKtnuWPwJrVUxIxqal9QkaPIAr2s+8xG+AJK
         asrELk7i7LC30H1Bpuqiamxpx7rTTR4ITjr7X/ZtETahfRoHp8F2XFdIYWJmjMQv0PV5
         GUpPLXQ2z2UPvLIN2fN2mfacCYgU3fOijqPZ6wMtgBZ6KOQ/U88yui4pNUy/mZGR60/h
         lqqbKcJttNAMCK5KSZyYCTncIHQpz4It14en/CQg9arlAURDZLvGx+MFDicW8ac6rWY1
         ohuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734458471; x=1735063271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiwHnId7iQeGUr8OsM8sKryugiv1jIm1WvtUfh1wJ+Y=;
        b=CMplvC78WzydNiXilNzuL06RlzKR9k9TqCiayMJdlsBhm7vdLLSUo9vapHGYWavo1d
         K6+DgFigWO1c6mIYcBS6TcinhAttvES+CjaVllkTfZe9kgVKpg39Ne2Z/AKy7EFTxhgZ
         UiFT/Th69/Ep8MhDCfj7q/mGS5/ZnEq0hMfuuwBRCX4nTZSQq24inSnwiRtFgbIKfFIs
         mCOF8IaFYrEO2hMi4U515QSLGnnyy2AYKSR6Us4AV2oVXwaKJ6ntu2DmFL/0PAOuWH1M
         Og7rH25DSULEihoZsP+8IAe+LEbgs4tdeVm+/ieaR7ZUCPhIFeMQpldmJR+tmPUYlUKg
         S1AA==
X-Forwarded-Encrypted: i=1; AJvYcCUI1ZggJbvZa0PhanvRyUkV68C/9PBM3Qw+Yp7FNbigeSuhfFIkg51JwMV3hhn1y0YKl36Wj8QKbjX71RL1@vger.kernel.org, AJvYcCUbwvbNyw3m/1JsqwX2tQ3FWizr2BkLPizzpei4R3iIg0tfdpDiOeocHyJaFBrj2Ht0GvSNfXATugSz@vger.kernel.org, AJvYcCWcnusQnL03kkMliPeCOOupRkurZBHGJg+pcXKL1lc3C+CMAVDPnrHc9dpdqGEbbMHRu0BsrwKGHLug@vger.kernel.org
X-Gm-Message-State: AOJu0YzqS1J/UhDLt/HEi0V7Fen+VxZPsttL7o/uWSJgwDGTvytb5V7l
	uBx/s9gxxH9O7Op3kr8Qa0B3Bxr51YbxWX6cBI5Mgqdlkk6Zua5AlWWcCvhk62MBj3m7DZmW/8c
	T2el51g3Skm7WcJgot8nKxhiD2XM=
X-Gm-Gg: ASbGnctisSWtkJ+r+Sl1WkAVD2wm7/rDyN1q2oQdbHDBNoCHWTK9UMfJjsXCQIzQTyt
	c8QVq+EjDlpRUPj0iV+2p23yey5rwuQtez7LRu7QeMQ9FetlZdoRwU0wqZpZdd3yTEu6xt93e
X-Google-Smtp-Source: AGHT+IHd+3ZVfpm2NDJm9bWCoeeRHqvP9fk+8IUJThjwea2MK0kqPI6ZhSam/HTj+u/wwVy83PXt4Sd7guaeIDXPgdg=
X-Received: by 2002:a05:6871:823:b0:29e:2422:49e2 with SMTP id
 586e51a60fabf-2a3ac8e1087mr10260963fac.31.1734458471419; Tue, 17 Dec 2024
 10:01:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241215053639.738890-1-anarsoul@gmail.com> <20241215053639.738890-2-anarsoul@gmail.com>
 <qbtp4jvkx3r5azufe4k3vtapqpfs54dyjiu4cy5v5wkkzumrzx@vy3xzkfplbue>
In-Reply-To: <qbtp4jvkx3r5azufe4k3vtapqpfs54dyjiu4cy5v5wkkzumrzx@vy3xzkfplbue>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Tue, 17 Dec 2024 10:00:45 -0800
Message-ID: <CA+E=qVeQ8uHBCeFtw6_2cY3252-YXc6eWrf5_YdeVgbp5LJo5g@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: clock: sunxi: Export PLL_VIDEO_2X and PLL_MIPI
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, Roman Beranek <me@crly.cz>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 11:33=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On Sat, Dec 14, 2024 at 09:34:57PM -0800, Vasily Khoruzhick wrote:
> > These will be used to explicitly select TCON0 clock parent in dts
> >
> > Fixes: ca1170b69968 ("clk: sunxi-ng: a64: force select PLL_MIPI in TCON=
0 mux")
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> >  drivers/clk/sunxi-ng/ccu-sun50i-a64.h      | 2 --
> >  include/dt-bindings/clock/sun50i-a64-ccu.h | 2 +

Hi Krzysztof,

> You cannot combine these changes.

The patch basically moves defines out from ccu-sun50i-a64.h to
sun50i-a64-ccu.h. How do I split the change without introducing
compilation failure?

> Please run scripts/checkpatch.pl and fix reported warnings. Then please
> run 'scripts/checkpatch.pl --strict' and (probably) fix more warnings.
> Some warnings can be ignored, especially from --strict run, but the code
> here looks like it needs a fix. Feel free to get in touch if the warning
> is not clear.

Yeah, it is not clear what do you want me to do, assuming the previous
similar change to sun50i-a64-ccu.h did essentially the same, see
71b597ef5d46a326fb0d5cbfc1c6ff1d73cdc7f9

Regards,
Vasily

> Best regards,
> Krzysztof
>

