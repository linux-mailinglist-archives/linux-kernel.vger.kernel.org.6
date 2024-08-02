Return-Path: <linux-kernel+bounces-272756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3BB9460A9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B881B22CE6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DACEAD5;
	Fri,  2 Aug 2024 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R5ITO3S2"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FEA175D20
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722613184; cv=none; b=QYE0GFRY/MhJ53V4JzViLbCVqAn5Xs7pOp3YgNRAAYBMnlU9MyUbaK4zrvjlVmDJa/vuJbd+4CO2arxBYBE1j7jFKCtAL/8tiOenksu4t/jDX7A57fET1ffWSZNloYWHce0liZ5llYd3JsfIVnKr2QQzF493ZPZ8A9tNUlBWBqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722613184; c=relaxed/simple;
	bh=PboGmkdjZNT1whciN4V7Y8gf6Kprem+GQuOewhF51TQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gfe9vH2hYeww7lPc8ajS7Avo02xiORyuoiSGq3nWO7NJiDeG1ovEU/zNTQd4AFhD54EEUDhzPHXyGW4Tkd3GQTGOTApkfhPtxeEewUDRN5TfjpYOmgkpYmGjFBZ+on/+oB+rjR9LBRgC4OTnJEwe6k61maPlVN99EMbtaMavXek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R5ITO3S2; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b79293a858so40969256d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 08:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722613178; x=1723217978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRFINZgqxXlEvcRo25F5fVmBGHphu79yWWl1LkUSdVo=;
        b=R5ITO3S2WanRCrTfVKR3kUtypdRP5mDtIq2+JFpc8bH0BRw/qdXU5In7C4SH3XRKpU
         gbFAlW/LAtc8tAFwhUM7wK6Y8LU/trkK3n+PCYv4SkwTEK5R2NmqKTy3UZpg54lvKMz9
         /sfeBSxh4n306GeCSgEaLzfbCg07b2LEBd0kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722613178; x=1723217978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRFINZgqxXlEvcRo25F5fVmBGHphu79yWWl1LkUSdVo=;
        b=t0h5cR6e64/KGLGTtQL6rE+HB3OS4d9I2TmsMMDzv3aRX7+D0t+UEqQpERPZY0kU3Y
         XQH0U3w4B284Wtr9rznxgppTgQMghWt1D7J68ar8ErcT74Ro7brjC72MkTkeGULGJPVk
         HzlrDKNLeF9rZ1VzFiKg4othew7nkIldFw9aoIu0B8R64XjBjXbYv1y+sgzm7mUmtW0N
         +/DwRT7e9s+cSB6kc+OUWZ5By8gUuNZmKg9HqNpbbdMyeC+9R2s1841ci5E48SoDgnmx
         nvrSjH7RvZme0SKx5vbNSXChnh+ck2N3ywf9PahqKF7hHPH0+R7vB4MbUfRPtbZMc/qG
         3hYg==
X-Gm-Message-State: AOJu0Yw8/+fWKXYYrWbE4piGqdzB2jFg1Lz31e3iiX81es8URXkGbLPc
	DD0HQmCthXFT3FMMea15VmYMUvcLf0w2z1XZ3Dhj0/vYpKq9LLhcEb+xR+h77GVR7lJrd/xe9No
	=
X-Google-Smtp-Source: AGHT+IFDIm71X7SiMp8zV69EvPmSw1MLnfdAGODQCbV75y/Dk9DKd7MQNSCqsTiSIGF1us33L7nUGg==
X-Received: by 2002:a05:6214:451a:b0:6b5:485:ea30 with SMTP id 6a1803df08f44-6bb983a91cbmr50367806d6.3.1722613178467;
        Fri, 02 Aug 2024 08:39:38 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c7b5e97sm7878346d6.66.2024.08.02.08.39.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 08:39:37 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-44fee2bfd28so1151571cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 08:39:37 -0700 (PDT)
X-Received: by 2002:ac8:7f08:0:b0:447:dbac:facd with SMTP id
 d75a77b69052e-4518c7e5c44mr2509491cf.24.1722613176824; Fri, 02 Aug 2024
 08:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802070602.154201-1-terry_hsiao@compal.corp-partner.google.com>
In-Reply-To: <20240802070602.154201-1-terry_hsiao@compal.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 2 Aug 2024 08:39:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XMmxXY4REZiUTsZA3KZBrUdSzi5DCwuWz5F-9KLZA4eg@mail.gmail.com>
Message-ID: <CAD=FV=XMmxXY4REZiUTsZA3KZBrUdSzi5DCwuWz5F-9KLZA4eg@mail.gmail.com>
Subject: Re: [PATCH v1] drm/panel-edp: Fix HKC MB116AN01 name
To: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
Cc: linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 2, 2024 at 12:06=E2=80=AFAM Terry Hsiao
<terry_hsiao@compal.corp-partner.google.com> wrote:
>
> Rename HKC MB116AN01 from Unknown to MB116AN01
>
> Signed-off-by: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 2733366b02b0..7183df267777 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1948,7 +1948,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('C', 'S', 'W', 0x1104, &delay_200_500_e50, "MNB60=
1LS1-4"),
>
>         EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d51, &delay_200_500_e200, "Unkn=
own"),
> -       EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d5b, &delay_200_500_e200, "Unkn=
own"),
> +       EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d5b, &delay_200_500_e200, "MB11=
6AN01"),

Nice!

Reviewed-by: Douglas Anderson <dianders@chromium.org>

...and pushed to drm-misc-next:

[1/1] drm/panel-edp: Fix HKC MB116AN01 name
      commit: 21e97d3ca814ea59d5ddb6a734125bd006b66a60

