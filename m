Return-Path: <linux-kernel+bounces-194484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 083908D3CFD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 18:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5DA1F21691
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0961A38DD;
	Wed, 29 May 2024 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="PgOBpqIl"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0A1194C87
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000668; cv=none; b=ow3dTIYMfFvIJgG16sBqobMnYe9I+fa+AL276nNSkUQYrSqtSZI1IP+xkkJXazP0GF7xxJD8brsuYeUfnNnEP90lexAqB610EseKXNmPW40XOnyoOP5+3dJdy/KHpbMzz/Na0DRcOB5dlMLieGNWseC7hG547l/OjhXBV2xDaOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000668; c=relaxed/simple;
	bh=D5hQleF4je2re4WTabKnBIrdc70AGoD50APXI1WJ4SA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G7W7mINlreauamVJn9SRTcfOMBZJz0ZBwFlYV8U+sgcE95qx8kJICQaW3mxjJ2Lxw6hE4sbvhZm57pDn2zqV+vkfNB1rcnE4Ry+Z4Y7vvKtHyu6IecJSPQrB9ESGZu3MUCM0jofi706VRMafl6m9vZcbpprcwBdDM3fJ8JSz1WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=PgOBpqIl; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5295dada905so167128e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 09:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717000665; x=1717605465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vhg3PSDLD+pC/Tu5xX3Yt9O/jtF+LQuu+I4tEFxm4GE=;
        b=PgOBpqIlEgm7O6j5hrl2SrvqM/DRmO8rsrFXF9bQ8Oxk+uEEL0DN3NxXcadUTU8R6W
         Zy2s+WvYy1Sqw5KRUMUY1MRd3/dduwglqQkKtfr2CIaF2PtY1/szEdJS3Mirr+3q3/x6
         8whEJzLTvg7qkN7ktuYaBq4GMFfB4TQd1NMTUoVqq2J2l9cgRrXaI9bdIxkBi2n0r4QE
         bRAxISFuFr9WtHF6TNKt/dqw0p4919TRc7Kc/x7Img0asS2fVGEReEwkkbi9KO0mIL/z
         61HqoNsuLJ05OhSgVM4n4qdpIU8xiUSB5qwD29Ku70/7kzEFe3e8H6pT7Vg73HgV3jfX
         dR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717000665; x=1717605465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vhg3PSDLD+pC/Tu5xX3Yt9O/jtF+LQuu+I4tEFxm4GE=;
        b=nIZUb76dyNAL0nlZeKXlKpCCfw/Ofnws4O2z92mTywQQhorYuonHRy8WrYNAt5wZl8
         l3ticQYuXVMYavH2m1PxO/IvGU/JOMGYCuINIWojkFHVbHbvWf/ISpDs2aL/FRliCaQW
         C04JPHb1lIxqG/myAWTLmpPQ1AG6h/0SfbPtAIxi731HS1+62hQveIDG6ZEI7WH5MPAP
         bXReCyEJVlXR1MWRtPGKAljBTSKyy3RRNrN1F8E2uD2U5oMwdJ6yMsoxxSS3+hfLzRPe
         Nkwzw/VAYt33bHq5cR/wJ1+whKfHj3ROw6/5NbSP12Rim/wunLOdpXeqBfk+TbvfeGNO
         KWeA==
X-Forwarded-Encrypted: i=1; AJvYcCXA735zhPulQxxgbGAzlVZeZ9toH8YfyvxiqcDg9M2jvL7gDuLKfEfiLnySSzZsR2MC78pbdTsDB6bIya/6H/SlyKI2X5bz2Rb3ylvZ
X-Gm-Message-State: AOJu0Yxv1DeEDG27Hw2vuTFEVxBtS3Fcq51NDSqPVfSn0NJAXz7or70W
	C341V3f59N3Fn1+waUU/a09vsVm1Oo0xt5jVubRxFcXNqstaQIz/4/KJn+UiIDI9bbPvmJQxmU1
	JvKG9yQlia1J3SXRsdTEYotZzGcNpo7Cw3kPW+Q==
X-Google-Smtp-Source: AGHT+IFb7OdP5izYBsFIM8KNbnVSke/aDi57hq/CQb9jSjOOLKEcu+ukVpWtaVdyek30b6o6ySohcFJ0aUZA5z/4PtE=
X-Received: by 2002:a05:6512:3ed:b0:529:b6d1:572c with SMTP id
 2adb3069b0e04-52a848cf73bmr728684e87.32.1717000664855; Wed, 29 May 2024
 09:37:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528164132.2451685-1-maz@kernel.org> <CAK9=C2XNPJP0X=pg5TSrQbsuouDD3jP-gy2Sm4BXNJp0ZiWp+A@mail.gmail.com>
 <86bk4pm8j1.wl-maz@kernel.org> <CAK9=C2XRx==OTPoGW_AHmjq4Th0bv4okwcq6-3L5JYwHwQp97A@mail.gmail.com>
 <86a5k8nbh1.wl-maz@kernel.org> <CAK9=C2Ugq=0y8M86CD75mQccBo=TBLBomb4rqC4i1naKy2LyWQ@mail.gmail.com>
 <868qzsn7zs.wl-maz@kernel.org> <20240529-rust-tile-a05517a6260f@spud>
In-Reply-To: <20240529-rust-tile-a05517a6260f@spud>
From: Anup Patel <apatel@ventanamicro.com>
Date: Wed, 29 May 2024 22:07:33 +0530
Message-ID: <CAK9=C2UvppYBUE8_u+M86KSdtULyMAMA=kPvmb4xS0S1_UJGhQ@mail.gmail.com>
Subject: Re: [PATCH] of: property: Fix fw_devlink handling of interrupt-map
To: Conor Dooley <conor@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, Saravana Kannan <saravanak@google.com>, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 8:47=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Wed, May 29, 2024 at 01:00:07PM +0100, Marc Zyngier wrote:
> > > > > In the RISC-V world, there have been quite a few QEMU releases
> > > > > where the generated DT node of the interrupt controller does not
> > > > > have the "#address-cells" property. This patch breaks the kernel
> > > > > for all such QEMU releases.
> > > >
> > > > Congratulations, you've forked DT. News at 11.
> > >
> > > Can you elaborate how ?
> >
> > You've stated it yourself. You are relying on a behaviour that
> > deviates from the standard by having DTs with missing properties
> >
> > And since we can't travel back it time to fix this, the only solution
> > I can see is to support both behaviours by quirking it.
>
> I'm not convinced that there is any actual production hardware that
> would get broken by your patch, just QEMU, so I think it should get
> fixed to output devicetrees that are spec compliant rather than add some
> riscv-specific hacks that we can't even gate on the "qemu,aplic"
> compatible because QEMU doesn't use the compatible created for it...

I also did further digging and it turns out the "#address-cells"
is missing only for APLIC DT nodes and this issue only impacts
APLIC DT node creation in QEMU RISC-V virt machine. We
should just go ahead and fix QEMU.

>
> Spec violations aside, the QEMU aplic nodes in the DT contain a bunch
> of other issues, including using properties that changed in the
> upstreaming process. Here's the issues with Alistair's current riscv
> tree for QEMU w/ -smp 4 -M virt,aia=3Daplic,dumpdtb=3D$(qemu_dtb) -cpu ma=
x -m 1G -nographic
>
> qemu.dtb: aplic@d000000: $nodename:0: 'aplic@d000000' does not match '^in=
terrupt-controller(@[0-9a-f,]+)*$'
>         from schema $id: http://devicetree.org/schemas/interrupt-controll=
er/riscv,aplic.yaml#
> qemu.dtb: aplic@d000000: compatible:0: 'riscv,aplic' is not one of ['qemu=
,aplic']
>         from schema $id: http://devicetree.org/schemas/interrupt-controll=
er/riscv,aplic.yaml#
> qemu.dtb: aplic@d000000: compatible: ['riscv,aplic'] is too short
>         from schema $id: http://devicetree.org/schemas/interrupt-controll=
er/riscv,aplic.yaml#
> qemu.dtb: aplic@d000000: Unevaluated properties are not allowed ('compati=
ble' was unexpected)
>         from schema $id: http://devicetree.org/schemas/interrupt-controll=
er/riscv,aplic.yaml#
> qemu.dtb: aplic@c000000: $nodename:0: 'aplic@c000000' does not match '^in=
terrupt-controller(@[0-9a-f,]+)*$'
>         from schema $id: http://devicetree.org/schemas/interrupt-controll=
er/riscv,aplic.yaml#
> qemu.dtb: aplic@c000000: compatible:0: 'riscv,aplic' is not one of ['qemu=
,aplic']
>         from schema $id: http://devicetree.org/schemas/interrupt-controll=
er/riscv,aplic.yaml#
> qemu.dtb: aplic@c000000: compatible: ['riscv,aplic'] is too short
>         from schema $id: http://devicetree.org/schemas/interrupt-controll=
er/riscv,aplic.yaml#
> qemu.dtb: aplic@c000000: Unevaluated properties are not allowed ('compati=
ble', 'riscv,delegate' were unexpected)
>         from schema $id: http://devicetree.org/schemas/interrupt-controll=
er/riscv,aplic.yaml#
>
> I guess noone updated QEMU to comply with the bindings that actually got
> upstreamed for the aplic?

Yes, we never bothered to update the QEMU DT generation after
AIA DT bindings were accepted. Thanks for catching.

Regards,
Anup

