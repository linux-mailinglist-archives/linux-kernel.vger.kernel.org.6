Return-Path: <linux-kernel+bounces-345715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD5D98BA24
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95671C233C4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1D71BE221;
	Tue,  1 Oct 2024 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="LeyaX072"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E129A1BD514
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727780078; cv=none; b=uGOxUBF+bL7rxga26vPMObJUqaR4QF6Mr6AAOlr/F5rTBvwO/i5jB0UwpnolIW6jBKvTG8x89d9KWt5IitxRSt7FapcdUzuOMxb4Mqay3EmnYSgoV4GnBKS8mEnyZJZrr85VXlJuR2uwKf4sWOuf3d9t3XSOKah7TI5f82fBDkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727780078; c=relaxed/simple;
	bh=KAhqO5BJmYLN3Pdw2X6KaKyyCWQEvISE60APhrDdUHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ud8HfANBAf8NbWrOUgA8xEdmbeI6+F+xD2CYSTI8LxXlxoXZSbYS2++YZ7WI+L0anmttyUXHtCRrSetiF4CnFGZS6zVqyqK4oroYzxCp5i+UPAltYP5RYi7yHqmM6wAEcMss+reR4JIPxiYTakVmiY0yno0PW0tvqgEfl4pNYhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=LeyaX072; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e25cb262769so4717425276.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 03:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1727780076; x=1728384876; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HJVTEZA0F9slRMs734ykkG2JzVDg00Afe49QeNoa8W8=;
        b=LeyaX072xh3WgO7zgJnFBXrMt/CXvv6L9aMD8ILJI4HXlcPNMA9HfarYnMUXk3zk1B
         x/qFSBzB8qTwsLyY0F9xaNc2DhefA2avZ0cA2Ov7WmFxosi5xOaUU7jNr5V551XZpZI8
         +JxD1XKI5vfXef0ArnNi6RmmO28p0lzVdQa/w3KbODFoHEZ0l7B6ZN8KwWt9W8gc2pDc
         3j3e+ahVU4Fi8g+b2nerVcjDbMXCUdsl02lpbQSSt5iJPslrWLj0FDNXrfjNKEN1euft
         UEWbkXjtIzZTatbR2V58Lfz7pARZUxB3KEfpdDEhO0Y0znWLoyA4DrdmYK07Pp29ykAa
         vIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727780076; x=1728384876;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJVTEZA0F9slRMs734ykkG2JzVDg00Afe49QeNoa8W8=;
        b=UqsUR2EL0g2N5NHqhhGuvrm2TyjlvQP9ylIrKAXT4+igF9iyMkzH1bYjU2vnXiQfMV
         c6BG1/n99iQ6l3521bun7VNCdtnbu1dGFGfdaLH7Yvd7IBKIYIvr0A+8YbuVu25JKV01
         Lk3HyzmLDG44fkGq2u8Xops9zWRmVRU2tuTGyIINO157WnGa8Gm/avwMxHfgWJLkv0sM
         KPMgbNk7EfNY9Um93ixDX13W5onQxehGtNd+//QSN89xE8FwfSUDnE0KfP/tyte2ZJyb
         V/q4TNY9jOQE1CYLVg/0Oqo9ikaApR07Z9MiGkViZL+YQYWD/zZz44xbccWzZpXVVR0j
         wBvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9UcDwGCLX9KzrV3Y+AG79/DYqnTcZfNdgAQj79KcwVbBW9rb3RyGleWWn7m8DNGFpP8p/6dW4XGTqA6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBOa8p+bJymvabkEXSB3cRndrwVy3WnZsD6XwnUqgg6mIHPple
	YIZlvS0LT/eBoHgUdbmPF62qKR04BOU56ydKqJz3SLVXwFVwAxs9Vob6fyRdBCl+eLYQr/vuOJ8
	FomhQRLnIP+3Tsq+yF8hE7Yn7ZWqHmYfjov7gKg==
X-Google-Smtp-Source: AGHT+IGGam+COCYGUu+zG6oZ5j7GiUe97jMLKD14U0AGW3C1PjuQ7CcyBIb9p3B85I+Rkh1gHWNflMhT2EtigC/A1uc=
X-Received: by 2002:a05:6902:983:b0:e22:60b0:7a73 with SMTP id
 3f1490d57ef6-e2604b75ba1mr10997106276.44.1727780075728; Tue, 01 Oct 2024
 03:54:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZvQ27pvrnEYA8BB9@Emma> <3e296eed-5dbc-4098-ac3c-3c3125a352d8@gmx.net>
 <6723d91c-ac15-436e-878c-2d6fc1aac5e2@broadcom.com> <916d584f-6a9d-4eec-b6c4-319cfb298675@gmx.net>
In-Reply-To: <916d584f-6a9d-4eec-b6c4-319cfb298675@gmx.net>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 1 Oct 2024 11:54:19 +0100
Message-ID: <CAPY8ntDVEuyPE6ftYaP0B46ToC1v1AAXiO-h8KpoScB=gXkUyA@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: broadcom: Add missing required fields
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, 
	Karan Sanghavi <karansanghvi98@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, kernel-list@raspberrypi.com, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Anup <anupnewsmail@gmail.com>, 
	Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"

Hi Stefan and Florian

On Mon, 30 Sept 2024 at 19:36, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> Hi Florian,
>
> Am 25.09.24 um 22:38 schrieb Florian Fainelli:
> > On 9/25/24 09:39, Stefan Wahren wrote:
> >> Hi Karan,
> >>
> >> Am 25.09.24 um 18:14 schrieb Karan Sanghavi:
> >>> Added below mentioned required fields
> >>>    1. interrupt-controller
> >>>    2. #interrupt-cells
> >>> in the bcm2711.dtsi file for the
> >>> interrupt-controller@40000000 block as defined in the
> >>> bindings/interrupt-controller/brcm,bcm2836-l1-intc.yaml.
> >>> This issue was noticed while compiling the dtb file
> >>> for broadcom/bcm2711-rpi-4-b.dts file.
> >>> After including the above fields in the dtsi file
> >>> interrupt-conntroller error was resolved.
> >> looks like you made the same mistake like me [1]. This change breaks
> >> boot of Raspberry Pi 4 [2].
> >>
> >> There are a lot of DT schema warnings to fix, but this doesn't belong to
> >> the trivial ones.
> >
> > Including the #interrupt-cells would not have a functional impact
> > however, and we ought to be able to do that.
> >
> > The 'interrupt-controller' property presence means that the controller
> > will be picked up by of_irq_init() and that is was causes problems for
> > people testing this. Stefan, do you know if the VPU firmware
> > removes/inserts that property to tell Linux which interrupt controller
> > (bcm2836-l1-intc or ARM GIC) to use or does it make use of the
> > "status" property which would be the canonical way about doing that?
> There is a config.txt parameter for this, which is called "enable_gic".
> But if i use this i couldn't see any difference to /proc/device-tree.
> Also i couldn't see any modifications by the firmware to the node in
> general:
>
> interrupt-controller@40000000 {
>          compatible = "brcm,bcm2836-l1-intc";
>          reg = <0x40000000 0x100>;
>          phandle = <0x8e>;
> };
>
> Except of this i don't have any clue about the VPU firmware.

cc Phil so he can correct me if I get this wrong.

The firmware looks at the DTB and automatically sets the enable_gic
property if DT /interrupt-parent points at a node with compatible
string "arm,gic-400". It doesn't modify DT around the interrupt
controller nodes.

Manually setting enable_gic should only be necessary on a system which
isn't using DT where they wish to control whether to use the GIC or
bcm2836-l1-intc.

  Dave

