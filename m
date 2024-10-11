Return-Path: <linux-kernel+bounces-360818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BED99A027
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733AF1C22BB4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AFA20C49E;
	Fri, 11 Oct 2024 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0JYwjVO"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D55804
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638939; cv=none; b=f0jPtzxqZIJX+wdASrFEtNT8FuUyNP6jskuFc31PUar4ThStXH1d8RzbLUHud02XsSLjah3OlaNWjJ6nNKE+lFkbJlfST4jvrM3kxbQtv5goXNVc/5maATvOXe+q7gqxCHuJq9/PfVf634ZfxuIvVql2gvG7RJ22op+C6XspQSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638939; c=relaxed/simple;
	bh=DltDeVYJEIb6wjca1o7bFaNWh22hJNIaTsco4M0fMzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flbqtEWluQJ1g6/p8PfmjwraiCDK01E7YeCs3NUQLG9DPE3i5KGWD9+pVtfRYhjhSNWlVTbetyC9mSyqd+Un7szQd4JEUdmgFtI/barOJLOljJCOoTfzEgIKn1Ef+106U25ueQTUTZyJvJyj3cvU7AwukOEGcRUTjh6jyDThApM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G0JYwjVO; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d58377339so357071f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 02:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728638936; x=1729243736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TCoDAR3p+NDgfps8OlJnbGKnp0R3MeEWSzHOxiQY0I=;
        b=G0JYwjVOmsppUfkGh2OByNk70IarIL6uyAStv2jEJCq8DSCJpanb7SMvPcYJ2/xyQ0
         JRkGBm9ZAhnVkqdjtlRFW65Ue4D54da5VSVwkHWjM9ueHeaZzBGKw5MvWGrPv5jvqxZE
         dmPfbKGu3x7r5btEbBttkfSncW6G27rdP7tvLJyRck0jT0yhO14Bya1azt4I/+AM4Tuf
         NfTHcdMeaWBZBgKeLiY5aPRORKuZ6Euu8oTOPRyvqQt0A6YOlYyW8Io47v7LKFi7OFBV
         gEpLGJQVY+kH6ce75Lx9tTsFe4NxwDU81okz+USANS2sEsTcAMWAD2Z7Vf9WxPczMSaG
         d8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728638936; x=1729243736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TCoDAR3p+NDgfps8OlJnbGKnp0R3MeEWSzHOxiQY0I=;
        b=rTfr7Nu9zoDGzs4hmcgBfTZo/qEyY+0mVVSUDtlTpquTFbm8qhF8NcnVcUAkgkBIPc
         G6qHxMs7r/NdlJuHb5MoYCtX7CmZlfVgFpv4mESFcDaaB+0lfipwOFo7/QhvhCp/+Y+V
         eFLat1T9h5lqmV8i5T8TMWxz2BWnnq+Pnvy6qySLAEMpFY4qY/zrquUah765JRTYk0No
         B5pkD87S5NUmeojv4Gc8dwZjszJA2XtAABug2f7JXDM0ZtAwZS/Yrvg7e4Nj4DCR/3ay
         GhZ9YS0RTManLXb3pdkojEBvcr+UqLf1379ER8/QvtZa80oD/s1ICSi4Q819HsTbZOWv
         jUbw==
X-Forwarded-Encrypted: i=1; AJvYcCVcq2VwrLtmmwGtKYLol9CR9VCYkFaF1iNXHWbO3ZTjOthUHIAt/pjVQwoEylsob2CUzK94OpzPof5hAQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqC48bu1kabFevo+rVNH3yCglbGWmA7cpoesYHuUMBqYGRP5oN
	E9v4lkSfXiLCtKdcjol9RwAFvL+dZF9iN016+14L11+uXWyBPUYJ40L5Ui32FluemRntuS938gY
	ZteqVCRD+Xoe9XwvmeZA2qTqFxjDbtMqwWsYTdw==
X-Google-Smtp-Source: AGHT+IG8wW1q8UJWHHq4y9KQZM4c6D7AmGKumiUzVkMrFvBY3yCJMkHghO6Wg3mIMaH1uDi6/A1L+L4KOCuGGEPI4z4=
X-Received: by 2002:a5d:5270:0:b0:374:c3e4:d6b1 with SMTP id
 ffacd0b85a97d-37d552ade68mr1496679f8f.44.1728638936030; Fri, 11 Oct 2024
 02:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006-fix-postdiv-mask-v3-1-160354980433@mainlining.org>
In-Reply-To: <20241006-fix-postdiv-mask-v3-1-160354980433@mainlining.org>
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Fri, 11 Oct 2024 10:28:45 +0100
Message-ID: <CACr-zFAT9tbmH+YUBLazUjzH+uyjeKSewpd=XFr3HBd7=jaMwA@mail.gmail.com>
Subject: Re: [PATCH v3] clk: qcom: clk-alpha-pll: Fix pll post div mask when
 width is not set
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhishek Sahu <absahu@codeaurora.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 6 Oct 2024 at 21:52, Barnab=C3=A1s Cz=C3=A9m=C3=A1n
<barnabas.czeman@mainlining.org> wrote:
> Many qcom clock drivers do not have .width set. In that case value of
> (p)->width - 1 will be negative which breaks clock tree. Fix this
> by checking if width is zero, and pass 3 to GENMASK if that's the case.
>
> Fixes: 1c3541145cbf ("clk: qcom: support for 2 bit PLL post divider")
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>
> ---
> Changes in v3:
> - Remove one of the fixes tag.
> - Link to v2: https://lore.kernel.org/r/20240925-fix-postdiv-mask-v2-1-b8=
25048b828b@mainlining.org
>
> Changes in v2:
> - Pass 3 to GENMASK instead of 0.
> - Add more Fixes tag for reference root cause.
> - Link to v1: https://lore.kernel.org/r/20240925-fix-postdiv-mask-v1-1-f7=
0ba55f415e@mainlining.org
> ---
>  drivers/clk/qcom/clk-alpha-pll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi Barnab=C3=A1s,

This patch fixes a regression with UFS devfreq on msm8996 (introduced
with the linked commit in your patch) so:

Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>
Tested-by: Christopher Obbard <christopher.obbard@linaro.org>

