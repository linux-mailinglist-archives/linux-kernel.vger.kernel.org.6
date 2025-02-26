Return-Path: <linux-kernel+bounces-533638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AEDA45CFC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9DE1891E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C91B2153D3;
	Wed, 26 Feb 2025 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmiE6386"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204862153C3;
	Wed, 26 Feb 2025 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569190; cv=none; b=HKHBBU0/uKOCpBFrJ3p0U7LwKB/jyFJR/l57msWQIwB5p3lfm+UlnpmVYHgidhldxqzVvHw7Hz/ri6oRJ/xpZ8r8UKHKGzkw9VWl246TV30vWsJ24hwTo4L/0TG+2KUhfyry0kZH0RGp6MBmi0uY4iFIyj141y+FOzmDO+09GUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569190; c=relaxed/simple;
	bh=QJf+HQZVegvutXbd299woU0Z2/6qbQLBVtIfCFcaGrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChVTgZP5xqUAHYH5Kmc13rF91U+FJun9qOgEvJvWFHl/AYpHecSXs2pCTLTjb5nQdJVnOWKT6INwZ0WG/zEd5SVYH8gTl6Zaw2N7BNTwr6oQUDre3WBjrg2H2ZsObpn9qSWxlt+W/eFi+RVLfjF4krHncIGCg1W4oTQgBiXTjrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmiE6386; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22128b7d587so130557165ad.3;
        Wed, 26 Feb 2025 03:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740569188; x=1741173988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RTmpIGHngtsSZ/WnYi/gqVccUnJFm776Qa1QJJB2Nw=;
        b=jmiE63865pLWv0hg6wecJqi+62YJdMRmaoJUHgH48J0igNegqtSHYj232varVyzLWh
         WXs6/zUoHU28Ng9DEgs1qoC+ThRFEpWXjNWmy0mKRUpcHLqB2CBHimOm5TqZTxGCvNzu
         AUaQxls2U6yck7nvBMa9SQ2I7JWRy6uZxp+xzrETdekf3/3x+t3vppfVDrEHL8YJXvLb
         3PHyXcBiCd3BTIjQ9CoV0oRnYT6zTvz4P0CqVmlDF5IBbK1Y56sBcsko/GSVCeuT9N5V
         MLPvkH847RJ1BLWJkyZ9LLSypQLmqWLjYvMfIcJ5TaYcX4hQBGl2FICb6GYroK2JQ7eW
         pY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740569188; x=1741173988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RTmpIGHngtsSZ/WnYi/gqVccUnJFm776Qa1QJJB2Nw=;
        b=vwvK/T9tzlIJyAMdyRtWNl0jto0l9por0bFBg/+C0EEDptAIkolom9ghH0zpG1ZYwN
         weIs0SXYRIzMsSWlhra5qX3M3UeeaObvatwkgQXnoGY3zc+3VsaVwW0pMfruLXgkQYlm
         bzAxhX8rrUqBFtp6kICoHPNJt14QazECtqlz1/OtNVUEEmRwkDHWJd/krKJHYwt3JDP8
         gYLKmzIxT5t93FsQMwKzK8AzvaPZbmimcPoKpEoqXrQCk/KjT+UFG77HWiuLDzrIAJYk
         fKkWduQnpgJaovxFbmXMkkURc3Whv2fuoaT55puaUqIEUgiyF3qhyhJaIEP3S8zhLKjT
         Xx+A==
X-Forwarded-Encrypted: i=1; AJvYcCXs4voaMDvt1++FKSCJ/oJ3wcXk4Hz6ciKFdW4nElsT68bKZOQLjITzf5Cr5Uq1jMAD7V7OYe9L6aEJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzTZPFpxrxmrrwpc0PkmKjnt2p3BkcFYShtmnKwN9/GFSmZubCS
	NCPcTE/AC+6/l2dMYH+q/G9mMb9+/RCSKw6fvTxULy9B6GnjDZh3CF4Z4JuD
X-Gm-Gg: ASbGncu75MXNHP/5UrMn+h5dhf/g/iVznPpOTkujF+RX0lYjlpHnfIN10rifR3aWjYZ
	SyNLh8Wfp9yL0k/hS8EIXLp2n0Dzn7NtJECufek0uIHtjMT9FfekKYhKDwsHwh7yRp3Ohl+qHrb
	6JxcZEWqK/uwBXz07ejEG/Pfb1FNv9zFBfmqulGxJ4noBFMgjSR2+Fk+rlJexE+wEz5y9ZpmmlY
	vFrloFFNzmZlpuDgoO6czQzDs1CcuKTfa8aBB4CuQV+0KYpa5pXdB85FeKkCdtAWIVC7+kp+QhC
	utx9ijZ9ktn8aAvb1r99ZqARMr7zlreyEUGIhETq0F6UUG+LWT41zlQXoa71eImTQSmVSA==
X-Google-Smtp-Source: AGHT+IFdM2uihMFE1scAm5JrACgtnVIbLNjAwJpcqKr3P6lxtJIGZA3FqHOXHR4oGZESQpKSGY0nfw==
X-Received: by 2002:a17:902:d4d0:b0:223:3bf6:7e6e with SMTP id d9443c01a7336-2233bf67f9emr6888115ad.9.1740569188348;
        Wed, 26 Feb 2025 03:26:28 -0800 (PST)
Received: from localhost.localdomain (221x255x40x66.ap221.ftth.ucom.ne.jp. [221.255.40.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0009a0sm29800345ad.27.2025.02.26.03.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 03:26:27 -0800 (PST)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add hothmi vendor prefix
Date: Wed, 26 Feb 2025 20:25:48 +0900
Message-ID: <20250226112552.52494-2-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226112552.52494-1-kikuchan98@gmail.com>
References: <20250226112552.52494-1-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add prefix for Hotdisplay Technology Co.Ltd

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5079ca6ce1d..44108bd6ae2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -650,6 +650,8 @@ patternProperties:
     description: Shenzhen Hope Microelectronics Co., Ltd.
   "^hoperun,.*":
     description: Jiangsu HopeRun Software Co., Ltd.
+  "^hothmi,.*":
+    description: Hotdisplay Technology Co.Ltd
   "^hp,.*":
     description: Hewlett Packard Inc.
   "^hpe,.*":
-- 
2.48.1


