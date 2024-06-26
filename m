Return-Path: <linux-kernel+bounces-230603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7E9917F17
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A0F1C21747
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1E717D8B1;
	Wed, 26 Jun 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DJkv4B8W"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63CA16089A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719399749; cv=none; b=mgWRdE8N0CQeYAkQrWsvZAg114olaRuYh8ckrSduv/idAfC4Xn6Q18KtXcbfARKscXIQJOurw98WphVb7iAOFyG+MNG0RewPxvvJj1Pd/4C3kD5u0X6WW5aPsRQJmQleheStLH26DvOEBXTawjHrkneCKz7Iuimyyxbxk1IWF0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719399749; c=relaxed/simple;
	bh=iHKo5jSf/IdRTguJc6dSMvj0EoFBMTutpyv41hTOCGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDFvhQaR8wRRCb1yP/6tUzwTlwwqyYUdOV01gttU6LbJphsLL+RLFckhd+k7jWXWLoHj8UTdI8XSY2RnC/pGUMg4QCEBCHj0gN7II1YG3kVSVS4yD1ImUNNq/34ywEPC9d9obLwBMnhVBAdG2/HpAIfgi+IQ56a9cGIdRJ/vd6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DJkv4B8W; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ec5fad1984so46747221fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 04:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719399745; x=1720004545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDswRBBP2Qt3ekSLsvBri2VGbmBXgiH4bSSikEURQGY=;
        b=DJkv4B8WUXXrUF4H/7lGJ7vjZ5dUtnQxDPWzL1BunBARWdnw0PHNMyRIvrRhQeJBZc
         aZyoN8AusIj5ad67RN8kfG2yoASZaTEh2Dt+vpZFI1KPodR1RBiq2sDU1W3Fei6YJHpX
         SDPENyRLpsYH/LCFoaFuOPauO0g8ApJ1SUfBTbfDl7zZ7esNKvR6LBTLMrWBGWKWgyal
         55EZ2qCpdwbenMRWOPKlQhM0IjuXiVSGClcL5ay0O/43GH0BO3txKgvO6Zdl3Vn8mkJh
         BBOtJ3hmeoXU2W9XMteA23v952u9Pba03qqCo8UyYzXQXIX8LHYLO53BXCW4VxnR+VWF
         ifWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719399745; x=1720004545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDswRBBP2Qt3ekSLsvBri2VGbmBXgiH4bSSikEURQGY=;
        b=pSlhIb7MCfuYbcr0fC5ywwXDYDFjUab1Vz6mMVE1BOdYfIASFlUR//PMCcdJ7V8G70
         Mrpfm5dYTLeWUCCBatoS914T85d2lvHal/OHph63cAdutBrZlomfXeIs1+M7sPyq2vx2
         7Vybk1EytMv6m89W7Ap4YMtE1FhTXVqSzOYkkdJWCzOo8GeKxGStVXQ6hX8xtnsFYzQs
         nvmXrcnNCos1gwu+pyTG/A8rHVit/PAXYHu10J1pDPQJyQ7ZsWSJ476qSEZWRNtp/Eis
         /dBXenxnfjaDfvJAzK3RQCyCMdG62uUrsKjpnldpH+ySAb+6NVDtyJPShHumwD+PPz7T
         ceuA==
X-Forwarded-Encrypted: i=1; AJvYcCWQRNYIJvGj4iqc87jZEApcSLylRQ13zxzK0w7vaG93omjasWiff2UO3NjXW/4j7wST0lGJ9Swe0IN2UShf+h56aobrdfPSJxHzvgUu
X-Gm-Message-State: AOJu0YxXklR9zDkMr08rSdZOOeNa1HuC+q9YJRK5/53yJCCR+Ep299FC
	faxeFpD5sa0AGrdNPm7cCV54o1u4z1dKBnYBfj628QDp+pB6siUIbN/uT/0m8P8+0gatL7Tb6Jy
	o5mjd8zkNETUNReUYpmifJEnqDY5aTa9q5o3hEg==
X-Google-Smtp-Source: AGHT+IHOZFXD0xS4qZO808BfSHcTBiGzJgw7SoL1DC7zM8qFILuyWWKJM3LJtdXgtfsaOsNad2MuzEsyatICH5an/Aw=
X-Received: by 2002:a2e:854f:0:b0:2ec:49b5:50d5 with SMTP id
 38308e7fff4ca-2ec5b357a00mr72949841fa.41.1719399744869; Wed, 26 Jun 2024
 04:02:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625151430.34024-1-brgl@bgdev.pl> <20240625151430.34024-2-brgl@bgdev.pl>
 <f4e055e6-8903-4bd0-96da-b5247678ad84@kernel.org>
In-Reply-To: <f4e055e6-8903-4bd0-96da-b5247678ad84@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 26 Jun 2024 13:02:13 +0200
Message-ID: <CAMRc=Mc5TX=bRpSDpAaMdcbR8rXgFi+aoWCWSn-co3tHeVb3rg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: qcom: add sa8775p-ride Rev 3
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 11:00=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 25/06/2024 17:14, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Document the compatible for revision 3 of the sa8775p-ride board.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Document=
ation/devicetree/bindings/arm/qcom.yaml
> > index ec1c10a12470..000037f4a712 100644
> > --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> > +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> > @@ -895,6 +895,7 @@ properties:
> >        - items:
> >            - enum:
> >                - qcom,sa8775p-ride
> > +              - qcom,sa8775p-ride-r3
>
> The board is not compatible with earlier revision?
>

In what way? Can you run the same DTB on both? Sure. Will ethernet
work in both cases? No.

Bart

