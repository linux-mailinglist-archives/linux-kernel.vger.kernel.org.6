Return-Path: <linux-kernel+bounces-340221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA98987021
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 943351F27C41
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68EC1AB6CA;
	Thu, 26 Sep 2024 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wa0FqmY+"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71C117C9B0
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342980; cv=none; b=IJ13UEONKx44m4DE4UG9dMhl5yH82yj4g0w0AOe0FuoW6eVmEW5kC46Zv1+0IFWINPhLDlcu20rPChwpRkJlWT+qFFCrOM9Ty9N7svswtXHZfDTA1TP6wBnSxj+FilhTaxYHpx28sAcMmvIMsc0umHvxOK1R5FgOPazmKo1uzeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342980; c=relaxed/simple;
	bh=e6nEwqo0egjHQZK0hgI1JGRoPmddHPorS9dz1V7owoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MoHKybXGaHODVpUOSQmXFz9VhgOjd+31AZhywoQd35nrfPqIcb0IhGUyrI+Gq7UrITypisHs8LYVp3WRYmHqYsvDoB51gM7E74YtILpiVAfPlFq0qd4jRnVVFThZMSqRVL8BNnOww8JJme2cQTptqn3TRxr8O5Mm25lg1Y/JjFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wa0FqmY+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2068acc8b98so7394855ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 02:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727342978; x=1727947778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CoVZDlT8rcbCdZD4HgbL8e34c7fme5G3T1sU2oo428U=;
        b=Wa0FqmY+nm9PIH3uPu5ZgwsyiVzwCarUMFJrQ/03XK30JGScFIbT6dmc0ziZIdZVs5
         U5bUbqctT/golOIUbC1YSF4HV/AzBO3NV9Z3x+RRDNXwUHIDb06UBmlVAzSU2D8iEUlW
         qSa99ISGYLGGnosbpMhmLXX9Lqx7w4yfNianU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727342978; x=1727947778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CoVZDlT8rcbCdZD4HgbL8e34c7fme5G3T1sU2oo428U=;
        b=kTYImUF29YvtSAittT1crTSBGPxMN3EffxImC7PZOrI+5scX+y2OWMtE87BIGLrG4X
         4TUyJcuPi2FfMnQgxlHbAZdGLPcx3ZGQ05h3zoY+eThV6x5TkccZrUKNO4gRxZHkJSjS
         RfV1zUopGKZLNzdYwAMVhK4MjRDf0AEYk8pnC+hzZUVJZ04sW9p19WPZ2H/Ezmhkjkup
         JFN7EW22bHBgtTS/0k82blj52+3GY7Phq05+R7tN2cLSyPSxy9mmXG7MpOWkUyDTT5Lc
         i18Q7U/HdeH9ZD+ozplKTJ1AUuetb5QW1CxxOSeLjjQFcdr9XpuKGpo4qd4K8yF1FCLQ
         VeXQ==
X-Gm-Message-State: AOJu0YyXKlpgkFv6bc3KZmlg2w7z9v8zFioKM3tjY1DuwpsXG61uLv6t
	wWqnAsuvfezMzCRUfkE/OvqutH5Q7MyNWe2XE7/cirkY7yfpHA7cnDWRVe4qVg==
X-Google-Smtp-Source: AGHT+IHXrp6wJER4dh1BTAriwK+WD+8X8sDvbZv4icGc+K+dLuVljojwoLFCgGkE+FqGR4g9QtmlWQ==
X-Received: by 2002:a17:903:40cc:b0:205:701b:22be with SMTP id d9443c01a7336-20afc662bdamr57796665ad.56.1727342978037;
        Thu, 26 Sep 2024 02:29:38 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:4234:cfaa:3b83:d75a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af1720b00sm34819105ad.64.2024.09.26.02.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 02:29:37 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Xin Ji <xji@analogixsemi.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v2 0/2] Drop EDID cache for it6505/anx7625 when the bridge is powered off
Date: Thu, 26 Sep 2024 17:29:07 +0800
Message-ID: <20240926092931.3870342-1-treapking@chromium.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This mainly fixes the use case when the user changes the external monitor
when the system is suspended. Without this series, both of the bridges
will skip the EDID read and returned the cached one after resume.

Apart from that, we also observed a DP-to-HDMI bridge expects an EDID read
after it's powered on. This patch also works around the problem by always
triggering the EDID read after the system resume.

Changes in v2:
- Only drop the EDID cache for anx7625 when it's not in eDP mode
- Collect review tags

Pin-yen Lin (2):
  drm/bridge: anx7625: Drop EDID cache on bridge power off
  drm/bridge: it6505: Drop EDID cache on bridge power off

 drivers/gpu/drm/bridge/analogix/anx7625.c | 2 ++
 drivers/gpu/drm/bridge/ite-it6505.c       | 2 ++
 2 files changed, 4 insertions(+)

-- 
2.46.0.792.g87dc391469-goog


