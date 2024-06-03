Return-Path: <linux-kernel+bounces-199690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2C08D8AE9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 22:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90531289D05
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 20:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572B113B58C;
	Mon,  3 Jun 2024 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Lr+jI0ky"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C719D139CEF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 20:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717446703; cv=none; b=WjoYRVGKH43iuvlCF7xkTsVAcM1gSwzAFrantr3R4QfSjkjR+aCE++0OPZuvRojdv02wdQwoQDRP1Pb2dk5KxwSdjnmx10uO6/vHDiHjV6haavthYP/hoicrHYNeSxvY2Gm1oAtlR5Ao89xqoPtADMK4qo/WbUJ7efZsZCF0Lvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717446703; c=relaxed/simple;
	bh=kseNDCmSQ5FUN+wUVr7xlVyxKaH42d7W1N3nfdVvntU=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+gdAjhg6FQn39WbsrFW262VRnGVWdw2S8c4DIyN7dbUQGFNIJ12R+Ll+axBCMwg0dFvjX1mMUZndTuXaC5b7hE+VCIKLFXL3NEyX3O5sWFAl0oB+J2Ey5CyyiA6alwGKnb52LlulvZ3kBmRhG+hv9rhputWAhLvkyyHkVU8cnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Lr+jI0ky; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 005A7412C7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 20:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717446698;
	bh=ahV+EJLz1b7kXv8nPMYOtMyUKc6v5M9VH6zQprdv2v0=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Lr+jI0kyV+RGfYSf1YJPLZ/eax1MbgWSGH/loprVK/Muk3oEIJupQzn6Y8u4BgRCu
	 Tp2hHBG/sArtC2uT+B5hn+7P3dGw8z/grnfNVih2Q9vhWlyBnqhhwbJcKJPTjVhXfg
	 ysC755FWANtfQs92/ogxIzUzlMvCkWL2eBbymYW/S5hKIzOYCy4rAS7pJ6NG18LIgr
	 rPGztFKyZicdQ67tEgl/1aXDDyjv92/d4VQAu1z8Y6BAhRoVmOR6mwQbXlRw6jA+IQ
	 e4TTaftqOPUd4qIZB1Id98zPCKcBuRCO03JLbG7U7mtu096fvTrXquJUPt3tb/pSA/
	 Afrrc7SRWiNkg==
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5ba591276c0so561637eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 13:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717446697; x=1718051497;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ahV+EJLz1b7kXv8nPMYOtMyUKc6v5M9VH6zQprdv2v0=;
        b=Zn+lyrbngJL3pC5b5xG2bWmClTo2ThoSnpd7avPp5rqbBbBJn9ojfI70rUmi9qvw4l
         ZmANCLjcpS9rZH5D4twotcx1TYgHbkjCbMeJhb1PFZEjODpPI24DI2h4RwPUww9SO3+s
         rt3S38yxi3cTWIq37fB+Vwc9iLsA7MTB6Otmr2EX3Pz+DCAmTGN49d5gA0m02Af2ZKuN
         JTLALGZ7/+RZGbu1FKJ0GT7ymqxVJTD+sVVGjXIhL1e1/r34bV+qAi9I026JlhKg29qw
         QYjDLiw3Ah8TcKXfF/UJFIdUiZYt/PqgE/66hqd4oJiBSrSe7z52SlE3RDWtnKbUMHeF
         PAwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRpHgd4w7ErjDOvyOf3H5njKIjcECOhB/chuLKAsGcNdR5no+hHm4aLMhqDCVmsHfQa9L/FwPel162j5rHHjWB4QjY+oTni+DyixJF
X-Gm-Message-State: AOJu0YyRgAYkZpXjtZ3+lbvvye2EEZ1q9/45F1huCQnqcX36ye4TgGi5
	pF4kkzEebGTiAH+CCVTZB7JLL9qSAx1fqwQQLY/DUT5MYDnsNBHBxAAQFsVaFS6U1rIcT1JUoi1
	8BPINuCyi3bN90g2oV9aqFRreJolPL8wqwK13kqOl2LOcYpsc/DSLXY+pLPZznibha7pTlpMvYM
	5W5Te0jALBvzE2jdt/pQc8SXa2B0s0zx9kg9QRmJaa3+sfcTVQn0wZ
X-Received: by 2002:a05:6358:e49b:b0:192:2717:4ed4 with SMTP id e5c5f4694b2df-19b48d606f7mr1494301155d.19.1717446696525;
        Mon, 03 Jun 2024 13:31:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNOqELb+TNrrcp0k/w7K34E/nZ0eKhmkZ1wR5a0BvRi2qcNm8V+dmkcOht1G0ZNEE2zOCO/z+ZLZWTjCb1Ndg=
X-Received: by 2002:a05:6358:e49b:b0:192:2717:4ed4 with SMTP id
 e5c5f4694b2df-19b48d606f7mr1494298355d.19.1717446696068; Mon, 03 Jun 2024
 13:31:36 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Jun 2024 15:31:35 -0500
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <0eb3b03d-f817-4f6d-8a29-abf87c3632f6@canonical.com>
References: <20240603150759.9643-1-matthias.bgg@kernel.org>
 <CAJM55Z82+_RL1Z+DCW+_xgE7ZMmiWdPekCt6qtREPXg1jB+68g@mail.gmail.com> <0eb3b03d-f817-4f6d-8a29-abf87c3632f6@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 3 Jun 2024 15:31:35 -0500
Message-ID: <CAJM55Z8pntz8=aHhad4LW5cH4BLTCw5vfJPYRpYmTjtuuqiZtw@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: starfive: Update flash partition layout
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: devicetree@vger.kernel.org, aou@eecs.berkeley.edu, duwe@suse.de, 
	linux-kernel@vger.kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	linux-riscv@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, 
	matthias.bgg@kernel.org, kernel@esmil.dk, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"

Heinrich Schuchardt wrote:
> On 6/3/24 18:10, Emil Renner Berthing wrote:
> > matthias.bgg@ wrote:
> >> From: Matthias Brugger <matthias.bgg@gmail.com>
> >>
> >> Up to now, the describe flash partition layout has some gaps.
> >> Use the whole flash chip by getting rid of the gaps.
> >>
> >> Suggested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> >
> > Hi Matthias,
> >
> > Thanks for the patch.
> >
> >>
> >> ---
> >>
> >>   arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 7 ++-----
> >>   1 file changed, 2 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> >> index 8ff6ea64f0489..37b4c294ffcc5 100644
> >> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> >> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> >> @@ -321,16 +321,13 @@ partitions {
> >>   			#size-cells = <1>;
> >>
> >>   			spl@0 {
> >> -				reg = <0x0 0x80000>;
> >> +				reg = <0x0 0xf0000>;
> >
> > ..this is definitely fine, but..
> >
> >>   			};
> >>   			uboot-env@f0000 {
> >>   				reg = <0xf0000 0x10000>;
> >>   			};
> >>   			uboot@100000 {
> >> -				reg = <0x100000 0x400000>;
> >> -			};
> >> -			reserved-data@600000 {
> >> -				reg = <0x600000 0xa00000>;
> >> +				reg = <0x100000 0xf00000>;
> >
> > Do we know that all of the VF2 1.2A, VF2 1.3B and Milk-V Mars boards have at
> > least 15kB SPI flash chips? In other words were there a reason this previously
> > ended at 10kB?
> >
> > Also it looks like my Mars board and VF2 1.3B both report discovering a
> > "gd25lq128d" chip of 16kB, so why stop at 15kB?
>
> Hello Emil,
>
> 0xf00000 (15 MiB) is the value of the size-cell. gd25lq128d has 128 Mbit
> (=16 MiB).
>
> Cf. the examples in
> Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
>
> The prior partition scheme had a partition 'reserved-data' also ending
> at 16 MiB. We don't change the expected size with the current patch.

Oh, you're right. I totally misread that, sorry. You can add my

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

