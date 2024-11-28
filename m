Return-Path: <linux-kernel+bounces-424527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3DE9DB560
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37E3283893
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28DE19AD8B;
	Thu, 28 Nov 2024 10:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NkDWXMtE"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255071925A2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732788487; cv=none; b=NO+S5GkLZNJWcBR4PPQf05XTlKkYW+BVVtCrcO+MTpLlzqlX1PwIO8ILq7v2oMnqE9k//pntaNmkj6Rz8G1Y6XmhbOJOcjQTKREAHmkUfWufpAOt/ZUVmgvvZ/y/Gzu6/VBky0soRA16zpP/zBHRc+w+j5oO1l9ScpFJaolVrMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732788487; c=relaxed/simple;
	bh=8skcluPb5KySGbl1QWIwfG/p2EUmL9ffmC8AK029src=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NmhNbRH4BRqPz5PRSL7wxb09QgFD/bKTXeap4k7quYbpM7UFfrXN/xidzHpQr75Z5YXXhJQFOFu+toEaDVDUznxku0QeFabgdf9krkOWGE/ZTM0TcEnBZoX/TDk1SvBG9hrqhylCH89+ood0KksK8akx5a9H1lL/8xdfuz73FIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NkDWXMtE; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-382411ea5eeso372639f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732788484; x=1733393284; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ng5DukXBHLhyQt4qj69S1LcwJvUdoL890VdhX9vWftk=;
        b=NkDWXMtEiEgkdf2nyciQK+m929XqkDiGznG4NGaDR0d0lXIYdFrSAu5MRnKpJE13tC
         mgeRc2IQtYfZoTg69wx/rXysL0mgd7IRNYJXKOPq0/4Tp0AZrIXrshg+Wjaa2l8vxtpQ
         U5AAYFgCiHdBk2XyPJN+M7hyg3unBiHbmymq0cYoUn/IxmxUty7s5qvuSrTuKjh7EyNl
         +phzP61SUbrXVMrwycmaMsdPoPxGsRg6c2gC8ljJHkx0p6izNXByFy+NMcwn/TNN/qAU
         gVQe0xEuVhRF4ad6by/kCbHNp3bJHu/0wF++bAl6wEuVyOCsUB0bhc1qxmD55+/VtyKm
         EE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732788484; x=1733393284;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ng5DukXBHLhyQt4qj69S1LcwJvUdoL890VdhX9vWftk=;
        b=XEEEuD1dQaZxSdYBr3nwtDzgzTEJNyd1b2pxleo2zpHXyGJoYxhqRMRQLl/+5PTkpg
         T06W4l/n3Ki/KN5dKs/GJV8RPoGcaY8gx2/WqCcCMPBzitSp432aV6HMCBiTvGgnnR3G
         dUJ5BlyfLxb1Ml8UovhiNIuOGpYUJDC4lOFbM2z450iqwhOTP3IFozfauI104Dp0Oh/Z
         5tRIkFXSsCLHzXI4W2zTDQQl7LZsfmVlE81QQQjFCZLRC3uErWHpXiFMSZlJF/6g7Gw/
         krVwvZBbtPv+em402a1aet8t8xznW5ScuvEQcoTRVDSpedRNE9cgZ2VIILhcFOyyUM/g
         SuLA==
X-Forwarded-Encrypted: i=1; AJvYcCUvnw26MXR5AWIUbR0siyJIRnPCfwwVd81f3v2m/1lUyZ6lsGm2LmuWKmBkGh4MG9IwMBN6xMo7wzNI9LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOv9dFJyXMliTylnxx7en14CC/Hb+qiciASiW0GEOcl9/rZZYx
	AtHPqOl6Fg8E2sOe+zIJitVXYihVHAWQNv5ywPCUfxikdWa3BIp5S52cSSxYBKg48j9iDwwCduO
	Y7nQ=
X-Gm-Gg: ASbGncsxrukCEQ3dMi3ihFtoGedmY4EqRhQW2YOuDRxuxqU1KiKoxUgu259IqwhSkgG
	WEhtHxyWTUY9/AjCUKqbzBfqpl9rAVWkWMscvQYMbIE1WOZpMn8BgGZLGFLih+dZXJAnPvXbubA
	QEfPMIf2J3yrxt1cKZkL5hH8PI+JRQIACrLvqg/c5lndpo3IuVlLpCzEb1ndqUKD9x5Ges/iFun
	Z0HOdjUG7ZvgXhbcyKdTHheQ4EcElK2d+uJOqbn/tpR+o4KNuLnbFLBe97zYf81yZR3LH8=
X-Google-Smtp-Source: AGHT+IFKf4bquwdhlK5RF968lsp14oLZ3x72nv57uo5+eQdppr+kvS8nrDbYelTP65RSzlcf0ARkng==
X-Received: by 2002:a05:6000:156b:b0:382:4a94:af0a with SMTP id ffacd0b85a97d-385cbd80afamr1624339f8f.20.1732788484536;
        Thu, 28 Nov 2024 02:08:04 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd3a56fsm1230335f8f.62.2024.11.28.02.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 02:08:04 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] OPP: fix buffer overflow in indexed freq and bandwidth
 reads
Date: Thu, 28 Nov 2024 11:07:53 +0100
Message-Id: <20241128-topic-opp-fix-assert-index-check-v1-0-cb8bd4c0370e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPlASGcC/x2NSwqEMBAFryK9ngYTv3iVYRax7WgjJCGRQRDvb
 uOy4NWrCwpn4QJTdUHmvxSJQcF8KqDNhZVRFmWwtW2NsSMeMQlhTAm9nOiK+gdKWPhE2ph29G3
 vuaOGhtmB3qTMunwT3999P6bbqBZyAAAA
X-Change-ID: 20241128-topic-opp-fix-assert-index-check-f46fe5c3c7ba
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=882;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=8skcluPb5KySGbl1QWIwfG/p2EUmL9ffmC8AK029src=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnSEECgem8wGWvZixDER6uQxG0aoieHbOCD2lak4Ku
 4W8PvaSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0hBAgAKCRB33NvayMhJ0d7IEA
 CM5+s+4EId7Zw8Ltfzi3AtYBAj0B0f5Sulbl77DwW+tCeIAKgBJb085B1kLM9wmGHqMq7t8w1h2zLi
 /TxHWmZ092rTpCpgMuXwxuFExhpSP8zhOQWGHS2SYtBevFxMvapQfGCDxyCarVjmK7hxs8+QXJQvJ1
 xen+UBbzNMkP1KNFeS0FBZ8XDB8xZMULtwmOf5kuFBNbavVc6+64NbCJWPXI/vsJi9RghDoocb7JgW
 vCXiEBjM1Y0adPsLsr8oPJwNr8zp3cq8VX1CETunnxbGN5twd3gBs2GB9pXUYSuttiEemnZUsH8PrJ
 FsGKrWzAshiiSNTElkaf2vkG8v6CWiMhBR4aozEtO1m5LuSRz9p76FPaTQNcr69AtJHztuCngvJLHK
 tAMNa2s1g2NXYxWP7kb41qNZHpsyFrCHoE/n235CFNIr4wxrlxHqcRM3Qy3bDB1SlNexOWbTe9MOAf
 Qoa03iozVAym5uweW4SYrVix06ZOoCxBqYdggEZCBQi/yDpMQE2DRBBncY2v3Xuirr/fqGlVzBGq5Z
 T2GedGzAx++0oh9xsh+/FlP4ziAWvaU42I1JOUTWycr5OHH734W/e4MTqdxorltrImo++/aqb+s5xk
 k8w8qIHvv7FfrWeJ7BpRee3HMPBc6H9kk8R5GILhd9t4yRXtu89dEVMFNzJQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

While fixing a crash when calling dev_pm_opp_find_bw_ceil()
because the bandwdith table wasn't initialized, it happens
the index is not checked aswell for indexed freq finds.

In order to properly fix that, pass the index to the assert
function and add a specialized assert function for freq
and bandwidth.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      OPP: add index check to assert to avoid buffer overflow in _read_freq()
      OPP: fix dev_pm_opp_find_bw_*() when bandwidth table not initialized

 drivers/opp/core.c | 52 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 16 deletions(-)
---
base-commit: 6f3d2b5299b0a8bcb8a9405a8d3fceb24f79c4f0
change-id: 20241128-topic-opp-fix-assert-index-check-f46fe5c3c7ba

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


