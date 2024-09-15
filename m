Return-Path: <linux-kernel+bounces-330000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F76979850
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 21:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18CCB1C21322
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 19:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CF11C9ECA;
	Sun, 15 Sep 2024 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="D5RQkV0S"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6941B85EC;
	Sun, 15 Sep 2024 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726426978; cv=none; b=oXgxHEaIXyJMd1lfPgM6Hy+kltqquM+BIgDT2MiP8BvDAvHVwPlT8RGYoNT//CEHORdpNEq+GFqDcqTGuJYCqvJ1egt5UYF/cOXF+gH0Gx5rwB42QtF42GDmvtj4w3SgPNioft1i+nhsRtsWQ7arXLTTugzs5AJS2RzfupK/4Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726426978; c=relaxed/simple;
	bh=incBIIGh6/Nb8jqbKnb1w2E8rNeIc3tWZZuPGZv0P+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYW7JFN/rZuitfToPuM6rz0SbruS3lwbQ2v9EpNdHB1dz+QlLtPt36mPKuGB0ezU3PaquUhJlpK0DSkjsN+JsT7NsfOQRiZFVESrtDMp04qvvviN1jFyisfMqrJr4qQheuo9vaGvY8zFeXUipnAZRdc+GDoagN9TtVvNX6lVjEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=D5RQkV0S; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20688fbaeafso29104055ad.0;
        Sun, 15 Sep 2024 12:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1726426977; x=1727031777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4UOvVGZ8GtKwRInuJIT2ch8XFkLj324WspKyPQ0xaw=;
        b=D5RQkV0SxNk3csv51Jfs5cc6ctiv/zwAHLEYR5WJqifpno0ZY2macaBTLxcW2XsrM7
         Prqw7jOSrJ84E2EwNfwZvt25fKTsshZsgoFWNW+G5WgVlq9VsGwZaaIRzhrCJcyOmwBx
         SetW2k08rm5a4Dv7bK5qLumOJKtd2Ic2NmH4k2OSF+pNHlhBLk0vs6XnVdDdIRt93pGt
         sU88oFu8EiS2cToFQaVfiMjpPzALWjOWlko6fCie7ae32bhQdy7f0EUIt/dkKc2Yp5ps
         w9WD+dU5BZ0aOd5/vfVeBJU5EcMZ1KF11h240ZYJY3HpTiKMHFq7vqAM4rY+uT0Vwolg
         RALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726426977; x=1727031777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4UOvVGZ8GtKwRInuJIT2ch8XFkLj324WspKyPQ0xaw=;
        b=evYiGazhvM0svXlL52CzxWheP9DuMfXH6PMG7i5804UgFZauzJUFDROcQTCQPyTGVs
         4LvjlklScXsEJnsMkKLXnXZX21XIsrwy1ynL8tnxyJVeTJUOqSnmLD1J5pbEWMnK1kUw
         BhRu/R1mI9EevB7wD97aByAgytNX7FUp3bcwAcMzZVw/ZLCx/J2YwpQmDlKpMvqijTvA
         NxKYxx+Rba/R86xyOpZUWQpc9/p9qJZriP+hi7jb31gMpb4XLYLx+WcygIumvi1XnY5C
         TnpFxUKxhMH11Nu6vtQ8GfldaFuaJ5tXj9duhZ8IycKATxMlO2iWj/js93n3tkIKDsTs
         YvhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9zjnUWtJFiWnystlf3u9fu6KdjWD5pOyxDxKE1YqFF0DEqeR3xLJVQfPHCu5edhlH0xrc0n38ENFvGkUR@vger.kernel.org, AJvYcCVX1NX6Ux+oim3OGtV20pkZd8dx7oldeudwttzSPG8HwfVBjmKSG8tddsNn94+YCCZ9kjU9TSIEEKyY@vger.kernel.org
X-Gm-Message-State: AOJu0YxQUerhvENvWIQiOW6mt5VdIpaolybMM8BrJwU1GvLcIQ+OGtY5
	J1CrIOJnGllJlFmN3GsAIDAAbx+wyhZiq4Md+YKFdzvPwl6VYt6x6Z4cN5qz0buPebMAuiY07tS
	ljraRKM7jpTA4Ql4W9U6tcA9X7pK6DFI5
X-Google-Smtp-Source: AGHT+IE7kheTN19zXbJRfYda2IivoITqgwqNICI/LYdA2vzUDioYop84RC1rbN/XaMWP5zvCukwcsh729j6RO0lWXnk=
X-Received: by 2002:a17:903:2a8e:b0:205:5582:d650 with SMTP id
 d9443c01a7336-20782b7d46dmr146275835ad.52.1726426976825; Sun, 15 Sep 2024
 12:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-0-feaabb45916b@linaro.org>
 <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-5-feaabb45916b@linaro.org>
In-Reply-To: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-5-feaabb45916b@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 15 Sep 2024 21:02:46 +0200
Message-ID: <CAFBinCAgm+OGnxDvYAWGU-hEgBgGqJwHESR3ivT66BNvTNo5Pw@mail.gmail.com>
Subject: Re: [PATCH 5/7] ARM: dts: amlogic: meson8b-odroidc1: fix invalid reset-gpio
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 12:19=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> Use the proper "-gpios" property name, fixing:
> hub@1: 'reset-gpio' does not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g=
.yaml#
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

