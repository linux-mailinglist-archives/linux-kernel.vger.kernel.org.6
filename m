Return-Path: <linux-kernel+bounces-178370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2F38C4CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E292282747
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5321111A1;
	Tue, 14 May 2024 07:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oZSJ7wrt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F132DD304
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 07:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671017; cv=none; b=Y5BpxHphLbO0+LbeE7cxtwWfPAuSIjlfDsOc0In37w1+Oixda8FZI2e0daQjXbT/BlWECjIiqbkmQE9pdZm1wGrdt7zO6F2ZftkDji221oWARfkxuiHDt67G0MC7q+6UYtjoapl3ZHGjUtyOclmSWVP4dCibBoqJRdCDJNpeHdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671017; c=relaxed/simple;
	bh=bIykSKFCjgwKnx+bEcxlKpVpSfpJtdr6i7KWveGNpYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ga/B6OXX4aqBrrWVn2prFaggePeQZQuijbQf3uQjxHMoncUz171HTCUmOJwKpKMh3iY2/r4yh7weQl6JFGwlGwMliUX69mV3ABiQUS/8kMIUHh7mrwk4HnuYyTZeCabFwoV0r1IWcn6DZM6EMytmExNBCnVUjRUAbYkevnWOa6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oZSJ7wrt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0C3C2BD10;
	Tue, 14 May 2024 07:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715671016;
	bh=bIykSKFCjgwKnx+bEcxlKpVpSfpJtdr6i7KWveGNpYk=;
	h=From:To:Cc:Subject:Date:From;
	b=oZSJ7wrtdMHfn4vPEaF63kXrxmV6IEVxbLDpx2yJqIhYOKoK3QGy8h6JY2YUqhLPq
	 zGGN+LM3nDpScTJL5XXx1sZoK8wZ8KWd4+X6WXQRzEn5wb40W1RfPcHX9gmSkfesAK
	 eD8Whh31djUgNed0pEKjBs6XGz/8sR0Yl04aWFfo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [PATCH] misc: ntsync: mark driver as "broken" to prevent from building
Date: Tue, 14 May 2024 09:16:51 +0200
Message-ID: <2024051450-abrasion-swizzle-550b@gregkh>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 30
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=bIykSKFCjgwKnx+bEcxlKpVpSfpJtdr6i7KWveGNpYk=; b=owGbwMvMwCRo6H6F97bub03G02pJDGnO/I/2aLIpl5vJuOba+lvn3v2W/P74ihcHHrSsi1m5e HXZqd1nOmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiS34yzLOT/cHc8WhvhwVv xmH+h688SnUyWICiVU/U3W1WPq15X1Zf8sWrtbC99B4A
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

The ntsync code is only partially enabled in the kernel at this point in
time, creating the device node and that's about it.  Don't confuse
systems that expect to see a working ntsync interface by teasing it with
this basic structure at this point in time, so mark the code as "broken"
so that it is not built and enabled just yet.

Once the rest of the code is accepted, this will be reverted so that the
driver can be correctly built and used, but for now, this is the safest
way forward.

Cc: Elizabeth Figura <zfigura@codeweavers.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 2907b5c23368..faf983680040 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -507,6 +507,7 @@ config OPEN_DICE
 
 config NTSYNC
 	tristate "NT synchronization primitive emulation"
+	depends on BROKEN
 	help
 	  This module provides kernel support for emulation of Windows NT
 	  synchronization primitives. It is not a hardware driver.
-- 
2.45.0


