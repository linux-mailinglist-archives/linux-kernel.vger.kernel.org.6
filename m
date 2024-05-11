Return-Path: <linux-kernel+bounces-176767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3939E8C34A0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 01:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8AE1281E9F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 23:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189FC3D97D;
	Sat, 11 May 2024 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NUatmsiV"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F4F17BA8
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 23:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715468430; cv=none; b=sfJ5ia7TC4STjj3m41R/7Fd3aMFtBejqhdgw1UzbK669gkhfPI2Ez7BHS+IRPTZ/gZBBprkv9nIFCk7gckqSwPISQq6D+YbNCRIaDqIe8cpbVHoo4kRJy/o8sXvlobfzRbKcg0OwcTn1d3FfZ4RIdRJ4ivxiMT+n9T6lNHRDdEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715468430; c=relaxed/simple;
	bh=GhJMJKGVASCLWmDBvP3xUjiHWJu10Z7FtTbPQeRjNs4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lsvryZdyEJbcwj4UBGMk3DKW2o5wIRUm+f2250SmBpwpcrco5FdXbiwMj1cYxJOPnN9h6I1IOtHTjfzEUWkuUNQuuwkxm86uFvoqg+19P6StjtHTbufNF8QWaES9wQhRB50ZYxIDzAT4VUKrtRzxbik4Mf9SNqbwWPLDP2qPZA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NUatmsiV; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51f3a49ff7dso4125163e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 16:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715468426; x=1716073226; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w1crgjrJgHOKBr+imw+Nt/0ShicbgCAQX722QtzGop8=;
        b=NUatmsiV9nV+m2InMwShyaXHc/10BqvBYeZh4YCO9toq+KvQiPNnIKARc/+IykvWBl
         vUk3dzXBqsEAOY4FjpLFincZgzcReMaaD9Hq6tUHcWZiWyF+7Rz9IBpcoBSoRwAMYMlT
         NqLhgpBpAMLLuIx7MHvPh9z3cRSOYKgaZt0x91DvW+D6hB835pP2kY0j4/M3V7+DHlgM
         Wpiq0YqYv2LMKvd1XWRcZgUZtgCxzSkcyB4Ky+hBJcV8GkKNIlhPzHGEg/YifQfMI7A9
         n8pvXRtUGrBvzCbp5VWOn9F0zftyfq/VtFt4xOhHnwQu5lFJvYAnfjtGEgWcNB2gmYsI
         2CXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715468426; x=1716073226;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w1crgjrJgHOKBr+imw+Nt/0ShicbgCAQX722QtzGop8=;
        b=SEruCELkRiAFk1C3WFKAO1gWxOcO+3/RKjEkGZzHR0jf4w7GHZG/qnXXJd/durljFc
         zNOC0FF2n/hxE6dRQqZwdNUOECXjxf1MrmyPbqkquj1laH/P0tarV/DrWLFiKeOtr5JT
         ubUnpWv32YZaHrrI5j6wJ1FQfkqIp4ksPesh31ASiTsKTP+u2UDNRVk/q1bCeO//1Rpd
         bCk7P/v/SDVaLwxbTG7A4PYomfen5x8NBblf90FTkoskWKL6Ut1YQDlDJ8MOJoWDUJzF
         yts+xlyqoD8H0WInh1we2+55TZckAL+Qkhc1eX3C1dsUA4qFh35/2FpplOxZsSTxXSV6
         GrWw==
X-Forwarded-Encrypted: i=1; AJvYcCX0qFavempquPHrsaTIUXZuze1K2u5iiGTdGcsh3Ix1NVRRZ/ORfTXbyVWQF8XvvqvqO9WzxgL6OwiL8TP3rYuG+BGCym9wfG3ZQYlK
X-Gm-Message-State: AOJu0YxvSFbP3kjD5Tgtq6CLY2CngVmLXKQ9n3pyHySTsRi9pnTTEI/u
	13VJdYXQKdIdIp11XNq2bBqVOvw9akp3gnjSVs6yWzjneys66qXGNuKAjGDzhzk=
X-Google-Smtp-Source: AGHT+IHOGC+XRG2Kq/VfByDdZEWx08N/OcEscIp/vQc/nukNXhNojPs9d+F3zg4lu3WjZRcCkjlBRg==
X-Received: by 2002:ac2:55a4:0:b0:521:533d:6367 with SMTP id 2adb3069b0e04-5221027bad5mr3264708e87.63.1715468426639;
        Sat, 11 May 2024 16:00:26 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d3717sm1134222e87.173.2024.05.11.16.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 16:00:26 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 0/7] drm/mipi-dsi: simplify MIPI DSI init/cleanup even
 more
Date: Sun, 12 May 2024 02:00:17 +0300
Message-Id: <20240512-dsi-panels-upd-api-v2-0-e31ca14d102e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIH4P2YC/32NQQrCMBBFr1Jm7cgkVlpdeQ/pIk3GdqAkIdGil
 Nzd2AO4fA/++xtkTsIZrs0GiVfJEnwFfWjAzsZPjOIqgybd0lkRuiwYjecl4ys6NFGw7S7GjXo
 kJgV1GBM/5L1H70PlWfIzpM/+saqf/ZtbFRKeVGe73pCztr8t4k0Kx5AmGEopX6G9Al21AAAA
To: Douglas Anderson <dianders@chromium.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Vinod Koul <vkoul@kernel.org>
Cc: Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2256;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=GhJMJKGVASCLWmDBvP3xUjiHWJu10Z7FtTbPQeRjNs4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmP/iIfiL837D5WZQ2bWaZtrjxYgMPZDItB4OxM
 ojSbdARTaaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZj/4iAAKCRCLPIo+Aiko
 1fdiB/9+QLRt7ECfH3CzlQmvUmSg5waLTJLqtQvSjUmr71DqTi+fKsZbgXnf33KmfC2IABElpwm
 Nj0WJzND7JoeSolP8g+ww3fpHOj+xHWIQNgOkrB3WSEKxwuTtkA8p0gvNbqquU84NNnMcjqDTGk
 oq+kQ7GAK5TQn1Zlc4/P/n5TeJVsY4GUGysPLZ2KNXJdcw4TzxBB2hwYFL99SASG6i84ZaGtgsp
 Q1VFderVjXIFu4ubx8f2ODnvN2GA11XXXbWgloZ9/mdsr9AdNAbOT0P6q8Po6Tx6Mc8HC4OfX1E
 WYTgEnI+ndySL2JorOGx7F94j1j+WOxttx193ePxlQCf4D6r
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Follow the example of mipi_dsi_generic_write_multi(),
mipi_dsi_dcs_write_buffer_multi(), mipi_dsi_generic_write_seq_multi()
and mipi_dsi_dcs_write_seq_multi(). Define _multi variants for several
other common MIPI DSI functions and use these functions in the panel
code.

This series also includes a fix for the LG SW43408. If the proposed
approach is declined, the fix will be submitted separately.

Depends:
- https://lore.kernel.org/dri-devel/20240508205222.2251854-1-dianders@chromium.org/
- https://lore.kernel.org/dri-devel/20240511021326.288728-1-yangcong5@huaqin.corp-partner.google.com/

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
- Rebased on top of Cong's series
- Fixed mipi_dsi_compression_mode_ext_multi() docs (Doug)
- Added do/while(0) wrapping to mipi_dsi_msleep() macro (Doug)
- Inlined boe_panel_enter_sleep_mode(), ili9882t_enter_sleep_mode()
  (Doug)
- Dropped error prints around nt36672e_on() and nt36672e_off() (Doug)
- Link to v1: https://lore.kernel.org/r/20240510-dsi-panels-upd-api-v1-0-317c78a0dcc8@linaro.org

---
Dmitry Baryshkov (7):
      drm/panel: lg-sw43408: add missing error handling
      drm/mipi-dsi: wrap more functions for streamline handling
      drm/panel: boe-tv101wum-nl6: use wrapped MIPI DCS functions
      drm/panel: ilitek-ili9882t: use wrapped MIPI DCS functions
      drm/panel: innolux-p079zca: use mipi_dsi_dcs_nop_multi()
      drm/panel: novatek-nt36672e: use wrapped MIPI DCS functions
      drm/panel: lg-sw43408: use new streamlined MIPI DSI API

 drivers/gpu/drm/drm_mipi_dsi.c                 | 210 +++++++++
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c |  81 +---
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c  |  48 +-
 drivers/gpu/drm/panel/panel-innolux-p079zca.c  |   9 +-
 drivers/gpu/drm/panel/panel-lg-sw43408.c       |  74 +--
 drivers/gpu/drm/panel/panel-novatek-nt36672e.c | 597 ++++++++++++-------------
 include/drm/drm_mipi_dsi.h                     |  21 +
 7 files changed, 583 insertions(+), 457 deletions(-)
---
base-commit: 7dd7a948b03724e4c63271bd96830059bc62a1ef
change-id: 20240510-dsi-panels-upd-api-479adb2b0e01

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


