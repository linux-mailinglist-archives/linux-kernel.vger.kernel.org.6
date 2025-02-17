Return-Path: <linux-kernel+bounces-518210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7373AA38B74
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F1577A4B7D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D62236456;
	Mon, 17 Feb 2025 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="rZjlHNrw"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0D9235BFF
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739817923; cv=none; b=iCZrSg2/bZ6NHB81LwJkdJAfp/tVOjtWQ3tu0SdjvP8ib8N418eLZmHW+MBtN8q4VE5ZJOo74bbl5XF1Sewhy8BBS7GTrttghbi4LwNfRNUYI3q2TOTmmGQKoU9Ve4/h7dSS8ijMXdwBMx+oPr6nmquw2GxmhycgAOfoPz1Eu1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739817923; c=relaxed/simple;
	bh=LzTuepUtd8P/x0Dhdu8adn7QZcKomrDCsoqReLgD7+w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uFkRrcYPCUGTRaw1R0Fu37EoXgbLd7Toy9KpPeP+kdI4EXO/bYCD0FduJZeNEDPWB7RdA+vBLC3IIH4nWG7gd8ZTXebKUUqbC1INqZE1Kqm+PNlS5mWp76K5Knv4ox9UG6ShKcuOy+NCZljE1RBgMhBJgn7d6vDP4Z0mytlxiy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=rZjlHNrw; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e41e17645dso47877086d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1739817920; x=1740422720; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6L6CLEKqcPrRJhrzPfeseJlwds1PXfz2BxfcoLKD2Oc=;
        b=rZjlHNrwBnniP0HnHM9aipkMlrQ7LHVywmUvQl27tDnHcGFoC9epcoF+2JVPhisGDt
         30x0Hn1WNRN3VO683q9o/p93xT7+k0sgTvKtlcFUqqyDFa+tT6w4eaBWqouYgxdnJfU5
         l6NmT2Wvi12pOIA7+sP8D+1rXjSUOaxk0Mbk41+b9uvHgqZ8HFAQaLMxMQEB6vrWz5VI
         lTyVZyjYGhC4Q8pIZh/Zsoc0tnQCRdjXNHsFPZ+VPFWIQsxzjgpxgdnjydtHDfHoXMm2
         XWcPoI6CpCDcXZfKVwZiozUOi9PS4BomavjTPjkusmovkVve+01K36eLarxJ22JLZhrc
         6iYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739817920; x=1740422720;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6L6CLEKqcPrRJhrzPfeseJlwds1PXfz2BxfcoLKD2Oc=;
        b=TIoJkWvN7mVp2ArY/ExkF2GiGB1t+FAgz0OiorcH3Neup4UVhPRB1U3RL7r31o9xk9
         UHeSl6GUfSzNgCuSyKrILlteVyoRaAYLluhGUZftnZEuzAiPlos9Jpe9CI1P2JCKzM3k
         XsKip5dmx2+KdHpCZ031OHav2R80p6LXShjCjglMwhOTCKWpJVZJHj7VIGEGs+eNoHIi
         8FTuNOZqXZkyJJHZ9KnO6y6z5RAOOo+MvYeE2czI6JyHE+bwaZAklMMn0D+SUn3Ssgsu
         DnPGsoCKXA4Zaok82gd4D/vKbyjj0VNoukyEsRIi2TYytu7OB7e4YS+QPHGy6VaLTFoE
         LRdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFke9rm1F2XxcoxM8DVv/nIG7ZKx/CrEbTn1J84LSDSs5BWM1f/YLGzUx/CeKXZSHFwWlsl4Bi/23wB3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrzaIW5dkGhSD5BL19W4q8ae7ry+5u/rrf5qioiPtqnI6MsNDG
	1FbMGCQN9H0yCJ4P0zoXO0SX/yTnj/hs4FYQ15r/bO79G00BN8krPT2hoCJ32pY=
X-Gm-Gg: ASbGncu/yePUL434PkF5RL44nmSStZpID0d25E2VAZnAdwm6jf1lrZLMA4qPP6U3U57
	CqyhaYFnEwHVFheTv9z7QFYJXpjQAAdSpABD4RaefsoB6asVtY8jrAWGokwnrJMhEGgu3DLzd1W
	8hmqwqD6rqkoFq7YPpR1FoC5SwN1ATHoH7lbxnngpDCDq9xEFr+Ui55oQLQwOe9LAAE1pJzZid3
	5ewd9DyUIAVrlmyR6WjQA0yRCThZZaUg4CP8We48r48KS4QL5x26ehL83W63OQxEOpWfqcy5ii7
	wzOW3om+18U3WzuQexxb
X-Google-Smtp-Source: AGHT+IGNdl7vF080sQ0ioTe7+4SN17jK4snwRBjBnucmBNF6nJHjI5dIs2Whm+kD76Bwzk4VXdCbEw==
X-Received: by 2002:a05:6214:1bce:b0:6e6:6711:d7f1 with SMTP id 6a1803df08f44-6e66cc865b6mr166508596d6.8.1739817919179;
        Mon, 17 Feb 2025 10:45:19 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:e976::5ac? ([2606:6d00:11:e976::5ac])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f0bfe304sm14136191cf.55.2025.02.17.10.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 10:45:18 -0800 (PST)
Message-ID: <f257832e823d23c8324a9eaf7890dd4b6d50a6f0.camel@ndufresne.ca>
Subject: Re: [PATCH] media: mediatek: vcodec: Enable HEVC main still picture
 decode
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Nathan Hebert <nhebert@chromium.org>, Yunfei Dong
 <yunfei.dong@mediatek.com>,  Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Mon, 17 Feb 2025 13:45:17 -0500
In-Reply-To: <20250211-enable_hevc_still_picture-v1-1-0c06c0c9add2@chromium.org>
References: 
	<20250211-enable_hevc_still_picture-v1-1-0c06c0c9add2@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Nathan,

Le mardi 11 f=C3=A9vrier 2025 =C3=A0 16:34 -0800, Nathan Hebert a =C3=A9cri=
t=C2=A0:
> Mediatek devices that support HEVC also support the main still picture
> profile, but today, the main still picture profile is excluded.
>=20
> This removes the skip mask for HEVC, and enables the main still
> picture profile decoding.
>=20
> Signed-off-by: Nathan Hebert <nhebert@chromium.org>
> ---
> On Mediatek devices that support HEVC decoding, HEVC Main Still Picture
> profile is also supported by the SOC and firmware. However, this
> capability is turned off in the vcodec driver.
>=20
> This removes the code that disables HEVC Main Still Picture profile
> decoding. Validation of the decoder has been done via V4L2-backed
> Android CTS tests on an MT8196 device.

While its nice to know that you are working on upcoming SoC, we need
confirmation that this is working on all the upstream stateless
decoders supported: 8183, 8186, 8192, 8195. Ideally testing on 8188,
which I can see has merged support without the linux-firmware file to
go with it.

I'll wait for that and Yunfei's ack before picking it. Yunfei, please
fix the situation with 8188 in linux-firmware, and CC me.

regards,
Nicolas

> ---
> =C2=A0.../media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless=
.c=C2=A0=C2=A0 | 2 --
> =C2=A01 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_de=
c_stateless.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_d=
ec_stateless.c
> index afa224da0f41..d873159b9b30 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_state=
less.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_state=
less.c
> @@ -152,8 +152,6 @@ static const struct mtk_stateless_control mtk_statele=
ss_controls[] =3D {
> =C2=A0			.id =3D V4L2_CID_MPEG_VIDEO_HEVC_PROFILE,
> =C2=A0			.def =3D V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN,
> =C2=A0			.max =3D V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10,
> -			.menu_skip_mask =3D
> -				BIT(V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_STILL_PICTURE),
> =C2=A0		},
> =C2=A0		.codec_type =3D V4L2_PIX_FMT_HEVC_SLICE,
> =C2=A0	},
>=20
> ---
> base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
> change-id: 20250211-enable_hevc_still_picture-26b35eb08270
>=20
> Best regards,


