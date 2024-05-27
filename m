Return-Path: <linux-kernel+bounces-190568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41598CFFE4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009E51C21538
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374D915F3F7;
	Mon, 27 May 2024 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bTnKYUeJ"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F34615EFD7;
	Mon, 27 May 2024 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812348; cv=none; b=tnX/ySyyqf2dxd4ra1RJPXA+5uNIa8jgwgrhlGgdTXYYe/vLXRWbbsSsRn0AwrY4um1W5ev0PbGTN8krt9oCFJZZQjEOAv4zzmrl8KKWcGz5LHZmQRlvZtHViyUXGmnSPaNIUDkL/FCTn576TujCHvvRE9g6779rhBp+BEHOmhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812348; c=relaxed/simple;
	bh=aJi9kEQuVivnoyDxTdlWp/ywSq1Sd13uw2LRfy4vUv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kxONG4IaTrDbV902LEQC/nzR1Z8wVjgpoLbvrJVxtHYTvTqOTubEIPUoQk4WhpnBJH9U3y3ffh7SKnCVtUeOhUZAH2XB5BvmLq4O5wX45lEIhg5FN1intR8vDYkPn+FUp7/4QVPNU2HUvJREDAr4HbhGuvNhhXFE+vGh9rzqmOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bTnKYUeJ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 41DAD1BF206;
	Mon, 27 May 2024 12:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716812339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6dIIUfmUc8NO0pZNfG5eRyXQNvs/FWO1RLC4XodFVw=;
	b=bTnKYUeJvoYRvmmPBzaCq35Th5ZcUumDCLdE9crX1ZR1o+bgNKbq/2CzR11AFbJvlbcgdm
	MGxCR5SkzP7VnAypaGPl1udU7UaUifdomsSBGDn1cq8Mufx7XRAFeA07vW5WiLeouZoPrK
	DVNCWBqkJAtKex4IBdV+on+xvpmVWLWwDZbFz+H2mXIpFs+tg4O2eo+vnF0XUXAlisLuCn
	G9vqp5YMTQhY9uWPp762N9BDVdiVDJ5WzpTQCKP/hfwBdwaYE1DGi84DoXAAF0D/Gy6jh1
	prbL8hAmFxy5b4+l6rh4QOn3nn+e+TiUtOQgLw3ySZjJrw77pWV+uhrppcEY5w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	oxffffaa@gmail.com,
	kernel@sberdevices.ru
Subject: Re: [PATCH v6 3/3] mtd: rawnand: meson: read/write access for boot ROM pages
Date: Mon, 27 May 2024 14:18:57 +0200
Message-Id: <20240527121857.178627-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240507230903.3399594-4-avkrasnov@salutedevices.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'04a81b4f9ba1a473af7715168306c23ca4e15a25'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Tue, 2024-05-07 at 23:09:03 UTC, Arseniy Krasnov wrote:
> Boot ROM on Meson needs some pages to be read/written in a special mode:
> 384 byte ECC mode (so called "short" by Amlogic) and with scrambling
> enabled. Such pages are located on the chip in the following way (for
> example):
> 
> [ p0 ][ p1 ][ p2 ][ p3 ][ p4 ][ p5 ][ p6 ][ p7 ] ... [ pN ]
>   ^           ^           ^           ^
> 
> pX is page number "X". "^" means "special" page used by boot ROM - e.g.
> every 2nd page in the range of [0, 7]. Step (2 here) and last page in
> range is read from the device tree.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

