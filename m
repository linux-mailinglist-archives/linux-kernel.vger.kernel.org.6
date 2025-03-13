Return-Path: <linux-kernel+bounces-559648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6A9A5F723
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF3507A257D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B92C1F942D;
	Thu, 13 Mar 2025 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="hhVk+t1k"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF3B267B85;
	Thu, 13 Mar 2025 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741874437; cv=none; b=hmPadaCusR0fTwb5p/iuAkftEm/Cm/aWLg0Vu1AElbRCnI8RcT8w9slW2rC/obRHuVz8l/Ck4YxfS40ypVJROftfV3L5XUEWJsEpbPc9HmR02xh2jg3tois44ywM+EOC7nqN58qlZfKiaO1+OFVcJ9ASbvzG/cxsehgga3Nlld4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741874437; c=relaxed/simple;
	bh=OORnarBLZoM8w6pBuDPCN02BbzmkfN+e2BeRwda/AvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sVZDrSL4UJ9rPLYfLL5c2C21n5pNrhRNDr6NjITYOgoSAIjFz773xg+qhVcFY6v9q5wdOi9InHdVPKd9e3sRRmANUR+35w0kbwNWXImdDi8QUOytW5ud+ybhI052D6so9HjQnDW44pVi6blRXiAXs2mqOx95SBo9b8tVTvaxCPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=hhVk+t1k; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse-pc.fritz.box (p5b164989.dip0.t-ipconnect.de [91.22.73.137])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 918132FC0189;
	Thu, 13 Mar 2025 15:00:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1741874430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FOFSQNyM0icOexkDUVBuOK+NmfzXRAGy8joQIWnow0k=;
	b=hhVk+t1kY+j0SNARpZONHmRni3bVnmdG8LUi8AnolLBmkpIkLKNfStEu/gAj5Krb+36qyp
	QupbeFA1zP+T3xUM2E50lD0oarvPoEFlL4+DsanTHDNY2KRY4jO8yTFxPYg/UeConBE9vJ
	OU+ogc5jN5QwGRNyjT4SHDGIK1aGsKg=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Werner Sembach <wse@tuxedocomputers.com>
Subject: [PATCH v4 1/1] Input: atkbd - Fix TUXEDO NB02 notebook keyboards
Date: Thu, 13 Mar 2025 14:31:47 +0100
Message-ID: <20250313140028.617291-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some notebooks send Super + Control + KEY_ZENKAKUHANKAKU¹ upon pressing the
touchpad toggle key.

It can be mapped to correctly touggle the touchpad purely in userspace with
these patches:

- https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/-/merge_requests/810
- https://invent.kde.org/plasma/kwin/-/merge_requests/7278
- https://invent.kde.org/plasma/plasma-desktop/-/merge_requests/2873

But as you can see, this requires per desktop environment patches. GNOME already
has the correct mapping and KDE does with the patches above, but smaller ones
might also need patches.

As an alternative soltuion I also wanted to suggest this i8042 filter + virtual
input device.

v2: Coding style fixes
v3: Send F21 keypress via virtual input device instead of serio interrupts
v4: Add cover letter
    Fix copy paste error "GPL-2.0-only" to "GPL-2.0-or-later"
    Add missing Copyright lines

Werner Sembach (1):
  Input: atkbd - Fix TUXEDO NB02 notebook keyboards touchpad toggle key

 MAINTAINERS                                 |   6 ++
 drivers/platform/x86/Kconfig                |   2 +
 drivers/platform/x86/Makefile               |   3 +
 drivers/platform/x86/tuxedo/Kbuild          |   8 ++
 drivers/platform/x86/tuxedo/Kconfig         |   8 ++
 drivers/platform/x86/tuxedo/nb02/Kbuild     |   9 ++
 drivers/platform/x86/tuxedo/nb02/Kconfig    |  17 ++++
 drivers/platform/x86/tuxedo/nb02/platform.c | 107 ++++++++++++++++++++
 8 files changed, 160 insertions(+)
 create mode 100644 drivers/platform/x86/tuxedo/Kbuild
 create mode 100644 drivers/platform/x86/tuxedo/Kconfig
 create mode 100644 drivers/platform/x86/tuxedo/nb02/Kbuild
 create mode 100644 drivers/platform/x86/tuxedo/nb02/Kconfig
 create mode 100644 drivers/platform/x86/tuxedo/nb02/platform.c

-- 
2.43.0


