Return-Path: <linux-kernel+bounces-349875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FF698FC8E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 05:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC230283B2E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 03:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE41D43ABD;
	Fri,  4 Oct 2024 03:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ju+DWacT"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EFE22067
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 03:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728013357; cv=none; b=K9v6QvN+pvBXkPs0JRrGaD/8ES4p3h3aYwvPWSCVgZqoBGfTq7xpSwQj10Rs25GGUzvE6F/UTEitx0WeXonZP9rdUCSxlinpUQkaBaX6Q2e4AY2E2cwPAMJPCzeuCHs6f4XrStZkSUWF4p8O8s5vz9uosgS/iqgcHaQwNR9Nr/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728013357; c=relaxed/simple;
	bh=eShM+8qD3+izMvNynHezdRQaLgQaRTBvWG2wJCcwEKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nylpRqKKzlt3d25mjIWktxnSGr4SgS+eQ+PdCzKTwq7sQgzHTvlKnZdh9KVp0xQUPgoz2IUfFVTwp1iqqoWEnB15+7uYIPIL0/yfi2TppDW2dtrOnGObFharc9BhMFMM44OSPdRFkpl9J3ppQNYtXwZkJGYer229tLG+lQ5/M44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ju+DWacT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20b90984971so17971935ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 20:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728013355; x=1728618155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/k4t1X9HW0gv4C4rJatY6CF+LcH2LmAGsSgjwSUDdNc=;
        b=Ju+DWacTP47BCPAvnB6T4UP/RpgNAj4y0uBy2xFLf78aotFfElEt6GiLlJZ2/4U1PP
         CZ8SOvyqV76A0GSyE45DmrmKQODkgCKWNT06ArlyZBCy7jUmEWmBJc8su0ftSZnEvAxb
         y6q9wSigWCyrpvCgjBka6kqszCOs55RLI2yvJ0eWLaDcFTP8YVF9MM85NrPJQUDXLOep
         rEqIJ+re5nHKPjbcsZQLrHiC0evDu+L4cUDyzhxjjh5JOPglqcPQjsFPJvOsv/kAc+/j
         DrKSPadPUGSCgZ87wCAtUWzNfe8pVGB2PCTOX0kA8Z36nDuDvsEWI8Oe/s4OO6ouEhEp
         4Qcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728013355; x=1728618155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/k4t1X9HW0gv4C4rJatY6CF+LcH2LmAGsSgjwSUDdNc=;
        b=V8Pev9uDZvj4WjAucFMygAAy+19jv1rkw84NRda8D1iYJNcVPLob1nVcgbmsbEDQVN
         Tw7z+4LnRHdGr18cCGi2N8q16RUZQVTh282HA6/YM6ZTgFTHiyOUdLO9nCMbdtJBC/0g
         iU39z/zXE9BmqCsTV2K798dY0IuPrJSI/U0mpb7BGsnyHD1mIBHroMHjEbO7iASCRYlH
         NqeNNBiAmuQN7/09GZXeTvk1HWry6w2mkn/zDQjkG5uUsNoEcLze/Mq8SVs1CwRj0zb9
         4xXaJfG0T+i9D2HI7RgJG5zdzzKita57HzWJUOM8iLJoselJ00LwYLaD9QO/19YMKtJp
         RJ0w==
X-Forwarded-Encrypted: i=1; AJvYcCVSsm8I0AQx6ke3EPdpZ/2jvkL55TwDB0Gfj//2vwNJsxTd3YIOG5BxIH65afd20j815DNVuMlpAiNbWpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUqyC/qRZzR8mzEksoVyXiFyCJyzL+Bepy6+4g1mBfF/bjIquR
	oPEG2I/ioGa0Sv0majcurybSre6J2nPnUmDBJGrjgmbuwOZeeKSI
X-Google-Smtp-Source: AGHT+IE4/oISY4qUDHtc5QkLC3khS3w3EkerY6i0U7q2FWl9om080gyDNLKdFV++fvUqPoIs07gpDQ==
X-Received: by 2002:a17:902:f68f:b0:20b:54cc:b34e with SMTP id d9443c01a7336-20bfee34d54mr19636205ad.51.1728013354988;
        Thu, 03 Oct 2024 20:42:34 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00:b8ac:3fa:437b:85fa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beef8ec6bsm15806365ad.158.2024.10.03.20.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 20:42:34 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Justin Chen <justin.chen@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 0/2] phy: usb: Broadcom BCM4908 USB init fixes
Date: Thu,  3 Oct 2024 20:41:29 -0700
Message-ID: <20241004034131.1363813-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings list,

This is v2 of my previous patch [1] targeted at resolving a crash-on-boot on
the BCM4908 family due to a missized table.

Changes v1->v2:
- Florian requested this change be broken into an immediate bugfix (w/ the
  'fixes' tag) and a second patch containing the coding change aimed at
  preventing this problem from happening again

Best,
Sam

[1]: https://lore.kernel.org/lkml/20241003211720.1339468-1-CFSworks@gmail.com/T/

Sam Edwards (2):
  phy: usb: Fix missing elements in BCM4908 USB init array
  phy: usb: update Broadcom driver table to use designated initializers

 drivers/phy/broadcom/phy-brcm-usb-init.c | 433 +++++++++++------------
 1 file changed, 215 insertions(+), 218 deletions(-)

-- 
2.44.2


