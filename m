Return-Path: <linux-kernel+bounces-243327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FDA9294A9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 17:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51BB282B60
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 15:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEF513A87E;
	Sat,  6 Jul 2024 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="EFm+RcmE";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="feUqBK6f"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEBE168DA;
	Sat,  6 Jul 2024 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720281340; cv=pass; b=I8LRgA4TFJ7YydrZKOEpt91pd0NkQhvLXGKcpkXVE9/STv4E7KokD0sRomJ/OmtMRnB7SHZ6yr4oNpr0FDqYY1dPnnwU3F4hvMCBzuyG5As2Dz8IOHCFB17xB8UCkxA3RA2LYwpmHMtlwoT3J+1YiwJn1FD2VTYVuuMUqrk0YYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720281340; c=relaxed/simple;
	bh=Nw528Q8aiXtTR/m5KO2A6eO3cpfoszO5p+Ec9Wh5CR8=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=WWTazU6NK0YBFMar46P/8LZBYMpJSChGL1Vlbc71X/jCiwZ0cKb3jSC/kLQ+MwpFOqEm5afFme2L6bv86EcJmZNU7SHU2dm8XIAf8yhT9EAdq0BomD3qAtVUDz+hi/JaW/yWJMO6+wDjIvExID3n++oLFV+8T7VNRadt5NlGQbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=EFm+RcmE; dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=feUqBK6f; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1720281272; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oQu9NJpOTvlm5sqaOBtbtSjC0GmbqaTimIaErxL5er0Cy/y1doMRrYd8YHsasBDvv2
    +bpa44fULXnM/OBjToO6pjSsNp47pPrDs/uh4c233WTsognGXbU/xHZf7ukrIjVP4BZg
    RDNpuIgguQl5U4eickv0vIPFv1VdshLv9RL0fN9uR3l5fDQK0MxIIUihJhOfUtwJHYOI
    LOTldA+PQuA7IatRdqAY4xy3njnQUQTmzZElydx1EoXLofTU1PxE6/GEIbXwWOHrdQsE
    BmGRnxQUh9GGIYJYbpdt45g+5rGRr78G8DuOgkLjQOZBpyoec9SyqEO+6BWQLsnCweP2
    eYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1720281272;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=V5YwiazAeEN4dRiis3W1yfsGHE0h2QF7Ju83ZXv0xIw=;
    b=DyT6PHTmBeSgGXeyC302gvjLyhYtgE5QH2EwcjMehTllmqGQGALl7lc9l0KXPFuahz
    CI4U/aIETe985yEzzLSZKBxiS5UD+owVLYCT9pk+ORt+c0+n0yk8jQV/Ck9rkIvmHqlN
    c0K2AjvqxGPBzvBDX9TbPJVDJ8pGpi2RxISJutYNTxnVtNpsHyqEIVfK6sdyXSvNssNv
    Jh8OH3qdqzaJqfgxEOeNFr/ypfASJCQ/HP2l1eFLRMEJuJQTXZqZqxYWCd02VfWTlWV6
    ZFrnfP9PXE03ZSdknClLVLth+Kmj4yGMZVm4xdIuUxfK4g/CSYco3EW0Z56DtB8qTVMA
    ZfmQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1720281272;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=V5YwiazAeEN4dRiis3W1yfsGHE0h2QF7Ju83ZXv0xIw=;
    b=EFm+RcmEv3Jb6IZRdOg09a00x/Od740fpnTkH8XS2mvx3dIdfIgtyl9OLqp+av91aq
    AFPsmvHmMk9Q27zp6YWU08KM1I+eXCIz9b/BqEUtCf7iBaOjB7ua7y5S2OxEte2wwij5
    fpTecZk7yKJXlgG7BpJlgTQl/7k0x+2RVGI5NnFCUTd76FeOvoGKayrASRIBiTCN67d3
    7KkTan+cH7n4Jf8K+Z5cByWi7LE1b4f63NGtPYhfdluXG94oMzrPZ5euEUJABLQFmAQi
    4tboeUrDnPivRy0+v+b8VGNq0TPKxmWEhUoH5ckaGWqG7ok35jm3XulmmNnthRcawkEW
    xXBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1720281272;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=V5YwiazAeEN4dRiis3W1yfsGHE0h2QF7Ju83ZXv0xIw=;
    b=feUqBK6fPUAJa9MwugIBfvjA9VqnYR2IcS/1VKpZyqPJcohTAspOxna4wuCDAPKPF4
    HMtx926oKldM5qV6MgAA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5m3s36WCHpkK6jpK2wKbeiFIUzgLYe3d6gbw0o="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 50.5.0 AUTH)
    with ESMTPSA id e08389066FsVYVz
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 6 Jul 2024 17:54:31 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PowerPC] [PASEMI] Issue with the identification of ATA drives after the of/irq updates 2024-05-29
Date: Sat, 6 Jul 2024 17:54:20 +0200
Message-Id: <8FDD860C-4DA4-46EF-BAD6-8F68837DA993@xenosoft.de>
References: <aeaa9b78-5853-473e-b985-b10241e88e0d@xenosoft.de>
Cc: Rob Herring <robh@kernel.org>, apatel@ventanamicro.com,
 DTML <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Matthew Leaman <matthew@a-eon.biz>,
 Darren Stevens <darren@stevens-zone.net>,
 Christian Zigotzky <info@xenosoft.de>
In-Reply-To: <aeaa9b78-5853-473e-b985-b10241e88e0d@xenosoft.de>
To: Michael Ellerman <mpe@ellerman.id.au>, Marc Zyngier <maz@kernel.org>
X-Mailer: iPhone Mail (21F90)



On 6. Jul 2024, at 06:15, Christian Zigotzky wrote:

Our tester has tested the second irq patch again and the kernel boots. We wi=
ll test it again to be sure that it really works. ;-)

Second irq patch:

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 462375b293e47..c94203ce65bb3 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -81,7 +81,8 @@ EXPORT_SYMBOL_GPL(of_irq_find_parent);
 /*
  * These interrupt controllers abuse interrupt-map for unspeakable
  * reasons and rely on the core code to *ignore* it (the drivers do
- * their own parsing of the property).
+ * their own parsing of the property). The PAsemi entry covers a
+ * non-sensical interrupt-map that is better left ignored.
  *
  * If you think of adding to the list for something *new*, think
  * again. There is a high chance that you will be sent back to the
@@ -95,6 +96,7 @@ static const char * const of_irq_imap_abusers[] =3D {
     "fsl,ls1043a-extirq",
     "fsl,ls1088a-extirq",
     "renesas,rza1-irqc",
+    "pasemi,rootbus",
     NULL,
 };

@@ -293,20 +295,8 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phan=
dle_args *out_irq)
             imaplen -=3D imap - oldimap;
             pr_debug(" -> imaplen=3D%d\n", imaplen);
         }
-        if (!match) {
-            if (intc) {
-                /*
-                 * The PASEMI Nemo is a known offender, so
-                 * let's only warn for anyone else.
-                 */
-                WARN(!IS_ENABLED(CONFIG_PPC_PASEMI),
-                     "%pOF interrupt-map failed, using interrupt-controller=
\n",
-                     ipar);
-                return 0;
-            }
-
+        if (!match)
             goto fail;
-        }

         /*
          * Successfully parsed an interrupt-map translation; copy new

-----

Great news! Our tester has tested this second irq patch again and it boots.

Link: https://forum.hyperion-entertainment.com/viewtopic.php?p=3D58632#p5863=
2

We will use this patch for the kernel 6.10-rc7.

- - Christian=


