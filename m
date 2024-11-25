Return-Path: <linux-kernel+bounces-421713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66839D8EEC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 00:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97592289C26
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 23:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB2F1CD1E1;
	Mon, 25 Nov 2024 23:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ePppu1GQ"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ED61E480
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 23:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732576424; cv=none; b=BwiCJar4/iENOFl1fDU/qgdpPnDzBhfxez9bERJmBByYyWk275k4rD0V/s8QosxbXIog0O8LH5HRgaadLv5duiRDCVQlqU7hN32FmbyC0Ri9KHJ3nwnTeGiBuohFH8KZAEZ2TpmMbaCKFv1gC5HpajARzF8tnvJN1rMip7YNqlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732576424; c=relaxed/simple;
	bh=KVZsvLMcMF7B+5XJvRsy6EnNxud+pPcVbig6ZFELOP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/nqz1ith+hmgdU3n1aGnob5Neh3o6uzYI19GTUDEiCDNPvJJZ4FFClZAdafhus1j6vLZGS1iDuEwtXBPPdmqrNuTxAknK/cAWSFHK0q1dBUDs03ebktwk72PoSyVSrxaL48hPiLXeuHeLg1RHnw3KpdDsm1ybCSlh4OPcByr8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ePppu1GQ; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6eeac3535baso48605277b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 15:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732576420; x=1733181220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1h22yel4a+AVA4skUO0bIJ443dO8U6a44Jcm2JOSrU=;
        b=ePppu1GQrtyNEEN3O/Rqt9I9B37A7SM1mzYZ4CVOy3ewo2ythDYBnSMWtVkyn/gXGw
         KXttxQElikKcKdsuTtIWeEgYYUnA5Aqaq6FmzMgO/BqRcehUGYCWpWEZPJIw30S52DvL
         lUbKmePHi1chJoXaTgdDyR7wSr8TOG0APpgHYxD+hZwQI+yCTMng1Q541/HDEf0TD5dO
         YvgNo8G3q64m0wMYZZsVj8Bu5yUXgxtyAkACiTG+mYtHvy4m+Pcl0Dryl1LuybZpK+tD
         Q41sakQ7P5DlhVMa/YMEVRxLzk0c0i7clGkt40sy2cRQqw5KEymXqkiSI4L0hjECso24
         cbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732576420; x=1733181220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1h22yel4a+AVA4skUO0bIJ443dO8U6a44Jcm2JOSrU=;
        b=NZzL/zvBuBmA3DjlzhCvkgxtJdB+NUT3YAbhogS2kFo4rCwGKCHHof/naecd4FdM73
         OHSmdxPsag6xlCnPLiAMlwvFNLqtPP4WSMLry139szPyc6iHyxBq0jJNwYvEOsIRk/ft
         jeJ0Y0O6kfYxkhxZ2jU833H96Zdmqp4y3kshnmoeN/PfBz2+F7E77k0yj7OqzvFQBMc8
         MvEhUiT5jBah0RP7Ljd0ig2kkbGlLqxNVPk9vH3+SMgQ4JiD3KCepmU38F5uMeu20ppL
         dW8NJbnAy+oozhidDSwsbrdRj8iP2BjBVYD2RMI4wW/qx/FRLptNWIgq/yhF3712G2Wh
         rXXw==
X-Forwarded-Encrypted: i=1; AJvYcCUTX/bQf0ehckgMVqvOXYAaYYo3m1eTm+L7xuYHh/Ab/+OMiU9cPg4Bn3X+1kdsCZIHeCeLQ/sqcYC5lgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw34pzfYzz4+31thFBMuygtC+9vOdbMranQ2DtPii/8T3uxOI0r
	n+vY1cVPYixeUiWrr4rbIpoVlVb3uUvWfMqiBUv3FWLBziVR1g5/wLUZ2KdcJ6TWlKJDSElbzsV
	nbGB+3drpK72o+59p59WbEuG4sXyfTvUMzZDnbA==
X-Gm-Gg: ASbGnctAbX+pfNN6U2nBqZfoch46/a2lEyPLDnBmnkaH9+94CBWT7njkkuM5W5clVQg
	uIliZAkqCzWxXEe4v0bxno0INmtdsxlw=
X-Google-Smtp-Source: AGHT+IEgwZhiK1rR9pEss4yB2/MBxGuFiIOxpC0IuHysvYmViO2ZsmddzZAz/1H8S4RvbyNtVnUa/ZDzKpS9xj676Pc=
X-Received: by 2002:a05:690c:3513:b0:6e3:a7b:49b3 with SMTP id
 00721157ae682-6eee0a63524mr158689697b3.41.1732576420404; Mon, 25 Nov 2024
 15:13:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112170050.1612998-3-hch@lst.de> <20241122050419.21973-1-semen.protsenko@linaro.org>
 <20241122120444.GA25679@lst.de> <CAPLW+4==a515TCD93Kp-8zC8iYyYdh92U=j_emnG5sT_d7z64w@mail.gmail.com>
 <da02f209-8524-4281-a9d3-1b524bd966da@acm.org>
In-Reply-To: <da02f209-8524-4281-a9d3-1b524bd966da@acm.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 25 Nov 2024 17:13:29 -0600
Message-ID: <CAPLW+4mbxfHJbxvj1CUGSbs-oN_zfnQjWvovB+KYqbyoqtgOKg@mail.gmail.com>
Subject: Re: [PATCH 2/2] block: remove the ioprio field from struct request
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, linux-block@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bart,

On Fri, Nov 22, 2024 at 4:18=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 11/22/24 1:55 PM, Sam Protsenko wrote:
> > On Fri, Nov 22, 2024 at 6:04=E2=80=AFAM Christoph Hellwig <hch@lst.de> =
wrote:
> >>
> >> On Thu, Nov 21, 2024 at 11:04:19PM -0600, Sam Protsenko wrote:
> >>> Hi Christoph,
> >>>
> >>> This patch causes a regression on E850-96 board. Specifically, there =
are
> >>> two noticeable time lags when booting Debian rootfs:
> >>
> >> What storage driver does this board use?  Anything else interesting
> >> about the setup?
> >>
> >
> > It's an Exynos based board with eMMC, so it uses DW MMC driver, with
> > Exynos glue layer on top of it, so:
> >
> >      drivers/mmc/host/dw_mmc.c
> >      drivers/mmc/host/dw_mmc-exynos.c
> >
> > I'm using the regular ARM64 defconfig. Nothing fancy about this setup
> > neither, the device tree with eMMC definition (mmc_0) is here:
> >
> >      arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
> >
> > FWIW, I was able to narrow down the issue to dd_insert_request()
> > function. With this hack the freeze is gone:
> >
> > 8<-------------------------------------------------------------------->=
8
> > diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> > index acdc28756d9d..83d272b66e71 100644
> > --- a/block/mq-deadline.c
> > +++ b/block/mq-deadline.c
> > @@ -676,7 +676,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx
> > *hctx, struct request *rq,
> >          struct request_queue *q =3D hctx->queue;
> >          struct deadline_data *dd =3D q->elevator->elevator_data;
> >          const enum dd_data_dir data_dir =3D rq_data_dir(rq);
> > -       u16 ioprio =3D req_get_ioprio(rq);
> > +       u16 ioprio =3D 0; /* the same as old req->ioprio */
> >          u8 ioprio_class =3D IOPRIO_PRIO_CLASS(ioprio);
> >          struct dd_per_prio *per_prio;
> >          enum dd_prio prio;
> > 8<-------------------------------------------------------------------->=
8
> >
> > Does it tell you anything about where the possible issue can be?
>
> It seems like eMMC devices do not tolerate I/O prioritization. How about
> disabling I/O prioritization for eMMC setups? Is the ioprio cgroup
> controller perhaps activated by the user space software that is running
> on this setup?
>

Can you please elaborate on why eMMC devices might not play well with
prios? Do they lack some particular hardware support, like required
commands? Also, I've noticed (probably) the same issue reported
recently [1] for USB SSD drives. so it'd nice to have some references
showing it's actually the case specifically for eMMC.

Do you know if we have any config options to disable I/O
prioritization? Not sure how exactly we can do that specifically for
eMMC devices too. I'm not an expert in block layer, would appreciate
some help with this one.

For ioprio cgroup: CONFIG_BLK_CGROUP_IOPRIO option is disabled in my
case (ARM64 defconfig), so I don't think it has to do with ioprio
cgroup?

[1] https://lore.kernel.org/all/CAP-bSRbCo7=3DwfUBZ8H7c3Q-7XSG+SB=3DR4MHHNN=
GPvBoinsVSZg@mail.gmail.com/

Thanks!

> Thanks,
>
> Bart.

