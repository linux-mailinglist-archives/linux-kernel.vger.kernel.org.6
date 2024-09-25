Return-Path: <linux-kernel+bounces-338854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4C5985DA8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3C7284C67
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 13:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB3B20FA9E;
	Wed, 25 Sep 2024 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkhtgBC/"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CE620FA84;
	Wed, 25 Sep 2024 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265979; cv=none; b=QsACReWhUUlLJmSfngdRuMymREqAbvluPREDDCiudBoEb7p+Rzhah/zJDk8SWX4Ju7Cf0SMB8jbOLKz7W2wrpusy7/Yh+4hrhslcLUvsRZel/3YYdveUbg4fE7ZTNgFZ3bG0p+5XYCF/zF3hmYC2ZRj9NH+Yo3ol0GyGbunOAiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265979; c=relaxed/simple;
	bh=Q/0isB8d+PhYppY+RJRI+eI0LimUN2tr5HgwjgRnTWU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ff0r1KOQ4pN8WSrUwMUMXETxAmAwzDL/WvHXemPVYmYE1NyL6NdeEK4vcFrV/3MMeherRSoKR91OA2q8lycXCJ65iOiQBKqNG5LGnKAtFdegGJUYnInCSDirJ0WPBtm0vtInRAVrNq3zHrXaWT468JRMWxIH/Nno0zroUE+3brg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkhtgBC/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-378c16a4d3eso7157614f8f.1;
        Wed, 25 Sep 2024 05:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727265976; x=1727870776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GFGu7JG+fN86SqEPQDV5t2R/+6V1TMtaekXfpbj35vo=;
        b=HkhtgBC/NDPqMQvYqy+rX5svVWIsOOcJFPVik6StjRGYdBgsFx1QxJGnd4lG8be2H0
         eEFWgR5Vq3lAug6M70eLSsuOM9DS5WGjOaS8g/7rV+stsC3L4HTCgRb6GojQ00p4pc1F
         GLD+jcOFKTXu6JRoLpnTwTId7AdzqJYsgzQW2R+lj9XDhINIRmHT1jrIQ4o/JTiEc8b2
         gdvpx9TzIlCDTVVlwOshJIKIVz+VIXCSS/ssWd6+CszTrD/giB/sANQ/4Nic3Ev4deQo
         EgSv/BtI1GvcyoqRpyseuylMZokjIBBtnJeeeW8UHRD9n+GPesS1aNsje/5kZE9zEwDx
         Aing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727265976; x=1727870776;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFGu7JG+fN86SqEPQDV5t2R/+6V1TMtaekXfpbj35vo=;
        b=mjFCSAu6S61uAo7wLMNDUWZJrQ82wSCTYVhzzGpku0gJXbu6xT1xF6YCYSuuRnCwTL
         55rptPPFF+lJHkPgKcQjvc/uQiKnmPzzcOBr5J0Zz9Nc1jN18mKPmlvRJMIm0mmHMVMt
         OI/zLpLtVjfNjlU51oD241FqIs5IYXHCls18xz2DeNGROmZgIayFWqySp6UnFzDzpxct
         Y8tmRBRR3Naqx4sxlRg7nDwRVO+iPvF+l2HLoViL3mIxQABVtl79ud7jTk41VeMpFko8
         7cZJpFgxpLlNrk6MS7VaJgKd+UC/sROaADUT3HqkvXvEbH2UDFzXSHisElu30+paKkzc
         I6ow==
X-Forwarded-Encrypted: i=1; AJvYcCWPbasJGdktQS8khT/SO1tr7j6Jk1ChDS+zPwxjBACSbjXS4aU7QTfsrNZH2Vu0PnqHR67Xzzq1WzjG@vger.kernel.org, AJvYcCX74fooODY0845dmnBVubHLSW0fhdcW/OY0CVbfvKR/0fVWPVNM20uurPm6KxmGXLDdUVpnAU6yAMRTU8/9@vger.kernel.org
X-Gm-Message-State: AOJu0YxbRJX9ABNzwfTjWGLbGUPematB7gvbhKwiyNTrDkxhJQL9tmED
	aK9JFh0gYpYLsctrkVq4dpjuHX1pefsmh1MrW1cEK2J0r/EmTExv
X-Google-Smtp-Source: AGHT+IHui2T3XvdVgwebU7tifxGbADu36lPdixerBRDLTCO+Id/czkCJ54OP+u092S/jZ28BuBXgyg==
X-Received: by 2002:a5d:660a:0:b0:374:bcdc:6257 with SMTP id ffacd0b85a97d-37cc24c687dmr2345251f8f.54.1727265975674;
        Wed, 25 Sep 2024 05:06:15 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2a8b55sm3823201f8f.17.2024.09.25.05.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 05:06:15 -0700 (PDT)
Message-ID: <66f3fcb7.5d0a0220.3ca4c2.ba83@mx.google.com>
X-Google-Original-Message-ID: <ZvP8s3zhrBtvmnYz@Ansuel-XPS.>
Date: Wed, 25 Sep 2024 14:06:11 +0200
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
 <66f3f58e.5d0a0220.5d655.b48a@mx.google.com>
 <20240925135256.32d3a0f7@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925135256.32d3a0f7@xps-13>

On Wed, Sep 25, 2024 at 01:52:56PM +0200, Miquel Raynal wrote:
> Hi Christian,
> 
> ansuelsmth@gmail.com wrote on Wed, 25 Sep 2024 13:35:38 +0200:
> 
> > On Wed, Sep 25, 2024 at 01:30:03PM +0200, Miquel Raynal wrote:
> > > Hi Christian,
> > > 
> > > ansuelsmth@gmail.com wrote on Wed, 25 Sep 2024 12:13:58 +0200:
> > >   
> > > > Add Documentation for Airoha fixed-partitions compatibles.
> > > > 
> > > > Airoha based SoC declare a dedicated partition at the end of the flash to
> > > > store calibration and device specific data, in addition to fixed
> > > > partitions.
> > > > 
> > > > The offset of this special partition is not well defined as a custom bad
> > > > block management driver is used that reserve space at the end of the flash.
> > > > 
> > > > This binding allows defining all fixed partitions and marking the last one
> > > > to detect the correct offset.
> > > > 
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > ---
> > > >  .../partitions/airoha,fixed-partitions.yaml   | 80 +++++++++++++++++++
> > > >  .../bindings/mtd/partitions/partitions.yaml   |  1 +
> > > >  2 files changed, 81 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
> > > > new file mode 100644
> > > > index 000000000000..a45df51065af
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
> > > > @@ -0,0 +1,80 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/mtd/partitions/airoha,fixed-partitions.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Airoha SoC partitioning
> > > > +
> > > > +description: |
> > > > +  Airoha based SoC declare a dedicated partition at the end of the flash to
> > > > +  store calibration and device specific data, in addition to fixed partitions.
> > > > +
> > > > +  The offset of this special partition is not well defined as a custom bad block
> > > > +  management driver is used that reserve space at the end of the flash.
> > > > +
> > > > +  This binding allows defining all fixed partitions and marking the last one to
> > > > +  detect the correct offset from the new end of the flash.
> > > > +
> > > > +maintainers:
> > > > +  - Christian Marangi <ansuelsmth@gmail.com>
> > > > +
> > > > +select: false
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: airoha,fixed-partitions
> > > > +
> > > > +  "#address-cells":
> > > > +    enum: [ 1, 2 ]
> > > > +
> > > > +  "#size-cells":
> > > > +    enum: [ 1, 2 ]
> > > > +
> > > > +patternProperties:
> > > > +  "^partition@[0-9a-f]+$":
> > > > +    $ref: partition.yaml#
> > > > +    properties:
> > > > +      compatible:
> > > > +        const: airoha,dynamic-art
> > > > +    unevaluatedProperties: false
> > > > +
> > > > +required:
> > > > +  - "#address-cells"
> > > > +  - "#size-cells"
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    partitions {
> > > > +        compatible = "airoha,fixed-partitions";
> > > > +        #address-cells = <1>;
> > > > +        #size-cells = <1>;
> > > > +
> > > > +        partition@0 {
> > > > +          label = "bootloader";
> > > > +          reg = <0x00000000 0x00080000>;
> > > > +        };
> > > > +
> > > > +        partition@80000 {
> > > > +          label = "tclinux";
> > > > +          reg = <0x00080000 0x02800000>;
> > > > +        };
> > > > +
> > > > +        partition@2880000 {
> > > > +          label = "tclinux_slave";
> > > > +          reg = <0x02880000 0x02800000>;
> > > > +        };
> > > > +
> > > > +        partition@5080000 {
> > > > +          label = "rootfs_data";
> > > > +          reg = <0x5080000 0x00800000>;
> > > > +        };
> > > > +
> > > > +        partition@ffffffff {
> > > > +          compatible = "airoha,dynamic-art";
> > > > +          label = "art";
> > > > +          reg = <0xffffffff 0x00300000>;  
> > > 
> > > I'm a little bit puzzled by this kind of information which is known to
> > > be wrong. As the partition offset and size must be dynamically
> > > calculated, this reg property (as well as the size parameter of the
> > > previous one) are notably wrong. I guess we are not fully constrained
> > > by the fixed-partitions schema here, so could we avoid the reg property
> > > in the airoha,dynamic-art partition? Maybe we also need a #define for a
> > > specific placeholder in the penultimate reg property too (for the size).
> > >  
> > 
> > Maybe instead of reg we can use a property like size?
> > 
> > Can you better elaborate the suggestion about the #define?
> > 
> > Do you mean for case where the last partition might overlap
> > with the penultimate? Honestly in such case I would error hard, that
> > case happen when too much space is reserved and that is a
> > misconfiguration of the system (developer error)
> 
> That's not what I mean.
> 
> In the above case you say partition "partition@5080000" is 0x800000
> bytes long. This is obviously wrong otherwise you would know where the
> art partition starts. And right after you're saying partition
> "partition@ffffffff" starts at 0xffffffff and is 0x300000 bytes long.
> This is also wrong because 0xffffffff is not a valid start address and
> IIUC 0x300000 is also unknown and dynamically derived.
> 
> So for the art partition my advise if you know nothing about the
> start/length is to just skip the reg property. For the previous
> partition I'd maybe use a definition (whose name is to discuss) instead
> of the wrong size argument (the start offset being correct on his side).
>

Ok probably the description isn't clear enough. The missing info that
require this parser is the flash end.

Following the example we know the size of rootfs_data and start offset
AND we know the size of the ART partition.

There might be a space in the middle unused between the rootfs_data
partition and the art partition. What is derived is the starting offset
of the art partition that is flash end - art partition size.
(where flash end change and is not always the same due to how the special
bad block managament table reserved space is handled)

This is why 0xffffffff, used as a dummy offset to signal it will be parsed at
runtime. On second tought tho maybe using this dummy offset is wrong and
I should just have something like

length = <0x300000>;

Is it clear now? Sorry for any confusion.

-- 
	Ansuel

