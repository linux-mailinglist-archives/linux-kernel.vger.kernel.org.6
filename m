Return-Path: <linux-kernel+bounces-394916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0548C9BB5E5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6FF2831AF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2300822066;
	Mon,  4 Nov 2024 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxiNDfJi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B63222339;
	Mon,  4 Nov 2024 13:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726702; cv=none; b=eTVdrWVNNXpntcoHOYKAlWgt1jEiBCc0L1E0LwMepCy6izuBXaeYumGC5gcl0fbqAkn71ZourgWOYmENywoyJxKOAqsuVpa5sJN5CbaEAEr+p90SxvkwLBM+vAKPnKfI0jjTDd08MigbRclgA51aFghJYCCudKh+2+7AaeUT7b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726702; c=relaxed/simple;
	bh=Doo9m3wIIEWg5JXjG0Xv9k7ZyZpGgwIIe+URnSMqyQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbF7x5JJwQLv/8rx1DxsFo2ltDgfpFDJW2WaLNe0r18OeNz5ryoBSqa3tybD6EBqjPXAQkAGV+l/L+Y+D6AZfxk5Cp5Tl+EXXBrb/lrGaoJQYVqiUYcvOW9svdDq4CEIbLx88RqsfeXNspfC3uh62YSlC8zCR1IgAahLf7H6nCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxiNDfJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0FCC4CED1;
	Mon,  4 Nov 2024 13:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730726702;
	bh=Doo9m3wIIEWg5JXjG0Xv9k7ZyZpGgwIIe+URnSMqyQo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JxiNDfJiSa8dfcOdfPG0HHovIxGuUgLAAno0QrHlR+zmLKPUfBbsMK0UjEiZvaTHX
	 YPzYJm/jHpZDY0FjzTYvvpn5adJF0fc5ZuLrjUvSApzNF6v/GO56Uy/7ZTzKzDifJ/
	 RTAo/AtzQVM7d4jsN2assliYHV9sE3dK4qWZGyNee3pOSG2dpgzCJMG+1+LmLyJBOV
	 GoZZ3G7eYpYl+3kfdDjS8XfmtWoRfevO38wFlo4gbzXcd9G2SN2lAY24OJD+AibfRx
	 nr9SpSJAVIZWO2Lji9V0vdg0+jhZs8RMzIOzKE+/1MnzGPQQIsZFMP91i4mr1bkcER
	 BEKGTYX6q0I9w==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e3c3da5bcdso38402097b3.2;
        Mon, 04 Nov 2024 05:25:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZRufqQCSh3GyWe4I5eRcl3JwLA5+YK8PviErFWtL38myKC/jPCW0UHGPpVaLxpWkXR34DlqjookRjxSyJ@vger.kernel.org, AJvYcCWKYXzrkh3LTQDrzjAczf3rhd+/mWxpEIg1andVXJveNrl4pxGjN88YOLS+5TL/LP94uSDHeydssGWL@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3F7AaXmlAF0itIdq3LmfQAVyarb8e30AuHuFfITLnomk1jLqK
	jmqPd0QXaakA0b52sObcJlnTAGvtJdmecPTH5OYuIWhz2v/YtdeiS2bQF6JAfyAeOh9ayiP7Yik
	fldMWPEH0vuGulaRMCS/Hi46t1g==
X-Google-Smtp-Source: AGHT+IHqhOLaFSEhC7cXDIrTPrOUvp3w8WrjGzCLWXFyxkMPyvR6fmuxJjHNxXEZ1kqfJwMzHIU7K2dw1YakhAPFgWo=
X-Received: by 2002:a05:690c:304:b0:6ea:98d8:a55 with SMTP id
 00721157ae682-6ea98d80b01mr28133297b3.14.1730726701300; Mon, 04 Nov 2024
 05:25:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910215914.823546-1-robh@kernel.org>
In-Reply-To: <20240910215914.823546-1-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 4 Nov 2024 07:24:50 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLLRSEaDv=Zm_LQH9cpgH2prh21+cmovgSR=pzQTuRtZQ@mail.gmail.com>
Message-ID: <CAL_JsqLLRSEaDv=Zm_LQH9cpgH2prh21+cmovgSR=pzQTuRtZQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: marvell: kirkwood: Fix at24 EEPROM node name
To: Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 4:59=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
> at24.yaml defines the node name for at24 EEPROMs as 'eeprom'.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  arch/arm/boot/dts/marvell/kirkwood-openblocks_a7.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Ping!

Are Marvell platforms still maintained?

>
> diff --git a/arch/arm/boot/dts/marvell/kirkwood-openblocks_a7.dts b/arch/=
arm/boot/dts/marvell/kirkwood-openblocks_a7.dts
> index 9c438f10f737..2bc4b68bd723 100644
> --- a/arch/arm/boot/dts/marvell/kirkwood-openblocks_a7.dts
> +++ b/arch/arm/boot/dts/marvell/kirkwood-openblocks_a7.dts
> @@ -44,7 +44,7 @@ sata@80000 {
>                 i2c@11100 {
>                         status =3D "okay";
>
> -                       s24c02: s24c02@50 {
> +                       s24c02: eeprom@50 {
>                                 compatible =3D "atmel,24c02";
>                                 reg =3D <0x50>;
>                         };
> --
> 2.45.2
>

