Return-Path: <linux-kernel+bounces-239272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDE79258C7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1359B2A923
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421BF16B748;
	Wed,  3 Jul 2024 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="NlYiDjUJ";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="HnKQGAsQ"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FCB175562;
	Wed,  3 Jul 2024 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002586; cv=pass; b=NkSDAWgYQx6KS46zGQHkAUvjMXilBf/aHsho7u6EMSmsET12CUdESVOZ+/GUfg9WjoJ+p7pgVGMxifc9kQQMcKNRuFFac8A15U2xKLN38WKAGwWSpMdTF/0oV1Re0rfxu4KmRtwR03KFgNljhx7zyRnP2TKTq4ZExxjqnInuY2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002586; c=relaxed/simple;
	bh=gsB15KylrTss2Q22K6/8fTOKkDDS/+PxBfNc7RDie7Q=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=GBmDDbwAB3oxUQe1S2uYbnOPm+oK9A+XfRn630MOqmJx8+WpRhb4XULj3X6XGeQLwDmJ7YDp52UHbMRHd3rWVVnmyj15hv293/uJEADBd3tREhHvwNOYWtHzX6YJ0uK01dflaQH8lXFB0CjgH/vvqwUKfGEbuQ9Df7EKQxM6Mao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=NlYiDjUJ; dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=HnKQGAsQ; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1720002389; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pNni1aDpo97idlHxjXEYnr6cXufqQ1jfdjKSGUt64RdiIJ3hZ/VMc5U4O2R+3KRJF8
    eVmiPsIvVrA0xoR4cJTO4201shWC308D3zA4CDnlKcIQYMqsB0TXJRc67yQvQpD/hAd+
    fHbh4Qr7pFcE1wRbur2SCH1S52UJB6VStAy1IFJIHRDPiPO908GpHMxldhfba3x26afW
    bIHaFkvr+u5BZtgJbCQT9zd/d09jSRpRqXunOn90L4f4P4kTUzWzIc1+gc8UTFKkdS96
    NRPSAecnwQamLoLUza+pl5T0OdIHZ72zCckgnFqGDUJDZPqMfk2aST9N8vgOicsIlThO
    mfhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1720002389;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=gsB15KylrTss2Q22K6/8fTOKkDDS/+PxBfNc7RDie7Q=;
    b=UG+n1195gUiIEu7LB4gqzxjZecdaYprqZt2a6tpLjGHWBrJIdFUZwLVExUdocJMM9d
    uBSh4p9xwzF1tHgOf4imCEd4OTLjUVac6xO5wjDXQXKbPt6pbS8yJWEX1EZC8dQtnNOG
    zgg03J5KUOO5A0GhTvk/OSu26BePtiGjfupk42zzUJdhuB5ZGBHY1r6zD4kucH95ABd1
    8qkb9oxfZtkWjI/bYwO6g9Kjk7/tkgvjqs8Tqill2DVX9WSANCjV8MGNh7Hf0b3SEjDM
    yynHmklLA51dGl9oLInAbFyqsgrQtQWoP3adSeOnnrn2lZBNC0HQUENFyFKefxkpuSO8
    RTfQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1720002389;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=gsB15KylrTss2Q22K6/8fTOKkDDS/+PxBfNc7RDie7Q=;
    b=NlYiDjUJmvVFgMtRhTdc3b/gD4AkDu0mBIay4tIzGxAIfULvTCZX93yP2uZuKH92hD
    ym+q8FC9qBTAV/T+hylgajPy2bpxTozICiH7EEMmfiyuqZHvxAZAsOJ5sDJs/AydDtms
    vWXdJLqUU8UM84jICH+D8aL1tGhIp1faiEBb+/PW5AN1uC3T/zGBxh5E8VBi0Jtd1Inw
    sOX7qLvDbwNf/lqhCENApB6yOtZBq4Pic/I9F1OZ2b5C2dY0r/KgIALFT1Xpif5bJANo
    AXeTzJbEig/pt+z+QKvxLntcTQssOKxKOok5Oz+Ix/dlvXACziytvv40ek1POdJkmTI6
    CYcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1720002389;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=gsB15KylrTss2Q22K6/8fTOKkDDS/+PxBfNc7RDie7Q=;
    b=HnKQGAsQRUJcpMBsv1E/ZPqnTqey+uXtiTQTlOFjnyEkHRAWmJZAj2ew7Elq+gaeFp
    lhwKcR1ItlZ1bX9h07AA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5jgsyqQXntn0mkb0Dnz0PBqI1iVaDzyFx0Z7Dc="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 50.5.0 AUTH)
    with ESMTPSA id e08389063AQSOWH
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 3 Jul 2024 12:26:28 +0200 (CEST)
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
Date: Wed, 3 Jul 2024 12:26:17 +0200
Message-Id: <B550D4C4-6F82-409E-B5A8-E7D123ACB93D@xenosoft.de>
References: <86cynv9dx7.wl-maz@kernel.org>
Cc: Rob Herring <robh@kernel.org>, apatel@ventanamicro.com,
 DTML <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Matthew Leaman <matthew@a-eon.biz>,
 Darren Stevens <darren@stevens-zone.net>,
 Christian Zigotzky <info@xenosoft.de>
In-Reply-To: <86cynv9dx7.wl-maz@kernel.org>
To: Marc Zyngier <maz@kernel.org>
X-Mailer: iPhone Mail (21F90)

On 3. Jul 2024, at 08:40, Marc Zyngier <maz@kernel.org> wrote:

This isn't a DTS. This is a listing of all the nodes, not something I
can use to feed the kernel. I explained how to generate it.

Download the compiled device tree for the Nemo board:
http://www.xenosoft.de/fdt-nemo-board.zip

No, thank you.

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94

You know already the device tree: https://lists.ozlabs.org/pipermail/linuxpp=
c-dev/2021-November/236587.html=


