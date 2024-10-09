Return-Path: <linux-kernel+bounces-357421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B7E997115
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6131F262A4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1141E9076;
	Wed,  9 Oct 2024 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XbfljYFi"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF151A3AB8
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489972; cv=none; b=QG7gYrE5q5GEobpEI4I0L4Xd35QGWOO7XEpnlnaryTMcpoqch+fgkMz2mC4XPCttLURFZSrmQeHM6/0185XMHZ7Hw+38hZ51JdjI0SNVbcoXfjfplt7bNKnkO6+3HQZEDzVb63wgG/z5L0jaEb/9cDQ0DGrXPnstW6/01AYx89k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489972; c=relaxed/simple;
	bh=3Vge/iwKjCWd2R94XXdwXx8iYmEQKEaMiC60ptPZws4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBitWW3OhB+hqeayalqBZTeMo7J7dEanZhTzHzfEQC+r2eTqi2WGDN+vGbfRqJFIVmkDJZL5aZLLG4XXZhyNXFUSZvku9TVKog2BMbIs1XJGe2u1os8G42ybZoKSndxkRSVOZ9AYMtksnD/4MjiZ6xGvsjx1Ll/O0APTB02F8LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XbfljYFi; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e28fc33fd8eso1055552276.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 09:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728489969; x=1729094769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Vge/iwKjCWd2R94XXdwXx8iYmEQKEaMiC60ptPZws4=;
        b=XbfljYFiQVe6g4GlQOWOizSRi+/piasdMGDpUPjWcgwjVxqQ2reHMwBPZqQ0PsJoD9
         erRP/jco0xVCOuNbBAiX2/B8Zh4ujiibgkirTLRp1sCEvvSrfDwrIyMDqh+IAfgG/KGW
         S92QVV15VBxLdK48Vji40pGbXpsNK6zqmuwStb04Hk4EbQ2CG7YVndUZ4Qy53MKdmsWC
         Bcn3Jnq0++2Yo9FV74Jw46f1hsebv27L0czLuFh9fG6JxV9eMAodyj7X+iKEzhv35stE
         aONa+Pv1wtmHaJMYBkSfGbENlJ7cvVVAubSLYiEyIW7b/7O1NmyO7SWJ9Ci2ncAljtHs
         HWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489969; x=1729094769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Vge/iwKjCWd2R94XXdwXx8iYmEQKEaMiC60ptPZws4=;
        b=GZFxvjVP13OKRVYe+UUMkusX61ctVyLGboeooQhYFLfdiJA+qRRBt1o5lC0vYrI3W+
         d96By4OCF9Ll2Eq63XTCUMw1+kCOuGYH3pD0pZ5OOOdm2gXMRpE+QODtXt0kEsKvQ1KZ
         NZCaoFrWn+nGZjtewHNPaDakg++U+ZQvigON5MwRF5BAdSsCYAamNqExiqsOLT12K6cB
         hmvtU0el4/N5cJI7Az7mD0HIg7ANjIxmIWJdGbCZRlMANyxlM7mOPuBcxNNVFzARwiAu
         2xN8haP/wf8YgpeO0E9ilAK8y/pZKMyn25s39WPopb2h5C54jwDcMCWMNQTTZ5MD/IOR
         KPYg==
X-Forwarded-Encrypted: i=1; AJvYcCVYwoOTovcWlNpr5rSy+8S0ZeFGz+sNC3VRnT1Kll7U30ZUKRgvT7jYwfgY1VCviE1g4c11mvZddT2sCsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQRrQIR2MgZG50drnOcN7KKEnT+woe9iUP+Dscl5BiDL90QY0z
	6qkhTgTaX4XCxEqMR/wOh50+GRHe7y495QczXcU9CN++x4UuC86khpM1OSv/sf/adQ4pmL17dSj
	wBY3Ws/IrRRe1hz9vSBzjWalnXzE/ePaFoVZNaA==
X-Google-Smtp-Source: AGHT+IFcyreBzw5VlY3rdfyr3fwEFI+o5pWeKAPwPH/IpwyWII2FcOYUF3isT1hLnHPhuyqMZAnzxrDwH/EoiLrn3Os=
X-Received: by 2002:a05:690c:dc4:b0:6e2:1467:17b4 with SMTP id
 00721157ae682-6e3221317edmr33059717b3.9.1728489969296; Wed, 09 Oct 2024
 09:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005-power-supply-battery-const-v1-0-c1f721927048@weissschuh.net>
 <20241005-power-supply-battery-const-v1-1-c1f721927048@weissschuh.net>
In-Reply-To: <20241005-power-supply-battery-const-v1-1-c1f721927048@weissschuh.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 9 Oct 2024 18:05:56 +0200
Message-ID: <CACRpkdape9jmyw7dXBkzxcrMx5oFk0e=nBBbRW9QncDJptZ7UA@mail.gmail.com>
Subject: Re: [PATCH 1/7] power: supply: core: constify power_supply_battery_info::resist_table
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Sebastian Reichel <sre@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 12:04=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:

> The power supply core never modifies the resist table.
> Reflect this in the API, so drivers can mark their static tables as
> const.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

The series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

