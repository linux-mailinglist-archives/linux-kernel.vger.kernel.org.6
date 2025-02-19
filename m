Return-Path: <linux-kernel+bounces-521127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7E0A3B4BC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A060F189BE0E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6DF1E0E08;
	Wed, 19 Feb 2025 08:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l++9H2hQ"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B301DFE39;
	Wed, 19 Feb 2025 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954203; cv=none; b=FfeYJHckVysMDhpZJi8Cu29IrAIhxLxR2PCXpBh10/jqxbbUZJ4IXRaJf3vkGiVnRLH8RZI3de4C+ehwS+luTsBlT2s4DYr/z9J0s2jYpLPvW2ts5Ijc4iC8snewaWJDpcNgossZUic2chZ+5/rIFRpWqpMzlhgaglbjX+sbmTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954203; c=relaxed/simple;
	bh=dXFsWhl638wEt2WdRXJGFWD7cfvkLuyTrUtgYE7Ngxs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pai0jQrP6SnH41DAJqKckJPLXVF/9KT3WoX7+hne3dhhgRAeEiCe8So9LoGpz/bJhtlQ3BZTqnnQEFOXUE8BslS71cWZFGiT/s0Qo7VJ+/6pc0Zdvf6SzQLhDFF4ml6VWLXlcrkFiam6Qrn0wDbCFVg+6MfSAa8gIUa10r7PuCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l++9H2hQ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4EA8244340;
	Wed, 19 Feb 2025 08:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739954199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXFsWhl638wEt2WdRXJGFWD7cfvkLuyTrUtgYE7Ngxs=;
	b=l++9H2hQn/u+qIStQwH+1g2AA05EkXihmbppaCB50w/4E3wzZ+DRpmt5pPqOpvTFO0d2SK
	lksQ12wkhaE3L5QYRXvgFT65A8lOVd0ZpggZYyL5wjcfLf+V95q8ghjUdBmU0t8zsfJF1i
	Wrr43E3j7b9wAPgzMstJDi0gj1nIQXmUGbT3IKRQpKIw4F55+3A+WOdcBe1JAUnXZ5gyx9
	6UtozZyYqj25MyIojkEyWDPX39XgupTlFt0RB/dRFxWVw0Q19RIM4hxHkcMIAVn5IgQtZn
	VC4cle9xOjdMXPIqysebj2B8a1zSC+/pO/RycD0/h/oORDC6sUClmOMV4hM6DA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,  richard@nod.at,
  vigneshr@ti.com,  krzk+dt@kernel.org,  conor+dt@kernel.org,
  linux-mtd@lists.infradead.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  git@amd.com,  amitrkcian2002@gmail.com
Subject: Re: [PATCH v12 1/3] dt-bindings: mtd: Describe MTD partitions
 concatenation
In-Reply-To: <20250218213903.GA1203860-robh@kernel.org> (Rob Herring's message
	of "Tue, 18 Feb 2025 15:39:03 -0600")
References: <20250205133730.273985-1-amit.kumar-mahapatra@amd.com>
	<20250205133730.273985-2-amit.kumar-mahapatra@amd.com>
	<20250211212928.GA1188800-robh@kernel.org>
	<87r043r2lq.fsf@bootlin.com>
	<20250212160659.GA3883406-robh@kernel.org>
	<874j0zqgps.fsf@bootlin.com>
	<20250218213903.GA1203860-robh@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Feb 2025 09:36:37 +0100
Message-ID: <87ldu2qqju.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeifeejjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeghfejtdefieeguddukedujeektdeihfelleeuieeuveehkedvleduheeivdefnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrmhhithdrkhhumhgrrhdqmhgrhhgrphgrthhrrgesrghmugdrtghomhdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrn
 hgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Rob,

>> I'm talking about storing in a central place all the concatenated
>> partitions. Your proposal with "next-partition" works fine if we locate
>> it inside the 'partitions' node, but I feel like the 'part-concat'
>> instead was not fitting very well there. So I was wondering in this case
>> if moving the concatenation of the partitions would be eligible to the
>> chosen node, or if that's reserved to *very* few properties (and should
>> remain like that).
>
> You would have to solve the same problem as this patchset which is how=20
> to support N sets of concatenated partitions.
>
> In general though, we add new things to /chosen very carefully. It's=20
> usually "things the bootloader configured/enabled" which I don't think=20
> this qualifies as.

Interesting, I didn't have this "things the bootloader did" explicit
case in mind.

Thanks!
Miqu=C3=A8l

