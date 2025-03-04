Return-Path: <linux-kernel+bounces-543275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3934A4D3B6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73252189801F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDE51F76C2;
	Tue,  4 Mar 2025 06:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0JhxR9p"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4781F666B;
	Tue,  4 Mar 2025 06:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069255; cv=none; b=ilH5EksEmipMcwBsd+sfJjEwyyLSHC88GGm6ZTlZetSCrys6n4d/Kprh3rYDKq4cwhEDe3zzdXRvpSPyYbI4yoYEBAJQy9+1PwxCsogu91N1Jwo6/j/CHK0+jNosSQiERmsHHnEQV8Q+o56mJojshJw6820XvPbIKvsusRZAsLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069255; c=relaxed/simple;
	bh=shsY8picWdauNM7HAi5QIbN1+/obURFOkQY2q4XNRbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PfdO1pnEKUd64sOJxq/E2CGjRZ2DlI1SA2Tj5dWiaxp93oiCA3C2zqN100JPGLs4JhifvPCx/ex4d8KKJQBXNP7qdoXWoDj6D2bfOXzkvkDUcMQeOpgMlfszTqvidpZ9vt9CmchMV3dhh7pb89uqyEtd3bAsDU6AE7FBRP/Dxls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0JhxR9p; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e4d50ed90aso5861138a12.0;
        Mon, 03 Mar 2025 22:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741069252; x=1741674052; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xva56AKX2brNKS42OhnyZtYq2t1leFGV1oKmYOkZd/E=;
        b=l0JhxR9pWrNfQ6PUmBIYbmXDPFAE4e5bWqNzJt7fjKsU06QU8QUUFosWzIYD6dQIuv
         a0UAgLdPpDX71Of5cCyWgsy8HBxvwbYHKcJvtOyLVkWGZwE/vGz7VdJm7xzGz/rQ6gWB
         g67oYyx3H/4jG6Bx2Pe7+H5f47EgpjSM2R0VQV1ZDO/3FA7GGBa/p9HxwPIUxjuNyhhD
         CrTazbyT5gVDY+eG/Gk4mnc3B50NmWRHkQyp7PEPZdmoAGjjC2ZpXxFwgoUQy4VfJa3a
         mxlRx08n+iJwJiNcMI33aS3fSQfZJ6V4PFUQf/RCrX0ARo+ZUJPBYsDUkP7ESX9Jhc6e
         xK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741069252; x=1741674052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xva56AKX2brNKS42OhnyZtYq2t1leFGV1oKmYOkZd/E=;
        b=XS3/2NpoA3d0BKzOTr+H7D0vX2HskwQY2W/mrKN/Eg25G+a4i64/RVelZXc/fF25//
         WIwI6F14FPeFs3Pb3XCQOMcBTjV8Nh7y4G3sfdU15a1iakWoywjEirXEE/VH80PbJpAI
         /QZFB4vX4Hof5inNrqi5jzY6AJPOYFcBI3DnCxgQ+me1Ph6D6TXSSsM2nuJCmqQGdb0H
         Fqr1mBA/PBP1T3AEXhKPs74OAcZI9C9lWiFe3qE/fHDTJ4lddVb4zd3wOOT5u8y5CIaw
         shK3AFioD3vtEITXqj+7AyUNUb9cKSN001BH5+W0qopVSK9SA8YyxL1gx8690YLgogGN
         /D0A==
X-Forwarded-Encrypted: i=1; AJvYcCUWFC+7uNb0rkPiDLl3mPajPqTxu5TmCWCSCK/mhR/0Vzde0GRZCyl9aP64+aWzXtH/+9vgSdKuUaR3QrtA@vger.kernel.org, AJvYcCUZeaFjgOzpLrUHLyiBsbq3/ZaoMKsTnbPSNATl0G7oEdyyfGv//P/LvBXPl1oeduhi1KJ156jXg5kP@vger.kernel.org
X-Gm-Message-State: AOJu0YwWnaqIvvThp1oxWBn+fhlkCkjjV8+nJyTj/TG347iMaqnG5B6F
	HW15P8eb0+kYyHD4e+dEQRauCZxESdh++ASWCo4BoeA7IOhpqWmj
X-Gm-Gg: ASbGncsCZrbmb4fFX8ZSpkjTGPKTlx43PB1aP8lYBNjM787hbC3Jcfs2nmqm+qVxeW3
	u9bBdQAVPRiJQc4D3mfI9UufbZpFtGACHqrccqS/Y952Ee6SZdFocPDsJynROX3nsWZrWMZWs2E
	7h02o7vmgKKFIrjEyOODah0dfLzLyZjj2s7vK2UQNqKrmjUZ9dJ6woGlALosGQpCtuM+TJ4NkEW
	mmq9R6DO9BVN+JX5PapQ1YJonUfUQS/FAQ62yf09K+mrtw7kNshSKA3qIWT8Eb6Z0FMvQ9ryaFU
	y23sDkkiJ3Hvju4AXgrcJAgn5XZ/c2piNgPfsqZfDuycON4y+uX30VlT1RtAjjpOx6RMjtpMQ9w
	ElOEneI8Huxfj1eY=
X-Google-Smtp-Source: AGHT+IGqxGbHhw8vAWP2kBYNSJUUX3w7Bp7K4lE281b5Teg6k5sdnOV9KvAZu8RwZYv6Q2M+AHVuhA==
X-Received: by 2002:a05:6402:3511:b0:5d0:8197:7ab3 with SMTP id 4fb4d7f45d1cf-5e4d6acd50bmr17383364a12.3.1741069251986;
        Mon, 03 Mar 2025 22:20:51 -0800 (PST)
Received: from hex.my.domain (83.8.122.142.ipv4.supernova.orange.pl. [83.8.122.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a663fsm7609036a12.68.2025.03.03.22.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 22:20:51 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Tue, 04 Mar 2025 07:20:35 +0100
Subject: [PATCH v6 04/10] mfd: bcm590xx: Drop unused "id" member of
 bcm590xx MFD struct
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-bcm59054-v6-4-ae8302358443@gmail.com>
References: <20250304-bcm59054-v6-0-ae8302358443@gmail.com>
In-Reply-To: <20250304-bcm59054-v6-0-ae8302358443@gmail.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Stanislav Jakubek <stano.jakubek@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741069240; l=805;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=shsY8picWdauNM7HAi5QIbN1+/obURFOkQY2q4XNRbc=;
 b=OVhUKUbl5xyAk7zk6jqImezy1Yc4vGpEyWmiVYIC6OqY5Te8APboSXtlIjB3/WJXSZo75TO6s
 DYaWzcPvgBoAXjtRtdrYvmlbffH7EHq/VyPjjZ+YAsOTX/yBX4WS97y
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

The "id" member of the bcm590xx struct is unused and will be confusing
once we add an actual PMU ID storage value. Drop it; a replacement
will be introduced in a future commit.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v6:
- Add this commit
---
 include/linux/mfd/bcm590xx.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mfd/bcm590xx.h b/include/linux/mfd/bcm590xx.h
index 6b8791da6119b22514447bf1572238b71c8b0e97..c614d1b1d8a217ac2f212908a4c19ae71fa56f63 100644
--- a/include/linux/mfd/bcm590xx.h
+++ b/include/linux/mfd/bcm590xx.h
@@ -23,7 +23,6 @@ struct bcm590xx {
 	struct i2c_client *i2c_sec;
 	struct regmap *regmap_pri;
 	struct regmap *regmap_sec;
-	unsigned int id;
 };
 
 #endif /*  __LINUX_MFD_BCM590XX_H */

-- 
2.48.1


