Return-Path: <linux-kernel+bounces-303998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3763C96183F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95E67B21203
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D61D1D31A8;
	Tue, 27 Aug 2024 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SV3AvS/h"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516B31D175D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724788586; cv=none; b=SqY14EVCsE5UelO7n6OeIW3qwhaS/5zpQFhJ1vg8pC9Ql1jzeT9UReDl6+smWeBkOWqq2U+oUecS4uXiTJ8qh4twhYn8td6qrPN82BOoMNGXNngCRxQDzneyZCR0nsEQfhcgZFzKA/eIeqSAr/L2JrHeZ/J6Z9HOqj3dscu6mQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724788586; c=relaxed/simple;
	bh=TlHnc6LhVP9H/5j0kBJ84CxpzBsrXkKjWnAYwNr8I4Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qbXxWF8w17nwxJY7Jtkbk0pYBQQ9yDpWYbw7VNL6WPWQ/YzAeQ4VXSsbd55V1l56SGn8/ZAzTV6jcXAtMXGjoK0PH+zfigtcKhu4ky3nqLDIpFuZ1+bc/t426xnFirs+KQ/bCBgDazty7ZUVXBSNSoxPtSzlb4/MRH+JyQk0eQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SV3AvS/h; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-714302e7285so4831474b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724788584; x=1725393384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c4m8pZ58RVuetSQCef8u+byuvMfFoIktNE8VEW444zY=;
        b=SV3AvS/h7OtZBiAqd4QlHmiGMtu4ILNvqKqYYE0Pizn54GkEO4gDsICllDl8uAEnrZ
         /pxugB4Yg5uwKhKb5qmvNsMsvAJCpwyxTArn4n98kznmCx+WEg8sotE/Cs2YL4GWp11U
         ODA7DaAn0hzoMw5/BkxzAYtujBO4kxxqMKcOvotUf3+ihsMKIfaGecvhL3Y6kQkXUgZv
         faRDLka2PvzXzhqaNUR2U/ERTeyDknwh0pe+v12k1wOGdQ63jfc2Tch8XVWp45uH3fGf
         NV9EDsqS6Fd+PQa6Q39Ql8yLxDMfy0H35hyWPrv4fHvBkT0fH2YreAiy0ObkQkVnLWtn
         +UXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724788585; x=1725393385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4m8pZ58RVuetSQCef8u+byuvMfFoIktNE8VEW444zY=;
        b=h58cBHTvJI+hQZJbH5WwYFYRjebhJzkVVYgK4pNGcnO7zUEnhaLmJx0KhbS8JiFunZ
         23sZrYnynpKaeLnJdFvYprGtoVcOPVnUS/yoGMnKrd9F5CbgjFx9mXjEQaX5Sv2FwLPf
         Y1nXZDll+EcIQKfW/U+8SyZSmzK7scBaqlrzWObFddBbZ8+9JqlPTkdbXbL7qllfaLEx
         YUdcaZVe/gzekwrbHZiyLortESRI2EuPTkaJE8G9Oc2xXbzK/jFET48lG0QzBIgtkfFO
         Hdh2YfQNkldBkoZkIp2XjBZXLQFzB0c+xZ/vYkDasN5LuFifPiaxJHTuhvXOnfZ8Pb3V
         DSww==
X-Forwarded-Encrypted: i=1; AJvYcCURcIvK/V7AVBGIZsiqjB+kseutnHFi4VLYPlBg62L+s7CmNHFCCzj/ObTKvaypb+BcWM8Dg95NssEmwZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkHl27aXJTJ43SQKfQ4ovMgliBvWtRqra1I8dikMm15cR6TNSM
	NncZ1+b0lKRJMImmsUaMhZ8iI9lVyiWdLGtP2OpJV+IQfSWDqmmr
X-Google-Smtp-Source: AGHT+IHb8TtMldCvGdpVG6MwxW1eBlqOcmE3Z+fdcc3o7bBNDkjK6qr9rgwQvEieUw/2M8om6csfCg==
X-Received: by 2002:a05:6a00:1415:b0:710:4d3a:2d92 with SMTP id d2e1a72fcca58-7144573e05cmr17362654b3a.4.1724788584507;
        Tue, 27 Aug 2024 12:56:24 -0700 (PDT)
Received: from localhost.localdomain ([2804:16d8:ec10:100:8c4e:d5a2:795b:a46e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143422ebc6sm8965745b3a.38.2024.08.27.12.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 12:56:24 -0700 (PDT)
From: Nilo Alexandre <n1lux.comp@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH v3] staging: rtl8192e: Fix parenthesis alignment in r8192E_dev.c 325
Date: Tue, 27 Aug 2024 16:56:19 -0300
Message-ID: <20240827195619.34712-1-n1lux.comp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Align parenthesis to improve readability.

CHECK: Alignment should match open parenthesis

Signed-off-by: Nilo Alexandre <n1lux.comp@gmail.com>
---
v3: Fix typo in commit message.
v2: Using tabs instead of spaces.
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index b767dc00100aa..2d17d8e8898e7 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -322,7 +322,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		if (priv->epromtype == EEPROM_93C46) {
 			if (!priv->autoload_fail_flag) {
 				usValue = rtl92e_eeprom_read(dev,
-					                     EEPROM_TxPwDiff_CrystalCap >> 1);
+								EEPROM_TxPwDiff_CrystalCap >> 1);
 				priv->eeprom_ant_pwr_diff = usValue & 0x0fff;
 				priv->eeprom_crystal_cap = (usValue & 0xf000)
 							 >> 12;
-- 
2.46.0


