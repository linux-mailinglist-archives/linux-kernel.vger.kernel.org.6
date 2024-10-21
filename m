Return-Path: <linux-kernel+bounces-374195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5443F9A66A8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 000231F22899
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478951E572C;
	Mon, 21 Oct 2024 11:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Qa5OfbIu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="lXMQ0zaq"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14856946C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729510501; cv=none; b=rHFXDtlTeL1GpLWDrNvKCDZ0/oew8M4pAa/y8iG/cUifaoM8tyrAt9hKefHekxBIzU4OQgVRvGByZhcK4w5GmZa93mYuezsWuoIebz5OS/EkwtOmvlypiD+GMQMbsgUZ7Xbmdo+SYv7aHG+ZpPEWZD2KOFCcG4M49ZjiYqF6hSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729510501; c=relaxed/simple;
	bh=ao3Ic3NAzmzIh7klZPH9s/cUx3/nP4lN8yNXH2vxSJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AEc/32EnF5A2NT67dGTj+3a0aNZZTRVJeMTxi5q3RkB2qQs24kHRCbBAnHimsN9h/XbieTrqVC/kmW42zokZRmIv08F2wEETldns08fgCEz6l3wBPPlpJqe5r+7CUF0t90etUJ5OGOUn7Y+V5tC1JQiLukI2DvSNMmvcgmKcgaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Qa5OfbIu; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=lXMQ0zaq reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1729510497; x=1761046497;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xBGt+V2RZZQSDPxlnzAtn/bO94K3mipNsiNwKWlS1AI=;
  b=Qa5OfbIuHM95jSODD8N/Q4yjrG5BvCiXLVX9eoPdEIyH/rGOaS/qWIoh
   rtUUT4ndd0b4lgROT4Lg99GgbwSLjEelgWjcQJzqmEog3HCxX0YqHyqfW
   JzAq5c0FU5EALu0zmGpiMQYC1rbAKDE/vkPsEJRxGwizdQ/4c1xDQ7zST
   TQN7Tl3Kbnjo+AhgKj/GQW4q6WQwoLIiJ/9eD+6C0vNP8GJW+V//D9gNG
   6zfBj2vF0iyGgyAXs1s7T9oJoHMKpwcYC3dmFR0xw0JLeNJYH0+6pIILi
   o6qUhtBA5/585SN8uK+1WvLR4OG41Nr82sE7O/RrfXah8WLw44Jk4ZzPI
   w==;
X-CSE-ConnectionGUID: 8ptZ6kINSzmSAoAhNpkAOQ==
X-CSE-MsgGUID: LVSHlD6RTZe8hUCQwvLSaA==
X-IronPort-AV: E=Sophos;i="6.11,220,1725314400"; 
   d="scan'208";a="39572168"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 21 Oct 2024 13:34:48 +0200
X-CheckPoint: {67163C58-41-21611FC3-DAD22B0C}
X-MAIL-CPID: 93DACDCF98894E590E793835C8BCE410_4
X-Control-Analysis: str=0001.0A682F18.67163C59.0031,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D9D7316B3EC;
	Mon, 21 Oct 2024 13:34:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1729510483;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=xBGt+V2RZZQSDPxlnzAtn/bO94K3mipNsiNwKWlS1AI=;
	b=lXMQ0zaqgSwfMZ0TpImvRwev6OOvs6ZSHQaskJnNZa1UCKJKrNTyCecqGCX4ePTGxmZqfm
	3a1fgIlwI1VPMlXhLcMyIRcajh6/cYzopDDnTiT0bT6zUafQfb8gcztzO+/3qGbyn3MmnC
	QdCtWlK8q/SAPESAyfEo4xEXsF/+PUT8yHs2ZmUo0y7OCHFYLXEWZ5Tkt5LCFla5Dnxgob
	scMUlzgJ/NC3GyYlqwflmN2/pX4ppihd6K0/7R1udqigxROcwUl4tQgWJ3tt90JlWqIXGL
	lHxSdUwYUE69Yt+XbDyA9Ofs5XfgT+Puv4qmn+QiArqE4HehYyG1avLDFQvz8A==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v5 0/5] mfd: tqmx86: new hardware and GPIO/I2C IRQ improvements/additions
Date: Mon, 21 Oct 2024 13:34:22 +0200
Message-ID: <cover.1729509613.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Patch 1 adds support for 3 new TQMx86 COMs. GPIO support on SMARC
modules is currently limited (not all GPIOs can be controlled, pins use
incorrect default directions, IRQ configuration is handled incorrectly),
however this is a preexisting issue also effecting the TQMxE39S and
TQMxE40S, not only the new TQMxE41S. This will be addressed by a future
patch series involving both the TQMx86 MFD and GPIO drivers.

Patches 2-5 improve module parameter description and error handling of
GPIO IRQ configuration and add support for configuring an IRQ for the
TQMx86's OpenCores I2C controller in the same way.

Changelog:

v2: improve module parameter description (new patch 2, adjusted patch 5)
v3: replace IRQ 0 resource entries with empty placeholders to simplify
    error handling (patches 4 and 5)
v4: remove tqmx86_irq_to_irq_cfg() function (patch 3)
v5: move placeholders to the end of the resource arrays, use defines for index
    (patches 4 and 5)

Gregor Herburger (1):
  mfd: tqmx86: add I2C IRQ support

Matthias Schiffer (4):
  mfd: tqmx86: add board definitions for TQMx120UC, TQMx130UC and
    TQMxE41S
  mfd: tqmx86: improve gpio_irq module parameter description
  mfd: tqmx86: refactor GPIO IRQ setup
  mfd: tqmx86: make IRQ setup errors non-fatal

 drivers/mfd/tqmx86.c | 106 +++++++++++++++++++++++++++++--------------
 1 file changed, 72 insertions(+), 34 deletions(-)

-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

