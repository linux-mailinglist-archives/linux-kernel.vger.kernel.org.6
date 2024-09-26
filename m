Return-Path: <linux-kernel+bounces-340367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC038987227
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9143A1F26AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034881ABED5;
	Thu, 26 Sep 2024 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="FyLb3Azm"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB90114AD25
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 11:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727348523; cv=none; b=kmpBIs7pMkjBWM7sgrFsvwJVdJlpeEpvNp/HblNXMFlItL8gevoOB9DMXDIum7eCy1LZkUma1/VZwz8dylE6Byh3Iw1qSB5mX1rUQlW8Bke1BGxztjuixUj6EJUfg0U1MszzifY/kq+ucGLfBn/NUdQ0CnSvozc6ttlZy2BC4YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727348523; c=relaxed/simple;
	bh=ZZ4U8PS+xvbWV05UkMujhA5g6+5WcpBTCI2eB50r8G0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eLfJgaORIq7iYQVUQHVf28CTtBIVjpNfvy6yYvCBwELPE1dmicRcDIMyPnSB9UMwSD/HyrjJFcRgdaba6hGQltPMj3YhSJBHZSX2iTmXQvpQyU9Kb62/7eFt1NEEyEB7WgCaPjxHFCBUTQZFDHv8k82Zk8SWtssuFlwR4wNge5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=FyLb3Azm; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ZZ4U8PS+xvbWV05UkMujhA5g6+5WcpBTCI2eB50r8G0=; b=FyLb3Azm0dgfcSW0RJ6Ti7wC2a
	+sf6mTQnXWGlCKPRmEuiL5Zn5EXFLmmEhdl9x7t6enLLV1AiAq8e3O1nQHJU6j0jJuLCE5mcUPP7U
	1BFSeN3KIiCYc6mjNQWwGQhCb3+x12OxEuO7kdQmMEM/LcIk/ROMnyeN//ErV85iXY3UAx2XAa0TP
	G53SGLk7HLVdHcf40blFas38xW3rYSDLJnw5o+/R89kWDY9biMHHnRq0YN1TNB0dT75V8kEKfFqm+
	76noulpzjPL7U5aLRt3ighOmNz5YgxwDmV6/x5a2dtLt9DONyIJklCH+rP4jSN4Xb2nJh+UP+gXGL
	kXKh34aQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1stmFu-0003tV-St; Thu, 26 Sep 2024 13:01:54 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1stmFt-000Ghc-2Y;
	Thu, 26 Sep 2024 13:01:54 +0200
From: Esben Haabendal <esben@geanix.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <mwalle@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,  Richard
 Weinberger <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  Nicolas Ferre <nicolas.ferre@microchip.com>,  Alexandre Belloni
 <alexandre.belloni@bootlin.com>,  Claudiu Beznea
 <claudiu.beznea@tuxon.dev>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>,  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 00/15] mtd: spi-nor: macronix: workaround for device
 id re-use
In-Reply-To: <e079751d-e775-4dec-9959-c9c3fdcc8ecf@linaro.org> (Tudor
	Ambarus's message of "Thu, 26 Sep 2024 11:08:25 +0100")
References: <20240711-macronix-mx25l3205d-fixups-v3-0-99353461dd2d@geanix.com>
	<e079751d-e775-4dec-9959-c9c3fdcc8ecf@linaro.org>
Date: Thu, 26 Sep 2024 13:01:53 +0200
Message-ID: <87bk0ahe5a.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27410/Thu Sep 26 11:30:46 2024)

Tudor Ambarus <tudor.ambarus@linaro.org> writes:

> Your patches do not apply on latest SPI NOR, I tried locally. Can you
> point me to a branch of yours where I can see them? No need to resend.

Sure. I have rebased to spi-nor/next and pushed the b4:
https://github.com/esben/linux/tree/b4/macronix-mx25l3205d-fixups

/Esben

