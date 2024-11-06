Return-Path: <linux-kernel+bounces-399033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9B69BF9DE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 00:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B369282076
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B226E20D505;
	Wed,  6 Nov 2024 23:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmVUMFjj"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE95201110;
	Wed,  6 Nov 2024 23:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730935256; cv=none; b=phh1CWuJWRBsJqdjhm6xXJcZ//ALsF8dhKt48qf7CPGLZJan3tB+Qj2wVFfXtd36MrjEStwuNzgV6Jwyx80/oTCa4GGmWBAfc9JZtFw6Yp7u+ct4DlCSQ87BR16VhHPMqFKs82rVONaLlNVMN3xAoS9alwG1R9kczZLrShak3KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730935256; c=relaxed/simple;
	bh=QYFVfPVttD6bKYWbid/Cc+HJWPnXtf/0yYKtU24Vvh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ot2CeuzKxyUjjAhfMODMNkF8GOpFk17BtVD8h9cxHeIGgFKRka8Vv3mbkdV6ex3Q6T6ooOHDaDlxPnSjeVntsXavdurW0xgjpdq/IdO00s65rEETe57KCkBbzO33Jmo7OWgtkTAbzC6XKAmcl3jOU1XQEmVKPtmUBojoKcRevEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmVUMFjj; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2b549799eso286484a91.3;
        Wed, 06 Nov 2024 15:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730935254; x=1731540054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=204I192wZq57uv/twISUsqu7G8IXzQ6X9WInp1dTzqI=;
        b=DmVUMFjjcDcgYNrxMG+Rrzd2jfm1XH2jiAgXe9Rgvdhrg4IiM5UUDqu66kLcqOwVYZ
         ItaJvTXAanxnSuD9ODPqrVolJ2p124FFd5qIpVKbt0FIXBOEMfvnM2cPFnRtiO/QCvFa
         /J/VlOQW1QNlz9cbmmVD1EkDygCeoWgjGuaKVqwaPB9BybQw1Y3k+DjIhrSIPyGyYz7t
         lnHdVpkAt0AAbl6WDHvT32/ivS9sG7nY2qJj4DVb+WHJCsnAuSFMJFjL0bVmmhvXVywV
         GRFgRzLoJ9zc36ZdsHEgSjA4DqOWLSb8946Me4MFnLk2k8/N4uCFnUdmuGRKqYmHNAVt
         d2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730935254; x=1731540054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=204I192wZq57uv/twISUsqu7G8IXzQ6X9WInp1dTzqI=;
        b=cgFe8IsuAtsNq+VrZgXZCFjjrbs6p555lgab4uwDBrRUqteJzuwyjoMIjRLFr45mvc
         3egTxQO6xVobCHpJUIWsxsDChpHL7wrLyPTTKl3EIcfcIYWGTJ3+8ODV8ofllzEHw71X
         6f9w4TgHNhUFILUiIUdtGeHz2U+WTeRPbVRnVSZHzV6prMRI0kqXwdcPF8rheb6QAvOX
         p/1OOPaJrNHzMKPjowUaCYv0rCwK58Dp00uhLGifRc+7MpEUsNQEc8UpJ0hYaHgmbbvO
         KBaaFeq7PTMsdY42dKvxFgEdZDzEy0le8oGJ8FrrVnRcyUN29MZa8jChWtg7FTOS5yxe
         ootg==
X-Forwarded-Encrypted: i=1; AJvYcCUSc8HjGUsXf4ejs7n54Lx99revhDGoB3N97c4LnDl7KQqqMdq4ud8W0t82JtZGqntIXzjAPp0X6c+x4tU=@vger.kernel.org, AJvYcCXtXcupZjBzyoqBSA6xaB5klA4ojL+r8PPwL/w47nyftMzBFCbuJeDGe4IZljQ2E7x+vs8FmfvJ0spRPT7DL8PSg7q1Kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmJZL0YNun8pjndQYMxXvAduusBqLzevNlvHZ/15nZTWp6b+wl
	AsZgdGoImIj6++GjaPXEX7Nk63eEQWvLNc8zBp5yoaEVvzAKVJe4f6N5dAFeS/Ylnpjz1pb/YuE
	g1glMg7P/7EbyVbWYr8dgO1mZzIs=
X-Google-Smtp-Source: AGHT+IHAG8gKLSuZQfbAvvV3qyphofMRiOQ8lRzggSaM5XMmTSeYZMvPa8rkRpndDbwCuNCRzXjDuskhRcs63GCtkok=
X-Received: by 2002:a17:90b:1c85:b0:2e2:9e64:c481 with SMTP id
 98e67ed59e1d1-2e94c2e2caamr30858391a91.22.1730935253822; Wed, 06 Nov 2024
 15:20:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105235505.8493-1-vishnuocv@gmail.com> <f3a50d1a-aa0c-4cf5-9138-a1da4ebdc671@redhat.com>
In-Reply-To: <f3a50d1a-aa0c-4cf5-9138-a1da4ebdc671@redhat.com>
From: Vishnu Sankar <vishnuocv@gmail.com>
Date: Thu, 7 Nov 2024 08:20:16 +0900
Message-ID: <CABxCQKsR=uyxAHnk0S10i8bXQ_5aivQj61s06BKFCOhu7uggLA@mail.gmail.com>
Subject: Re: [PATCH] Thinkpad_acpi: Fix for ThinkPad's with ECFW showing
 incorrect fan speed
To: Hans de Goede <hdegoede@redhat.com>
Cc: ilpo.jarvinen@linux.intel.com, ibm-acpi-devel@lists.sourceforge.net, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vishnu Sankar <vsankar@lenovo.com>, Mark Pearson <mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks a lot for accepting this!

On Wed, Nov 6, 2024 at 9:02=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> Hi,
>
> On 6-Nov-24 12:55 AM, Vishnu Sankar wrote:
> > Fix for Thinkpad's with ECFW showing incorrect fan speed.
> > Some models use decimal instead of hexadecimal for the fan speed stored
> > in the EC registers.
> > for eg: the rpm register will have 0x4200 instead of 0x1068.
> > Here the actual RPM is "4200" in decimal.
> >
> > A quirk added to handle this.
>
> Thank you for your patch/series, I've applied this patch
> (series) to my review-hans branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x8=
6.git/log/?h=3Dreview-hans
>
> > Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
> > Signed-off-by: Vishnu Sankar <vsankar@lenovo.com>
>
> Note I have dropped this second duplicate Signed-off-by,
> I have kept the first one since that matches the From:
> from this email / the git commit author field.
Acked.
>
> I will include this patch in my next fixes pull-req to Linus
> for the current kernel development cycle.
Thank you!
>
> Regards,
>
> Hans
>
>
>
>
>
> > Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> > ---
> >  drivers/platform/x86/thinkpad_acpi.c | 28 +++++++++++++++++++++++++---
> >  1 file changed, 25 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x8=
6/thinkpad_acpi.c
> > index 4c1b0553f872..6371a9f765c1 100644
> > --- a/drivers/platform/x86/thinkpad_acpi.c
> > +++ b/drivers/platform/x86/thinkpad_acpi.c
> > @@ -7936,6 +7936,7 @@ static u8 fan_control_resume_level;
> >  static int fan_watchdog_maxinterval;
> >
> >  static bool fan_with_ns_addr;
> > +static bool ecfw_with_fan_dec_rpm;
> >
> >  static struct mutex fan_mutex;
> >
> > @@ -8682,7 +8683,11 @@ static ssize_t fan_fan1_input_show(struct device=
 *dev,
> >       if (res < 0)
> >               return res;
> >
> > -     return sysfs_emit(buf, "%u\n", speed);
> > +     /* Check for fan speeds displayed in hexadecimal */
> > +     if (!ecfw_with_fan_dec_rpm)
> > +             return sysfs_emit(buf, "%u\n", speed);
> > +     else
> > +             return sysfs_emit(buf, "%x\n", speed);
> >  }
> >
> >  static DEVICE_ATTR(fan1_input, S_IRUGO, fan_fan1_input_show, NULL);
> > @@ -8699,7 +8704,11 @@ static ssize_t fan_fan2_input_show(struct device=
 *dev,
> >       if (res < 0)
> >               return res;
> >
> > -     return sysfs_emit(buf, "%u\n", speed);
> > +     /* Check for fan speeds displayed in hexadecimal */
> > +     if (!ecfw_with_fan_dec_rpm)
> > +             return sysfs_emit(buf, "%u\n", speed);
> > +     else
> > +             return sysfs_emit(buf, "%x\n", speed);
> >  }
> >
> >  static DEVICE_ATTR(fan2_input, S_IRUGO, fan_fan2_input_show, NULL);
> > @@ -8775,6 +8784,7 @@ static const struct attribute_group fan_driver_at=
tr_group =3D {
> >  #define TPACPI_FAN_2CTL              0x0004          /* selects fan2 c=
ontrol */
> >  #define TPACPI_FAN_NOFAN     0x0008          /* no fan available */
> >  #define TPACPI_FAN_NS                0x0010          /* For EC with no=
n-Standard register addresses */
> > +#define TPACPI_FAN_DECRPM    0x0020          /* For ECFW's with RPM in=
 register as decimal */
> >
> >  static const struct tpacpi_quirk fan_quirk_table[] __initconst =3D {
> >       TPACPI_QEC_IBM('1', 'Y', TPACPI_FAN_Q1),
> > @@ -8803,6 +8813,7 @@ static const struct tpacpi_quirk fan_quirk_table[=
] __initconst =3D {
> >       TPACPI_Q_LNV3('R', '1', 'D', TPACPI_FAN_NS),    /* 11e Gen5 GL-R =
*/
> >       TPACPI_Q_LNV3('R', '0', 'V', TPACPI_FAN_NS),    /* 11e Gen5 KL-Y =
*/
> >       TPACPI_Q_LNV3('N', '1', 'O', TPACPI_FAN_NOFAN), /* X1 Tablet (2nd=
 gen) */
> > +     TPACPI_Q_LNV3('R', '0', 'Q', TPACPI_FAN_DECRPM),/* L480 */
> >  };
> >
> >  static int __init fan_init(struct ibm_init_struct *iibm)
> > @@ -8847,6 +8858,13 @@ static int __init fan_init(struct ibm_init_struc=
t *iibm)
> >               tp_features.fan_ctrl_status_undef =3D 1;
> >       }
> >
> > +     /* Check for the EC/BIOS with RPM reported in decimal*/
> > +     if (quirks & TPACPI_FAN_DECRPM) {
> > +             pr_info("ECFW with fan RPM as decimal in EC register\n");
> > +             ecfw_with_fan_dec_rpm =3D 1;
> > +             tp_features.fan_ctrl_status_undef =3D 1;
> > +     }
> > +
> >       if (gfan_handle) {
> >               /* 570, 600e/x, 770e, 770x */
> >               fan_status_access_mode =3D TPACPI_FAN_RD_ACPI_GFAN;
> > @@ -9067,7 +9085,11 @@ static int fan_read(struct seq_file *m)
> >               if (rc < 0)
> >                       return rc;
> >
> > -             seq_printf(m, "speed:\t\t%d\n", speed);
> > +             /* Check for fan speeds displayed in hexadecimal */
> > +             if (!ecfw_with_fan_dec_rpm)
> > +                     seq_printf(m, "speed:\t\t%d\n", speed);
> > +             else
> > +                     seq_printf(m, "speed:\t\t%x\n", speed);
> >
> >               if (fan_status_access_mode =3D=3D TPACPI_FAN_RD_TPEC_NS) =
{
> >                       /*
>


--

