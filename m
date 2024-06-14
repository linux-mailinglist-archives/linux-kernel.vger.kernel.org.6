Return-Path: <linux-kernel+bounces-214370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 526C990835A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575D21C22106
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C84F1474A5;
	Fri, 14 Jun 2024 05:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WiLL9SsV"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AC913212F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718343187; cv=none; b=VrRWdn5+6U2bRSc+lBDpD3zYsS9F6DM+cyY73dIzmOaAQEYZdEL7usymkC6wrMSLBL3xrDFnum9wFzrZwSkx0uG3V96L3Q/tzrCKIsFLUv+BTZWxD8y501QoJUD3Iy49hw4Vp2gaS2oyj1Pqjl8jaw1DIkmtAHl6rHtwTef0gi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718343187; c=relaxed/simple;
	bh=BupNbaet3a10DtX8fq4B0pbTB9kFPovlKijsk5zElls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=he5eE65kv+JGznCvUcQN5izQDyPkKK6xKeid+1t+5Caftlz3CUdBiFlFalnkMRp0WVqDaB3ygyOsG9J8y4e29f2beSxdi3jIMclDu3xNwbjCyDIxDTb/64KM7l86kbrCD+GERSRiV9BReuvU1uFLS7WvJltXKYZdhCFoTkpSVbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WiLL9SsV; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a31d63b6bso2306474a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 22:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1718343182; x=1718947982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8ARRkQgQLeSzGpDyFDHG3CG5SMLQRwzzC+kAYB6yiU=;
        b=WiLL9SsVhxlDYeDBncnCHj8PuT3+B0x7hx2DDaHPisAY/7M1tM8A1yfaw/I/DSmBtA
         D6vRYu+NNrFJFaE/LmPdxC9tXut+NtSvBtw37dlh0rfyQIG3lFoP89FLZ6/Qh1K9B9nk
         nZ27P+6WgNMeWRQwIhJwHXjI6clrQLhUS4UhGLsrVGR+j2dO7f92/MfdUIctIzRtOHOr
         TCSn6mcyKsMb2BYIE/4uQYKWQp+gzXHPjGjxBTHRw596CRrYcvvAXEopOm997YFHbpbI
         +7Iavq4hmsLOiKupTjrHhBh4VqKLngoTxuZ7gelOmOYNer0butZdX5Xq/M45xEGczKZN
         9QNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718343182; x=1718947982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8ARRkQgQLeSzGpDyFDHG3CG5SMLQRwzzC+kAYB6yiU=;
        b=cGMLecYyy9uk+vfA/HTE4PIAObZ3r3f072coJYJ+c3a3KdCDERy3x+dsuTCw5nVfOC
         orGnPXAx7WebEw/LZMU5PlT4Pt9Xv1nVyiLzUf2SxNQMgIX/Loav7XGJvfW6sQ3Y8Q5H
         cEtmVkLf/zj2+W9k+wo5qG1SRjWtdFPVQNSUnjqktLhN0vtjDHdkcGqhva2m8p64zBTu
         VYUds8kvDhBwmQ4X/HtYGX+TZ/tKf9vaKkOu/yZEN1wBZi5FoBLGZeuuQGy2abhRnfkM
         FO5zxuHzq7bFmGl29F+fPlmh2UYC1P9UIe78jxui4ZhKFxTRrslyrie/6ZTegIantS9n
         myMA==
X-Forwarded-Encrypted: i=1; AJvYcCW3yB7xmznyRsfh6WYji1JuFtXhSxoGB2GcGWB10rFasmhxADIF0oq8t1FLVxxPX/M7SWSqDZhVbq8g+eDIVOgE+XY/tHZw3ZkEMVCc
X-Gm-Message-State: AOJu0YyLKIorD+Ihvy9lHk0wBtaSZLQHK4gs6wsltN8QuBE0u11YQmkR
	vHnjHn4i06e4h8XdN6bPWDny1CwCKh+DrQ93dnWpza8ng2oZe+ryPK6+G6i0pAEeaeT1lsiTgkT
	2CHc87r4PUUVz+v/R7RaepBVGW3U/ylzqPVYu3w==
X-Google-Smtp-Source: AGHT+IGTgVboz/ujcRsWq103qFWwrdS6joYaGKHoQsgk5YzRRr2+LI4jztKjeI6DNFtQgYBvlNW2w9j9iSbzdp79sMc=
X-Received: by 2002:a50:8d0e:0:b0:57c:6114:3efb with SMTP id
 4fb4d7f45d1cf-57cbd6496fdmr1053552a12.6.1718343182608; Thu, 13 Jun 2024
 22:33:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607175743.3986625-1-tadamsjr@google.com> <20240607175743.3986625-2-tadamsjr@google.com>
In-Reply-To: <20240607175743.3986625-2-tadamsjr@google.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Fri, 14 Jun 2024 07:32:51 +0200
Message-ID: <CAMGffEmgcKh1xGOrRNsBq_GrEbL0a1UdG3dgg6Mg0vrsKzW_Vg@mail.gmail.com>
Subject: Re: [PATCH 1/3] scsi: pm80xx: Set phy->enable_completion only when we
 wait for it
To: TJ Adams <tadamsjr@google.com>
Cc: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 7:57=E2=80=AFPM TJ Adams <tadamsjr@google.com> wrote=
:
>
> From: Igor Pylypiv <ipylypiv@google.com>
>
> pm8001_phy_control() populates the enable_completion pointer with a
> stack address, sends a PHY_LINK_RESET / PHY_HARD_RESET, waits 300 ms,
> and returns. The problem arises when a phy control response comes late.
> After 300 ms the pm8001_phy_control() function returns and the passed
> enable_completion stack address is no longer valid. Late phy control
> response invokes complete() on a dangling enable_completion pointer
> which leads to a kernel crash.
>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> Signed-off-by: Terrence Adams <tadamsjr@google.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_sas.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm800=
1_sas.c
> index a5a31dfa4512..ee2da8e49d4c 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.c
> +++ b/drivers/scsi/pm8001/pm8001_sas.c
> @@ -166,7 +166,6 @@ int pm8001_phy_control(struct asd_sas_phy *sas_phy, e=
num phy_func func,
>         unsigned long flags;
>         pm8001_ha =3D sas_phy->ha->lldd_ha;
>         phy =3D &pm8001_ha->phy[phy_id];
> -       pm8001_ha->phy[phy_id].enable_completion =3D &completion;
>
>         if (PM8001_CHIP_DISP->fatal_errors(pm8001_ha)) {
>                 /*
> @@ -190,6 +189,7 @@ int pm8001_phy_control(struct asd_sas_phy *sas_phy, e=
num phy_func func,
>                                 rates->maximum_linkrate;
>                 }
>                 if (pm8001_ha->phy[phy_id].phy_state =3D=3D  PHY_LINK_DIS=
ABLE) {
> +                       pm8001_ha->phy[phy_id].enable_completion =3D &com=
pletion;
>                         PM8001_CHIP_DISP->phy_start_req(pm8001_ha, phy_id=
);
>                         wait_for_completion(&completion);
>                 }
> @@ -198,6 +198,7 @@ int pm8001_phy_control(struct asd_sas_phy *sas_phy, e=
num phy_func func,
>                 break;
>         case PHY_FUNC_HARD_RESET:
>                 if (pm8001_ha->phy[phy_id].phy_state =3D=3D PHY_LINK_DISA=
BLE) {
> +                       pm8001_ha->phy[phy_id].enable_completion =3D &com=
pletion;
>                         PM8001_CHIP_DISP->phy_start_req(pm8001_ha, phy_id=
);
>                         wait_for_completion(&completion);
>                 }
> @@ -206,6 +207,7 @@ int pm8001_phy_control(struct asd_sas_phy *sas_phy, e=
num phy_func func,
>                 break;
>         case PHY_FUNC_LINK_RESET:
>                 if (pm8001_ha->phy[phy_id].phy_state =3D=3D PHY_LINK_DISA=
BLE) {
> +                       pm8001_ha->phy[phy_id].enable_completion =3D &com=
pletion;
>                         PM8001_CHIP_DISP->phy_start_req(pm8001_ha, phy_id=
);
>                         wait_for_completion(&completion);
>                 }
> --
> 2.45.2.505.gda0bf45e8d-goog
>

