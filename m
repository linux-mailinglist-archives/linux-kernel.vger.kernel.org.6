Return-Path: <linux-kernel+bounces-449462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7CC9F4F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5D11882671
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09BA1F7567;
	Tue, 17 Dec 2024 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mws3iLCQ"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45241F7082
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734449086; cv=none; b=fR2OreYjQyQI0h/IG/+EsyQ8hEY3d2/C+MkQ2iO0I2QUFdbw1HCQ+ykQalCUJEglQrzdQIke8NJYIHShvkI70QNc7NBLJZYg20YPJ8RMtqIgJOFZzxH55FKvSFJR+hlFzArlJrSXitg4RwQIYVah5bodMpW3mcj+u8AQbhsVEhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734449086; c=relaxed/simple;
	bh=tJcj122iz7Jx3wrPNt7YdMvOP8Z5lwK8MmU44L9IfCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDJY3Z/jJ7GNe/OkenXM+SmoqbvXzFrjxruU9mp0BRn8eQya2Ny2Yv+T+lXImDk3SsflJG5SDkTeEudbCPjBjI3n0ah/xKv6hHlJFlQOZR1MRdqTgm+52yM/6rZmmb29z0jJ9rK93ZJtE2274Xq4mC3wP/gKYgjCiycqok17334=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Mws3iLCQ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725d9f57d90so4022999b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 07:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734449084; x=1735053884; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0H8dpphBiU338zp26XHA6XldVzXKyZfnCcMSHEK5Qec=;
        b=Mws3iLCQWKMXA2b9km32fZ9IoiKb1G0cFDEC76oypJ0qNOxwy5EQ6yWxQWofjh3iqx
         0a69kaFDvFOOKQLMkgjuWmuU1ylKUYKj7rHzyVKgslX6MHWOhAqgT7tk5GsWCsVYjEiR
         wmWOqv1glDQVkoGB+/AiDfZeq2vrfVBtU+QUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734449084; x=1735053884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0H8dpphBiU338zp26XHA6XldVzXKyZfnCcMSHEK5Qec=;
        b=iba3Hs2k+UEPla5uYvJ8dS5WEkxm07PqG58jtCZ3v3PgE+KuOS/z9b+JL7pTEfdEwg
         6ZxerIYgh3ZmtUvLw+mi/fUVo0TEjFPWmyEJRHCTIH54IgfjN72h0HstEbRDrGhMdFWm
         M0mDlVf/Q8ZpxDebHNqPtULy8gctxUvRLZPiPYLqYGJQgTIo+Wszu8+nzpctlwM9WAbM
         QqxLwoXa9RJipyOEBpiC8zdkSfyhvQy78qozmkjUpVfBr9Z7ZjHHGuy6LUvPavGFfYVu
         DTbdIS+q/io+TGCtNpQr09ZJhad+P1v5g8MzF/8b9izschFyXm2lE/3YWbAW9cz+XXwK
         IZMg==
X-Forwarded-Encrypted: i=1; AJvYcCVxlEauFUMBaXk9+4MlbNljzZbRwpS2YnN7x0/JZ01yOimWXYjBcuKKaWDMPZCxZnmfm7hYudiNdErUSnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEI5u4QbKBzHNc6ft+LDaCKiSnYQ7moIV0oLCnxuwc9NWyt5dB
	E27oTMzsglAOU8Ip71URxK6/d3HUEUdLBVjUF/Guq5Ex4n1nEAEvG/ripAXCaYwHNoBr5f2I9AE
	=
X-Gm-Gg: ASbGncsFH7AZC44F1RUN5VyZP6+vXbwy5q5zMVzBN4mcznd2uOxpiWcpQw6kKFKQRw+
	VN9p1c8mLBu4PecJDrem0XsK/i/hpwwJlMUfYRnHILOD+Y7ZkEPYvDbZsfrGLCbZCerSpov5P6j
	4OJnW/85EqFfHtRo0r3/Dk9PX4qZmTkYa0eMBTJ6RFdauSnvuqHeMgW+qe54hG2l8LosIQEoZtf
	pY+IZGioYWwwOTSBfCpYLbdiu3Bvq5CogWxww5cKstey+QSWNIFh1ardSG4pzf95kp+mtVDVuq/
	ALlQPvXUiLe2/7GLOT0=
X-Google-Smtp-Source: AGHT+IFrzcUzgNnMChOZT3YqOrLI2JBz6kI+AQYsivg9wJkI2O7wtjSrXOV2fV7f6/Ru9+FR+64bWA==
X-Received: by 2002:a05:6a21:394a:b0:1d9:c615:d1e6 with SMTP id adf61e73a8af0-1e1dfa95707mr26492353637.0.1734449083748;
        Tue, 17 Dec 2024 07:24:43 -0800 (PST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com. [209.85.216.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ad5687sm6792661b3a.72.2024.12.17.07.24.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 07:24:40 -0800 (PST)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ef89dbd8eeso3603366a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 07:24:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUum3ogDwYIZta7kE15Ip8+3L+Wmq8oKDpq8bbnMD1QR4aWux/DueaQh1UIaAbJK3Btt06fYK8TnnIa/WQ=@vger.kernel.org
X-Received: by 2002:a17:90b:3d4e:b0:2ef:67c2:4030 with SMTP id
 98e67ed59e1d1-2f28ffa7efamr22923781a91.27.1734449079297; Tue, 17 Dec 2024
 07:24:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212-usb-orientation-v1-1-0b69adf05f37@chromium.org> <20241217145612.GA1652259-robh@kernel.org>
In-Reply-To: <20241217145612.GA1652259-robh@kernel.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 17 Dec 2024 16:24:27 +0100
X-Gmail-Original-Message-ID: <CANiDSCu_mFQQVkDb_gSyXeb1_Tu+DxSeHYvGsGp6XVDuOdPyjQ@mail.gmail.com>
X-Gm-Features: AbW1kvbl1RIFIvxrMQUN76wEj-BZmkCHKRl0SbByJH78c9Yqx7sfn6vg0uVQdIU
Message-ID: <CANiDSCu_mFQQVkDb_gSyXeb1_Tu+DxSeHYvGsGp6XVDuOdPyjQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: usb: usb-device: Add panel-location
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Jacopo Mondi <jacopo@jmondi.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Rob

On Tue, 17 Dec 2024 at 16:02, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Dec 12, 2024 at 09:44:37PM +0000, Ricardo Ribalda wrote:
> > For some devices like cameras the system needs to know where they are
> > mounted.
>
> Why do you need this and why only this property and not the dozens
> others ACPI has?

Userspace needs that information to correctly show it in the UI. Eg;

- User facing camera needs to be mirrored during preview.
- The user facing camera is selected by default during videoconferences
- The world facing camera is selected by default when taking a photo
- User facing camera have different parameter defaults than world facing.

Right now, the only camera driver that expose the ACPI location
information is the IPU from intel
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/pci/intel/ipu-bridge.c#n258

And they are only using the panel.

If we need more information we can consider adding more parameters in
the future.


>
> >
> > ACPI has a property for this purpose, which is parsed by
> > acpi_get_physical_device_location():
> > https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#pld-physical-location-of-device
> >
> > In DT we have similar property for video-interface-devices called
> > orientation, but it is limited to the requirements of video devices:
> > Documentation/devicetree/bindings/media/video-interface-devices.yaml
> >
> > Add a new property for usb-devices that matches the behavior of
> > ACPI's _PLD.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  Documentation/devicetree/bindings/usb/usb-device.yaml | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/usb-device.yaml b/Documentation/devicetree/bindings/usb/usb-device.yaml
> > index da890ee60ce6..1ce79c1c3b31 100644
> > --- a/Documentation/devicetree/bindings/usb/usb-device.yaml
> > +++ b/Documentation/devicetree/bindings/usb/usb-device.yaml
> > @@ -42,6 +42,20 @@ properties:
> >        port to which this device is attached. The range is 1-255.
> >      maxItems: 1
> >
> > +  panel-location:
> > +    description: Describes which panel surface of the system's housing the USB
> > +      device resides on. It has the same meaning as the `ACPI`'s `_PLD` Panel
> > +      object.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum:
> > +      - 0 # Top.
> > +      - 1 # Bottom.
> > +      - 2 # Left.
> > +      - 3 # Right.
> > +      - 4 # Front (aka as User Facing).
> > +      - 5 # Back (aka as World Facing).
> > +      - 6 # Unknown.
> > +
> >    "#address-cells":
> >      description: should be 1 for hub nodes with device nodes,
> >        should be 2 for device nodes with interface nodes.
> >
> > ---
> > base-commit: eefa7a9c069908412f8f5d15833901d1b46ae1b2
> > change-id: 20241212-usb-orientation-8e3717ebb02a
> >
> > Best regards,
> > --
> > Ricardo Ribalda <ribalda@chromium.org>
> >



-- 
Ricardo Ribalda

