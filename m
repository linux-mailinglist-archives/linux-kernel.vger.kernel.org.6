Return-Path: <linux-kernel+bounces-515505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8EBA365B1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829C2170A79
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CFE2690EF;
	Fri, 14 Feb 2025 18:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JQ8ZA9a5"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA2114D28C;
	Fri, 14 Feb 2025 18:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739557533; cv=none; b=eu2IZX2Yg0iSSrbbbgWkMVcDMeh33X7S/TZXHX8UNryJ+WIX4iyiPlv1diUOHNcE/PkIphfGecwW5j0KvK7IzrT3CM+vZ/Cx5JJtVGMwgq1jInzL+ZRPcdYH5JrgurJjtQj833AXvwVLkcHqgcA5TQov8jRkKsu3x/EX10fKrAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739557533; c=relaxed/simple;
	bh=QCJvZJqtYJ9nxXKjkgJa5DxPKftJDg4tRC75vU1cmqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AygGSh8fZ91S7U1bVHrhwv1XhQLd2B2Q5ZV16nw8dIWGDYDz3X+t30tsS6eMrAsM6j4CdyGFjjQj3U9jxq+GDucEzcIroBrUUWd5OQ0+whIbl79yHFh75j2IEvQPX3uQsgym5NXp5JnA3BhmijDpkAWsbSSm7lgHfqSXhYnUt7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JQ8ZA9a5; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 560A544414;
	Fri, 14 Feb 2025 18:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739557529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z2RTZUt1Fez8fLySGHYZ7rwtZmq2cugowgiBqVWj1IQ=;
	b=JQ8ZA9a5xrDAF1OoPMDX5TlshSu53HN8BI5VjSKV9m/MdIFHVnv6de0aQWIP7jZhuiT8QF
	rERbiTEolhMmL7UcwPgUtzhc7kygYoC1zGSxyamhoDrXrSIKV0g1Ym0CgnDb2iwJTUeFx4
	G8t02xxj0SK+nqWRNxlJzQzLm3QWreuuyEVa8kPYdQ5Pf7eqR96Xi01kooIJTU3Bzmthyq
	BdTTYSMO/n9jcDnalMzwk1CNsSVRLaEmeaO+xjQjztzHxaW/IfQ04eRqRaoEdQTNfndkSB
	71bnPbXCKY1rKoVedZUk5XZL7gqO3QQAwIyyiEZiTHZzG7s6fiyJSr0chkkvSw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	niravkumar.l.rabara@intel.com
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	nirav.rabara@altera.com,
	devicetree@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] add clock-names property to nand node
Date: Fri, 14 Feb 2025 19:25:21 +0100
Message-ID: <173955748391.979249.16358494428797372077.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250212112535.2674256-1-niravkumar.l.rabara@intel.com>
References: <20250212112535.2674256-1-niravkumar.l.rabara@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtdefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepfeeugfdvffefhfduhfetfffgieeiudeugeffvdehvddvledujeejvedvgfdtvefgnecukfhppeelvddrudekgedrleekrdduieejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledvrddukeegrdelkedrudeijedphhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnihhrrghvkhhumhgrr
 hdrlhdrrhgrsggrrhgrsehinhhtvghlrdgtohhmpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnihhrrghvrdhrrggsrghrrgesrghlthgvrhgrrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 12 Feb 2025 19:25:33 +0800, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> 1) Document the required clock-names property because the driver
>    requests the clock by name and not the index.
> 2) Add required clock-names property to the nand node in device tree.
> 
> Changes in v3:
>   * Include missing Fixes tag.
> 
> [...]

The following patch has been applied to mtd/fixes:

[1/2] dt-bindings: mtd: cadence: document required clock-names
      commit: 211b841f34cce652258ddec7fa4750a748b28471

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

