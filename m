Return-Path: <linux-kernel+bounces-218582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D44E390C23C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591E31C21884
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833A01D9503;
	Tue, 18 Jun 2024 03:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="cnDFXdBe"
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BBD4C6D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718679992; cv=none; b=Cvv7fECSWSJXJRvkyYOqvTIn9gxH2VMR8swwJ75D1Ms10hq7UcRJutXke+Kyp1qR9n993ry5ZC/FmNPIetoQ70oiA//Yn8SvmeYc1UT4+Eo1T5D8KSNAENDujtYo02BZ0mKaWFoy4u2wsne3kW69YNS6SITSTIa6ivJR3w2eCGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718679992; c=relaxed/simple;
	bh=uInoEhGosu5GMD5vL2VB3gNQ4eTa+4J/kytQOt+uD6Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kZMA4urNzXc0dNZlZr8fLIC7P3YoBsQsL+p/3agI1rQ+zTR59WA1BNt38t+ZPj4XBxe1XmyKLK6dOS6OH2Tst5ps2c5P0ImV7EIf25lRi6+zuwDZfmZpiHR5VIp73LJOlBGpoGPLrx6Llzw0nz21dYUnWEMNIIqiN5Zl/QZMw2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=cnDFXdBe; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-6e9f52e99c2so3641733a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 20:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1718679989; x=1719284789; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2VRhlSIRp2dQ6zjf1R4Z8ODRGkXxF2N2s5hDpq56dI=;
        b=cnDFXdBeP13klVGcQf64IGc6WVjP2ldXMBl2/DKHLF6AiC+F+a3yMWFW2Py0DRLiH9
         AszUO564A6P1BWevlu9D1fTSgAuvZ24FG2jB8RyCXX9NlTSR2fg1t1RCxp0+Kfl/2nth
         GlYb1/mFYySPhwBedK0DMRu2ZHB+iaCVGC9oU73IhBWbRRj9OyVdBWJ8wYXSikntO38J
         Y7GRc2BALCvKdvtux9I+D0LI/ivRO/W7WeAGJveHW4dStl2rHPvRl7R2rjLN6xxckV1m
         13saloRwU6tNI29NllfW7D2cHjYyvppMk0OeG7+QjqE8DN9jyN3emA7zjsShXKDaSQUu
         7NYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718679989; x=1719284789;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2VRhlSIRp2dQ6zjf1R4Z8ODRGkXxF2N2s5hDpq56dI=;
        b=dl9jua6wUhS+/8quhBm5VV8ANh2tppILorl6v3TyZRYfVi7cXApvGmE0X0q0DQ5vbW
         90NQNYB0sa3mEDr2z0NWL8TZm+ha44asMo1opNX+Dij7OFyI0SdUOd46OW7DGvfv6wZ2
         zF34MIDSS7NB0Az5W/47AfFy/Kddkh+hni42V2s6X66DOd8gQSuhcMtboEbeRhKnbp04
         aiFmlSuHo24soL9QNaLS+CXScOz3s61y+aqLiWpOwbbmr99vJ2onfMln/mAXOWKP7I/c
         77XdDOo0ZK0Fdd5tgFhKD0FcMkRb9phfn06B6KNghy4YLf9DJV4AN5up4Z72nqNa9rFt
         yr7w==
X-Forwarded-Encrypted: i=1; AJvYcCX9osujRlo+qJ76z7pQ6bfZnYyKbyifVOZlOjA7tD+gHi7FXwHJQejAnPASR9hW/YMfNbE7XxBspyECZj5Jez53ffvfpPAF1ltRw44b
X-Gm-Message-State: AOJu0YxiVuECgdC/AYrHrYm7McABhOc3lnUrievSGg7TdrtruBgcmzcf
	bt9DsUC5hT8MEqDXBcd68pPCcd9TaMZTYTH/9o+zQCnpafiEblCDVvblN4/7N4c=
X-Google-Smtp-Source: AGHT+IFlhKfP32ABgzSXCXa3SNgwMCy4g1+CgVpsyPa2+FxBprwtL0HxAYljCSvteqeO1VfvX+ofTQ==
X-Received: by 2002:a05:6a21:6da3:b0:1b6:8b1e:c3f3 with SMTP id adf61e73a8af0-1bae7dedd57mr10665783637.14.1718679989008;
        Mon, 17 Jun 2024 20:06:29 -0700 (PDT)
Received: from smtpclient.apple ([103.172.41.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4cab602e3sm9435362a91.8.2024.06.17.20.06.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2024 20:06:28 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH] scsi: sd: Keep the discard mode stable
From: Li Feng <fengli@smartx.com>
In-Reply-To: <20240617162657.GA843635@p1gen4-pw042f0m.fritz.box>
Date: Tue, 18 Jun 2024 11:06:13 +0800
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DBAA6B83-E60A-437C-A8D8-B854E625F6CD@smartx.com>
References: <20240614160350.180490-1-fengli@smartx.com>
 <20240617162657.GA843635@p1gen4-pw042f0m.fritz.box>
To: Benjamin Block <bblock@linux.ibm.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)



> 2024=E5=B9=B46=E6=9C=8818=E6=97=A5 00:26=EF=BC=8CBenjamin Block =
<bblock@linux.ibm.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hey,
>=20
> On Sat, Jun 15, 2024 at 12:03:47AM +0800, Li Feng wrote:
>> There is a scenario where a large number of discard commands
>> are issued when the iscsi initiator connects to the target
>> and then performs a session rescan operation.=20
>=20
> Is this with just one specific target implementation? This sounds like =
a
> broken/buggy target, or is there a reason why this happens in general?
>=20
> And broken target sounds like device quirk, rather than impacting =
every
> possible target.

(resend due to GMail HTML bounce)

This is a common problem. Before sending a rescan, discard has been=20
negotiated to UNMAP. After the rescan, there will be a short window for=20=

it to become WS16, and then it will immediately become UNMAP.=20
However, during this period, a small amount of discard commands=20
may become WS16, resulting in a strange problem.

>=20
>> There is a time
>> window, most of the commands are in UNMAP mode, and some
>> discard commands become WRITE SAME with UNMAP.
>>=20
>> The discard mode has been negotiated during the SCSI probe. If
>> the mode is temporarily changed from UNMAP to WRITE SAME with
>> UNMAP, IO ERROR may occur because the target may not implement
>> WRITE SAME with UNMAP. Keep the discard mode stable to fix this
>> issue.
>>=20
>> Signed-off-by: Li Feng <fengli@smartx.com>
>> ---
>> drivers/scsi/sd.c | 7 ++++++-
>> 1 file changed, 6 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
>> index f6c822c9cbd2..0165dc70a99b 100644
>> --- a/drivers/scsi/sd.c
>> +++ b/drivers/scsi/sd.c
>> @@ -2598,7 +2598,12 @@ static int read_capacity_16(struct scsi_disk =
*sdkp, struct scsi_device *sdp,
>> if (buffer[14] & 0x40) /* LBPRZ */
>> sdkp->lbprz =3D 1;
>>=20
>> - sd_config_discard(sdkp, SD_LBP_WS16);
>> + /*
>> +  * When the discard mode has been set to UNMAP, it should not be =
set to
>> +  * WRITE SAME with UNMAP.
>> +  */
>> + if (!sdkp->max_unmap_blocks)
>> + sd_config_discard(sdkp, SD_LBP_WS16);
>> }
>>=20
>> sdkp->capacity =3D lba + 1;
>=20
> --=20
> Best Regards, Benjamin Block        /        Linux on IBM Z Kernel =
Development
> IBM Deutschland Research & Development GmbH    /   =
https://www.ibm.com/privacy
> Vors. Aufs.-R.: Wolfgang Wendt         /        Gesch?ftsf?hrung: =
David Faller
> Sitz der Ges.: B?blingen     /    Registergericht: AmtsG Stuttgart, =
HRB 243294



