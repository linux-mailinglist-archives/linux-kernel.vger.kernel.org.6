Return-Path: <linux-kernel+bounces-404418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 263719C4389
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D0F5B259CC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF781A727D;
	Mon, 11 Nov 2024 17:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YZmsLlt+"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21871A725A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 17:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345955; cv=none; b=DXZC6zlP9SNEp14lLgbcERfMivuC7m/cX6RI4+C62R0XG3yteo6KQuZmYn4PhgCOn3xy0Emma+M0xEG2Q6h3z2NTV98pshc1jWnNx+qaanar2Pr1VZbnuEqMnIAfa3TkMnmeLOUguINO1Iszp8k/OOBMFxWeatLPeCP0XsuNWoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345955; c=relaxed/simple;
	bh=ZTk11ZVemdflfr0virzfjHPwj/DySg68gOxo+IYI7+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HK+jG/iKB4inVGTkvpruBULwf/sEIxJfHcSDnhbWFiK4i0ctN8qWXYR048gS0BReyvz3nfIYXlhsoEmsGsv5CBZPMFIFWfX/ZoT4sMZnsU4BVoLyOrkxUcD3CJVNnnd0eUNYPbH8r/676CYFARN9RxfQHKcZrMf5YZiDVWv7amY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YZmsLlt+; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53a007743e7so5663144e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731345949; x=1731950749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jH1JjioDnQEXEHp1YxtApalVozz8jy8hPAeJoS9fBbM=;
        b=YZmsLlt+y7Rd0Omr+40zZ/HfxSdmp0NmvrfXBCqw62B7x5Va7ImQLM/xAqXjDKFADe
         3aYUcZtVg56gQ7lboA9dN1oU/LsqMNnPCjephIRAXq/pSISP6oTEwnzzhjG7C10sU7XZ
         vPAOOFagaSsKbSzmRmU1/JkdEVAFMqst0Sh+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731345949; x=1731950749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jH1JjioDnQEXEHp1YxtApalVozz8jy8hPAeJoS9fBbM=;
        b=MknQs7hf5guRmkYQ2VDTaV91psEaovmKGMlaCOVkuT7a540r3QVD/Kd1PqICEec+pR
         r60ehLViQI9F6y+7DpcYavxR4nXTMum1f1cpl2LbSPEccdKwK2pK1rdN2w4njsIlo6Uq
         pXebeR8Ib+2wXPwvE9pvp2Thn70VpVRBFxKaAGlLq6b27aQ6gi47WUwRmPP1Z/YGujsW
         QkX+CQmr54atzVmnhsOiewN+OpDewsTgej+TCKhqRcyaimw4S8Wa/V+OeZcwHYl3JDxO
         u05D9y7X/8pdTHG1ZSzvyxfgUrkKIP6gsqmfK7dWIDYveyytKGNFx0HDVl+bNSVKw4Bh
         08qg==
X-Forwarded-Encrypted: i=1; AJvYcCXgIoMEAE5Mi+r6SAQ9vbOg0iRr7aCbFRolEVyzDhTuloHWEOR9DvI3JvhWvgFrsUmf4z05siSQZa6oes4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc+5UO2Buq0VGx/Fc3X4Q+TPDbrvEN4VPv3d4b35ZiVlo/dpHP
	Cd8wvbH+LwDlJU3zb8ySXorZzCFIiy0ds6rXYN8zNEzaXydd0ygGEY2DTA57r9wCFntEa/w76oT
	wgA==
X-Google-Smtp-Source: AGHT+IGGfvtJLVBfh2McmeAp+NYZNpxJhPhdGH9he+pe0j1H//qk/dxUTMhZYtlPL0c98oOVEOKwGA==
X-Received: by 2002:a05:6512:acf:b0:539:adb0:b86 with SMTP id 2adb3069b0e04-53d862308eemr5745608e87.14.1731345949532;
        Mon, 11 Nov 2024 09:25:49 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826af020sm1621648e87.268.2024.11.11.09.25.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 09:25:48 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb3c3d5513so40979231fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:25:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0TF1eszSnhycGrz1FKU8OF2/JV3/uhCgGINQ7kG10LqcJxaz3oFVBGMqYdrsqain+cz/Tq42CHUjRyr4=@vger.kernel.org
X-Received: by 2002:a05:651c:1593:b0:2fb:60a0:f4e1 with SMTP id
 38308e7fff4ca-2ff201b29a7mr58237271fa.24.1731345947358; Mon, 11 Nov 2024
 09:25:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111075000.111509-1-charles.goodix@gmail.com> <20241111075000.111509-2-charles.goodix@gmail.com>
In-Reply-To: <20241111075000.111509-2-charles.goodix@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 11 Nov 2024 09:25:31 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UDGqVHxFLEh1e5BW5p1Db+WNjntuSqFjf5uSFLncJUvw@mail.gmail.com>
Message-ID: <CAD=FV=UDGqVHxFLEh1e5BW5p1Db+WNjntuSqFjf5uSFLncJUvw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: input: Goodix GT7986U SPI HID Touchscreen
To: Charles Wang <charles.goodix@gmail.com>
Cc: robh@kernel.org, krzk@kernel.org, hbarnor@chromium.org, 
	conor.dooley@microchip.com, dmitry.torokhov@gmail.com, jikos@kernel.org, 
	bentiss@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 10, 2024 at 11:50=E2=80=AFPM Charles Wang <charles.goodix@gmail=
.com> wrote:
>
> The Goodix GT7986U touch controller report touch data according to the
> HID protocol through the SPI bus. However, it is incompatible with
> Microsoft's HID-over-SPI protocol.
>
> NOTE: these bindings are distinct from the bindings used with the
> GT7986U when the chip is running I2C firmware. For some background,
> see discussion on the mailing lists in the thread:
>
> https://lore.kernel.org/r/20241018020815.3098263-2-charles.goodix@gmail.c=
om
>
> Signed-off-by: Charles Wang <charles.goodix@gmail.com>
> ---
>  .../bindings/input/goodix,gt7986u-spifw.yaml  | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)

As far as I can tell this looks fine now. Thanks!

Reviewed-by: Douglas Anderson <dianders@chromium.org>

