Return-Path: <linux-kernel+bounces-523807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 108E3A3DB7C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CACE53A7BFA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4445C1FA14B;
	Thu, 20 Feb 2025 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fQwd9XwM"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3158D1F942D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740058810; cv=none; b=HvwIMhivlgBD5teHGhdaICZyijhSpXm2aev2srCzj3wWEGO7A9Xs2XBNc0PMCTdUvgqrjssVtoz0sLHCC8mOIFza8zIvfTEDno1MK2OdZtn6jT0l3T9vdlt29Khgi0KLUR7LOVFLJCu7ZFp3o6Q00E7oU+TaQJCKO9/JqDnmPkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740058810; c=relaxed/simple;
	bh=YHiEwZjQAEX3AGU4xj8gssFAfSoCb1JqMeq59o4wcrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=huulqyjIZMj+3+Vbfe+4MSub3w+8qMRA8H8QFslYjN/PnqO428pcLmXeRH51De68Md+QCPy0W0Cy/LH8aUvt3w4Ei3EQBp4HB1ppMPQbQ3rqxIRisTb8zEHypcjUDuTMliDIj6blKHWP5G31wD9HifE+Lg98rtOyzANhCrNPXII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fQwd9XwM; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f441791e40so1448743a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740058808; x=1740663608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ML1/0H9YV2GOwGv9BI0hsA2CQR0qo+3F7StWZRVvACg=;
        b=fQwd9XwMqfCIIipFVA4Dm9eZYRqfXi7sPZ7dWCfKUCHVdgjDpAm8b44yu5RY4+8uEW
         QGWBoFSRG3hT+I66RagVvtX5m3sY43KfBq4fvfCpz+8S56/RKc8yW+C/SjgQgTFZzQ0K
         fWh6dcAyB9bTVzG6W8IdXB0sxYWh5PksE+b0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740058808; x=1740663608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ML1/0H9YV2GOwGv9BI0hsA2CQR0qo+3F7StWZRVvACg=;
        b=wwUq6b8S0tBFM8rdQHrbpmDXQMuMqQUdoaNAAturUaLLcJzepBlNRhZUncttKfbpk9
         gWbxmBcn+dhL9XF+qbzg+e20LUUc/X53HUutBAs+Cji8pg00ymIODWRrQaEQoYmyfZaW
         YYu7XiRTPXQ0u3n01lHgOrI+gBRrlPKQBBLXfVoQreGVzrFGxiSmA7OioQK5LCLbHsk5
         L8pvtMI4J+Sn3fbAU+txzGbSGQAK/tbDirZVjSFt8kQ1ujeDSl4HkaQmAT/huvuD6lQs
         9PNaTsPnQz3UsaeRxGTKt3IvqptF2FSycLP+dgRiKH+NnF5l1A2y+Ss8NqBdzp2PD+fW
         sJYg==
X-Forwarded-Encrypted: i=1; AJvYcCUIZWfOrK6IMRu0Zezyfp40p6smhUJ0oneZj8um5KayGbooQwLBTwYzUTfRveab/15gSSzqltaCtF2PYvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNfEdDHUNEoKE4iSM6QmJ+4VfnxIazNo1ArtsssJooLho6BIMc
	svI8CS/CNKLEAvpXZvqXshsfalXwmTlFep+NHpp3zO8368rXmbp2xhBR6C5EI35OCOwQqkgyAn+
	ifBlvDRfn8zD0XmCLItpf53et8LFdv90joPIV
X-Gm-Gg: ASbGncs/6ymSudYHbfxdmCubRUwIhMUuloL/v+aDnbq7Q4hU+yhkAGXiE/ZPDxetz6q
	gOpYT6aBQ6NIOOenBd31mRb9fQqUSmLUKoM9twFTBepqjrlIxqlDEytk39gudOrh776PFQOFEup
	4UJjgFPbgzPEYygmR1/GA65uY=
X-Google-Smtp-Source: AGHT+IEL5keA+PapFixcBrr6dT8RQR/4gBofNZ3DcuRjKbHdgZu0h93rSpNvZX8XRvTFUH8ttG3sMUe4HE8dka1DC4I=
X-Received: by 2002:a17:90b:1e09:b0:2fa:1451:2d56 with SMTP id
 98e67ed59e1d1-2fc41045074mr33941390a91.25.1740058808515; Thu, 20 Feb 2025
 05:40:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210130419.4110130-1-akuchynski@chromium.org> <Z7SYg8HaSVx9QyH9@tzungbi-laptop>
In-Reply-To: <Z7SYg8HaSVx9QyH9@tzungbi-laptop>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Thu, 20 Feb 2025 13:39:57 +0000
X-Gm-Features: AWEUYZldFkmbJpsZ2rH52bgIzXaIk8HNEGPbISy_CZuCvZhPJJ9k0ZHwzqAkiuE
Message-ID: <CAMMMRMfYWqGEJDmMaPQFjQFeUhWJ4wVp-xy2TTdAhp3gRv-n8g@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Add support for setting
 USB mode via sysfs
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Prashant Malani <pmalani@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, chrome-platform@lists.linux.dev, 
	Jameson Thies <jthies@google.com>, =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 2:26=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> On Mon, Feb 10, 2025 at 01:04:19PM +0000, Andrei Kuchynski wrote:
> > +static int cros_typec_enter_usb_mode(struct typec_port *tc_port, enum =
usb_mode mode)
> > +{
> > +     struct cros_typec_port *port =3D typec_get_drvdata(tc_port);
> > +     struct ec_params_typec_control req =3D {
> > +             .port =3D port->port_num,
> > +             .command =3D (mode =3D=3D USB_MODE_USB4) ?
> > +                     TYPEC_CONTROL_COMMAND_ENTER_MODE : TYPEC_CONTROL_=
COMMAND_EXIT_MODES,
> > +             .mode_to_enter =3D CROS_EC_ALTMODE_USB4
>
> The symbol `CROS_EC_ALTMODE_USB4` doesn't exist.  On a related note, woul=
dn't
> it always enter CROS_EC_ALTMODE_USB4 if the value is hard-coded here?
>

CROS_EC_ALTMODE_USB4 is defined in drivers/platform/chrome/cros_ec_typec.h.
TYPEC_CONTROL_COMMAND_ENTER_MODE command will be sent only if
mode =3D=3D USB_MODE_USB4 because EC currently only supports entering USB4 =
mode.
Otherwise, TYPEC_CONTROL_COMMAND_EXIT_MODES is sent, and the mode_to_enter
field is irrelevant for this command.

> > @@ -84,6 +102,13 @@ static int cros_typec_parse_port_props(struct typec=
_capability *cap,
> >               cap->prefer_role =3D ret;
> >       }
> >
> > +     if (fwnode_property_present(fwnode, "usb2-port"))
> > +             cap->usb_capability |=3D USB_CAPABILITY_USB2;
> > +     if (fwnode_property_present(fwnode, "usb3-port"))
> > +             cap->usb_capability |=3D USB_CAPABILITY_USB3;
> > +     if (fwnode_property_present(fwnode, "usb4-port"))
> > +             cap->usb_capability |=3D USB_CAPABILITY_USB4;
>
> Are these defined somewhere?  E.g. the bindings?

Unfortunately, property names are set in the ACPI firmware in the same way.

