Return-Path: <linux-kernel+bounces-551360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749DEA56B7E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C9587AA268
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FFF220682;
	Fri,  7 Mar 2025 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KDrkAndT"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FE4220683
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360215; cv=none; b=WCGOMibbWhqNdB+Ymd3bs++cp+wprddx4yPF14fMcEmhbSFLykpNkeWBPu4TVtDcQFt4LP3yNG6ZtRUT3gchmadr/o9p1f3UrzvYExrPsmnvpqGeY2+c+jqhJ7soInicdfIo9pLpGGLNV6BZ/njtie5mM/wvSGIPcMTb1MV1uas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360215; c=relaxed/simple;
	bh=6BdE3BOmpc0hWHpiv/1U3xCx/f6RR9FEN5UM+tYYQew=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OdjNvaGGrxNaQUntQtbEDnO29PB6TPoVeTee/eOkwTiPJ6tYgTn04ODB3PIOR3z8pESaTQlHhVv7GUG4o61qJTYtfh9+MW+jmo0DgQWgrmETnLepQILGSGqfTM6ucFvTPkj3ZMBNN7OJASk1VMuFNIBZAhP7s7WzNNsYO/8+UyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KDrkAndT; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BuJf+DWtLBBhZh38ItBtEvDGGJVgmVqlp/Eo3nFZtyM=; b=KDrkAndTkH7QTO69oufln1sMwf
	nDDWW0PxU6tSdOjTNI5oj/WBO3TzCvdH9Ooy6PIfsyEhQbPLi8TA4E0EWFWx7C1dgUCfG48xewoBo
	Dz0hRxL/00GvSZQldeRG2cm9H3HaSa1VIYBSRnQ7cb5XDE/Scmol6GHeFqAsariXTp3yfwpbFODpA
	SgeywavZUGedinBPeHjqztGFNNFMuF/fVz7FI26+NlEjINJcWUAD89w5JItiEWL7BM6T0anx+qdoI
	QUjhdXQSWROB7DwLNd5A5lCpy4aNqDMTeJNxhqJ4VVwEJAwNjpQ+KRmQcgsSUYyLM98CzdZc0v6L5
	Lfnqq8ow==;
Received: from 179-125-91-70-dinamico.pombonet.net.br ([179.125.91.70] helo=[192.168.67.187])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tqYrH-005OEr-VB; Fri, 07 Mar 2025 15:39:34 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH v2 0/2] char: misc: improve test and dynamic allocation
Date: Fri, 07 Mar 2025 11:39:26 -0300
Message-Id: <20250307-misc-dynrange-v2-0-6fe19032ef76@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB4Fy2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI1MDYwNz3dzM4mTdlMq8IrBkiqlJsqVRommqsaGlElBPQVFqWmYF2Lzo2Np
 aAAp9OjRfAAAA
X-Change-ID: 20250307-misc-dynrange-d54c92a5e319
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Dirk VanDerMerwe <dirk.vandermerwe@sophos.com>, 
 Vimal Agrawal <vimal.agrawal@sophos.com>, linux-kernel@vger.kernel.org, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
X-Mailer: b4 0.14.2

This includes a change that prevents dynamic allocation from using a minor
number that belongs to the historically static reserved range, which is
still used by some drivers.

It also improves the test, including a lot of corner cases, specially ones
that would fail before past fixes.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
Thadeu Lima de Souza Cascardo (2):
      char: misc: restrict the dynamic range to exclude reserved minors
      char: misc: add test cases

 drivers/char/misc.c             |   9 +-
 drivers/misc/misc_minor_kunit.c | 509 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 509 insertions(+), 9 deletions(-)
---
base-commit: 2397d61ee45cddb8f3bd3a3a9840ef0f0b5aa843
change-id: 20250307-misc-dynrange-d54c92a5e319

Best regards,
-- 
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>


