Return-Path: <linux-kernel+bounces-439484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F499EAFE7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED1E18827B8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AE678F24;
	Tue, 10 Dec 2024 11:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uem8FXRi"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DD923DE95;
	Tue, 10 Dec 2024 11:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830160; cv=none; b=tvKgXQeOjGNvUpNp+j0DQlba57lfsVdWOrqnxnmAnYQMuxtHHbXswMKbpbjME9h1N2MfuU/6WkWM9x3Tx/MRvGbmjdFRQHtQANcA75nSkjeBW6xwe5NVYDfDNFPpB1wH/swf8Xd0OXoF87h7AHVqVF9d5ZgsN7XLnoldyZO7b80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830160; c=relaxed/simple;
	bh=syKr1d0Tfo87s6XNs5FVvlsg2xAdVouGH97tuGaw1Tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+zz9G072usoZpPpLiTQD4KLFw7pY+GkbTa2ZXvwuAIiomUgYs2S/UvKe0DEGErDqyNsLSTWEkt9FWpheaCF3c28lUZl8NnN6Uhi6xsJ1WMcxb7e3z8z7hrbCKIFtsfo0Ce+09Ps9s2DpL6X8KadpXotbkahq+Roob11H1a+EPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uem8FXRi; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3d143376dso5107461a12.3;
        Tue, 10 Dec 2024 03:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733830156; x=1734434956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vsa+PCKL3nkjdlqJseBSn+MXW/M4bMK4clgKtZHb1eI=;
        b=Uem8FXRinYkwcaCS24d3kzEv0x+qaVsSKuNoX93BhkLACo0a6p1g0e0R1UECA9/eqp
         Dg49CqrMBpnlU83sRkN4vskTz6Jh+D8i49yf8J2dnOKDHxviCJFl7jzTsD5Wz3Z5NtI+
         IbeNjqMUScruW8a+LNtJA5j/gyuw3z6XgaeyB34I4WpJ9f1BVREpGLKVbb+aDxVeyUTa
         GLdH1GEfw614l/Ibq2avHUKj+tqgO6VZD5NPIYz5WjDOlCdS8xljIwnQlqA7YwNo1mvL
         I4F1QkUOgV3PFNx5ZWlt5GyTiGaiJyjQKH9ccjgnaYRb+5nuU8r7b0zClH3KCqeDT2Co
         PuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733830156; x=1734434956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vsa+PCKL3nkjdlqJseBSn+MXW/M4bMK4clgKtZHb1eI=;
        b=rUQ+S0Ww29TBCXPssnQgLAtf/7stu+gEVYCLXwPqdCGvBwQvunH+jimcsESlKW2A+T
         hTLYOlvF+NP2HJmu8/vP+9q5b2OwIGopF5faXgHYqK+ReRl9N9nsuq1knu3zpBGdsEPU
         D1MhP8ej19J1mVWTzCHNZuT0b6EsFdhnphgmtxj+5TF+dnsT1py0IXdm+asaCIVrm8mE
         xhcr3Q/e4W2nrMG57Rm1r/NG+D8524NVqEv6zx4RcIdNm9RzmUsQF6oJwVbiFvuLuQz5
         N/hZpyKCdD0DoieyU98TI/YLH+B4CRAYbm+ejM6ygytI0UrDlw1YrNVMhyV+choOG7ZL
         z8JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVntw3UxE4+S7AshPH7hn8OA4sTvg7hBF1SGXzcWJvVF56z35ypgQ9Z8s4TPfTl2nPZoi5R0tpnI7cF@vger.kernel.org, AJvYcCWmTY3nCyhNtOi81bvFFYEjvfktjQ4lvl2g1IV3+Ot6/y36s3TDuRkYdWhuqzZ95ZrXhDtis1/VOgQ/iv6W@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ZEu+jfOpQwBjppmgWj8oWtCue038Qe8xzlE7Q/0Q3snmZZbu
	FVQhbbLGuwURBZ3Jb6wPWn5yp4TLRaW5Oua5B+p98bX82EEXDwZCUOOPK8IBwoC/xESSlJhXZvN
	1xf+WF6i6UE9TivWMkd1ti6LGRqs=
X-Gm-Gg: ASbGnctrbUgZdpg9/JUFqL+qz6tj6FVITNRLDcG3WK4Ir48/3ML0v4p0SiZpQPiUIL5
	HHfp/CurFXyug4ayowG8fLk6lrhO/PZLRRzo0
X-Google-Smtp-Source: AGHT+IFH5n+zWAxeaP6Ebg2yPGAGyKrxuqKNK29gHMryFKRfiM7VSwvTxu54I6XWT3mw6cto3WCv6aezpiIGED9xMrI=
X-Received: by 2002:a05:6402:210f:b0:5d0:b60a:2ff6 with SMTP id
 4fb4d7f45d1cf-5d418612cffmr5077206a12.22.1733830155765; Tue, 10 Dec 2024
 03:29:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210013010.81257-1-pgwipeout@gmail.com> <20241210013010.81257-7-pgwipeout@gmail.com>
 <2b68c2dd3618e5904a4eac1ec87d29a7@manjaro.org>
In-Reply-To: <2b68c2dd3618e5904a4eac1ec87d29a7@manjaro.org>
From: Peter Geis <pgwipeout@gmail.com>
Date: Tue, 10 Dec 2024 06:29:02 -0500
Message-ID: <CAMdYzYpj3d7Rq0O0QjV4r6HEf_e07R0QAhPT2NheZdQV3TnQ6g@mail.gmail.com>
Subject: Re: [PATCH 6/6] arm64: dts: rockchip: Remove address aligned beats
 from rk3328-roc
To: Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor+dt@kernel.org>, 
	Diederik de Haas <didi.debian@cknow.org>, Johan Jonker <jbx6244@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 5:45=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Peter,
>
> Thanks for the patch.  Please, see some comments below.
>
> On 2024-12-10 02:30, Peter Geis wrote:
> > Since commit 8a469ee35606 ("arm64: dts: rockchip: Add txpbl node for
> > RK3399/RK3328"), the snps,aal, snps,txpbl, and snps,rxpbl nodes have
> > been unnecessary in the separate device trees. There is also a
> > performance loss to using snps,aal. Remove these from the rk3328-roc
> > device tree.
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> >
> > ---
> >
> >  arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
> > b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
> > index 6984387ff8b3..0d476cc2144d 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
> > @@ -155,12 +155,9 @@ &gmac2io {
> >       phy-mode =3D "rgmii";
> >       pinctrl-names =3D "default";
> >       pinctrl-0 =3D <&rgmiim1_pins>;
> > -     snps,aal;
>
> Huh, I see that quite a few RK3328 board dts files specify
> the snps,aal node.  I wonder was it a "cargo cult" approach
> at play, :) or was there some real need for it?
>
> Actually, I see now that you added snps,aal to rk3328-roc-
> cc.dts in the commit 393f3875c385 ("arm64: dts: rockchip:
> improve rk3328-roc-cc rgmii performance."), so I guess that
> your further research and testing showed that it actually
> isn't needed for Ethernet stability?
>
> >       snps,reset-gpio =3D <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
> >       snps,reset-active-low;
> >       snps,reset-delays-us =3D <0 10000 50000>;
> > -     snps,rxpbl =3D <0x4>;
> > -     snps,txpbl =3D <0x4>;
>
> Unless I'm missing something, the commit 8a469ee35606 ("arm64:
> dts: rockchip: Add txpbl node for RK3399/RK3328") doesn't add
> the snps,rxpbl node to the RK3328 SoC dtsi, and the respective
> driver does nothing about it when the snps,txpbl node is found.
>
> Though, I see that rk3328-rock-pi-e.dts is the only other
> RK3328 board dts file that specifies the snps,rxpbl node, so
> it seems that removing the snps,rxpbl node here should be safe,
> especially because it was you who added it in the same commit
> mentioned above.  If there were some SoC-level issues, all
> RK3328 boards would've needed it.

Good Morning,

You'll notice the author of that patch was me. Setting aal, txpbl, and
rxpbl was the original fix I came up with for the rk3328, which I
applied to the only board I had. Someone else later on isolated it
specifically isolated it to just the txpbl and applied it to both the
rk3328 and rk3399 directly.

This was just something that was left hanging after that result.

Looking at how rk356x was done, I suspect there's an even more elegant
solution. However I don't have the deep level knowledge nor
documentation to implement it.

Very Respectfully,
Peter Geis
>
> >       tx_delay =3D <0x24>;
> >       rx_delay =3D <0x18>;
> >       status =3D "okay";

