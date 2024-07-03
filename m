Return-Path: <linux-kernel+bounces-239223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9981C92582C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11FEA28F80C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7364F14265C;
	Wed,  3 Jul 2024 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MWUTEvxH"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1859274413
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001774; cv=none; b=d+JToXWenPnpFG5KVSnMwKJD09GQMxXqFQwfVt2+klJOCBZoVvyxguvfIScPvEOFdaZ0u5Pl8I7YsSqdXTzHVM5DbQc8QJ4eUKDmY3NL4OSawTe0XDyQQYESl4jQv8//HHy3vteobxR6aOLFI1efaNnq2GznihIK0IO/G3D5SSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001774; c=relaxed/simple;
	bh=rVRf9n1bFnXgcGWnl9warbbpA8WJWg1GWzSYHcOBEF0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D22BH7n9U/GVO3nnboIRW4FF7laK//Dzrg3QgfALO2GgKmgdtwybDv0KjCWJpEDteBnfCgkvbTa0U4gXcQcc4zHFB/9waSFGmyiaHZHiDxXR+wEtRDIpx3lgYLfNE8xkmz0xAegmM485DkvL05S6FzX2DSe6bCbBECl1q6Y3s5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MWUTEvxH; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57cb9a370ddso3477595a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 03:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720001771; x=1720606571; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8n4l537zzmVevTwRxYF/dAXb8Lz3WH76s41W0uF6dT4=;
        b=MWUTEvxHtZmYLcE311bSzrjtEJxnKQ+4YJ+dEeoaOMoZgn8S/6cDglaYjpScKIVd1W
         dni3pm440IgYqa3m98rPQcutyCM2z7HIG9ctxgHI89Qvxsa1wJD99uA5poTJ8U8hW/Iw
         YGo9WUdQ8mmycRy5RFBzRdgfAy3E550U0AEn2R9g6wXHJEKO+f1Fwnsxy0mLZ/cdPN/x
         0QwjqNyq5XiRQqbR3+5TX3lnRKGdXVXjSFd7umRH774Q80OmXtA/yLs6+jzH0i43oLZ+
         mPwYhhKuyAfKwjx73A8ane9uCczuwZ6UjLaKrikZ46l687EEDdT2vopmXtCxLFkfIY+k
         Ys5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720001771; x=1720606571;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8n4l537zzmVevTwRxYF/dAXb8Lz3WH76s41W0uF6dT4=;
        b=eiUlwRyWWHfFV86aCar4cqY/xnyFVs4y+ieUtPlLciMoaIALXUo2Qw1h6BP6lL8fAk
         j9FPRAnvEFei1pgDV8RU8Xvni5C1Ki8u4LrxqOml/sNTp6SpPict9DHj/o7yQXRvTRe6
         ypAoV2SI1bP1zN6W+9IebD8bHI6PckNnGg22rIoRP9DHpHebNA0SBzVilfophBaK5jqk
         5VXmHMsbSm1b0vKZ35DLC8bJeCiM18YkEXVd8GnMwsVZkrcgtEqD99IkhZaoN4OfApw2
         QP9h8621n69ShzK0LUcCWg0IiUhmtlq/AWrOpiJY5wY5Qmy8iTCyz7dbrNTLWqDJZmN1
         T8Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWY06YRmEGmW2ygcdPkPF5EGJFUZYEuByfSYMZiWsC+GaaS1lWpZYG91WnRGsYHRCVpqaPJ0embCd3vO1/YwfzKGMMcDieHpLTkfgZG
X-Gm-Message-State: AOJu0YxOjFXdy8XSdb3pTd2bUovvN+/OZMsnPv61D4Md0hZVf/4voqBS
	H+gJA/QGZx5KVtvP4glrwsvJNLFg30Jsi03llWfbSe+U1VLak8qsSmR4cbe2KgQ=
X-Google-Smtp-Source: AGHT+IHjh2iPIsDOndUbytlmALDqW/1/ZBtRvtQbnsaiAJOFDAAUYImBknXBOAZcTuBdDGgTPdlzUA==
X-Received: by 2002:a17:906:584f:b0:a72:7e5f:a0af with SMTP id a640c23a62f3a-a75144a8f07mr645953066b.55.1720001771282;
        Wed, 03 Jul 2024 03:16:11 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab06565csm494291466b.103.2024.07.03.03.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 03:16:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/9] soundwire: simplify code with cleanup.h
Date: Wed, 03 Jul 2024 12:15:52 +0200
Message-Id: <20240703-soundwire-cleanup-h-v1-0-24fa0dbb948f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANgkhWYC/x3MTQqAIBBA4avErBswE6KuEi1MpxoIFaUfEO+et
 PwW72VIFJkSTE2GSDcn9q6iaxswh3Y7IdtqkEIqMYgek7+cfTgSmpO0uwIeqOU4qm5be2sV1DJ
 E2vj9r/NSygddFtd4ZQAAAA==
To: Vinod Koul <vkoul@kernel.org>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=rVRf9n1bFnXgcGWnl9warbbpA8WJWg1GWzSYHcOBEF0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmhSTh4vNh28srE5LybUlslx4pM9JAnEQM5PQHj
 jj/t4OlYayJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZoUk4QAKCRDBN2bmhouD
 19DWEACDV3MRzK5iIKIoPiqXrVovBLjGHnXr+WtQcAuAHt+JTG+TlogroB4bLtm9lZCwjz3nkkM
 ZcSupxjD4d11w2qwV4vaUney+SzbwnwwTsfC5cfkEcy0IvWnAb5mg9jC73mBR/v0IkttK9Imwys
 rOMFwwOravADKKcfGX59/gUg3XZbTt4fHtr8TVXIqTGXdyauW5JQuIn3Son97SXrSa6vWt3q+Yf
 V0fclztDuT0+vcQQwuezNry+5mrZZZ2lMEOF7X4jtWeXVioAXVxlOUjyhvEiufxfa9kVLxyT36U
 aRi4kqYzpnIvGTCyDIehUJoUhTnEP53yBP8ouybuNyyrWrX14wbTEL9zYIkWjyz52EK/ancJIWi
 fz2ltZK8CFciAhskExjJfLBYXZhaU+12qNM6XRdVQylHHqLk3JFHMwWyv2RxXgJcFlr1pmeOz7k
 yIuNxIxsNhXTLKiJ7iroz9nlYkQiUpd6AREmxFshBYeqQc0tMfc80M1fuIMu00ukTKg+/4uJqAR
 IXzD4L/UaafnGKHzKE9RfouxSLqwPar02lITaC3kpLYQV8op22EFylp6qra8+h+aIHXsQmbiqTa
 dkAUAttjkf3hC8377GulhB/NPX71dfqYRQbg7dhVy7uIo2gQpn52CwOOJjntw1lBBM+2YyMqW+z
 tKhM1vgxwI+xjIw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Allocate the memory with scoped/cleanup.h to reduce error handling
(simpler error paths) and make the code a bit smaller.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (9):
      soundwire: amd: simplify return path in hw_params
      soundwire: amd: simplify with cleanup.h
      soundwire: amd_init: simplify with cleanup.h
      soundwire: intel: simplify return path in hw_params
      soundwire: intel: simplify with cleanup.h
      soundwire: intel_ace2x: simplify return path in hw_params
      soundwire: intel_ace2x: simplify with cleanup.h
      soundwire: cadence: simplify with cleanup.h
      soundwire: debugfs: simplify with cleanup.h

 drivers/soundwire/amd_init.c       |  7 +++----
 drivers/soundwire/amd_manager.c    | 13 +++++--------
 drivers/soundwire/cadence_master.c |  5 ++---
 drivers/soundwire/debugfs.c        |  7 ++-----
 drivers/soundwire/intel.c          | 25 +++++++++----------------
 drivers/soundwire/intel_ace2x.c    | 22 ++++++++--------------
 6 files changed, 29 insertions(+), 50 deletions(-)
---
base-commit: 246cf92bafedeea46cb16964d16478d6b68f8e5a
change-id: 20240703-soundwire-cleanup-h-a29941fb3dd4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


