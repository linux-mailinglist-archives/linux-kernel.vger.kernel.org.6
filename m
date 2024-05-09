Return-Path: <linux-kernel+bounces-174277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 758A08C0C69
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD1022834EB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D663D14A08E;
	Thu,  9 May 2024 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W7S6AymZ"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A40B14A60C
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715242704; cv=none; b=iucQj4XluqQVRzrTGFvyr9CImYfZwa4AdezXQn2VyxTh9gP2Pf4NlRJMWUWE5ILUdf4yWADoAXJxLw7RMEAKdu0p4fA6xEqrxW9eYbOX0mbZL+o6CjOLFipF8zGOYsEiB4AhmZV4y0R65K3LXKWAfvEdVPRMX5x0WQhn9iN3Xlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715242704; c=relaxed/simple;
	bh=y5pO77tjw2lAZYfY/uwztr3YKG3CqampXp6SVr7OTWg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=nzdaV0UcZ0z0YFaGSKxPj1oTJq02Fs71+PjZokjdXtQBQe50WjlChd8Rn+fkMabJQWwpJ336r9aJjC6TNr6wIRujrjq3pBZ0sLPgNVVfNL76fjrIpjaItugtgdebpQJ3o9ps0lopAVKGZGajoBF9alMwzEMwqx/DXWGomkB0LNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W7S6AymZ; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A5059FF802;
	Thu,  9 May 2024 08:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715242680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fPoSqzGHrYVu/YdwFJNDRyoNYcUqqfUFAj7yMgwNIC0=;
	b=W7S6AymZIfuXeiExVjgu0Z4F7yMUOZAMUJB0OV9kZAFXW+8eNaFnuDp3iqrQX2tnlB0CZ4
	aN66m0mCKzyoM57Yf5RI1NkLXnGZbYkoLJ4Rt9J1SMtKZCEsjnvjfGSt2euZu7PHufZPZS
	TZfzHlbq+QrPILk0S3S9bQFBklOpyYRdBqU7O3qY3s3FAn7i6acaUKt6qRSO/LcG7Ikd6p
	14WtaJb0Yq4du+Ye6LdKp/Cfhn2hwpewKABBJmVv8m9gEKutRoqLGsCOAehraGpWH6s96H
	fxvt/+hNONfJ21rBkhcniAH3a7uNcYX6iJ9Fdg+X6CyWzK4rxFuPz1G+Z56ecQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v2 0/3] scripts/decode_stacktrace.sh: improve error
 reporting and usability
Date: Thu, 09 May 2024 10:17:20 +0200
Message-Id: <20240509-decode_stacktrace-find_module-improvements-v2-0-887fb6d5acb9@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJCGPGYC/52NQQ7CIBBFr9KwFgPYRePKe5imGWCwxMI0gETT9
 O5ij+Dy/fy8t7GMyWNm125jCavPnmIDdeqYmSE+kHvbmCmhenGRkls0ZHHKBcyzJDDInY92CmR
 fSzuHNVHFgLFkDkIBohqcBseacE3o/PuI3cfGs8+F0udoV/lb/8pUyQUfNEKvdK8kwE0TlcXHs
 6HAxn3fv7Zy5pbmAAAA
To: Konstantin Khlebnikov <koct9i@gmail.com>, 
 Stephen Boyd <swboyd@chromium.org>, Sasha Levin <sashal@kernel.org>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
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


