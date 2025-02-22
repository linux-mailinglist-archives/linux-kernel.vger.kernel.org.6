Return-Path: <linux-kernel+bounces-527460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7F8A40B7D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74CEF3AB109
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8CD201113;
	Sat, 22 Feb 2025 19:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="i/+2dm/c"
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4EE20101A
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740253337; cv=none; b=RritSyRkiU7RHLhJTlB8EyEmrtApyFF+FOtdML9BzGB7yL1lLSMfyYDs9z8UXl/eTGF/pgjqo2liciR4drQbXlHALAc1GzdIogd9QrHprEx6e7YtlUhTOv5QEcTyKGoPtBlHfGg0op63lDd/czqhUKCQkEopvQ5WzUMoy0IEu3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740253337; c=relaxed/simple;
	bh=j1q5n/HUVw/zxMoNDqNZmL4I4OG1BZVMxCj88fnlUTM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=QffrJLZblTsiYiqhMayhgdA0MwLbT+dECLCil+qe1bHf7xsK92bVSek9D2Nba3KT9ebtJpYyDlM1oZVJ0883ivItwznK0XoISwBuoUn6IApeyqz9pnOLs5bqJj+R/EGZi2uI6Axb3BlzapXJY0aO9Tl+ihF10QKnK053Z9trAws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=i/+2dm/c; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1740253025; bh=aynS2a/kPanX+LjKJ5jXaswTqt6h+e7tIoipmNInIxw=;
	h=From:To:Cc:Subject:Date;
	b=i/+2dm/cUXgPoDXaW6Ox/g8AqFZVWAjqsIrSDseGf7H5kg3IAat5lt0JxhhcZmB8w
	 eOdoBYE6XNG2vckTMRWtb3dG615Fcbftf5VOYoQukAcDsHWLhJF95n88zMwj7gYQYd
	 kckonNx/ABdDUqAqTtioo/H8FNHpk/MFJi+6fQGQ=
Received: from mail.red54.com ([139.99.8.57])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 93031CFF; Sun, 23 Feb 2025 03:36:48 +0800
X-QQ-mid: xmsmtpt1740253008t1qpfuhzk
Message-ID: <tencent_0BDDF3A721708D16A2E7C3DAFF0FEC79A105@qq.com>
X-QQ-XMAILINFO: NDgMZBR9sMma2vJX+AgOZyC9uQnYIokU47mtTtkAAMa2B6aY7d1ha3Ux33Mz/9
	 cKVaJuZUw64Zqu57ZKMFL3rLA7hn/4nzCXclFHGy3Tddi+AF+oUwIcTeBGkPqbcuo7bpvFOPO4op
	 70ZIL3ymqbifxqsOLlsAujJO8p4PQBWwMubpY+QnSNtpFGXlOb8zGPR1YhMyry2nOHJa+rBlbNZ/
	 EU7CfRlQL+k1C5yOWxwPm8rbEnP39+iuLO9qosVTI17XjZfkN3BBvkUBCyTGSP3+jM5Gx3nVWzxZ
	 pOOc2gHuHzSru8YRmhMVAMynroEzo3Y1yno6I8PssjkZf3xp/RolyaNPNeLS3A9c/UNJzQ9aDhyy
	 iI+I0/kAzhEd1DnAH+fF+LjqvPNBmrik7C5F+Gj4Fh/vZwGJqVgeYjzAsuMDEErs8eREOpoXgWbZ
	 PMYgl4W40DdyzIYS+FxgSh5ZSOcU2jA24Mw+KqMLFr7BLs+amEc1ZWCQDqH5p0V5bc8Xjxr1HS97
	 5+yoiFb1cdMJOzPGCINzi1kxbNuhFbbEwf9mIAapL5FrANAc3FJZl/b0lcj7bXoh0TaGVfpkjtxX
	 gI6OC9dUkZOlahvB1kVl8Pv9YY/zlo3edyLeONcmALwyRahIaW9HdTVh5nXDo/Km/+exx7RZ+AS+
	 tLyc/nnOM5DfW+K6qz19inRMMaGCxGJMMNuB0AH3NGmSVazk6OQEyZhk1aL4KJdEDxtjTm2T04r8
	 NSHUffdB6ffEB17m6cOXBapjLad6c0+z/POa4cqfL+F81wDWL542T1cvjCdoD2paFkLnUkiK2uUU
	 ER0YWz6enPSiJE9sekVjWZlzxjjAsNbNSqsW/JujU2tgBT8FJFOAwkfOdYUU/V9hpEn16ot6thJ6
	 JJf/nAqzq09vMbLqXLQ3r3L5PN8WA0vXdGPSGubDnlLIziH8UhVDRAoJ3JiJvSbYZRzFnqRXlDSS
	 C1Ac1K1ur6K7FyFc14qsuQ/5ArzCln
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
Sender: yeking@red54.com
From: Yeking@Red54.com
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Robinson <pbrobinson@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Fabio Aiuto <fabioaiuto83@gmail.com>,
	linux-staging@lists.linux.dev
Subject: [PATCH] staging: rtl8723bs: select CONFIG_CRYPTO_LIB_AES
Date: Sat, 22 Feb 2025 19:36:17 +0000
X-OQ-MSGID: <20250222193617.396927-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>

This fixes the following issue:
ERROR: modpost: "aes_expandkey" [drivers/staging/rtl8723bs/r8723bs.ko]
undefined!
ERROR: modpost: "aes_encrypt" [drivers/staging/rtl8723bs/r8723bs.ko]
undefined!

Fixes: 7d40753d8820 ("staging: rtl8723bs: use in-kernel aes encryption in OMAC1 routines")
Fixes: 3d3a170f6d80 ("staging: rtl8723bs: use in-kernel aes encryption")
Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
 drivers/staging/rtl8723bs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8723bs/Kconfig b/drivers/staging/rtl8723bs/Kconfig
index 8d48c61961a6..353e6ee2c145 100644
--- a/drivers/staging/rtl8723bs/Kconfig
+++ b/drivers/staging/rtl8723bs/Kconfig
@@ -4,6 +4,7 @@ config RTL8723BS
 	depends on WLAN && MMC && CFG80211
 	depends on m
 	select CRYPTO
+	select CRYPTO_LIB_AES
 	select CRYPTO_LIB_ARC4
 	help
 	This option enables support for RTL8723BS SDIO drivers, such as
-- 
2.43.0


