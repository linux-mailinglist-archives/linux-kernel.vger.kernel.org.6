Return-Path: <linux-kernel+bounces-518694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC3CA3935E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9E8188D06A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 06:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C21E1B0F17;
	Tue, 18 Feb 2025 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bdR1YpSJ"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C957C2753FC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 06:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739859603; cv=none; b=K78ZVBsglRmG09GZT9H1tLHKahoSx8Dp/FdQl5RYLVcrJA7YMxLSzUP2tYLCbZRsykpz1Ln6DwfaXzzsvjzL5bW+c1uarc/1F1kANY/juFvMmLYYlm/8oOBoWs25ljgaUjbs8kPEYLa9WK4P8hojk2RhcIcgsbrZUFM9tFSxMGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739859603; c=relaxed/simple;
	bh=OAvB+muy4XgHIVeRXR8FClqOVDakLuMO9E170qfw/iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+822boSvuoycut8u6LZLxePjWwpjx7yu4gQQtfJD00iRsmWNiVitEf4dqocyn0AyB+XxuyW9XH4kLMNY5mqbCHy/d1rDtR9ucmpdLMXyH9KwzPHysWLjnNEVaadduDE86dwH4aPPwCnquGsM1TBh8S55uijV+qS5F223eCwQO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bdR1YpSJ; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86911fd168dso768243241.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 22:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739859600; x=1740464400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xv4n+LUwamiLE41T0SAH0qvuQvjUID2QnZlS05VRF3A=;
        b=bdR1YpSJcWSUxxXA1bZ0si+c4jSxFkD3tluNb/Nbvee9LNSjvoKtE7STHIQ+oCSRVd
         YNh7oDcORH7cvETClfWPx2mEamN1oTT2bNhgj8yKMnAOX8Ev6KSWkBEOGEcum8L5XxOo
         frMSn11VWEgITLSez+fiDkfVHxYY9qq2l1yvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739859600; x=1740464400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xv4n+LUwamiLE41T0SAH0qvuQvjUID2QnZlS05VRF3A=;
        b=m+7ON4N5vwztBpTCHtUqN+dbSlvDyn40g6J/BXgqDaDMWwwaRi/3TbGjokSFvyqAi1
         jTTOfZLeDkosoopQMi/ABwsypnQlWoLJxDIwo3q1ju9jQFEAXAIFp+i9CDlPxraZkwSl
         iGR2NIIasDEP1SjPgFWUFjxcB7gOHnoTkJrWQ4GjIoPLknBADBZZNQ18huq4Rz3caP73
         rq6RbHU5IX62uIAwY5x35B5Dc0FYXsu01rmogM46h3NKC7ncbqL3WGbO/mCTMbZUka59
         7dJ95l+c3yCpn0kGdoIS9Gt0Ajao/fLJif4GJ91PQW9bjhvOW6pf1pBwkm6un/y6QUti
         cazw==
X-Forwarded-Encrypted: i=1; AJvYcCUnB9hwjTfGEUzTPeSPjbvxdXXjAQt+loitSUkc6SyGudtsUgW3lMLbCJaWDd9yZdUM8OixIMBqOyft24s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/NVwIjfVlAPELypYwB1f6lzxRAekHirmyblg27Sc0Tx2awZD7
	P6AoYB3lxirloa7ZaxIjamulR8TpvcN2qe1BTm9tl3gpouZlf2OKH9nb7f6g2zgXVNEWrIy3BFA
	=
X-Gm-Gg: ASbGncvl+Tr/Usd3oCJ6oLpai99Jm0floeBuf5rQOntfb++k33IypWFh1d7zfy9ipPh
	zAxi19Ld0O18YEautdS1JyXEZIPCeXB/jOEiS38LiO6MrS/OG6Zay6OVqFgiFsPchQ0OmSCBLj0
	wnZRJD2GEK9iTRhW4h2vhM7MAXWjUI2f9U40DiyZaC6ecbvDkXCfaW/od1xFDaSQ4b0AmaHAaK+
	F4bUOTpcda68KApFEyhQ4MK1pT7swQiwtXiF5KBPzurHUyEemso6zOvEY44z7LiH8PmdLuug9NZ
	ej5VuaDh1x232iqlGdr9wYW5mtT1PjmSuNPojQungO+xXRoELr4=
X-Google-Smtp-Source: AGHT+IEtqpgrkAUK6wYtCuqiO9Z4gIlUTCU2TFbSYH9pS9KWQlvEJm3Uf8+vzhXvQbIvZO3cA0rVhA==
X-Received: by 2002:a05:6102:4b0d:b0:4ba:eb24:fb02 with SMTP id ada2fe7eead31-4bd3fc818c2mr7827217137.3.1739859600541;
        Mon, 17 Feb 2025 22:20:00 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4bd9ac0c9a3sm1509795137.2.2025.02.17.22.19.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 22:19:59 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-8671441a730so1673038241.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 22:19:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUsZ3P0zhtF2/tPnkHJOc9Aj6fAQYhQQniuZGCkuuPxfFIvM4qgaRukgGf42g4G3xZB5KVf76YVMXwFPjo=@vger.kernel.org
X-Received: by 2002:a05:6102:151d:b0:4bb:5d61:1288 with SMTP id
 ada2fe7eead31-4bd3ff163famr7472440137.23.1739859598960; Mon, 17 Feb 2025
 22:19:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219113411.3999355-1-fshao@chromium.org>
In-Reply-To: <20241219113411.3999355-1-fshao@chromium.org>
From: Fei Shao <fshao@chromium.org>
Date: Tue, 18 Feb 2025 14:19:22 +0800
X-Gmail-Original-Message-ID: <CAC=S1nib8o+4gbVSRXx40_jcCRne4KD5xwEFEHZiaokjask5RA@mail.gmail.com>
X-Gm-Features: AWEUYZmvvAhIhLZdIE8ZnGqrNusNM3AKRBNLuy20n7CpoEBss__hOTAJAkQGCeU
Message-ID: <CAC=S1nib8o+4gbVSRXx40_jcCRne4KD5xwEFEHZiaokjask5RA@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: mtk-socinfo: Restructure SoC attribute information
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 7:34=E2=80=AFPM Fei Shao <fshao@chromium.org> wrote=
:
>
> So far, the MediaTek socinfo driver populates the SoC information as
> follows:
>   - family:  "MediaTek"
>   - machine: "<marketing_name> (<soc_name>)"
>       e.g.,  "Kompanio 1380 (MT8195)"
>   - soc_id:  <null>
>
> This approach has some drawbacks:
> 1.  "soc_id" can be used for showing the SoC name (e.g. "MT8195"), while
>     it's currently unused.
> 2.  The newer socinfo API automatically populates the "machine"
>     attribute with the model name from board DTS if unspecified, which
>     we may want to preserve if possible.
> 3.  "machine" combines the marketing name and SoC name, making it
>     trickier to parse. Ideally, the marketing name and SoC name should
>     be in separate attributes so userspace to utilize them as needed.
> 4.  There's no guarantee that the marketing name will be announced along
>     with the SoC name. If either is undetermined, the current design
>     will result in a malformed "machine" output. This is observed on
>     some newer MediaTek platforms, where the marketing name is still
>     undetermined but the SoC information needs to be settled for device
>     registration and validation before launch.
>
> To address these points, this commit proposes a new theme to display the
> SoC information:
>   - family:  "MediaTek <marketing_name>"
>       e.g.,  "MediaTek Kompanio 1380"
>   - machine: "<dt_model_name>" (auto-populated)
>       e.g.,  "Acer Tomato (rev1) board"
>   - soc_id:  "<soc_name>"
>       e.g.,  "MT8195"
>
> Moreover, if the marketing name is not provided, the driver displays
> "MediaTek" in the "family" attribute instead, consistent with the
> previous behavior.
>
> Restructure the way driver populates the SoC information as described
> above.
>
> Note that Mediatek-based Chromebooks are the primary consumers of this
> socinfo driver, and Google has prepared corresponding userspace changes
> to comply with this update, so the impact to userspace is controlled.
>
> Signed-off-by: Fei Shao <fshao@chromium.org>

Just want to resurface this patch. Should I resend?

Regards,
Fei

> ---
>
>  drivers/soc/mediatek/mtk-socinfo.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-socinfo.c b/drivers/soc/mediatek/mt=
k-socinfo.c
> index 123b12cd2543..b9dbc90d7814 100644
> --- a/drivers/soc/mediatek/mtk-socinfo.c
> +++ b/drivers/soc/mediatek/mtk-socinfo.c
> @@ -62,17 +62,24 @@ static struct socinfo_data socinfo_data_table[] =3D {
>  static int mtk_socinfo_create_socinfo_node(struct mtk_socinfo *mtk_socin=
fop)
>  {
>         struct soc_device_attribute *attrs;
> -       static char machine[30] =3D {0};
> +       struct socinfo_data *data =3D mtk_socinfop->socinfo_data;
>         static const char *soc_manufacturer =3D "MediaTek";
>
>         attrs =3D devm_kzalloc(mtk_socinfop->dev, sizeof(*attrs), GFP_KER=
NEL);
>         if (!attrs)
>                 return -ENOMEM;
>
> -       snprintf(machine, sizeof(machine), "%s (%s)", mtk_socinfop->socin=
fo_data->marketing_name,
> -               mtk_socinfop->socinfo_data->soc_name);
> -       attrs->family =3D soc_manufacturer;
> -       attrs->machine =3D machine;
> +       if (data->marketing_name !=3D NULL && data->marketing_name[0] !=
=3D '\0')
> +               attrs->family =3D devm_kasprintf(mtk_socinfop->dev, GFP_K=
ERNEL, "MediaTek %s",
> +                                              data->marketing_name);
> +       else
> +               attrs->family =3D soc_manufacturer;
> +
> +       attrs->soc_id =3D data->soc_name;
> +       /*
> +        * The "machine" field will be populated automatically with the m=
odel
> +        * name from board DTS (if available).
> +        **/
>
>         mtk_socinfop->soc_dev =3D soc_device_register(attrs);
>         if (IS_ERR(mtk_socinfop->soc_dev))
> --
> 2.47.1.613.gc27f4b7a9f-goog
>

