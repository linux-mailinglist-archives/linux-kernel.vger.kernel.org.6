Return-Path: <linux-kernel+bounces-347430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C262898D29B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AD12B21830
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C42520011E;
	Wed,  2 Oct 2024 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qz2O2qCd"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC2119750B
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 11:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727870297; cv=none; b=RsiUlJzgZiZvMjDvzGyBE1Gv7E2w59Z0duQrQQ0XBEOJjUbRD3NRmLFPBkLXp8VNzonywy4/Ug4CIDTAFG3ESuBkDOvjfcxe/odp5+aFQT7YyUwWAVVKgfI0NsKjzGXa3xbTRgBbbHawDQ3COw6jjSK6Q01acB5hk3Lq5YEl4xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727870297; c=relaxed/simple;
	bh=fL9v4AHZ/INp8TeWxKwvfGoMuAaVHhqmCcCgRa9MWnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pviuYGS7xchrQuDNUSZUy5SKRIN6jtCNBmUVbYNJlCILGkyBUUDYOLb5102TmzMAFKcZRLhgkyxLBAbJNVABkKZsBWXhIygRdCoj64S0bOsgOHgG+Nbr1mT+G0Kjwfgo++RCGAflFpmqeDzesKkqzIyIUcq7njcX5kUDrlKSbHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Qz2O2qCd; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-50958a19485so1128588e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 04:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727870295; x=1728475095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fL9v4AHZ/INp8TeWxKwvfGoMuAaVHhqmCcCgRa9MWnA=;
        b=Qz2O2qCd7gvJp6EBYFjqWQRfi94pvumbK0aDJevYCivV3uAf6s4H01xqxZRYdiBXDR
         GyS4xFFzLvX6zfyZUfM7umX/ClCbl7pLp0iuy5wVDaNjDenCkS6zIszrMApkDJbrULVs
         mQnwf1jgvTdVKCImu9616vpanepbjnfJLK/kI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727870295; x=1728475095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fL9v4AHZ/INp8TeWxKwvfGoMuAaVHhqmCcCgRa9MWnA=;
        b=iRFtUrtc7IT3Hk/0pMI5yGGdXuQrKnbxw/9tHlfppkGBhJElsfH4d7VpzYSD/Twi8R
         2aUythzHgnUf9XwBCM7MeuMLYnWh+8Zzc4cW8ltSQGkuMHW+FpeK0f7dvljN99GfexcW
         Ac+4mYlrmotqDflTIGbveqS4zEcEH4hxc1kcVIewMRj7RggmMsuBBMKL6fyI/T9ITsf2
         FC12jUfoWB7ykRiE4fNE7bKr+g5oYXs9xnEOK+00zf0Ex95l8vJVmgXtOrap73ze5MaY
         MU/fATZVtSw6zHRSrncFJVTZ/NHmWcD8K+Qmh+NP7VY98P8rOryUXlxEcICMh0BTqcRx
         d7Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWD4wYjv4rMUwYnASk+R9Hy9JRH1x3MFYylW3TcVZvAHiCBKA70RlpMUBVdO7vPgOJeJr5ozkkuoUy++oI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV+3C+osk4r/Phf6nWh66cDLNusRdx4HdaOcU2i/XJUx7VWALJ
	HprN0iiwYVREnCJfJocYOV3Hfdq9dHQTHnOPtKa7ilh0W2SoLe3DZEH/v08W5mwpva88T2SiGQn
	E5w==
X-Google-Smtp-Source: AGHT+IHoLy9nfrqHX32V57/NTzD3PP06qLvKebd92J/up/0QZF9sPetejPv/gIzv/UMFsWNSWTIMgw==
X-Received: by 2002:a05:6122:7ce:b0:50c:4707:df0 with SMTP id 71dfb90a1353d-50c5816477cmr2301271e0c.5.1727870294817;
        Wed, 02 Oct 2024 04:58:14 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50790d1eb2esm1153185e0c.30.2024.10.02.04.58.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 04:58:14 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-84f1c36c31cso273249241.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 04:58:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUX/EoVeAkgbhCXDZHeqgayPYgiK7pClfpuD4RY6B1pzGAidjlctIxIZcGiWcqKkf44aJXEC2Zf9Ftg5+A=@vger.kernel.org
X-Received: by 2002:a05:6102:3912:b0:492:9e3a:9f48 with SMTP id
 ada2fe7eead31-4a3e68078a7mr1610494137.2.1727870293454; Wed, 02 Oct 2024
 04:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001113052.3124869-1-fshao@chromium.org> <20241001113052.3124869-4-fshao@chromium.org>
 <r22z7eehmuprvq67gxekqwsah2mcobfsyhn7xzyyh2gdtjegve@zl32uljxrilx>
In-Reply-To: <r22z7eehmuprvq67gxekqwsah2mcobfsyhn7xzyyh2gdtjegve@zl32uljxrilx>
From: Fei Shao <fshao@chromium.org>
Date: Wed, 2 Oct 2024 19:57:35 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhF7CiiGaNASiqYw4Av7MQfLJsUa1HrYsx9n4D2sAP7Gg@mail.gmail.com>
Message-ID: <CAC=S1nhF7CiiGaNASiqYw4Av7MQfLJsUa1HrYsx9n4D2sAP7Gg@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: media: mediatek,jpeg: Relax IOMMU max
 item count
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bin Liu <bin.liu@mediatek.com>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Rob Herring <robh@kernel.org>, Xia Jiang <xia.jiang@mediatek.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 2:16=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Tue, Oct 01, 2024 at 07:27:21PM +0800, Fei Shao wrote:
> > On MediaTek platforms with Multimedia MMU (M4U), a multimedia hardware
> > can be assigned with a local arbiter (LARB) which has a maximum of 32
> > ports for MediaTek's IOMMU infrastructure. That means there can be at
> > most 32 items in the iommus property in theory.
> >
> > Instead of relaxing the max item count every time a newly introduced
> > device tree hits the limit, bump the number to 32 as an one-time effort=
.
> >
> > On the other hand, all existing and foreseeable JPEG decoder nodes at
> > this point have at least 2 IOMMUs, so set minItems to 2 accordingly.
> >
> > Signed-off-by: Fei Shao <fshao@chromium.org>
> > ---
> > It's not in the upstream tree yet, but the upcoming MT8188 DT will have
> > 6 IOMMUs in its JPEG decoder. This patch is to pave the way for that.
> >
> > Changes in v2:
> > New patch.
> >
>
> I do not see any user of this in this patchset.
>

Sorry, I was doing more checks before sending out that series.
The particular patch depending on this is now available as
https://lore.kernel.org/all/20241002114614.847553-6-fshao@chromium.org/

Regards,
Fei

