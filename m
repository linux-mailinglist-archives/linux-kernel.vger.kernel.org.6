Return-Path: <linux-kernel+bounces-178994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 793BD8C5A33
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE8F1C2176E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BDD1802A1;
	Tue, 14 May 2024 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aDe7usDp"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F8017F378
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715707315; cv=none; b=IWBNepJiNkFMD2JfYFRD0r3n5ivrNSkcTMPXO9bRqmeh4reDW6SNtuAW36H8eAUrft5JbeQ1vMconjyxp2ebDLz0LcG6b/ch8coVL4PO8jz+zn+HWX3WswwFCLXV1fDRaiZPpsynG2rhXpp22Syi+6lB85Qyn0JtWOQp2fA4M6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715707315; c=relaxed/simple;
	bh=LXxOW+4URWw04jgWlII7sX2DMFbfU12irLmGCjF+1H8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lLBJpK0VDi0iX4M/nTn6hfiCFA87PzBRdiL8vY6gmzDUv49Czu1ihQ1N9ZSFpEPFQ960ZioBZGS2RoCeea+F1pV14FiGEFunNez7ArOnRmGb6jpI6hZjariNAxJF4O3GWQvrJtqrvQHlqdWdNCe0ki1gqz32P5EJTo0FhOAwtuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aDe7usDp; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d3907ff128so4916188a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 10:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715707313; x=1716312113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ssdyg8CCGX3LIJke97/Daf2m8VAxcmXAY7Al2Agin+M=;
        b=aDe7usDpOTauWs82wHXWAUrQdpAgKYeabzvO4yLyh9WzxMo/18CxHc/wj7rH5YFELa
         T5k1Kvk2z+trJJz8FT9CnGVnHiz87bDMi5bgNwL09bj5IFrhNAokP5bXt8231M7lrWrE
         5NCW5SNi1qEcXv6p5//GsJsvxEBgKVlNKo98k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715707313; x=1716312113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ssdyg8CCGX3LIJke97/Daf2m8VAxcmXAY7Al2Agin+M=;
        b=BgDRCr6O3V0JJRJJzPpZWO186+kIy5So9FSQA73qNywtZRqwnjTfy9d7NfLyLCQcxF
         w0muYcw6HmFb5JAFfrhBUex8WqyvRv7S5DycdgdDzbd+pnBC6By4HWDLKIt5i7bELjjc
         IKyL2Dp0mpw5q7Fh/ou+qYWdWHbxb1Te1ODsREa+qD6QQK+Z/EzQqF16VQYMk+x7fUoN
         iIYURDqnVhSva8qwowuX+nklAFIvMN6fTZ7GEOqiPGy83HCT7yj0yu9vzUUuLpTDkwVc
         cSxe5d3vuJkBCKqg54jjXIkTNqM3QthTmD9Q4PPwPOgW6CYSb0MtLE5t9J3Jq383yCts
         fOYg==
X-Forwarded-Encrypted: i=1; AJvYcCXPdfk6dQyyd4f7hwBHGQe8f1BKlcEusQw2BFjQCsIwh3ha0jghpVyATR6RjUFF5YH/+y+IYB0UiqUHWjPGznYZORXQIjYPzDVv42Lf
X-Gm-Message-State: AOJu0Yw+VWMy54bXmwpW7OoNawKdbIml80U/LQ9H0BRr1fygSEIx7AWg
	Sl/PaHSO1sPexBOGcvBWnXWPNwIU68pr4NeujVwB8aKPFznl55p0K+J8O0dmsw==
X-Google-Smtp-Source: AGHT+IEdkNHfIF4J+VOvPXSXkd1kac81F8OYFYQWIaEBgRlg2k0P2Wfxxy1Qni+Ukv55u3HtLQE+5Q==
X-Received: by 2002:a17:90a:4c84:b0:2b6:3034:4ae6 with SMTP id 98e67ed59e1d1-2b6ccd93d4dmr14814191a91.33.1715707313086;
        Tue, 14 May 2024 10:21:53 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:ef10:6fdf:5041:421f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf3101csm100147575ad.121.2024.05.14.10.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 10:21:52 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
	lvzhaoxiong@huaqin.corp-partner.google.com,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Brian Norris <briannorris@chromium.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Joel Selvaraj <jo@jsfamily.in>,
	Hsin-Yi Wang <hsinyi@google.com>,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/9] drm/mipi-dsi: Reduce bloat and add funcs for cleaner init seqs
Date: Tue, 14 May 2024 10:20:50 -0700
Message-ID: <20240514172136.1578498-1-dianders@chromium.org>
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

v4 just has a tiny bugfix and collects tags. v5 has another tiny
bugfix. Assuming no other problems are found the plan is to land this
series sometime roughly around May 16 [2].

[1] https://lore.kernel.org/r/20240424172017.1.Id15fae80582bc74a0d4f1338987fa375738f45b9@changeid
[2] https://lore.kernel.org/r/35b899d2-fb47-403a-83d2-204c0800d496@linaro.org

Changes in v5:
- Fix comment dev_err_ratelimited() => dev_err().

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


