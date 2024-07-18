Return-Path: <linux-kernel+bounces-256455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C7F934EB4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92142849BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D11D140E37;
	Thu, 18 Jul 2024 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cpm53qQ0"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311DF13B286
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721311481; cv=none; b=KZA10NHgMpAl1aoTspYQjjMAIPhthtQmo+6DnDsXYBx7g4ImD1VxWafssjq1+tpy0LjZ7AQioISV+0Ic/1faX8gVOhzwd1Pj0L4MQKCHe+EgrKKUvqfze9/SwINMIvU0kY8UgcotJ6UEU6h+yXIC0ZFz6C3doPIizTHRAHhbbow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721311481; c=relaxed/simple;
	bh=7mKSULYsOZRiRiSYaR5r+kVLZIVlF7XgyiZG/+xst4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PoPbW79TJNXFIiOD3cQGmEvDBOXm0+aqOxFAiRc4ThDaItdXeP/B6Lj8he3hLByev7IJVfV2P6X7HMy6yE/Aljq+hSs+2n6ItfXzR0cRtOQQzF9RAJ9qp0m5wxlWwEoK43EIPR9oNBbeX290UTnjFi5lN0sPP/9ofQrdLqPxK9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cpm53qQ0; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25e3d8d9f70so397794fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721311478; x=1721916278; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l3WTjubRD4NA6PA1aZkc5sumZd760DIUvpDf+w+griw=;
        b=Cpm53qQ0CdM4w1vrg+s6YLiiEO9cJV2GtdVHc7s/g2JEDWwEsO6g60uZRxhe4a6s4N
         RgwyyV/RvHn7kI0dPk6SN9rtFkz6jHtTEJOjQ7JjqsRgKfaj/pWpHbEBdRyVx9E7ylbv
         RzlCVKmPWFowTcJc+9MsUAMVcIUEqPQ3CEZFgvcRGyGtT/Ky1hBQpuuDRHOhZMOTQ0aC
         MfHO1rVMHArls9UkHryC01c9dK2EJ0uKGtE69eXOiZdq7WzqbS499PbNp8rlmxzCTOcX
         hfwWUrOuf5M+ZU5cVwt/ieC0b5Sa18kQ6sm/8is5bTGMoITvxnTIKw8oH+KqMtf81qK2
         RTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721311478; x=1721916278;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3WTjubRD4NA6PA1aZkc5sumZd760DIUvpDf+w+griw=;
        b=UEHFhDp5OOkZtiJLC+WIRSilHvlYGVNq3C9temCLVlwTNHT3SQHq2WqBYkb2QN9Vgk
         2BwoQXDBTpUOcNEn551xdfWgJutttiKHET6FHw2kgDN3TUorENY5hKgIjCqVowGBl7MS
         pyxVloX75+5umsaxYu83crwEJUa7qZjEC8cUfPwISgPnmnR+8LFlbNyo/h0kaxVlFhZM
         0kJ+M6oOZD8LbbsCJs2Htu3g/1OkcCyaItWUu81gGzdZxHP2bA3YID4s1kEh/wGzu5lT
         pih3dCMJ8i5EBJ7lU2DMhCa9P3Sw6blrFftJpSOJlGmYVFbBRMX74Oyop8eEfJ3pmIVf
         m9pQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+laqM4Z4+h+82qtEpkNWayGJLMFPj1VCgIOrAiXKC9xJ1WPgjle1srQaaTwaeGhwbDNSU4n+tHa3m8aEwy5r+C1C2piOrGN3+CASz
X-Gm-Message-State: AOJu0YyUshKmC3wzDRKg0gbtLfAZ1TqZ72boGv0jdWhfL8T+fSCgjwPx
	FFV+VZi5lTWwKm6ddEJ7XLheR8dYe8tyXh7I5gfD8YAhrggAeVd4u2t/HECdC2csohgtcO13mcS
	JPb17Jy355rHq/Q/B3la9sNoUiBh0upwsMV3J+w==
X-Google-Smtp-Source: AGHT+IFsbUIhMc2W1HvDGSyiBSrarYG6v/MdEev7NIE3ZTndjqyt+c6mewlonjpkRzRFwjH5PGhD97w49TVHcju3rbc=
X-Received: by 2002:a05:6870:f112:b0:260:fbf0:d65c with SMTP id
 586e51a60fabf-260fbf0d961mr922488fac.9.1721311478117; Thu, 18 Jul 2024
 07:04:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718125545.2238857-1-amit.pundir@linaro.org>
 <qitt2j5hw6pax7yekdooutxebhkznhdv3aafnhkysr5fjcbmd7@xqbp7h3ld4gs> <CAMi1Hd1wzvzStEv2zoNocvYBkJDis27vzCDcBtMruQQ5TdOkDw@mail.gmail.com>
In-Reply-To: <CAMi1Hd1wzvzStEv2zoNocvYBkJDis27vzCDcBtMruQQ5TdOkDw@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 18 Jul 2024 17:04:27 +0300
Message-ID: <CAA8EJpo1go=4zU0zvi_dd8ST+phP7+aMJz+sM-Jerwpf6s2=Hg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8550-hdk: add the Wifi node
To: Amit Pundir <amit.pundir@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	linux-arm-msm <linux-arm-msm@vger.kernel.org>, dt <devicetree@vger.kernel.org>, 
	lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jul 2024 at 16:56, Amit Pundir <amit.pundir@linaro.org> wrote:
>
> On Thu, 18 Jul 2024 at 18:36, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Thu, Jul 18, 2024 at 06:25:45PM GMT, Amit Pundir wrote:
> > > Describe the ath12k WLAN on-board the WCN7850 module present on the
> > > board.
> > >
> > > Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> > > ---
> > > v2: Changes suggested by Neil
> >
> > Which changes?
>
> Neil suggested a few changes to enable 'bt-enable-gpios' in
> sm8550-hdk, now that the hci_qca driver uses the power sequencer for

You should have described such changes in the changelog. Note, no need
to send v3 just for this reason.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> wcn7850 https://lore.kernel.org/lkml/d3416be5-b97f-4db6-a779-9c436e41dd72@linaro.org/
>
> Similar to this sm8650-qrd change
> https://lore.kernel.org/all/20240709-hci_qca_refactor-v3-6-5f48ca001fed@linaro.org/


-- 
With best wishes
Dmitry

