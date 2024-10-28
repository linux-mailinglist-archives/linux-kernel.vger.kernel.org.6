Return-Path: <linux-kernel+bounces-385219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 330B89B3422
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1921F22620
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6251DE2BD;
	Mon, 28 Oct 2024 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfhnR8EB"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0611DD88F;
	Mon, 28 Oct 2024 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730127472; cv=none; b=m/fhY0izV/GnWu6xBrGhBw/PwuuZkvjtVe9vO0XZjGeu/kqHF+SrXvnWtZyj9hZolD2BCAu/aTXazXZj6guRloM5W9NPFql+i15PvY5j9kIz+a361rgz2sXJzdAFO8ydjYulVi/JtGHd7aVV3dC9PZxzdNB0pa31I2pLwN4hBgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730127472; c=relaxed/simple;
	bh=JNw2e73J2eV1h/GOBlklRjBzAVe8uwhGIZtJa6t1djk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6qGSjlPGf00g00/xbnlveTOb4pep1DQKkZvXIyzNQR0FFtBy8nYcblFpIDgUZ/6b8zFqcp+AGx6V8MntgOQEVnkestmU1MyuSCZHFtRCRiaR78mlhbuLkDccJCl2PUe7eMwsxh/0HEIt4VzVhDtI+4Knhai+4Ne06T5crHm5dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfhnR8EB; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e6104701ffso2693231b6e.0;
        Mon, 28 Oct 2024 07:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730127470; x=1730732270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/YrC2RdmmDYfu70L7fvVu1XlTAzhSEEMTC8WHyyWhM=;
        b=LfhnR8EBlGvUex8qbC/pO4cfyu95hEkT/wJfbtQSlUoL2HBRI87HGwLY6HMVmhwWio
         LOLRUBBtVaWy3QxxurWCSB9jc4smOqVverjwpEUjWZV3ghDrLBtBBZ7gHL3v/e5gv9hL
         NnXgOyAaga6mi+f/ldivIkdg8oLuWWVtQdfJXrCv2/WyrhHOrdPU/nfC2O9c+nB08HkI
         XTg1Se4k2ka+7jKbHl44g7PkNO6YxF7Kl2K4DuG5OrXrPvSPMjLLFpLwz7ztCpES1dI5
         zugurF/iHdz9T5ODNi/6Yjlg+5gUcqJk5fyFncEgiQ9sVZ/iNuxhV3ns2ucSBUgybMuU
         y0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730127470; x=1730732270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/YrC2RdmmDYfu70L7fvVu1XlTAzhSEEMTC8WHyyWhM=;
        b=vadS5UWyu0C/4VxiiM9zddkMjYQej+3+LSytFKoxeOkTFeUgVGxNNqi913VhVM0EZs
         Za9Ag5YvwLYjI+Kcfh13eUIo9NgiI6ZRzRlAp0OY/+lGg+nANv+6J/8w6DWw+j/c5MFS
         Lz6r2wJ2tIAIswAhgUPZZPCIsycW2ABBKkbgplGXlpAhOeLKBIQOvvi2LZS2+LNREZ8m
         FwECUwZOoiGOTrEFoyzfltlNgvACnWM9ZGnSfQZwjP0Axgg1CQ32qYxRBxIjx+myYWjV
         IdxL1vDkeKFZokpLmCTR2z3bs2QqMHPA+zFu4Rc9vOyBYlvm58h4IgrkexKOvHDWV9YY
         Wxug==
X-Forwarded-Encrypted: i=1; AJvYcCVJDJJGYDoVLuylogWE8f6XWaV+YvBE9rzvS8Bhsn8qg/FmvC4gY2lCtMYdT/vQYqrchGxC9d6UMZFX@vger.kernel.org, AJvYcCWmJOGD2Xx7E1lbQYW54e+4Zz1nhPTHLBL8MFDHpFw4zME1hugkk0U0ZTmLFcXALk/tnrwxPLn4VY8SHvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSYDj4l218xE+wD11fAXC8k9z6wdtEpKFyp8GkjBtds9uev+no
	LW8q+JM+HXFVMqeMUKbW2kTaTxQXQ/S7TRKSI1xRrf0iVWP8CS3l8M9AFF/8+kj3su33Uu+NHPe
	8NhRMOYnTt34qZNkUCjC4wL7Ka90=
X-Google-Smtp-Source: AGHT+IEovg7l3McEchPGNAiGLqs0R+bGRzw4K7In1sEPtWvN8y+JE2vHv+bjCZeySecw9FNgdOOBzza6Da50FfDZ3Wg=
X-Received: by 2002:a05:6808:13c8:b0:3e5:fbdd:e33a with SMTP id
 5614622812f47-3e6384430edmr7443523b6e.13.1730127468844; Mon, 28 Oct 2024
 07:57:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026080535.444903-1-akinobu.mita@gmail.com>
 <20241026080535.444903-3-akinobu.mita@gmail.com> <ijdk5uuurnfd2shnwwj2nm64bno6lmrhdyqp42pzjc3i2e5cyh@v5ljkrsgo6ac>
 <CAC5umyitFp7oGR-eYXMVaS8bY1AGe3QwEuSPoEz3DxWwH=dUsA@mail.gmail.com> <e29e2c9e-60c1-4f32-ab71-e74f331e1921@kernel.org>
In-Reply-To: <e29e2c9e-60c1-4f32-ab71-e74f331e1921@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Mon, 28 Oct 2024 23:57:37 +0900
Message-ID: <CAC5umyhCw+62Y+h3Jvh3=0Ocs8XJsSu_vaiPpO_g=65Jo4vUFg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: hwmon: pwm-fan: add
 retain-state-shutdown property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Billy Tsai <billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B410=E6=9C=8828=E6=97=A5(=E6=9C=88) 23:22 Krzysztof Kozlowski <k=
rzk@kernel.org>:
>
> On 28/10/2024 13:42, Akinobu Mita wrote:
> > 2024=E5=B9=B410=E6=9C=8828=E6=97=A5(=E6=9C=88) 5:38 Krzysztof Kozlowski=
 <krzk@kernel.org>:
> >>
> >> On Sat, Oct 26, 2024 at 05:05:35PM +0900, Akinobu Mita wrote:
> >>> Document new retain-state-shutdown property.
> >>>
> >>> Cc: Jean Delvare <jdelvare@suse.com>
> >>> Cc: Guenter Roeck <linux@roeck-us.net>
> >>> Cc: Rob Herring <robh@kernel.org>
> >>> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> >>> Cc: Conor Dooley <conor+dt@kernel.org>
> >>> Cc: Billy Tsai <billy_tsai@aspeedtech.com>
> >>> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/hwmon/pwm-fan.yaml | 4 ++++
> >>>  1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml b/D=
ocumentation/devicetree/bindings/hwmon/pwm-fan.yaml
> >>> index 4e5abf7580cc..86a069969e29 100644
> >>> --- a/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
> >>> +++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
> >>> @@ -40,6 +40,10 @@ properties:
> >>>      maximum: 4
> >>>      default: 2
> >>>
> >>> +  retain-state-shutdown:
> >>> +    description: Retain the state of the PWM on shutdown.
> >>
> >> You described the desired Linux feature or behavior, not the actual
> >> hardware. The bindings are about the latter, so instead you need to
> >> rephrase the property and its description to match actual hardware
> >> capabilities/features/configuration etc.
> >
> > Is this description okay?
> > (Reused the description of retain-state-shutdown in leds-gpio.yaml)
> >
> > description:
> >   Retain the state of the PWM on shutdown. Useful in BMC systems, for
> >   example, when the BMC is rebooted while the host remains up, the fan
> >   will not stop.
>
> Nothing improved in the property. You still say what the system should
> do. This is user-space choice, not DT.

It seems better to implement it as a device attribute.

