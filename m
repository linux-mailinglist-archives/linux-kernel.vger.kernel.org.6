Return-Path: <linux-kernel+bounces-217086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F91E90AA60
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621171C20EDD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E20F194C9B;
	Mon, 17 Jun 2024 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wp1ZL5bJ"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380ED194C85
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718618022; cv=none; b=deVAPKZY5VhvOIE/mSeWnujcYpjF1IECYId5oNvE2VoLWnmUPONvwpTYoqAJlLfuttFG6nNpZiFEMzimh1guxfxFGkFuMy7WVlJTN+1ynCY+Xh6qnyWA6PaOoiSe5i5O+Wd7WQysEx3P/0rpFNCWMQoB/lG1cKauo9ZJ6pYd/G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718618022; c=relaxed/simple;
	bh=EwVLuVeHp2g3G1fblt/MpM+4+1Yf8xjMAvh3KYBPdkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDM6SqSls9H872QbdxEoJJVeowL/dw3nLuFNFF0r4TJhEtaZfL94O6pdVnJPtHFCjI1JNCyM4BG2G9Nfq9NcRCySxtFQ917e5kd3M1DXBRUEzTO1xnmevx5RgHmqKXbBXHlpmMPUO2dHV7ZoEfScQas0GndWuqLDtZ+5BBq4X4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wp1ZL5bJ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52c82101407so6983593e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718618018; x=1719222818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ow/bdqViiq77vsNYuMh0FoiQ44/aFS2ozFtxuSsTOHw=;
        b=wp1ZL5bJrsLei/Pnp2GfaICtok3bK8z9Tqn+GodXcLOIV4oHwV8IYVhB7Du47oPYXI
         E2WCWdC+E+ttcPdSwjpeSgzqEHiiiw5nWWn2qRt5OIt/EjCdFJTR0lzVYFj2w8QKfNF/
         2LgT9rdP37eUZo6GhmLgQTtzz8FPeeLXli5iwa+52ert/0vNLkMK9pSaCmiRYHnVQd/G
         kvTHfnL9KbTm9azu+AjCM0Lsi8sQ5JVy8DcS2mWD1r9JORL7iY21DQHmrkQt2U1Ms7kY
         ZZXBGA1aiS5n4mmmh365Y64XwK8YD/xt0Ep6zK8kRNihUEo8D/tpnAbHVvuCdZ2h5a+b
         hvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718618018; x=1719222818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ow/bdqViiq77vsNYuMh0FoiQ44/aFS2ozFtxuSsTOHw=;
        b=lztdcDjcBHtVzcF0B29pFkWs9Du0RFcSRN4liNxl8f2GYFg/itxKpIdQV4bbk5XUIV
         3ycwnMa9yasI0nEHiiqS9HUCogm98/C9CF2x+43lKLsW8q5j0+PWrIhgP8I+LUAw3CeP
         PZA7AgBhKkHzU0OJ5rdjS2a68GCsn7BC5/RIg+ZXFnHfqWVYe4aLTu+fptB2XH4njHwa
         AQr/2hAcgF1IUNDoNMKkfGrDH7saUjBL1sY/CdX94DbFovzsN43qgtnLEQZj3jT4+Mlm
         /3x1RhJ3446h/eWdYSGNgvu4sXkRjglTRKttpgA7xSE5xs/jtUh9E92y7FFxbVDoTnLw
         Rbjg==
X-Forwarded-Encrypted: i=1; AJvYcCU9+pm9kMDj2bUfOICYebArrUhVhRwEVG9ZLeQv4CSEYyvOv6C34NR4ohTl9eXJIaPoJBPzOXCBgvLeS9zrK3QMrRqc0kUpOeBbstNm
X-Gm-Message-State: AOJu0Yze8fklX3ORqRgooaZcC+5H7NOZ/ahRRqaRoVD0BEF2Sd7jm57i
	8xsFagSV/ZYPI6dhSJvwSOnTZDRmZseImvCBFaTpcj3TOfMk+Qc1ZjN/4a0URqgs47lNheF0eKp
	nKVjtIj9JacHKp0rh9T0PyfZ5wsl8oisYuP7BLg==
X-Google-Smtp-Source: AGHT+IFTgY07RrDts8kCSgZpcdeNkbbio2oxZYTF1W4ol0ipTL0MLFFayU3iO9ZhdfbwSWYFxpptD8C1Ao9fcwSlw5k=
X-Received: by 2002:ac2:420a:0:b0:52b:bf92:bcd with SMTP id
 2adb3069b0e04-52ca6e67674mr6832479e87.22.1718618018212; Mon, 17 Jun 2024
 02:53:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605122729.24283-1-brgl@bgdev.pl> <20240605122729.24283-2-brgl@bgdev.pl>
 <m2ocalmjfiitgr2ziqtegll4gzs5l5hykgx57fzz2n7u45szje@faa2xxfmksm4>
In-Reply-To: <m2ocalmjfiitgr2ziqtegll4gzs5l5hykgx57fzz2n7u45szje@faa2xxfmksm4>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 17 Jun 2024 11:53:27 +0200
Message-ID: <CAMRc=MchOAwNR0i-_x13Y60gXGJHtnmVvmCet17u+TKUgrZ33A@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] arm64: dts: qcom: sm8550-qrd: add the Wifi node
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 11:32=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, Jun 05, 2024 at 02:27:26PM GMT, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Describe the ath12k WLAN on-board the WCN7850 module present on the
> > board.
> >
> > [Neil: authored the initial version of the change]
> >
> > Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
> > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > Tested-by: Amit Pundir <amit.pundir@linaro.org>
> > Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 97 +++++++++++++++++++++++++
> >  arch/arm64/boot/dts/qcom/sm8550.dtsi    |  2 +-
> >  2 files changed, 98 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts=
/qcom/sm8550.dtsi
> > index c55a818af935..c9d3c0549ab5 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> > @@ -1784,7 +1784,7 @@ pcie0: pcie@1c00000 {
> >
> >                       status =3D "disabled";
> >
> > -                     pcie@0 {
> > +                     pcieport0: pcie@0 {
>
> Ideally this should come as a separate commit, with proper Fixes tag,
> changing all pcie ports at once.
>

Why? this is not a bug, we didn't need this label until now.

Bart

> >                               device_type =3D "pci";
> >                               reg =3D <0x0 0x0 0x0 0x0 0x0>;
> >                               bus-range =3D <0x01 0xff>;
> > --
> > 2.40.1
> >
>
> --
> With best wishes
> Dmitry

