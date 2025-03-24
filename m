Return-Path: <linux-kernel+bounces-573065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 008C9A6D28D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 01:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B290A1887D80
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 00:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0B78828;
	Mon, 24 Mar 2025 00:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5lHf+An"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF081362;
	Mon, 24 Mar 2025 00:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742775849; cv=none; b=MdJ1w16o1OXM6j7tDhG2NjqLQK95YuyRAhzEBk3tJFlmDm2EQpiwL78eZ6HQaz3DJUkbNraOfQ3wXyeGvRd8Uk/YGtsQEiyhavGJxudSEjKrBbbArl4/bzP6+BvZXEUu7V7iwmb1FzNI5lZhwzyz/COxLd4xRTv8t+v2OKOcqnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742775849; c=relaxed/simple;
	bh=hI0Yjbzs6zLvSplbv5YgbaejazIMfEpB7KzR2kvNQ+c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XL6+rMzQ56C3fH7Fvcegky8uTvC70+ylbcQEJwLtimqj1mHLGezPPFJeTMybLjp7b0lS0RNHD1rbF218Cfr8wtful3EH9dAU8LKlx5kE0/6y2fddR+lED3cqSFkM0uyINkbsB9kA2nsPrA3uwfow9xffYdnxaFGrpDs8Q46W/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5lHf+An; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22438c356c8so70145175ad.1;
        Sun, 23 Mar 2025 17:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742775847; x=1743380647; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZuewRliMwytzhOFFb8tPLcPDVcmBLEIXYNzwbH/t5w=;
        b=L5lHf+An5aOug9dt2EH2+DqOj5HzZEWhY2RGN/xC6xm1x0sw8lU4oT4HYvlKZww1oP
         a4SVURJqtVSvZUSeP0TjP1Z0dKz5yc77gMAqG3kibMQDFl6UZTQevEteZLRjcmnzpYaQ
         FtmM7kViNmqyqP7FxWBQkuFxX/XQe7DcYGxCDuDRYUxBo/An7CJzGplhuSwUJOrBbiDW
         f1NUNmgzA4vzQEM7tzkWj8fSYKG4vQ9YsOoX8iJ+stf280Le2KUo6F4DRpb/tJ4/KPNH
         KUJtI2gKPHVfszDAmQepzpE6+wcdhMZSQ2kcwcqVHueB0fMcrJxP58c4Mxheb7gl1ELr
         MM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742775847; x=1743380647;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EZuewRliMwytzhOFFb8tPLcPDVcmBLEIXYNzwbH/t5w=;
        b=SlUfdaj0ZAB6a84KiCjAc5py3lSHgRVOoXfy59UtfJMHStkfHovtrLWOgBpi7d62Ha
         LaJF9bfYDl4TsF0ir3qHDwEpsCd+CCVzYarXi4TtRCzG4SNbQbf67r/3722bSZop0sfZ
         kmdkpdcVtvIlTT+9AylP6Ajn04JmKXgZoJ8qIBLtiFesMYBn6rZFxjZZ3aiK+yS3FdJN
         vmq1ZUUnBmPL94go9d0HotEvtfhH2NLoFYLmFUNrTn6VlAOGWJCISEsR4qjbDRrHBUws
         BPN3HvYAQBOAr/PgLk72p80R56+tTrlH+yW8+MmYOxexS2WBo+BioYrHMZq7FcTShqqt
         jZ6A==
X-Forwarded-Encrypted: i=1; AJvYcCW6k3eiR9Tiba9NnVOqDm4qoIWHgmIFLi+RW4qtLIMwpWN4hXtawb1KDhh5/UD7rPYk8KCyQ+CSpuYxeJM=@vger.kernel.org, AJvYcCXjGP7gwNr4ScPQTcYno5BY3X298RDY+AlxRlr/bK4o6ZIsKFzXhIkDfPBjhCaJI+oWRX4+kyiQBK1fUSm5XSbfKlmQTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYnoxjaFmQ0eYXzjthYSsL0VAaHCQqSvgAbaIaUDFr2vk6sv/Q
	uSyqYt6leYTUTIc62Mh6DrKMCNAGEKsZZ5aaw3XrT4ZSIUmZhdBq
X-Gm-Gg: ASbGncujBlOugyH8lo8SfgOZGT0W3AGK7PFHg2Lr/CekQFwpWvVeYkM+xofon735D0F
	hY0W9NK+ok0c7wO5f8EgqO7qN5Nwsugc+US5H727hK9UlO/pTfu5VA605Tz+53LamtU+37Q4gq+
	hmSNNECaJTBm4PzosPqURBZuwX7wodJs0iYp1OkOOJhc75fMXgQGCPGlPkt1rN+Waek5Y1hnlsD
	U//xLyvoh4KZ9m9MQqvDqfWWA8N0HcedbOhp2v5WoCtKraoZBtBte8uiZ/lM8btnK2TUJs+Gixt
	/jMmAeuutdSXbkzl16FkuC2zwz6D83VxzEabVQ==
X-Google-Smtp-Source: AGHT+IHNeIVRasTMjXF1aK8atEskkkV+pJDfdlx1Bj/qZCzZicmDp11gnyYbJkHjfg9lwUZAuNGydQ==
X-Received: by 2002:a17:902:f64d:b0:223:47b4:aaf8 with SMTP id d9443c01a7336-22780e3f214mr156838985ad.52.1742775847460;
        Sun, 23 Mar 2025 17:24:07 -0700 (PDT)
Received: from localhost ([181.91.133.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811f44ebsm58128665ad.234.2025.03.23.17.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Mar 2025 17:24:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Mar 2025 21:24:03 -0300
Message-Id: <D8O2H5QEYWPA.15LUV2KUG8MKC@gmail.com>
Cc: <ibm-acpi-devel@lists.sourceforge.net>,
 <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Seyediman Seyedarab" <ImanDevel@gmail.com>, "Eduard Christian Dumitrescu"
 <eduard.c.dumitrescu@gmail.com>, "Vlastimil Holer"
 <vlastimil.holer@gmail.com>, "crok" <crok.bic@gmail.com>, "Alireza Elikahi"
 <scr0lll0ck1s4b0v3h0m3k3y@gmail.com>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: disable ACPI fan access
 for T495* and E560
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Seyediman Seyedarab" <imandevel@gmail.com>, <hmh@hmh.eng.br>,
 <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250323030119.17485-1-ImanDevel@gmail.com>
In-Reply-To: <20250323030119.17485-1-ImanDevel@gmail.com>

Hi Seyediman,

On Sun Mar 23, 2025 at 12:01 AM -03, Seyediman Seyedarab wrote:

Patches submitted on behalf of someone must begin with a From: tag.

> The bug was introduced in commit 57d0557dfa49 ("platform/x86:
> thinkpad_acpi: Add Thinkpad Edge E531 fan support") which adds a new
> fan control method via the FANG and FANW ACPI methods.
>
> T945, T495s, and E560 laptops have the FANG+FANW ACPI methods (therefore
> fang_handle and fanw_handle are not NULL) but they do not actually work,
> which results in the dreaded "No such device or address" error. Fan acces=
s
> and control is restored after forcing the legacy non-ACPI fan control
> method by setting both fang_handle and fanw_handle to NULL.
>
> The DSDT table code for the FANG+FANW methods doesn't seem to do anything
> special regarding the fan being secondary.
>
> This patch adds a quirk for T495, T495s, and E560 to make them avoid the
> FANG/FANW methods.
>
>
> Original-patch-by: Eduard Christian Dumitrescu <eduard.c.dumitrescu@gmail=
.com>

This tag is not required. Instead use Co-developed-by + Signed-off-by
tags, which are required.

> Co-authored-by: Seyediman Seyedarab <ImanDevel@gmail.com>

Move this tag just before your Signed-off-by and change it to
Co-developed-by.

> Reported-by: Vlastimil Holer <vlastimil.holer@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219643

This is missing a

Fixes: 57d0557dfa49 ("platform/x86: thinkpad_acpi: Add Thinkpad Edge E531 f=
an support")

As this is commit is already on stable, also add

Cc: stable@vger.kernel.org

> Tested-by: crok <crok.bic@gmail.com>
> Tested-by: Alireza Elikahi <scr0lll0ck1s4b0v3h0m3k3y@gmail.com>
> Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>

You can go through [1] for details, before re-submitting.

> ---
> The main patch was proposed on Bugzilla, but I couldn't reach the
> original author (Eduard Christian Dumitrescu) to help him fix it
> and resend it, so I submitted it on his behalf.
>
> Kindest Regards,
> Seyediman
>
>  drivers/platform/x86/thinkpad_acpi.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/=
thinkpad_acpi.c
> index d8df1405edfa..365cd7e452a4 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -8793,6 +8793,7 @@ static const struct attribute_group fan_driver_attr=
_group =3D {
>  #define TPACPI_FAN_NS		0x0010		/* For EC with non-Standard register addr=
esses */
>  #define TPACPI_FAN_DECRPM	0x0020		/* For ECFW's with RPM in register as =
decimal */
>  #define TPACPI_FAN_TPR		0x0040		/* Fan speed is in Ticks Per Revolution =
*/
> +#define TPACPI_FAN_NOACPI	0x0080		/* Don't use ACPI methods even if dete=
cted */
> =20
>  static const struct tpacpi_quirk fan_quirk_table[] __initconst =3D {
>  	TPACPI_QEC_IBM('1', 'Y', TPACPI_FAN_Q1),
> @@ -8823,6 +8824,9 @@ static const struct tpacpi_quirk fan_quirk_table[] =
__initconst =3D {
>  	TPACPI_Q_LNV3('N', '1', 'O', TPACPI_FAN_NOFAN),	/* X1 Tablet (2nd gen) =
*/
>  	TPACPI_Q_LNV3('R', '0', 'Q', TPACPI_FAN_DECRPM),/* L480 */
>  	TPACPI_Q_LNV('8', 'F', TPACPI_FAN_TPR),		/* ThinkPad x120e */
> +	TPACPI_Q_LNV3('R', '0', '0', TPACPI_FAN_NOACPI),/* E560 */
> +	TPACPI_Q_LNV3('R', '1', '2', TPACPI_FAN_NOACPI),/* T495 */
> +	TPACPI_Q_LNV3('R', '1', '3', TPACPI_FAN_NOACPI),/* T495s  */

nit: Please, remove the extra space inside the comment.

>  };
> =20
>  static int __init fan_init(struct ibm_init_struct *iibm)
> @@ -8874,6 +8878,16 @@ static int __init fan_init(struct ibm_init_struct =
*iibm)
>  		tp_features.fan_ctrl_status_undef =3D 1;
>  	}
> =20
> +	if (quirks & TPACPI_FAN_NOACPI) {
> +		/* E560, T495, T495s */
> +		pr_info("Ignoring buggy ACPI fan access method\n");
> +		gfan_handle =3D NULL;
> +		sfan_handle =3D NULL;
> +		fang_handle =3D NULL;
> +		fanw_handle =3D NULL;

IMO as this fixes a specific commit, only the handles added in that
commit should be nullified here, i.e. only fang and fanw. The others can
be added later if the need arises.

> +		fans_handle =3D NULL;
> +	}
> +
>  	if (gfan_handle) {
>  		/* 570, 600e/x, 770e, 770x */
>  		fan_status_access_mode =3D TPACPI_FAN_RD_ACPI_GFAN;

[1] https://docs.kernel.org/process/submitting-patches.html#when-to-use-ack=
ed-by-cc-and-co-developed-by

--=20
 ~ Kurt

