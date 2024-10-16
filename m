Return-Path: <linux-kernel+bounces-367492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217249A02FC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 704B2B25FF2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B0C1C32E4;
	Wed, 16 Oct 2024 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rsDF+/j8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D65A18B478;
	Wed, 16 Oct 2024 07:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064914; cv=none; b=o2aHVrIVdKD+jTEzVp8Jqr4Fh1k5/ZCYgPTAVjYCG7rfp+lSk2JxHoduY1HNcZcbTdXDW0fTTLa3ZjP4M/m5z+PyfsFX03TwjuXTHlSa92bipg0ESMWxrEUHxr3OAW6sntynTscI7mOUtA1HqKy5YT9pQvdPhv/Ka8kPBWXrElo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064914; c=relaxed/simple;
	bh=bGu+QvRxT9xe7HGIdDLZTCZZ6sTH0lhSLgemm4Sx6lk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iR3BPFXkAe/CoVglO7GjAyy+dlwodrIHpPThKxlqBtCDgF9tNsaFJMRhaHEViU/E+9ShxQBpYQ2fNUFJCsO1y9guKdGHV5IBK6TfLE+yekYTgeBoS1lwsGh2xu960z4u7wpabKkXxSaESL/YA7pDTI6sO4Krn2ufq2O7FoSft64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rsDF+/j8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B1BC4CEC5;
	Wed, 16 Oct 2024 07:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729064914;
	bh=bGu+QvRxT9xe7HGIdDLZTCZZ6sTH0lhSLgemm4Sx6lk=;
	h=From:To:Cc:Subject:Date:From;
	b=rsDF+/j8gDX8VmLrjSawOF3oaRmXxqI+Eo63H3tXKl58s2n1IYuNzy2k31bD7UKfy
	 alddQF96WYkMfyDEpRb8d/F9Lb17hXVPMpwtCh6S4AMm7juMYTNd9BYj7RhbxNefKU
	 LjKEyfVIhFRDoHHVJBs50zoBNE/1awCRqFh647Bs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-staging@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Penkler <dpenkler@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] staging: gpib: mark FMH driver as broken
Date: Wed, 16 Oct 2024 09:48:28 +0200
Message-ID: <2024101628-jazz-radial-3400@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 25
X-Developer-Signature: v=1; a=openpgp-sha256; l=914; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=bGu+QvRxT9xe7HGIdDLZTCZZ6sTH0lhSLgemm4Sx6lk=; b=owGbwMvMwCRo6H6F97bub03G02pJDOn8+WfezpOQ78655PhsT2NPm9KOdTrXWOoYCrdm96jte PMwYV5vRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEwkRJBhwbJarXXrXn1PzFm6 9Ep0uRn31BVF9xkWHAnftfJkyeUJ1RtPTty8qIr/xP6QqwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

When doing a 'make allyesconfig' things break in this driver due to
duplicate symbols, so mark it broken for now until that can be fixed up.

Cc: Dave Penkler <dpenkler@gmail.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/r/20241015165538.634707e5@canb.auug.org.au
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/gpib/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/gpib/Kconfig b/drivers/staging/gpib/Kconfig
index 9f337d57ce87..f41b56b66251 100644
--- a/drivers/staging/gpib/Kconfig
+++ b/drivers/staging/gpib/Kconfig
@@ -130,6 +130,7 @@ config GPIB_FMH
        tristate "FMH FPGA based devices"
        select GPIB_COMMON
        select GPIB_NEC7210
+       depends on BROKEN
        depends on OF && PCI
        help
          GPIB driver for fmhess FPGA based devices
-- 
2.47.0


