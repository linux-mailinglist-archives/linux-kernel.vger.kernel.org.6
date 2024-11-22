Return-Path: <linux-kernel+bounces-417966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B585B9D5B52
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5374DB21B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1F31CB528;
	Fri, 22 Nov 2024 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bz5nIjZL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9481BC094;
	Fri, 22 Nov 2024 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732265685; cv=none; b=sOPp5iIuY5yqTePP7omTEfiiQM5vb18+Cv77WrwbBPBkfLad/8aCOc1scLDSVBhqVuVi9/pJ2Ktp+ipsY45ha7Tijk05WL6jH6pB0NMnSBzX9cokaadG4gAzJ/ZTE0jRwhXQ8boHikKavOB4fjVMwWrqX8+ohDrhnYINAuPhd78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732265685; c=relaxed/simple;
	bh=7rzMvx48n11Ga+k4795VyVqRvaffhTq48wBjDhlzNNo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OG7QgRZiBzJ3cVWBHPZJ3pYX9M+kiwo9uMlqSq7RjYJkY6e96VuuplVj+NEdUqchFDTkOVVEvlByuR/Hl6kWdQT63oU7fw0pynuCU4XbfgjSqB1C4wzwsUztsYeqRl4dnm1sXMA/XSWmuKqRwBxZu544RQLovdj7YiboktdZQng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bz5nIjZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 232D9C4CECE;
	Fri, 22 Nov 2024 08:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732265685;
	bh=7rzMvx48n11Ga+k4795VyVqRvaffhTq48wBjDhlzNNo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=bz5nIjZL3KtxyswrPAm0AkkiPjXzW8GxvrVVMXXM8MnI/dbA4smxZEmLlTYk3LsjO
	 UojVhfpWpP3BjfrEOr3104UIQHW1lxj9TGGJ0yI+6X3kJw4v/sWX6Lmuo/ow29HyWD
	 rJHnQUcq8IbGAFR/oB9JmPEJ4B2eznpDE/T8idKxn2TgU0gyxhQp655WayNjmREzi/
	 7v4gMmSHbW1Ka8rHD6tGKLYDYcHkG0RX0L1tBTjmMtWbMDiUwNSKkFoKF3UdsrQvoG
	 BoYjmjU16NEWaBAw6Dq4I+gL2LRc9jYz6mdIwj9go+1JhvK7qEbuA+BaeCoO3tKqOF
	 Iw/K6pVV5/bkA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19526E65D37;
	Fri, 22 Nov 2024 08:54:45 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Subject: [PATCH v2 0/3] Add support for attaching a regulator to w1: ds2482
Date: Fri, 22 Nov 2024 09:53:56 +0100
Message-Id: <20241122-ds2482-add-reg-v2-0-a5a03ee74da7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKRGQGcC/13MwQrCMAzG8VcZORtpY53Tk+8hO3RttgXcKq0MZ
 fTdrQMv5vYPfL8VEkfhBJdqhciLJAlzCdpV4EY7D4ziSwMpMroc+kSmIbTeY+QBe9YHUsr6k6+
 hjB6Re3lt4K0tPUp6hvje/EV/vz/q+E8tGhU615jubDurqb4Ok5X73oUJ2pzzB9ApMhKsAAAA
X-Change-ID: 20241111-ds2482-add-reg-fe13200ad7d6
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Stefan Wahren <stefan.wahren@chargebyte.com>
Cc: Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732265684; l=833;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=7rzMvx48n11Ga+k4795VyVqRvaffhTq48wBjDhlzNNo=;
 b=/3H2DNmW19Y6vUUYwxh+ll7I0BRp/3t9orrqSBiaWcUwL5Y/NrWsX7KRoDq04OA/QiTPOpBGK
 GFwHYefiy5KB5KhbaAP3ux9rPEEdYxnJoBNHMgP3xcZ5Lw+u90W4qd8
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=EJoEbw03UiRORQuCiEyNA8gH1Q6fIpEWnn/MyaWOWX0=
X-Endpoint-Received: by B4 Relay for cleverline1mc@gmail.com/20241112 with
 auth_id=275
X-Original-From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Reply-To: cleverline1mc@gmail.com

Sending a new version based on our discussion.

Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
---
Changes in v2:
- Removed property description
- Changed commit message of binding commit
- Link to v1: https://lore.kernel.org/r/20241115-ds2482-add-reg-v1-0-cc84b9aba126@gmail.com

---
Kryštof Černý (3):
      w1: ds2482: Add regulator support
      w1: ds2482: Fix datasheet URL
      dt-bindings: w1: ds2482: Add vcc-supply property

 .../devicetree/bindings/w1/maxim,ds2482.yaml       |  2 ++
 drivers/w1/masters/ds2482.c                        | 23 +++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)
---
base-commit: 6d59cab07b8d74d0f0422b750038123334f6ecc2
change-id: 20241111-ds2482-add-reg-fe13200ad7d6

Best regards,
-- 
Kryštof Černý <cleverline1mc@gmail.com>



