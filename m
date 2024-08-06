Return-Path: <linux-kernel+bounces-276885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2428794998E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8025282EF7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B5F15B137;
	Tue,  6 Aug 2024 20:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="b8pYLhvk"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DAF77F08
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722977394; cv=none; b=db9yWkBsPuGeGSVboIsDH9KHnA0trs0U5h3Qgv3lTn7NMLVriNr25qBylRrHm5J25LmyW5KG4oYDKgKpDvGdTpTv6oc4hxTHtxqGtpGcxU3EBfyjbZKTw91HY2gv/UKK5/rzUCtT+dYGuqzzyOs76KwmKWphvDzP0V0BH2OMfPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722977394; c=relaxed/simple;
	bh=LAOwpjfaOTd9j79Xq3XM0C4JVgaSGIPP9nm5nXzl8No=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPD8hDLn2LpLK9uQYwbBDATqkRtwdPAOFcuX2FP1hKmnf4k8MM6/HoQOpizj9xX8+LIsRq1/sX3yLD5/bz6FAyIui9zh3VLtZUXeA7ee/sPke/QgmrbVF+jaS54+ottUhzkLoIlUEui8Q6Iv9uu9Ddvtvexazw5hi8PH72jgGKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=b8pYLhvk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc56fd4de1so1895205ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 13:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1722977392; x=1723582192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOb7yzxJR8v2Ep13bBP5suT1y7mTdVA2Wy56PSiUs5w=;
        b=b8pYLhvkfesniuuqhHdU3sIJon4RDgoHA1u1P1Bm1uwW3XO/Pg/wzt7INGwVRW6Dwj
         pwVsk8ViNT4RG74XJUjayGZHJqcqGDiSesrmLIGqc9urbUmmIrwskXm629tnfWZRdbeA
         SPMZjSrAPbmiFgU5EC8fPVgoOH5LQziumU7U20kb//1UzRhmkj4IixbJsYsVHmrlfysl
         eMa9MdXp3s0BLok0Q3OUVBLRhqHbJhiWMU300Q+sB5snPKfkDShQ8TrjguNnYo8QpETe
         +rYBxhKAI013FJt/IH1mvBrFuzgWg0E+4iSVc+uK9Iwstr7Qwbb78/F9xkC1TbBrIjQd
         wfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722977392; x=1723582192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOb7yzxJR8v2Ep13bBP5suT1y7mTdVA2Wy56PSiUs5w=;
        b=VQew23bN06Pl8e4ETyMuDS+6Mhf0sraoYPV0hrJB8KX4VM1opaTWzJBWdoiN3VT4HM
         Gw6/v9C63wntCcbMA7dVtKHPqOzOzLPwlAKsMKsZ1l+sNLO89p1jINpa6xCSM2OKPQwa
         G6w743jKMp8jW+nQ5gpSzVKjQBhBa5o5s6GT3yopAHf50y+6mjcyS7jefhsAGIth+h4V
         YgeF4EPbrmJcIPX9qunpT3f7TtrB3wPCWDhM7kUF2azXhfQ6h4/UKu2oQBUVBBS23Djh
         c4ZyRaSGjCL8lweMA8uD6hFqQDUAPKYnJGlznxUeuDZwhTjiEFBk0pEpzlUM2yJQfRwI
         wVeA==
X-Forwarded-Encrypted: i=1; AJvYcCVMQFBGv4NnfWCKo6WNEaqTJYSmuPsQabDqCVO01ttlF+WPx0biQY5+VLy2LkK6q5JsPs3r8F8XlB+xqca6VQYtlBFRYU0rRuOJpXjG
X-Gm-Message-State: AOJu0Yz5PUHFpMrlEeeH2nHp4K8Iose4kzLZ8wSSbP33UZQOlMbAYwH8
	jyL590ztbWysbOZI8K5B6w2WAcUZRO/vHQabxxzmOpb4BqtdeFgjzzPcvjv3t0Eh5irW3z/KvsE
	ognjjjrQYPcKeQLu9Qz9FILfQyP8=
X-Google-Smtp-Source: AGHT+IEWfPRU2iaveYmuat0ybCTueo7tRCzgALc58m0y0WIi4uI64eQxtPbB6Cb9+AleElQR9RrKgLFpgvj4b6HwZRI=
X-Received: by 2002:a17:902:ec86:b0:1ff:39d7:a1c4 with SMTP id
 d9443c01a7336-2008552d030mr595535ad.25.1722977391739; Tue, 06 Aug 2024
 13:49:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730125023.710237-1-jbrunet@baylibre.com> <20240730125023.710237-6-jbrunet@baylibre.com>
In-Reply-To: <20240730125023.710237-6-jbrunet@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 6 Aug 2024 22:49:40 +0200
Message-ID: <CAFBinCCvWFCCvb9gPvv0-eudG=iuKROk5rPSiorKTnHcToDfTQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] drm/meson: dw-hdmi: split resets out of hw init.
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Kevin Hilman <khilman@baylibre.com>, dri-devel@lists.freedesktop.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jerome,

On Tue, Jul 30, 2024 at 2:50=E2=80=AFPM Jerome Brunet <jbrunet@baylibre.com=
> wrote:
>
> This prepares the migration to regmap usage.
>
> To properly setup regmap, the APB needs to be in working order.
> This is easier handled if the resets are not mixed with hw init.
>
> More checks are required to determine if the resets are needed
> on resume or not. Add a note for this.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_dw_hdmi.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meso=
n/meson_dw_hdmi.c
> index 5cd3264ab874..47aa3e184e98 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -581,11 +581,6 @@ static void meson_dw_hdmi_init(struct meson_dw_hdmi =
*meson_dw_hdmi)
>         /* Bring HDMITX MEM output of power down */
>         regmap_update_bits(priv->hhi, HHI_MEM_PD_REG0, 0xff << 8, 0);
>
> -       /* Reset HDMITX APB & TX & PHY */
> -       reset_control_reset(meson_dw_hdmi->hdmitx_apb);
> -       reset_control_reset(meson_dw_hdmi->hdmitx_ctrl);
> -       reset_control_reset(meson_dw_hdmi->hdmitx_phy);
> -
>         /* Enable APB3 fail on error */
>         if (!meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
>                 writel_bits_relaxed(BIT(15), BIT(15),
> @@ -675,6 +670,10 @@ static int meson_dw_hdmi_bind(struct device *dev, st=
ruct device *master,
>                 return PTR_ERR(meson_dw_hdmi->hdmitx_phy);
>         }
>
> +       reset_control_reset(meson_dw_hdmi->hdmitx_apb);
> +       reset_control_reset(meson_dw_hdmi->hdmitx_ctrl);
> +       reset_control_reset(meson_dw_hdmi->hdmitx_phy);
The old out of tree vendor driver [0] enables the "isfr" and "iahb"
(in P_HHI_HDMI_CLK_CNTL and P_HHI_GCLK_MPEG2) clocks before triggering
the resets.
Previously meson_dw_hdmi's behavior was identical as it enabled the
clocks in meson_dw_hdmi_bind() and only later triggered the resets.

I'm totally fine with moving the resets to meson_dw_hdmi_bind() but I
think it should happen after devm_clk_bulk_get_all_enable() has been
called (to keep the order and thus avoid side-effects that we don't
know about yet).

Also out of curiosity: are you planning to convert the driver to use
devm_reset_control_bulk_get_exclusive()?


Best regards,
Martin


[0] https://github.com/endlessm/linux-s905x/blob/master/drivers/amlogic/hdm=
i/hdmi_tx_20/hw/hdmi_tx_hw.c#L470

