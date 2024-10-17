Return-Path: <linux-kernel+bounces-369681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997509A20E4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 028A8B2190B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B6D1DC07D;
	Thu, 17 Oct 2024 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="i00EyNUW"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4381DB37F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729164496; cv=none; b=q2ty6ByXAk5eVYVOBFzsiNfhq0XIdnXZyWZvozL+btFj0iKlHAyQTajXLJDZg/B/8ZMR3GozKL7QYm4yygm+s7nLtAvGniKNYzimY0L5IAGGSrUnq4mLdPtFcCqRc/eN8K2ihu5Ps8JZmlSUxtsFpU1eBczzT3UOxpX/3ud3Mfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729164496; c=relaxed/simple;
	bh=3bstaIXUv6a17OjBqcsZ3jRVz0msaMJniniMIJt1qD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIN2eHxH0GYh0vVDtFn+gtspPbU9+MC69lNOjUQo27UIPob+AHr7TFd310P0vC1SlLuvkKjCGOaG7cP293rPC1wCif+zQbGG4zlPoQCe2W+XBzAblcK2A3UKtp+on4K0EMh6gK86JqFCWC8Y4el7PucNDS5Kcmbp3WAx+HWV27o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=i00EyNUW; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so8528351fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 04:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729164493; x=1729769293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bstaIXUv6a17OjBqcsZ3jRVz0msaMJniniMIJt1qD4=;
        b=i00EyNUWdnWnSy3Cn7DQSjaIek1jGM7iopbhcfcFtzhaCI9vmVnFZdO3R+Pyni4gtl
         ijweL/TBkRXM/9S2mw/eDKkr8Q+rwAk5m+ct8fqt1qa4+pC55fPS0HTVZFcoBnG54o6q
         G5dCxqgeguBSBpcnY3iY8pyuhKwYgDOGXTioti+6dgQFa6E7zsPEHLD/SMRy6/lXCVyE
         8iAXUuNM7zsERgGjtXpgVotVMghZbYH+rhEaCdsH8kp9FlKsY29TPMBVyhC1iNvJEodm
         2QlUU9GnduO+Du2SFgIVKZdyPWnN74mIEZ1eRrLwrXNIO+5Wzm+bmmTyJK0QDOcCGAv2
         5SfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729164493; x=1729769293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bstaIXUv6a17OjBqcsZ3jRVz0msaMJniniMIJt1qD4=;
        b=HNkQGluLnLScAbg2I5B3ViY+Le1HVwZLdTD6WuiLGt64na8Y/qWvdctI0pqzn2OTby
         zDApC6E1PWH0Y+RXp3eR0KGeu2sb0yPcmcmREezJm+9i6HkzKYl5+hNtyvN8c1jwMJ6E
         LlY2l8zWud0TOwdDJk2+/uRF5TfQnBIT3UoZb/+63letWlLAi9HSuyKwM1VfC5GUhLfB
         0aLlEtroJNZmwwfA/Hc2JHq4sdGkr+oaKcJYNE+fadWRi2L73Qkh7m9VgbvS4Tnju+fv
         4cIIi4T4bJebAeHct3M3sh8tvY/hDGEERD2LSb/mEbZiOmuVBKZ6xk3jZhtSKW1JzszU
         6u5w==
X-Forwarded-Encrypted: i=1; AJvYcCX9cJk3HB0i1h+hECizIyLFjtO+v9I2Iuba8CbCH6EZXa/CI0OAOsJBBaCd7HQWlz2jw6Gy7e43NzOt4Us=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkmDEb5G/FB5+jV0F9ENJwMsZ4vbX9V04zv46sDGIieRnPKtuc
	jmo2J+rOynoXx6kuaXRyTbSwNAzUfnpPFifPzMjU0ItSEXRMXWvKvsDfTcBcN+WdVG4qJti3x92
	pLsCWAXrr0TiWQZ0UaIIElNchWbLCefDSaQTSMQ==
X-Google-Smtp-Source: AGHT+IEwdVt6AMUy0dZa8ffDdOfPCN3cB4NRXbqVMD8pKlMzGOo59AxscXSgX2IQKf/+4MH5yGnHCgjzqBA+AeV1wOc=
X-Received: by 2002:a05:6512:3995:b0:539:f26f:d285 with SMTP id
 2adb3069b0e04-539f26fd52amr8730107e87.3.1729164492613; Thu, 17 Oct 2024
 04:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007-x1e80100-pwrseq-qcp-v1-0-f7166510ab17@linaro.org>
 <20241007-x1e80100-pwrseq-qcp-v1-3-f7166510ab17@linaro.org>
 <ZweftESPrJNEsqGE@hovoldconsulting.com> <Zwj539cN2DJ7nd3A@linaro.org>
 <Zw5fzNZ_xCwPyw4G@hovoldconsulting.com> <Zw_dE1rQ-Ljsh-sY@linaro.org>
 <CAMRc=MfUEfKHkAVvtGODxvJ-BdL+kX7uDgW+1y4QW3Kc5mpX+w@mail.gmail.com> <cde15d83-6059-47bc-94d6-2a88ba95e5ae@sirena.org.uk>
In-Reply-To: <cde15d83-6059-47bc-94d6-2a88ba95e5ae@sirena.org.uk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 17 Oct 2024 13:28:00 +0200
Message-ID: <CAMRc=MddPDFaw6vYo1FzXHbUsLyr2QKT6oy2i68ZCdJdFWCJww@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: x1e80100-qcp: Add WiFi/BT pwrseq
To: Mark Brown <broonie@kernel.org>
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 12:59=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Thu, Oct 17, 2024 at 11:28:18AM +0200, Bartosz Golaszewski wrote:
>
> > How do others deal with it? I'm asking because I've been seeing these
> > warnings for years on many platforms which makes me think they are not
> > a high priority for anyone.
>
> > The best approach would be to provide an optional bulk get for the
> > regulator API. Or extend struct regulator_bulk_data with bool optional
> > and take this into account.
>
> > Mark: Any thoughts on this?
>
> Fix your driver to request the supplies that actually exist on the
> device rather than just some random supplies you hope will work?

Let me rephrase: the device has this supply but on this particular
board nothing is connected to it. It does sound to me like an example
of an "optional" supply. Do you have anything against making it
possible to define optional supplies when using the bulk regulator
APIs?

Bartosz

