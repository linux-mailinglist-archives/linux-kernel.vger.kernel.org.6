Return-Path: <linux-kernel+bounces-429080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FED9E18FD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF78FB3AB40
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382AE1DFD96;
	Tue,  3 Dec 2024 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="cy4f+sUj"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FBF3F8F7
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217593; cv=none; b=bHkUDdNCvITZLooaJfirxf3A55u5m4S3B6fWOv3DdElFE5w6OlYjjrvbc+w4Ip6AdbJUxHNFcu4da+/Q82qwUDvbVfbXX+7mSTEa9s+cU6LzztPgfvu2NAFkEVinXo0wD32nrDc0lF2mIvJGfjVHm/9kEbwIBBPv/dWAJ4a76D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217593; c=relaxed/simple;
	bh=+RUkhSp74pt31GI7QEfwoh1/meW8bvxnwhCmfShcZDc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fPO7ZgifQ1hATIEUJlTPfJyKngNlA6ADkDz3jmUcqiKMdufwvZEtaa6/2vOsQo11yQLVdxjeM1AUPkjMfJcav1KsgRfH2WX5gPZOgCqOC7Al9i5kkL6ARnW1TEvfojCcxP0wtgENL35ibo6jL0LNIZTMj6YQZQJxazmuaIaVkvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=cy4f+sUj; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ffdd9fc913so54829151fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 01:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733217588; x=1733822388; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CC9LNLFc1Hh67gjWV5vx9a18ct4bVImqOXc1JIJKqZg=;
        b=cy4f+sUjSjWYmuhKK9+4rP/+hrxuWrb4EtDv+mvkimG1Ys83MTxbz/kukQQ1Liaefs
         vCBS2uxC9omhO6/FRUIt/B0o8yC+OwILZmhbpC5vcPlJWNhKuZQpjuYDwlORvvvYUGqg
         /BPXcNx02RYtSi3eBIBpHTn9t3dB7Fm1YxPwZpn7Hp1ap9gQOSchvzB83WK68reLpUuL
         dwpY2vcIZ6pYFWNH+yzpNwDyXAwPZBtOQ09yiuDqbRP0QEUZHXuUbwuiJp2o38Y8Gq8U
         O3QW+GhjkzCBBPOVST26Bxm/ZOlkZKX02yRydtShCQ0Xt+/5QnVqWK+4fwalSYQpIfEb
         oLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733217588; x=1733822388;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CC9LNLFc1Hh67gjWV5vx9a18ct4bVImqOXc1JIJKqZg=;
        b=uKAhMqEyBrSZX5UWVXSMZqHu0Xs7GeMlT3Th7vp4UyLiIC/f14srU7t1YNwfgm7Rxm
         YEbdXkHYO91NGlQXsgTUNXpVIDC/9KaNNRNzoHUphLa6RzhFRbq8+Mt+VWp24wO+6h0e
         covzECrH9aVdto01ZOm43AZv3arzzd16RVGz/Ee5XENAoZDkFDE103tEGQt/4PnOV7dn
         933c9F1L3GEHch0KarUaGyjLNGkuGyx44w8kxASYbOtoLKfwcpjU4zk2SSL9A+s5WbaY
         HQJL8EaNqkO6SdcHHpWuygpMc1w1tLhATTOpizwg512Bjd577wRanHkfmlIBls32MFGY
         T/mA==
X-Forwarded-Encrypted: i=1; AJvYcCXKryJyDnnD7wVC6YYzf/9vyEmucWZuzgkMcO30nLuOeif3PkH8+YquZgBULYTmt5fgHGQqRyaXdVdD7WU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7cbXdCu2gevJLXIiS1y9q6CRXbjQTTye+mCVpjS2srkYqGacX
	2bbtmxyW6JfPyU3f1CUP82fNRw3u71SHLt0F+J89XdQ9YArlq/wigCAXJCur7OM=
X-Gm-Gg: ASbGncvwUonNQZKBoQgFgOObPZeTzfVyuUOMNoFCbe20qqOKIt+lQl1sPN2oIT7bJtx
	ZESyq4YKvkNP06vHtlGvskJhrnHmo+7cEZzu+ZyDafBzyDjb+hsDhyPWzFdDFr6zzKdCOQuPAam
	Z4cyxRoSYYpKd9mS/+VoXREegvvtDeKq9kaC8YCCew3VE0wVJIbKyHyosIhpY5C7sR7fv28ubaX
	I7IdB8nzWqqDnDo83QRno4Z9Xn3ReNTM6MW+PZat/fs2/nnd8g+oc/TQftaRT3D4VJes7hym3Yo
	UOnBaWE=
X-Google-Smtp-Source: AGHT+IF+pYErz1kpD3eIIL5x4sUIrRIiDsWqlvfMTbuZhhsoChxhFgBLXzN+QJSiFdHDv6SmgVXa1g==
X-Received: by 2002:a05:651c:2114:b0:2ff:a95c:df1 with SMTP id 38308e7fff4ca-30009c0d858mr12308381fa.6.1733217588457;
        Tue, 03 Dec 2024 01:19:48 -0800 (PST)
Received: from [127.0.1.1] (217.97.33.231.ipv4.supernova.orange.pl. [217.97.33.231])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbb915esm15591811fa.19.2024.12.03.01.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 01:19:48 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/9] crypto: qce - refactor the driver
Date: Tue, 03 Dec 2024 10:19:28 +0100
Message-Id: <20241203-crypto-qce-refactor-v1-0-c5901d2dd45c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACDNTmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyML3eSiyoKSfN3C5FTdotS0xOSS/CLdxCRTCwszy9TUZGMTJaDOAqB
 MZgXY1OjY2loAwmn4e2UAAAA=
To: Thara Gopinath <thara.gopinath@gmail.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=+RUkhSp74pt31GI7QEfwoh1/meW8bvxnwhCmfShcZDc=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnTs0vT2Q2VlnO/jIG3fZpQwI3Q0yjeNlv2gNCq
 xzoBdmSemeJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ07NLwAKCRARpy6gFHHX
 cp/nD/0WCGIDjIpD1NFtXulwrj1wA0XucQewSAWAplsNUDPNn0CNPa4BkRzhxoiBFf5+tS15M2M
 lPGMGgrMhiZa0CLexY3xvIHNDPNRUr5Zb3JVDav1fCqxEubeNODjtiiKiw+piuNk2AF6djuc1Ln
 dZm6A4r15cbXRLqAB2cqYabA82OH0R53A7P79B339FNTkt1SfHJBNiZ+c5QG6EvIaZgwdrwHXwo
 AINH2F/QmfrE+lMi2qE1knd2sOIh9qicx8QlVzH6cvgmc8MzdcfJjKXMFno75Dg0BLdEjH2eTNU
 FcipUP5frmOFb26gJct8damAlS73BhIdBlQMq9JELarIWcNI+IvApci3kgwtkv52WEYAECwQ6ha
 RSktu8EjLazohZO7fnVffs8rs759oZCGpbCJoQ1PpARXWiNYXBgATwo9cS3XzxM9REIVZGWTt4T
 iyT6CVBY30k8pkMS+CI9zxs7Lxqh3br4ZiLPg1cgdDRoF0sivBkND82jMtn5vBk2hQpNWVG/KDH
 EkrgKGtAMHd/bfVQwREmjjqk49m8g/bPCkeC1w30XScsbOWH5AunokWLf0UvHgG31vGqpG/cn1e
 QlL2D2QSf02UCjKwfWIUAyTiluB8HVAs6LUHO/8E1Z7wvGgBmvCENq05he3EspxmQkRHE4aaX7p
 ARB1UL2sixR893w==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

This driver will soon be getting more features so show it some 
refactoring love in the meantime. Switching to using a workqueue and 
sleeping locks improves cryptsetup benchmark results for AES encryption.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (9):
      crypto: qce - fix goto jump in error path
      crypto: qce - unregister previously registered algos in error path
      crypto: qce - remove unneeded call to icc_set_bw() in error path
      crypto: qce - shrink code with devres clk helpers
      crypto: qce - convert qce_dma_request() to use devres
      crypto: qce - make qce_register_algs() a managed interface
      crypto: qce - use __free() for a buffer that's always freed
      crypto: qce - convert tasklet to workqueue
      crypto: qce - switch to using a mutex

 drivers/crypto/qce/core.c | 131 ++++++++++++++++------------------------------
 drivers/crypto/qce/core.h |   9 ++--
 drivers/crypto/qce/dma.c  |  22 ++++----
 drivers/crypto/qce/dma.h  |   3 +-
 drivers/crypto/qce/sha.c  |   6 +--
 5 files changed, 68 insertions(+), 103 deletions(-)
---
base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02
change-id: 20241128-crypto-qce-refactor-ab58869eec34

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


