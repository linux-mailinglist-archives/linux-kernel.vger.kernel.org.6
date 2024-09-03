Return-Path: <linux-kernel+bounces-312652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B74F969960
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EFC0B27B92
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3361B1AD256;
	Tue,  3 Sep 2024 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Au6xXDpf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482E91A0BD5
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725356399; cv=none; b=PKUmqAjQLIH/qazL82J/OOP55cyc/mSpwaFrijgvb4Zm/nnn+9Vzz51wdCm5DcsHWdt6UpKacFl4xUahR7CULNcoEA9ZBUEG4R2qRUGrYNHPkvLothcpeoqYa5X2b69xh2/Y1MYaQbsEEw0JQHo5eCvaTHA6dssGEG+WGmaG7lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725356399; c=relaxed/simple;
	bh=YmM/1Eehb6jsD664Sl2Rr0CIjdzwq6jIGR9orWtFBBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FZtwnZjJ6My+72n2QgdxcVRJLTBq6Qd5MtF6UNYQa1Cws7sT60T4WP0r7PQmWp6vJxkvwKTqYVigoMmD8PNFkITEI1++mIBHvMRAzr4u+t1LtmT1KA7qL0k8BZnZcWDv459eqP+xvbTx8YyM7NTFTmmKgdvluXYaYQI7fyzQUM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Au6xXDpf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725356397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rPJ8JR2hsu2+h8AaCAr5yRN3QjhSF/kOuIBdMukfuug=;
	b=Au6xXDpfDdZcsDmgJ1w3MqDvnKqOCoAy6WZkhVJOVH9cgXirJeTD59aNk84INqek034i1E
	Z4+AivIud2m11d2LO9EmH6HFLPu00Cya485u9JzXj0Vketm6BIa+bXqw1nNr54czTJKwg9
	dBbMgrd8oE24rbEdTlgKHjNqpYGCYpE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-WIgiqh2uPAKZh-BvFH9t5w-1; Tue, 03 Sep 2024 05:39:56 -0400
X-MC-Unique: WIgiqh2uPAKZh-BvFH9t5w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42bbd062ac1so37190225e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 02:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725356395; x=1725961195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPJ8JR2hsu2+h8AaCAr5yRN3QjhSF/kOuIBdMukfuug=;
        b=mFhrSE3Kswvi8JILGDWXSoJbIQlbrCz/SPyIqvpWM6Qeqq7W2rgRGxmwz/5nMc5u1f
         3N53tunZhHmHmVkRJmwn35BSLbA0COMx9MQy6pxPYr2DjiJfoF+UW9aQ6RUNUK/MfSUK
         HpaWzaRWOEsS/vJM2d4CwZEcmrMNg8CKFwKmTrtWg1WaXxBW2Z0RRNFunDu99opMA5Iw
         hZL7W6gwF1bnirW/bAQuUfl08WteqLOliqKANx1UIjzKtetVLRgfkSUhoaAGQx5nCtUN
         k4ynHWCiFuDxGmu3mnNcnmNnSPvSBBliabPcTGbMVH5rXr9EBWWl43jWNOuCINoOImh3
         48tA==
X-Forwarded-Encrypted: i=1; AJvYcCXXfdsyA7RvpBsIAH9mUAhsiHR+DfkgcRq+PbkZlfyVYBMjfS6ox7m9LhaK6FfZlbZAqpl8ICuvyNYzkuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCmR/vM7Y8szi1BlSQLTJ9lyLgl7OU1PIGNEQpWSq1EI2QZPcj
	Jaxsmy4yEJ7DdJuQQnbS3HDX4Oly+aceVPKiYVtqKd+/atJiDdGD+tg2/Jnq4QqUKoWKeGTI4Es
	XfO8iC4k0T5LzLZGfbh2+jG/q1vgsc1oUhMuToGtA4qSICmvOzaweGfhzSHOhIw==
X-Received: by 2002:a5d:4086:0:b0:368:7583:54c7 with SMTP id ffacd0b85a97d-374bce97f92mr6805205f8f.8.1725356394862;
        Tue, 03 Sep 2024 02:39:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHopwsF2Or6X59KptCdtP9shvBUqKfSIOsOAprOTS/L+AM2LQoWh0DPR0/BX78uGFil1dVQkw==
X-Received: by 2002:a5d:4086:0:b0:368:7583:54c7 with SMTP id ffacd0b85a97d-374bce97f92mr6805193f8f.8.1725356394362;
        Tue, 03 Sep 2024 02:39:54 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e33d60sm165511655e9.43.2024.09.03.02.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 02:39:53 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: remove unneeded file entry in INPUT section
Date: Tue,  3 Sep 2024 11:39:48 +0200
Message-ID: <20240903093948.122957-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit b9401c658d2c ("MAINTAINERS: add gameport.h, serio.h and uinput.h to
INPUT section") adds further header files in ./include/linux/ and
./include/uapi/linux to the INPUT section, but the file
./include/linux/uinput.h does not exist since commit a11bc476b987 ("Input:
uinput - fold header into the driver proper") removed this header file
in 2017.

Fortunately, ./scripts/get_maintainer.pl --self-test=patterns complains
about a broken reference. Remove the file entry referring to the
non-existing header file in the INPUT section.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 87108b3fefaa..3b19921eb948 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11195,7 +11195,6 @@ F:	include/linux/input.h
 F:	include/linux/input/
 F:	include/linux/libps2.h
 F:	include/linux/serio.h
-F:	include/linux/uinput.h
 F:	include/uapi/linux/gameport.h
 F:	include/uapi/linux/input-event-codes.h
 F:	include/uapi/linux/input.h
-- 
2.46.0


