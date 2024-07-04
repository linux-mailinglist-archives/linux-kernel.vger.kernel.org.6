Return-Path: <linux-kernel+bounces-240437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5A6926D97
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C62D1C21343
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 02:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B561758B;
	Thu,  4 Jul 2024 02:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sq4iF6pf"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E40107A0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 02:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720061364; cv=none; b=fbay/UIdcSUIjZy7NBakupf9rQvcKLIWVEQpKZsMTIPomdGNODnTBuD2zfhweVgW0LnZI894xP4HxbnHTzulKFh+J8DHKdowrD5zS4khH2Zu5OJsT/+AjC/K2WapdIbLGKqPpmbxj/lo4nHtnFOzdcrVbYPPVtb51/o0WLiwoCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720061364; c=relaxed/simple;
	bh=+2RP6jDMa7l1qe/0BAmAJiDQOPx3iHPAWOBucjJnbW4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UqVJftl09OvtaJuyMqgOrVm2MWuyyciW6fvZPJmMhdPZ3/UEXruAwpcf9d60TALjtcCRmGFz7tnbBOv8675St/549QNsznPyNciuOR0cUYItijJgqTn+R0/RGIBgEneCOS4o1kRST68nfgsS1367Io7vinLQd55jxvLhRbIrlO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sq4iF6pf; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c980b55741so150771a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 19:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720061362; x=1720666162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4VfUskD/qPJn4//0G8swipdcwsHQZ9A5zlheJWqzB8s=;
        b=Sq4iF6pf1WBqc+9nM055fqw96cUxCwgkfm8/biL2JJrAXewi3Ka5JwvxRXEujFv8PE
         Z2XQVqnqLQBj0oizi405eJ0JZiQMIqUrRzgrUajDXDkmoV8mBw7lIkoRHBvP9B7ik2Ck
         wEIzTpDWjnqVnljvlXmi/bbENHMlxqSiivrr1UwTIX8Jd3PsYQiRhHQO6pJQSnAQhTLz
         CkNcxEPD8EPf8QjFy9ClgNMDsZFWP7syWYbgTrFOKz8eBKPtUp9aGDKnHyHv/oi/wh69
         hBjVj23c8RaJC3p22lyXC97+y6I8qnATYHqdu4PIXHQ7bJnPCepNlKWNxPCEFSmQw+se
         UE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720061362; x=1720666162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4VfUskD/qPJn4//0G8swipdcwsHQZ9A5zlheJWqzB8s=;
        b=YQ3vAT3b0TM+ekcwPFZ1wdNmdMlbSIqtPP2DOCtarvZ6DUyXp8WhuAZgGCUT3J6drU
         SzYqCOkD8g1msd6Od7MTMMlVHQWSZkyTLMHoPgl2Vy7vNcWTwAcCbybeae0ep78QegzV
         OWRQUA1jqE/2uesMf6W1Y3WiP1r5rVYrZcj/7RO0wgGQYTV9DVsndLpaEAVkqzwpcJuO
         2a34ADlq75yQGXpm1nFxXOJ2JN/R2l0lxNdN1OIjMyPjiUxSXCoFh8+V6hTBeZF+89Zz
         QSBNToMzifBGTh/ciy58GI524EJd8yZJ3zFqHLdevIQNuyG/fAI1x1XuXU8SfXxohuGy
         Jg+w==
X-Forwarded-Encrypted: i=1; AJvYcCVOS7mkirFT38wIcyW/myvzV961JbskQBCGM0x72qL3wFu1Z0RTa96w29REnfMUNM2gvFexv9MvrSO6JzVq23VDziawJHRATBEd2IUT
X-Gm-Message-State: AOJu0Ywk6Xa6+Gxx2gqxxuaCsDxijfLGggxFkmrnm87T61rd+JBRU794
	jbYYCKNzdaZc0MHq0vnb0II7Dz0NGMrJCr70A2kn9rj5PUOfNsvN
X-Google-Smtp-Source: AGHT+IGQsTpOx1QzcrInHksPymhOLpAkHCMutbM5pVz38YzCLXxPyaevyAqE9Q1A7hfklMqp+l8zNA==
X-Received: by 2002:a17:90b:193:b0:2c7:dfb6:dbe6 with SMTP id 98e67ed59e1d1-2c99c822e05mr199139a91.45.1720061361952;
        Wed, 03 Jul 2024 19:49:21 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fad067031fsm102255835ad.259.2024.07.03.19.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 19:49:21 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 5DFDC80152;
	Thu,  4 Jul 2024 10:51:27 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com
Cc: richard@nod.at,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v2 0/2] Add support for Macronix flash
Date: Thu,  4 Jul 2024 10:48:37 +0800
Message-Id: <20240704024839.241101-1-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

Adding Device ID 2 for Macronix serial NAND flash.
Adding support for flash with the postfix Z4I8.

Cheng Ming Lin (2):
  mtd: spinand: macronix: Add support for reading Device ID 2
  mtd: spinand: macronix: Add support for serial NAND flash

 drivers/mtd/nand/spi/macronix.c | 64 ++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 13 deletions(-)

-- 
2.25.1


