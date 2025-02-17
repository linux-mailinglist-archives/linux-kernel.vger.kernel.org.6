Return-Path: <linux-kernel+bounces-517265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB16A37E72
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A803A9885
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609AB2135B8;
	Mon, 17 Feb 2025 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PzC+Uzm9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CCE213249
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739784544; cv=none; b=hiiWQW44d4+xb4GVNJ2IIX9Ecgm4DzaGK4/C8o5vHW/hR/bUnV5RGzaKpfOXhCXwAe3g9WLOvva+jQHAsKqFNAkDt9yw6rSZ4Ln2maxyL3TRh6fOVb+3pFFBUQdelMgC8mYl8lcxZ0Gomh65JNerLmqPXN34S+4vsxjQsmQoVnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739784544; c=relaxed/simple;
	bh=DvnzqR3N+Yt1hJiN/UFuDlnF+d8ai01tb91e7tKjUK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZZUdjQvd8Fhv5OJDx2b0Mz9uEyIfx2ggMYgrZcVRPb/sgcULwagcmisWTq4wGVXT4U5OVl1mzY2Jro1ICKr8kd9+6jTc2ko4klGsIphkZU4dVltpwBC7vWlLyVziy5Kv5UvKyYpw1nQYBgt3bVJMqeVOf/+JndG9IHweBs41ePE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PzC+Uzm9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739784542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qeVUNDEioZ1zA8ELxm1OFFvu01528gdmuR0pSmN5LWs=;
	b=PzC+Uzm9uyu0dmVSOdjIc/6RRb1lijSpImggs8y+T3Z3d28glCki8IFyam4iYwORsMHmXK
	3oHMFg2079NeWCUuAsmmZNZPn/wM23K/c/s4sCWbSe8VoOvcFWK3KqXi5XblsgRB8lChvW
	ZLRCRNUz4B6aHntF5jbBT+L1WdnLXGM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-qtEzi95nOvSWCSBaJ5R-Ig-1; Mon, 17 Feb 2025 04:28:58 -0500
X-MC-Unique: qtEzi95nOvSWCSBaJ5R-Ig-1
X-Mimecast-MFC-AGG-ID: qtEzi95nOvSWCSBaJ5R-Ig_1739784538
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f36f03312so613309f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 01:28:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739784537; x=1740389337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qeVUNDEioZ1zA8ELxm1OFFvu01528gdmuR0pSmN5LWs=;
        b=JvC7syCUvrM4edDbCHY8r3tdsQyakZiR7KTaVOoWb4fp/vw9YTOEVOAoqqmhT3/gQc
         TCcvWFLOpBg1410gKFkmAJA70qz3s1cBD80TsJA03J8yghCWTLG+hHOKNIP6GOiSv20L
         touECPA5XhhhQAE/4qSxvCTppguxYoUABvCtZApQelBhjajVu+2Zx9nQ1VleZhNvgnGW
         L8DSqOV0ztStADw/+rK4X9syorfenxotetA7l5cFi2t1LT53tqprrYoWhdd5izPxsfYH
         Hd+85urBSSTjhmuSaPOG7/R4lSorEm8+duosXJ23qRoRkqbzBiQk74lQ17mgLCLix3QB
         5tBw==
X-Forwarded-Encrypted: i=1; AJvYcCVV9mTFpNIfHWiyeIxDsMXDWhWzPHPE0TtEElSrXh7YC6+GybpQvlP27jGONSeMBX2XkejcbA8dG6Sgwg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh6ihjfUpUJtPKYWgVMLNPnemIkLNI18a0Q9caO7s6DZUQqSLi
	Yb4zBoPnJ47qt7nTo7aHP2xXulZvSuTTcJs4G9ytttCApM6YLbTNqYSm9OU9nVjwdCr/75YAmhI
	5FAItJhKc5E9Gb9iAHjJwP7CY1u5C+oLkYD74/UjxNbDG2cfrmgIoKzZC3zu0wQ==
X-Gm-Gg: ASbGncugms4xY1BQoQWpTXKjKab9xpE93yfTVBAEN7QVAzud8BB0Escf5OQ8FLC41sn
	GnuWTh7qs2cbY+5n++EDhpsqPlN1NhpGI6SI7xOAOPQJn6/mEREkj4QZmp/Ozil4Wv53CCgStD5
	yJhlRslmsvh8Wpo2Rq959N7B6LdOaiKQbepxKlX/4zfmtx862vFTpap59Gcs50Zt9UaPRJJHU9W
	QxJxvAfbbjxWyyen8ZgR7ZsmxRokYAQGUXZiRXHFpMSwDtnJz6hzNlNi8drjFiDov4iiyqT054Z
	hA0bjHX/TzIqM2HhW9PBztw7d/WO1XGGboeJVRzo/+UxOC8l5Dp7
X-Received: by 2002:adf:fa08:0:b0:38d:df70:23e7 with SMTP id ffacd0b85a97d-38f33f34cecmr6714670f8f.31.1739784537697;
        Mon, 17 Feb 2025 01:28:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrmijOoGMXonbnwZyd9fLGlM4O8FZOdIeSBCVRiU0u4DCtv0gGZP/fVwdyLL1x9WLMBEhxAg==
X-Received: by 2002:adf:fa08:0:b0:38d:df70:23e7 with SMTP id ffacd0b85a97d-38f33f34cecmr6714640f8f.31.1739784537284;
        Mon, 17 Feb 2025 01:28:57 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7998sm11554234f8f.82.2025.02.17.01.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 01:28:56 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Nuno Sa <nuno.sa@analog.com>,
	linux-spi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust the file entry in SPI OFFLOAD
Date: Mon, 17 Feb 2025 10:28:51 +0100
Message-ID: <20250217092851.17619-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 8e02d1886988 ("spi: add basic support for SPI offloading") adds a
new MAINTAINERS section referring to the non-existent file
include/linux/spi/spi-offload.h rather than referring to the files added
with this commit in the directory include/linux/spi/offload/.

Adjust the file reference to the intended directory.

Fixes: 8e02d1886988 ("spi: add basic support for SPI offloading")

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a54d8510ea6e..53cf3cbf33c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22402,7 +22402,7 @@ SPI OFFLOAD
 R:	David Lechner <dlechner@baylibre.com>
 F:	drivers/spi/spi-offload-trigger-pwm.c
 F:	drivers/spi/spi-offload.c
-F:	include/linux/spi/spi-offload.h
+F:	include/linux/spi/offload/
 K:	spi_offload
 
 SPI SUBSYSTEM
-- 
2.48.1


