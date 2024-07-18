Return-Path: <linux-kernel+bounces-256833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99835937104
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 01:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544AC28231B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E789614659E;
	Thu, 18 Jul 2024 23:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Po0/GAeF"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA3780C07
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721344326; cv=none; b=ttxTFFp3kfsCqVed2vQ4oR0Y1y6PLsa+POmF2qsfR4ZBMRHJ0q3/3QzKPVrkVg+78YGCyZxYCMtQax9tXs+0i3ACP4je0bhtkAXwL/kMaCdVMYWwB8ZoTaXE9h3IuWgmNW4mQm0mm3H8qKsTXH06xFvnUaGL633MmJDFtad4sWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721344326; c=relaxed/simple;
	bh=7xPyN/a++eW85lgR9HwYmEav3SElM8LKOPms+Vep1Zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bsP+ijMbJklx5+0oRgK4o6n3Zr2JFNi7f67aFH4z7x7weiYfB9VUEEVv1niYrHjKwwmbtaR2I1r+xhLmGBa/oxIuPEBOPGu3jJ0R+ke+bTX7cSxFs7W8vdi+9jb7XJSVPDUYoXUkYXb0evbwSRq/N5zPciNDmHdafbz7kxaX0K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Po0/GAeF; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-708cf5138b6so1077850a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 16:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721344321; x=1721949121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9khtoctNp6Gh3eP9HY6HLZ7GyEjG4eZ3UQ7stBpEWc=;
        b=Po0/GAeF+4CpcKiuBKrfubZcLYgBVpDCRSUBY4HeBOJ+jX7eEG9oJMNgyiLkG39EKU
         5M5fhaDmw4x5Tfu+l49CzKiNv9X9kY0EA60PEk2uS7TlOo8Z4brOuOB/CeO7WSiWI3cy
         Px00XIFUj9FmDZz2jyT0bic5gi7IiH+UUObZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721344321; x=1721949121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9khtoctNp6Gh3eP9HY6HLZ7GyEjG4eZ3UQ7stBpEWc=;
        b=C9lWCqynWTy2qkvHi3a85lNTwtXXu0aunTXCeDMxFV1TZp1jZaQd99HJ0ogpBH/f+S
         m8HE6smLwsnq2JD2x5xoEBpy6WT8LZcPz61aeE0Ano/3bEATVrHIukdTN6OluiBRLgG7
         vO9Z+431OhFxrik1cyKR1Q7dPLoaX9EL1oMHrjQ7YP3iHb2v60JVNLzhfutkqjU8zLI+
         GceLEshjZFqx5FjJihD9SuXD0niqOMKByUBfBSy09jEN1IEImEVPvBpo4i7pQca2ODJM
         v3sHRXUTY7W1jILOcKUwpMjX1GDJdEwH82HFqaRmpMzi6iqOSx4yzRQhXn3aAP/3fuAY
         EMhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwfnwHBzXyM10qYYU4IZeIjSCQ5Tiip8Sra2dsnS2xkOf8g4p0vud+406fZC8v45EBOZaNVD0NQugZpI0Cz22dKB7pt8PlLURIN6mX
X-Gm-Message-State: AOJu0Yz7TNDEmE7Ih5+Ok5EibtURCj/gWPO9eMyWd5DbJmhzAjAfK88J
	epH22K77ywKK/hYgAnSiGzBfulo6+VLRH8/BQbFZGmXhFpeQaPxbtWUk4ecacuvpGHflcB4tQr4
	=
X-Google-Smtp-Source: AGHT+IHLSXl7U35TXWNz41N5zyfCP4Tres4xY8itr66CSTXJ3q9VV1mfKm1jLEQBt9iBGAkdnFlfQg==
X-Received: by 2002:a05:6830:380f:b0:707:e28:58d3 with SMTP id 46e09a7af769-708e37ef7d6mr8092487a34.25.1721344321284;
        Thu, 18 Jul 2024 16:12:01 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a199078165sm10545685a.105.2024.07.18.16.12.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 16:12:00 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-447df43324fso66291cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 16:12:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQJZWjzm7yx93xIoTSxD7ymu9b+ehExcMoWavZGTdb/NwIHlOZ6PWLtDOSu7OTpUnVBrjqnvcHd9OXRGG4G7pf7ygSGWGeDuJEzdFm
X-Received: by 2002:a05:622a:4187:b0:44b:74aa:1838 with SMTP id
 d75a77b69052e-44f9c6519cdmr636121cf.5.1721344319670; Thu, 18 Jul 2024
 16:11:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718184434.6307-1-robdclark@gmail.com> <20240718184434.6307-3-robdclark@gmail.com>
In-Reply-To: <20240718184434.6307-3-robdclark@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 18 Jul 2024 16:11:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UDopTSfpfzjUDPFQKyhUTNOk9z_Q5qnH4Up24M0xZoPQ@mail.gmail.com>
Message-ID: <CAD=FV=UDopTSfpfzjUDPFQKyhUTNOk9z_Q5qnH4Up24M0xZoPQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: x1e80100-yoga: Update panel bindings
To: Rob Clark <robdclark@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Rob Clark <robdclark@chromium.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 18, 2024 at 11:44=E2=80=AFAM Rob Clark <robdclark@gmail.com> wr=
ote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Use the correct panel compatible, and wire up enable-gpio.  It is wired
> up in the same way as the x1e80100-crd.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  .../boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts   | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/a=
rch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> index f569f0fbd1fc..37ef05f8c7e0 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> @@ -592,9 +592,13 @@ &mdss_dp3 {
>
>         aux-bus {
>                 panel {
> -                       compatible =3D "edp-panel";
> +                       compatible =3D "samsung,atna45dc02";

Instead of the above, I believe you should use:

compatible =3D "samsung,atna45dc02", "samsung,atna33xc20";

...which makes the dts work without any code changes. This is what we
decided upon for Stephen's panel [0]

[0] https://lore.kernel.org/r/20240715-x1e80100-crd-backlight-v2-0-31b7f2f6=
58a3@linaro.org/

-Doug

