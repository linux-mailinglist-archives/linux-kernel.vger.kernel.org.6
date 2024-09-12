Return-Path: <linux-kernel+bounces-325972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D91597609C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F3A9B22147
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 05:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863D8188929;
	Thu, 12 Sep 2024 05:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltWNoQLX"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB77663CB;
	Thu, 12 Sep 2024 05:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726120377; cv=none; b=oBLazwfrz8sEVMmWJapOg8JrEX8+CsYTaQp4YMvgEQrVjlxlPeE0wFBsZeI1lo2kxR2+y+GiBpTAGuJ2Vnqd5vBXZD+j7LQyRnfaUN0QmKMZkZGAxgfctYRlKAEwgSzfRUP+6js+IwH9ewyYQapSX2U/K/xR03OhoMzgYUrSMrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726120377; c=relaxed/simple;
	bh=cyf1Hb2C/+172elhulghuDprDeDW/q6iLjvvVCDRM3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FrFKVsxYq2Xvokq3RWJrpnMTfxuEZFHUtF/bKCWUeGSO//lyi3ZIh0fYQ10JNcg5KyNS0Jo5qT7AjjJXwFPn10QdndzkXw6NA+VRBEy/qOsZ/rDo+AHySxLUpBbi1VOKxwTPG5p79qOXdPcJdRkHqwEXrtT2jKaveQk4PFtli6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltWNoQLX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20551e2f1f8so6077505ad.2;
        Wed, 11 Sep 2024 22:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726120375; x=1726725175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyf1Hb2C/+172elhulghuDprDeDW/q6iLjvvVCDRM3k=;
        b=ltWNoQLXUZM1tdFQ7MjRu1A/qEih3feZ6k9KL2EKBevOfokIlHIIH+pI/8RnhY7lcl
         a70gQa+6qCJi+UCGQSvGigjRHY2SUHgmbpq4EDUJObx9g5YhNNtqRTPm0XuP/YdquTDr
         ROMlo15rV5fZem6UUXDbB0PbgC/p1gJOVncHLo88lJ+WJf+Rq5Z+16NAF7/keNSlKTk3
         j32k3NroGton6/9yKKPfnHHsagtw5Smme7hnBcuyrykjufCYz9QFYT2+GmnFw/i/udI8
         XBl0Rz9adRpo7Wxllha/dGf2UDRI15N0jveiLAPjunj9m6wYoqav/CmMzngD0IaSUE6w
         MHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726120375; x=1726725175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyf1Hb2C/+172elhulghuDprDeDW/q6iLjvvVCDRM3k=;
        b=Vbwdq3lRm0fH+PDGaOKNTKGs3vkFM2FKZOTkZ5rzX5ra/lEaYeoh51FK/KDxmA8bms
         NH0c1HcY8UiPEnLVTePye3A+b6V1DBlKZHokeRJ3vsJSKIobPR8DS/HUZrY0D1BBRjEa
         Y1bPj+Ml3A9q4hEhSbOlJMfgpGf4xKosWX7jdhNY9qxYtca79fkHuUpHq/tWf6pcs/AQ
         UesxvAyYBGCG0lFdhgYgBBfe+31Xt1z4Zu5carHljP1MIfel2NPuBlXl3ur2RE/1IOa2
         hxdNhk53Ph99SW32v5P9Ud9dLPv11Rf4cthImSH+c7jE7V2tURKXK8YfZps+e8pIyuc9
         e9AQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2y1YZATM203Td9ONTipdLWTMWCth6sNItj4kdTl3q4Aqybvvx/mKMSFhW+T5Sq99HBppYqLMgkDFPUeo=@vger.kernel.org, AJvYcCX5i0WWQINygN4uKyRJe1AxfbiQmWUYaHxkfTkw1s7zmwa42pOBwFHHuEp4AgGFEE0X32pVoyNa+nd1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3mUdElPh1g7fj0TZpNBhbL/Um8v/pYPhfavJon0vYmkmFbODt
	XPbrQcMkc40JL+QNJCDnr+jCFfx5szYwKIkhaJaK/OlgZ1Ctot7p1ixa1pqESn/k6XoKWlyL3tO
	A/0+y6U9KGaozK5zPHnNVn4/pdxxHcLWGxAw=
X-Google-Smtp-Source: AGHT+IHTZBq7WQxTCuoatyBiiOKHG7oXH+KbJERrM2Lth84TKU6yGz3+BeSN/yGNB7IcRHa0JUAbWO2todjO7Xitf5c=
X-Received: by 2002:a17:903:2302:b0:207:20c5:42c with SMTP id
 d9443c01a7336-2076e40be2dmr29349775ad.45.1726120374758; Wed, 11 Sep 2024
 22:52:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911051716.6572-4-ki.chiang65@gmail.com> <20240911093828.58129593@foxbook>
In-Reply-To: <20240911093828.58129593@foxbook>
From: Kuangyi Chiang <ki.chiang65@gmail.com>
Date: Thu, 12 Sep 2024 13:52:48 +0800
Message-ID: <CAHN5xi235kgU8Xd0VYw6r5NeieCM8uqWjgPnLSP1haAFqgcFsw@mail.gmail.com>
Subject: Re: [PATCH 0/3] xhci: Some improvement for Etron xHCI host
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, mathias.nyman@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for the review.

Micha=C5=82 Pecio <michal.pecio@gmail.com> =E6=96=BC 2024=E5=B9=B49=E6=9C=
=8811=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:38=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi,
>
> I have some Etron controller (forgot which one) but I'm not using it
> because it crashes ("dies") all the time under my workloads.
>
> I suppose I could try your patches if I find a moment for it.
>
> I'm aware of one more bug which affects my Etron: if an error occurs
> on an isochronous TD, two events are generated: first the error, then
> "success", even if the error is on the final TRB (the common case).
> Then the "success" causes "TRB DMA not part of current TD" warning.
> I suspect that all Etron chips are the same. This should be easily
> reproducible by unpligging an audio/video device while streaming.

Hmm, I don't encounter this problem.

>
> Considering how utterly broken this hardware is, I think it could be
> more efficient to have a single "Etron host" quirk. These bugs are
> so stupid that it seems unlikely that any of Etron quirks would ever
> be reused on other hardware. Of course it should still use "general"
> quirks when applicable, such as "broken streams", which it does IIRC.
>

Ok, I will use one quirk XHCI_ETRON_HOST for these workarounds in the
next patch revision.

> Regards,
> Michal

Thanks,
Kuangyi Chiang

