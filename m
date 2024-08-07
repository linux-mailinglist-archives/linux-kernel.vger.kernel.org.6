Return-Path: <linux-kernel+bounces-278557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D557894B1CD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E9F1C21A7E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58722149DFF;
	Wed,  7 Aug 2024 21:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnCv3NFf"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2878149C52;
	Wed,  7 Aug 2024 21:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065172; cv=none; b=OwQd/vmz83j1mLdt4YQ+zlRRxwN/1/mNP/isj7cyQ4eTihrL8lMmOCaOKzdANh2vsRLKM1/xV/muL6LcJgJnX4I+7jKz28zKrokfoRGVEu2ipl96tV68i7sJ6jgNneoDamPtzNix1pN7srvjrt9Woc9PhQl8llj3jhGueTC5bi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065172; c=relaxed/simple;
	bh=fUOuliGWnJ6pVRmXhqqcaSwhF9lPv6HxhyTKm2t9g8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKWd/IhuJBIomNUBQ7+o63f14fsncx6ClzyCH5RghCnPgLrSWWGDkMEVMKoTZC1/RhLROPpmbkYzpJ4lHqJkxPH5Vl/Sx9RXlsk6xIKDwK7fsuIxKmcK9DNp+BkbxxCUcDSVAge4CmvhfrI9gconhEazPH0OLYsgf4Y37M0WQMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnCv3NFf; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f040733086so2586641fa.1;
        Wed, 07 Aug 2024 14:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723065169; x=1723669969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/bmxju7ZLwzIAH8jlEDDreLMssuhznvKRpLl5JRJbc=;
        b=FnCv3NFfs0DF8N1KFnFkpRwxhDFhwGARV0P9SVRlUgUfdCNTGD4EN56rdzw1PW1uAi
         tMmwUbu4Jul+Cj0yGh+AdTd7x5GprSfhuJSbgnNwmYfQCa4lheayWQcqES+9sR3fs7qP
         IvdMp7iqU9ciPGdAOtOXINhxmbC4ObNrnbhYtPs6GLOAUryQ8w5l/TZNhcXv0HNOwC2r
         AsJeT/BCCWZ8ubYlUzhoeP/dlqJFqkx2fP9p8IvCY6Af7ZxAk5w0kbGyGu+d+12+V+RY
         oCJE5m28VjPgr7UFRu/KKRC7O8WUw+YL2gvGaC340APgvmtZceNmPrQGg3HXif5Vfn27
         JXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723065169; x=1723669969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/bmxju7ZLwzIAH8jlEDDreLMssuhznvKRpLl5JRJbc=;
        b=us0fffcDL87LrZvqNf9l0aqA9ziLRGRjyl3eaIwgolqLtQZPBN26rMLUFAXJRxte6a
         xnrA8AZFmKSrY5wrgvLmaZ0gxbKHF9pPqaVVunUDqyi2qqfZiWkEPmseQF5hWypg1CoJ
         qA07w37iLRjY/Rg0tl0a7oc+FN+fYBmrWC4lXB3WBZAIYN3LYTdZoKiCy19Ji3uf0VF9
         0EjGEZ0dv3bmLZs6PKzvIrgd1xNDhm5zjnytLdNYHI0+FTdGswSXhRgMS/Yta4lptNtS
         fjAf1wD0GNL6w7MQpb9kX8D294N4beDPGjMXJcC7YWUK1FhbdwhrzZzDaE67+jUG31mW
         jjIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnsizGtSHWDmNmWXl4jSoyX/oANT8IPsM6v4dAGJ9EDjgfXGxElVLzNBGgnvvNnnVudhhUpX5wXDu7@vger.kernel.org, AJvYcCWHU+65wsLsUerijXtPYRf0CMjQqQ94BONuiQ1yVg6DHEVeoYKUmgHpsWlr5bPQGIlqtcmEKwGfsL+zPn8y@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx7LjIfz+qHP/bK2Xh+fE7WygetKHOGr49szmb48KnTKqYQLlB
	d0kqWOE6D8cXkzvdWzBT0SZTJx2rrC1SLrDFPCyTx7F+a/tCkF+q
X-Google-Smtp-Source: AGHT+IHY8G93+4dqsOW2PvS20aHLKtl2r2rEMnKjeoACncKdu2CAA+R9R8DzuDfiVZbRYFJwm7/qJg==
X-Received: by 2002:a2e:3002:0:b0:2f0:2833:efaa with SMTP id 38308e7fff4ca-2f15aac3960mr127650011fa.25.1723065168562;
        Wed, 07 Aug 2024 14:12:48 -0700 (PDT)
Received: from latitude-fedora.localnet ([31.173.83.209])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e1adf63sm19884571fa.40.2024.08.07.14.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 14:12:47 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
To: Florian Klink <flokli@flokli.de>, linux-rockchip@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Muhammed Efe Cetin <efectn@protonmail.com>, FUKAUMI Naoki <naoki@radxa.com>,
 =?utf-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@protonmail.ch>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Dragan Simic <dsimic@manjaro.org>
Subject:
 Re: [PATCH v2] arm64: dts: rockchip: add rfkill node for M.2 E wifi on
 orangepi-5-plus
Date: Thu, 08 Aug 2024 00:12:46 +0300
Message-ID: <4888470.OV4Wx5bFTl@latitude-fedora>
In-Reply-To: <1b2e1b1b321f84f5cbff2ae18c3eba2e@manjaro.org>
References:
 <20240807162001.1737829-1-flokli@flokli.de>
 <krvprzy3iz5b7n37eo2mb6sol6pcjkxsjdbdi6sxeebwveqtnr@e52cvrlkdjsa>
 <1b2e1b1b321f84f5cbff2ae18c3eba2e@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Wednesday, August 7, 2024 9:32:51=E2=80=AFPM GMT+3 Dragan Simic wrote:
> On 2024-08-07 20:14, Florian Klink wrote:
> > On Wed, Aug 07, 2024 at 07:24:27PM GMT, Dragan Simic wrote:
> >> On 2024-08-07 19:00, Florian Klink wrote:
> >>> This follows the same logic as 82d40b141a4c ("arm64: dts: rockchip:
> >>> add
> >>> rfkill node for M.2 Key E WiFi on rock-5b").
> >>>=20
> >>> On the orangepi-5-plus, there's also a GPIO pin connecting the WiFi
> >>> enable signal inside the M.2 Key E slot.
> >>>=20
> >>> The exact GPIO PIN can be validated in the Armbian rk-5.10-rkr4
> >>> kernel
> >>> rk3588-orangepi-5-plus.dtsi file [1], which contains a `wifi_disable`
> >>> node referencing RK_PC4 on &gpio0.
> >>>=20
> >>> Signed-off-by: Florian Klink <flokli@flokli.de>
> >>> Tested-by: Florian Klink <flokli@flokli.de>
> >>=20
> >> I forgot to mention that providing a Tested-by tag is redundant when
> >> there's already a Signed-off-by tag, because the latter already
> >> implies
> >> the former.
> >=20
> > This came after I sent the v3. Generally I wish people would test
> > things
> > - though too often it's not. I explicitly tested this to work (with a
> > wifi module added to that slot being unblock-able afterwards), and
> > wanted to point that out, thus adding the Tested-by.
>=20
> In general, some time should be allowed between sending consecutive
> versions of the same patch, so people can provide their feedback.
>=20
> When it comes to testing the submitted patches, please note that signing
> off a patch implies that the signer has already, to the best of their
> abilities, made sure that the patch works as described and expected.
>=20
> With all that in mind, please allow me to repeat that a Tested-by tag
> should not be provided from the same person that the Signed-off-by tag
> is already coming from.  It's simply redundant.

Just two cents: perhaps dropping the tag and expanding the commit message a=
=20
bit could be the best of both worlds. Just state that you tested it with su=
ch=20
and such module, observing such and such results. That would also help if f=
or=20
example another user tries a different module and that fails due to some=20
quirks: it's easier to debug a potential issue when one knows a working=20
configuration to compare a non-working one against.

Best regards,
Alexey



