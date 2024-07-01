Return-Path: <linux-kernel+bounces-236413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BBF91E1E8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB02B1F24AA1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27551607B6;
	Mon,  1 Jul 2024 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LX93Psqd"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE5543144
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843033; cv=none; b=uGKeXi4OPCfEGdha+bn4mTZyepPdn2aoTGLomnZqGkJW0bDA7vpXvX30gTd0L/I6jeUTheG6HPfL2c4Hgv+iqTpovzki9RwCZEUp+LS3G9rhVtoG/yZp+7RdZyiidnf4Zi1z3fZRwlnNeUSgmdH784CHXZTBbDq5XPOht85CK0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843033; c=relaxed/simple;
	bh=+meXUlHYX39IvtHzyMlSdD4CA8/W1DMe5IkqgKbMtxw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=R3IgSC3pko3F3L92JcjlKGNg1DRYfxXp4rHQLGMmB+mZ/vz/gGUXHx3mGJas/48NKn7lMk9zELwfKBxwlgHdJSdjkcp9CVRqpWDMsK2QyBi/LJHJRSlTW1a4G3VEKkwBjDcSR3I3JJ/ClQ5YhswpKOsuih2TMzdZQyJ20gxVxNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LX93Psqd; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfe4f388d33so5510032276.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 07:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719843029; x=1720447829; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xm7gCNTjN0klxx6tovnvy/0uS85ngU8K1EvDYCGt6e8=;
        b=LX93PsqddmTSichuni2YK2yfLTpED0+Cv85SiAJ19jwJGFA4MM0rnDVSP2c4psDXUo
         KQEu1yhUoQmlY3lDFxaVHwYkca+eYMLRin0Q/2vB3E7AHQ0LRJdpijKNe88Eax51GsRf
         EyZwHEWB/XL53LzUMXN68UtRxv/+9wo8XZefmtuIlFZGhfCfCY8Ld46Iiln6TkA8Em/Y
         /chcc86o+HcvV4dDnMUIjb5gsnI8U8VutRlLJh65OnCe4sG10Wx/BiV47hC+qfnPW/k3
         1vnCyQlT/Y/7ZScrBFd2kw5Y2/hmTyqa9PwZziQ+miZhUrOAvS40d5OGmKhMYqOKfy9/
         g/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719843029; x=1720447829;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xm7gCNTjN0klxx6tovnvy/0uS85ngU8K1EvDYCGt6e8=;
        b=Y9SOwk7BVzeqcFWLYQFRki6c77xKI25sr3itkloPRepmfXEZsNVAxZw73SC3U9phNA
         8VielkAvFnjexdDsQ4uf0c8LPvnyqitO1bQROSOIyjofkdnTzpAVtK7RQ6rZc/EBukOZ
         hKtv4LW2JZixNYNAkLnX/pfgpsx9d1rFjCRBKriVq5StkHp+uC4AEVSIAfg62DHOEp3q
         biNyXpwHjNozFHKTpxb4D1dsajLpAW+rhH1BOAq946B7uVgClm9oeecGTrN+5axIpXdS
         shsU8TFj5fMvSGLe9sNDs2IyBFro01GbT2M/czHivUS77Q0u61GdpGW19gcZwvZKYjb3
         Gxuw==
X-Gm-Message-State: AOJu0YzeOAMRpNQFgT8ndgPRYXbgKNKZFpAeDLlXhi0+FYKJZty4u6c5
	53bRG6PfUBU9KumVE1LKCA2EtI1sE+ZD224eYE1GuBCbaFWeTPKhNZt/sNLkebUU1xevnw==
X-Google-Smtp-Source: AGHT+IFyGvWNkjohabajKk0DUCPr5cxYV/b1ecDA5W3PW9FG/xKLKP++NvSbyusdNb17qFzWf8syVTft
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1242:b0:dfa:8ed1:8f1b with SMTP id
 3f1490d57ef6-e036eaea1cdmr682399276.1.1719843029591; Mon, 01 Jul 2024
 07:10:29 -0700 (PDT)
Date: Mon,  1 Jul 2024 16:09:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1046; i=ardb@kernel.org;
 h=from:subject; bh=VfwgXPrDjPqhCTi1Z4L2E0I+/0yMfkpDX2LBefwxGvc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIa1px1K3X3deihz4v+ZSnFig/nT5lLP3haKrBCs/MjvKN
 7RsZHftKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPpT2NkuH983+ajsfLG5RPv
 9oqWy39ccjxprUd68avce5ftEm9IJTD8s79WteaA4+9NMVMmLtmR9/X+hT1/X6n71Byoa4kL9Ji 2hR0A
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701140940.2340297-4-ardb+git@google.com>
Subject: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Aditya Garg <gargaditya08@live.com>, Hans de Goede <hdegoede@redhat.com>, 
	Lukas Wunner <lukas@wunner.de>, Kerem Karabay <kekrby@gmail.com>, 
	Orlando Chamberlain <orlandoch.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

v3:
- add patch to make the SMBIOS protocol glue code compatible with mixed
  mode on x86
- update Aditya's patch to limit the effect to dual GPU Macs that are
  known to require the set_os() calls in order for both GPUs to remain
  active after boot
- drop mixed mode handling of set_os() protocol, and dereference the
  struct members directly

Cc: Aditya Garg <gargaditya08@live.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Kerem Karabay <kekrby@gmail.com>
Cc: Orlando Chamberlain <orlandoch.dev@gmail.com>

Aditya Garg (1):
  x86/efistub: Call Apple set_os protocol on dual GPU Intel Macs

Ard Biesheuvel (1):
  efistub/x86: Enable SMBIOS protocol handling for x86

 drivers/firmware/efi/libstub/Makefile   |  2 +-
 drivers/firmware/efi/libstub/smbios.c   | 42 ++++++++----
 drivers/firmware/efi/libstub/x86-stub.c | 72 +++++++++++++++++++-
 include/linux/efi.h                     |  1 +
 4 files changed, 98 insertions(+), 19 deletions(-)

-- 
2.45.2.803.g4e1b14247a-goog


