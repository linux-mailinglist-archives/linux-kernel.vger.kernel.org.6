Return-Path: <linux-kernel+bounces-267534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B7F94128E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3338A1C20A03
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3921A0702;
	Tue, 30 Jul 2024 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0YQUy07G"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1BC19F467
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343841; cv=none; b=fjCg8+TszA2EpVISBUVqFAOL7tTuB+6wiVaCUoDrn9tcdPMS1VCi0vguDC16k7YbPMLkf4mSxesQmvRznOWOTlJEuXScHuTj2bb/IaCdHeth7F1gYUxCe+phpyR6sg2TTnDJFML3yfMgAVBFI6LUdgzjnh9SUVw+mdWgg4bde2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343841; c=relaxed/simple;
	bh=ND1Z2QSEc8ze0NZoRpWgZwD08lwNK0gF0FUUxf0STs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSKsHPM845hGqV3gmZyq6iT+g75UFSzgHCDTHkHaqseqKEGlTHaD9ZZaQEH7Mhn5Bah5BeaMI85HO5zbt0EpusDt0WC2Ov0vP5jaOrG/I5SjFnYZcjvSpwypHDIbekS0ga1zbum2mWUM9WUbRIksYZXKwCd3FwVrKbLyOsAYBH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0YQUy07G; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-36858357bb7so2107511f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 05:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722343838; x=1722948638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FpQIo3/nECT6BJG3YrzIm131E/DRxLPrAjjYNTEWJA=;
        b=0YQUy07G9qEIjZ503mj3yKWW+kP7EmVd1PnO8cex/Epa/S2hvHwrtgSlVHBJ6h5yJ5
         rfEEezCKKBV+fZ5p0wsoGpiFNzhCQ69evl5F9dFEGpPp9UvW8He7wuAiU4IXa/Ir5M8y
         RzZrTC0z7SBbFr7c6QoFbgNAgKuwv66VzsAzp0FPkgvhkn0Ei214Ami7Csv0Nw/DIetU
         Wx2WtVWZ9OEjLuCEGJJgjlS4WvtWX7iQYnkV7dbfEu2ab3HL7H2ZO7e57muAqURjzAyh
         i4Rb2ZRNVYhxFcqdVp6WvH/4iqnyjpP5kZJ0WhemRcicG6Hv5nhSPtTscrT52BtVQK22
         OXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722343838; x=1722948638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FpQIo3/nECT6BJG3YrzIm131E/DRxLPrAjjYNTEWJA=;
        b=TZyyVJ0iuWSOMeiY6tap5C3IyiHBkfgFQPEPAATMxLpmfFupNCGkYZwuoLJLmzr2N2
         /R51gTvmexFiWIvEXm7dWQ+UTi2XwkyMbnDRntXeP1LjgwGN6z1sdmf3Qg4KvdwD/d1l
         VrZlGRfofCpySuxOYvUeKFcm7F27ItGYkeRcljh8+PwbFYVNqXah01S1DH+MsodSOOTm
         bEY8D2XDSQgf9aHtE9HFdC/1hnrmpr26qILtOEkzn1DIhT9E4Z5+IByXVyORiu+V0L9B
         b3JrnVbmz8ZSXnGj89dN/3VihR6X/tlb0aSBsdH4+4wp+50bFKv8p2+174RpknqZnns+
         h9yg==
X-Forwarded-Encrypted: i=1; AJvYcCXwNZkYaYAd9o3cGNod516Nob5FIVmMZFGv0mvzkS4puJge5H2Wbcujo1IQGpklUaH6Y516TBF/+vMux8mgH6idtrVz+8AGRCywZva2
X-Gm-Message-State: AOJu0YyWuHyfIrUurlpdZEPWmlzXggbO7wc9KlG5Uzw/mABMLTVxWL9W
	/8MkUhpKOnYSh1BrP8L4uzw6ojW1Q21/BADsAS5QnBJ5nrS9WPYgSfufZxIScUk=
X-Google-Smtp-Source: AGHT+IFYKETa1maYsbR/lXJacP4Dulbw5t+LnfR9HzWYE5KbSp8mR/aHH1IRgvWxRpjGsQ/h6Ss4mQ==
X-Received: by 2002:a05:6000:4029:b0:36b:63b5:ed64 with SMTP id ffacd0b85a97d-36b63b5f8e9mr8234742f8f.40.1722343837924;
        Tue, 30 Jul 2024 05:50:37 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:291e:4a48:358e:6f49])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42805730e68sm216521405e9.9.2024.07.30.05.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 05:50:37 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	dri-devel@lists.freedesktop.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] drm/meson: dw-hdmi: fix incorrect comment in suspend
Date: Tue, 30 Jul 2024 14:50:14 +0200
Message-ID: <20240730125023.710237-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730125023.710237-1-jbrunet@baylibre.com>
References: <20240730125023.710237-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Comment in suspend says TOP is put in suspend, but the register
poke following is actually de-asserting the reset, like in init.

It is doing the opposite of what the comment says.

Align the comment with what the code is doing for now and add
a FIXME note to sort this out later

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 2890796f9d49..5cd3264ab874 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -751,7 +751,7 @@ static int __maybe_unused meson_dw_hdmi_pm_suspend(struct device *dev)
 	if (!meson_dw_hdmi)
 		return 0;
 
-	/* Reset TOP */
+	/* FIXME: This actually bring top out reset on suspend, why ? */
 	meson_dw_hdmi->data->top_write(meson_dw_hdmi,
 				       HDMITX_TOP_SW_RESET, 0);
 
-- 
2.43.0


