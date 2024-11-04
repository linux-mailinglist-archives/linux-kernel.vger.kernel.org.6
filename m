Return-Path: <linux-kernel+bounces-394358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047D09BADE6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDD97B218CC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBC71AB526;
	Mon,  4 Nov 2024 08:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGb+odqR"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4848D165F04;
	Mon,  4 Nov 2024 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730708439; cv=none; b=rL0KoU8BIw/tmTmLLa9OTkNlNMuktksnvT5ujq10E/RdnY+VaAkeo8F4YUtjhfIUcV3ItUnXWjetPklZHPk9oX00dCSGOYrsrimyA1Bd85r6Vg6kvKJaIoRYzN00FW3ogSsc3AGKk/NAMLCcM000KsSXqXL0WmpuIsfIg2Jvwic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730708439; c=relaxed/simple;
	bh=Nfv0dt+GZMKlMN5KP/ZwxnVWZP74CulOtAsGT3GgNpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JomgYyyNYlVKcFb7ULGcUf3NVeCe2AnPeUL0pHxRXo0vw5rMqbTfCur18IdHSHYovF6i7z9TctGrVaX1mNmUSvfg15jnPdU/1/LRfcvlcstLApLVDvfjmNfhVlRNmlzz/Zjoy+ixxLD3mQi98yFvMy3YSyGxWeundV+/oqN3m3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGb+odqR; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cbf340fccaso31933346d6.1;
        Mon, 04 Nov 2024 00:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730708436; x=1731313236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1jVXbPTVzBsjqPi6FFutxVJsnea7PWQ8s+9/ntA9tg=;
        b=hGb+odqRa0YLlR6Kbmuzr8kyazisbgIh+VMOjNG3cmG9booW8TpadzotKzxkjDj7yc
         eWkDVNk4h/NQ/65ScCCloDckE//uuLtZZs3PucZUjDCe5oAgNbgLbeswO2aAXPRGhZrd
         1qWUZ4hX6R3cmeoKnZfqcBmlM4OLRxNu82ud/RJIaT8oMH2s09Sre+njFFeCQTjhCWPJ
         FRSXtk5tPPryBnSKO4cqmj/ptbsjXV7r5SJgRkD8mssexoZgeeShPUjNveOshCUTpMDB
         mzqqNacZrvB4qF+kAn/7ZDNwecC4aQErPlB/MXPjMxZqhMhCPOsV8frOeeEMF8zTRqEP
         ZN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730708436; x=1731313236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1jVXbPTVzBsjqPi6FFutxVJsnea7PWQ8s+9/ntA9tg=;
        b=fCgPEz+yWrOIw3xajeO8HyTQiYnKSlVT4kLfEJ717nylXRxEN8aNGhhhys1G8r0hDK
         mjNNVfb3d9mKwnsjEvsoJjkJ8LQQ57x6bLCoeSsj4gsTHzWroe8jKox7auKP9vAd653c
         mvRta5+mdQZ781xRjibzfIRbNPuilBAS5w0GEDR2MdnBOAB9KWadjA9qmqbxiyDnuBO6
         LWuzNfmdILVS+HXvUo2XkU3hOvVUmBcLLibgVpE1u7NYheJdzoPZwKswuVXq2Q0Zx/WC
         q5qGqsYu1fUZkdCT2dZxjxJ18SM/EvzSvCwJ8DcfwllBcX8Q0xukQkVDf0pR2gEQtY71
         7ICA==
X-Forwarded-Encrypted: i=1; AJvYcCVDLWEKDDLuqCBJuByfLZ8CnUq9/2BCs2g/UQ9V1fkhTNuZbzKf556i4/q4U/ydhV5cY7JDzoLF03Bi6i0A@vger.kernel.org, AJvYcCWJ+MkeANpLuP0Y1Es7kxFLP+kAxvCMEukeEI5xU2PG6pMZGb4/t6zIMYKSFwcopNPuwhcVJC6RNRba2mo=@vger.kernel.org, AJvYcCX+rnswRaYQC7h8bljaIvX8YiKg+115s8kPkMIxbvN47mFwcGPqRUgX35Mz43mvDNsZeek/zvIp4rS8@vger.kernel.org, AJvYcCXvsZQOxdZJ/su90H1XpjdLyC7HRiP6CFg83IYZBen7YmkXRvDfJivuaXqN73H7oiiab2ymX/vKyUM5@vger.kernel.org
X-Gm-Message-State: AOJu0YzZhrXCuH2zCDAQJstgnzDgmUbxdgL4fnM0br3jbCbKZ9dHuVs5
	cUlonlNpqv1DR3pH4eLrtbSSnJUO5ouzHbMcU8eKVqVthY0UNQ98eVg+6faTqZH/co6s42pSuBq
	WgkujO5kdor5jqL9vzEOiljUKBuQ=
X-Google-Smtp-Source: AGHT+IHLgcrkYBUwDtz8eL6HLBbEFOCEwinDtbXkm6C8XHnjj2JY5Dc4znzcgnq5rs2Dq/efGZ+wJLDtRfgCTcX864k=
X-Received: by 2002:a05:6214:4a8c:b0:6cb:ef36:5fbe with SMTP id
 6a1803df08f44-6d35424a60amr251831156d6.3.1730708436288; Mon, 04 Nov 2024
 00:20:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022052905.4062682-1-kcfeng0@nuvoton.com> <20241022052905.4062682-3-kcfeng0@nuvoton.com>
 <2339841b-034b-440f-83ac-139d95059727@wanadoo.fr> <f6846ac5-55ee-405c-939b-1199ea362fb5@roeck-us.net>
In-Reply-To: <f6846ac5-55ee-405c-939b-1199ea362fb5@roeck-us.net>
From: Ban Feng <baneric926@gmail.com>
Date: Mon, 4 Nov 2024 16:20:25 +0800
Message-ID: <CALz278ZtciLq3gVyB_66zNPDh+n2oypLOmVSUQq4yR5sO-CoNg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] hwmon: Add driver for I2C chip Nuvoton NCT7363Y
To: Guenter Roeck <linux@roeck-us.net>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, jdelvare@suse.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, corbet@lwn.net, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	openbmc@lists.ozlabs.org, kwliu@nuvoton.com, kcfeng0@nuvoton.com, 
	DELPHINE_CHIU@wiwynn.com, Bonnie_Lo@wiwynn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 11:14=E2=80=AFPM Guenter Roeck <linux@roeck-us.net>=
 wrote:
>
> On 10/22/24 00:20, Christophe JAILLET wrote:
> [ ... ]
> >> +    hwmon_dev =3D
> >> +        devm_hwmon_device_register_with_info(dev, client->name, data,
> >> +                             &nct7363_chip_info, NULL);
> >
> > return devm_hwmon_device_register_with_info()?
> >
>
> No, because the function needs to return an integer, not a pointer.
> And
>         return PTR_ERR_OR_ZERO(devm_hwmon_device_register_with_info(...))=
;
> would look a bit awkward.
>
> Guenter
>

Hi Guenter and Christophe,

I'll keep following this driver and check with these suggestions.

Thanks,
Ban

