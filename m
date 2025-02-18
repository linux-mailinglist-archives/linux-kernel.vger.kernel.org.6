Return-Path: <linux-kernel+bounces-519403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD7AA39C72
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD3116F95B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D48125A643;
	Tue, 18 Feb 2025 12:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LufKjvml"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529C818E743;
	Tue, 18 Feb 2025 12:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739882944; cv=none; b=np68FjvYkO/74mlloOEUug1SY4waSj93XGWoNKKCObJuBBM+kdF8DFyBTOe/LiGvy1bYj/ZWbgiy40i2Rhd1H+6i2Q96jBKeXdsN2ODNSzwZ9KLzhXmTPPwMHjUIqSG+jTjT32IzsnjxNtjYBSKzY5cNvkh617zS5H3mbtQnYvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739882944; c=relaxed/simple;
	bh=3MTAPX7BbYroUzgDrT3TI2XCGXe5QTbsIEpvN1L+HL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZKPfHpTYxdMDxQRRzQh9kSakib4mzqmE/2lfCIuePwL+XK9yeWSWOo88CWLLL+g2h7Vyueu9MeNAhIMMGr3UdAYuyi1gLn39eOCHe+wDrfyxxXPgZ2ikWD3DpjQtbfMpW+85ptfvY1bqh7y65u90s+300WPG8UicdjW2Ts43t4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LufKjvml; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4396424d173so54426125e9.0;
        Tue, 18 Feb 2025 04:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739882941; x=1740487741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHMEUUgzJ5Lepuax0T+IdRjsT3yoJrxVgzW4e4ftDcQ=;
        b=LufKjvmlDUVmfLvbIZx+lAUYODeSytD9mQKXxcFDFP8oUuf8jmD/5ssOoiAqKBnaEt
         /cAO1rIP/2294mF9rCyKQGFxl4AXl9HhSE61aQhEjMWFJT7SPN0HqU6G/j2TG9t6Wrak
         kO19wGRrtOUnHzDyU646zQWWqVAFbJqUrP+f5lyzp2nTJ+VJfjC4kwS7mK+nuisJzdFG
         C1HJQdwodtBerH8yNhsKldgmnk8lmtpJD0W+uSKhzi/zIqt1aFbdRb9dhyfuapBnvbaR
         oFxHanqQmiTln0ra3zqqlUg/MzganTwGG2lM183KhlaOl2d9bNtTdKhA/Ixgio71Sev2
         UA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739882941; x=1740487741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHMEUUgzJ5Lepuax0T+IdRjsT3yoJrxVgzW4e4ftDcQ=;
        b=A9GxgLKrKrfjwVh3WEMwxAeWDah+G26/diR1kdhkX4IhhcznFJHwF6cAQiTKotRu+a
         iMFjfKg3BJzPdpG/PXc4SuB5OjfB/Y/OzjtBuCsE42BuOzUN1wDgxEf4FT8Gbs5OptAU
         w3a0F5t9E5IC6ZH7jm0sKZ9kEAgQJ5OKBZ1/FeQnZnLbb620mRjjraAVxkHCzRw/GZnP
         oJ/ChhqrjMk3QlAUpFWrchEMuofhiORwIKjqFmDDVgd3xS93Pg/pM4xa5DgsDjWVlbaC
         7Sx0t2rnCg52saR6bj3hWw18pM3qlBGJ7PtH7F4+9qHCn8PtnyFGkLW+xWqpPtgkKTlu
         TvIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI1V/gr800+022JwuP8Zqd4fqHMpQ7+qxCBrISFTGWkU5rJfY0dLUXjD44foV+yw4muKGlofDr6YsQ@vger.kernel.org, AJvYcCWxiDG9Q2Kdrqw9k4FC/koHCJ8qyktO13pFfLNGiFGaoMDHqCVEAhSllZwLKJ44+9usstdi2jNOb6sH6HG+@vger.kernel.org
X-Gm-Message-State: AOJu0YzcQGsh56iGvzsomZYNseSDOmtDW4SpP2DUotAlMF25sBspLpIg
	+i32ATtNM2J+5yQxZ4KL+eMPcAtngYz59+0NG7xITnTmYWBM0kXcZGfX+KkBl6QtLZBfNnJug6a
	BdDp0b608RTHrXI2QAVe38+tQMvY=
X-Gm-Gg: ASbGnctNFJOwl2yHoKR6u/aOtcd9kA1jzpBfzv4sJwDSjN3ntburJGNu5792bTq4E3m
	hs/L0r9J/wLwx6EI8s2i/48vEwtkMZEWoHWkJc7MsE0gEvLKMevr90M3AiczKSEZpFl0BC2FZgw
	==
X-Google-Smtp-Source: AGHT+IG+4guV9zL2bAZNHMObNNITOjYzmm8gBHf04+Fx5knp80glZYkRGDTbsirq+bKDuplePjSR8kzavUyBoBLNCGo=
X-Received: by 2002:adf:fa08:0:b0:38f:2a99:b377 with SMTP id
 ffacd0b85a97d-38f33f57459mr12091977f8f.53.1739882940549; Tue, 18 Feb 2025
 04:49:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217140910.108175-1-clamor95@gmail.com> <c19bd9b3-86c4-4f1a-beb9-b6aed32b3ef5@suse.de>
In-Reply-To: <c19bd9b3-86c4-4f1a-beb9-b6aed32b3ef5@suse.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 18 Feb 2025 14:48:48 +0200
X-Gm-Features: AWEUYZknhrRerz9466maOIJ-JIcnOjmCvbeJ_Q4ULJO_5cv5VSDkdN2CrbigW9c
Message-ID: <CAPVz0n0WG1Q51SONb4fmkzi4q7Q0sZ_aKSLrLnGboNNya6nO+Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm: bridge: add ssd2825 RGB/DSI bridge support
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Javier Martinez Canillas <javierm@redhat.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 18 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 14:36 Thom=
as Zimmermann <tzimmermann@suse.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> (cc'ing Javier)
>
> Hi
>
> Am 17.02.25 um 15:09 schrieb Svyatoslav Ryhel:
> > Solomon SSD2825 is a RGB to MIPI DSI bridge used in LG Optimus 4D P880
> > and LG Optimus Vu P895
>
> There's a driver for Solomon 13xx displays in drm/solomon. Did you check
> that this new driver isn't just an extension of the existing code?
>

Definitely no, ssd2825 is a RGB to DSI bridge in a pure form. While
13xx as you have said are display controllers family.

> Best regards
> Thomas
>
> >
> > ---
> > Changes on switching from v1 to v2:
> > - added description for clock
> > - removed clock-names
> > - added boundries for hs-zero-delay-ns and hs-prep-delay-ns
> > - added mutex lock for host transfers
> > - converted to atomic ops
> > - get drm_display_mode mode with atomic helpers
> > - parameterized INTERFACE_CTRL_REG_6 configuration
> > - added video mode validation and fixup
> > - removed clock name
> > - switched to devm_regulator_bulk_get_const
> > - added default timings
> > ---
> >
> > Svyatoslav Ryhel (2):
> >    dt-bindings: display: bridge: Document Solomon SSD2825
> >    drm: bridge: Add support for Solomon SSD2825 RGB/DSI bridge
> >
> >   .../display/bridge/solomon,ssd2825.yaml       | 141 +++
> >   drivers/gpu/drm/bridge/Kconfig                |  14 +
> >   drivers/gpu/drm/bridge/Makefile               |   1 +
> >   drivers/gpu/drm/bridge/ssd2825.c              | 824 +++++++++++++++++=
+
> >   4 files changed, 980 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/display/bridge/s=
olomon,ssd2825.yaml
> >   create mode 100644 drivers/gpu/drm/bridge/ssd2825.c
> >
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
>

