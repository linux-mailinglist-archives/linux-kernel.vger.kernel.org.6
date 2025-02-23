Return-Path: <linux-kernel+bounces-527786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7521A40F75
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 16:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2830F188C649
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 15:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5D320AF82;
	Sun, 23 Feb 2025 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHMc3IuM"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3759BBE5E;
	Sun, 23 Feb 2025 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740324798; cv=none; b=kQELsz/7YMcZ9c1UUXZAhIDGnpEkjy/KAq/NwmrXMrYiC7ItqQ2MB60ZpR034+oFsMfySGdZZF6ifgg7pkkFdGICRv7y7eKnGdC1+agglf4GjKgP8MZ9R6sN6jWiqD6kPyaLeYxS1M501HGu5I7EKPVRVAqhud+LTWQ1oZfcJvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740324798; c=relaxed/simple;
	bh=TmFkSpRQVJxcajxNzeTd7Dwo5yMA/jCVbuXoqVieW+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VBjHs7d/N73OMcujOtQ9bkpEEcmJSWjD3Gbjbxa6LsnFn6J/t3wJPbzai7mCoK9NF7LguQ5lpv+Zfg5L/Lx2cFLaW6wq0lb3VZm2Q7zHNblUJovKtd2rs+JLmD34osTopElXQg6fIabdcLAwrtMcu699YFyFkOGQCoPNPoFzitY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHMc3IuM; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-307bc125e2eso33842601fa.3;
        Sun, 23 Feb 2025 07:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740324794; x=1740929594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YgjojD0fkXCQkwACLWsbK5zmwbRWKyzVLcOWkG51yvI=;
        b=YHMc3IuMKYa8P+s4PAGzwZKwRvTIAuIqzrn00dw3EqHGIsfpaiHrPnvLN74Mb+SiXR
         PgHWniPg4MI/U0IJs2OfoonRuOfuEubTbazlt6P0c/GxthoSaRlcH1re2XH4IOBgT+63
         ARcoyR3u2B3dcYjbtBxxfWhfo9DmkxrQfa7OGzuV/pdaxiQVBfLaijMtJFohprMRCSZr
         KsHXX+tiGt+wkstE8+vnBDAaCwYKCpZOQK5r3UA46pOrX/ycpTqpHW08jOzhb4eEStnw
         esJszJ1BigmolAJnYn7A93rbxJ5condhjo7QjBMuu83YdVlURA/aS+pBMAzxDahqmO/g
         wYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740324794; x=1740929594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YgjojD0fkXCQkwACLWsbK5zmwbRWKyzVLcOWkG51yvI=;
        b=Ef5PC+sMkRhlrxRxfy6VawjTXzmoVrcnUXVBuv7SzycatlA16+BjaB2yDCuADVNutR
         j5+h08821yW+Lu3YdJpNkMumVK9CN7XVOEFZvisotRg0oo8WakzjzgBmwHXrD+l300uR
         Sv2bDnyHoaephjUORyyW3VffG5MxGYoMuG0ym607HApV7kb1FnidB5QHNBTyKD7mXS3I
         C+s4F07PDe4fnDB9KluiO59pDX+LNGgzv0cuUlOkv/urjwHGF2D9EQj1SydVRm0y31lt
         wXBGKyxr3hJB53Uxvy27I2to/BPqbPMM0hUxZ2TvPo/DUAkH/rDyDANxr9/QHlqOgDxd
         qzTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjtZHkWBqJ7ww8sYifN5FbV45i4xJ/UAo7JMFqzIAVUQ2g//e7JA8E9FyCJdArBAPhCKrWe9eJJtWde9wU@vger.kernel.org, AJvYcCWY7kK113nl8kSk8c1+ZNSJHXldxx/uotCplONgAep9F2/5nzfSX4LCmzY+Dd1Dgm/6Wn+IWZi8VYvf@vger.kernel.org
X-Gm-Message-State: AOJu0YwcDKvD/+a5vzr+kWVGusnxU9zZI7V0TVexuQT2XE3S0J5wpA7M
	lY1xvfJUUgFpBWgdYo3XYv6T2g2iqimjZVvZyqrLfGaDobcdzHI9
X-Gm-Gg: ASbGncv2YDpMl5HjxrK8z1dTBBsX0YAjkjlPXH0+/UCPPfLJYwE+viqTINJhFRv/CBv
	k35X5FV8bY0vDtsCWj6TYn2D8mqcRt4+NuYEv8mCkZBSnqwOyzBAiSkkjfZnV+EQAcDrcSog7I6
	JRWkeXVkZPagaKDltyhz5pYuOrJlIBX5qWXuqNqvqy/aRx6BFB0Dynf6+728vyVdrr5Nhnu9hve
	13Tw8KnZlu8OJDjh7wUQN+a4I1Fc3WN5CZIk1VfBUdlN8Jp8df4Z367V/EMqYyzJ+/3P+19UCE8
	uUelwwKj/YfxjPsS
X-Google-Smtp-Source: AGHT+IG77PHKjf5AhiLyerMkTqb453TjzWBZYQ7pg1s4WIRVRUE0L2S+OmWF2VO1uU3W239jf6xc6Q==
X-Received: by 2002:a05:6512:1386:b0:545:e19:ba24 with SMTP id 2adb3069b0e04-54838f791d4mr4496251e87.48.1740324793960;
        Sun, 23 Feb 2025 07:33:13 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54523dd8ca3sm3025569e87.181.2025.02.23.07.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 07:33:13 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] drm: bridge: add ssd2825 RGB/DSI bridge support
Date: Sun, 23 Feb 2025 17:32:42 +0200
Message-ID: <20250223153244.149102-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Solomon SSD2825 is a RGB to MIPI DSI bridge used in LG Optimus 4D P880
and LG Optimus Vu P895

---
Changes on switching from v2 to v3:
- added mutex guard
- configuration register flags parametrized using panel flags
- removed unneded debug messages
- removed unimplemented modes checks
- added check for maximum pixel row length
- use types header
- remove ssd2825_to_ns
- shift bridge setup into atomic pre-enable
- cleaned default values of hzd and hpd

Changes on switching from v1 to v2:
- added description for clock
- removed clock-names
- added boundries for hs-zero-delay-ns and hs-prep-delay-ns
- added mutex lock for host transfers
- converted to atomic ops
- get drm_display_mode mode with atomic helpers
- parameterized INTERFACE_CTRL_REG_6 configuration
- added video mode validation and fixup
- removed clock name
- switched to devm_regulator_bulk_get_const
- added default timings
---

Svyatoslav Ryhel (2):
  dt-bindings: display: bridge: Document Solomon SSD2825
  drm: bridge: Add support for Solomon SSD2825 RGB/DSI bridge

 .../display/bridge/solomon,ssd2825.yaml       | 141 +++
 drivers/gpu/drm/bridge/Kconfig                |  13 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/ssd2825.c              | 821 ++++++++++++++++++
 4 files changed, 976 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/solomon,ssd2825.yaml
 create mode 100644 drivers/gpu/drm/bridge/ssd2825.c

-- 
2.43.0


