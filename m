Return-Path: <linux-kernel+bounces-418770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08F89D657D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DAA4B233ED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 21:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9039B18C33A;
	Fri, 22 Nov 2024 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="inXTmVs7"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CE118A6AA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732312536; cv=none; b=sYUghldzCOSzDDIZiFN/a8JrdbP+7hANm6WfFuw/e3wpKh7suKF0bmXmnJzNWl3V4ScxAr5F4nZnS5TFtaXVJYNuM6i9w4oAJTqBEyGq0sCBjP/qLy1UaNddwCUwWtBqafXnGz941+JVPKrIjYpiWlePP5d39hkuuj6n6iCdlCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732312536; c=relaxed/simple;
	bh=Ivt34dLadzx+dY3zrPHdwzCxKtw0aya58zcMXS9yIKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hlJgvGY5F8+Zq6sMwxfR13/vTl6Smhr+Si5j9R4FMoKCqIoKtK7sncttOhcKtXybFHxwCYaP0KxtrEjOM6Y/iw+O24RgzP28aOm6xVDA30xZJKBcjDJgtIxWpCk5sSstlVDaWanqXrv5WWJxuBH4SzOQw4YSh4JLymN6QzfKEKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=inXTmVs7; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6eeb3741880so25883657b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 13:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732312534; x=1732917334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4w0V8piCFy/xNq9WrRvW2FpZEM6c30Db54nbhmRpaA=;
        b=inXTmVs7FaJfgcJfMD5LVQez/2iX2xemFQpOgtwKAzF82NKXsQEDT6b52v3o5OVvtC
         IiAMc8h5AJ7GGl1BFjlOemOFXY19GpShZK3t6j238qfrZ6MPGe4f3nNNyNwfj8GAQneK
         PLBTwkR770HWt8srkqyIx4toz1p4Sc2sCEk2+IIZueH6cG0UAFSYq99AYOLvtH9z3Bxh
         i/l1ENbnr81bC4P9xvw2zIM3+27zRMgLYBrGX6gafflMxwMHy06Wq72XbRbdQ1X4Xgpd
         9h8vapaQAbyuOp3cQRuJRfM7t9yq5xMl9S2/GZsh5BAvwVMLyXbWFVzd68FZ+xfEYGZ1
         xMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732312534; x=1732917334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4w0V8piCFy/xNq9WrRvW2FpZEM6c30Db54nbhmRpaA=;
        b=c7/6KL3zN+p2Jddbxi1OijCmTojvZihOE+gkGBfi2rGRAnOlcrL1OTZkigG743/Wg/
         KB6NZvy9aol1mLzQZ1S6Ht3LiiT9NUgM+Ys0iLKNYEi8MJ632GZXHq9AcrbA1spXf9uj
         VxLLdpUCXaHXaLSkZVHPpyYFdIMzuegTQxpyL1HuwP49fgDSNTYMrWvTTlrr8NT3y0C1
         NHU2WfVmo3Y7hX6yY6KC/nYJe3aSlQPrKfwrxgPkS9vRQH9cPdzk/wSTRbDXvDABOymK
         rqXL5Y0ajzWEzTksr0BCm4w9KfF0/cfpfj2y3agL/6QBZzOmxk+qTmCHcK1Q8fmo8l46
         5reQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZuumNr5fp38R3NHU0ik+CPoqJL8GMufQbVPXMw9vZpSU/OXBFVxFRV72AtyvkLIFsnRi4O9SEglBfYaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YytP9/KPlc3+dlfHoJQ5bOBRtWSqUawqy6pkLPhIZ/DAZrvyoFm
	C148jOBYqjAAtP+qGaKAc2Qe9J6e+jdGMAsWw3aAYQUtPVVjTZprfb5VgmAJqi38O6+hSN2fBKu
	qHqBc/bQ34XvYgE7KlL1PvC5RImRBfUocururLg==
X-Gm-Gg: ASbGncvACtbUbphb1gWpVXPLDgW5fAizUjZ0GlYpPdLCxqxFCVugqBV59C1uVE5M+X7
	EjfPA9YCBK2ZwKD/JhGoybX9FFuHih9E=
X-Google-Smtp-Source: AGHT+IGRq1VZsNlaYrCF8hcYwGMmdJ3cPmaBbMhayTP0BZfNZaqlKQg8YaIV/vhw18gRsEQlgZOx8XVaet9ohYoKAfM=
X-Received: by 2002:a05:690c:881:b0:6ee:b38c:b6e1 with SMTP id
 00721157ae682-6eee089e833mr61356057b3.14.1732312534045; Fri, 22 Nov 2024
 13:55:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112170050.1612998-3-hch@lst.de> <20241122050419.21973-1-semen.protsenko@linaro.org>
 <20241122120444.GA25679@lst.de>
In-Reply-To: <20241122120444.GA25679@lst.de>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 22 Nov 2024 15:55:23 -0600
Message-ID: <CAPLW+4==a515TCD93Kp-8zC8iYyYdh92U=j_emnG5sT_d7z64w@mail.gmail.com>
Subject: Re: [PATCH 2/2] block: remove the ioprio field from struct request
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 6:04=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Thu, Nov 21, 2024 at 11:04:19PM -0600, Sam Protsenko wrote:
> > Hi Christoph,
> >
> > This patch causes a regression on E850-96 board. Specifically, there ar=
e
> > two noticeable time lags when booting Debian rootfs:
>
> What storage driver does this board use?  Anything else interesting
> about the setup?
>

It's an Exynos based board with eMMC, so it uses DW MMC driver, with
Exynos glue layer on top of it, so:

    drivers/mmc/host/dw_mmc.c
    drivers/mmc/host/dw_mmc-exynos.c

I'm using the regular ARM64 defconfig. Nothing fancy about this setup
neither, the device tree with eMMC definition (mmc_0) is here:

    arch/arm64/boot/dts/exynos/exynos850-e850-96.dts

FWIW, I was able to narrow down the issue to dd_insert_request()
function. With this hack the freeze is gone:

8<-------------------------------------------------------------------->8
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index acdc28756d9d..83d272b66e71 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -676,7 +676,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx
*hctx, struct request *rq,
        struct request_queue *q =3D hctx->queue;
        struct deadline_data *dd =3D q->elevator->elevator_data;
        const enum dd_data_dir data_dir =3D rq_data_dir(rq);
-       u16 ioprio =3D req_get_ioprio(rq);
+       u16 ioprio =3D 0; /* the same as old req->ioprio */
        u8 ioprio_class =3D IOPRIO_PRIO_CLASS(ioprio);
        struct dd_per_prio *per_prio;
        enum dd_prio prio;
8<-------------------------------------------------------------------->8

Does it tell you anything about where the possible issue can be?

Thanks!

