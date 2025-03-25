Return-Path: <linux-kernel+bounces-575053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702D0A6ECFC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082553B7673
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2154254855;
	Tue, 25 Mar 2025 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cM8AJS6S"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C621DE8A5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895974; cv=none; b=Nbqch5Me8rIl0jjRCcqQeh6jUKTioZnkV4QIUue3ID4eQBlOKiUC8ZI8+rpAcYqR4a1HI/IgRliC70oNDdGG33HnJcmQaFlbqQ5RUDcaOoCKIJt/sV/EJ7JgTwEAzjoyXYF4KxeuhTsUwUXt31pkU0hGHbR5Om4gjl8XK/sZj9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895974; c=relaxed/simple;
	bh=lJwd9RuzohyybOZuJcJO85WskvXGtLy1H+iADky9H0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e2Q0XS7WAj95nwayRv4waFFYZfjMRPcF8kdQ1S1TDktGqta1dVf+ty4aKxS5aHIMdhltUztjGXMkKLMqZxGEDD7jX3wI1bPunn1vIG0m4/SDkdP/M2mlr+lpv5JllC0huYbDIcbdKZPvDsENYgSGuUOpl29qDw62ZEfFv+Cf9m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cM8AJS6S; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e61da95244so9014699a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 02:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742895971; x=1743500771; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6Fu6WaKV6UwFUaV1JRbU4BYRYqi9fvopRa8oATbj0Q=;
        b=cM8AJS6SIcApbWUlfjRAvQBOndqq8xy6NPu4i4FiOiFPAZrntpMTYYzROQsXt1/yMw
         OSTpsjr0qlg0raV6TDEnZiYLW+v9HG0H0X+CiSFFZLM4MnuVx+KL0hOG8VrwZgu32ay9
         zdW/X5ZqR0J92zhglj3Er1Dqezulz9Uwdu2cxw7lDtQ9xZXrHLfBpMbT8MVdnJbxi56t
         /fs4HGAyGCCgw3I6mbgZxiSiBU1aB2LFaBolzsklbt55Z2CL5n4P904FsY8LFLNlszyw
         nH3+Ow3y1zZbb45CclDDjoYUsYuCncwulhy1d890ivDXUlBvfIJag/FPVuQR149Fqwf1
         a7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742895971; x=1743500771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6Fu6WaKV6UwFUaV1JRbU4BYRYqi9fvopRa8oATbj0Q=;
        b=QIezg2aW4VYTjkHZzlAR1t610Dn77XKOi7B5nCAsIVRrQZ2+n6biqPeGpvtImw+of/
         WeORcMf0qcRXTYaHSx6xzCsNLqDDEhkm3wLVWxJEZQVQWpCRwRnTT5uJOnWw6MUJ09Ue
         u/nHiJ/SsvJccZGXgXQrxwuF7ZnCH/VbsdJY6cpf5Ur+lU+eUPTsRvZAAUX09XLZ0sHt
         h6D1zrHOI/rBtW9A+kjyWxMJ3Mo76EYhM9uTl7Ddi5bSgO827ypg8WesX3ZfzXxzCO9H
         4qY4JyuJ4S15fOnlR5jBDQWsQZJXEglKqO5doQC0PByvYGzloFsw+EqW956DA8KsgE14
         QEhg==
X-Forwarded-Encrypted: i=1; AJvYcCXmdQzzawkrJpCFlNDYj7qXN8qCJkw124YCJM3/PdxvkyR1eFfhlJxViOBSQwhv5ymcsrJs4ePg+mzb4CI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMK+KCsb+2ZPsz8H/57untyvxlYEFh+tG3XM1/oxWv2akuE3/Z
	yJyzTZ3YoPanoApTBKGppVQTyn3RG/YtIdmWQh+PyB8pa9M4RFVl8qcccKnPyjLi3OGEJmnzwat
	oHPg=
X-Gm-Gg: ASbGncvluE3glz4zd4EmHtlqHrEqNOW79jVwqmxilLUGuA5gVMMie/rSKzH987qA0G2
	9bjUk6SylsSxwe5j2qfuy12m649YBAKf/yZ5ejapyVMSf3FvOTp4X3I+j1plDk65iG90PEAFAEF
	ChmmVWkw2b83xIDFPxlx6mx8eBN2JpagpQ3PjSCN8Yo9LKiN8yp9UYpWEmrXa359tJuouziaW/o
	y6T7RtvAfTBYIn8ugXstGskxCrOiFlUlVf6YoUEsQqUja5TjYDAkKUMWWmSOhLMRgqexQ6BnoNH
	OFZuaV0Jh0Y/wAK9HngrCHnMeyGwf4+AQYZ+lFDA8O3iZC0czJjs27/a1BUwZYhW3xwxdlr04dr
	VzzcGQho32uplBPGZ5YwOvIA45dV8
X-Google-Smtp-Source: AGHT+IHJAkOOtBg6Ow48+caX8OWgjB0vQLeBKP45DnYtGc5Gk49AKHqQCTiXRKEbwQxhd5ygBBxnoQ==
X-Received: by 2002:a17:906:4795:b0:ac3:b372:6d10 with SMTP id a640c23a62f3a-ac3f2081eaamr1405346066b.4.1742895970561;
        Tue, 25 Mar 2025 02:46:10 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8e509dsm832834566b.68.2025.03.25.02.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 02:46:10 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 25 Mar 2025 09:46:08 +0000
Subject: [PATCH v3 2/2] firmware: exynos-acpm: allow use during system
 shutdown
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250325-acpm-atomic-v3-2-c66aae7df925@linaro.org>
References: <20250325-acpm-atomic-v3-0-c66aae7df925@linaro.org>
In-Reply-To: <20250325-acpm-atomic-v3-0-c66aae7df925@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

We need to access the PMIC during late system shutdown and at that time
we are not allowed to sleep anymore.

To make this case work, and since we can't detect this case in a
non-racy way, switch to using udelay() unconditionally, instead of
usleep_range().

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v3:
* use udelay() unconditionally (Krzysztof)
* drop previous Rb tag

udelay(20) causes a checkpatch --strict warning (it suggests to use
usleep_range() instead for usec >= 10), but that's exactly what we can
not do.
Reducing the udelay to be smaller than 10 will generally cause the loop
to be iterated more than once, which I wanted to avoid.
I could reflow the code to hide the actual value from checkpatch, e.g.
with the help of a local variable if that is preferred to ignoring the
checkpatch warning.
---
 drivers/firmware/samsung/exynos-acpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index 542eaff03f9e39422a8c5345ca75e05c1710a9ee..379da420b9eb3fcbca5461bec7e2de6bf0774659 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -300,7 +300,7 @@ static int acpm_dequeue_by_polling(struct acpm_chan *achan,
 			return 0;
 
 		/* Determined experimentally. */
-		usleep_range(20, 30);
+		udelay(20);
 	} while (ktime_before(ktime_get(), timeout));
 
 	dev_err(dev, "Timeout! ch:%u s:%u bitmap:%lx.\n",

-- 
2.49.0.395.g12beb8f557-goog


