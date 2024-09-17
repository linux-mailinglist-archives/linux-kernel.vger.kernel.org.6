Return-Path: <linux-kernel+bounces-331930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3818B97B317
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74AA7B25501
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 16:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6296117ADFC;
	Tue, 17 Sep 2024 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="ZZUD1ZTG"
Received: from forward200d.mail.yandex.net (forward200d.mail.yandex.net [178.154.239.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751048248C
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 16:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726591314; cv=none; b=fgNaxnjy8uXypF7xOZKKa/8Kb0JvT3/O2iHzyAL/P1ocOugX6qQxTjvg4rLy5Od+jEeoBoeVzqm4SA4y7GKGqQxiYAT0n/MbFN6yOgle45xYcQG1i3kmdCofSfiFQnSuwEujWx9/MWIsZNMtq+Tx6HaE99tjWjf9f2j7nuDt9mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726591314; c=relaxed/simple;
	bh=PcUsXvt5t2BjRIayHSYsQqgFmmlvRK/A6Tmee8/mcT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Avx+MB4WAtz7hcYy/oKCqhyxlufJ03WrcVLKT87nzg8kCi81g2oueNNtnFQEbqPL93AtL6YVYyt+8iu1cY2rHQHlUJdRpUExuyIfwRz6ywexzT4xSk+uuzwvRLVYp0Dkb+x/4DaD65eVdaGT19v1cIu4834f96uopz4vB4u5+S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=ZZUD1ZTG; arc=none smtp.client-ip=178.154.239.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from forward200a.mail.yandex.net (forward200a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d200])
	by forward200d.mail.yandex.net (Yandex) with ESMTPS id 3EBD564589
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 19:34:44 +0300 (MSK)
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
	by forward200a.mail.yandex.net (Yandex) with ESMTP id 1C66966B33
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 19:34:14 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:3a92:0:640:6d97:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id D96F160E4C;
	Tue, 17 Sep 2024 19:34:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 4YPGSC4oJSw0-eUfSztTn;
	Tue, 17 Sep 2024 19:34:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1726590845; bh=tNvtQy4zqLNoVHoocAvSNAtslnts3O0YSk0ydjob6Zs=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=ZZUD1ZTGryK9Ogn1ZWMemi4x5simG3vOcMVFoJWCEm8H0VScruirZQ9Rk0iwZoAnl
	 SzqmUMRqduAnVEXQlaOAUMkAW0Zeqi5Pev2y2fOlX5pUhuMMFs/mDmwubyezOV5M/e
	 kZvgJ0c2KnYDxW4AS9kPoMIKrUe3utgY58eMA3C0=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: soc@kernel.org,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
	Nikita Shubin <nikita.shubin@maquefel.me>
Subject: [PATCH] MAINTAINERS: Update EP93XX ARM ARCHITECTURE maintainer
Date: Tue, 17 Sep 2024 19:34:01 +0300
Message-ID: <20240917163401.6501-1-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as maintainer of EP93XX ARCHITECTURE.

CC: Alexander Sverdlin <alexander.sverdlin@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2cdd7cacec86..f9672f279a66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2272,6 +2272,7 @@ N:	clps711x
 ARM/CIRRUS LOGIC EP93XX ARM ARCHITECTURE
 M:	Hartley Sweeten <hsweeten@visionengravers.com>
 M:	Alexander Sverdlin <alexander.sverdlin@gmail.com>
+M:	Nikita Shubin <nikita.shubin@maquefel.me>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
-- 
2.43.2


