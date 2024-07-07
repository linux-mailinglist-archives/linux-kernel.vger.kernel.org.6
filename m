Return-Path: <linux-kernel+bounces-243491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97B99296DD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 08:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68042814DE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 06:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A19DD26A;
	Sun,  7 Jul 2024 06:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brMW6xzB"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64905AD58
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 06:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720335120; cv=none; b=LTibe/cRmwRsXQzb1X8ZUWKCVX8amud576kqR4QueHrvXHtpKuMKpYCREc/4qLJXSqZOdPKGIFh9hkNsVpoqyBk7B0iPSNYXd1zBRzAjlpC9u3E++/EttxaS698SvywDTuJJfXFNHWiRryHcQs++bS25u2AtrxQ/Ke4LM7D0OLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720335120; c=relaxed/simple;
	bh=L4WoQul3N5LS7PJxrWssweaVbAa+vK+j6cEzfVUg2So=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T3Nx9zlCqAzv9vk5CjgFr0v97M7sofIub1X+ijXCOGHIm0Yw45Sm3aHmyjiMPTg/NyffZfP4pgHvKq+ks7POffOq3qA+jsHoBdOQ5ThxP8tv6ifuTzLdq810Ft2jYtbTNZcsxGEUzWAYJVPyHWnE+3mU4vaq3DWmcC3JV/fi+4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brMW6xzB; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-58d134ecd8dso470250a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 23:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720335117; x=1720939917; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6XOOmKwyPR1K1bWeX1bkuqoM5NDjvh/8+FGEvea0Jow=;
        b=brMW6xzBYjM+KZU+Pmb1Sh2JQZPc/BiEnkozE25ZjEUoA+Nqo+6FeKtmfC8cg4r1wp
         wUygWnvigcSR2qOukOq1igbOQFRXEGiLz84NsJIaU9E3vytNhI/BaXaqkF5xrzA9alLn
         XqxWR7inSDPAVt6yDMakPPsqnhsOhAnmEU4KvkrgJNGFh/V5ODSz57MeLVm1XIRPOe5s
         hpy1/bxPea10fdeVb/17/yFb5vQ633l1V0WKKTYEtQ2dHfqdxDXiYNBaVMe2QialD+0E
         inuNl0S46naq1hCL/DTEZU7xUrnNwA937fmxA+2Y7mHl8MLj7txNfHiVm71aY683yYJM
         Mrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720335117; x=1720939917;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6XOOmKwyPR1K1bWeX1bkuqoM5NDjvh/8+FGEvea0Jow=;
        b=ndaHRbzM8TtaNt8uOWbjRZrDhHqVimezI8LGJpvuFCak59hon+ktsXJ6PVT76fWSh+
         YqG7CtCXQyuhP5+HrKlpFf+qs6rp/OrqVvcI2YmWcj9R5/yWWt727kkQ51aJrfTw2AeP
         61sdOCaN59GkSEE2Diu9C7iZ4pTH8D6St3IQTBhN6u84C/Qyt4i35V2v49tcoQr6H2UW
         9NdDHFMT7v/tiH70au19MeZRuc7+qcacaQ9FOI+szQ3Iafwo4UU0Ftuj9cizeUYlVEoE
         psH5+qRiJnBnzIBV2rH0HKI2VF5059iRPtkmoeTE/CzFNjJ1SxyG9aA8AZYBx8az0SOO
         RgBw==
X-Forwarded-Encrypted: i=1; AJvYcCU0YHoqHUHpthevXTBX43MxDQXcfDsSh39Q//XYKI6DgDrEbPLtqmAVhCKW1HxRCrLBXdA+kj2YpXHfo5bOK26xWQVMKrFFSTzTiHED
X-Gm-Message-State: AOJu0YwJjX6zQcsHmfIqkGQ04SzEW7XXkPQVQKOo1VdYugEOqRrtFGYP
	lF9vECYEgEELVZGsZvkxD0nNMHFaP1Vmql3pLqgdTFhAL0G27iIZ
X-Google-Smtp-Source: AGHT+IEiED1MqeinvizuswuqGoOHbKZeca0Haem6CX69FMhsyBn/byEZw5xQMR58wYUJAzHA0KBbyQ==
X-Received: by 2002:a17:906:7f0c:b0:a6f:186d:9e9f with SMTP id a640c23a62f3a-a77ba727942mr595413466b.5.1720335116417;
        Sat, 06 Jul 2024 23:51:56 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab065667sm822029966b.114.2024.07.06.23.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 23:51:56 -0700 (PDT)
Date: Sun, 7 Jul 2024 08:51:54 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] staging: rtl8723bs: Remove unused macros starting with
 hal_com_h2c.h
Message-ID: <cover.1720245061.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Remove unused macros.

Anyone who thinks this can't go wrong is mistaken. Some of the macros are
double. I checkt that those are with the same value. However this is
a manual process.

Tested with rtl8723bs in ODYS Trendbook Next 14

Philipp Hortmann (13):
  staging: rtl8723bs: Remove unused macros in hal_com_h2c.h
  staging: rtl8723bs: Remove unused macros in rtw_ht.h
  staging: rtl8723bs: Remove unused macros in hal_com_reg.h
  staging: rtl8723bs: Remove unused macros in hal_phy_reg_8723b.h
  staging: rtl8723bs: Move last macro from hal_phy_reg_8723b.h
  staging: rtl8723bs: Delete file hal_phy_reg_8723b.h
  staging: rtl8723bs: Remove unused macros in Hal8192CPhyReg.h
  staging: rtl8723bs: Remove unused macros in Hal8723BReg.h
  staging: rtl8723bs: Remove unused macros in HalPwrSeqCmd.h
  staging: rtl8723bs: Remove unused macros in rtw_mlme.h
  staging: rtl8723bs: Remove unused macros in rtw_efuse.h
  staging: rtl8723bs: Remove unused macros in hal_pwr_seq.h
  staging: rtl8723bs: Remove unused macros in rtw_mlme_ext.h

 drivers/staging/rtl8723bs/hal/Hal8723BReg.h   | 373 --------
 .../rtl8723bs/include/Hal8192CPhyReg.h        | 882 +-----------------
 .../staging/rtl8723bs/include/HalPwrSeqCmd.h  |  11 -
 .../staging/rtl8723bs/include/hal_com_h2c.h   |  76 --
 .../staging/rtl8723bs/include/hal_com_reg.h   | 796 +---------------
 .../rtl8723bs/include/hal_phy_reg_8723b.h     |  69 --
 .../staging/rtl8723bs/include/hal_pwr_seq.h   |   7 -
 .../staging/rtl8723bs/include/rtl8723b_hal.h  |   2 +-
 drivers/staging/rtl8723bs/include/rtw_efuse.h |  13 -
 drivers/staging/rtl8723bs/include/rtw_ht.h    |  22 -
 drivers/staging/rtl8723bs/include/rtw_mlme.h  |  26 -
 .../staging/rtl8723bs/include/rtw_mlme_ext.h  |  37 -
 12 files changed, 4 insertions(+), 2310 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/include/hal_phy_reg_8723b.h

-- 
2.45.2


