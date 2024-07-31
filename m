Return-Path: <linux-kernel+bounces-269309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8EC943159
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55FD9B22DA4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D59B1B29A8;
	Wed, 31 Jul 2024 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="vKCmkXhq"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75501AAE3F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722433850; cv=none; b=lT4Q/zAG7AnEBjSmUJEmg28mpbgV+q8o3YRrH+VeGTxHH0rgAKU4+TQ2u71qJLuYBhTyxX/wGAhw6IcBBNWtopDOMCFIEV3YrOvPwEsdzcxnoNXQtRTz64H5BvWHK8QR68BQJvftA/+Nr/iADGIKEuZB4fytqG6I9FEBEPhCuiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722433850; c=relaxed/simple;
	bh=VrYxixv9GrSlHcpoMIf1d1vd1y+GqlVfp7maNLmLfT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MQ4HHWJqubNI5O/cRTUoOAIuG0tfkkWf3+TrT0MPKR9rAjJjQw7UJQGFREhJ0fpgwxwJMaFTuDSnIqS87IFpsRLUO5lT4xBmESygGB1SEMstUPQQtOd5CRiexs+5sTP6jwhHqRXh2ALSO9nVYiliG5XkfOqFM0oOo616wFfp6MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=vKCmkXhq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so5932955e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1722433847; x=1723038647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y7hnFzPJEcOIabXbhmUEAZBsUSgPXLCHLtzI2HnWZ9g=;
        b=vKCmkXhqcyL30fgTsWyLB0EZQY9l7bkeQ6Ivv+K7AxYyvZYifLPuWXzFGfZ37liwW2
         konY01DVoCpXf97OPmPKdw99zH7GPpb9x8LcAv07wRs1POZhScJ5T3UiYhWFc8mlka2f
         K4KjV9QBYkPmrZosO9MqdwUwhoPWSLUxZX4dleE2IhmgpdYffls92lrztqDpmc7u/ar0
         JqomhloqAgAEYi77dLQhVxKU/ywhPNPnvve4Ymkz3uuu7prpTAk7u2FXo+9VVVCjgQlo
         9P6zWUh2i3QqmCHJHju5VO0PmJyg2nYMEPjEur/cE6QtCi8N4xHvkhKGJozDdQ1vy4Kr
         N3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722433847; x=1723038647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y7hnFzPJEcOIabXbhmUEAZBsUSgPXLCHLtzI2HnWZ9g=;
        b=Bt2tA4Qc8rrKXAIcUv0lSg2ADcIwBnIP5poFhgjeL821ZuDNfkwKrGgliE1SsS0ceS
         cMMl0Kr/UabGpgig5EwMnjQT0q2TNFm2ZXbdqA9oDqLgWhqxCL4ZOdn6tQByPftmDUAP
         ntHxkgAxzXiKB0Jm8HUm4cyIx67Fud6LhEB8YF6jkZiTi4LIHs8AJd29IlYkyjIa5Jto
         TripZn+/MGQPdiv1ZsZqlXyWhRDtR9fjNbQbjbTXgPYnOeN8MAi5h0Gh7HxT8TpuLrC2
         kUMjT0cfmvmJHKzlPrp9Z3y2k5k1P05+CBdnW368S22Pd0pyGN581QzqTl9M3OlngfeS
         zYow==
X-Forwarded-Encrypted: i=1; AJvYcCXwRoG+S8Cre3j/Qf8SEsBzzDvWuES/IpLkXlt9xlaNfmgCghpqmvM8DOHu8Sntwc/j4c1ULcwXr0N2sIblOP1kW2lsfevWSO7ViEOi
X-Gm-Message-State: AOJu0Yx0eer7USzM8ECS7m2dOrgSYJ4BoG9h5PB+KCm2yMD9Q8pt+9/W
	1+yLNIdZtfVVYqUMxjEUW848xapAPmgkUigZXUVRTtPQuB7Qoj/pxu+db96oROQ=
X-Google-Smtp-Source: AGHT+IGtHk37P70L5w/N69KdcbAk942SnKefdRks2f4UU2B9nujaFdFMGK2y3KLXZi4xOhR3p8WzDw==
X-Received: by 2002:a05:600c:3b17:b0:428:9a1:f226 with SMTP id 5b1f17b1804b1-428243e1b22mr38734125e9.1.1722433847072;
        Wed, 31 Jul 2024 06:50:47 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb6403bsm22795905e9.35.2024.07.31.06.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:50:46 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH] HID: hid-steam: Use clamp() macro
Date: Wed, 31 Jul 2024 15:50:04 +0200
Message-ID: <20240731135003.80609-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use clamp() to actually clamp the value to the range [-32767, 32767]
(as mentioned in the function comment) instead of manually mapping
one specific value.

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/hid/hid-steam.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index bf8b633114be..3442985d52ce 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -1341,7 +1341,7 @@ static inline s16 steam_le16(u8 *data)
 {
 	s16 x = (s16) le16_to_cpup((__le16 *)data);
 
-	return x == -32768 ? -32767 : x;
+	return clamp(x, -32767, 32767);
 }
 
 /*
-- 
2.45.2


