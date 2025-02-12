Return-Path: <linux-kernel+bounces-511462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1B0A32B59
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE211656D7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0A6212FA1;
	Wed, 12 Feb 2025 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dAG8SAQl"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8CF20E33A;
	Wed, 12 Feb 2025 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739377124; cv=none; b=nmYI3F5UYgQ+OrkPzY6gDpbwGdkjJNsLdUyxg/bz3BT/rY/MiUvdb5C6iL4II+NHd+PhONHrtvoWsQtjHesdAAOht1TjUv53lbPNhVf8RMjM3hsDlh6+C3ubAjJXHq73kJHutKYnpY5ekOZGSECMlU5GvqZgO14+oUpvNVGhoPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739377124; c=relaxed/simple;
	bh=JSBE115N7U9CMQpZg6ZPZBsdfvFaB3/geDg7qbYTHHU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nEyoqaRcM6rpkIxWOk9kaaljPZwFvuAx6y/mhsg8dVREVAxVtwiBnhPhK1fqWPa1bq8abvuHuNBcyULF/1vY1LSOPWFeBySRYgg/e4gR7TPX1hx93DLlVm4KlhdESX1GTS+I/u2lmMH8S/2gL05u4kJ0vTwGKs39ZOW+msVDP1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dAG8SAQl; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0A62C44419;
	Wed, 12 Feb 2025 16:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739377120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JSBE115N7U9CMQpZg6ZPZBsdfvFaB3/geDg7qbYTHHU=;
	b=dAG8SAQlqiIZbfuzzhstCGWm+L9Dbfjcybrs1hu50NYmrj612zYGM9rM5S5H96pxSREXPg
	aWhS4n4Na7gekB6QW63VfnQAnw20W+bGhF6YqRDN1jMnRJT/UkoJCLgPXf9uTYxu9k+Jai
	n1rDqsCTv3cezCmSeWCZnmIpYmoKkjSWA/MSPrdKFkBAbdWkmIupX1Im/7yEbkiSdCmH+I
	5U9tcUTaBUqiz66eFrreUccik+VM7a5gw+fWK3F3jvrg0+J9UoRsEn4bpSLqvT0aXdKLPW
	dPjeh9XAwQtdUT9oRHVsVqmtJSsq4fj/tAWeN7wseNLGmTCwNv4dF9Y7X6c4ag==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,  richard@nod.at,
  vigneshr@ti.com,  krzk+dt@kernel.org,  conor+dt@kernel.org,
  linux-mtd@lists.infradead.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  git@amd.com,  amitrkcian2002@gmail.com
Subject: Re: [PATCH v12 1/3] dt-bindings: mtd: Describe MTD partitions
 concatenation
In-Reply-To: <20250212160659.GA3883406-robh@kernel.org> (Rob Herring's message
	of "Wed, 12 Feb 2025 10:06:59 -0600")
References: <20250205133730.273985-1-amit.kumar-mahapatra@amd.com>
	<20250205133730.273985-2-amit.kumar-mahapatra@amd.com>
	<20250211212928.GA1188800-robh@kernel.org>
	<87r043r2lq.fsf@bootlin.com>
	<20250212160659.GA3883406-robh@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 12 Feb 2025 17:18:39 +0100
Message-ID: <874j0zqgps.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggeefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeghfejtdefieeguddukedujeektdeihfelleeuieeuveehkedvleduheeivdefnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrmhhithdrkhhumhgrrhdqmhgrhhgrphgrthhrrgesrghmugdrtghomhdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrn
 hgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

On 12/02/2025 at 10:06:59 -06, Rob Herring <robh@kernel.org> wrote:

> On Wed, Feb 12, 2025 at 09:25:53AM +0100, Miquel Raynal wrote:
>> Hi,
>>=20
>> >> The partitions that gets created are
>> >> part0_0
>> >> part1_1
>> >> part0_1-part1_0-concat
>> >
>> > 'part-concat' doesn't work if you have multiple sets of partitions you=
=20
>> > want to concatenate.
>> >
>> > I think you need something like 'prev-partition' or 'next-partition' i=
n=20
>> > the partition nodes to create a linked list of partitions. Hopefully,=
=20
>> > you don't need both properties, but you do have to scan everything to=
=20
>> > figure out which ones are concatenated or not. For example, no propert=
y=20
>> > can mean not concatenated or last partition if you use 'next-partition=
'.=20
>>=20
>> Out of curiosity, would the chosen node be eligible as a central place
>> where to look at?
>
> Why would you need that?

I'm talking about storing in a central place all the concatenated
partitions. Your proposal with "next-partition" works fine if we locate
it inside the 'partitions' node, but I feel like the 'part-concat'
instead was not fitting very well there. So I was wondering in this case
if moving the concatenation of the partitions would be eligible to the
chosen node, or if that's reserved to *very* few properties (and should
remain like that).

Thanks,
Miqu=C3=A8l

