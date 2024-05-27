Return-Path: <linux-kernel+bounces-190384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7228CFD8D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F23A1C211DA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E6113AA2D;
	Mon, 27 May 2024 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nRyqNcYJ"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC6513A88B
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803761; cv=none; b=PqUSQ2/4uVCtvlnSDFUy9znb0XXSEfBGZ8CjndiDxe0wA6JcjJxqKhmY27HS00G1iQtt46fSBojcMELqVvHZiQm6tdPxpRObVNFpd+FzM+avKCCpV1ecz1aNVRO4hsRQryDKOd2E144Cti+Ip+TzZ9/dy+QKYIJab8U0Kw11ITc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803761; c=relaxed/simple;
	bh=4qLu63oQjPQI3PoKweAmwGqswfeub7pAhmGJZVG+mBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UjGvxvY1NbHrcn6aWsTo8XMiZsJCgeYNA+Cyt79kYjuR4FzU84FXy0bVyOABGcrfOJ3U4t99uP0ULqihvEJ3NBIm72VkbMoGqs1aNtXwcT+LtHoimLzURYKfaY6NC/q+DbN2+JgOVJEI7rHvoASjxVF9RRuRTRoEVVbVEMyUV9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nRyqNcYJ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f850ff30c0so3229893b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716803759; x=1717408559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xVqObQW1tDXZp0fIQB+e2zlQS1L4PNA6wMGDb0OfNVs=;
        b=nRyqNcYJBnQFQMO8ogfIhpsRdUEMD1dGJjP6xl5Zsn9VJtYJ1n83f3YArkRK0HFFkU
         NB2DTX2gaMAMkugcs1dNyYrsCGQLDjGsAZx0h3rQK39XZKZf7cJlzjTkeTpYZ3yfRbdB
         DT0vLDjy1fvML4RvWZlGnTPS+tV2PdpL7sudk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716803759; x=1717408559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVqObQW1tDXZp0fIQB+e2zlQS1L4PNA6wMGDb0OfNVs=;
        b=I0dW1jpp2a1/k0A7OK/t0xVSL6B7BMODoZEBsrbZ001ja9wDLepw8wHu/TbsSCYaWV
         Ct6V8gj8Ayf1sREwvyn/06Wr86xl+XDZ8CZN5Kx9UYW9RUgYQqzn7owjgwHFb5inZzTk
         5T70C+5cz294igYqGCL0r5c6RQufuAWgfVWHJ8yMqMC+ESMcxTvcSctZJoegwe/zsoCj
         wr8BNVQhUiGO6v0NwXSJ6z+vq5L7276mTGIEIwF2nmcxswIywY8l+1bYNJt2eY1kPH0J
         ww+V6Wo5sbiw60/x7vh/J8tZZa7pAwI+JidsjAS01IH+laG+T4rC1GHpHuiFNMWFGKwi
         llzw==
X-Gm-Message-State: AOJu0Yzi+8lVZcc5eND+zwUA3YvZRtkPN5uq+ELY/6SPew0sAoiBFEEz
	byAl9wQeXZHlw2A/HAhk9gCTp0BqOqAoiNGfVEiIJYQZSx8mL+5HnKKQvfXgsw==
X-Google-Smtp-Source: AGHT+IGSeRQ9ncSvLh1p/paH6YS7lQiGlvz0ZoxgQ9AWSvApeNL+VJvo1/NPMaTOG4LA1ELaniNmyg==
X-Received: by 2002:a05:6a00:450a:b0:6ea:74d4:a01c with SMTP id d2e1a72fcca58-6f8f34aa591mr10007490b3a.14.1716803758828;
        Mon, 27 May 2024 02:55:58 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:a9ab:23f:9d2d:dc0e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6fd94372addsm2951616b3a.186.2024.05.27.02.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:55:58 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Douglas Anderson <dianders@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH 0/2] Support more panels used by MT8173 Chromebooks in edp-panel
Date: Mon, 27 May 2024 17:54:48 +0800
Message-ID: <20240527095511.719825-1-treapking@chromium.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains 2 patches.

The first patch adds more panel entries with the delays from the
datasheets.

The second patch adds 3 panel entries whose datasheets are not available.
For more backgrounds of the rationale behind these conservative timings,
please refer to the commit message of commit 7c8690d8fc80 ("drm/panel-edp:
Add some panels with conservative timings") and the related mailing list
discussion[1].

[1]: https://lore.kernel.org/all/CAD=FV=V=K9L=bJiNvFJ+K_DHUTPxA4WtukXA+E_VW6uihE8kdQ@mail.gmail.com/


Pin-yen Lin (2):
  drm/panel-edp: Add support for several panels
  drm/panel-edp: Add more panels with conservative timings

 drivers/gpu/drm/panel/panel-edp.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.45.1.288.g0e0cd299f1-goog


