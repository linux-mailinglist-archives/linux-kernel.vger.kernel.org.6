Return-Path: <linux-kernel+bounces-211141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BDD904D9D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61BFE1C236AA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A4816C869;
	Wed, 12 Jun 2024 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="aE7ueDgd"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7A116C6B1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179585; cv=none; b=luq5eBFPg1uG2Y0IAxwoKFzAZfJNeMZ/W2aoyUUnUhrR/HtXUrYvAOUtQKejbUDg68WSWlrWIZufTTacN1dbGxV6KS/zurkkZNO92g113TquuNT0lnAwhzuHu5Q6wKpXkfg61mgBLHDA8zcaj108akVFs252oZFQZZmyAbhBCmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179585; c=relaxed/simple;
	bh=jU0s9gEKbGXmqfGEflzcwnbnMDxLuaH6EgnphUim8yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gXXlq0I/Psx5t4VejWwZUzztTu912FoRK/G4JtzvA9HZkP1/SJQj8zcTnvVem9NKAVctHnrd1nJu7nZ8cxsdp6eAczzuLh8JxUUZxcusk3GvN86vI2F98V5fz7NuIqEB5uOeSIsW4OQAl2aOwnYNLxy44rlECrbYfAdgvz0kIaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=aE7ueDgd; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6ae259b1c87so5933266d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1718179583; x=1718784383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jU0s9gEKbGXmqfGEflzcwnbnMDxLuaH6EgnphUim8yM=;
        b=aE7ueDgd63j9DsQ5S/8r1j9nf7EPyMqv69K4YvVtXd3L8udGkjMgXHWmWsqqsOSDsu
         J8n7gJ2UhmLTtTNemmPgSxgFUVwoaywIiUURZcRICeU95rtW1u/ogVF5WAN36ttMw/I6
         6tGu7S6+BuD8PZUgnno+WvYrgq4mFtkD6tKsHMIOyb2sahAPZ8wfI8yQzRvg7YwKg7c8
         I90al8oevBCLHoemos/kzMkAkIgnk/1WOVcOEMxTeP62zEGVRSYm8JWm/UsHc4J/r8KN
         COPAputChhverY4EMy4hTG9Z+QkMGLcXJPP2TJxFXjyzPh/T5SXyaSN/4rYeo5fUdPxd
         LEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718179583; x=1718784383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jU0s9gEKbGXmqfGEflzcwnbnMDxLuaH6EgnphUim8yM=;
        b=k6cextOfT4BoNb+fuzU4fAdjYrpYIYh5Q+YZ0CSjqfWck8IfzZTS+AxCZ2eiBmfDIt
         HStJqDFlrNFrroiAltFqT+pzhvdX8u2UMQ0i32MSX/pt9XsWIZdD1Dwq5l1G4dJxKipG
         i522ZbEVXDwrccCrDi/W0YK+GGS5cocasdOBUkrP0NbiWVl4iwXb9dQc0gFDjeRrFzDe
         PPMb5YjEXoXPXsRDXFBEvhxAV3plipmRaUyIcMmoIoQjTGU3Zsy+PEjLhUIcNTLCzhYR
         HPgE0+bH20JgIih8/L+BZe9r9Vf42S+3rZZUwpILYH8pE7lgVIP927xDNtbMLyCDfVWu
         e1lg==
X-Forwarded-Encrypted: i=1; AJvYcCVf69KSqGfRcL0DvGZBjTKY/Bs30zabYVv9TCe6uewNAYwj/R+3UT+h8oeRC+jTI/q33O9uSbA70Sv5ivzm0K1kqTR1uPuY5RNwzXB5
X-Gm-Message-State: AOJu0YxgxUHy7vsloTM53s/7EcxEez1/YOlbZZXnrlyn4x0xbesQpTnc
	ocMRL0ww0IyBxv6mT2TMJr9OWuNGg2dksTR/ji0JxXHsquttXj7a5W0BU1Gx8KXR2fzF7IRlwlg
	5R1kwyoLnkIq2StHoaR2OaMsROy2LvTO+CnRUpQ==
X-Google-Smtp-Source: AGHT+IG1/F1xQpU9EkBs57YWAqg59A4uhPeAz2DU+7fqEukJUGW0HybNnc7pOII0nGwuizPlb618ysTlXm0ZvIeJ3Yo=
X-Received: by 2002:ad4:5d4d:0:b0:6ad:752d:1530 with SMTP id
 6a1803df08f44-6b08a0780damr78312956d6.27.1718179582619; Wed, 12 Jun 2024
 01:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611094810.27475-1-piotr.wojtaszczyk@timesys.com>
 <20240611094810.27475-2-piotr.wojtaszczyk@timesys.com> <51eeec03-47da-44b5-a21e-f280d0c4b47c@kernel.org>
In-Reply-To: <51eeec03-47da-44b5-a21e-f280d0c4b47c@kernel.org>
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Date: Wed, 12 Jun 2024 10:06:11 +0200
Message-ID: <CAG+cZ06EN4Uw7Cy+kwsiPzu16Kp7tsF19Oit6oN6GUcSe464JQ@mail.gmail.com>
Subject: Re: [Patch v2 2/2] ASoC: dt-bindings: lpc32xx: Add lpc32xx i2s DT binding
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vladimir Zapolskiy <vz@mleia.com>, Russell King <linux@armlinux.org.uk>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>, Chancel Liu <chancel.liu@nxp.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 12:45=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
> > Changes for v2:
> > - Added maintainers field
> > - Dropped clock-names
> > - Dropped unused unneded interrupts field
>
> Does the device has interrupts or not? This should justify decision, not
> current usage by drivers.
Yes the device has interrupts but feeding data FIFOs is handled by DMA
(amba-pl08x.c).
Should I declare interrupts despite they are not used in the compatible dri=
ver?

--=20
Piotr Wojtaszczyk
Timesys

