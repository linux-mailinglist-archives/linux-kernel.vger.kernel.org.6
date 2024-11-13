Return-Path: <linux-kernel+bounces-408104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFE89C7A78
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5491F23180
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ABB2064EF;
	Wed, 13 Nov 2024 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/7sOOx+"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F0720605E;
	Wed, 13 Nov 2024 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520678; cv=none; b=nNHzH09mvj+lZ4EpbrPBj+d9m1VMIL5lroMlvtNI6BCH/qFJ6dumTzaxM9zhLh3qAItaCqmTVlRJ2ru5drYKLqjZyOOFi9Yy/Vfj4rOZ9MQsEJ6Y5t+oVBvk0HUY2DrbDDnmBXg2OeMtxwkiGGt+7A1ir/wFzaicguXeuqhb2QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520678; c=relaxed/simple;
	bh=2+naAnEhlYo0y7mD9BWzUkdNhpan/DMW2MuKIQuEKRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5QI4qbXsgjJKYbU0tfOHDXyChobYGeH/dZ5jmG7smBh28QCPawnUIDmsDxi00gvKCNX93Q1doT+sBcre4SNJltZXUBGJCQUpEXnsC0guKHyONOfVxTnvkLfX6LnpR/Ba0VwC65Z+QB3LyeqnXtOOUSYgiY4OINRSbkfVORhalg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/7sOOx+; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2feeb1e8edfso95226381fa.1;
        Wed, 13 Nov 2024 09:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731520674; x=1732125474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+naAnEhlYo0y7mD9BWzUkdNhpan/DMW2MuKIQuEKRk=;
        b=L/7sOOx+kcbyIxAkZPa9NyYQyKtMwF5oKjfVoiL3P3T7iJ6jSg2A3aITV1xqygFyq1
         i0+hXeTudVZpsaCUt8muNqUu2p7/+99/2CiW8lyaQTT5PFha8W+CIdZKxd0pHwqoEUcs
         3PqnwJUN8mKuOoPz1SB9bWDS5awMlPCZsuQB7OqwYIBRIeNp61787lz802vfLJ4LiyJT
         ml7g5P0y+OD0VkfeYANkvqyA6fP22oRuBNq9VhafJ+sLN91Uj9pkEgY6OA2Cp32AHPUK
         yfy4MAbNLcO1zwtdH9muFKGImAIMtmd+mk8G0o8fl//Ata6IUoIFwOI5CFJ6Gc9W7XHX
         /1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731520674; x=1732125474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+naAnEhlYo0y7mD9BWzUkdNhpan/DMW2MuKIQuEKRk=;
        b=c7/zPLPZyLLBfSi0u1Rbg4R1DknTmiXJepgHjfTlWfKd43FdjmUAZI3wv35pcfWeP+
         R6n6RU9tLpfyGml80d363YozYRVu12gzWvrosfq5WdIZSvpHPHhVrj1vCzrIGXZrMljN
         Gz+QTnp3oF0AsPRWgxi2PpmqtsFVg9hTAHaeJA0WaYH9NI8sOfuRJpq4CZDCBCcvT1vV
         9tM6ED1AigzNLejkKKq/mfanFfmJU8Oc71jgIUfaTwd7vSHiNP4qC21qy26ZdcPIrch/
         x5Agu+cLNPXbhQbmieBsHHBK1b0xX7HEMrDfml/VfSHpqMVl19Md3UyMt+fkQA1kanUU
         D9Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWFZjQpivDDMumZDb+f+GIVZUXUki27tM5VBYpq0M5NuisevATKIYciOyZKDPyqTKP4Hhk52XZtjME3UsZi@vger.kernel.org, AJvYcCXza42ZlsV6XQi90vbDiuMm8sfVb4GV6dgVzApa2fBoHdpskPJha7hiGe3qJBuKgwP1XDI5nD2W9C+t@vger.kernel.org
X-Gm-Message-State: AOJu0YyvuU90YZ3baijetxt9xv6Z7hcKRX7/t6/rnlBc/bQ6a8fKDHet
	qZINTDTE0IvBr/rwJtCBEMuSePN8TV822Xm1ToP5F7Y0qE9IPRMsb1ftFG37Cl03V3mcncAqhjO
	P579Y5hGKVZoYYOzqMCC1SzmlOxo=
X-Google-Smtp-Source: AGHT+IG+aC5tPt2yrdBuMhr6qpWwFd7aP0+osiz15sDwB3XQBCFR0oq0kfKom9cIQROfLPtslJmNhaeftR6G8xMCBkM=
X-Received: by 2002:a2e:b8cc:0:b0:2fa:fcf0:7c2a with SMTP id
 38308e7fff4ca-2ff202079b4mr141052341fa.24.1731520674006; Wed, 13 Nov 2024
 09:57:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023185841.1183706-1-festevam@gmail.com> <20241024-pep-proud-d714705c9ddf@spud>
 <CAOMZO5BSZ4YAZ7Lqa3eGP9Wx=Ed7cgug==_UZqc7F57=XCJv3A@mail.gmail.com>
In-Reply-To: <CAOMZO5BSZ4YAZ7Lqa3eGP9Wx=Ed7cgug==_UZqc7F57=XCJv3A@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Nov 2024 14:57:42 -0300
Message-ID: <CAOMZO5AgQxd2_gkcPSdhfSDArEEkBVvo_yAW3hdHVXtHH5FyAg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: timer: fsl,imxgpt: Fix the fsl,imx7d-gpt fallback
To: robh@kernel.org
Cc: tglx@linutronix.de, daniel.lezcano@linaro.org, krzk+dt@kernel.org, 
	Conor Dooley <conor@kernel.org>, conor+dt@kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Fabio Estevam <festevam@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Rob,

On Tue, Nov 5, 2024 at 7:48=E2=80=AFAM Fabio Estevam <festevam@gmail.com> w=
rote:

> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
> Can you apply this series via your tree?

A gentle ping.

