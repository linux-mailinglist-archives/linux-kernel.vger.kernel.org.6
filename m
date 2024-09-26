Return-Path: <linux-kernel+bounces-340041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5E0986DE4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553B81F22D3C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD2918E76E;
	Thu, 26 Sep 2024 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="P4WGfk4W"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E34224D6
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727336620; cv=none; b=HVNDOg8UKDJqKSjmV0nHjJOeLkbZn6dkljyMSiyKbSRJkFizOlCNlsxbPeeMLfXWN8ShsaQNX+FHCN/DtGSJM4HBHWof8FSgwdiZQk1TSj3S6RBsGg82W5zxXl+6bg5FY802SSC8AaRr1RNSH7XMqsIi+jP/4/p2jv37xY0FZgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727336620; c=relaxed/simple;
	bh=+dyrPIj/vXms6g9F84iGi46agOb2XG4/wT0OCKqAhX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mDQuwAZExhf/lf3+WItPk/N2OGU9DIAUycZBi7hJV3qaPRsN1JUbumgWaicUaSXylxdy1JZU/8Iemo0ipEmMgYwWLxozPMbKJWk1oPdb6mkKSyCK4BHl4jagfv3TH+8qWLvejBYxeqYePgodbKekerOLprbEzZjA2HX9gjSNmEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=P4WGfk4W; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+dyrPIj/vXms6g9F84iGi46agOb2XG4/wT0OCKqAhX8=; b=P4WGfk4W21jGA+KQF2E7ENNW80
	DGXb61/M28w6va7RE9m0PTWo3M9JGRKW6vzSQvU+S3bzWPQ4zysnZFliZScgTHkvmjfXamVE8JULx
	6zNUwk/39N30rrQ3veqlG5N1xpelWOnsuVq91WKO75v2KitmcAFu0lV8yP/IwYaTd0hrQrz712W9c
	8V5q7QAP755w/aIrGwNtAZZN1HeHnfoutlBNr1WXJbgaewhOqqTElUQXNJDicygSKBEvFYOa1kq8J
	ITZRCRMH3OS+5+akSFcZGscn8koXj7d+pDDHSYykt2VqWMzSViTEo1Mf9t1MJuD/tkLLHyp+pk3Ax
	je7/K0hw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1stipe-000GeR-FH; Thu, 26 Sep 2024 09:22:34 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1stipe-000DhP-0F;
	Thu, 26 Sep 2024 09:22:33 +0200
From: Esben Haabendal <esben@geanix.com>
To: Erez Geva <erezgeva@nwtime.org>
Cc: linux-mtd@lists.infradead.org,  Tudor Ambarus
 <tudor.ambarus@linaro.org>,  Pratyush Yadav <pratyush@kernel.org>,
  Michael Walle <mwalle@kernel.org>,  linux-kernel@vger.kernel.org,  Miquel
 Raynal <miquel.raynal@bootlin.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Erez Geva <ErezGeva2@gmail.com>
Subject: Re: [PATCH 0/2] mtd: spi-nor: macronix: reading SFDP by all
 Macronix chips
In-Reply-To: <20240925074903.1983601-1-erezgeva@nwtime.org> (Erez Geva's
	message of "Wed, 25 Sep 2024 09:49:01 +0200")
References: <20240925074903.1983601-1-erezgeva@nwtime.org>
Date: Thu, 26 Sep 2024 09:22:33 +0200
Message-ID: <877cayj2va.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27409/Wed Sep 25 11:17:07 2024)

Erez Geva <erezgeva@nwtime.org> writes:

> From: Erez Geva <ErezGeva2@gmail.com>
>
> Add reading SFDP to all Macronix chips.
> All chips in the Macronix competabilites table
> have a replacement chip that support SFDP.
> Macronix stop producing any chip without SFDP 15 years ago.
> The benefit of reading SFDP is by supporting
> fater op-codes for newer chips.
>
> This patch do not add an all flashes support.
> This patch extend the already support of SFDP to all Macronix chips.
> The new chips that reuse JEDEC IDs and chips that
> are absend from the Macronix competabilites table.
> The patch just remove the restriction!

Hi Erez

Did you see the response I got to the last revision of my patch series
that tries to resolve the same problem that you are adressing?

https://lore.kernel.org/all/D2NGXHZ2VTK0.M0AOB4CM7MHM@kernel.org/

I think we should try go go in that direction. It sounds like it would
be a simple solution that would improve the overall situation, not just
for Macronix.

/Esben

