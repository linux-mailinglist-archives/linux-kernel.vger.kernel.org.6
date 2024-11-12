Return-Path: <linux-kernel+bounces-406256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C299C5E70
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC693BA36DA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6B420408C;
	Tue, 12 Nov 2024 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cphwKQ9m"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB7D20400C;
	Tue, 12 Nov 2024 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427114; cv=none; b=Oun0EbCYZRDCoBgfv3OR76xwUcr/DgyH8MRi3IElF71EyArmg/UtTiSlVA2F+Mmf7kwd0bw4oZka6X7ePaa7+bCiSSLIpM5nyTshwmHyaRplSU8KXz+zbHWz5fz3BYtpkkPsCXfzi3cHo9uGfs0eUyMDAbLue11FnsjnVu0kypg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427114; c=relaxed/simple;
	bh=uSU/VtQn1QUlbG4Wl5WZNMTR0aFBqiE+k0MLbiJaaKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dfF5HrGt8iMOrasVyUx9MXsqK6MgMyxuf20pySq8IpUgiYoYALGAgFvjomCZkf9CabCXPPF1GQQzUOqv2Bqu237wRI0SCWEkdeT34CQnjINjCmTHHjoBErj+HnncxdwfgVohYsmEYs52KNVk9355BYoG0CDSRB8yVhbWTdMFkMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cphwKQ9m; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-381ee2e10dfso3420349f8f.0;
        Tue, 12 Nov 2024 07:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731427111; x=1732031911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGw6mWqyKGhSGEz0pcciGxD/rSjc8N2yFhLNVJVJUYM=;
        b=cphwKQ9mAQz5vqIY9GruKjMwl/0OimzX7MBAsCPyRjl7XlvgbdiQ5yTDg4a+vDrXyI
         X4FJWGAaS/IckpZlmaUb61kkLJtRzLQHk3XcQ3hOntzsx6fZ7UtQGFObv/VVsfgOz2jX
         TtYnKbMqN9qrzTU2FE2DJrl+7k9K8a+b+4xSnpSQZEyWBAEYSV/YH09lTjMpbooM9FD+
         FCQtiaE6mXdbGhUUpJRtAxIlhQaLUg7v2M728FgLuPSaaig5bQ1ADCj+CXFaZpWA/988
         WE5ySrrHmH4dJGFNSRazVzpuj1GynV+UoQu6X9ZkiNBOJxRo3QxR/o/YZlDhulRzXXrF
         7QOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731427111; x=1732031911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGw6mWqyKGhSGEz0pcciGxD/rSjc8N2yFhLNVJVJUYM=;
        b=h4+wUyFUdhWYMQnaqZ0IT0gBZovwI5vhT61FdbphCyjb8w8LpWY/cYLdYPZo4iECf+
         x3tKiFqx1HHkIovcLXB7escPvPQL9NmFPeqkPqRbDj+K4n3N+dBq3M6OfAkegcnlCYNo
         TbmuAzROhhMIU+3NiWvw+3gr7hunVRaUcp6bJVfSfE1XdnqD/f7wR8aRD08RidiBv24Q
         P6LkUXcVCyxvuF/eUYQDU0KGnYSdcciC/Uv4GVF0ibb4pXRpI8L5B795mQKG/BvILy93
         nNyw5q260q3xQatiq3jXOzsY+96obofJSF8tQNtsHkDvlPrgqovY0HDKWwvXeWtDYLVd
         0lig==
X-Forwarded-Encrypted: i=1; AJvYcCVoR0hXbBWkwTkTadeyd34m86WtChSPrfXgyPBZRBqmhzjzsz+AqZcG3qSdyJIaGc5XKswTs7c1FBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKYJ8mi85YEjfue+dN/i4lRYvg5i03YcMDUNA4muVVVDitEjdo
	ZkEF/c6A0xh14Ar/zi1RazGOS78HPACnZaLyYEGOtHHadVeoRxaKgBneKCThOuA=
X-Google-Smtp-Source: AGHT+IEbyNeqX/7SF/IGuqdiiAfXFJz/3cccPl3GxFMxGzcm+w5FZmI77IrTrDi6ZFwOa2K4uuRVLA==
X-Received: by 2002:a05:6000:2a2:b0:37d:5257:41bd with SMTP id ffacd0b85a97d-381f1862d93mr14320340f8f.3.1731427111188;
        Tue, 12 Nov 2024 07:58:31 -0800 (PST)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381edc1104asm15991136f8f.88.2024.11.12.07.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 07:58:30 -0800 (PST)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: gregkh@linuxfoundation.org,
	andreyknvl@gmail.com,
	b-liu@ti.com,
	johan@kernel.org,
	oneukum@suse.com,
	stern@rowland.harvard.edu
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	snovitoll@gmail.com,
	usb-storage@lists.one-eyed-alien.net
Subject: [PATCH v2 2/8] drivers/usb/core: refactor max with max_t
Date: Tue, 12 Nov 2024 20:58:11 +0500
Message-Id: <20241112155817.3512577-3-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112155817.3512577-1-snovitoll@gmail.com>
References: <2024111251-spill-hatchback-72da@gregkh>
 <20241112155817.3512577-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure type safety by using max_t() instead of max().

Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 drivers/usb/core/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 880d52c0949d..25a00f974934 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -924,7 +924,7 @@ int usb_get_configuration(struct usb_device *dev)
 			result = -EINVAL;
 			goto err;
 		}
-		length = max((int) le16_to_cpu(desc->wTotalLength),
+		length = max_t(int, le16_to_cpu(desc->wTotalLength),
 		    USB_DT_CONFIG_SIZE);
 
 		/* Now that we know the length, get the whole thing */
-- 
2.34.1


