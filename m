Return-Path: <linux-kernel+bounces-175975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BC98C2818
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3A58B263C1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C661171658;
	Fri, 10 May 2024 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U3Fg7Cp3"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416EB171657
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715355865; cv=none; b=h7OeybKhjaMW0O6BshR9LMmI4qu3vPctbf/490ZPSUq+aXnBpuivykSXyVNPRXeLgnsV3Uo1I4Y0yQHEbMxiMQ/NV8Jtj/IFaIEq4HrzE43kzqJ8c4oQWT2TuvUpCd22lQ8/Z6pG3+r4YUM4OzrU8EbBqwdUC0bIJosHOkHqdoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715355865; c=relaxed/simple;
	bh=PSbCck90XzR29/LcPaIDYs4i+apiq99iORTmH6bbfXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRL85RLBqDL9M8UTCVIfkv6KJm8+qrdkCYc8YR7wCYFtfM5VZyArAfFWpHuEGZMrm5TWtcWl2seee6DHPUk5sr9z7ijSI6Uvpw6i/Fz1zx+DLFJm/QdyubNUU1dm0CszkgoyrtS3kg+AiZ1yzWlbdRFcuudJAb3BAFPkytt0LJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U3Fg7Cp3; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-47f03844ea3so786735137.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715355863; x=1715960663; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dWpeN9v4LQPHTvNkYUfPGosFaeM74t16OD1N/lIzMnI=;
        b=U3Fg7Cp3tizK/cFVxa1OK70Y9i4pbogfLzzi5/jbq6rzgj1kFe8AB86kfBpA9l8Ppb
         keBDwI/mxu+pzFSeegcmDKeMeQ9xsIPjZrJ2Rs9U28lwCBwRmmkwjXdJofDzKqXZB96G
         UCICInTzwHvA8Gb55meNU+5E2cdtBoioIup1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715355863; x=1715960663;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dWpeN9v4LQPHTvNkYUfPGosFaeM74t16OD1N/lIzMnI=;
        b=bPP8Vewd6lqUYleSrTCcu+fIAOTJrWSG5zyT+jJ0JYOsIBxYyYzXxD1/1A42K8NfGc
         4P196+EvMJeritqRSqCWKmZvd5/VVykQsfpsba2SnKO0yk6oTstBKhZGVfneuEpzBPUt
         rCPiG1YC/BwceDuBuYESi5iBinjyvKq2c8EAQt/0DkwpAWDm7ZwBL3y+tsyfslmAc54T
         0FxiTmGeYc1YIsLw8KYdEBwIuoW1fnqNNSFuuN6NXE05N/g1fRH+/T1Okqtv7saHgfhd
         ELmUw/aIghnKhhIu2LCfYP3/GyJoYVMMzE6h7BSS0MiF5EQBq1CXem4Bx95P1RMZvyU3
         aqvA==
X-Forwarded-Encrypted: i=1; AJvYcCUQVgvGBAfz6VC31d+ZtxriUBKkNL75JQJto58GJFTH9tU6cEs7vcrBtf/argRxXzrFOQeGYkoeFmnfgdhk13EWh8eVPxR2yp95YDB3
X-Gm-Message-State: AOJu0YyNlcYBNj6eixNHZDsBXL+F6G/37ndszi6k3cJ1YpxSPkMLURz+
	/n5/jO4/hHxiWFzrK0+9tJRCeqTMPjU8qnupJpt+EUOta5QgUuEmwpzXZip2bGtRZI5UPz3LATZ
	xBwFVLPKswyNj2rDIjwgpIa4TYlXzffBEIK54
X-Google-Smtp-Source: AGHT+IHIRkQDh6WbpwsnpPK0f2E4zk9nbL9fTthvlONSIHmEejGLzQVUv1amXe+iXYRJDNvBaOujXUQa+qBW0+AVN0o=
X-Received: by 2002:a05:6102:1610:b0:47f:1ad0:2b12 with SMTP id
 ada2fe7eead31-48077e4426emr3624858137.22.1715355863240; Fri, 10 May 2024
 08:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419044945.GR112498@black.fi.intel.com> <CA+Y6NJEpWpfPqHO6=Z1XFCXZDUq1+g6EFryB+Urq1=h0PhT+fg@mail.gmail.com>
 <7d68a112-0f48-46bf-9f6d-d99b88828761@amd.com> <20240423053312.GY112498@black.fi.intel.com>
 <7197b2ce-f815-48a1-a78e-9e139de796b7@amd.com> <20240424085608.GE112498@black.fi.intel.com>
 <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com>
 <Zi0VLrvUWH6P1_or@wunner.de> <CA+Y6NJE8hA+wt+auW1wJBWA6EGMc6CGpmdExr3475E_Yys-Zdw@mail.gmail.com>
 <ZjsKPSgV39SF0gdX@wunner.de> <20240510052616.GC4162345@black.fi.intel.com>
In-Reply-To: <20240510052616.GC4162345@black.fi.intel.com>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Fri, 10 May 2024 11:44:12 -0400
Message-ID: <CA+Y6NJF2Ex6Rwxw0a5V1aMY2OH4=MP5KTtat9x9Ge7y-JBdapw@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Mario Limonciello <mario.limonciello@amd.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"

Thank you Lukas and Mika!
This is very useful and helpful!
I am setting up two alternative builds with both of your suggested
approaches and will test on devices once I get back into the office,
hopefully around next week.

> +       /*
> +        * Any integrated Thunderbolt 3/4 PCIe root ports from Intel
> +        * before Alder Lake do not have the above device property so we
> +        * use their PCI IDs instead. All these are tunneled. This list
> +        * is not expected to grow.
> +        */
> +       if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
> +               switch (pdev->device) {
> +               /* Ice Lake Thunderbolt 3 PCIe Root Ports */
> +               case 0x8a1d:
> +               case 0x8a1f:
> +               case 0x8a21:
> +               case 0x8a23:
> +               /* Tiger Lake-LP Thunderbolt 4 PCIe Root Ports */
> +               case 0x9a23:
> +               case 0x9a25:
> +               case 0x9a27:
> +               case 0x9a29:
> +               /* Tiger Lake-H Thunderbolt 4 PCIe Root Ports */
> +               case 0x9a2b:
> +               case 0x9a2d:
> +               case 0x9a2f:
> +               case 0x9a31:
> +                       return true;
> +               }
> +       }
> +

Something I noticed is that the list of root ports you have there does
not include [8086:02b4] or [8086:9db4], the  Comet Lake and
Whiskey/Cannon Point root ports that I saw on the laptops I tested on.
Those laptops do not have the usb4-host-interface property. This makes
me think that the patch won't work as is.

Then I queried for up all the root ports on all of our devices that
are confirmed to be affected by this bug. Here they are as a
reference:
Cannon Point (6 devices in our lab with different combos of these root ports)
9db8 #1
9dbc #5
9dbe: #7
9dbf #8
9db0 #9
9db4 #13

Comet Lake (7 devices in our lab with different combos of these root ports)
02b8 #1
02bc #5
02b0 #9
06b0 #9 (one device had this variation of #9)
02b4 #13

Tiger Lake (1 device in our lab)
a0bf #8 (the root port's device id is different from all the ones on your list)

After first trying your fix as-is, I can vary the list to add all
these root port devices to see if that has an effect. It seems like
this list might have to be longer than it currently is though.

