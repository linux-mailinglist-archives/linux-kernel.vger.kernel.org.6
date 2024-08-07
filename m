Return-Path: <linux-kernel+bounces-277488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AEE94A20B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB14D1F23B56
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE32F3EA64;
	Wed,  7 Aug 2024 07:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="h9uWMD6g"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597FC8F77
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017229; cv=none; b=SE+hHqGoxT8ozAsi3co7iK3nc9EQhdWrsoT/T2ETW4xVEPzNu0Uz6XOqfHw0Ugek2dV4ZbvkPUlUg2Bm7Un05UxCehsHedsrWJq4D+oyyiG2Y+f6Ve6yWFRNbhmnGgjuFnmPmHBCMZE5PLBSgrv8rfs2ljzSAdpK75/QscdxOyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017229; c=relaxed/simple;
	bh=KqnPxyjijqgj7Dabl0pL8UK9VNQba/K8dgna1uY/+o8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZeuAlvm2E3eFQDnrsDmRZ0AqZGUc4JNAmb3rH06JSmIwSyn3Qjlva9EpjfFsTxrSWKgfAqJdTAdWyAE6EflTZ3vKW9xTPQBi78dt902jD7+k9wHbwL/wuyYkAhDU7Q0U7KAmmf1j/Xu9pTmd3LC0QAsXXvNautZfT1zBFhyQ1ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=h9uWMD6g; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52f01ec08d6so1895382e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 00:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723017223; x=1723622023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqnPxyjijqgj7Dabl0pL8UK9VNQba/K8dgna1uY/+o8=;
        b=h9uWMD6gEvL9VFBHXMTgT30wHAi724kV+7WcdiKDv0XwwtFMT/srTumwwpg9JufOfF
         neRV7C1NqFQU6B08MLOmZjpdeHBq9fP6jAQSlyt2pX2h8lfp+81wGw3svjiNNrTUfrW3
         8BtX8RXM5EHiGT0JyCsYK5Ms5JYRo3d0VKvBsDBlCXY6dedtj6AM4QttVlqF+gj7AVVa
         ZR1bPuhvPOPPe+7isMbTYuEZlv8EZjUlGvLfS1qDQlRzs/XiUq/pY53lpRw5ZW3K0+bn
         ed51U4ualsuW1NVLBVaMlvIJtnrjsITMCi8+PvdlAOZFxBy0Nkd+H/KNsfClt84gkkR1
         +K3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723017223; x=1723622023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqnPxyjijqgj7Dabl0pL8UK9VNQba/K8dgna1uY/+o8=;
        b=HqfWesIOCF+ME7aWnIXPrmK9Gx9DNRFuY7nMDLV2ajP7zt1uhbPCrpxsgI42J+8bF4
         6UbwAk7e/hNlkw48+6mq9sNMzc1JTliYxd0jXIHnZgzXoJ013RTX1biKIfCMhYjyAUvl
         7h5ZtHravw45l/oBBllGcIFwkTQ/Z2A90Qb4TzNscnJY5dN6diBfOCTVo8cId8oDVukT
         82F3dUK3nlb8CkGCEyoyXPeisylM5CJFy308+R+4NRWTYQ+SZWPCxk16XbLsh+O6Q2cG
         YXMjRyZxWl+wDQuSYqpa7qzD0e6u42Ge6IYF0J3ZOPqEYt11UtWDTTmPZSW6KUnFIBwH
         11DA==
X-Forwarded-Encrypted: i=1; AJvYcCX26PDUIP8IlQqiEIWS9zVO0rKZvHWxvqAkJr8x/h1x8rvfrY9pWoEZOJs88cGmaHykpRF0VVKAVp/Arhp84DWhCD0Vu1vudPMsUwV9
X-Gm-Message-State: AOJu0YzO3ylTym/FQ+AAID47GE8c9E27u41lsi7UPYRpn4jizh74/MNk
	4YUpfT4IRVcJOFZ6tr+91mYapC3hOjEaTBfgECQE9x7kGgGJNZ3mgL5WLmlnVuJe7m3HQITvFo6
	awW6fNvKeQ+hmDRufbN+sMgDU6dgnH5m375FQ/xjn8k0OgP58ztY=
X-Google-Smtp-Source: AGHT+IEMHPUoCGAziZXFqLRYhcE89Hu0RXOGMn5qoswWzoIi01nwD/49Dvb2oq880JBBAmn6aIs0b95/3o35im4sNu4=
X-Received: by 2002:a05:6512:2302:b0:52f:d69e:bb58 with SMTP id
 2adb3069b0e04-530bb39b7d5mr13670284e87.44.1723017223061; Wed, 07 Aug 2024
 00:53:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731-hci_qca_fixes-v1-0-59dad830b243@linaro.org>
 <20240731-hci_qca_fixes-v1-3-59dad830b243@linaro.org> <1723fdc3-33b9-4518-8f25-161ab59ecf21@notapiano>
In-Reply-To: <1723fdc3-33b9-4518-8f25-161ab59ecf21@notapiano>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 7 Aug 2024 09:53:31 +0200
Message-ID: <CAMRc=MdSH6n=QKwWnT9zNaBito34t+BpCufQDjnAOaeC5iuD+Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] Bluetooth: hci_qca: fix a NULL-pointer derefence at shutdown
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	Marcel Holtmann <marcel@holtmann.org>
Cc: Wren Turkal <wt@penguintechs.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 12:44=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Wed, Jul 31, 2024 at 05:20:50PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Unlike qca_regulator_init(), qca_power_shutdown() may be called for
> > QCA_ROME which does not have qcadev->bt_power assigned. Add a
> > NULL-pointer check before dereferencing the struct qca_power pointer.
> >
> > Fixes: eba1718717b0 ("Bluetooth: hci_qca: make pwrseq calls the default=
 if available")
> > Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Closes: https://lore.kernel.org/linux-bluetooth/su3wp6s44hrxf4ijvsdfzbv=
v4unu4ycb7kkvwbx6ltdafkldir@4g7ydqm2ap5j/
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Hi,
>
> I just noticed we're still hitting this issue in mainline (saw it on the
> mt8183-juniper platform in KernelCI). I see this commit was merged 6 days=
 ago to
> bluetooth-next, but it seems there wasn't a pull request with this fix ye=
t to
> include it in 6.11. I'm wondering if it's still going to be sent.
>
> Thanks,
> N=C3=ADcolas

The patches are in next so I don't see why they wouldn't be sent upstream.

Moving Luiz and Marcel to To: to make sure they see this message.

Bart

