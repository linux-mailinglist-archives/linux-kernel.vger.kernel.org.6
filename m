Return-Path: <linux-kernel+bounces-201831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 020E18FC413
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C1ABB289BD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB76169381;
	Wed,  5 Jun 2024 07:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="iwECQPVU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="nUCmKO2z"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E89B190490
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571076; cv=none; b=tCXm4abSSlPF8FbmCqGOIGwuUCh5sQczOpnVr5YerX5lAe+v9VOhJat7eqvDyW9oWzNWUO68bZQ9LcQt0yuXTheHiEwszNX/+A+gnPf8uJvDFoFvVF2hbnfaTl52LUmr/RzY+gJ9ZiciiQ07XFrK5GTv9qyYkmzPTTzt8tEBIuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571076; c=relaxed/simple;
	bh=ZzeOIK0fdxhla5yKm/asKEHPqvhbNzPZILZ6m5aG2NE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kN5LVBvpVibwXbRSIXb0VZ1CeMvx5KjuEVgB0OTw2KFZouhfLm0QFtZvhfpCcpMmhGKTB/12nZuxLDHCXB+X9bPwjlBsfiKvf6qKFvD8FLjLjsY7jpu+R6GDXlxgtTOtE01Nq2qtccpa8hmLH8ZF7eLB5sEhHJq4qUH8Sw0+eZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=iwECQPVU; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=nUCmKO2z reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1717571073; x=1749107073;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mgfcgl64o70xcL/9NpurbH905QcGKzrnJ7LtmqFUkBQ=;
  b=iwECQPVUsHnJc6XuigIaTxkHq/Q2gp+pe0rGd1lixdit0cTIDOdKnW6b
   HZzoc9Ti+7XMQ74xZ53OUfLhpwnOrdgL6TdWbNvMcKJ9jq0CD7mGsSSGx
   3FIB2vqbPHTb30+x7hWgM4TQFLuef+hUwILlEpKrqQusZv+HZlsEEnheB
   SOev65lwuCwh5M+Jdze+16XMRe7xelr+qdam9Fr+iblqU3uYmFCsx6Qzk
   pWFSYBcWxV3SQlt68oKvatqvkX3KW3RTmXItLY4HSfSuJS5+dzD0LeeDO
   oP4WNYLJZRJemWjJNOtva5tT9z8lpic98kvYH6/0yYgrtFQ5tr3chZYN6
   Q==;
X-CSE-ConnectionGUID: 9GLMyuQmRei+iIq9l2ScZQ==
X-CSE-MsgGUID: jaW427zPQKy/Tz1X+hvV5g==
X-IronPort-AV: E=Sophos;i="6.08,215,1712613600"; 
   d="scan'208";a="37226793"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 05 Jun 2024 09:04:29 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 68A1517296D;
	Wed,  5 Jun 2024 09:04:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1717571064;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=mgfcgl64o70xcL/9NpurbH905QcGKzrnJ7LtmqFUkBQ=;
	b=nUCmKO2zd9oM8GmoEmPR7Mjxa3KgggnbJcs0Bg6NCiZHv3ntArIvm0jGYnFZS8USGv8tIZ
	iZjFAT2aX+F6RUFoSYw+zUW8BToP5311toSOkCYnJF+H1BwGt6lLb0LnLqfqD29abahMtj
	4S5NzetKcKlVLGAA0Q61BIdSJzacgEwf2tjpcGT/XcwEQVFVosIRmEWqN976YY1OE1c4Mo
	BdP+vqarPm4hERbqKuyAdDX5kIaqJPTByt7T9MgxuLATMAxP4EZNDsgSJBQtqOC5SIG+VY
	qVv4iFRDimGFuU9sZOPc4qLowK1sZAdRcAuhc5YBB3UTG5ghfgz6TkFsn+ECvQ==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 0/4] mfd: tqmx86: new hardware and GPIO/I2C IRQ improvements/additions
Date: Wed,  5 Jun 2024 09:03:59 +0200
Message-ID: <cover.1717499766.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.45.1
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

Patches 2-4 improve error handling of GPIO IRQ configuration and add
support for configuring an IRQ for the TQMx86's OpenCores I2C controller
in the same way.


Gregor Herburger (1):
  mfd: tqmx86: add I2C IRQ support

Matthias Schiffer (3):
  mfd: tqmx86: add board definitions for TQMx120UC, TQMx130UC and
    TQMxE41S
  mfd: tqmx86: refactor GPIO IRQ setup
  mfd: tqmx86: make IRQ setup errors non-fatal

 drivers/mfd/tqmx86.c | 109 +++++++++++++++++++++++++++++++------------
 1 file changed, 79 insertions(+), 30 deletions(-)

-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


