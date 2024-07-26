Return-Path: <linux-kernel+bounces-263485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C652893D6B6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A141F25578
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB2B17C7A2;
	Fri, 26 Jul 2024 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e1gUi3vW"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320C817C22B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722010145; cv=none; b=HUzFSrYYfn0AEhXCP7xl26/wYiiAMgWwg0REp3l21A5iL9XtD/OdPyf72h+R5yTSX0KjsQFBWwJWH+quyPoX12Md3GoLa/bmZgcRx2ljXUItN/vTC9MEvJExioMvAwlEad359dw/ZCSAJ5G45PmC1MfRmfgH8i+pusEkUwqX3o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722010145; c=relaxed/simple;
	bh=jPX1zF/m58GweQPRJHV+jxXdrDFq0MEinvq2Kbi1wOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qFfxXKuPtjfKuoV2xVYkvO15bM0rlgWLvG0+mq1WWduZoQYvNIxvKL6z8LKT0NLrRv4qiWR5WFSby1rl1IgLOl6qzhZHVjAghkvANIeuPmuvOoJMTO93X4Cb45kkauFmhhEuzyrPRZrhY1BQQGN2oV+V8WTjObhj/s+JtxfWUUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e1gUi3vW; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-8036ce66134so57481939f.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722010143; x=1722614943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SCXYqPQn405+twdpMIVNsWhhsXXKXZ8d6OiTnerw59k=;
        b=e1gUi3vW/jD4ayGhhMsOxJqtqCHtt3biYBwzb4J0c1nv/DdcnLs4pRJGI1NtG+/DQ9
         U1U7RxRAru2ABIq4ATfhdjTieBqb1q3ISwPjqYH5ARPCxszSnE3ERumFmvFleUGvlHmc
         PiTEke/HyHEgIkUfjcdMuu/q8cXegKwlL1/D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722010143; x=1722614943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCXYqPQn405+twdpMIVNsWhhsXXKXZ8d6OiTnerw59k=;
        b=M28AASUf5YMhrcNq6ZrEE2ciz8XjvfGtGeH7+NNnpIpNooQp4CN499iVIFfOXoPe3z
         +xMlleRLfDFfycvJ+se/KYJyaHGiyXvcVk58vuZjT9u+hvG30Ny9Sy3PgwZMZm9i6Ta9
         lHl0ABU8pOnHtvnHktiyCxRlDy2OzDk07HITwAuktwctFQF9cA0tESnlq69C7gdippor
         /gE1J91OpJyscVGaTfM+NE8zKXarE+NwP+aT4jUoEBn+VEhuxhHuWSPHQblYdpP8e+qr
         WVuFLTe441D1QncHQh/SAzPwMZ9Ktio1I/b/A4yPfjXb4uK3kzHSOJuE0hox+6nGF873
         oF8A==
X-Gm-Message-State: AOJu0YxI1K5HfxJpOUhO0Hm3Fqj33tyn/Wp411JliUIdJf69os53Wfye
	Rz4j42XO41BlE6LN85jTumbtH8yob5Vr11tGt8RNG12ABvs9eTaFRqq+2EfqCGEMrO0RoTQsugs
	=
X-Google-Smtp-Source: AGHT+IF89K4L+EFV5BbuRK0rkV0iatoHnT7+eF9NQG+IOLkRXMueCAWlTF9eeG3e906UD3i/+x/RSA==
X-Received: by 2002:a05:6602:27ce:b0:81f:84c1:1ee8 with SMTP id ca18e2360f4ac-81f84c12941mr649589339f.6.1722010143181;
        Fri, 26 Jul 2024 09:09:03 -0700 (PDT)
Received: from localhost (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with UTF8SMTPSA id ca18e2360f4ac-81f7d78b8bdsm112559139f.31.2024.07.26.09.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 09:09:02 -0700 (PDT)
From: Matthias Kaehlcke <mka@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Matthias Kaehlcke <mka@chromium.org>,
	Matthias Kaehlcke <matthias@kaehlcke.net>
Subject: [PATCH] MAINTAINERS: Update onboard USB dev maintainer email
Date: Fri, 26 Jul 2024 16:08:47 +0000
Message-ID: <20240726160858.1722235-1-mka@chromium.org>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the email address of the onboard USB dev driver
maintainer.

Signed-off-by: Matthias Kaehlcke <matthias@kaehlcke.net>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c0a3d9e93689..cd0e5d03fd21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16994,8 +16994,8 @@ S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/i2c/ov9734.c
 
-ONBOARD USB HUB DRIVER
-M:	Matthias Kaehlcke <mka@chromium.org>
+ONBOARD USB DEV DRIVER
+M:	Matthias Kaehlcke <matthias@kaehlcke.net>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-dev
-- 
2.46.0.rc1.232.g9752f9e123-goog


