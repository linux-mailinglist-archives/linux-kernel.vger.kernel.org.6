Return-Path: <linux-kernel+bounces-414565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5E29D2A09
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351791F23605
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68151D0F63;
	Tue, 19 Nov 2024 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5n2aaAu"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65851CEAA6;
	Tue, 19 Nov 2024 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030998; cv=none; b=n5wDsL9j2RqR7gcJCLXuujGlb/qoNWRsOZc1Lo5QYASEIONHXSPM6TY93OLuOtwXwO3/FarXJo0lmCavo4Ip5tRO6dsQ1ZlJtDZ6l8VXQPl13FvoUTBjfHA+pVpZsVjmDGHcC1zDX6QQNsYP3YU2f6IEiem9QfH+l15poJC/RgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030998; c=relaxed/simple;
	bh=FkL5bkKtAiHvQTF29E9UZy7IZKVw5GcwQnU8LPk+eyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CkdXFDvu9+eaRyfDSOnbZ98GGHIBknGqoI4ND67AryqctnA+GpUa9ekuGilVnnboBFgaZ0c7jFZXh9YM2MhGacsUab1skt/zi+6muLwxOBpVM9ps6QUhR+wUzem25Jxrwd3lOrFLdAwbF2mNAhTVc5Ndi71UclQE8b+V0jZoJHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5n2aaAu; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e388ff24cfeso2294695276.1;
        Tue, 19 Nov 2024 07:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732030996; x=1732635796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wEGUj1o7pb0AzUqV7Fkn4ZlKTwE9iZsUWbsWf714dAg=;
        b=c5n2aaAuIFAbAD0IbdT8hM5ghMXI3FkP/+TwOVhc1PHfk0+dU/jPsjECYbIbH6DDzl
         aHdzxbgPiO5ljEYgZ/4q2hvi99HBqW4B85gAK/pGYtNdHI13dWEJUPgtGNGo2PTAGI8G
         cMGtQJ8jGvOXB/W8qYujiGui5ZmF340HnlJNq7amn3pEeL75jqpCKJ9FMSzYKzK3SJqc
         0jCA3hmOnKb7O2btxr3ezGOp+ScV+6aKojqFifQIOQX1DeAaQZH/+8Irhd/FOPUpljJe
         xTgtj92Iefc9bbPOXIhYJtYclW5XFaOmuMjKOGKtlr+9PVgX5Gnnn8LnhqFWtTNeuYoN
         iZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732030996; x=1732635796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEGUj1o7pb0AzUqV7Fkn4ZlKTwE9iZsUWbsWf714dAg=;
        b=B4F8NNaE9PdD8nfFwIXMuinxahPeJoK6yVbIHvL/Jw0XzUQwvKotYS1I7i3QPHt7GY
         3Eo4aaEMEaByHq0yDxK5ReRbXePl4FvcSHnNw0ZfArNPjxfxPhNJkGJaLkplQgM6yWUk
         9MuYdxO2nKNIHB+lg7ZwoVEawQRajbG5yadLJSAWRnOt7o7//hmKCeP4jA3SHmStgMzM
         OetfJgO3QfXtf/O2bpcZCJaTRujP2OTr0PUfS62zCDrytSSIdl0HfHgXNVZ03h4MlbPp
         wuZoxtrf3yr8pAmfk3iE0H2CM7CqC17dLAJ1Hujk/ZKZyvKIkGSP0MeuQgJ4smW95371
         1Yxw==
X-Forwarded-Encrypted: i=1; AJvYcCX04UovC6/FLE+QfvjTGUBH2lyAj9lxpj+dMb2fFboe9OYbP29vr7vNz76lXLX6YKzBSow2ZdErwdxo3Go=@vger.kernel.org, AJvYcCX4SDpmHljLj9TTDikTiNZa/HyQiResWSLtnwOmuqIB9HEs26V0qY459/oNrWfmUUn6KFf7Y12J58OI@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj8fuBqMcBrgx0PAZoKOv9lubB5trBGC5LTKkNT9pa9oOupZKc
	jzHvNMaIZrsyiA0NAcxqfZ4waeTeJw2jwlrxz9K6mdLsdpQI6E7Y
X-Google-Smtp-Source: AGHT+IEdUneL+IdFdTDxewMisaVAR0l3eDRbxXY6aYZEdvtBXu14ad10c2xaIszw9JSsl0K5XvOwiQ==
X-Received: by 2002:a05:6902:1022:b0:e38:8a7e:6a6 with SMTP id 3f1490d57ef6-e388a7e16c5mr7387684276.11.1732030995702;
        Tue, 19 Nov 2024 07:43:15 -0800 (PST)
Received: from x13.. ([157.23.249.72])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e387e763c98sm2530152276.28.2024.11.19.07.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 07:43:15 -0800 (PST)
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: Thinh.Nguyen@synopsys.com,
	gregkh@linuxfoundation.org
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	skhan@linuxfoundation.org,
	ricardo@marliere.net,
	linux-usb@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Documentation: usb: dwc3: remove deprecated member
Date: Tue, 19 Nov 2024 10:43:07 -0500
Message-ID: <20241119154309.98747-1-luis.hernandez093@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch updates the documentation for the dwc3_request struct,
removing the sg (scatter list pointer) member.

- Remove 'sg' in the doc block for dwc3_request

This change resolves a documentation warning related to the missing
description for this field.

Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
---
v1->v2: remove unused sg struct member as per review[1]
[1] https://lore.kernel.org/linux-usb/20241119020807.cn7ugxnhbkqwrr2b@synopsys.com/#t
---
 drivers/usb/dwc3/core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index ee73789326bc..3be069c4520e 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -956,7 +956,6 @@ struct dwc3_request {
 	struct usb_request	request;
 	struct list_head	list;
 	struct dwc3_ep		*dep;
-	struct scatterlist	*sg;
 	struct scatterlist	*start_sg;
 
 	unsigned int		num_pending_sgs;
-- 
2.47.0


