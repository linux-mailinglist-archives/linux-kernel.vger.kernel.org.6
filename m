Return-Path: <linux-kernel+bounces-367461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A77599A02AB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA42E1C246F5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C5A1C175C;
	Wed, 16 Oct 2024 07:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fv1F72xe"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFE71C07E7;
	Wed, 16 Oct 2024 07:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064035; cv=none; b=rm7ZcLNtIqYyaxJ97rJr1plqTYLzGiyxxzTxGXz3aRRTtHxzte9eYn1rNdyWAGz7G+HeBgXH7Qpz5vF5tOwVxmv+B9J2k37hLGB1eQ7le5KL312U/ylUsc0NPcZoGTo/2ZCXWtrt/e/2EXgwppd43Cjxzf3jxuuzCqHdPu1uc4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064035; c=relaxed/simple;
	bh=jbnl5zFtd/AmhSVbB2QtMeNIBRDEF4ErAIc4LWkYZIw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPBnlBVOFAVhirCoicCwpEQ0ROc9I/Or76Xmn5wrO5+bQm+M9nM2RUb4Wdc1mQPkvcF1K62q7uj7gmuWkmG27JYz4Gubskkct6RDnyI7ccoeBzY+MyJNRqWHnzaJniDeFBM/0Dl93/lDzxXryMjUiWJAkQlps8n+AVMCMNJZkBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fv1F72xe; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c96b2a10e1so5349575a12.2;
        Wed, 16 Oct 2024 00:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729064031; x=1729668831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cXa1hSmQlBz3jTyKXhPdDBCqIFGgPKP+x3HVoQSXBrA=;
        b=fv1F72xe1dDYYOV/EWWH9z/KrWVNolRkQLukAd8Fg1XnxdC7lp61T6XefWamnJ99Ng
         AWDDW7o3ocfW30RSFpKGQbBtAxzNaEm6BdMwegUW30lHmvHUPkZteKMRLIpZgvdAFnUY
         EF3ZKtQwY6FhVhyd1cD73RjZ8/vrsl+3caRHzS1ke535wstssszhczfjAw5AvG5gR+Vh
         2S7wCrqEnvAsSLMTLSV8kXBmZr5wYmXDutduaPaGwUNpuB62PCaA8bbDxd9GNNIChHkR
         K/+m5YiIwtZvdUYtD97ZkwTMC1XqysepffXQqFADX2BhZYyTS5wS5eS7KBKRhqNNoChi
         JWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729064031; x=1729668831;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXa1hSmQlBz3jTyKXhPdDBCqIFGgPKP+x3HVoQSXBrA=;
        b=xDZqIN2OH7Xpo1mwRVETUIv0VqKcSMti/T27i5ZrhpxO6sWS3t6tNuhLgDYeE0Ip7s
         1Bc+tludCy368lRaAcJetqAFJ61fQZsD1mVcKpDAwoKeMGwc74/dTQhWp8/wyjJx+wr5
         1+rsUUhdsc6iEMAaO0kDC1OHcspYvgdFZseApS4JDZ4Q6EGRVUrRwvgHW3vDIIW598A7
         O5EL1R3vSqE3q84iCMuyHwIki6mC8C1hDMWuMwo53YUuxHNCAPQ1kWClDydNlhwkRcng
         E1bUYr2nYHTvR2IKBJTie3cG4qoVuOI2wCwD9STD+t08HXkr1+Zz+tURUeM4nt3MpTqr
         hbsg==
X-Forwarded-Encrypted: i=1; AJvYcCUSeTAXbi2O2lYgSalO3SLSB9KuVgJrdvAS8RQsljdgbwkX/gSCdFHmXYy+UBfH3eyu05/Td+8w2nDErBL6@vger.kernel.org, AJvYcCWpZTGaBcTvMyYUu6CKEIIkSUb9nQlBIRhnUPJQLkxfEbDsqv6lUNJKnWQjjjbXLQe8QyPMQjdBVii7@vger.kernel.org
X-Gm-Message-State: AOJu0YxetJjyCGCFQE5o3GqPI7FjEkS5O7vwwjPckZbTEbRqZ051ByBB
	mPR1wYuEPTy1PP+eFCXQHbuqsxC+4FnAQdRpp2ZDoUgLcL4evL9b
X-Google-Smtp-Source: AGHT+IHjg+HCf0vA3R+CEKZXyod/7JNMTqttYepOdFYYHMkdEMBARuAb7yvcJsVGJ6k7L44AOzsbeA==
X-Received: by 2002:a17:907:c8a2:b0:a9a:161:8da4 with SMTP id a640c23a62f3a-a9a34f0d1ebmr238639766b.55.1729064031009;
        Wed, 16 Oct 2024 00:33:51 -0700 (PDT)
Received: from Ansuel-XPS. ([176.200.96.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2971715fsm148567266b.26.2024.10.16.00.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 00:33:50 -0700 (PDT)
Message-ID: <670f6c5e.170a0220.373da5.7bb7@mx.google.com>
X-Google-Original-Message-ID: <Zw9sWo8pfBocRc1T@Ansuel-XPS.>
Date: Wed, 16 Oct 2024 09:33:46 +0200
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
References: <20240925101422.8373-3-ansuelsmth@gmail.com>
 <20240925133003.619c40c4@xps-13>
 <66f3f58e.5d0a0220.5d655.b48a@mx.google.com>
 <20240925135256.32d3a0f7@xps-13>
 <66f3fcb7.5d0a0220.3ca4c2.ba83@mx.google.com>
 <20240930114819.609f9341@xps-13>
 <66fa7915.050a0220.1da288.aeca@mx.google.com>
 <20241001104225.67483dab@xps-13>
 <66fbcee8.df0a0220.2ad0cb.4f6a@mx.google.com>
 <20241002100006.5995fd10@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002100006.5995fd10@xps-13>

On Wed, Oct 02, 2024 at 10:00:06AM +0200, Miquel Raynal wrote:
> Hi Christian,
> 
> > > > > > Ok probably the description isn't clear enough. The missing info that
> > > > > > require this parser is the flash end.
> > > > > > 
> > > > > > Following the example we know the size of rootfs_data and start offset
> > > > > > AND we know the size of the ART partition.
> > > > > > 
> > > > > > There might be a space in the middle unused between the rootfs_data
> > > > > > partition and the art partition. What is derived is the starting offset
> > > > > > of the art partition that is flash end - art partition size.
> > > > > > (where flash end change and is not always the same due to how the special
> > > > > > bad block managament table reserved space is handled)
> > > > > > 
> > > > > > This is why 0xffffffff, used as a dummy offset to signal it will be parsed at
> > > > > > runtime. On second tought tho maybe using this dummy offset is wrong and
> > > > > > I should just have something like
> > > > > > 
> > > > > > length = <0x300000>;
> > > > > > 
> > > > > > Is it clear now? Sorry for any confusion.    
> > > > > 
> > > > > I'm sorry but not really. You know the end of the physical device and
> > > > > the size of the ART partition, so you must know its start as well?
> > > > >    
> > > > 
> > > > Before the system boot we know:
> > > > - size of the ART partition
> > > > - real size of the physical device (512mb... 1G... 64mb...)
> > > > 
> > > > When the physical device is probed (nand) a special driver is loaded
> > > > (before mtd parsing logic) that change the physical size of the device
> > > > (mtd->size) as at the end of the nand some space is reserved for bad
> > > > block management and other metadata info.  
> > > 
> > > Here you are explaining what you intend Linux to do, right? I would
> > > like to understand what you are trying to solve. I dont understand why
> > > you need the size change, I don't understand why you don't know the
> > > start of the ART partition, I don't understand what the data you are
> > > hiding contains and who uses it :-) I'm sorry, this is too unclear yet.  
> > 
> > Totally not a problem and thanks a lot for you keep asking them... More
> > than happy to clear things, I'm trying to solve a problem present on
> > Airoha SoC and upstreaming a correct parser for it.
> > 
> > What I'm trying to solve:
> > 
> > Correct access to this partition at the end of the flash in an automated
> > way.
> > 
> > The content of this partition is the usual ART partition found on lots of
> > embedded devices. MAC address, wifi calibration data, serial. Usage is
> > NVMEM cells and userspace with dd command to extract data from.
> > 
> > Airoha use something also used by some mediatek SoC. They call it BMT
> > and it's currently used downstream in OpenWrt and they firmware. This is
> > also used in the bootloader.
> > 
> > The usage of BMT is a custom way to handle bad blocks entirely by
> > software. At the end of the flash some space is reserved where info
> > about all the blocks of the flash are put. I'm not 100% sure about the
> > functionality of this but it can relocate block and do magic things to
> > handle bad blocks. For the scope of this change, the important info is
> > that after the BMT is probed, the operation of "reserving space" is done
> > by reducing the MTD flash size. So from the MTD subsystem, it does see a
> > smaller flash than it actually is.
> > 
> > The reserved space change! Across SoC or even devices but the BMT is a
> > must where it's used as bootloader makes use of it and writing to it
> > might confuse the bootloader corrupting data. (one block might be
> > flagged as bad ad data moved, BMT driver validates his table and do
> > operation)
> 
> Ok, I think that's way clearer now.
>

Hi sorry for the delay, very happy this is better now.

> So the BMT driver does not exist in mainline Linux, but you would like
> to skip this part of the MTD device to avoid smashing it. And it is in
> use by the vendor Bootloader I guess?

Yes correct, idea is to permit easier access to the partition. I hope
(and assume) this driver will come upstream.

> 
> Is it some kind of table that is written by the chip itself in order to
> maintain a list of auto-replacement blocks for bad blocks? Can the size
> of this table move with the use of the device? (if yes, it's
> problematic, we don't want to resize MTD partitions without noticing,
> it would break eg. UBI).
> 

No chip hw bad block is disabled with this implementation and the table
size doesn't move/change so MTD partitions will stay at the same offset
after the first parse on boot.

> I believe this BMT block is going against the bad block handling in
> Linux, so I really wonder how one can use both mechanisms in a system.
> If the BMT layer takes "one random block" to map a corrupted one on it,
> it totally defeats the current bad block model we have in MTD/UBI
> and simply cannot be supported at all. Just skipping the
> currently-used-for-BMT blocks sounds like a very bad idea that will
> break your system, later.
>

Well we disable it and since it's reserved, from the system side you can
do all kind of magic since the space used for the driver is not
available to the system but I will try to gather more info about this in
the next few days.

-- 
	Ansuel

