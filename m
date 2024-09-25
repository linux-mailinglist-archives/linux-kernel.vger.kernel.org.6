Return-Path: <linux-kernel+bounces-339072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB11E985FFE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51FD71F26288
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A191925BD;
	Wed, 25 Sep 2024 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1q/HptG"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C60A18308D;
	Wed, 25 Sep 2024 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266828; cv=none; b=OOqOkG0sJCfl9On1FnURa6On6Tb76UNR6VBkg3gWLYTiXeisJ/eIzMjUzmCw9uJYwKF0Jq08wpKuGla7IvYX8B3Na94IqIiCTyZQLJDDMaZwHB5VND/F1PDi93Y2bzC04vvv6SQjyDNJfWurlgGKOBK3b4SvVxouONt/zARAK6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266828; c=relaxed/simple;
	bh=BVIKs5p8wPKsIFFHc3VjmL08yvB077qRlK8Y/PX8C8o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gKpRweAKxLzk7i+ZCNLGtWDQcebQHCFgF3sPi7u4qs/4b2Ot1fR3SVWkaEwm07/0tkwEdVC/zZS/W6Yx455VGXH3zRiDvQ2OIpnYcBb01+KShGaW3JmGCdkeImhFPZjoBiu2kwVxivbnud75U5ENZ0C1s60XQvEbmjt1HaqHAxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1q/HptG; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2054fea6f26so3751515ad.3;
        Wed, 25 Sep 2024 05:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727266825; x=1727871625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i7xNM0O+xbhrrlGWqxwznqgYdPW8etKAhMjyDgYMNtg=;
        b=H1q/HptG75zfbCM1n9ZvBxOFjVVH6YAYv/eNJh2nZHNXdaSqbPThjzH6FT7Fou7tsY
         A/N/oVhjpvKP9OGOq/YPCu5CYdduO7v+X2evNu2wKwVunLMgH1OOluY02rmDm6UjaDlL
         oH8+DD3SsQuMktc+3ZIDvgZolhOUKDyNpxSfQBlwKURqHHmhKPNpOqsNg7ulMpljNI6u
         SsjgJZH/odo16Wl+L+I85Mgs2o3pAbNechrP3NeZ45EEzYpivu9GIlfPwUC2KBnPnYVh
         UxyVKfZtijYJJLwlfbl2l9dbWnZam0AMVds76XKJtHHrJD/fxMc+fKj8+bcR+7XyAq3C
         Z/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727266825; x=1727871625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i7xNM0O+xbhrrlGWqxwznqgYdPW8etKAhMjyDgYMNtg=;
        b=a7BWmrQftXlJBKPZgMK7vHR+KTBLp3Cb3FVGsxs32GCy38/wcFQ6U6V4VSZ16AggEN
         suqhdOybHVAc8pRfhatHy/tpHeFumSc5WZW5yPW97in6coU7gwb7xjIfrsZCIUU2hMPg
         yrKwC12C7FFvY4bi7rPvMsyuW/FRRuIoXUyAQgEAhbt9S44kBBquNGb5IskfMH4Dd3N3
         uSnRfyGL9HSOyO/BOmPbEJEXe/UluYW0WlffAJRnF1cp05sLSh1hcs25e4kYTXvaPvQL
         TvVOxlr2KjUwcoBMvuDd9TO43avRU1127yV1PAo2Yb2TnbqwaJxSu4NomskS9FQITzDs
         89Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXbPjK6YGIK+UeOnDYik2eR6My+dFYRv0JI4GPdj+DA7jcH4ogVGVjxgDnrWUdVwgUZnKeVqCZuKgScwjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUlpc0I9Bey6Ea+BLwfSYceLiyX2J2sZXG3JASykP/4y1G0C40
	TmsgVu/+L27gmU6B1tUwB/TqCaci345hGcAuyvVQpj+IGMD2VovT
X-Google-Smtp-Source: AGHT+IHGvAKGfvAdQGqJQCw1JRRow6WqXo0NzHxjsEuprOybsP/nV/XT83aPeA91DRD3TOjD7+9pYA==
X-Received: by 2002:a17:902:d2cb:b0:205:8820:fe1c with SMTP id d9443c01a7336-20afc4ab338mr15208645ad.5.1727266825298;
        Wed, 25 Sep 2024 05:20:25 -0700 (PDT)
Received: from dev.. ([2402:e280:214c:86:1869:2941:7f8f:86c7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b0df108ebsm5084265ad.266.2024.09.25.05.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 05:20:25 -0700 (PDT)
From: R Sundar <prosunofficial@gmail.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	RD Babiera <rdbabiera@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Kyle Tso <kyletso@google.com>,
	Xu Yang <xu.yang_2@nxp.com>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	frank.wang@rock-chips.com,
	R Sundar <prosunofficial@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH linux-next] usb: typec: tcpm: use max() to get higher value
Date: Wed, 25 Sep 2024 17:50:14 +0530
Message-Id: <20240925122014.552221-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use max() for better readability and to fix cocci warnings.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202409231009.2efXAh9b-lkp@intel.com/
Signed-off-by: R Sundar <prosunofficial@gmail.com>
---

Reported in linux repo.
tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

cocci warnings: (new ones prefixed by >>)
>> drivers/usb/typec/tcpm/tcpm.c:6356:20-21: WARNING opportunity for max()

vim +6356 drivers/usb/typec/tcpm/tcpm.c

compile-tested only.

 drivers/usb/typec/tcpm/tcpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index fc619478200f..aac4de1d53a8 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -7367,7 +7367,7 @@ static int tcpm_psy_get_input_power_limit(struct tcpm_port *port,
 			src_mv = pdo_fixed_voltage(pdo);
 			src_ma = pdo_max_current(pdo);
 			tmp = src_mv * src_ma;
-			max_src_uw = tmp > max_src_uw ? tmp : max_src_uw;
+			max_src_uw = max(tmp, max_src_uw);
 		}
 	}
 
-- 
2.34.1


