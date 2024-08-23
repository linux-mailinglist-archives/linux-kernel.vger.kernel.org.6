Return-Path: <linux-kernel+bounces-298490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8414295C80B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1E61F230C1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE19D1442F4;
	Fri, 23 Aug 2024 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZS237N+k"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85B213C827
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724401682; cv=none; b=VeRnFwpeADF+dtmCz+/RDhfeOxKx3GUnvfNiz6V+li/2zNrvy8u6XsWyb9T0dsXHfgGKJv9xrl3jSRSf/oaAABF8JJbPS1veJTC3iJturiyth5aBY6+yyOCf6bhqNcj+oZZT5JkYayNa3VBMKdiU/1h96gGCXhyEbpGeIf+HGD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724401682; c=relaxed/simple;
	bh=y5pO77tjw2lAZYfY/uwztr3YKG3CqampXp6SVr7OTWg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=ZWk5+j806hbxPatAAEeT0ufbvooVNPbplQmLRkOoPHkax3sGy4TNQq/2B4p40AfUiVaachb9z7HV78D8r/0T45cxXbI734XZwS8OCjkkm2kx93dJyO4RBBgRn+mPK3QxH54LGDxI9Jb3CGztChPNga/SiQIjD4drjraKzRThdzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZS237N+k; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2A5B560003;
	Fri, 23 Aug 2024 08:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724401677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fPoSqzGHrYVu/YdwFJNDRyoNYcUqqfUFAj7yMgwNIC0=;
	b=ZS237N+kbz+VqWIzn5gQZ2UVMnB+pQVRm3X1Xc4fyr5TP59qRWsZKoLmKTYncL6d2n6/D/
	3gnh5wZHwb3BUOHKeE/5hqpqEAR6ZACMQt2xyiT02pJNsysopKIemyxgMh+49SGngF1+AL
	i7ZRgstEB0cV/WP7h0c3Pja4k3XM9FWSThzIr9Vkq4tqx+HWfi2qzqxN0534zjDmuQDi2D
	/tATiv3sVqPpjbCTfRZsiAycQkhTATzRqNbpHWsVHatwx2A6GpLM2jBQhSDKWMp4hySi0r
	5I22ZXJSS5f9qPgTboMia9XCZB4CCd2hwMXVnxGTEysSXU2qrSa3+KIMzMTU5A==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH RESEND v2 0/3] scripts/decode_stacktrace.sh: improve error
 reporting and usability
Date: Fri, 23 Aug 2024 10:27:41 +0200
Message-Id: <20240823-decode_stacktrace-find_module-improvements-v2-0-d7a57d35558b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Konstantin Khlebnikov <koct9i@gmail.com>, 
 Stephen Boyd <swboyd@chromium.org>, Sasha Levin <sashal@kernel.org>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>
X-Mailer: b4 0.14.1
X-GND-Sasl: luca.ceresoli@bootlin.com

This small series improves usability of scripts/decode_stacktrace.sh by
improving the usage text and correctly reporting when modules are built
without debugging symbols.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v2:
- Fix a typo
- Add Stephen's review tag
- Link to v1: https://lore.kernel.org/r/20240311-decode_stacktrace-find_module-improvements-v1-0-8bea42b421aa@bootlin.com

---
Luca Ceresoli (3):
      scripts/decode_stacktrace.sh: remove find_module recursion and improve error reporting
      scripts/decode_stacktrace.sh: clarify command line
      scripts/decode_stacktrace.sh: add '-h' flag

 scripts/decode_stacktrace.sh | 49 ++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 22 deletions(-)
---
base-commit: 45db3ab70092637967967bfd8e6144017638563c
change-id: 20240311-decode_stacktrace-find_module-improvements-a02aee28fbaf

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


