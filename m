Return-Path: <linux-kernel+bounces-242004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7390F92826E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9761F26010
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780D2143C53;
	Fri,  5 Jul 2024 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="fTYLQggZ";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="hluCerhd"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D313E45000;
	Fri,  5 Jul 2024 07:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720162812; cv=pass; b=cznPl1+LfB6tdttUiq6nkHlOBKtYcK9dCqGF8KGH42w3/vaflEj60pitmiKf1oTvRjlVgT9HwyWhLz80jPcTtuhFtPS9ViKr0q6Ss1G6Z1GYN2Mpi1WETxsLCV67buPzjNVr5F6qphKEiDXiw70lx73LKTbUt4IWeS27+RuhwVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720162812; c=relaxed/simple;
	bh=QSIwoxIOy0G1ehWIbduiiJY4a1/LzlKM/BH7Nv72fzQ=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=trrF+rKsaUVXTl03uoZDoUitWMuuauoh+L2uDer5RwcFCiQXLU3Fo/I4074zktCRGjueH2xuwlJ15QbUM3RtCv/zHTdJwEMZZsHwBPq3RUBsfHGSvOkppgwP9Edm2PkB8M/exHnE9gB5IRucILiDTuy7BfjPSSUFLK0FedXqvk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=fTYLQggZ; dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=hluCerhd; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1720162762; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ShMLVJWxdYJ6RyJ/MuaTH26WvWpoxpBTNnCbG/oXUyw4FrFnyBvfdLH5q5sPkdBrQy
    RZqFA+AFUGteZeK28NylZYweTDHCl/p14d67A2eaY4FZuVssXvUBjmGjkl+UgJUzc78P
    PWSAdg4SR3Yhi9byuyZzfLaQAZdAIOv8IUDQj9+G83RBEvQ4/VQeMiczIrsxVLUJ1bA6
    G5YIVvC4l/a9BGo+LJ470LGUUCjmnTdg9OtWWn13m/upxK+61M64wsprHFezOvzoOazd
    qK4wozy+l0aWwvm/p2nuDqtURLoCqewdgawqdBeQjjFcD9zv0HRH7GCnw/IJ/oVcfQ+7
    sgOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1720162762;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=gNL/fOXpQJrMQTPOsNrGaufWZIoIwwlUQi6VU5VoR4Y=;
    b=Mxf0H92FaRlAXEcB3j/9CQlkBvI3maNmXYaZLIxlpoJYM/dgMA+MwQlnhUEgqToEcU
    E9/GGz19xy3Thp8CVOkv6nQD+oeDFp+GX+rbdv6H11E9uzgGj7AXUDY7BH7NlBBoXrMq
    ztB4aYASI+SlHTuB0x5toTDZFTpHU74SLLCWscRq6Uydw+iejilZk7A3Xa4lgGuYVSAb
    qi3DdZ/xkBAbr+cm0FycsR2lWL+uEYBIdA1hKeRuRhS7cj3AXPr/APzHfMJIRRYhlx6C
    29DCGSS9lQ94WzbX83Y9PKZRmpil8rKhAGRR7DgZ1vZMeG9YxSFiqYjObjjOi4mPm9fr
    tXZA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1720162762;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=gNL/fOXpQJrMQTPOsNrGaufWZIoIwwlUQi6VU5VoR4Y=;
    b=fTYLQggZpwBTd5rl6H1yL2tSn+rpWdm2+QROMf24vMKEyUr3Y1sCPCBXgu4yyHs5QN
    Z9r+AhlpC5bBDHHI3fNW6kgfDIRL1/53aSX4YUsMmFM7HRRn/uBxllcxd2kMvyt8JB9D
    LrbpSoi9yTG++p3OwLOyLvnTYody1AR+jkziUqzGix8LB+iDqYbRlxEr1lU5JhivH6lP
    woo0Aorvi7HX2MUDY8Yq65Ym7UC5qNoDUOMxwfTfRfGTM8Tv6XaViJItUiAxj9fgx+X7
    AvrRFCdBoKWX/lPZnGhdLg4ppG62OWQiP0JDvIUDalOHm3sk5OLscm8wZRvO3ehnbQQE
    V+ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1720162762;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=gNL/fOXpQJrMQTPOsNrGaufWZIoIwwlUQi6VU5VoR4Y=;
    b=hluCerhd664fdOv5TIuixPwDRdZHSrNZMzjo9EM2L2+1zI2/oI2sZIwd+TvSfP5kKy
    r6WGnoUvBhWQwmOKEkCg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5m0s3zACH4zKZqEV93ynRnNbNQ9EJ4O1StAee0="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 50.5.0 AUTH)
    with ESMTPSA id e083890656xLV6Z
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 5 Jul 2024 08:59:21 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PowerPC] [PASEMI] Issue with the identification of ATA drives after the of/irq updates 2024-05-29
Date: Fri, 5 Jul 2024 08:59:10 +0200
Message-Id: <F30D5471-B68C-442B-A34C-6EA0C8232006@xenosoft.de>
References: <ccf14173-9818-44ef-8610-db2900c67ae8@xenosoft.de>
Cc: Rob Herring <robh@kernel.org>, apatel@ventanamicro.com,
 DTML <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Matthew Leaman <matthew@a-eon.biz>,
 Darren Stevens <darren@stevens-zone.net>,
 Christian Zigotzky <info@xenosoft.de>
In-Reply-To: <ccf14173-9818-44ef-8610-db2900c67ae8@xenosoft.de>
To: Marc Zyngier <maz@kernel.org>
X-Mailer: iPhone Mail (21F90)

[snip]

My earlier request for valuable debug information still stands. But
while you're at it, can you please give the following hack a go?

   M.

--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -282,8 +282,10 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phan=
dle_args *out_irq)
               oldimap =3D imap;
             imap =3D of_irq_parse_imap_parent(oldimap, imaplen, out_irq);
-            if (!imap)
-                goto fail;
+            if (!imap) {
+                match =3D 0;
+                break;
+            }
               match &=3D of_device_is_available(out_irq->np);
             if (match)

This may not be the final workaround even if it solves your boot
problem, but will at least give us a hint at what is going wrong.

I have the fuzzy feeling that we may be able to lob this broken system
as part of the of_irq_imap_abusers[] array, which would solve things
pretty "neatly".

   M.

- - - -

We tested this patch yesterday and it solves the boot problem.

Thanks

- - - -

I am sorry our tester was wrong and has reported, that this kernel doesn=E2=80=
=99t boot.

Link: https://forum.hyperion-entertainment.com/viewtopic.php?p=3D58627#p5862=
7

Sorry=


