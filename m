Return-Path: <linux-kernel+bounces-394877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D34D9BB539
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D771F21EFB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B56B1B6D0B;
	Mon,  4 Nov 2024 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BQtLYRqh"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1855B18BC2C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725253; cv=none; b=k0pp2Rv+rV2/lZOc+sb5KIc/kFHwRafq17q5NEi7kQecbJT5WBuly0wQA7+qJZVx0mKlw69qvk3ek7Ody6f3WSnBT5bXLGtlIXX6I1LIfbnmdBOLRwvXpg4W78QtXCgwUAuEul3vfECa2rpIgTEVbHxY1FUmOCm0Q4k5+5qj24U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725253; c=relaxed/simple;
	bh=JhQ2PWN2Y1EFf7Bbt6XnhgOueYeaz3vhV3MZ8+CoaM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aecLdEsUxOB8N+QgCZm3dJtLADrAnPpI4wfqT2g8lQK2tWrp+dzryRL+G8egV9+5XOhReN79cGZFVAMFowgsIGwugeaPCRs6s6nwSW2erx//puURpIpLVYiu1hhbANdLLBWikkAVHbavVfmmVLe4BHKrcUq7mSq44hWNClyd1lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BQtLYRqh; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539fbe22ac0so4061781e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 05:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730725250; x=1731330050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nWI6Xd/q/LZwmtaLVMw4xyJRrOQePjMO2FUfWARW0Q=;
        b=BQtLYRqh1kfutTaexWkm7NQi+uUkV4bTu7tZ9SuFVSMCx5vUnFDXRsVNoBO6WqEavK
         odGncTYYOoq0iftkLro4CxESxFU8bEvwePfZAocA1FAjvheaaUQzlShEZTm5zlqrVltH
         t6kpCFcBtrYLlesVeN0SHLXvj7zBql3wD88e8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730725250; x=1731330050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nWI6Xd/q/LZwmtaLVMw4xyJRrOQePjMO2FUfWARW0Q=;
        b=XesynBFh94neUDzKbDu2n2muQ2DlqmBVtROlJv4A5eO8NEI0afTPJbDWJHDPaACdvu
         RByNsjKwZN2cwBcuN0yo5eRFvEayJQrMPrlRt/kgZIecnP9WZ5M6awscysrUzYGvCdEd
         Q/BVAYeLiftlPMOfchhvXZKQo0hWuINHQkXAJZ6QgxUJ72kBgWVrRfYR5IkIKwtAOmYO
         mfW2AhX4NGISA9C8SegkYJK5zPEOZnzkwrdh2vFkobAIvn7xEC4BdKsWHknqq6wYkrX1
         EzRlOHD9C571jvaCxv3Ond8M87PZPz4zBJ4bnh+/oPjDRRQq9V4wAVGJpMpFaO9Pj1kF
         5wTg==
X-Forwarded-Encrypted: i=1; AJvYcCWk3HxxuSzg4pXl+yP/sf+lBhth5ErqkjE3eGeewcj4tM435aM+ToXSo8w8iUe2gEqA5f3ZN1yzx0m+IiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRc1d1OHJB8R89APSkbpjOnywcvtOQ37HxaP2pSrdURjjN1X0Q
	/gI0Lq7+C7j5eI2NWtSfVX9A8lIYjIojFmoVBQBF8z2uuZroVAbqQdQhg7Rwar7O/Gk5XNV9NlE
	Nu9GLiB2VwjN74AY3DVPqYPBrLSJ8jQ4z63VL
X-Google-Smtp-Source: AGHT+IEaB8ZZda+xiJN8hKjO+7R4XsS7rVORV17qPKkGoFiz7+eoeVha8v/dIRlM1DAoeMrrYQuRDQrFwr1eS5hM8ts=
X-Received: by 2002:a05:6512:3404:b0:530:ad7d:8957 with SMTP id
 2adb3069b0e04-53b34b36e63mr15028995e87.49.1730725249927; Mon, 04 Nov 2024
 05:00:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030070224.1006331-1-wenst@chromium.org> <20241030070224.1006331-2-wenst@chromium.org>
In-Reply-To: <20241030070224.1006331-2-wenst@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 4 Nov 2024 21:00:39 +0800
Message-ID: <CAGXv+5HVy41qee6kwVUeLV_DfA0=wk2X77kv81rBKAZDGE6mww@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: dts: mediatek: mt8183-kukui-jacuzzi: Drop
 pp3300_panel voltage settings
To: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 3:02=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> The pp3300_panel fixed regulator is just a load switch. It does not have
> any regulating capabilities. Thus having voltage constraints on it is
> wrong.
>
> Remove the voltage constraints.
>
> Fixes: cabc71b08eb5 ("arm64: dts: mt8183: Add kukui-jacuzzi-damu board")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

I see that the other three patches were merged and included in the pull
request, but not this one. Were there any concerns?


ChenYu

> ---
>  arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arc=
h/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> index 783c333107bc..7bbafe926558 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> @@ -35,8 +35,6 @@ pp1800_mipibrdg: pp1800-mipibrdg {
>         pp3300_panel: pp3300-panel {
>                 compatible =3D "regulator-fixed";
>                 regulator-name =3D "pp3300_panel";
> -               regulator-min-microvolt =3D <3300000>;
> -               regulator-max-microvolt =3D <3300000>;
>                 pinctrl-names =3D "default";
>                 pinctrl-0 =3D <&pp3300_panel_pins>;
>
> --
> 2.47.0.163.g1226f6d8fa-goog
>

