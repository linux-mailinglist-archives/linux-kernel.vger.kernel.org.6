Return-Path: <linux-kernel+bounces-173812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A458C05E3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787111C21CE6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA32813175B;
	Wed,  8 May 2024 20:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i1t7e66N"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B146130ACF
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715201596; cv=none; b=lj+5IHXKdPDZHRf99ufDLHbkfKJW8xM2qK5Q0uw6uJN0NO3KbzvpujIr7mXUiTeWkwd0N5G5Wsq5D+d3zuKWVPBEBw2XWfk0F4USvy9vj903XRQD7UiXSDtrwSNEvnNRt5/DMdgXX4qrcBxRu0WiNoqZJhR79g1QKV3LcH/kzNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715201596; c=relaxed/simple;
	bh=5dqI6Q9VRMnPFtj/fULp3IbNjZl7toh/De9ZjCYDd9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=atLhI0I8SzSiTBABI/bRUStRe/5EibPgktPRlki0FO+kPPOrdOyxC/fQrW8lSDeWnnm+UOaUzhw/C1oKB2Wf5luJPRiROBogmFnFSGnAT/86DJ0tQw9AsAwRMOYvN3wdTiVPRkpLAp3aZyu7Ndq0lF9gxMtwK9t+sQoK4q9MP2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i1t7e66N; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2b4a7671abaso193863a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 13:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715201594; x=1715806394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YqkxFBwBCIjXspjTXUzXTZ3b9F2ADVTFncXrWGlr3RY=;
        b=i1t7e66NzREA+EFdGhzrd3v3nU9VQOzOByNhSseGi+58Zvl/tqb6GhVUEluyxxv505
         nBGQ51LkcnEAxxbeAalD2fD03mH3b1xB9XunuZhWo3w7rnEtHkFGVJHLZ5sj5lEOUjk5
         XwUcm9CWH+Lg3RwoIABOKyPmxtJgNH7pDSw7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715201594; x=1715806394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YqkxFBwBCIjXspjTXUzXTZ3b9F2ADVTFncXrWGlr3RY=;
        b=diYPE5FnZCbFBOI8OEE5QJ6M/F/01IMryoxfOZ/CK45jtohpc+CZtJhkL10+8FEE2e
         FJlXi4MLOdWnoCYnax5FP6RovLCGSM6MepYwqEyyS7/xgOnmh86JsZ/nbFHIc9T/uw7R
         MNqOM28Uy1Kgb4wQfS9SFxVkpLEeQH2F+lv0GbQPsaKfAS5SCAxFzWTOAwN64MD5/1d4
         c653J6oSEvX38VDJrfeXMMY2gnZ55dPKv3h+9n375T1uiSs4XAbiDzcQEYyBmjFllaHs
         0nv4dvnerQ1E38WEkePPEIwFqkmUGxSogtMvhkThvr0dcU7NnCc7DNPJSKviPNKRROQT
         cUXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2W8Z3VVlrWMbACaBgvFaurXfKR/NdipRJjY3kA05wCPGeR+VJ7xHHXc+N2Kd6alUpEo0Qa4eJn5MvBK8aa5Cp1J5Jo7mf4k++bNEq
X-Gm-Message-State: AOJu0Yz8d4r2CroyRi2z49224iMZj0o0FooNH4lvlQEVrdhQL+P+DJhh
	8xdtTX/4kJpGu+OIWrbJb++Hza76dlX3j0o+t890dT+nK0fCpGW85hjsSYJp9A==
X-Google-Smtp-Source: AGHT+IGiUf19nbv8mVQARWFwlILcfxotMoUSFRx1h7bsJtjkb0vbvYocGef5+88IYl9SHmfxsT4U6w==
X-Received: by 2002:a17:90b:603:b0:2ac:5a93:636b with SMTP id 98e67ed59e1d1-2b61649d74amr3509508a91.2.1715201593783;
        Wed, 08 May 2024 13:53:13 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:40f4:feca:59e0:d3ca])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67126ad51sm6887a91.25.2024.05.08.13.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 13:53:13 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: lvzhaoxiong@huaqin.corp-partner.google.com,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Hsin-Yi Wang <hsinyi@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Joel Selvaraj <jo@jsfamily.in>,
	Brian Norris <briannorris@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/9] drm/mipi-dsi: Reduce bloat and add funcs for cleaner init seqs
Date: Wed,  8 May 2024 13:51:42 -0700
Message-ID: <20240508205222.2251854-1-dianders@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The consensus of many DRM folks is that we want to move away from DSI
drivers defining tables of init commands. Instead, we want to move to
init functions that can use common DRM functions. The issue thus far
has been that using the macros mipi_dsi_generic_write_seq() and
mipi_dsi_dcs_write_seq() bloats the driver using them.

While trying to solve bloat, we realized that the majority of the it
was easy to solve. This series solves the bloat for existing drivers
by moving the printout outside of the macro.

During discussion of my v1 patch to fix the bloat [1], we also decided
that we really want to change the way that drivers deal with init
sequences to make it clearer. In addition to being cleaner, a side
effect of moving drivers to the new style reduces bloat _even more_.

This series also contains a few minor fixes / cleanups that I found
along the way.

This series converts four drivers over to the new
mipi_dsi_dcs_write_seq_multi() function. Not all conversions have been
tested, but hopefully they are straightforward enough. I'd appreciate
testing.

NOTE: In v3 I tried to incorporate the feedback from v2. I also
converted the other two panels I could find that used table-based
initialization.

v4 just has a tiny bugfix and collects tags. Assuming no other
problems are found the plan is to land this series sometime roughly
around May 16 [2]. Note that unless I get a review/Ack for the patch
("drm/panel: novatek-nt36672e: Switch to
mipi_dsi_dcs_write_seq_multi()") then I'll land the series without
that patch.

[1] https://lore.kernel.org/r/20240424172017.1.Id15fae80582bc74a0d4f1338987fa375738f45b9@changeid
[2] https://lore.kernel.org/r/35b899d2-fb47-403a-83d2-204c0800d496@linaro.org

Changes in v4:
- Test to see if init is non-NULL before using it.
- Update wording as per Linus W.

Changes in v3:
- ("mipi_dsi_*_write functions don't need to ratelimit...") moved earlier.
- Add a TODO item for cleaning up the deprecated macros/functions.
- Fix spacing of init function.
- Inline kerneldoc comments for struct mipi_dsi_multi_context.
- Rebased upon patch to remove ratelimit of prints.
- Remove an unneeded error print.
- Squash boe-tv101wum-nl6 lowercase patch into main patch
- Use %zd in print instead of casting errors to int.
- drm/panel: ili9882t: Don't use a table for initting panels
- drm/panel: innolux-p079zca: Don't use a table for initting panels

Changes in v2:
- Add some comments to the macros about printing and returning.
- Change the way err value is handled in prep for next patch.
- Modify commit message now that this is part of a series.
- Rebased upon patches to avoid theoretical int overflow.
- drm/mipi-dsi: Fix theoretical int overflow in mipi_dsi_dcs_write_seq()
- drm/mipi-dsi: Fix theoretical int overflow in mipi_dsi_generic_write_seq()
- drm/mipi-dsi: Introduce mipi_dsi_*_write_seq_multi()
- drm/mipi-dsi: mipi_dsi_*_write functions don't need to ratelimit prints
- drm/panel: boe-tv101wum-nl6: Convert hex to lowercase
- drm/panel: boe-tv101wum-nl6: Don't use a table for initting commands
- drm/panel: novatek-nt36672e: Switch to mipi_dsi_dcs_write_seq_multi()

Douglas Anderson (9):
  drm/mipi-dsi: Fix theoretical int overflow in mipi_dsi_dcs_write_seq()
  drm/mipi-dsi: Fix theoretical int overflow in
    mipi_dsi_generic_write_seq()
  drm/mipi-dsi: mipi_dsi_*_write functions don't need to ratelimit
    prints
  drm/mipi-dsi: Reduce driver bloat of mipi_dsi_*_write_seq()
  drm/mipi-dsi: Introduce mipi_dsi_*_write_seq_multi()
  drm/panel: novatek-nt36672e: Switch to mipi_dsi_dcs_write_seq_multi()
  drm/panel: boe-tv101wum-nl6: Don't use a table for initting panels
  drm/panel: ili9882t: Don't use a table for initting panels
  drm/panel: innolux-p079zca: Don't use a table for initting panels

 Documentation/gpu/todo.rst                    |   18 +
 drivers/gpu/drm/drm_mipi_dsi.c                |  112 +
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 2792 +++++++++--------
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c |  794 +++--
 drivers/gpu/drm/panel/panel-innolux-p079zca.c |  284 +-
 .../gpu/drm/panel/panel-novatek-nt36672e.c    |  576 ++--
 include/drm/drm_mipi_dsi.h                    |  101 +-
 7 files changed, 2452 insertions(+), 2225 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


