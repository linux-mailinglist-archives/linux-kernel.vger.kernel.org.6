Return-Path: <linux-kernel+bounces-521644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6996DA3C02F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D00A7A4EC4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E531E8339;
	Wed, 19 Feb 2025 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UwfrExLB"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFD119CD01
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972483; cv=none; b=ShY/47ng8B1lZ9n/st0T7iGuUoUT5ZJgO8HLmOj3ADrTEW/7NPqrrkJ7CE0WeW75zonxn56TCKFM8OAH9cnlOvWBlntS/YRb1k7ViB49nGCD86ybPCUReqFbvyrTw/pRM0MSHOxrp+qNNQJ0Eu1n92o1AbZlfqmWuRvnqj32UJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972483; c=relaxed/simple;
	bh=rFQyiZoEMUWMw2eEtfx4APQV76D89h6kfmj48FsyZdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Af4z4Nom+n/T2+9t3YAzyDI6yh5yaAtn3++RVdG5y+KgyoFjYhGnfcECuQ/u3s+blTc2tavbnHPScT8CO09dsB5dLgSqiBD9L4mE0bP03yBtbdG8q5P6jNEcGl9oyOQwCYTNVqy92taE6IHQeZaxmWQEM3zv7MW4G1NIl/FYB8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UwfrExLB; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7FFFF443EF;
	Wed, 19 Feb 2025 13:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739972479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xcBRoz8d8kfVyEGHs3Q9+R3j8VA136sGzn8ZA7cE/sU=;
	b=UwfrExLByhzPWOX2cZk++dnv8S1jfe7JPEOeEXBm2csPgjTE2VjZJVzVyFSGOWgjIFEzbK
	FTPdvxd+zOEBb/MjKVg/J9c6gm4tXv53pzIHfbEjNnDkq4iML8+BQv7HuLGJY/mRPpzA/y
	h+Y+TVSnYMF8U0D8gQfOwe4ucf0p2pPrmiVO9r/obAKnbMZT0+U3cBB7SH31cRej3SKxsZ
	YlA05x5/xeF+n4p0UP09oSxFX27jlOatqbUqk29OSzJgEsz4jPNyHmWl9eMaiULJgP6pqv
	Ku3m/aQQOQKmwQQKErQGD9TYBRDbLpqjzyGraVQm6FDs657tlXiTBxS3nqaj9g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux@treblig.org,
	Shen Lichuan <shenlichuan@vivo.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	u.kleine-koenig@baylibre.com,
	nirav.rabara@altera.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	niravkumar.l.rabara@intel.com
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH mtd/fixes] mtd: rawnand: cadence: fix unchecked dereference
Date: Wed, 19 Feb 2025 14:41:17 +0100
Message-ID: <173997243493.1255269.588065932781621293.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250216031536.3366360-1-niravkumar.l.rabara@intel.com>
References: <20250216031536.3366360-1-niravkumar.l.rabara@intel.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepfeeugfdvffefhfduhfetfffgieeiudeugeffvdehvddvledujeejvedvgfdtvefgnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehffidrrddpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtoheplhhinhhugiesthhrvggslhhighdrohhrghdprhgtphhtthhopehshhgvnhhlihgthhhurghnsehvihhvohdrtghomhdprhgtphhtthhopehruhgrnhhjihhnjhhivgeshhhurgifvghirdgtohhmpdhrtghpthhtohepuhdrkhhlvghinhgvqdhkohgvnhhighessggrhihli
 hgsrhgvrdgtohhmpdhrtghpthhtohepnhhirhgrvhdrrhgrsggrrhgrsegrlhhtvghrrgdrtghomhdprhgtphhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

On Sun, 16 Feb 2025 11:15:36 +0800, niravkumar.l.rabara@intel.com wrote:
> Add NULL check before variable dereference to fix static checker warning.
> 
> 

Applied to mtd/fixes, thanks!

[1/1] mtd: rawnand: cadence: fix unchecked dereference
      commit: 60255f3704fde70ed3c4d62f919aa4b46f841f70

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

