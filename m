Return-Path: <linux-kernel+bounces-211462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6084B9051E7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099361F283BC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FFD16F28C;
	Wed, 12 Jun 2024 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fnqZgEYx"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EB816D306
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718193726; cv=none; b=EWlWLqaj/b9uhN0GUtMETuTw/MAN6+1qATJ2j9E1LvMykxnwpmYl0Nr5IM0QkDLP26fqfv7pAYg84RMIhLHwP09IK6gQvrihDrA5+z7rOleqsSQWXbaYEijAPRhpmCF1A5QwgDKFRcuEt3GqUDjwHyxGYN+bHUW3h2LRdGPWTBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718193726; c=relaxed/simple;
	bh=yD6R8w4UBkKJudrIwQyum7bH4UdiU/mENrrdT4nd20I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cITgo/ff2ank2nodbvFFx8mekCIrvyuEydC16i8u3Cvqugt9gcvi5CKmGipm4ZdkVY+cEoAHO0x9Vlnb0h2d3lnfCPtg33Dr3iaZ2YvZa6Ky/RFU9zLQilpgqafNXAqkVLhAtPmsusXhh6JrO7ZfTTtIBg4APhunHsQ5Brw9uwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fnqZgEYx; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52c9034860dso3514961e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 05:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718193722; x=1718798522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgHNgP5mgQQhJMbmzukrZ80r1nI1t333GxSKlDaG7So=;
        b=fnqZgEYx18dNfHggOD1+6+vQV8fw1RHjlS0bzrZXoVVJIj5VyIq2EvXZP4YfH6cf7x
         nnfk4ah0AJQHeMm46e5psUFjEoJKZ6NksRHR4zJGaP4Hcp6jBwMjmCe/6vrPmpZx9HGQ
         OoWqDzY9HSdOfZUgySymyzQbQFL3qlZSVF82bUqZe7fdrpM18jGlojVTFde2XFOwW0gR
         SAv1ZoSJ18SrgXEdS9W8On3LZt0yaXHD5YePpSnGbtg4jdi9LmRb8kjz6Z7u/tQ87LSq
         m/HnNATGUv3XBPSLhCEDITN9MSlUkTHxL47DDzHMnmk5e0xCTP9m+VMN7S2cPOl3oDYd
         j7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718193722; x=1718798522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgHNgP5mgQQhJMbmzukrZ80r1nI1t333GxSKlDaG7So=;
        b=E7WbKSAaLTx6paHbXeTs/zUCZrzZoHB6lT7yqt+w14LGbUQ3DriVzuLDpZd9c0+J1Y
         s/2bSbxZdteQofu22f3mjU8DW0/4fv88pzIxZnEdSedXOC919rsI61vzWzQFKCp2Kjlc
         lvKBx1xUrPwgjog9Dw7YE84LrbTdBjxmQjVEVb4qUIdGgWr/7TBSoRON5RADbOCh1GL7
         PvaYJydMVqesH2EXK/DNfO+3U0Xi+/KPfXRc9GyKRUmMWUOshEQ7mit1UZgx+RxNBDlQ
         MH8FIOQrkiDXS4xXv57Sve1F9k+D49qPMkQTfhebAHcIldkhjb358xHo2ZNBPoscTTdm
         sbsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN1c8MoJRTX7Bc4Cavl46YSCr8m2wNZhm/yusGUnDGxPrq1wrZ3ecSF+VQ2ZRuqF3BQue966q00kSyNWWUxAevlrjWZuSAkPOT/97m
X-Gm-Message-State: AOJu0Yya1QFWFkVwKjyXAv+ssphOnbpepsOtlwah/bg3Z4vMnUOG9kHR
	ATPlJLIlJd/eSBDJENDCL+vgMXO26XoKyZuafvlbny1j5iKld+ja5f7WKC0kq6gIxrG0GrA+FlE
	1VzUbPLha3vu5UaIgtIYwi+VJt6XE2TC0F0+x7Z9SUNAd/gVegVY=
X-Google-Smtp-Source: AGHT+IFTsWHoTu0eHCUEIDfT+ze11HzmE/etIZ7sNoJT7JzsAgwhY3+Wp9mO51T7N/HcjZr5s9IGNKEKawNEM8cxd5A=
X-Received: by 2002:a19:8c41:0:b0:52b:be6b:d16a with SMTP id
 2adb3069b0e04-52c9a3e3b86mr1025330e87.31.1718193722025; Wed, 12 Jun 2024
 05:02:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611140034.24685-1-afd@ti.com>
In-Reply-To: <20240611140034.24685-1-afd@ti.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 12 Jun 2024 14:01:50 +0200
Message-ID: <CAMRc=Md4ayrVmiD1xPSmCrF6KrjiZGyFVpnrQt5SX46KY0WZ_Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: lsi,zevio-gpio: convert to YAML
To: Andrew Davis <afd@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 4:00=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
>
> Convert Zevio GPIO controller bindings to DT schema.
>
> Changes during conversion:
>  - Add used but undocumented interrupts property
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---

The conversion of this file by another author is already in next as
commit e4608bbccf2b ("dt-bindings: gpio: lsi,zevio-gpio: convert to
dtschema").

Bart

