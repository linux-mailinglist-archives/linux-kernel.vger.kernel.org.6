Return-Path: <linux-kernel+bounces-345685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A06698B9B3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70A94B21B32
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5101A072D;
	Tue,  1 Oct 2024 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXad7WlA"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401B33209;
	Tue,  1 Oct 2024 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778541; cv=none; b=TjLhn5LJ44F+TAyJ4zn3fpnoQyCYHxKTe9xt5cllpznSYNi+UvSasr2yGYsiErsBdARyqRvNRBQK5ueNuwnFawFVNsWT+wsYgyDEnVJqXd+sS1iOL0avtVteIoMhH/VsonuX4RhIrk3p4uTilFvXNAKlF7WJas3NFd1xsOqB3mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778541; c=relaxed/simple;
	bh=I6Qr/Ob7Ff/m0p/vV8bz76GhU1KYcAYQ3zoI0yMDfcg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ef6pgLda65kol1TvDQJaRc/NEVPjtNQd1EvE7gAGU8AxAzJXL35sBETAlAZWcKfkSqMY8HfWbZ6veZNEnJMKbhdyQBnqL5bW+IQgMLauzhkPaWZGkGkC9pxr5+RB51QX+S429tRgEt0sxrrTIEDfXLm+3jbqLTvUKHCUYudsz1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXad7WlA; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37ccd81de57so3326115f8f.0;
        Tue, 01 Oct 2024 03:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727778537; x=1728383337; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XxxaxknpIr+rYBfvQOLwgicD/hlb/iC9+wZ3tE8jGrk=;
        b=PXad7WlAZvMUdJGxEJbnrjUf1xPZyYRXnG6e43STQ1euMU87S0bjVFMkw5t9Ltppra
         5QZTdWtpp8+tqkry4HPWftkw8Vh2iEN0kIxo5l02X1U0QIofTUx98icCCwWJwxNxOloX
         FKNYOemfIl0Gq213g4B3CbAYVnjAT1YAaGop9KINoP3noHl+uXhinv+CIaOkPTMywZII
         3vIGMTPS4vV+yH0jglQQrEptOMDnt4fJqp9MazBxzygH5PBAh1ahFVgSrO5zeDM0BTYZ
         dXE8xsrEMC3g+uQBIy1HT974Fq5DcBn1T+a5MeAAQwrAr52UDJl0NgH4IgOw/XGandvj
         9yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727778537; x=1728383337;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XxxaxknpIr+rYBfvQOLwgicD/hlb/iC9+wZ3tE8jGrk=;
        b=M0Hy28xPZ5Y6uqQDm6wbAbH6aO2jFjMk4ej5xeZj6EF1lD61mOydsRSt9T+5jitU7u
         39jeOVsPn2FsSkydSSc+HcJfQJ4j6GCSvppttXJYrLZ/hJHiee62njqu/GTk23pOOdgS
         QSSl02nCso1eu/UAIouRre26aCKY29MWnXTnQ+Uz7F/wcf8L/9OdUS6R2tBS5ooVPYog
         RPmBAVDFb0lDO6KclJnN4PHGhtIk99yBNMGQvER8H5S4KJNhT1cEzjlpgMqg75pQOk0R
         pdFMlwkINDT+hHI01tcI8XdLnYrCKqSv0igkVzlVeAPT+1BD8ELPAh+Jd0XM417XrZkB
         nr2A==
X-Forwarded-Encrypted: i=1; AJvYcCVTqZmdtBEUsigwTVfxjopLOlo6FmtFdIASr0Z4C0+Szt0U/fTm9SWyOb+9n5BpI74Rcelf0c8N7A4qNBgv@vger.kernel.org, AJvYcCXBRtH/DfskMEoh4xXZfOESVNKrM/hYNKaqngomwAnnLSN2ylLvZECIHPLqc9NGFa8c7eAZKMjCRE8h@vger.kernel.org
X-Gm-Message-State: AOJu0YxcP+fFYsz8VVtpcfEgp6w/hkbyJIrdLIz1SurbaJ2ssimY/293
	gDLyuDckw2vSq/PNy6uFOpY7XVlOCxYWhpg9AljL4pYfY86QfrNP
X-Google-Smtp-Source: AGHT+IGKollpdraY9TlsQu6ZSshUlo/5yR2eEYDo1CRP7REYF+jzfTN9M2CEbhYPINZAKREV3K3hmg==
X-Received: by 2002:adf:ae19:0:b0:374:cc89:174b with SMTP id ffacd0b85a97d-37cf289c56fmr1384753f8f.4.1727778537127;
        Tue, 01 Oct 2024 03:28:57 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd575de73sm11383189f8f.115.2024.10.01.03.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 03:28:56 -0700 (PDT)
Message-ID: <66fbcee8.df0a0220.2ad0cb.4f6a@mx.google.com>
X-Google-Original-Message-ID: <ZvvO4-N6wVe-f33I@Ansuel-XPS.>
Date: Tue, 1 Oct 2024 12:28:51 +0200
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
 <66fa7915.050a0220.1da288.aeca@mx.google.com>
 <20241001104225.67483dab@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001104225.67483dab@xps-13>

On Tue, Oct 01, 2024 at 10:42:25AM +0200, Miquel Raynal wrote:
> Hi Christian,
> 
> ansuelsmth@gmail.com wrote on Mon, 30 Sep 2024 12:10:21 +0200:
> 
> > On Mon, Sep 30, 2024 at 11:48:19AM +0200, Miquel Raynal wrote:
> > > Hi Christian,
> > > 
> > > ansuelsmth@gmail.com wrote on Wed, 25 Sep 2024 14:06:11 +0200:
> > >   
> > > > On Wed, Sep 25, 2024 at 01:52:56PM +0200, Miquel Raynal wrote:  
> > > > > Hi Christian,
> > > > > 
> > > > > ansuelsmth@gmail.com wrote on Wed, 25 Sep 2024 13:35:38 +0200:
> > > > >     
> > > > > > On Wed, Sep 25, 2024 at 01:30:03PM +0200, Miquel Raynal wrote:    
> > > > > > > Hi Christian,
> > > > > > > 
> > > > > > > ansuelsmth@gmail.com wrote on Wed, 25 Sep 2024 12:13:58 +0200:
> > > > > > >       
> > > > > > > > Add Documentation for Airoha fixed-partitions compatibles.
> > > > > > > > 
> > > > > > > > Airoha based SoC declare a dedicated partition at the end of the flash to
> > > > > > > > store calibration and device specific data, in addition to fixed
> > > > > > > > partitions.
> > > > > > > > 
> > > > > > > > The offset of this special partition is not well defined as a custom bad
> > > > > > > > block management driver is used that reserve space at the end of the flash.
> > > > > > > > 
> > > > > > > > This binding allows defining all fixed partitions and marking the last one
> > > > > > > > to detect the correct offset.
> > > > > > > > 
> > > > > > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > > > > > ---
> > > > > > > >  .../partitions/airoha,fixed-partitions.yaml   | 80 +++++++++++++++++++
> > > > > > > >  .../bindings/mtd/partitions/partitions.yaml   |  1 +
> > > > > > > >  2 files changed, 81 insertions(+)
> > > > > > > >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
> > > > > > > > 
> > > > > > > > diff --git a/Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
> > > > > > > > new file mode 100644
> > > > > > > > index 000000000000..a45df51065af
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
> > > > > > > > @@ -0,0 +1,80 @@
> > > > > > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > > > > > +%YAML 1.2
> > > > > > > > +---
> > > > > > > > +$id: http://devicetree.org/schemas/mtd/partitions/airoha,fixed-partitions.yaml#
> > > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > > +
> > > > > > > > +title: Airoha SoC partitioning
> > > > > > > > +
> > > > > > > > +description: |
> > > > > > > > +  Airoha based SoC declare a dedicated partition at the end of the flash to
> > > > > > > > +  store calibration and device specific data, in addition to fixed partitions.
> > > > > > > > +
> > > > > > > > +  The offset of this special partition is not well defined as a custom bad block
> > > > > > > > +  management driver is used that reserve space at the end of the flash.
> > > > > > > > +
> > > > > > > > +  This binding allows defining all fixed partitions and marking the last one to
> > > > > > > > +  detect the correct offset from the new end of the flash.
> > > > > > > > +
> > > > > > > > +maintainers:
> > > > > > > > +  - Christian Marangi <ansuelsmth@gmail.com>
> > > > > > > > +
> > > > > > > > +select: false
> > > > > > > > +
> > > > > > > > +properties:
> > > > > > > > +  compatible:
> > > > > > > > +    const: airoha,fixed-partitions
> > > > > > > > +
> > > > > > > > +  "#address-cells":
> > > > > > > > +    enum: [ 1, 2 ]
> > > > > > > > +
> > > > > > > > +  "#size-cells":
> > > > > > > > +    enum: [ 1, 2 ]
> > > > > > > > +
> > > > > > > > +patternProperties:
> > > > > > > > +  "^partition@[0-9a-f]+$":
> > > > > > > > +    $ref: partition.yaml#
> > > > > > > > +    properties:
> > > > > > > > +      compatible:
> > > > > > > > +        const: airoha,dynamic-art
> > > > > > > > +    unevaluatedProperties: false
> > > > > > > > +
> > > > > > > > +required:
> > > > > > > > +  - "#address-cells"
> > > > > > > > +  - "#size-cells"
> > > > > > > > +
> > > > > > > > +additionalProperties: false
> > > > > > > > +
> > > > > > > > +examples:
> > > > > > > > +  - |
> > > > > > > > +    partitions {
> > > > > > > > +        compatible = "airoha,fixed-partitions";
> > > > > > > > +        #address-cells = <1>;
> > > > > > > > +        #size-cells = <1>;
> > > > > > > > +
> > > > > > > > +        partition@0 {
> > > > > > > > +          label = "bootloader";
> > > > > > > > +          reg = <0x00000000 0x00080000>;
> > > > > > > > +        };
> > > > > > > > +
> > > > > > > > +        partition@80000 {
> > > > > > > > +          label = "tclinux";
> > > > > > > > +          reg = <0x00080000 0x02800000>;
> > > > > > > > +        };
> > > > > > > > +
> > > > > > > > +        partition@2880000 {
> > > > > > > > +          label = "tclinux_slave";
> > > > > > > > +          reg = <0x02880000 0x02800000>;
> > > > > > > > +        };
> > > > > > > > +
> > > > > > > > +        partition@5080000 {
> > > > > > > > +          label = "rootfs_data";
> > > > > > > > +          reg = <0x5080000 0x00800000>;
> > > > > > > > +        };
> > > > > > > > +
> > > > > > > > +        partition@ffffffff {
> > > > > > > > +          compatible = "airoha,dynamic-art";
> > > > > > > > +          label = "art";
> > > > > > > > +          reg = <0xffffffff 0x00300000>;      
> > > > > > > 
> > > > > > > I'm a little bit puzzled by this kind of information which is known to
> > > > > > > be wrong. As the partition offset and size must be dynamically
> > > > > > > calculated, this reg property (as well as the size parameter of the
> > > > > > > previous one) are notably wrong. I guess we are not fully constrained
> > > > > > > by the fixed-partitions schema here, so could we avoid the reg property
> > > > > > > in the airoha,dynamic-art partition? Maybe we also need a #define for a
> > > > > > > specific placeholder in the penultimate reg property too (for the size).
> > > > > > >      
> > > > > > 
> > > > > > Maybe instead of reg we can use a property like size?
> > > > > > 
> > > > > > Can you better elaborate the suggestion about the #define?
> > > > > > 
> > > > > > Do you mean for case where the last partition might overlap
> > > > > > with the penultimate? Honestly in such case I would error hard, that
> > > > > > case happen when too much space is reserved and that is a
> > > > > > misconfiguration of the system (developer error)    
> > > > > 
> > > > > That's not what I mean.
> > > > > 
> > > > > In the above case you say partition "partition@5080000" is 0x800000
> > > > > bytes long. This is obviously wrong otherwise you would know where the
> > > > > art partition starts. And right after you're saying partition
> > > > > "partition@ffffffff" starts at 0xffffffff and is 0x300000 bytes long.
> > > > > This is also wrong because 0xffffffff is not a valid start address and
> > > > > IIUC 0x300000 is also unknown and dynamically derived.
> > > > > 
> > > > > So for the art partition my advise if you know nothing about the
> > > > > start/length is to just skip the reg property. For the previous
> > > > > partition I'd maybe use a definition (whose name is to discuss) instead
> > > > > of the wrong size argument (the start offset being correct on his side).
> > > > >    
> > > > 
> > > > Ok probably the description isn't clear enough. The missing info that
> > > > require this parser is the flash end.
> > > > 
> > > > Following the example we know the size of rootfs_data and start offset
> > > > AND we know the size of the ART partition.
> > > > 
> > > > There might be a space in the middle unused between the rootfs_data
> > > > partition and the art partition. What is derived is the starting offset
> > > > of the art partition that is flash end - art partition size.
> > > > (where flash end change and is not always the same due to how the special
> > > > bad block managament table reserved space is handled)
> > > > 
> > > > This is why 0xffffffff, used as a dummy offset to signal it will be parsed at
> > > > runtime. On second tought tho maybe using this dummy offset is wrong and
> > > > I should just have something like
> > > > 
> > > > length = <0x300000>;
> > > > 
> > > > Is it clear now? Sorry for any confusion.  
> > > 
> > > I'm sorry but not really. You know the end of the physical device and
> > > the size of the ART partition, so you must know its start as well?
> > >  
> > 
> > Before the system boot we know:
> > - size of the ART partition
> > - real size of the physical device (512mb... 1G... 64mb...)
> > 
> > When the physical device is probed (nand) a special driver is loaded
> > (before mtd parsing logic) that change the physical size of the device
> > (mtd->size) as at the end of the nand some space is reserved for bad
> > block management and other metadata info.
> 
> Here you are explaining what you intend Linux to do, right? I would
> like to understand what you are trying to solve. I dont understand why
> you need the size change, I don't understand why you don't know the
> start of the ART partition, I don't understand what the data you are
> hiding contains and who uses it :-) I'm sorry, this is too unclear yet.

Totally not a problem and thanks a lot for you keep asking them... More
than happy to clear things, I'm trying to solve a problem present on
Airoha SoC and upstreaming a correct parser for it.

What I'm trying to solve:

Correct access to this partition at the end of the flash in an automated
way.

The content of this partition is the usual ART partition found on lots of
embedded devices. MAC address, wifi calibration data, serial. Usage is
NVMEM cells and userspace with dd command to extract data from.

Airoha use something also used by some mediatek SoC. They call it BMT
and it's currently used downstream in OpenWrt and they firmware. This is
also used in the bootloader.

The usage of BMT is a custom way to handle bad blocks entirely by
software. At the end of the flash some space is reserved where info
about all the blocks of the flash are put. I'm not 100% sure about the
functionality of this but it can relocate block and do magic things to
handle bad blocks. For the scope of this change, the important info is
that after the BMT is probed, the operation of "reserving space" is done
by reducing the MTD flash size. So from the MTD subsystem, it does see a
smaller flash than it actually is.

The reserved space change! Across SoC or even devices but the BMT is a
must where it's used as bootloader makes use of it and writing to it
might confuse the bootloader corrupting data. (one block might be
flagged as bad ad data moved, BMT driver validates his table and do
operation)

We discover this the hard way at times with firmware getting corrupted
on upgrading it.

The intention of this parser is to handle this problem transparently and
easier.

The Airoha partition scheme always follow this logic:
- bootloader
- fit image (kernel+rootfs)
- fit image backup (kernel+rootfs) (optional)
- rootfs_data
- opaque data (no partition)
- ART partition (end of partition = start of reserved BMT)
- BMT reserved space
- end of flash

What I'm trying to solve is making it easy to calculate the offset of
the partition written before the BMT reserved space.

Feel free to ask more question about this and again thanks the help in
figuring this out.

> 
> Quoting your cover letter:
> 
> 	"This require dynamic calculation of the offset as some
> 	dedicated driver for bad block management might be used that
> 	reserve some space at the end of the flash for bad block
> 	accounting. This special driver change the end offset of the
> 	flash hence a dynamic parser is needed."
> 
> I don't know what this "dedicated driver" is, I don't understand why it
> is needed.

I hope it's clear what is the usage of this driver now. (In short a
software way to handle bad block from Mediatek that propagated to Airoha)

> 
> > So on the mtd parsing logic we know:
> > - size of the ART partitiomn
> > - new size of the physical device (512-reserved space...)
> > 
> > And we calculate the start offset of the ART partition.
> > 
> > It's very difficult to know what is the new size of the physical device
> > after the driver change it as it might change based on the internal
> > configuration of the driver itself.
> 
> Thanks,
> Miquèl

-- 
	Ansuel

