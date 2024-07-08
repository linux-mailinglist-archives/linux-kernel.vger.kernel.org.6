Return-Path: <linux-kernel+bounces-243973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8F8929D3B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 506021C20E4F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE9623775;
	Mon,  8 Jul 2024 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="jAeEtlw8"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77A921345
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424352; cv=none; b=JCh/bTe6aCBHrVI3L0XxLZLBnT1+uOWoUyTMUmz8ZfEPau/ACdeltC4+qxLqvds5Bl8hzL3mZ7E+3KhGkgBi7WKaOz1bTn4nXAcS6qSUcwLKbbyORbuFq5GFTilBb3lsZwOzd9QfXTywpPu/sGkWe4an8byexrR7pehSMjlNz/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424352; c=relaxed/simple;
	bh=OdHQYffnI1MnKOFjaCBGe1+olPDrFei83GYzc+nRjDM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=eyhDOUJE12UmBA3VMmjecNzMzXADXf65/jan/+ePWANQudtrYwuF0FyN5yz0M+ZakkQNKuDf1p2Ol08PG0BfnuM/lbHf1z60ngSDRCa+2ZAA0PaFoDooaQOq+7SIhod5y0KnDYJOZWTNwVqzjkumdQ/6LXE+FNwOxJPsFFDJGoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=jAeEtlw8; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77af4cd570so207612466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 00:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1720424349; x=1721029149; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdHQYffnI1MnKOFjaCBGe1+olPDrFei83GYzc+nRjDM=;
        b=jAeEtlw8UVE8r9CzT/9i7D+8PKaNdOkI2syezy1hOIfZ3dKNIBBzV5YE4TITL2GQuW
         hNWsxWEPGwk8Y+qNClW4DbDQKwAXBdneTFOFReSsoNTdsTmFA84CYXaKCFRTxBJG8FzB
         sqf3GJu3XTtCz1cMscu/nzVCX5Wve1aDhDp/docqYdMNCRnmH6b/A7dUqXAsT+xisgQa
         MAyF4ViOyge59UpHnBRhk98IPeakCPaDHl2NiHg8xt0DfFJb/qoSo8JWq+LVHNxyuHwM
         icaK66dJEstTNAwsuHoKdkeeLli3Cws8ktSuJtwfwYW0jeBEgET0B910tjlhPsJCqHsW
         V6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720424349; x=1721029149;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OdHQYffnI1MnKOFjaCBGe1+olPDrFei83GYzc+nRjDM=;
        b=Rz2L9xispuvYX0nHNQgqmf2YWQsmVkZUZOUpGVm4nUOBy4oNlCD8XgXmTZuNPCCNJh
         OmGlOalw1g3hk5V9eonvR0VyiVXrc1VNNZQbYzz8ZucEPqAQ2UYVZibxp9f3lkYuN4Tu
         XhMvRH8iaMuFYwjN9Yh5Prk+Ru6zLeKvsr8kc3Eh9c43Hc48axOZ8QHu/ump4nqlXJI3
         4dKupS5hJ7l1twY8JuOZeVDl4v0dkbIcp1ChPVEjFyLH+vz4spOfTsdaGRMeEFCyLluK
         EF7PiqVpG8puPPZs+17Er5nSYrbbESNNCajMODSeuNZoUbDUP5/8O/N2IGyggdYzDRx8
         cz5A==
X-Forwarded-Encrypted: i=1; AJvYcCVJ94dsdJ2+sdoAqlxxj9NOsGJIqpk60hnt0AmjgIMb+6Cm1nPHWO/66EfYBu/kIztaI5InvMxjrcTNqBDZtxdSix85syqEd3JKIlix
X-Gm-Message-State: AOJu0Yw3OdblLFv0P/uFtPsaFWVqvSwOYvMIAsjDB+NMvaGI53qct9+w
	2JNACbse6QnRRlYX5pz0BG6+P0oEtCL1T1M2f7LLgQy9y6yQgXbBdB/cx4RQaKM=
X-Google-Smtp-Source: AGHT+IF/1aWOT6fhzPZTuQqzZjdB1GINtas402gNSeNFQ4i1cR0zwoyXLbvlvs8ayC989dd4FtVW9g==
X-Received: by 2002:a05:6402:1e91:b0:58b:f46f:ae45 with SMTP id 4fb4d7f45d1cf-58e5a4098c6mr9923869a12.23.1720424349166;
        Mon, 08 Jul 2024 00:39:09 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77d808b81esm256852266b.151.2024.07.08.00.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 00:39:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jul 2024 09:39:08 +0200
Message-Id: <D2JZJ6OV854S.JBNP47IB708D@fairphone.com>
Subject: Re: [PATCH RESEND v3] leds: flash: leds-qcom-flash: limit LED
 current based on thermal condition
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Fenglin Wu" <quic_fenglinw@quicinc.com>, <kernel@quicinc.com>,
 <linux-arm-msm@vger.kernel.org>, "Pavel Machek" <pavel@ucw.cz>, "Lee Jones"
 <lee@kernel.org>
Cc: <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David
 Collins" <quic_collinsd@quicinc.com>, "Subbaraman Narayanamurthy"
 <quic_subbaram@quicinc.com>
X-Mailer: aerc 0.17.0-0-g6ea74eb30457
References: <20240705-qcom_flash_thermal_derating-v3-1-8e2e2783e3a6@quicinc.com> <D2HO9CAE81NA.3UIL5UZ1N5I4W@fairphone.com> <40dfeb9c-e420-4695-939f-ef9b1985d61c@quicinc.com>
In-Reply-To: <40dfeb9c-e420-4695-939f-ef9b1985d61c@quicinc.com>

On Mon Jul 8, 2024 at 4:59 AM CEST, Fenglin Wu wrote:
>
>
> On 7/5/2024 10:23 PM, Luca Weiss wrote:
> > On Fri Jul 5, 2024 at 9:55 AM CEST, Fenglin Wu via B4 Relay wrote:
> >> From: Fenglin Wu <quic_fenglinw@quicinc.com>
> >>
> >> The flash module has status bits to indicate different thermal
> >> conditions which are called as OTSTx. For each OTSTx status,
> >> there is a recommended total flash current for all channels to
> >> prevent the flash module entering into higher thermal level.
> >> For example, the total flash current should be limited to 1000mA/500mA
> >> respectively when the HW reaches the OTST1/OTST2 thermal level.
> >=20
> > Hi Fenglin,
> >=20
> > Only semi-related to this patch, but I wanted to ask.
> >=20
> > Since most phones with a flash also have a thermistor for the flash led=
,
> > is there any plan to add support to be able to declare the flash led to
> > be a "cooling-device" for the relevant thermal zone? That way from a
> > Linux thermal API standpoint when the zone gets too hot that it can ask
> > the driver to throttle the brightness or turn the LED off completely.
> >=20
> > Right now the only action the kernel can take is with type 'critical' t=
o
> > just kill the entire system to mitigate the thermal situation.
> >=20
> > Regards
> > Luca
> >=20
>
> Hi Luca,
>
> This change provides the ability to throttle flash current based on the=
=20
> thermal status sensed by the temperature sensor inside the flash module=
=20
> HW , it doesn't need to register anything in Linux thermal framework.
>
> For the case that you mentioned, when an external thermistor is=20
> installed nearby the flash LED component and normally the ADC_TM driver=
=20
> registers a thermal_zone device with it, I agree that having the flash=20
> LED driver providing a thermal_cooling device so that any cooling=20
> mapping policy could be defined between the thermal sensor and the=20
> cooling device would be a good option for better system level thermal=20
> control. I would assume that this could be added in flash LED framework=
=20
> driver instead of the client drivers considering this should be a common=
=20
> request because of the big thermal dissipation of flash LED?

Right, the LED core getting the ability to register a cooling device
would probably be a reasonable solution, that way any flash LED driver
would be cooling-ready. Apart from decreasing brightness - or worst case
turning the LED off completely I can't think of many other actions that
could be taken anyways?

Pavel, Lee, your opinion?

Regards
Luca

>
> Fenglin
> >>
> >> ---
> >> base-commit: ca66b10a11da3c445c9c0ca1184f549bbe9061f2
> >> change-id: 20240507-qcom_flash_thermal_derating-260b1f3c757c
> >>
> >> Best regards,
> >=20


