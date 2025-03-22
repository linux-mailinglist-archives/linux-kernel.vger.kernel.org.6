Return-Path: <linux-kernel+bounces-572533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37076A6CB2B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 16:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5453B0D7D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 15:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D5822424D;
	Sat, 22 Mar 2025 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOUdRud5"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5000815B971
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742657839; cv=none; b=PCc5O98AeZz3oe4xWiTFIflWmGQYgxgWYYLkvyhvxrW/WndQgalRnxJ+qZeL79MzzdDJTEKefEjamhwNrXPNwavBz/J2S9RDhkAhEzAkUJg+/KvqHEypTdj79xpd9qZDtwz4M4q71/VGgsMjBePtT9qF3nMnA4hNBO0ZByJ906U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742657839; c=relaxed/simple;
	bh=/T8vDis5wt1e8gSA9CFxhWdIs6vxuC+8XJ8OzBDc8JY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WTMaLdyCWa143j4I82dn8UdO/0ZukZe6lL5oHOMRsgzipLJQozW0gHN2QUfmg2/VFpVS4fo5q56uEAFjwWailVrRY2zDWsv38Ak2Twlek06XYKGASl5/2MF3PokO6A7Oovr09rYNf2Pj9QoMxxfIOnwilc0iGb8HatkNiyi5vO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOUdRud5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abbd96bef64so533007466b.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 08:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742657835; x=1743262635; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MDPcWgMNo2FqmuOqa9TlGd/nusehsLtSUTJAhoCLfx8=;
        b=FOUdRud5VfrMHyfGD85XeuZusApodmIk7Tw2keyPQfPnbZUog8IAAtyjL2ZrI2FFvf
         V3mSvIccRUo157ktt+Ag1n7kHa1HnYQQE03TzaceoQon4AIL32biJx2bACIgS3r7u3zX
         ziFgBhwR/0/w9ji88w8po/O5Tv5EFP5Q1LtekWqMsfdWI2T89mdkINxvj1sUEDfrdX9+
         Hea6QSJTAf5JH1rMuf0tOKHdx3o1rIcKPpXJ2ZcxB2minS84zpoEw9AcZaDqiADPxffp
         OkQNqqrHw1R3GVYtX9ZQePATCrBzbLzFt3k3BM6cf5tp1TbIMkwGx0Y/5HaszAHqiOUO
         UcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742657835; x=1743262635;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MDPcWgMNo2FqmuOqa9TlGd/nusehsLtSUTJAhoCLfx8=;
        b=boOz+404qGk1wilBtojM2ps/+1jARx8ZCJNCKlh8nLkn3q/H6PViKPiLGUsIvQYOm0
         DIcPqIEtk9zbSDOk873GcensC5Bx6D2/7lko5NfW9aJbpg4WV7zapIg8hnLNXB7KURqU
         5icx7xczvhRXsyeZ0Gw4UbyVsFNrK1UKvxOM+AgMJbDG/cPenNzEpYWFxuDcUdBWD28v
         xZnn7XqmufBrngoNwPVD4O5Ojn7T3DpaLsCF11xIob8YtoorSs9ttzjO0F4Hsp9RROIF
         676UGblI8SVpstBllOjNWZs78NqjDFeNnu0rBgHMAuTJbTVyKtzG+uxFq374YMmEafHC
         GH6w==
X-Forwarded-Encrypted: i=1; AJvYcCWotBwibMTGYrYC96WJL5kR8mVVgT2kC7NBzfVwED3qWgSoBPNMVpKdpChpYRiHC6rA9zF2aTHrjpKvqs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRApFiQ1UNU8IPGjARBm3Ny76GJu0h3WnHg4zqIHEvxGBAC3UW
	XQ/2MrOtlngGvgeC170fm7BqRWmjlhVVHHw+KudMewHwWTZDvwURLIH0fZSCk14=
X-Gm-Gg: ASbGncuhRFD+2c3QdbqB7+ZtqsflZ7lQrToPGQv/RMZ3ZCnBPsmzbz6mnFbssp6JOUK
	gp/fAUJj9UYLk9C7wd9ZfHlIrljVRPZe5bGNG7ARzHqLlLUA/Bp4HCrlMKdrN4F9adq6hP6C/Wz
	shbIy5lAvhKQoZTvaRAiArXMFiE0/M88nVVttpr3kpWf6Yca+4L6KTHX3iHPmsBJEKgjTBvh9VB
	iBBatMgkRP7S4OF1giOp1oA4318Gh5/GfMi6jUIqP89wq0jRyqULUo9onJWN+GAAAFSXu3jV6uS
	vS1O3SAYdM0QK76sEl1OT434Uoa2Ua29Lf3qmXr5aI1Jkv7n6w==
X-Google-Smtp-Source: AGHT+IFkSEzUgBZ0q29OnEgwaAmNJN8Y3mUH0OvKhoqlOBRCbzI4wzIkN6km6zh3cBkvJW4Gi+rwRw==
X-Received: by 2002:a17:907:9403:b0:ac3:154e:1391 with SMTP id a640c23a62f3a-ac3f207f927mr779803966b.10.1742657834898;
        Sat, 22 Mar 2025 08:37:14 -0700 (PDT)
Received: from HP-650 ([105.112.226.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8d3cd3sm363834466b.40.2025.03.22.08.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 08:37:14 -0700 (PDT)
Date: Sat, 22 Mar 2025 16:36:53 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Julia Lawall <julia.lawall@inria.fr>, outreachy@lists.linux.dev
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	linux-staging@lists.linux.dev, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: bcm2835-camera: Modify function call formatting
Message-ID: <Z97ZFURPvDcTkjjf@HP-650>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The line is a function call which ends with an opening parenthesis
thereby not adhering to the Linux kernel coding style.

Modify the function call to include parameters on the same line as
the opening parenthesis to improve readability and consistency while
adhering to Linux coding styles.

Reported by checkpatch:

CHECK: Lines should not end with '('

Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---
Changes in v2:
	- Add more patch recipients.

 .../vc04_services/bcm2835-camera/controls.c        | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
index 6bce45925bf1..e670226f1edf 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
@@ -533,17 +533,15 @@ static int ctrl_set_image_effect(struct bcm2835_mmal_dev *dev,

 		control = &dev->component[COMP_CAMERA]->control;

-		ret = vchiq_mmal_port_parameter_set(
-				dev->instance, control,
-				MMAL_PARAMETER_IMAGE_EFFECT_PARAMETERS,
-				&imagefx, sizeof(imagefx));
+		ret = vchiq_mmal_port_parameter_set(dev->instance, control,
+						    MMAL_PARAMETER_IMAGE_EFFECT_PARAMETERS,
+						    &imagefx, sizeof(imagefx));
 		if (ret)
 			goto exit;

-		ret = vchiq_mmal_port_parameter_set(
-				dev->instance, control,
-				MMAL_PARAMETER_COLOUR_EFFECT,
-				&dev->colourfx, sizeof(dev->colourfx));
+		ret = vchiq_mmal_port_parameter_set(dev->instance, control,
+						    MMAL_PARAMETER_COLOUR_EFFECT,
+						    &dev->colourfx, sizeof(dev->colourfx));
 	}

 exit:
--
2.34.1


