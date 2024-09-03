Return-Path: <linux-kernel+bounces-313584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 521C896A743
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DECB7B22B10
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162FD18F2CF;
	Tue,  3 Sep 2024 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AR8qg2oU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E441D5CF4
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391192; cv=none; b=ihIgV/IvUQE2yFXCVER1ISdOCq6fkUek7+da7bXyDbDHjtZrWjH4VgGS3FRINp1ozuN5H4yY0ToVGoYi5MYvp4hXfftplOKr1H3IrT8Ry6MIZSypbyxBrauPnVOwAOvBDAmoLdqmoE3vL7+3BZjbtShuusmLFfmRiAiFrjqkXP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391192; c=relaxed/simple;
	bh=KqQE3iCy7S3bFdUawYBf51xOtDYqglawuE1j3xjb2Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQe3hkqMBlavgNSEVgbzDQvp2jEpdxpew95rMvct3s9zvBuqN1qCJlHIMcaMPBlEE+p1h0GVZb5m+2w56MmfJRQgZ2mxVNKnM1nNZmn+IaL0vAa4vpjndQdwjqqUsUBkVsxEX+6HdDaMavC1bx9tpBW7Cq8MXAJRvYtvNNObRN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AR8qg2oU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E1BC4CEC5
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 19:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725391192;
	bh=KqQE3iCy7S3bFdUawYBf51xOtDYqglawuE1j3xjb2Iw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AR8qg2oUbWcbxrnqfbP00Cl27m7+NaU4Z4M9ALEjxqtVia6hg6EJvBRm1jXaOJNXf
	 N4xbYzgYjMdX2oBRva4ZYuiFAyCe07hF1JIY9eu4vrMKrDMLdI6R9BTRcNS9jj46HW
	 I1ik4iPkFxOis5/RgsnLihR4eVJ3Fo8SKP/JxMZiA6F80yoDGdam5ZWH0NWsXOPtt4
	 Vz1iLnjW2FoE3a+uIWtpD9SqYIdzHo983xlYPEqzcECXxJDBkGSXCzR1LmxH9PNp+D
	 zenkQCdRpbMEBJyWcSBOfw1/pKnBihUJ8njwiyHPTskyBpSyxX/64XJ0fbQ+Bb2jkV
	 rIw/ZavbuIPUw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53349d3071eso7491452e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 12:19:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7dgpWZ8XpZ1b3sGbj5JY/cr0HyxdGp4eVYh0Z2wC1GwG+6uRPdzKZfvshY56K+msHvrvdz0iDK6G/aKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2e4SfUAOXnYUHGHETVnaMWtLgP+7hpeC7DB4eadXkNgd9kTsY
	blQUoPneNyNcxWZ4m8iRKx5TlRlmmRJZsk9DkFpOhJXBg2nc728q62yjJorqaB3RTTFqQe32Q2v
	EDGncrp2PuhFzSNbVSFX5lZU7iQ==
X-Google-Smtp-Source: AGHT+IGu8zU7mK4faIuJr3BtHKdZbZYxXscd1afke7A7tMmPBPXatjZnrJ1uoa5WM9CxkZQJTeBZA3Q0dpVPjkk8DtQ=
X-Received: by 2002:a05:6512:3c81:b0:52c:e012:efad with SMTP id
 2adb3069b0e04-53546af9ffdmr10588452e87.12.1725391190502; Tue, 03 Sep 2024
 12:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731191312.1710417-12-robh@kernel.org>
In-Reply-To: <20240731191312.1710417-12-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 3 Sep 2024 14:19:38 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKvA0Uw7uqpmdMP7Z4mL3Qsmay5Fqb4M97s=QsBW_Nxyg@mail.gmail.com>
Message-ID: <CAL_JsqKvA0Uw7uqpmdMP7Z4mL3Qsmay5Fqb4M97s=QsBW_Nxyg@mail.gmail.com>
Subject: Re: [PATCH] drm: vc4: Use of_property_present()
To: Maxime Ripard <mripard@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 2:13=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
> Use of_property_present() to test for property presence rather than
> of_find_property(). This is part of a larger effort to remove callers
> of of_find_property() and similar functions. of_find_property() leaks
> the DT struct property and data pointers which is a problem for
> dynamically allocated nodes which may be freed.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Ping!

>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdm=
i.c
> index d57c4a5948c8..049de06460d5 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -2211,7 +2211,7 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4=
_hdmi)
>         struct device *dev =3D &vc4_hdmi->pdev->dev;
>         struct platform_device *codec_pdev;
>         const __be32 *addr;
> -       int index, len;
> +       int index;
>         int ret;
>
>         /*
> @@ -2234,7 +2234,7 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4=
_hdmi)
>         BUILD_BUG_ON(offsetof(struct vc4_hdmi_audio, card) !=3D 0);
>         BUILD_BUG_ON(offsetof(struct vc4_hdmi, audio) !=3D 0);
>
> -       if (!of_find_property(dev->of_node, "dmas", &len) || !len) {
> +       if (!of_property_present(dev->of_node, "dmas")) {
>                 dev_warn(dev,
>                          "'dmas' DT property is missing or empty, no HDMI=
 audio\n");
>                 return 0;
> --
> 2.43.0
>

