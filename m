Return-Path: <linux-kernel+bounces-174567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F638C10DE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D260A2831DA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E0D15E7F9;
	Thu,  9 May 2024 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9zFzdJ1"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFCF15B130;
	Thu,  9 May 2024 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715263621; cv=none; b=DH99+1BjqVbtnNqtG/xznkcj3JkX4pn41/2tf7YBkb+Ub2EC2jVINAgF/In7JugW4oOayN0D7bn1m1G/VnMO9NwUGp+RFfEpibZuymOui7YcEjkYmNB1e/7r56Oma21QMmWol2DHaF0LhOeKePPx+tKF3AlP0pGZpTRivDxWjL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715263621; c=relaxed/simple;
	bh=lQ8brj1TrE1qzkIXEeU7rBlmiZmuSyA8wkw7ixpriEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBJYWtcmP94H8PCL6p3DBw4JCoHJlTrOymmYLj5TsWCx/UmlKFoabExLxgUjOYR1q1QceNclID/SwH77F6NPTiV4Jkr8tfgY30efsnAUUmme83+V5qvz3evT9C0LOXJm9ARl8tk2LpcKQ9M5T8NEUKH05ncnLx928nPoGdafdYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9zFzdJ1; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-349545c3eb8so503051f8f.2;
        Thu, 09 May 2024 07:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715263618; x=1715868418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbWVkqkhZ2d0PkibWvpex0qMFtjGLxAjIIoCdT+E/c8=;
        b=O9zFzdJ1ePt7OmtEF4iw1PQZA+mnrd39dCiDlIqgwtIViSP0JaeX84lEPMeBiR+jLn
         H/WMApXbHtAtN7HHSIIdhodVL+r0QVQfkepB9tR8FW5rDslcRYOSmf5539hK0FGLYYCj
         oItvf7hcHNmgb6ry7uGgXUJlhdRGkEbx6i5J8F3uRtYJANB4hzdQnxju26QATxHdbrm1
         KrCQdlTOV03rEL0ORFi2ctqWWvPYWObqHZaLDpwqbg+8G2B26sss+rU1wejJ9hITrqyT
         rJInFeeYFQ7O/mOGr8ymgRzIM997YkxS7A7gAk6/4ZN4A4BjHmnIxg7j4Osa2ybxFfjQ
         f9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715263618; x=1715868418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbWVkqkhZ2d0PkibWvpex0qMFtjGLxAjIIoCdT+E/c8=;
        b=r5HJUgLyHc/ZkrBjDOymOISouqvYTItlRNgw8vsyGjguHGgk9VrhWBhfABZvbilTla
         EsrGtB4TF09tHjw7LfRrHfAPhbKIrv2G7vWWl0zNF1WpWYMl+5QIyOvfzyqzadnRgYA0
         Ves699QhdAuFKcQHrCWqjVXz4kpgP2w2NyzcHz1VDkPOa5FX68GiAn7iO71Spi8ELpIw
         kx/Jd0PwYjoRE8E6OA4bRT8qbt2FcSCk6p3nZNPbpd0u2L1nSj+xZKQy4Vge4GfGF2Ay
         3OINQDVvO/oyRKucuUVk5MGd/exFSrPYFCQypb1IOXlPzcQsz8vNh0xAcSYoClzMT81r
         mMBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXevddLPmAZ6TwZ8I4vS+ACfvuzKM/qVK2mgHLubUoHlzR/3t1VMdfQ0katFp1kZDX1jh6/6gpC3YOV+EkIRB1WKrECyfOuzyBOAmiRgS959P0c3ZsOxPqKE2TVYtUg0q7ur4T53Rdy8jfz+BnL0xa7mT01QICewiR0Y/9dbT4vLCYCiA==
X-Gm-Message-State: AOJu0YyIWG5fc65Q7pLlpTtn9K8nakRC1hBDy/I1noa0IgHWr588AeNc
	Bm2Z6BMflWP44vdk6evs6Nk6WFxBdZn7T09UGe9PhrvwiUuOFxA=
X-Google-Smtp-Source: AGHT+IGJGV6bFqKBadGxqXhAzkF2pE6cCKZpD95eQc6VzdGRYvOXM2SRAFICzVxoDStLNZJ7jxAXuA==
X-Received: by 2002:a5d:6e8c:0:b0:34d:8c1f:3194 with SMTP id ffacd0b85a97d-34fcafcd7afmr3768024f8f.35.1715263617622;
        Thu, 09 May 2024 07:06:57 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:b44:d8c3:6fa8:c46f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad058sm1793311f8f.66.2024.05.09.07.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 07:06:56 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/7] dt-bindings: display: rockchip,dw-mipi-dsi: Document RK3128 DSI
Date: Thu,  9 May 2024 16:06:47 +0200
Message-ID: <20240509140653.168591-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240509140653.168591-1-knaerzche@gmail.com>
References: <20240509140653.168591-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the MIPI DSI controller for Rockchip RK3128. The integration is
similar to PX30 so it's bindings-constraints can be re-used.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
changes since v1:
 - added ahb clock

changes since v2:
 - revert added ahb clock
 
 .../rockchip/rockchip,dw-mipi-dsi.yaml        | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml
index ccf79e738fa1..ccd71c5324af 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml
@@ -15,6 +15,7 @@ properties:
     items:
       - enum:
           - rockchip,px30-mipi-dsi
+          - rockchip,rk3128-mipi-dsi
           - rockchip,rk3288-mipi-dsi
           - rockchip,rk3399-mipi-dsi
           - rockchip,rk3568-mipi-dsi
@@ -77,6 +78,7 @@ allOf:
           contains:
             enum:
               - rockchip,px30-mipi-dsi
+              - rockchip,rk3128-mipi-dsi
               - rockchip,rk3568-mipi-dsi
               - rockchip,rv1126-mipi-dsi
 
-- 
2.43.2


