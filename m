Return-Path: <linux-kernel+bounces-567480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 759CAA6869E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E2C19C0BAF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42D3250C00;
	Wed, 19 Mar 2025 08:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jq/0SFTb"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499C42505C4;
	Wed, 19 Mar 2025 08:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372485; cv=none; b=sGA20aaBxyCE9Jrq6rLfXgeDvXtUsguxirEsbNAbvrhQstjl1I21EOwWS5ahvXMIJ2hSZ5GgNVIZqGa3OM1lFDmMfDP1fLOXW/aa6SQjIDgCRqSTSAQYxjVWnRdgOnzLg8gYL7HmfnRoRMVQCS5WSB4n5vmWuVj4mtL4mM71fBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372485; c=relaxed/simple;
	bh=SAE9X4EEjY2ZvGnbvYn6CgWKevjhg+JZh0D4LXYQWSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EnoRiJGQEdUyrLy48R2i+DiVzDHUWRWIB3tOh2jw5ffZqB6m/OBA/f9F2tiTi9VNFnUf6lJpv4ZjG2gdgf/vqoDf44osw9B/uaStMAljx2EMBnUH5CkAre0EPvTDw9wV4ST2DWr+fKHOjplg5F63hGCC5ptiHJ85k0kvK7bQvQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jq/0SFTb; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8599843214;
	Wed, 19 Mar 2025 08:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742372480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+li3VJN1jkxERZLWTNPHaOMZTpe2H6m5wVIrNKLoMY=;
	b=jq/0SFTbB0DqTIk6jgz9+JIMiRX2v42uordG7LZrw21p1NT989w+Ad2jwL7bOVHGxAiKUE
	lZpDSgfXar49+B+qcp3zOgyDv2ND9ccISl9nhB5mdUGemRgPmiwUDCNgkIktUFDAlsj/oj
	xhdCy4KnUw6kImhvObGjpv/sUjYFLl3ZrESr828HFSC9/HKD6jGvJm+saGv7kNPUFFMXCc
	681QqfiQ78h+el8TYnR9gAr+EvT/4RoWoGkyF1bfrAV68zweAXXEoKEzh58CTVp/W3K1B+
	lPKvblwiQXKdE5l/vkJk0cmdgCfDUAp9KIocRKNlG+V1todppirSuOjiGpYawg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
Cc: "richard@nod.at" <richard@nod.at>,  "vigneshr@ti.com" <vigneshr@ti.com>,
  "robh@kernel.org" <robh@kernel.org>,  "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>,  "conor+dt@kernel.org" <conor+dt@kernel.org>,
  "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
  "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,  "git
 (AMD-Xilinx)" <git@amd.com>,  "amitrkcian2002@gmail.com"
 <amitrkcian2002@gmail.com>,  Bernhard Frauendienst
 <kernel@nospam.obeliks.de>
Subject: Re: [PATCH v12 3/3] mtd: Add driver for concatenating devices
In-Reply-To: <IA0PR12MB769956849D2B41827F0B5B53DCD92@IA0PR12MB7699.namprd12.prod.outlook.com>
	(Amit Kumar Mahapatra's message of "Wed, 19 Mar 2025 06:17:50 +0000")
References: <20250205133730.273985-1-amit.kumar-mahapatra@amd.com>
	<20250205133730.273985-4-amit.kumar-mahapatra@amd.com>
	<8734fa8hed.fsf@bootlin.com>
	<IA0PR12MB769956849D2B41827F0B5B53DCD92@IA0PR12MB7699.namprd12.prod.outlook.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Mar 2025 09:21:19 +0100
Message-ID: <87h63p5t34.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeegkeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejgeeftdefledvieegvdejlefgleegjefhgfeuleevgfdtjeehudffhedvheegueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtoheprghmihhtrdhkuhhmrghrqdhmrghhrghprghtrhgrsegrmhgurdgtohhmpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgp
 dhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

On 19/03/2025 at 06:17:50 GMT, "Mahapatra, Amit Kumar" <amit.kumar-mahapatr=
a@amd.com> wrote:

> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hello Miquel,
>
>> -----Original Message-----
>> From: Miquel Raynal <miquel.raynal@bootlin.com>
>> Sent: Tuesday, March 18, 2025 9:23 PM
>> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>
>> Cc: richard@nod.at; vigneshr@ti.com; robh@kernel.org; krzk+dt@kernel.org;
>> conor+dt@kernel.org; linux-mtd@lists.infradead.org; devicetree@vger.kern=
el.org;
>> linux-kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>;
>> amitrkcian2002@gmail.com; Bernhard Frauendienst <kernel@nospam.obeliks.d=
e>
>> Subject: Re: [PATCH v12 3/3] mtd: Add driver for concatenating devices
>>
>> On 05/02/2025 at 19:07:30 +0530, Amit Kumar Mahapatra <amit.kumar-
>> mahapatra@amd.com> wrote:
>>
>> > Introducing CONFIG_VIRT_CONCAT to separate the legacy flow from the
>> > new
>>
>> CONFIG_MTD_VIRT_CONCAT
>>
>> > approach, where individual partitions within a concatenated partition
>> > are not registered, as they are likely not needed by the user.
>>
>> I am not a big fan of this choice. We had issues with hiding things to t=
he user in the
>> first place. Could we find a way to expose both the original mtd devices=
 as well as
>> the virtually concatenated partitions?
>
> Sure, I think that can be done, but I took this approach to hide the
> original devices because Boris mentioned in [1] that we are creating
> the original partitions even though the user probably doesn't need
> them. I believe he is right, as I can't think of any use case where
> the user would require the individual devices instead of the
> concatenated device.
>
> [1] https://lore.kernel.org/linux-mtd/20191209113506.41341ed4@collabora.c=
om/

He was suggesting not to create the intermediate partitions, and I agree
it is not super relevant, but the flash devices themselves are relevant.

In this example:

concatenate =3D <&part2>, <&part3>;

flash@0 {
        part1 { }
        part2 { }
};

flash@0 {
        part3 { }
        part4 { }
};

part1, part2, part3, part4 are partitions, at least part1 and part4
should appear like mtd devices.
Boris was suggesting to not expose part2 and part3 individually when
concatenating them, I'm fine with that.

What I am saying, is that flash@0 and flash@1 shall be represented by
two mtd devices and not hidden/skipped.

Thanks,
Miqu=C3=A8l

