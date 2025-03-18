Return-Path: <linux-kernel+bounces-566515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A583A6792F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3CFE8867B2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ABB21171D;
	Tue, 18 Mar 2025 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IhggZrEL"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7B42101BD;
	Tue, 18 Mar 2025 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314769; cv=none; b=piLXUfEtTyLSXpbuHgNZyWwP5ntCk9CCutMgFBo+839X5rQW8YkYLKKLcS0fVGwZZkoA5OslitXQC7PzUUS27xwWtwTCa8SDFbcplm8VoVMct4Ep8q0/8RUqKeGfnJ65MYCGq9aM5Z3mLGL1g/NZoJ5uGaoo5RDFlGQExauvSsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314769; c=relaxed/simple;
	bh=rbB7ryC3rEw5mNBoRPW43HLwbLE5SgXH2VWLPU1lpb4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Kh0ba5WYQd4iVmP087IG8dUD9FhTeYQq7wydlWzFRY3sgKzyv3PnMAYOqj91RKH1o/uzY9fBjs0O5rzteZF6/KeEuFbwBhJtqhXLjkhBhjKH2l9LdsOfW8DvJ0WT8GLTSmWrVpjzFG+/Z5Q7cRN3dNEn2xS/V0NskJQgyuCvz68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IhggZrEL; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ED1EF444D6;
	Tue, 18 Mar 2025 16:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742314765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k/AxgIgt8vecfvtvzMLhuv/34eYNrWZI3TyC35mHmZw=;
	b=IhggZrELsy2jktQSttbwimH0C/+Ti+xR7lRFIi8W9GwEmfzp5Cb9a7r+puX9C5lr/dcm/j
	riQmWafNX5Kdvv1eLT/cPa/BkRQ2O276+H+ynspd0ISlLF5kwSycQCGec/BICzeTVJUlvh
	M1SRHc+FuR6tH64h80rrN2tDBdalQUYew2zYQeFJnWmkRSd/3RGMmeyjvmpk0KVCS1jqOP
	HwlQUFW91l9rOxiRyE2vDyoX98aGpo5ZMlDBY1/gvtgecdzzwbxXonEpu9MnWYuIc4p/3b
	b89R8hWNtP+MPUo/HJM7NWxgUfoXBaYAYbQ7egQpmlEqLeh+5WqFZR1McoZ8Bw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Nayab Sayed <nayabbasha.sayed@microchip.com>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250317-atmel-dataflash-v1-1-1a3247f40299@microchip.com>
References: <20250317-atmel-dataflash-v1-1-1a3247f40299@microchip.com>
Subject: Re: [PATCH RESEND] dt-bindings: mtd: atmel,dataflash: convert txt
 to yaml
Message-Id: <174231476490.980483.3190469118057006004.b4-ty@bootlin.com>
Date: Tue, 18 Mar 2025 17:19:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevjghfuffkffggtgfgofesthekredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehieffhfeulefgtdeltefgleevgffgheduledvheduudelgfehlefgheeivedvgeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhig
 hhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehnrgihrggssggrshhhrgdrshgrhigvugesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 17 Mar 2025 19:01:08 +0530, Nayab Sayed wrote:
> Convert atmel-dataflash.txt into atmel,dataflash.yaml
> 
> 

Applied to mtd/next, thanks!

[1/1] dt-bindings: mtd: atmel,dataflash: convert txt to yaml
      commit: 48a29721c967da1af657279fa696d6c386bdd5ca

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


