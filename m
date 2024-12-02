Return-Path: <linux-kernel+bounces-428275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5AC9E0C49
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF61282BBD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F3C1DED6F;
	Mon,  2 Dec 2024 19:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hmfy9Old"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDCF1DE4D0;
	Mon,  2 Dec 2024 19:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168322; cv=none; b=cA574YaWq0Dkchc+R1ZWFunURadMpDsyhUOCJxiVvcH5XxY/TcPqrLLIpkTeN+5G/W77nJ0RkE7Lr8vhw8fpizH7Mimu9eRelU07vlx8yNYTjT3jOBHp2ooMfPb1MlZAC2RyVUmlJOskvQMQXLESpeCeEogydbgXjbJTf6um5z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168322; c=relaxed/simple;
	bh=CCLjKz4p9ifDEuTD7i7Xx+E3HYG987FaG9aqLLF5Qvc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hvyDtkQHULuJ+/xqD6jus6tc96/m93rsqAXLl3Aa4og+uqVeEvJtuP3MUD3cLWdsu1EziYtET+dLRT4bKg4B1ZuiQAPfkOYJQgq0GYjPG+gF0t6FH+24XF7FyxcarAjWvYUU8+rJk6BYj5+z2E+wUX5bdzO0PAxgYQQ7wgAK5OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=hmfy9Old; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733168316;
	bh=CCLjKz4p9ifDEuTD7i7Xx+E3HYG987FaG9aqLLF5Qvc=;
	h=From:Subject:Date:To:Cc:From;
	b=hmfy9OldGu2MUnjh5a14kl54b3yqaLMbRVsQPuZUZ/2I3aAXMrmwSV0R6fWOpBiwj
	 88wUxK5DYFYBr6xhyxGfZiGO6oouImn2Tn9vjuLChL7iG1xw2Ni0jEU1gLpWwyHXHL
	 2Xb4DcpHl1+2nFF4K7K9E0fSi+ZmXhBT/oue2l50=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/5] platform/x86: Constify 'struct bin_attribute'
Date: Mon, 02 Dec 2024 20:38:31 +0100
Message-Id: <20241202-sysfs-const-bin_attr-pdx86-v1-0-9ab204c2a814@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALcMTmcC/x2MQQrCMBAAvxL27IKJNYpfEZF0s9G9pCUbpKX07
 128zDCX2UC5CSs83AaNf6IyVQt/ckDfVD+Mkq0hnMPgDairFkWaqnYcpb5T7w3nvNwjko+Urvl
 yM4EN5sZFlv/8+dr3A3HrrWtsAAAA
X-Change-ID: 20241202-sysfs-const-bin_attr-pdx86-c16ca5d376ca
To: Stuart Hayes <stuart.w.hayes@gmail.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 "David E. Box" <david.e.box@linux.intel.com>, 
 Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, 
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733168316; l=1415;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=CCLjKz4p9ifDEuTD7i7Xx+E3HYG987FaG9aqLLF5Qvc=;
 b=fbCmy4KqhmkC8aA8an75i/z6sDXnvm83lqZlF47zBtLi7BS02dQNo8YLruAaMzKuv7lKXfnj1
 c5h2qz5EZHVBid1+d+RZT3wn4EMhn14MgU5hA0cmPj5ECHi5EZE62re
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

The usage of read_new/write_new/bin_attrs_new is a transition mechanism
and will be removed after the tree-wide transition to
const struct bin_attribute.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (5):
      platform/x86: dell: dcdbas: Constify 'struct bin_attribute'
      platform/x86: dell_rbu: Constify 'struct bin_attribute'
      platform/x86/intel/sdsi: Constify 'struct bin_attribute'
      platform/x86/intel/pmt: Constify 'struct bin_attribute'
      platform/x86/amd/hsmp: Constify 'struct bin_attribute'

 drivers/platform/x86/amd/hsmp/acpi.c   | 12 ++++++------
 drivers/platform/x86/amd/hsmp/plat.c   | 12 ++++++------
 drivers/platform/x86/dell/dcdbas.c     | 10 +++++-----
 drivers/platform/x86/dell/dcdbas.h     |  8 --------
 drivers/platform/x86/dell/dell_rbu.c   | 20 ++++++++++----------
 drivers/platform/x86/intel/pmt/class.c |  4 ++--
 drivers/platform/x86/intel/sdsi.c      | 34 +++++++++++++++++-----------------
 7 files changed, 46 insertions(+), 54 deletions(-)
---
base-commit: e70140ba0d2b1a30467d4af6bcfe761327b9ec95
change-id: 20241202-sysfs-const-bin_attr-pdx86-c16ca5d376ca

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


