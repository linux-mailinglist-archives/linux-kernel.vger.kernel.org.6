Return-Path: <linux-kernel+bounces-401855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0667E9C2027
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32DA91C23AD4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B55B1F4FC8;
	Fri,  8 Nov 2024 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fOcN++J+"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B256D1F584B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731078856; cv=none; b=u1YJpb6k8PBg8LZfFg8wFAMMU792Z5Rp9ScC5EK9eyTzh8S4ECMHRdPMKKBNt988XiN3hWDp0W7QbR0sP0Z+hHBC+IShqbZqd6aTql6RowpE7+V2xzz1iDHnHavHY6/Bo60l7Etfj8SqKki7i3E4h2ArQsHsglNboVbYghs+TX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731078856; c=relaxed/simple;
	bh=smY4h117cYR692sX/32C1fiEi9e/UhXm2F3tRfVz2OE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYeLaEOCLglNR7YrS4QUdBQ03N7xnUVStwHKAcaW22p96QMZjR5RjvTx/t9oiApw7bogvgWsGqSI6JDG4rkzvb0Q4olhAyQiW7UdcWGe5j1Znva8/aJG2/iwm+smuxiX0XTmu1RmkcGh2UVezlq6J9eXSQ/8vlLRnrb4K3xFi8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fOcN++J+; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so3384604e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 07:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731078852; x=1731683652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbptqwjZLNdVS9qjZW7J9pwzy8My758ZGi0V06mo61U=;
        b=fOcN++J+O7rjb3qWqdUYU1GVX1fvlvvH/RwQoiwYjTctSUUmMh2B9E6vvYXaSyemZv
         3TrE1UYjWuLziIkJT7VUKhulnGTV1BoONOKh4PNtqbMb40nq/fXSbBK6xQ9olxwdG/no
         c4v13hYm0MTzbajmZYaL+20Tk7z0/YXKve4EQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731078852; x=1731683652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbptqwjZLNdVS9qjZW7J9pwzy8My758ZGi0V06mo61U=;
        b=VyRS8R7C0xJmin8QWfx8g55IL327v0apkxRbycRYGgQY+pQfVgV6JC5+D10dFnoKMf
         PVMEb23VI+2vSUzmUeUU/HuEWJz8gZ7aLbJ4B6mx+pb/yZQm1OllzvDx6p0NVcQUEaob
         yBhuDk+cQdEJo6kmA7/NWDLa/ktiXksCBuZvK0Yk0VUNnRN2HJGkX0wtbOhwaSrNkOte
         XZ8PhO15n2yCfZTbg6V663++6ROcJHjPzZL8Tlfyl4wQHXVJjKrZkfbCvb3zupaf/7LB
         2vCBkSDFbLal7JpXIsITCO0mmlPLf1f+ddJXD8dmM4E+HEQqkQKTFz4/jBs1QBkFU1IA
         kt/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsKG/CGVn9DCQVXZsHBKAoK8KGIqbBVxB0oMg1rkmUSTPDjs9KBdb2gurY7ltgMUrmgBVoVvpHDklUxYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6pdGeIN1HL4DxRkSBbOTWPl7TcoxinuXZVGq0nmZVlvve71RL
	Y//vvAwveBtSOeP2mtm+tPaKPIOeUuSH+ibWt4o4CWDRoB7Zav2CyTqZwua4S7yKupLXyQv+XWj
	weA==
X-Google-Smtp-Source: AGHT+IFC42wMfsem9KHUFygrRMvQg3nSz4RAy6DuuucLsuScUkGNlhvxqWxCcWk+9glxmKZBPLhK2w==
X-Received: by 2002:a05:6512:318c:b0:539:e23a:9eaa with SMTP id 2adb3069b0e04-53d862f34d5mr1796053e87.50.1731078851956;
        Fri, 08 Nov 2024 07:14:11 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826aefb1sm646777e87.237.2024.11.08.07.14.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 07:14:11 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f84907caso2403214e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 07:14:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdyNAz5Gs0CvICimSEAkGgpXjTdn2F795WVywdvPDHRug1djuD16Lj0/cHoOpkqugmBxnaHX1dLdReP+I=@vger.kernel.org
X-Received: by 2002:ac2:4c4a:0:b0:539:e97c:cb10 with SMTP id
 2adb3069b0e04-53d862ebfc3mr1963420e87.40.1731078850184; Fri, 08 Nov 2024
 07:14:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108120311.87795-1-charles.goodix@gmail.com>
 <20241108120311.87795-2-charles.goodix@gmail.com> <173107281349.1752060.15353696141928017835.robh@kernel.org>
In-Reply-To: <173107281349.1752060.15353696141928017835.robh@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 8 Nov 2024 07:13:53 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Uc0PZZp-rupazy9tGfZMssGET=904cdUJXbhS=fMCUvg@mail.gmail.com>
Message-ID: <CAD=FV=Uc0PZZp-rupazy9tGfZMssGET=904cdUJXbhS=fMCUvg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: input: Goodix GT7986U SPI HID Touchscreen
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Charles Wang <charles.goodix@gmail.com>, conor.dooley@microchip.com, 
	linux-input@vger.kernel.org, bentiss@kernel.org, linux-kernel@vger.kernel.org, 
	dmitry.torokhov@gmail.com, hbarnor@chromium.org, devicetree@vger.kernel.org, 
	jikos@kernel.org, krzk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 8, 2024 at 5:33=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
>
> On Fri, 08 Nov 2024 20:03:10 +0800, Charles Wang wrote:
> > The Goodix GT7986U touch controller report touch data according to the
> > HID protocol through the SPI bus. However, it is incompatible with
> > Microsoft's HID-over-SPI protocol.
> >
> > NOTE: these bindings are distinct from the bindings used with the
> > GT7986U when the chip is running I2C firmware. For some background,
> > see discussion on the mailing lists in the thread:
> >
> > https://lore.kernel.org/r/20241018020815.3098263-2-charles.goodix@gmail=
.com
> >
> > Signed-off-by: Charles Wang <charles.goodix@gmail.com>
> > ---
> >  .../bindings/input/goodix,gt7986u-spifw.yaml  | 75 +++++++++++++++++++
> >  1 file changed, 75 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/goodix,gt79=
86u-spifw.yaml
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/input/goodix,gt7986u-spifw.yaml:16:7:=
 [error] syntax error: mapping values are not allowed here (syntax)

FWIW, I think it's objecting to the "NOTE: " in the description
looking like yaml. Maybe just change it to "Note that". It's also a
good idea to get yourself setup to validate your bindings _before_
posting them to the list.

-Doug

