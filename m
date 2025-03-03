Return-Path: <linux-kernel+bounces-541640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5845A4BF66
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBCE01651A1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D64420C489;
	Mon,  3 Mar 2025 11:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UshAcp70"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC89220C02E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002792; cv=none; b=G8IiPhnODLhsAFk91bW5G+GPUluPDyFJAgO0pF+qROaWGvPfjzghWqetxjNjKX6vURujmZNNw51gflq61xFAxU15jP6D4bUtYbgSLV6E7+dELZnS3fiU4VGfRPSwDEJHw2b0mZMpBo6JnVyE5a99NNe+WxNP3rs4363wVm1ytM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002792; c=relaxed/simple;
	bh=weuzDKCsQiMr3iqm68yFLz1cNSwdbqWoaxOIGm3Qv1Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mlJy5Os6tOqf8P45jMp/lSmtqZqNG0p8by3O8byNEyGhurbovdECRPjEgmWj2/3C1Ho5xSWm3zt1vQqL872lex8ybT4uP6XsUGmXsZ5YD+M5dmtOM95WVoRtmX4+ypVABRqMDqhsih2rRIMK9a4oXpJmOoBfLqJiCSi/MvgYlTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UshAcp70; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab78e6edb99so601428366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 03:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741002789; x=1741607589; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yFk+AUCXrKYMFB3jOa4VTmIBB7qGuqY5Tz3fdWlt8X8=;
        b=UshAcp70bwLfueH9nQU4muj4dZfypc+TVIiBCwvARiyGQTMstAhK+bg5aQm6zCbylC
         3VRUuzd26k3HJG+y4pInEjxD/RFGMM46J93wdtQB3n43RfCDy5/qgv/+t/yZTfe1WpOA
         oU/nXM/Mu5N2GSeexZIUpMbl8gs1L8ZAVBhwb+5g+HgcbeaUuNzwqpflt7T8iSKTlzNY
         DCx5xQp6Ii/vHUz54glYaOS9nN/ODF/lPZzfWQZVUs3j7C6+744DQxEOS4YKrF7gacxp
         6vWZupHktV74iEzh4NBlHRY2lC/PB5HbwCpKAjrH2yMyujbps4qAnTOTgQJ/AjgnVT7t
         wW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002789; x=1741607589;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFk+AUCXrKYMFB3jOa4VTmIBB7qGuqY5Tz3fdWlt8X8=;
        b=O+2YrTTmXDTcr5HQmhEpm40sAX2pqX7dEkadVhu+r6OvcdsCxy5w/8bmNIwOszIxQq
         RvjQQ3wdZBQxjDkh/p7tDLVfeQ9Lxw1jq/s1ACaR1N7gA8YJa/LJiVqTSDSFbqXK6tGG
         +N3OrfgdXl1Qyz/2+hCP8YOYk2M/oy3/kgUNuM09kSqSXgWWNA8qDYeyJhx6jXo+g5BM
         TKJDnP7q7YkgzdUcbnJdLVAd2OjJJQyjnMq30Ww3rWd86tvcGlw2eor5GLTTqoACVLEN
         8cJ/JJLttGjlMZGtErOY+vguOHr2g+lySO14mWkit2FuvpUeLH3iFcL524ti1DE3GCb1
         EcYw==
X-Forwarded-Encrypted: i=1; AJvYcCULWHtrfBqfj13K5gGhlCtg/bLzxwEmE0ZQkKhPw9o3qAu+ivD4Gm+fkT3MpXRfJAmEcN1G3qBiTuY7n60=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT4I/ORlOgWhyNWRDwCb3ZY2IKCS+poJ5d6TuQmhBzQ0SOAKAh
	N+oCgGTPD11Dr9XKsO49Mx0U2FNW8xwPkcjDbztcpbc+YGnR9fy1AQl50lRVNgM=
X-Gm-Gg: ASbGnct0qMFszYk+sWesznIICWY9fioxDlAKYtgUS+Rdeyxvnbbiq2fpeFHsNhYXIUl
	iChL1BF3sXSzc0RBnKAVycLRvIghMJ13AUUNcp4uIJkeDYFDZ5Y47rScbMNuQHiQZPoMRukkQn5
	9+kxd0X0DF35p+7jVRzKlxS/sKaZ0LE1lKbU3lCS9rI6I0qj8K2nCWVAMvtYRd1Axhj/RjeFyMM
	LL/khuOTGO9RD2d0zuiE/L+EADQ8x5zYsHqjnAqd9GLyWDKi9+IxXO6Na2D+OdE0Yp2EoXw1KDK
	ujtqpqdCicNvi+HXyU5aAaJVQ0LXNuYyGJF3tfKJFJU=
X-Google-Smtp-Source: AGHT+IFEhX0K2m/xxoCepy05vSD+L8QdDqMDgYEprV1OF5Vyr84x+ua4osWWJ20v8KKeG7laOTv8/Q==
X-Received: by 2002:a17:906:a389:b0:abf:486a:5e0e with SMTP id a640c23a62f3a-abf486a6354mr945646866b.22.1741002789119;
        Mon, 03 Mar 2025 03:53:09 -0800 (PST)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1de83fa49sm86833866b.158.2025.03.03.03.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:53:08 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v3 0/3] leds: rgb: leds-qcom-lpg: PWM fixes
Date: Mon, 03 Mar 2025 13:52:49 +0200
Message-Id: <20250303-leds-qcom-lpg-fix-max-pwm-on-hi-res-v3-0-62703c0ab76a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABKYxWcC/5WNQQ6CMBBFr0Jm7Zi2BoquvIdhUWGESaCtU4MYw
 t2t3MDl+/l5b4VEwpTgUqwgNHPi4DOcDgW0g/M9IXeZwShTKmMUjtQlfLZhwjH2+OAFJ7dgfE8
 YPA6MQglVZam2tXH2fIdsikL5uFduTeaB0yvIZ4/O+rf+5581anS60tRWVpErryN7J+EYpIdm2
 7Yv84jMGNcAAAA=
X-Change-ID: 20250220-leds-qcom-lpg-fix-max-pwm-on-hi-res-067e8782a79b
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Kamal Wadhwa <quic_kamalw@quicinc.com>, 
 Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1832; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=weuzDKCsQiMr3iqm68yFLz1cNSwdbqWoaxOIGm3Qv1Q=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnxZgYd2y1ePd7e26DC8gF6jUr1+KlcJIjfd8Rr
 zgdzdceoH+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ8WYGAAKCRAbX0TJAJUV
 VkIJD/0Q409NWJSNEHd+fCoQUYi0dSBHe3lxpE/IltreHBhmQv0actfrY25E4+jsyQgnRmejHuL
 xXae9PGPduXBbUH6+311xQazz/EcbttQuBeKA6FAjMW7hPohIzKojja4+D45PAzsOEq19tGjDca
 V/hep0WSJLaQfQ3CidSpene/fo3civL7WpPhfvZcWy9EnGLwBiczgy6hp8ox7BvBqENxEYu1znc
 Tjc096J++kZLATDklZ3oCwfiV++d/uJ4ZPGnW1jGGYgquNWNNTp//joJ7ZcbosTZsIZTZi8Co60
 QzxLrla/Ivm1+gqj1dw2djEY5zcBPQwltu7aEnl8ko488C6TgcQtc0TS8QeJhA/1A/Rz0NAnYCh
 eTWS5a0tMeUJfIbjN46F2Nyua1OpZP/d1pwSNj/jwHfamKaf2odzjwKV2C4Rf/3ksuucDdDwYmu
 Q2migLWKqqrbmwLq09xAFlYwXMDb2EoL34zT7lLpKUEYXmZFxR8E3i/JWpgxswPn1eP0rT+as8k
 LxSqfhNfbudOJwoAU/GCpNCnd5rw7tdkAejXR1bqqSu4XQ8XuYb3kiaakvdq+JwJ1+l1mpcShOd
 ROxTRZmNbPv31Mg64AQsmaOl0jSUjMrlfSf3hilAlAX2GGU1WkSRILclJP1GSekX5C7Me/AjEpS
 OF1KY1ALG6rJnzw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The PWM allow configuring the PWM resolution from 8 bits PWM
values up to 15 bits values, for the Hi-Res PWMs, and then either
6-bit or 9-bit for the normal PWMs. The current implementation loops
through all possible resolutions (PWM sizes), for the PWM subtype, on top
of the already existing process of determining the prediv, exponent and
refclk.

The first and second issues are related to capping the computed PWM
value.

The third issue is that it uses the wrong maximum possible PWM
value for determining the best matched period.

Fix all of them.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v3:
- Added a new patch that fixes the normal PWMs, since they now support
  6-bit resolution as well. Added it as first patch.
- Re-worded the second patch. Included Bjorn's suggestion and R-b tag.
- Link to v2: https://lore.kernel.org/r/20250226-leds-qcom-lpg-fix-max-pwm-on-hi-res-v2-0-7af5ef5d220b@linaro.org

Changes in v2:
- Re-worded the commit to drop the details that are not important
  w.r.t. what the patch is fixing.
- Added another patch which fixes the resolution used for determining
  best matched period and PWM config.
- Link to v1: https://lore.kernel.org/r/20250220-leds-qcom-lpg-fix-max-pwm-on-hi-res-v1-1-a161ec670ea5@linaro.org

---
Abel Vesa (3):
      leds: rgb: leds-qcom-lpg: Fix pwm resolution max for normal PWMs
      leds: rgb: leds-qcom-lpg: Fix pwm resolution max for Hi-Res PWMs
      leds: rgb: leds-qcom-lpg: Fix calculation of best period Hi-Res PWMs

 drivers/leds/rgb/leds-qcom-lpg.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
---
base-commit: cd3215bbcb9d4321def93fea6cfad4d5b42b9d1d
change-id: 20250220-leds-qcom-lpg-fix-max-pwm-on-hi-res-067e8782a79b

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


