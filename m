Return-Path: <linux-kernel+bounces-401267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F489C17FB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A633B284313
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31F01DF723;
	Fri,  8 Nov 2024 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LsdUpsdb"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B821C68A3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731054699; cv=none; b=Eod3TVz9v8sSZqYeVsli9+LfGL9pi7EW6p5hKERA9Esm7d3wwU44Dx7FZjfs4a7ejpPSXjC/l++Ge+rwAoxwepHIF6bezUz3G+YDBgc+b1vYtf1zEE8gedQ+bZ+jIdAmmc2BqdpmmBU+JN887BoRni02axyT0b6BxrPf1nsJMQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731054699; c=relaxed/simple;
	bh=fd79AVP0NEtKFNsBkKcFdlWuoNK8n9iFc6De80oNWbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iTg7gdmt6YZP9qdo2WmT6tbsLY7QxWbPyU21MWqP5HhvPfOYiV8hB69fI41wUwcNyy/NYChWd9X/cizdDx0KXDP6ZfpA4HwolHQXC2hvI4A/mwCLKedB1ILyugU1eTvbPP9SGSSX/2rkVAg8Jnn49v6J+nfMj8Wjo9D1ECvKwHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LsdUpsdb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315eac969aso10802285e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 00:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731054696; x=1731659496; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUkgaqwyt5Dlc7iDZVCwHIHNWekO6hntBT7gAU7XDeo=;
        b=LsdUpsdbRwE7Y8Vj17wPzsFGMIrAGTGsHV+8BA35Vy2eOIAxsoz3lx45cOVGLFJHsq
         J495XO2moMWeeGIUQeRDLsMtjNc+SKhJTMM61qAvgxPQElLQpKZm8OhKF0x47JmqN5Uf
         NN8fVCoV8v0WmdebPFZ52cQu/mEh+Lg7ZwXgBB6VmPkexIjJa5XcIEiIGjRb8gDr7fqr
         hacGzxRLzn+fkyK/F0d7IdHppV1+dpjudUOhCcje9VLjo3ChIk88koNn7KzDTLMKioSR
         O9ZXybNKTMrAWg/WDK22z9Qy8McXtlLpndwabSI4BIbqtoOwbc4o6U4e6NyYXcRqjRps
         geWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731054696; x=1731659496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUkgaqwyt5Dlc7iDZVCwHIHNWekO6hntBT7gAU7XDeo=;
        b=PEGK88taauoMjK0rUlvze9hjjRCZHehONC9+sTDxR+Kg/FKzg+yNP7Uuh8mwD2648V
         RDif1Z9bKPjDOw4J9eouHaXNaOn/Zf/vH+3E8yVF8bfiWq99WplXyeRuq+Po35aeIcxt
         epighByrAWE/bcQzKrA8VXzQZaaKORciCJrJeZc4wE8ejAMd8sYdmVAwf4t2J37Adbee
         DC/2MaP91RmnZ7JS1VAzJI5CR03FrrXMvvyCAbDkkiNmQlBq6v4DlYOXfYhMeLUSuW9a
         bObzPn8ex0ort/eH32tDZFjM784YjYEJy1k9EvMNxllNNSiD1BCKfpc7NrSXJnCBZC3n
         EOeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpHybkUxXM5OKipIvi1iuO9Pu7xHyI9Z+ZHMcoHGNRUFY5iCYGWgz908dl5bXZEEywdUUTN9NK/qWlm5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3qm9+7JerCNAG0c/PD2MVNfvrKlsW9BvQ4JK+LBhRYH2kqgVU
	9WuTPO3yYp/2EWp0q77tXdcbNna0p477IP1aLSZlhLoEuLVvnlHUuT5Fon+Q0cA=
X-Google-Smtp-Source: AGHT+IEsoJ3YYVkQUti7IVhr3Z0+dq+6Xl3WZ+t4JLD73b47E793gKcg9Qge20p3M1HTDRIVWOPK6A==
X-Received: by 2002:a05:600c:8716:b0:431:7c25:8600 with SMTP id 5b1f17b1804b1-432b684f31cmr21029305e9.2.1731054695706;
        Fri, 08 Nov 2024 00:31:35 -0800 (PST)
Received: from aspen.lan ([154.14.63.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda04ad0sm3876370f8f.100.2024.11.08.00.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 00:31:34 -0800 (PST)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Fri, 08 Nov 2024 08:30:44 +0000
Subject: [PATCH 1/2] MAINTAINERS: Use Daniel Thompson's korg address for
 backlight work
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-new-maintainer-address-2-v1-1-47c9d71aac11@linaro.org>
References: <20241108-new-maintainer-address-2-v1-0-47c9d71aac11@linaro.org>
In-Reply-To: <20241108-new-maintainer-address-2-v1-0-47c9d71aac11@linaro.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Daniel Thompson <daniel.thompson@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=714;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=fd79AVP0NEtKFNsBkKcFdlWuoNK8n9iFc6De80oNWbo=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBnLcxJf2uFCuowNCWEnRWy2nCSehvg0Xwgx/nW9
 BdgbE2FM42JAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZy3MSQAKCRB84yVdOfeI
 ockoD/0YN1BMEfZrSdBx9g+VGHKLAC/CE6SHaG24UkJMt7C95zghZSCaEiC1Ry6vxYBl0s3bL/e
 K7pkCn+qCOnR2EaETk5R88qB6cTezKUVUSJn0dbAQcJfAE7sOYE3pocEJPPplr/4g7tDlbNxZRb
 yPxs4ZYM3cZu2IBHNfmpUNZnr8Iav7nH6t6XPreAVYZYUCWdEHbN3RC6elzP6IA6K7Z70WaKftq
 L2ieguRMwpVuBJsqPSXaBinsxiyfuxQrusV3teOy6iNrGAcAJjA0T2SY3XgLNCGm+5fpTTT6clm
 4AJOF55j5WGRxR9xtJpc+23RE/VEV4AAlEEryLcfmGksA/MlqK+M5kIAhPdhTr5KzQxT7z5Uj/q
 QqnPNwVgIpjkHrAyj/YzHWP4rvgPEQkwbewq3YRAUlzkjOiqfJfeqwTgQv3GXXrz1yQfl9M0/d7
 ri1h2/oGGwm3cihv93r2Sl2fCBdOgQVpC7SxIqdb8rQIZtJbfCVBB408vtRunWpz5jJzuY8OwEZ
 oGGGsfuUE+q2jW+Pc7lCtYNXRQHxN/pk9T+2R4ZkwMM9BHwYUMtqFvp+8E7PznL/gN9obZsRnIu
 x4diqAib4mo+gumVXtHGTiViKJyTCdWqnbAH0xBEIsnPumjXj8S6IBU7QlCN5FUmLSveuNiIq+7
 6n/tsDwvxxfRgrA==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

Going forward, I'll be using my kernel.org address for upstream work.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a274079502426887da55d55b83b9a17e74ec6b13..5396fd1b15aee1eb2a234ba8963c57571d532a91 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3790,7 +3790,7 @@ F:	drivers/net/wireless/broadcom/b43legacy/
 
 BACKLIGHT CLASS/SUBSYSTEM
 M:	Lee Jones <lee@kernel.org>
-M:	Daniel Thompson <daniel.thompson@linaro.org>
+M:	Daniel Thompson <danielt@kernel.org>
 M:	Jingoo Han <jingoohan1@gmail.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained

-- 
2.45.2


