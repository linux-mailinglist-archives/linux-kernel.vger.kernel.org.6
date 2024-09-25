Return-Path: <linux-kernel+bounces-338443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6A098580B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 13:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13314B20A31
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE65156F23;
	Wed, 25 Sep 2024 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9eIU1U4"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D05137775;
	Wed, 25 Sep 2024 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264146; cv=none; b=C3rcmgwmcZCLkR/GFVp9hWD9THvwA3/1ZvMmH+K9D/AftIavPospDS/W6qxTu9GV4COvDam+JWaC0MEbs7iHK9bl2j3g9Ye9rlSyzSIHF8f27CWZiubGwfeh1EiCJQM973G8ELIavol00n1sHljIFNDxggYPDdDwY25lJn9uoHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264146; c=relaxed/simple;
	bh=/pSQ/xNkOX6ORmM05y8rQhImn2uy639aERh7uoQXfDw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivlKb2HNsCWqU9BKXhSaoSGugoX0sYpumPmYvMyHpcqMN4YNL3zoxL4iYalAEhX7s9v4KQXfsQuoAHivFnTG6QtRvv0sXQDWP1XSnk6dI+KRmcAUxbr8p8jIS5cU7edvnAR+8ReV/FogcMw68hR4Ih+PL0ZMDjLXGSw6+UBF0kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9eIU1U4; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-375e5c12042so3484363f8f.3;
        Wed, 25 Sep 2024 04:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727264143; x=1727868943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qWs4MKWn4IG5TDYW4mkeYaUP9TdSrJm2s49LW7b6huE=;
        b=Q9eIU1U4jcD0YkCcfmMRRhl7IcsJnlxHvC2AFOpIe6SbgblAMaz3DvI80A2O+QmiR7
         fHDgt6y1s53BIgumPDJ9CyfdIjQ3C9y1j9S8TdWjRbqcGIaD5o9Vgvs3/Bw3EgyL1j39
         QRusOyFwB8Y+p5QjUNXMYSdCC+LFjhDCFCzsIF/oA4o6b1K949nAEn7KQ3SEeZFRKp40
         d9gTODMffNG4IWVMbPnyoW7ihFA6AsVRgFeOIYgmTXMuRE9NZOfkMRc9zepStlYiGaL8
         fqDse2dD4v0N+9bCmm29By73A8TOU+8kw824QpOVIsWrrypC4RXGGFXweA5HoZk7ycFv
         2twg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727264143; x=1727868943;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWs4MKWn4IG5TDYW4mkeYaUP9TdSrJm2s49LW7b6huE=;
        b=roQnvtP51JQwf3LoWSGkM7/5fisiXCLr4OwUrIe/B50BmKuLvcW/41XirxpYYRMxb2
         M+wQgynKmyfby/AX61g2VhzUshCIVV/lBwvrdTUUa2fwcw+4oMC0vNVcppFrl8z97LpN
         5kWQH6EVXqmywGeGbRFfcn/RLDo7aumxAB2PfLuXBg6kZcu1xbQZBdaBgEefJdfRe/PR
         moODWczRGGxE9hVvW1nWHz1B3IdvomwX7MqtBmE4q//aHupew7z3cJkctZJ17wbbpEth
         Nekd9xPkD0P1RDtaDR3BoUr1yzameeKimLrIx6e5eYspsqjCYxEZBXWsI1o2OUxH+cNP
         FmBA==
X-Forwarded-Encrypted: i=1; AJvYcCVx8dH7OadR23rFHKRJU7F7PsTgbqLiFkLnCTrThxHfXF7SqWtDSmEGRnHCsv7r9NGQn5TvNK1lM54U@vger.kernel.org, AJvYcCWsf2DG3Cta8K1HvuYwMCtdduO9mRQwdU7qE/8qrDJmHtULYw9D6JAPVsbQdTMo8yKOehypRlraFvSAhBJC@vger.kernel.org
X-Gm-Message-State: AOJu0YxiNp89Vv6gTafb+EFTPJ/m8iITWAikjY4b53OTw/ER23TBIPib
	TBIZWhZPGFbqJbvYPXbbEsX9GH1M1JCFeAP2HLeX7FXXxNp91faG
X-Google-Smtp-Source: AGHT+IHRdPtqmM9PLpkqO4zrDeiSAfnuAfG5Sq385VHJ2FgMeMRF8IuH66Jm6m6MGMrtVGh0FU9tAA==
X-Received: by 2002:a5d:4b07:0:b0:374:c1bd:f7c0 with SMTP id ffacd0b85a97d-37cc2479fa9mr1649530f8f.22.1727264142558;
        Wed, 25 Sep 2024 04:35:42 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc32add1sm3713658f8f.114.2024.09.25.04.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 04:35:42 -0700 (PDT)
Message-ID: <66f3f58e.5d0a0220.5d655.b48a@mx.google.com>
X-Google-Original-Message-ID: <ZvP1isSJk2ebHdLz@Ansuel-XPS.>
Date: Wed, 25 Sep 2024 13:35:38 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
	upstream@airoha.com
Subject: Re: [PATCH 2/3] dt-bindings: mtd: Add Documentation for Airoha
 fixed-partitions
References: <20240925101422.8373-1-ansuelsmth@gmail.com>
 <20240925101422.8373-3-ansuelsmth@gmail.com>
 <20240925133003.619c40c4@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925133003.619c40c4@xps-13>

On Wed, Sep 25, 2024 at 01:30:03PM +0200, Miquel Raynal wrote:
> Hi Christian,
> 
> ansuelsmth@gmail.com wrote on Wed, 25 Sep 2024 12:13:58 +0200:
> 
> > Add Documentation for Airoha fixed-partitions compatibles.
> > 
> > Airoha based SoC declare a dedicated partition at the end of the flash to
> > store calibration and device specific data, in addition to fixed
> > partitions.
> > 
> > The offset of this special partition is not well defined as a custom bad
> > block management driver is used that reserve space at the end of the flash.
> > 
> > This binding allows defining all fixed partitions and marking the last one
> > to detect the correct offset.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  .../partitions/airoha,fixed-partitions.yaml   | 80 +++++++++++++++++++
> >  .../bindings/mtd/partitions/partitions.yaml   |  1 +
> >  2 files changed, 81 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
> > new file mode 100644
> > index 000000000000..a45df51065af
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
> > @@ -0,0 +1,80 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mtd/partitions/airoha,fixed-partitions.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Airoha SoC partitioning
> > +
> > +description: |
> > +  Airoha based SoC declare a dedicated partition at the end of the flash to
> > +  store calibration and device specific data, in addition to fixed partitions.
> > +
> > +  The offset of this special partition is not well defined as a custom bad block
> > +  management driver is used that reserve space at the end of the flash.
> > +
> > +  This binding allows defining all fixed partitions and marking the last one to
> > +  detect the correct offset from the new end of the flash.
> > +
> > +maintainers:
> > +  - Christian Marangi <ansuelsmth@gmail.com>
> > +
> > +select: false
> > +
> > +properties:
> > +  compatible:
> > +    const: airoha,fixed-partitions
> > +
> > +  "#address-cells":
> > +    enum: [ 1, 2 ]
> > +
> > +  "#size-cells":
> > +    enum: [ 1, 2 ]
> > +
> > +patternProperties:
> > +  "^partition@[0-9a-f]+$":
> > +    $ref: partition.yaml#
> > +    properties:
> > +      compatible:
> > +        const: airoha,dynamic-art
> > +    unevaluatedProperties: false
> > +
> > +required:
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    partitions {
> > +        compatible = "airoha,fixed-partitions";
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +
> > +        partition@0 {
> > +          label = "bootloader";
> > +          reg = <0x00000000 0x00080000>;
> > +        };
> > +
> > +        partition@80000 {
> > +          label = "tclinux";
> > +          reg = <0x00080000 0x02800000>;
> > +        };
> > +
> > +        partition@2880000 {
> > +          label = "tclinux_slave";
> > +          reg = <0x02880000 0x02800000>;
> > +        };
> > +
> > +        partition@5080000 {
> > +          label = "rootfs_data";
> > +          reg = <0x5080000 0x00800000>;
> > +        };
> > +
> > +        partition@ffffffff {
> > +          compatible = "airoha,dynamic-art";
> > +          label = "art";
> > +          reg = <0xffffffff 0x00300000>;
> 
> I'm a little bit puzzled by this kind of information which is known to
> be wrong. As the partition offset and size must be dynamically
> calculated, this reg property (as well as the size parameter of the
> previous one) are notably wrong. I guess we are not fully constrained
> by the fixed-partitions schema here, so could we avoid the reg property
> in the airoha,dynamic-art partition? Maybe we also need a #define for a
> specific placeholder in the penultimate reg property too (for the size).
>

Maybe instead of reg we can use a property like size?

Can you better elaborate the suggestion about the #define?

Do you mean for case where the last partition might overlap
with the penultimate? Honestly in such case I would error hard, that
case happen when too much space is reserved and that is a
misconfiguration of the system (developer error)

-- 
	Ansuel

