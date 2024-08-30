Return-Path: <linux-kernel+bounces-309029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994DE96656D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A23285658
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898C81B5821;
	Fri, 30 Aug 2024 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZlMgFcs"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AEB192D98;
	Fri, 30 Aug 2024 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031736; cv=none; b=RRDN+wNMaFQkwjwVdt3JtymRwt8dUE6rc4axyP8MxLzU0jTTSzyJnAmblTAQ3/Br+l4Iy0WLbHzC/XyYKkwZvTsGvehiR2qCtuWCbv4SRsRA+AKdYHm7CkzR9C9vbq4trgvCec8IaFUzXXqoP39Aq+ctss2qo7C+rbe7NLUg2oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031736; c=relaxed/simple;
	bh=z0Jxr9GcaVWsSNIfvVwDhadADyYvp+MjMQOCjb8UsAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acPvzgjO22WZokeq9yzpFkGi0uVu8OuosFlvX1egDS7ttizrux7mcO/LgDwtohPTaEJdx5kIbASmGs7SCaH8a7B73v7gcwHDOQi32t+WLOOHWllM1tVqGyD5xmiBG0hytDRHN+iwfVCY6iaMBnB+j3nXHQbY/1c4CsfKkJwPqTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZlMgFcs; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39d37d9767dso7159525ab.3;
        Fri, 30 Aug 2024 08:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725031734; x=1725636534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vah8cjhzLMApjKYb++BW5rUOqQaxePVKAdvzAWnfOaM=;
        b=iZlMgFcsPwUef4Nq+LYK3tl0UT0nG87tjVYzeb1l5PCOik///y7cV0fDHDbHMXlqSR
         RAU3H28+9SSL7GApfhvqS07oexZwQ+vdiwiMS3w07tprgcjU1VESWhWIK3QEB2HsYTo6
         jLszMQj1QhESVf9JWX8BA7oVIiXspi8xQDN5g3YPZgyqJ80ChdkSMOQJPYSvdJUaB3Wn
         pMZAKr4Y9pIPoxeUfAzUwFMtAklZhpJOiVdpV/SmTwrMpR6c3HY4PlFmRnED5AbLf669
         PJWFAxiEpfk5ztUq43NuvuNAt/LcInV2Hhp9gbNwhGA5hvjOkF9f3F7/yoLrco8MGoRN
         TilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725031734; x=1725636534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vah8cjhzLMApjKYb++BW5rUOqQaxePVKAdvzAWnfOaM=;
        b=BqslqK8eWZGyBqYGV7tF/aXA67/P/3Q4FJHE09Mqd2IT8jmNAqjh3xBgXp1wxbZkh0
         Do4/56uhJrrFYlQQHZVLD7Em3VyaL7B0UcvBXdtRoJRN2pEHMjqgRw0gIZJJHLxvlU8v
         o9ezNwR9FfT73H0QZuH35/4zYbvbJlXmP5XxU5gHBeXPDQ+qTQv1wiCL4ShylphOYAih
         YBa0hH8xEEyDkwuxTXsZFCHtR69tjxTFCbnpZ+j7lwDyx42xAp00KbFhkhRRYASg9Jcn
         fhoiPmMzMDnaceG9HVm1kLQfXgqmpDUTg7/ryLPDQhxcIIBLyl9K62yx9e+yT7bUd6og
         gxUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY4DMCj1BpPjhQ6GvazVfuJ+k0MebFbCdgTe1nwW50bhMwcVD5U7Ws5dQWsrLwJbyR0mCSl/Fp5aKb@vger.kernel.org, AJvYcCVQW5rR5OXD2jnaBvl6AMTr4P9LfO81bA8HKDOtFyCaWYzVNfTDlY74V6ZANM/fXFodPxEdgJE9pSdoTfLs@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6uHQCfLFKfnF6JzoYQtry/WcxrwRM7u6SAf4dBtf7w+o9GJY+
	PK1fWEqN2LGiDT7rkQ9LnxePakyxAq7IA8nnZWDcM0bCZmGCwPwl
X-Google-Smtp-Source: AGHT+IEWeczUbduYfRfvJRK9CAJqdyCgkYF3aIwmFNEUPRqq3T8PgrzJvl3ssCccXEstFDKzoix0cA==
X-Received: by 2002:a05:6e02:1645:b0:39d:2c94:45e0 with SMTP id e9e14a558f8ab-39f379b2934mr77207365ab.26.1725031734314;
        Fri, 30 Aug 2024 08:28:54 -0700 (PDT)
Received: from localhost.localdomain (174-20-195-90.mpls.qwest.net. [174.20.195.90])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3b040474sm8870925ab.59.2024.08.30.08.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 08:28:53 -0700 (PDT)
From: Shimrra Shai <shimrrashai@gmail.com>
To: shimrrashai@gmail.com
Cc: Laurent.pinchart@ideasonboard.com,
	aarnoud@me.com,
	airlied@gmail.com,
	algea.cao@rock-chips.com,
	andrzej.hajda@intel.com,
	andy.yan@rock-chips.com,
	conor+dt@kernel.org,
	cristian.ciocaltea@collabora.com,
	daniel@ffwll.ch,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	heiko@sntech.de,
	hjc@rock-chips.com,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	krzk+dt@kernel.org,
	ldearquer@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	maarten.lankhorst@linux.intel.com,
	markyao0591@gmail.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	tzimmermann@suse.de
Subject: [PATCH v5? 4/6] dt-bindings: soc: rockchip: Document VO0/1 GRF compatible string changes
Date: Fri, 30 Aug 2024 10:28:40 -0500
Message-ID: <20240830152840.9066-1-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830152132.8894-1-shimrrashai@gmail.com>
References: <20240830152132.8894-1-shimrrashai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 78c6d5b64..8fd539125 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -31,7 +31,8 @@ properties:
               - rockchip,rk3588-pcie3-pipe-grf
               - rockchip,rk3588-usb-grf
               - rockchip,rk3588-usbdpphy-grf
-              - rockchip,rk3588-vo-grf
+              - rockchip,rk3588-vo0-grf
+              - rockchip,rk3588-vo1-grf
               - rockchip,rk3588-vop-grf
               - rockchip,rv1108-usbgrf
           - const: syscon
@@ -261,7 +262,8 @@ allOf:
         compatible:
           contains:
             enum:
-              - rockchip,rk3588-vo-grf
+              - rockchip,rk3588-vo0-grf
+              - rockchip,rk3588-vo1-grf

     then:
       required:

