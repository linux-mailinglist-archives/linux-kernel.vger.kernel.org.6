Return-Path: <linux-kernel+bounces-213152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2EB906D6F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9EC0B26EC9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4540E1487CC;
	Thu, 13 Jun 2024 11:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmZxx0YY"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045811474D9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279773; cv=none; b=lscttENaQg49vYvtlnq04r5E72T+vjrQy8CbVBCyWL0giMj9uIc8PtUADPQkVsH/h/n+CZKgCLbsIaY7aYkAxu7fwoMKDYaEMNPMUWeMoz+G8jS3IfnYaU1IqFlQ2eCsdLPt01EGXIorW8MHewh4RoNAdgIz4aHpagjGloEd054=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279773; c=relaxed/simple;
	bh=NiO6+hIDAiNcOWcb7sM1hDgUsvxyQm5OcSDZc3QGvVc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aFQVJDnEJEqCRcVZD/bBiMKKFhv0bJHyrTx0+AMjD7BjywZyhGkRUK7HMl0FYyp1o4OttmRGdV8rIA1v4wleet7llA+eZMbcJYBKIAY1g8LeP2EUNSv9RwLhJgjtbKt8ORls/vxemZbDZ0vWZl3Ij8TE20Q6rhHaN5JIIBfpLw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmZxx0YY; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63947so987781a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718279770; x=1718884570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hRQKBzzX7KQtvcDLJ9HYODa1y7ZaQxZ6+SuMcgINxSw=;
        b=JmZxx0YY2VDuMDq6Yh0up8PHb+zTQ7rBOLx7fM1CJUGsqClXUVYWDAAYyAnN9jBeET
         MeNW/BKhF/hahwZ7UB6xeoT8epDbSHHA8o+5WUVFwkL6h9EyIBxBwZfX+PwRUEkGgq7h
         j+yur/t3to5WZB26BSNR/XqbrqM7ksBeK2bcz6wjRerp/Ohxxcc09TyHbq6eiYxXC6HK
         D+9SqI3/j6tFqKdT5UMJHhjc5JwWHAW5E9+N/EOxX2jNbGm+4ergVKZMhlmlsZyDUiME
         AAGWKgM1hUxD23srOxrlHrquHTDDeHVhOuS3LHqJ2rbhrSx5+2KSb8JVyqsBWMpGhQF0
         7IpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279770; x=1718884570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hRQKBzzX7KQtvcDLJ9HYODa1y7ZaQxZ6+SuMcgINxSw=;
        b=DDhoIFWcYVvFIrit0Eclkn5Fx59ubS2fV0S8pkDS6rD6uNv6i4JInPtCzhIcIRMXM4
         BXCvaLY5D6/fXaCEKfCZ6X8ST3bC5kTyiAG13bEIZJHm2sOlkeK6YN6GiO3tudncJqIF
         Rhm5kU5dY5tEtPQzcSJBgvh/rBNijH1RWFCZJlnjLIkNURoUJWVfrKWnQHRNyjqPWFw4
         h9o8bj9oBdRCL89d0S5PW5lvkTwH0SVzSn+J88M8rPcv1hyJoUBtZQESvUNjHR9gOG5j
         MlqTW6uwyPimUBs1ANgtJxi0wY0IHh+bGqUM1+zRA7/jJziSVuDPUyhxi8HSYnGUNGHR
         mmPA==
X-Gm-Message-State: AOJu0YywlHUxXy56r/rsR1vFNlDjHyuE2BSCoFZndyVN6CcxwzXbolyF
	zMT5YHaZSSmtN7306f5e2ONLW9RdmoEUCkKFrfQxsymQbrPqrl6M0v7JPg==
X-Google-Smtp-Source: AGHT+IHiZMPBVHQ6Txn/3W9fUqlmAkZzPDqTa4b362GUuoT2QN8YB+5GTfylVvLZ2BJ02ZTjy2JP+A==
X-Received: by 2002:a50:a45a:0:b0:57c:6e0a:e8d0 with SMTP id 4fb4d7f45d1cf-57ca9756beamr3241992a12.1.1718279769970;
        Thu, 13 Jun 2024 04:56:09 -0700 (PDT)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cbc2d4b0dsm50582a12.33.2024.06.13.04.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:56:09 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: linux-kernel@vger.kernel.org
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>
Subject: [PATCH v1 1/1] MAINTAINERS: Update AD7192 driver maintainer
Date: Thu, 13 Jun 2024 14:55:09 +0300
Message-Id: <20240613115509.295818-1-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alexandru Tachici has not been updating the AD7192 driver and the email
address included is not reachable. I was assigned to work on the driver
instead.

Remove Alexandru Tachici and add myself as maintainer of AD7192 driver.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bff979a507ba..5e5b2856c67d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1218,7 +1218,7 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r*
 F:	drivers/iio/adc/ad7091r*
 
 ANALOG DEVICES INC AD7192 DRIVER
-M:	Alexandru Tachici <alexandru.tachici@analog.com>
+M:	Alisa-Dariana Roman <alisa.roman@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
-- 
2.34.1


