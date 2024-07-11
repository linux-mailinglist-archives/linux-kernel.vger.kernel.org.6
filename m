Return-Path: <linux-kernel+bounces-249002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BE892E4E0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E720A2853B2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0C5156962;
	Thu, 11 Jul 2024 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UiEeqhym"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25F815B55E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720694054; cv=none; b=BrFBzGeT9vHxr9VHdj1MxOm0KZDT2jAr+s2f9z1jPCyGwhIrOKLVmhQu4sln1RhFP2ii7y0IpwQDukMJlkPSZEr4TMpsugJrMYC8QwVg39KHguR4FyBoB3N3s0K/9EykqWhPS5tcXF9yMZQ9qfdAJtFOwOnKvpOryCEoNLdrkIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720694054; c=relaxed/simple;
	bh=U8ma8KhMaM2r8zgII+K905t72sTILD7DaVFiHDJtZZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zflh1zv1tjv4B2U/VW4/brEsehXbPfcGSzFXgfcYU6e2GLUgXv2r3LnGH6P07f/hSohpWCHE7UgoRIyABrhSdCONRWd0fELfn24oCLBiOYFOd6/z5rYrfNB6zUrv11XuVoTITYKU0c6Ys/ASq/qk4VJzgfGgNLJqiRpone+1SEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UiEeqhym; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-59559ea9cfdso863964a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 03:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720694051; x=1721298851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jR1Web6fOpG4PfW7GgX8Z5K27/fHkBluZOacmcz2i6E=;
        b=UiEeqhymZJOAS+ns+GPbWwkGNun4qelky5fRCXKetk4WmFjVTKs3qNzw+tt8nQlNxi
         LdgZpgd32u/JJdNzraAutwITpTeORDsQsZxAf0KAt01EhqAMitG+MNwmsrXimY0Itz0I
         Q7gXXvnDXUoWwZjqOLARyyuHoor0bORlvAJ4heUkeh5wJAJ09n+z4HF25/63C4OCq+oZ
         f5dmRRrbAiNXKPZ6mhoOvgGp7hbT2oyCoMhmGtY7NdOVf/EN5dxRAnEpdLFsXnVDIHAE
         xm3hnsGKNRNAduBoLI8W/NAlXPp19xYpCi1jn0L08e57tvHFw5pL414LYM4OmPGKCICT
         hgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720694051; x=1721298851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jR1Web6fOpG4PfW7GgX8Z5K27/fHkBluZOacmcz2i6E=;
        b=gndBKb4yZ8vypyzXdjRjSTBK9Mj3HZ8UK6cpF6NOCe9NlzRaShd9y2uarT4f7CVhwS
         i+CAE9k+aANFwXuq7fjiBMZ8T5Erxgbbhm50siwu/JCiXkeDLS+Wv4CrwrnjCafSSWYf
         RZx5pPSnEGiKuS/CJlUIQdzT2OFfhfjkHZyDxs3HAH2JTDUpR+3ywAU1y9l+bQTnmqG8
         vauFhVAwbeUDtvtKoTI3/yj1IImXuosH8ZJEYOTqw0oOJqv7qoFtdjFRX6sdUYMoTAKL
         uqJR9yMm6KaovsJSFvNtFx+COcB+2WA5lgINePcDp7EzcrCfCvLJx8IKdRrU8pok2Zx7
         qjkw==
X-Gm-Message-State: AOJu0Yx/RNcH459sZ2ixgw+HLQPmD0PQ1Z0/jngmDKA9vRw/i684/fxI
	MtKpG2XoVEZhb811jAx2asxBWedCpuUiNZp4X0ZP3nHbjnuqf/Czd7RG8C7VhPY=
X-Google-Smtp-Source: AGHT+IESzBPL1aKKBD56be1MULJXc15BES/x9i+LATELu4LzxdGOdNbDaV9C405YEadlCd/JoNnfNw==
X-Received: by 2002:a05:6402:4316:b0:57c:a77d:a61e with SMTP id 4fb4d7f45d1cf-594bab80111mr6037655a12.7.1720694050942;
        Thu, 11 Jul 2024 03:34:10 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bbe2cf60sm3296192a12.26.2024.07.11.03.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 03:34:10 -0700 (PDT)
From: Petr Tesarik <petr.tesarik@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Petr Tesarik <petr@tesarici.cz>,
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH] sysfs/cpu: Make crash_hotplug attribute world-readable
Date: Thu, 11 Jul 2024 12:34:09 +0200
Message-ID: <20240711103409.319673-1-petr.tesarik@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Petr Tesarik <ptesarik@suse.com>

There is no reason to restrict access to this attribute, as it merely
reports whether crash elfcorehdr is automatically updated on CPU hot
plug/unplug and/or online/offline events.

Note that since commit 79365026f8694 ("crash: add a new kexec flag for
hotplug support"), this maps to the same flag which is world-accessible
through /sys/devices/system/memory/crash_hotplug.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 drivers/base/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index c61ecb0c2ae2..73d69791d0d3 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -308,7 +308,7 @@ static ssize_t crash_hotplug_show(struct device *dev,
 {
 	return sysfs_emit(buf, "%d\n", crash_check_hotplug_support());
 }
-static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
+static DEVICE_ATTR_RO(crash_hotplug);
 #endif
 
 static void cpu_device_release(struct device *dev)
-- 
2.45.2


