Return-Path: <linux-kernel+bounces-190567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E6C8CFFE2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E1528749A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFE515F318;
	Mon, 27 May 2024 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oTrXooR9"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD6215EFC7;
	Mon, 27 May 2024 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812346; cv=none; b=ViU2qmPxy1sMMVRcJA7Vzi28/Z5M7XaIQDVX3QWXXWAyHLIjTjj251tZELmn374JrU7jeHO5iPxqZo0uEJfouvRx1hWkw0TpOjAgU7igEn3rGS+qmaLqjQuavenU52QFpzxRUqCfM0Sb62gqral7j3o3RN3RFCs7OPICWyVptlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812346; c=relaxed/simple;
	bh=IptZZo0YL3FlagpXnKLevmXCzhO71dyB2vJljMEgmUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fMJuIAAwgx8Zwe4G2OivUh9IJyeoEtnJdjGmlIrJ3FIe4GwLIVkV6UJA/gLP5govR4LmRygHBYPA4WgNQXNlQuaA7pXAk/TpJODUasKaD37Y15i9TfabK92i0btK2ipC4owUqToNrpshMyMUbEB0qNXrosabehHgTh7G/DLB6pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oTrXooR9; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2420F1C0003;
	Mon, 27 May 2024 12:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716812343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9HFncU1PhOHKdcu8vvbi3jbm3StjIMaMlXJRXdVMGNw=;
	b=oTrXooR9clakWRqcxff2jUrpg+xOGC2/Wh2pZvkxR2oXNxjWE2TRUI2KnX9Qp/t+IT+YSy
	fMLZGe4NN5Nhi+YARc8b6vknTmcP36AfFysSNfnu7b991hGQFGSBo3qyp7O2bpCCPMzsod
	pCD1JUyBzL3fwovy8Y3C91BprjLGyxtJHhCJjG23Wfv+BxVG4cAla3AqvFdK6JY4ljgTNr
	TIkninxriOji7uPAJHNj1AqcduSwYWcXp1iQV4nT8RqEkQ6TR646EXTYIbOLIkxDwft3ER
	pwI6uQ1Js30Ab0vz0VIOtQ7Ptgnl87gONUKHqnjPILdVREfgob7Tc8BXrBivcg==
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
Subject: Re: [PATCH v6 2/3] mtd: rawnand: meson: refactor use of 'meson_nfc_cmd_access()'
Date: Mon, 27 May 2024 14:19:01 +0200
Message-Id: <20240527121901.178655-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240507230903.3399594-3-avkrasnov@salutedevices.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'2234585f5c12f2a633fff715cca32ce0b40cfa29'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Tue, 2024-05-07 at 23:09:02 UTC, Arseniy Krasnov wrote:
> Move call 'meson_nfc_cmd_seed()' and check for 'NAND_NEED_SCRAMBLING'
> to 'meson_nfc_cmd_access()', thus removing code duplication.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

