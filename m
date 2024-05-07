Return-Path: <linux-kernel+bounces-171555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A91E8BE5AD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4B3286B20
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5483117106A;
	Tue,  7 May 2024 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAaDRJn8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C8116F293
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091299; cv=none; b=eLhmpy1dguDUPabRzL86dlEWZcXHrd76ybq5gCmNcV0uWkU2Fu9jORiGulBCYDV4RPKhQSsPAaHzqBqJC9zeg15qAUDyIC0MuEFF3iwA5obwHmqpmGOWhZmFgA+68ciLf97YJyUWyH+swz/1PkfskjUCvOMfsYLLi0/7wWOS/pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091299; c=relaxed/simple;
	bh=tYFhuNKK572ei44KClvdIFHmT5dQxptc6wlidmEeIbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QfbjfyoKKpHMthsl7EtBB4zhm2nERLhDiGih52v87NbwSfL5hqiJpv//5xYxa97TIc8ztXu4LWz3bAHmC03DHDU9w0EP4vcaXx3Tbeg4e1Wx6lHPJ2TV/vUXS9mrri6UOFPvSHtZRURlgiaXDrpg0IxgEQjTEJ28/lRTJN1uf/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GAaDRJn8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715091297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X1TemjxCew8gfx5TJGpneLG70M3weE+hrm8/BhqnHVY=;
	b=GAaDRJn8ulP9j+LywlpsZogPDbcgpO9XwGgwBIgYwBF6eQSoO+b343MtmebtF18aOIoB67
	1aopzb7sXGRe+PiP0b+yvyqDR4wBcMQGTyA8xfY02UXioFiApBAA1rXtb8PZUaanmkHVEP
	htlYxBUVtu3I1c2y9YI3cdk/pYhE29s=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-NkmbHfwTNbqn1l0yvSbSeQ-1; Tue, 07 May 2024 10:14:55 -0400
X-MC-Unique: NkmbHfwTNbqn1l0yvSbSeQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5202218b4d3so3122810e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 07:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715091294; x=1715696094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X1TemjxCew8gfx5TJGpneLG70M3weE+hrm8/BhqnHVY=;
        b=IaiWuKj0HFMLHOhq0JeH/CRGD/hZflb2zR6Yk7N1lu+7DHOkR0nAzT1QO93Agzdabp
         3IyXd/86CZxLxGWMwEkntPvvyqORVJ9VyzGipV3MziIV5ORAPDvZWIDmIqIYL3qNG/7o
         qVmACVB5cCmG62MujsRzGa8POkuCbJhn5u1f7QC13NnVCLFWcuaRHx7UOE6/UwcIzB3L
         nRWE45rTkAMNOfgCoF/mbcbgvDhIGqq4S6cJzRAAGOLZvVUSBQ6JcaS8W1FdBkZiNu8z
         icc6o0P7xGY0r59tgPGjzDVj9j/ynjTh+1WwlROIWVa7oPs3LYZUHNV6Fqu0iZqRPi/P
         mI1w==
X-Forwarded-Encrypted: i=1; AJvYcCVMbQOg6xVVdOgmbx2J2re3nRUGJv1q93TubvcC3oEBkDnFYLbf7jjYvAJpcLtghTBA50ZGa6AxRqyJ2E9213ULE8WJLzsBpHN+4dVH
X-Gm-Message-State: AOJu0YxsuokupsIcv/gTCxGPHB5FBX5qwrBNfJj/NET5xKp7mimec1tM
	oQ7BcwCCTKJDjPnndLhA6PgHoIcMbXhwmHf7669Muhc/o5vs0EhfYISYt3o62qpF6+FDt40T02A
	WQwr4NwYslWT3OirgveuC/R2qTGIpLChdFaPliPwP6iy7Ex+AHmZgmF586q8rIQ==
X-Received: by 2002:a05:6512:78d:b0:51d:1c56:b0f1 with SMTP id x13-20020a056512078d00b0051d1c56b0f1mr9151812lfr.17.1715091293924;
        Tue, 07 May 2024 07:14:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL6gtJQR2L/AKZnQJ9Vjdq0OBoXAmgXMJxKgRmEQ2ocaAFqN0lJ69a1Qg3oAiWGUjW/dsk3Q==
X-Received: by 2002:a05:6512:78d:b0:51d:1c56:b0f1 with SMTP id x13-20020a056512078d00b0051d1c56b0f1mr9151789lfr.17.1715091293449;
        Tue, 07 May 2024 07:14:53 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id s26-20020a170906169a00b00a59a09e34adsm4681491ejd.195.2024.05.07.07.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:14:52 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: repair file entry in AIROHA SPI SNFI DRIVER
Date: Tue,  7 May 2024 16:14:49 +0200
Message-ID: <20240507141449.177538-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit a403997c1201 ("spi: airoha: add SPI-NAND Flash controller driver")
adds a new section AIROHA SPI SNFI DRIVER referring to the file
spi-airoha.c. The commit however adds the file spi-airoha-snfi.c.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair this file entry in the AIROHA SPI SNFI DRIVER section.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ca79616a4836..2fe4506f9fe8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -689,7 +689,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-spi@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
-F:	drivers/spi/spi-airoha.c
+F:	drivers/spi/spi-airoha-snfi.c
 
 AIRSPY MEDIA DRIVER
 L:	linux-media@vger.kernel.org
-- 
2.44.0


