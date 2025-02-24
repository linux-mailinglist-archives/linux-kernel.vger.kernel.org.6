Return-Path: <linux-kernel+bounces-528399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5BDA4175F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C993B49E5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DAA1C84B9;
	Mon, 24 Feb 2025 08:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eiR5CFvZ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FC9193435
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740385644; cv=none; b=Jn6+mevdT3mokncSPYuYS/39qpbSt+i5OZ2e2WAAa5IpGpXtrwCRoa70X6Kp7MztKjE4w+D4dDWFiEGknaLzRWgFWohRNjyg3rZ2UHurKKM5oW1yKTlsESzy7sMndUmV4fwa/tdla0Hy0VcZ7tfOW6tNrsHxUpPH9ZzKMHDqyRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740385644; c=relaxed/simple;
	bh=Q3G1+33lrvJYjOe1KYWkvp9kKAHqf4tAYP2F+D1Ce2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IZ+euIy0I4MydWZBRd1eNyB+6ZkvXQvYxD8RCniOaZmzvFje6SdxUShVnIVjOXqwRN4V3jeQ9oKBYNyMGJ5rSVvM6puVDgiwejoa89MR/xkbKdGs1snAd/xjD8v2ERr7R0r+fkgtrqaboBmPzwpNkRhivOx0uE76kOrANGNumxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eiR5CFvZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4399d14334aso35597805e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740385641; x=1740990441; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uk396VuDOMsVA8+Zf1OOE0m10yce424MtlVhncgJRbc=;
        b=eiR5CFvZRqugZ2hJ306pXL7lP/IQgK1oX40u4+t5rnKkkvWBxSeqpCuyIyPT+eoyYY
         LwK49yFJTgjzxITIrXArSgwHYRtX/f0RgvGW81kIemQoYIl5D0/9jclXA1WGaBgLlCgq
         p1SnqSU9GWgIuJa5fwGmWwQuyoVYXYUSLA7Z1nFW/3MfmjzG7wJlYJ1/ONAB0b0XGDsC
         jxOS3GJso+mxZYHROexL8KBapRPY1p9HIRqHWDzGdmaz7pmLEFkluFr0j00+hmhTfyCs
         uMZeqSuqNThh5U9Bqkbx2X3JZECOwSVxCqFZwUwS+LojC2wGhowiYnLYIogKUiRlgsD7
         p94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740385641; x=1740990441;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uk396VuDOMsVA8+Zf1OOE0m10yce424MtlVhncgJRbc=;
        b=I2qAzSfl+P+c3QyJOpuqqe7Lrfh593v9twjp+gzxFzkwN6Wg6/kEa8iVKyH+em0zeL
         wR+1rtcMst9kRYedfxuSNpgM2Xtpv4jjN/U7dJ5JcpQZgvIc5fvP/2HUbOIQOrNUpwRW
         ycAqSJwmdT+9qKWA/zwQrkJQmJFHQujyt9MRkKy8m0XOgbd5pZMZK7dEIM43faV894YO
         gPmW3VX+/UE0tdXaj1imglQMAgUNverG8t3RuIpBMUrRHaveiR2mshffxE3SslJ34uJy
         pEbSuq5/91jwZqZvz1FpCwhA167d5WB+eLJ/3Zyjs49La8kjjBNVrcy52Pf+nRajmFlD
         zLxQ==
X-Gm-Message-State: AOJu0YzjH/5SMAWZx2u5mM62n3tCyromsQXLPVg7gG20KqQvrue9zYEh
	A5SjugRSQdpk2s4eq8gQFqrVIn9xB8LDWZ7vBA2A2dk21oG0jRVk0ljJdzp/KjpZLOku3tNOmHv
	bPZ8=
X-Gm-Gg: ASbGncsQpXDdufaidgDCsRIMi9VZR6lPYzHca2tOEeocG1QdAoqa5k6dwiZy/rOBlO7
	BQp9v91lI3kG1ss5QPUPsEa2pdpEN+hsbTOvSWEtp0WMC/Jku4dcxnsGUig0wUBD2IPqlQhR1/e
	qymVjd7gDiGfEHPd5JrwgYJAn8MSkcPlpvUvA9pwc6+uoPHRRZmOe40Fxb7KuqSV8cRd47TL+sk
	yOUE4P6IxCmdTkcZSoZ/QpKn52ULUqlPOlfbv6TA0F8kdx2zuSx7jeG1JYVJ2bk2+LUz1cl0D2x
	yxO6wwWUyurVDViTomFaDlEBR5keu+J+BG/ikC4yZMNvq55d9k6SlWZKl2hP8A2qqtnL1oOnCiK
	ra38VBw==
X-Google-Smtp-Source: AGHT+IEnRLN9Ixv+JBMwIap6yESxjtcmZunqGmsR9gYImMzQg7bdBY8/6/En1B1LtKHsJVvsiPuCTw==
X-Received: by 2002:a05:600c:1396:b0:439:6d7c:48fd with SMTP id 5b1f17b1804b1-439ae1d877dmr101583305e9.4.1740385641454;
        Mon, 24 Feb 2025 00:27:21 -0800 (PST)
Received: from ta2.c.googlers.com (169.178.77.34.bc.googleusercontent.com. [34.77.178.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce428sm101226065e9.5.2025.02.24.00.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 00:27:20 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 24 Feb 2025 08:27:16 +0000
Subject: [PATCH v2 4/6] mailbox: explicitly include <linux/bits.h>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-mbox-mutex-v2-4-9d699148fe4e@linaro.org>
References: <20250224-mbox-mutex-v2-0-9d699148fe4e@linaro.org>
In-Reply-To: <20250224-mbox-mutex-v2-0-9d699148fe4e@linaro.org>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
 peter.griffin@linaro.org, willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740385635; l=784;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=Q3G1+33lrvJYjOe1KYWkvp9kKAHqf4tAYP2F+D1Ce2s=;
 b=WmCEx3ps4LjV+7JWLnRXH/r6i5vER0+8ZA/yvKti1u6dprJB/h7kS2fkL6J07pSpqEALnNEQH
 jyzYE5+1VOZASE4pV+teKr7kHBDw/vq1b2iOeSlZvXopJYo7TX5UtAO
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Don't rely on those including the header file to already include the
needed <linux/bits.h>. Include it in the header file.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mailbox/mailbox.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mailbox/mailbox.h b/drivers/mailbox/mailbox.h
index 046d6d258b32..e1ec4efab693 100644
--- a/drivers/mailbox/mailbox.h
+++ b/drivers/mailbox/mailbox.h
@@ -3,6 +3,8 @@
 #ifndef __MAILBOX_H
 #define __MAILBOX_H
 
+#include <linux/bits.h>
+
 #define TXDONE_BY_IRQ	BIT(0) /* controller has remote RTR irq */
 #define TXDONE_BY_POLL	BIT(1) /* controller can read status of last TX */
 #define TXDONE_BY_ACK	BIT(2) /* S/W ACK received by Client ticks the TX */

-- 
2.48.1.601.g30ceb7b040-goog


