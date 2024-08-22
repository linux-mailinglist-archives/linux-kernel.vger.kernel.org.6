Return-Path: <linux-kernel+bounces-296319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55AA95A931
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90FAE283FE1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6E46FB9;
	Thu, 22 Aug 2024 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuZWYdLk"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65B53C3C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724287565; cv=none; b=ZqoWTPJ+QHUZBP7t1w4ABFGMbKPyg7wl6wC2Zeour3+OiActUKOyE7mj4K5muQpg3vjFpyACH8xlE44uipLMJnpxUgerp++zZsuSdYY/a9nokE+sxBInfzjP0hxwYO01H/NxsPCdywP3pzFtDxAi2BnaCxnQzfYt4gaIpWn5VnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724287565; c=relaxed/simple;
	bh=xbhdrzXBXQGFHkBi7JVQQnh/qFFqzJW4jZK4RQf97gQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nvvymVCTf8xxBPWiY7GbTIr9pJk/w0UgWbvbw00jATcP7UGrUbYjG9CdI2wCEMFj0myl3EW2TMKE8xUUQi/rLP/6CZhXg6e7j5MYCA/aq1Zf2LJRBlE4ZcM5sMPT3KlsnJ1hKmo/mNBY31frCreSIF8r/8LMdIoP+vEbIv+YB0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuZWYdLk; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70b3b62025dso204895a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 17:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724287563; x=1724892363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iBNlowdOWSl10OVciaBXJoWLTKHB1MfSEqNmoSmAPy0=;
        b=QuZWYdLkZ7tEE9bHE9/wKLb3O5tgudYmyumIKdBhdSlNivpv68qCRxsm1Qvzxmzqbt
         F8gxNPuXxAnvglEbGIUra0GDaeHB6fpBhRX7eNXCFIBEF573s8nUIaRSlXIvysZgMd5+
         XWCzhEFSGb1A+zosZvBK2EBd+yGrYInj4+0y1ry3dyQrgBEBmCJV4IPeYaAVS7ql81e2
         HpIB2lyktAyiU5gVofFo8C1NWYAFDVcipj8C05ETSoco6I6qHZ6D9vSd6kHHj3DJfk7y
         98OXFd1Xrlss5RLpJLIb4jmv91gUVQFcLrm/pVvzh8AyFJ+R5C4fW386kUf4q6PC3h9T
         6ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724287563; x=1724892363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iBNlowdOWSl10OVciaBXJoWLTKHB1MfSEqNmoSmAPy0=;
        b=SkLqkNtj6/HN7On8VU2GoqGrP+GgqoJV6TmJqhSitXD6jVVyjXIY52WnCHpLhXb+xW
         L3DBtIQTbdyaYVEx9RQoMDnZtfpoUUW7ns6l3fYO/sv/mvT/GNajs1AttULU/Bs2lP8v
         G6bssxO0xhpxMrEeDT2KGUgYXNyFRecX+ugoFb0WsZJVPNiXckOe6rYzL0GH53l9xKWU
         Gu8ESoGQJGYLElmTj3b5seY3wb1qre+RXGi0P7XlKgQMVJ3EBE11y7c00m6xFULG4RRb
         +8gyxquBACbD9k+NnQxb2OqIhwlmVlOpd4nS3IUdw+q0IHUVAUqBVuSzDAegemr/MWq5
         onmg==
X-Forwarded-Encrypted: i=1; AJvYcCXJvr7vKzW1jGKFSNSKmeXjoEE6L4qtZ15pgTVowAChXUfldWq8+HMYHzuOGQXJKVAdRL5GRAE9uAXGX5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAwhZYxwQiFcpGduj09XqBB/z7RTH9PQEdszqpPYCzDqoP/CCe
	l+LKyqlGn/bsSPomrOISQnha8RdqG9tvOYrQ/dpf1x192fdmYj01
X-Google-Smtp-Source: AGHT+IH/bjf1naOOqPi5C/0NuQzz4PHsm3FWeNxQhSdv0/HWm++aXaJE5hnZNAX492lNQZ6AiiZ1TA==
X-Received: by 2002:a05:6870:80cb:b0:261:211:9d0d with SMTP id 586e51a60fabf-2738be524bfmr4580052fac.40.1724287562771;
        Wed, 21 Aug 2024 17:46:02 -0700 (PDT)
Received: from pop-os.. ([2804:14c:30:24b4:ab5f:4663:351d:b821])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342731acsm252928b3a.88.2024.08.21.17.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 17:46:02 -0700 (PDT)
From: =?UTF-8?q?T=C3=BAlio=20Fernandes?= <tuliomf09@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] staging: rtl8192e: Fix parenthesis alignment
Date: Wed, 21 Aug 2024 21:45:58 -0300
Message-Id: <20240822004558.14638-1-tuliomf09@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix parenthesis alignment in rtl92e_set_rf_state in order to rid
the following warning:

CHECK: Alignment should match open parenthesis

Signed-off-by: Túlio Fernandes <tuliomf09@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 9eeae01dc98d..ad21263e725f 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -173,7 +173,7 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 				else
 					priv->blinked_ingpio = false;
 				rtllib_mgnt_disconnect(priv->rtllib,
-						      WLAN_REASON_DISASSOC_STA_HAS_LEFT);
+						       WLAN_REASON_DISASSOC_STA_HAS_LEFT);
 			}
 		}
 		if ((change_source == RF_CHANGE_BY_HW) && !priv->hw_radio_off)
-- 
2.34.1


