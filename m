Return-Path: <linux-kernel+bounces-293509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8A19580AD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7591F21874
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E24618A6D0;
	Tue, 20 Aug 2024 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="AaO9QP+O"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B9D18A6C2
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724141867; cv=none; b=IWhI7Xx0sBDJ0iSkXOsmPWQweECVI8l1vcb3ULbwH8hyYrJY0dLH4+uw29yA6kWVLSWhp/hG5sNtCBtW4ign4+v5FSrX0j0XJVhvHU7x+bbn/p8JNLxZ2/KJXWCRmpRqVnSnNDdF+iht23iwcOq7hVgjjWjLFFHiDn8tFGysjnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724141867; c=relaxed/simple;
	bh=IVTP/toLg2yh+Q9s92uZK4xzlEisMXLaxoaU3yPoRHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YOMaf3kQNXlh3UDn/GIQwUTKdtcum4g5d8TUjy6RnKoS9SH3Y1F1iuCKYsifkwsPh4MiA4C35bf8c2kzIKe4WHvw1iQ2ZIfrbMCJTVSob+j+OGLtpPJahhKwfCDK3BBeJIKeGEs6LQetdwuwaOjE5qjTS11Ix+oOiN30W8I6J4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=AaO9QP+O; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52efd08e6d9so6198390e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724141864; x=1724746664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVTP/toLg2yh+Q9s92uZK4xzlEisMXLaxoaU3yPoRHE=;
        b=AaO9QP+OYxqoJjVhB/+v0LeienhEZbYzBDDlCJxMC9faeJJPFZb0Wdepc/ElKO2Ho6
         vC91nSdbSj7sxFEuE38i4USQAcr69mc1mCG79Jw7JTXzGBbo/qNcDZTTN5nuUJk+uiP3
         V4mUDRAxb+8hHY1pgUSaFCXSrqPX3SZT5taZg5k7vfTuTs9bO6mzvjA2VOkyteueUxn2
         EFzi21Hqiq+luBgfce31QOVVCOfZiCAx0wdpSTMQ9HNTqJYdc/yUsG5cUAo0pM0ww8HD
         rizr7OUQR88KKJUPW/o4+QRQlHFmxuuO7YjNkcVwhhd9nlo3S7L7Ni7kimJgEAZ+MPSB
         SUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724141864; x=1724746664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVTP/toLg2yh+Q9s92uZK4xzlEisMXLaxoaU3yPoRHE=;
        b=ZmMpOr2hLk9PLcxOG1FoNXD8TvXERXD5KPYjNrwlyjtMN8qkOQXUkzURsptm32EPM7
         Jx6fB5mCCjOpa6//jmP2m5Eb+E6cBQnLLVEOWFHmNyY4mNIUqC4IyaT7KHYogvycQHCZ
         bwmjBr1TUSF07heNw687MmCqpQhgP1qOrVv98wZ6H/D99bGaP6cctNBsNB+XuvsfG5uV
         Om78+f3oJWaU7zshyn3KJ7TWJwIP1WE4qSr6p2vURGTeyJdDgxm/4fr7eJaAcPP6G8oT
         7fW8jo/MUCbENRpxyWCtI1q98RY3OC+5JOkTDQXil+zm6p7Du/vFKjx5iNXD2vFLbPbi
         o1gw==
X-Forwarded-Encrypted: i=1; AJvYcCWaceu1DJ4QwfRsOMsPXK3jrm8IgX6I/xiuFCimoVydHQcBd/effwM1yIwxPrpLEjTmsowU+XUKKpJPVvFTq4+5f6HSeuOYd7cdpbTV
X-Gm-Message-State: AOJu0YxmRxM2oOWY2RDv/Vh9Yatlu51vK3rvN9B2oW9dkOvRi82MnxGF
	y3KSsZCmFPnYjJHBJ0KMSyecLeT723XY6TaWU/ltkpC47TKqkVZh1Jqb4ECSWwtZy9dywlO7HYj
	ydL6Wjcn+eElsUjZ0ObD0XOSG0Awj3luk2q+xWQ==
X-Google-Smtp-Source: AGHT+IFbDdTiw6Uk9S88S7dbr6cMRoYSFc48iuM3jxrmJUMbQvuz5tHkvlmpLI49vLNz6wM1Mmx8F8SVj9rCoaZGQ6c=
X-Received: by 2002:a05:6512:ad2:b0:52c:de29:9ff with SMTP id
 2adb3069b0e04-5331c692a14mr9702714e87.2.1724141863245; Tue, 20 Aug 2024
 01:17:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819045052.2405511-1-quic_lxu5@quicinc.com>
In-Reply-To: <20240819045052.2405511-1-quic_lxu5@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 20 Aug 2024 10:17:32 +0200
Message-ID: <CAMRc=MfuW1T_dA-JdybqpYzEVY1KXmNdPsuB6J6gJ_3Gp+2jMQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: qcom: sa8775p: Add ADSP and CDSP0 fastrpc nodes
To: Ling Xu <quic_lxu5@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, quic_kuiw@quicinc.com, 
	quic_ekangupt@quicinc.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 6:51=E2=80=AFAM Ling Xu <quic_lxu5@quicinc.com> wro=
te:
>
> Add ADSP and CDSP0 fastrpc nodes.
>
> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

