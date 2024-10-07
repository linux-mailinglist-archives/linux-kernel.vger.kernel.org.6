Return-Path: <linux-kernel+bounces-354243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 355AA993A9E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 00:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB042857E5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35CC18FC7C;
	Mon,  7 Oct 2024 22:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="akxDpjlK"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5451F18E342
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 22:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728341920; cv=none; b=mNGBEtqMcPFQvHiOmMV5HTV03sd6P3UDit5Y+Gc5i91tr5zOZ5weGYDaELERIQ3iJttTJ+Yr1ba/ApPH28FMo5XmYRQuUOs8Ts+RhltWg3iHjaOQ6B1d1UZGQjByouaWy7/OkXDMVvmNwZc/BA6MHtZ5IpFsd9YC98b/089Ss+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728341920; c=relaxed/simple;
	bh=S5d9Hfdc639tZUhBVvL9DJ5PZ2v4N2O8wE1Ly4td4fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EzGXPJC9Mr9PnbgB0AMWBt0GM0+oW1Q+PTIG/hFpG1/VGK3De7T2NCtpTjFDWKuUyaVuu0MwpGrxtLSXr941BTAfrOrX2gNboNVtDTS37UxxcEXyl4WNFMXnL8+ohj/g9NzA2Pv020jWVCefIrj4V/m+IyIa60UR6ktbAv76kec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=akxDpjlK; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fadb636abaso48842651fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 15:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728341914; x=1728946714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9IXdCfaNtqS6OVy5IGIFP7SGWVPgo6mw3WGn70+14M=;
        b=akxDpjlKfUYuvq6UKAbyDbSaSXFBoO7vyeGpSseps6oS5a3TVwgxFptRM+5+iMiQ4X
         Xc0tp9Q62f5kzcPd2H1Mux/UCztgYpRKtVEo+5Wjt9+8dnJuDv/PFTaEdFXzu9l7siAN
         3wTVZkisSYIlXYkbHr6izGY3k1i0neeoI8Tik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728341914; x=1728946714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9IXdCfaNtqS6OVy5IGIFP7SGWVPgo6mw3WGn70+14M=;
        b=WcgoMI1BIRXhmLAJpw6HO3afbbltl7JMXzLSNFBMAx66yDW8u0lKebpgSX63K0q03c
         Lj5SkzvKIKzXWnZM0cs5PnxyC+d41F+14KWb0a2dhYLC2rtdehgPBVvQ2k2yJbFcYAf9
         gANYD3WIayYSeWI6LpeYq6bOwQ6iZNZZ87P6bTO+s28hK0i2KTrX9aUUBJrjVfXoPqaS
         T9Y9MhYTaLue3viEzJDAxb6WAa6acwFGlkDfr1nyD48+hg7hwUeV+6+eThc+NyaJMTTb
         2VGl+I94OI4SeEoL2z8O+jWGNSmtpzjJma0uI9SWaQK9BNd/kf7CKpUA6KqD340k68qY
         6QLw==
X-Forwarded-Encrypted: i=1; AJvYcCVPRWFwzrSO9JRjB449XhzvB2+FE1Ol1e8Ik+F5rGm8k1gX4ct/DUQMhrp9dnWX49S0egRPg7jWyq7rMR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys0SOJ3rwS52uBsKB32ao/wJDh/Ex2QlvlUXE/C7n26AHm7vPi
	u8Z6CCuBvwIRocpCCHFcntBjquEcN9fGGG2uYnp0tXP6PrMVqKfxw9CKi180fzz5ujut3YmQpQ1
	8bw==
X-Google-Smtp-Source: AGHT+IH2bvAFnN+14r7Fb9N46wR2U/bZrbN0+gj8ZPqWhVtMEr2wSyMWuwDTPbg3PO2grynd3LMn9g==
X-Received: by 2002:a05:651c:2226:b0:2f7:6812:d0ae with SMTP id 38308e7fff4ca-2faf3c1cd82mr62911261fa.13.1728341913650;
        Mon, 07 Oct 2024 15:58:33 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faf9b3afcfsm9549981fa.135.2024.10.07.15.58.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 15:58:32 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5398e3f43f3so5742225e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 15:58:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUh7ow8rgMsj5ciaDnNYhBAEC7xnS/zDMWoAqn2Lo4xf2qo1ZEeE3agIDXLyk4+3GuDgXfF/AsEdX/iWBA=@vger.kernel.org
X-Received: by 2002:a05:6512:3b8e:b0:536:5646:251e with SMTP id
 2adb3069b0e04-539ab84e0b8mr6613892e87.10.1728341911337; Mon, 07 Oct 2024
 15:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007201356.10430-1-alex.vinarskis@gmail.com>
In-Reply-To: <20241007201356.10430-1-alex.vinarskis@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 7 Oct 2024 15:58:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UsLHQ5KkOekMntQ1GK=TFoGKN9kaMcLnUmXBLtrmP4qA@mail.gmail.com>
Message-ID: <CAD=FV=UsLHQ5KkOekMntQ1GK=TFoGKN9kaMcLnUmXBLtrmP4qA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] drm/edp-panel: Add panels used by Dell XPS 13 9345
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Bryan.Kemp@dell.com, tudor.laurentiu.oss@gmail.com, 
	Peter de Kraker <peterdekraker@umito.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 7, 2024 at 1:14=E2=80=AFPM Aleksandrs Vinarskis
<alex.vinarskis@gmail.com> wrote:
>
> Introduce low-res IPS and OLED panels for mentioned device.
>
> SHP panel's timings were picked experimentally, without this patch or wit=
h
> `delay_200_500_e50` panel sometimes fails to boot/stays black on startup.
>
> LGD panel's timings were copied from other LGD panels and tested to be
> working.
>
> Particular laptop also comes in high-res IPS variant, which unfortunately
> I do not have access to verify.
>
> Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> Tested-by: Peter de Kraker <peterdekraker@umito.nl>

Your signed-off-by should be _below_ Peter's Tested-by. That means
that you're the one that signed-off on the fact that Peter tested
this.

> ---
>  drivers/gpu/drm/panel/panel-edp.c | 2 ++
>  1 file changed, 2 insertions(+)

This looks OK to me. I've been requesting people include the RAW EDID
of panels that they add in the commit message, though. Could you do
that and send a v2? Also: note that since I didn't see Peter provide
his Tested-by himself, I'd probably wait a little longer before
landing to give him a chance to object.

-Doug

