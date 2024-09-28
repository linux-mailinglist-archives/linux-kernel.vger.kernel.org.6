Return-Path: <linux-kernel+bounces-342462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047D2988F57
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F3F1C20C8F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 13:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A067187FF4;
	Sat, 28 Sep 2024 13:09:25 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B299F200DE;
	Sat, 28 Sep 2024 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727528965; cv=none; b=VXL/gMJuRBGHt2w/+vPhjzWg7jIAKMYJWKQ57Dd6rLZzMO5lS+lTSzxAsdtucjwG1yeguu79HMEizBW90KUpXcfkJ53KVHqXr59Swm2unO4Wo6RgVI7IJj1qO9T+cwmfJ9qK422DOO8RqRIPPZUi/QZk43jx8G86kZCUnp9HU+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727528965; c=relaxed/simple;
	bh=Dnj/3TqDRIHirYW16pi07Q3xMmjdFgG+2bzyI+ao4Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sb4R3GBbDRVpZemlv2vDf6cEx5jdAimJvy1r3dr1+/ca+/l0Hb8Npgb/6qfkQ9B60aP+wpljOjEibjBluHVnLpg2XcKZch4PzLqqWT0nI55pJgexPZFXGFOHixNQxsff/zyVqOmU66zZ7Djh5KWMoWq/wIQA2bsOO++OUZ4njpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1suXCD-000000004YR-36QG;
	Sat, 28 Sep 2024 13:09:13 +0000
Date: Sat, 28 Sep 2024 14:09:07 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	John Crispin <john@phrozen.org>, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] dt-bindings: mtd: ubi-volume: add
 'volume-is-critical' property
Message-ID: <Zvf_84xxhxwpPgee@makrotopia.org>
References: <e0936674dd1d6c98322e35831b8f0538a5cfa7a3.1727527457.git.daniel@makrotopia.org>
 <7a2e8819-ac70-4070-a731-53994c72cd79@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a2e8819-ac70-4070-a731-53994c72cd79@kernel.org>

On Sat, Sep 28, 2024 at 03:02:47PM +0200, Krzysztof Kozlowski wrote:
> On 28/09/2024 14:47, Daniel Golle wrote:
> > Add the 'volume-is-critical' boolean property which marks a UBI volume
> > as critical for the device to boot. If set it prevents the user from
> > all kinds of write access to the volume as well as from renaming it or
> > detaching the UBI device it is located on.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  .../devicetree/bindings/mtd/partitions/ubi-volume.yaml   | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml b/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
> > index 19736b26056b..2bd751bb7f9e 100644
> > --- a/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
> > @@ -29,6 +29,15 @@ properties:
> >      description:
> >        This container may reference an NVMEM layout parser.
> >  
> > +  volume-is-critical:
> > +    description: This parameter, if present, indicates that the UBI volume
> > +      contains early-boot firmware images or data which should not be clobbered.
> > +      If set, it prevents the user from renaming the volume, writing to it or
> > +      making any changes affecting it, as well as detaching the UBI device it is
> > +      located on, so direct access to the underlying MTD device is prevented as
> > +      well.
> > +    type: boolean
> 
> UBI volumes are mapping to partitions 1-to-1, right? So rather I would
> propose to use partition.yaml - we already have read-only there with
> very similar description.

No, that's not the case.

An MTD partition can be used as UBI device. A UBI device (and hence MTD
partition) can host *several* UBI volumes.

Marking the MTD partition as 'read-only' won't work, as UBI needs
read-write access to perform bad block relocation, scrubbing, ...

Also, typically not all UBI volumes on a UBI device are
read-only/critical but only a subset of them.

But you are right that the description is inspired by the description
of the 'read-only' property in partition.yaml ;)

I initially thought to also name the property 'read-only', just like
for MTD partitions. However, as the desired effect goes beyond
preventing write access to the volume itself, I thought it'd be
better to use a new name.

