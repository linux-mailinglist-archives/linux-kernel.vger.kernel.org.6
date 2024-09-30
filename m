Return-Path: <linux-kernel+bounces-343757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F791989F1D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D471C21B84
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86235189902;
	Mon, 30 Sep 2024 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4NH+Bth"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDECF183098;
	Mon, 30 Sep 2024 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727691033; cv=none; b=PLwDTQMin8kFCOudYamHNbE2rWeLP+Lnkllp8yRHXD0yqrTCVoyC7uwxhAbq6L3BKOdgXPt0aR5UJBQP9MV40H1lzmwzHUpxmw0fOmIUDxlXEY/e0A2ELs/XbrwojubaFw/XWKO90kAsNGhrLp+Oe6iEprx0d+6iUSA3LG0LXFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727691033; c=relaxed/simple;
	bh=IK+SuzHiGxVHRL4chgXp/d4YfwTVWJxQn9hzmkDfWw8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwEfZM9kqeOB6qqWvDEZWvgbHBBjJBPTpOTs3SiqhAXRZ04gh0SyESi9Rawuty1/R1p5bqDcm7yepW0hg1ZTO6aR1HBPe4hz2Jj3CJE7+yVEwGwajv1VqjiKVhABhvc4nOdGzYxMkjG5q2PYYbEsyPy7VUUgaSU/76ihGQAzTu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4NH+Bth; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so31907215e9.3;
        Mon, 30 Sep 2024 03:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727691030; x=1728295830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y8rM4vaCgNhaV0OL1RGwyXhfJ2KpUtBg+F/ROraRtak=;
        b=W4NH+Bthj/sDICrY2vIv7nyz03+pdqoos5hUoC09jf0XLPxwIMBqZEl+rqoKl3Ejy5
         SnBfVvvWwDgnAlYKlKYkzwQ33u6b6GXoMapvYMtNN1kyR7ZUQMW25/YmtlmeKjwMFV21
         VLJPuXt9YEGS2kDjb78Jmhjr/09yFvZLzrcTVrtuZsZygFvqga1PLJF919wT9FroDNd+
         qmZH8rKmAGJoZpgUSAJ9ZklJKuT9J6xmNexvZLhN1hq6aqiiFud2vrFAuYeIDU6wAwrC
         xHvAi5Jv62/hB6rfdYDkrFMZkXzO2l5kMQs6KZ7prajYvdJXLoIeF4VGeWRt7KfSgiTh
         PH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727691030; x=1728295830;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8rM4vaCgNhaV0OL1RGwyXhfJ2KpUtBg+F/ROraRtak=;
        b=SNU/BVA+xqG2B0By3Ig2thA3WDBtCFRQQMhCuIUqSo9reAA5xHNg5bQF7h+d+vg28T
         gep3HP7kc5bJZAjLmaV8BYpE7ab7sIedOEJslQz5rBT074gOdb0ju/N6EfX1J2UDx3G/
         oR8zbhNvMYygkAbmi8X14vJzIH/WBeqKTDvYszoB4YwrGZ+rMN9u3NkCdBLV+HaDM+AI
         n1XRGasYbjalxhhW3KNviAGN2YZyiK8+GNU9cmrcWjqMsGkG+OS/4AbGsM/qhT3F2P2e
         cq8cjR/07YeFBYK4u9/aH75WHy+lIJ3m2yTCrCumyi+epytYhPtrQTtUQw1QYMW3ccR2
         k1qg==
X-Forwarded-Encrypted: i=1; AJvYcCUl65QmdTdpcHR7xfRaopdKgZo8UVbFSHs7yjybYWwkL9Wv831Pv8F/woqK6UZMBaSsqNELzW29Sm4ucsNf@vger.kernel.org, AJvYcCWMGBBhrJbzzG03cC49/IpHrNqpkp31jVZeN1ixvUB+dW+kBdXkBw0jrO7CQN3dF6s2owc78a5yaQZa@vger.kernel.org
X-Gm-Message-State: AOJu0YysfoilPUuIptly3ST53pKlQfTpZCk5bH+sxh7I69oN9+ctwhxn
	m931+pEQpHrjp0XETMagv2tWJuRwDIXPZEGYeJZMUcE83CqHGiDC
X-Google-Smtp-Source: AGHT+IForZE+pZqxxqdfv6Tm5Wx3aKxtf2heafNKQrlGZqGJXBKs6oQZ0PV9/fIbGL4uQ3QmDirm7A==
X-Received: by 2002:a05:600c:3ca6:b0:426:6710:223c with SMTP id 5b1f17b1804b1-42f584128f9mr78677545e9.9.1727691029809;
        Mon, 30 Sep 2024 03:10:29 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd575e322sm8597501f8f.110.2024.09.30.03.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 03:10:29 -0700 (PDT)
Message-ID: <66fa7915.050a0220.1da288.aeca@mx.google.com>
X-Google-Original-Message-ID: <Zvp5DQVxOxhe5bGk@Ansuel-XPS.>
Date: Mon, 30 Sep 2024 12:10:21 +0200
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
 <66f3fcb7.5d0a0220.3ca4c2.ba83@mx.google.com>
 <20240930114819.609f9341@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930114819.609f9341@xps-13>

On Mon, Sep 30, 2024 at 11:48:19AM +0200, Miquel Raynal wrote:
> Hi Christian,
> 
> ansuelsmth@gmail.com wrote on Wed, 25 Sep 2024 14:06:11 +0200:
> 
> > On Wed, Sep 25, 2024 at 01:52:56PM +0200, Miquel Raynal wrote:
> > > Hi Christian,
> > > 
> > > ansuelsmth@gmail.com wrote on Wed, 25 Sep 2024 13:35:38 +0200:
> > >   
> > > > On Wed, Sep 25, 2024 at 01:30:03PM +0200, Miquel Raynal wrote:  
> > > > > Hi Christian,
> > > > > 
> > > > > ansuelsmth@gmail.com wrote on Wed, 25 Sep 2024 12:13:58 +0200:
> > > > >     
> > > > > > Add Documentation for Airoha fixed-partitions compatibles.
> > > > > > 
> > > > > > Airoha based SoC declare a dedicated partition at the end of the flash to
> > > > > > store calibration and device specific data, in addition to fixed
> > > > > > partitions.
> > > > > > 
> > > > > > The offset of this special partition is not well defined as a custom bad
> > > > > > block management driver is used that reserve space at the end of the flash.
> > > > > > 
> > > > > > This binding allows defining all fixed partitions and marking the last one
> > > > > > to detect the correct offset.
> > > > > > 
> > > > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > > > ---
> > > > > >  .../partitions/airoha,fixed-partitions.yaml   | 80 +++++++++++++++++++
> > > > > >  .../bindings/mtd/partitions/partitions.yaml   |  1 +
> > > > > >  2 files changed, 81 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
> > > > > > 
> > > > > > diff --git a/Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
> > > > > > new file mode 100644
> > > > > > index 000000000000..a45df51065af
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
> > > > > > @@ -0,0 +1,80 @@
> > > > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > > > +%YAML 1.2
> > > > > > +---
> > > > > > +$id: http://devicetree.org/schemas/mtd/partitions/airoha,fixed-partitions.yaml#
> > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > +
> > > > > > +title: Airoha SoC partitioning
> > > > > > +
> > > > > > +description: |
> > > > > > +  Airoha based SoC declare a dedicated partition at the end of the flash to
> > > > > > +  store calibration and device specific data, in addition to fixed partitions.
> > > > > > +
> > > > > > +  The offset of this special partition is not well defined as a custom bad block
> > > > > > +  management driver is used that reserve space at the end of the flash.
> > > > > > +
> > > > > > +  This binding allows defining all fixed partitions and marking the last one to
> > > > > > +  detect the correct offset from the new end of the flash.
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - Christian Marangi <ansuelsmth@gmail.com>
> > > > > > +
> > > > > > +select: false
> > > > > > +
> > > > > > +properties:
> > > > > > +  compatible:
> > > > > > +    const: airoha,fixed-partitions
> > > > > > +
> > > > > > +  "#address-cells":
> > > > > > +    enum: [ 1, 2 ]
> > > > > > +
> > > > > > +  "#size-cells":
> > > > > > +    enum: [ 1, 2 ]
> > > > > > +
> > > > > > +patternProperties:
> > > > > > +  "^partition@[0-9a-f]+$":
> > > > > > +    $ref: partition.yaml#
> > > > > > +    properties:
> > > > > > +      compatible:
> > > > > > +        const: airoha,dynamic-art
> > > > > > +    unevaluatedProperties: false
> > > > > > +
> > > > > > +required:
> > > > > > +  - "#address-cells"
> > > > > > +  - "#size-cells"
> > > > > > +
> > > > > > +additionalProperties: false
> > > > > > +
> > > > > > +examples:
> > > > > > +  - |
> > > > > > +    partitions {
> > > > > > +        compatible = "airoha,fixed-partitions";
> > > > > > +        #address-cells = <1>;
> > > > > > +        #size-cells = <1>;
> > > > > > +
> > > > > > +        partition@0 {
> > > > > > +          label = "bootloader";
> > > > > > +          reg = <0x00000000 0x00080000>;
> > > > > > +        };
> > > > > > +
> > > > > > +        partition@80000 {
> > > > > > +          label = "tclinux";
> > > > > > +          reg = <0x00080000 0x02800000>;
> > > > > > +        };
> > > > > > +
> > > > > > +        partition@2880000 {
> > > > > > +          label = "tclinux_slave";
> > > > > > +          reg = <0x02880000 0x02800000>;
> > > > > > +        };
> > > > > > +
> > > > > > +        partition@5080000 {
> > > > > > +          label = "rootfs_data";
> > > > > > +          reg = <0x5080000 0x00800000>;
> > > > > > +        };
> > > > > > +
> > > > > > +        partition@ffffffff {
> > > > > > +          compatible = "airoha,dynamic-art";
> > > > > > +          label = "art";
> > > > > > +          reg = <0xffffffff 0x00300000>;    
> > > > > 
> > > > > I'm a little bit puzzled by this kind of information which is known to
> > > > > be wrong. As the partition offset and size must be dynamically
> > > > > calculated, this reg property (as well as the size parameter of the
> > > > > previous one) are notably wrong. I guess we are not fully constrained
> > > > > by the fixed-partitions schema here, so could we avoid the reg property
> > > > > in the airoha,dynamic-art partition? Maybe we also need a #define for a
> > > > > specific placeholder in the penultimate reg property too (for the size).
> > > > >    
> > > > 
> > > > Maybe instead of reg we can use a property like size?
> > > > 
> > > > Can you better elaborate the suggestion about the #define?
> > > > 
> > > > Do you mean for case where the last partition might overlap
> > > > with the penultimate? Honestly in such case I would error hard, that
> > > > case happen when too much space is reserved and that is a
> > > > misconfiguration of the system (developer error)  
> > > 
> > > That's not what I mean.
> > > 
> > > In the above case you say partition "partition@5080000" is 0x800000
> > > bytes long. This is obviously wrong otherwise you would know where the
> > > art partition starts. And right after you're saying partition
> > > "partition@ffffffff" starts at 0xffffffff and is 0x300000 bytes long.
> > > This is also wrong because 0xffffffff is not a valid start address and
> > > IIUC 0x300000 is also unknown and dynamically derived.
> > > 
> > > So for the art partition my advise if you know nothing about the
> > > start/length is to just skip the reg property. For the previous
> > > partition I'd maybe use a definition (whose name is to discuss) instead
> > > of the wrong size argument (the start offset being correct on his side).
> > >  
> > 
> > Ok probably the description isn't clear enough. The missing info that
> > require this parser is the flash end.
> > 
> > Following the example we know the size of rootfs_data and start offset
> > AND we know the size of the ART partition.
> > 
> > There might be a space in the middle unused between the rootfs_data
> > partition and the art partition. What is derived is the starting offset
> > of the art partition that is flash end - art partition size.
> > (where flash end change and is not always the same due to how the special
> > bad block managament table reserved space is handled)
> > 
> > This is why 0xffffffff, used as a dummy offset to signal it will be parsed at
> > runtime. On second tought tho maybe using this dummy offset is wrong and
> > I should just have something like
> > 
> > length = <0x300000>;
> > 
> > Is it clear now? Sorry for any confusion.
> 
> I'm sorry but not really. You know the end of the physical device and
> the size of the ART partition, so you must know its start as well?
>

Before the system boot we know:
- size of the ART partition
- real size of the physical device (512mb... 1G... 64mb...)

When the physical device is probed (nand) a special driver is loaded
(before mtd parsing logic) that change the physical size of the device
(mtd->size) as at the end of the nand some space is reserved for bad
block management and other metadata info.

So on the mtd parsing logic we know:
- size of the ART partitiomn
- new size of the physical device (512-reserved space...)

And we calculate the start offset of the ART partition.

It's very difficult to know what is the new size of the physical device
after the driver change it as it might change based on the internal
configuration of the driver itself.

-- 
	Ansuel

