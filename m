Return-Path: <linux-kernel+bounces-534321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFBAA46587
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB63317DD89
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA627224B0B;
	Wed, 26 Feb 2025 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C3Orbq+G"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DCF224AF2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584555; cv=none; b=o7o9yaaOqFYlXgjJve3GdLL/H+Nsaq/odSauZRlliFqywm/euFcafGR9Cw0DU5GrTnfuVfjlcN0EjoVcPBqz10EMzMyQTamY69cIyH72NVq6YU5JTOtFlma7DEvfHRFrJD+VZeTuK35S81TlhqSDKgDNUElwZflVbGKGDnOPrek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584555; c=relaxed/simple;
	bh=yET4WCQ0TidGw46uDqCa2xPxmd6bKwpoScO4cAMic7A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pqmEba99sxBCGvkeRjFEguRaCVMkjJjrolBoc55Vpd9d/g6xWgYb7oLmz6QI83fPjSDKl9Hip/Pm6RYhgM2UV1yz4KMS6HYVKETeOnD7wYyfnK8DnbLBblmqsOCHXA4RwR7hnzNx9qJLQo+/Eo+yawf1a8OnD7HRmZ9Ig0mjx2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C3Orbq+G; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-438a39e659cso46771065e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740584552; x=1741189352; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yET4WCQ0TidGw46uDqCa2xPxmd6bKwpoScO4cAMic7A=;
        b=C3Orbq+GsIma7v8fPk0cUnsE4cHhspQ4nv6LHjkF6WFdfKFD2QhIMcpMZRhn4en5dZ
         7ZRAibSWpYEEfEm4KluZJGiysahiHnVUZ526Y+e1KhoOYN0/EvxQnZjwhOqQ0olM3wra
         3TZvImZZC26aSTsfUTBjOtPDN/T4vkBW9lf3z6hG3OQeUbWFj9uQFa8d2HyDT8sOKmrf
         JbVZfZZHXoEyUpXg3cwoKbgu09uZqq12R5Z5jvfK9l6rieEVGtABq5Kj3bz3GH3MAUTL
         D7bljuZyuxJpFIgtGCQhtQzatylKo9zNo3hj5gdUBC8nRSw+03x2dU1pr/C4JbjLxz6s
         otIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740584552; x=1741189352;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yET4WCQ0TidGw46uDqCa2xPxmd6bKwpoScO4cAMic7A=;
        b=fc6YoDiJMCymavcNC7Eeu+sgosL6fEhSQgOaXKEQxJKUhRo2MSJA8gwUs4Zho+GmBn
         kRSKdC8fJPbuBTNNqSZRnaPqXgasEercQlFDj8RdDvdpsrZO2a/XQFOq2FIJ4+IuqcRE
         r9Z2D3j5bJUY0IHRJUbzW8GdAHR6JYB7rIGEJoMCbevpMbPKlTmyFxV2GsIdjZC9cD3K
         Xzm+7djy4dPfdTrwyLEOaEqL+C/iYhVlG8EtRV+DSIPSyAm7BTYr4xOVxlGf2B0pCm12
         E7eEOk8kCZWw1toHJc9ccFB13MyNPLffhOFcATgPcm2Vvt3+EIBklxWBKD/opudjEo+2
         gYew==
X-Forwarded-Encrypted: i=1; AJvYcCU2G27KhKIinUI18ZY+EbyYp5ieRJ2xNhgAMgbsEcOfNbIYO9gswGbpElXZkON3Od8646dBcj6OcaP58q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHKtogpTPVt9Efn8ROKWNqkVivnEyOfG7lyb6yGvTeCmE8f6sp
	mLq7skVA768VB//k1aRmraH8Q8e6GsGtWWKJNPh5wNXZ8PbKneIPBXMni41QRys=
X-Gm-Gg: ASbGncuPAEs3Qr+aVtxjxZf3H7E4xfUbra0ss2AIR8KsWgi5IYWgiMMNH6Z6qkJfCN3
	WtiNPKz/+i4Ru1O0sM5H4cfHNFafCYc0x1ayxp0QzbEpGK6aeC50IpTPU0kbl2CCOrLRjS04tRV
	O7yJEFCSv3pLqXKZx4vjZ8M7L9ICwhpkCDp28AQ1kxT8tDDNz7e3B6M0J4zOr3KGyphP3L19iWs
	qmPnTfCaj/U2Bfxz7LKO06P1IrSMHxEaQzcCWPA4ZSeDj/SsZc2tJwoMMTOASFj03TsRpq+Py2x
	1wxQRE17xYeNgjUpK2/IH55fvOCiUA==
X-Google-Smtp-Source: AGHT+IFBjnTWTZFRw7uykXPFUh9gNCNUIJPbPGaNy6dQmXu2Z2glg7T41KVUH/4tSaNb7DypQgIDsA==
X-Received: by 2002:a05:600c:1c1d:b0:439:9496:181c with SMTP id 5b1f17b1804b1-439aebdc9e1mr174340225e9.29.1740584551612;
        Wed, 26 Feb 2025 07:42:31 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab37403cfsm48020585e9.1.2025.02.26.07.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:42:31 -0800 (PST)
Message-ID: <ba98106d00038a9b2a2bfb27dd49a5915cb93b81.camel@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: reset: syscon-reboot: support reset
 modes
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, Peter Griffin <peter.griffin@linaro.org>, Conor
 Dooley	 <conor+dt@kernel.org>, Will McVicker <willmcvicker@google.com>, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Date: Wed, 26 Feb 2025 15:42:30 +0000
In-Reply-To: <174058375994.2463209.9948592153423144239.robh@kernel.org>
References: <20250226-syscon-reboot-reset-mode-v1-0-91c1b62166ae@linaro.org>
	 <20250226-syscon-reboot-reset-mode-v1-1-91c1b62166ae@linaro.org>
	 <174058375994.2463209.9948592153423144239.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-26 at 09:29 -0600, Rob Herring (Arm) wrote:
>=20
> On Wed, 26 Feb 2025 14:08:20 +0000, Andr=C3=A9 Draszik wrote:
> > Add support for specifying different register/mask/value combinations
> > for different types of reset.
> >=20
> > In particular, update the binding to allow platforms to specify the
> > following reset modes: soft, warm, cold, hard.
> >=20
> > Linux can perform different types of reset using its reboot=3D kernel
> > command line argument, and some platforms also wish to reset
> > differently based on whether or not e.g. contents of RAM should be
> > retained across the reboot.
> >=20
> > The new properties match the existing properties, just prefixed with
> > one of the reset modes mentioned above.
> >=20
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > ---
> > =C2=A0.../bindings/power/reset/syscon-reboot.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 74 ++++++++++++++++++++++
> > =C2=A01 file changed, 74 insertions(+)
> >=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:

oops, sorry - the script we usually run didn't cover this binding,
I've updated things and will send a v2.

Cheers,
Andre'


