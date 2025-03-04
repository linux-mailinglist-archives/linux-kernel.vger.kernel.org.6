Return-Path: <linux-kernel+bounces-543961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6832A4DBDA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C2716567F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FD21F3FC6;
	Tue,  4 Mar 2025 11:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dIY/tIcJ"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB32D1F76CA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086486; cv=none; b=GYYe/PDnf95LwJKVPNQi1tOF2eXDFqFwcy9tOsSNVRitupEiQvqZVVojLpRvHtnocw6CvUfEIhxUxfwcvhnbitj+VE0K1TLD2gia2P5UEiNriIWBE7oNDZ9u1Ge02EZAm7A7zYzIl/Eo47QrDzz7/TPN16SwcwyfitEbzcB+Tl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086486; c=relaxed/simple;
	bh=h1r0EJAwdE5SF6M1FD+XQ0W/N3IZkFVXUmHO+s9yT1U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CzWmypjjHIv7KombLbxmmNDjuoc6lm4y5PWSVSe559pJQv2tUKTxtY41eSCe8lP6yIGMOlUR/ndWBeUC6Cibcts8aWwDmppgeYSr0+gZFC4rLthrdaq0o+ya2gSaOFJVm+0pL6WOZs3bUz+jT4/7y7GbkuxUk6X5QnGdoC7AJy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dIY/tIcJ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D67A42FF1;
	Tue,  4 Mar 2025 11:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741086482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x8PHBPyVcVGACAsLJJbh1k3kLjnnIG01sREfq4tZ7nE=;
	b=dIY/tIcJd7TrWrVoAtPaqW5eJaAlepxXeIILc5whI078rHRl+YK93K4gGxkCIUq83ture0
	mkAqE+ev3l3itIxUqXyCAkRovqY+87wGR2Acu5NkoZlQrCUepexmi49tonh/8pP33D+sKS
	gdrxWCCigw9qnIKsMxwscZeJqkxbfTNxt2UgwcSUPQZyMrIGn9zV3znj6JulTojupPd8gf
	HD+MUtKNrXoD0+Ta1miaS7SLyHdxBiFIulWFDUZetT6Ubp4uty/2QwOQgIxDXNcexDS0xl
	SphfiC29r/gkQUmxy04gxIo1LfniOBcAFq6d26HCLQZiZfElxMKlHS4NdWkF+Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: richard@nod.at, vigneshr@ti.com, Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250303145223.1748-1-vulab@iscas.ac.cn>
References: <20250303145223.1748-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] mtd: Fix error handling in mtd_device_parse_register()
 error path
Message-Id: <174108648055.2291907.15045418587875568653.b4-ty@bootlin.com>
Date: Tue, 04 Mar 2025 12:08:00 +0100
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
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddukeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvegjfhfukfffgggtgffosehtkeertdertdejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheeifffhueelgfdtleetgfelvefggfehudelvdehuddulefgheelgfehieevvdegnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrgedvrdegiegnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohephedprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepvhhulhgrsgesihhstggrshdrrggtrdgtnhdprhgtphhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 03 Mar 2025 22:52:23 +0800, Wentao Liang wrote:
> Check and log del_mtd_device() failures. Print an error message
> with pr_err() to prevent silent failures, but preserve the original
> error code instead of propagating the secondary error since
> del_mtd_device() is already in an error handling path.
> 
> 

Applied to mtd/next, thanks!

[1/1] mtd: Fix error handling in mtd_device_parse_register() error path
      commit: 2a6a44555f0727070643fdde7ffac6571e41327a

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


