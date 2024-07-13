Return-Path: <linux-kernel+bounces-251375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDCA93042A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 09:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350D01F229D3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 07:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FDF282FE;
	Sat, 13 Jul 2024 07:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJiJYT3m"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D68218E20;
	Sat, 13 Jul 2024 07:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720854512; cv=none; b=tXfuBIFYCWZqsaIEQofXKR0sHhgQMnxmev2aY06GebOqnuIfF/LF76+qq+05RrgA2VHESWpCdwp3dp70ac+BQyqrEOAwgZ76AQQo9io7+0rk24/JVW4p/E9BOBFVXoSQvxUqJAmXwQSowL53gBq9JZdQQLYzlujT9iOBBIip20Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720854512; c=relaxed/simple;
	bh=/2Wna6IN8RYaNi0ktowJREiLpfrmcnCXNbJbNaPmRuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1dKBL0gQmYjopOoqhdRlwm0emjs6D0hjNXi5PYtd0lqeGFQJVMbTo2UPVWHkSs6ahEQH5L5aXUWvchUOjkHBichy16I9EfPhiM1Q68ClOz7f45z8ri2PnnwF33XYpK5zey3wxbKoyL3rQWWegj+cBO0A/qWhBfopv1ZUaOwMC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJiJYT3m; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5ce74defe43so109317eaf.2;
        Sat, 13 Jul 2024 00:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720854509; x=1721459309; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fjlpCsYbCH3cdJRtayFHDpxKbTqwk5kyQNPmsXVKhUc=;
        b=OJiJYT3mpYsLZn9TlbQLlIiITbT+Oa1Xv4ecnj63YuGzAQFba7zsbvCKRsKthb6a7f
         LSVBc3B7pBeJgtRa3GIqMM+Oh8t/lybhSP9D4YhiOe/ECVeNZTQ/pMt4TZ33FUsF1xug
         tQE4GUq/Wl2H4ImNMVmlb62w9eNPcqjV/Ty76nKE3iseE5b3iokcpt9AhdSpySYBhatH
         xKDGyIqWpYudwT693d70kRUODoIzAGL8QkjyfrprXNHMC/lTjuE8H0E+g1Jz1k7Bd0MZ
         FUDlCrfQc0cs0JBGAqKeuOpUKYP1BwzYhno76tAHDziz+7eSteEIZNKcg/h4hBXv0h6e
         kTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720854509; x=1721459309;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fjlpCsYbCH3cdJRtayFHDpxKbTqwk5kyQNPmsXVKhUc=;
        b=AxgaEU8J9HRhTW/4h+dj4GTIbU9Bywp+GXDbV6exZyqIXFaPB6ZGuHN6L9zNCw1JTZ
         U2sS4rnuwblrjrxeFSoINbsNyzI/Fr5Y1N53qDQH1bOYZx0T+IWcH6nZXl7oZXT+AFOI
         fb8ilC8V7WVwq6u8jV3qDGdBBCB4jqFXFf4LcEnIfdXuDr+SoWvVM2/zdEYdw9002nvy
         JCGdzt5hXochz8tSr3la65faIHZZC2KyW+GFr4DqwovF0fSNfWlqlgTRXzrHwAk3bYpe
         KImmUyOjpSbLzbjhxH9TiUOyjii8ilSyWI06wMUi/3B9c42tzxd9cIB/lQFg+ejQfnVQ
         CXSw==
X-Forwarded-Encrypted: i=1; AJvYcCX2e5cLJumrhUXAJql2qScFodO8OYn6q+czs25TORhvPu4jPJ/X8hHjbaswIqYttjZ2IEyX3hJqLeI1P3QGxvSuDKrlJDYNyNkNwUyRCnWWPM67J8x3qKnVnVnW/6TkgRVbFMrtuWA3Gw==
X-Gm-Message-State: AOJu0YxfjwYsVGxz25JgbGtbKU2A/aAcRer72+5DD3suH6nhxJrMwsVT
	WR8Yn4m0wDuZo//eVTO79NixwPFYChTxhA17iW60D2uefL8KDkSp5icfMS8FMQuo7q7IQ1c+Jhn
	pD9VuWqrqNQ4PsvARSXcgCzg989I=
X-Google-Smtp-Source: AGHT+IFWVKyYxz5gy1azAb9yamwL6hAatx9DP1QAZFBlOoFzKR7AUcc67ukMdrKD3FBO1YCxpH6HH13DsqYepYUgQqI=
X-Received: by 2002:a05:6870:c6a5:b0:258:42bd:d916 with SMTP id
 586e51a60fabf-25eae7bace2mr12445788fac.14.1720854509337; Sat, 13 Jul 2024
 00:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712164554.1763-1-linux.amoon@gmail.com>
In-Reply-To: <20240712164554.1763-1-linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 13 Jul 2024 12:38:14 +0530
Message-ID: <CANAwSgT=eNVEk4qzcpD3wa=vZ=TOuJDM_Cz61SCWOsFK2nRsQA@mail.gmail.com>
Subject: Re: [PATCH-next v3 1/3] arm64: dts: rockchip: Add missing pinctrl for
 PCIe30x4 node
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jonas,

On Fri, 12 Jul 2024 at 22:16, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Add missing pinctrl settings for PCIe 3.0 x4 clock request and wake
> signals. Each component of PCIe communication have the following control
> signals: PERST, WAKE, CLKREQ, and REFCLK. These signals work to generate
> high-speed signals and communicate with other PCIe devices.
> Used by root complex to endpoint depending on the power state.
>
> PERST is referred to as a fundamental reset. PERST should be held low
> until all the power rails in the system and the reference clock are stable.
> A transition from low to high in this signal usually indicates the
> beginning of link initialization.
>
> WAKE signal is an active-low signal that is used to return the PCIe
> interface to an active state when in a low-power state.
>
> CLKREQ signal is also an active-low signal and is used to request the
> reference clock.
>
> Rename node from 'pcie3' to 'pcie30x4' to align with schematic
> nomenclature.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> V3: use pinctrl local to board
> V2: Update the commit messge to describe the changs.
>     use pinctl group as its pre define in pinctrl dtsi
> ---
>  .../arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> index 966bbc582d89..721e87a3a464 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> @@ -338,7 +338,7 @@ &pcie30phy {
>
>  &pcie3x4 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&pcie3_rst>;
> +       pinctrl-0 = <&pcie30x4_pins>;
>         reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
>         vpcie3v3-supply = <&vcc3v3_pcie30>;
>         status = "okay";
> @@ -377,14 +377,20 @@ pcie2_2_rst: pcie2-2-rst {
>                 };
>         };
>
> -       pcie3 {
> -               pcie3_rst: pcie3-rst {
> -                       rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> -               };
> -
> +       pcie30x4 {
>                 pcie3_vcc3v3_en: pcie3-vcc3v3-en {
>                         rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
>                 };
> +
> +               pcie30x4_pins: pcie30x4-pins {
> +                       rockchip,pins =
> +                               /* PCIE30X4_CLKREQn_M1_L */
> +                               <4 RK_PB4 4 &pcfg_pull_up>,
                            Should -------------^ replace with
RK_FUNC_GPIO ? since its a gpio controlled?
> +                               /* PCIE30X4_PERSTn_M1_L */
> +                               <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>,
> +                               /* PCIE30X4_WAKEn_M1_L */
> +                               <4 RK_PB5 4 &pcfg_pull_down>;
> +               };
>         };
>
Thanks
-Anand

