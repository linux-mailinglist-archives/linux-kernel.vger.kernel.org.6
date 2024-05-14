Return-Path: <linux-kernel+bounces-178998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B26428C5A40
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BB40B22935
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2B4181304;
	Tue, 14 May 2024 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AZ3V2kpw"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD67180A80
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715707324; cv=none; b=MS51DtNT4pF9VPV3mTP7R8QA9O6Y1xcF2U/LdRERs7klpRSOwsmL5yOJRSsyP42zJZj3GE8XBzlzX9zJ4oE0hHc6CuHHIkovcxI4MXu6p21Nw431dy/zfeF7wwieJ3TUzeW51XuRLFhwHEVh3nif1+SUBHU6cDudPAKFxTI+yig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715707324; c=relaxed/simple;
	bh=rFj+t+3bJGiLfp8/GUavfMe47IGIXf3Axn21v0iAVrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAgu2x5g7jY644tx8fmFdZObps8HHWikQ2llWJ+OIrVwUkII5UJPI60VQ8OAtXWgNlG3nnz0bj51OOz8YFMGVJaeSpVaMtezegu9SzZ0rHhLp8KEMBsT1+WvAB03zXDxdzCfmiNlFTlQ+OFagfENVKpF7Q/Kh2pgEap6S9rhreA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AZ3V2kpw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ee954e0aa6so46335855ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 10:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715707322; x=1716312122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKR874ePRAyu7x/9s6Ii0LVvINBFCzhhReL02qJjlmI=;
        b=AZ3V2kpwt2qyb6QJYfH2eqLkYwwSJ/ibxSfr4QZC04gCxtfhUdi3plft78wExFF5Bi
         nuErAU1k5S3EWOLYUUh1oIvLf+eaoqIjw811950USUnL1Z1WPJsqHxKLrpUq+rWmlt9v
         /UrsOtKxpaABVCqaOkWxNs8MxQBiB6zIKLnz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715707322; x=1716312122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKR874ePRAyu7x/9s6Ii0LVvINBFCzhhReL02qJjlmI=;
        b=lDHFppkJJTHmr6R9hS3bAitU+wAQbwn9Fv+FDDHXXKzg4tS+Zy0HT5iClCdQDgxwhD
         hn1T/U8Op554VTAadfsOLM+QZo3H5zCYulsly8k0JmiilHTo537gNwuUnyiBzkSocA7r
         YVsXtSRawUG3N/FuzPW7KZnEI35GfXuxKqzOL2MEzJmdD6BFW9wFiwNWNiR1NyUI5qtg
         Udp9v6XvGgJtStGB90+AeOdzA04tn80Xii/BLRJdN5njeoj4lOe93msRnzEEOhUruDCg
         qgfDnH8HybjYXbwe+f6NAwS9NDB65RwywT4gJBixquXx+AqG/pF5tdr2gCVK9JTOPBwp
         MDPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsb2Xtjbzaq0QQ2QaqeByhONDTqDY3DgzAV6Ld70NyLlKu+4Fh1PX/Es4mML+XX4S8l+KMocYrGSxcDsjAaqlhZrAUTGtRlopfjhoc
X-Gm-Message-State: AOJu0YzZhLX5EmMn+XB9ZgBcKuwsch5zaA87DBoQUBTv8twZ0xtXAU+Z
	xn2l57eNtr1dzlM5yb+mc3SdEj/b3tvrlaqtzl7SXvPQAt5xJ7O9Se+vxy6CPQ==
X-Google-Smtp-Source: AGHT+IG08x+GfLQSsNNcgVmwrHZwZlQ4i+oR67/nqB6S90T6BeMOwMgalLiI9LR0SCKqKJJp5I8unQ==
X-Received: by 2002:a17:902:eb91:b0:1e4:60d4:916b with SMTP id d9443c01a7336-1ef441a7ecdmr149994355ad.64.1715707321665;
        Tue, 14 May 2024 10:22:01 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:ef10:6fdf:5041:421f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf3101csm100147575ad.121.2024.05.14.10.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 10:22:01 -0700 (PDT)
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
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/9] drm/mipi-dsi: Reduce driver bloat of mipi_dsi_*_write_seq()
Date: Tue, 14 May 2024 10:20:54 -0700
Message-ID: <20240514102056.v5.4.Id15fae80582bc74a0d4f1338987fa375738f45b9@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240514172136.1578498-1-dianders@chromium.org>
References: <20240514172136.1578498-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Through a cooperative effort between Hsin-Yi Wang and Dmitry
Baryshkov, we have realized the dev_err() in the
mipi_dsi_*_write_seq() macros was causing quite a bit of bloat to the
kernel. Let's hoist this call into drm_mipi_dsi.c by adding a "chatty"
version of the functions that includes the print. While doing this,
add a bit more comments to these macros making it clear that they
print errors and also that they return out of _the caller's_ function.

Without any changes to clients this gives a nice savings. Specifically
the macro was inlined and thus the error report call was inlined into
every call to mipi_dsi_dcs_write_seq() and
mipi_dsi_generic_write_seq(). By using a call to a "chatty" function,
the usage is reduced to one call in the chatty function and a function
call at the invoking site.

Building with my build system shows one example:

$ scripts/bloat-o-meter \
  .../before/panel-novatek-nt36672e.ko \
  .../after/panel-novatek-nt36672e.ko
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-4404 (-4404)
Function                                     old     new   delta
nt36672e_1080x2408_60hz_init               10640    6236   -4404
Total: Before=15055, After=10651, chg -29.25%

Note that given the change in location of the print it's harder to
include the "cmd" in the printout for mipi_dsi_dcs_write_seq() since,
theoretically, someone could call the new chatty function with a
zero-size array and it would be illegal to dereference data[0].
There's a printk format to print the whole buffer and this is probably
more useful for debugging anyway. Given that we're doing this for
mipi_dsi_dcs_write_seq(), let's also print the buffer for
mipi_dsi_generic_write_seq() in the error case.

It should be noted that the current consensus of DRM folks is that the
mipi_dsi_*_write_seq() should be deprecated due to the non-intuitive
return behavior. A future patch will formally mark them as deprecated
and provide an alternative.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v5:
- Fix comment dev_err_ratelimited() => dev_err().

Changes in v4:
- Update wording as per Linus W.

Changes in v3:
- Rebased upon patch to remove ratelimit of prints.

Changes in v2:
- Add some comments to the macros about printing and returning.
- Change the way err value is handled in prep for next patch.
- Modify commit message now that this is part of a series.
- Rebased upon patches to avoid theoretical int overflow.

 drivers/gpu/drm/drm_mipi_dsi.c | 56 ++++++++++++++++++++++++++++++++++
 include/drm/drm_mipi_dsi.h     | 47 +++++++++++++++-------------
 2 files changed, 82 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 795001bb7ff1..4d2685d5a6e0 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -764,6 +764,34 @@ ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
 }
 EXPORT_SYMBOL(mipi_dsi_generic_write);
 
+/**
+ * mipi_dsi_generic_write_chatty() - mipi_dsi_generic_write() w/ an error log
+ * @dsi: DSI peripheral device
+ * @payload: buffer containing the payload
+ * @size: size of payload buffer
+ *
+ * Like mipi_dsi_generic_write() but includes a dev_err()
+ * call for you and returns 0 upon success, not the number of bytes sent.
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int mipi_dsi_generic_write_chatty(struct mipi_dsi_device *dsi,
+				  const void *payload, size_t size)
+{
+	struct device *dev = &dsi->dev;
+	ssize_t ret;
+
+	ret = mipi_dsi_generic_write(dsi, payload, size);
+	if (ret < 0) {
+		dev_err(dev, "sending generic data %*ph failed: %zd\n",
+			(int)size, payload, ret);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(mipi_dsi_generic_write_chatty);
+
 /**
  * mipi_dsi_generic_read() - receive data using a generic read packet
  * @dsi: DSI peripheral device
@@ -852,6 +880,34 @@ ssize_t mipi_dsi_dcs_write_buffer(struct mipi_dsi_device *dsi,
 }
 EXPORT_SYMBOL(mipi_dsi_dcs_write_buffer);
 
+/**
+ * mipi_dsi_dcs_write_buffer_chatty - mipi_dsi_dcs_write_buffer() w/ an error log
+ * @dsi: DSI peripheral device
+ * @data: buffer containing data to be transmitted
+ * @len: size of transmission buffer
+ *
+ * Like mipi_dsi_dcs_write_buffer() but includes a dev_err()
+ * call for you and returns 0 upon success, not the number of bytes sent.
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int mipi_dsi_dcs_write_buffer_chatty(struct mipi_dsi_device *dsi,
+				     const void *data, size_t len)
+{
+	struct device *dev = &dsi->dev;
+	ssize_t ret;
+
+	ret = mipi_dsi_dcs_write_buffer(dsi, data, len);
+	if (ret < 0) {
+		dev_err(dev, "sending dcs data %*ph failed: %zd\n",
+			(int)len, data, ret);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_write_buffer_chatty);
+
 /**
  * mipi_dsi_dcs_write() - send DCS write command
  * @dsi: DSI peripheral device
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 67967be48dbd..6d68d9927f46 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -256,6 +256,8 @@ int mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
 
 ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
 			       size_t size);
+int mipi_dsi_generic_write_chatty(struct mipi_dsi_device *dsi,
+				  const void *payload, size_t size);
 ssize_t mipi_dsi_generic_read(struct mipi_dsi_device *dsi, const void *params,
 			      size_t num_params, void *data, size_t size);
 
@@ -279,6 +281,8 @@ enum mipi_dsi_dcs_tear_mode {
 
 ssize_t mipi_dsi_dcs_write_buffer(struct mipi_dsi_device *dsi,
 				  const void *data, size_t len);
+int mipi_dsi_dcs_write_buffer_chatty(struct mipi_dsi_device *dsi,
+				     const void *data, size_t len);
 ssize_t mipi_dsi_dcs_write(struct mipi_dsi_device *dsi, u8 cmd,
 			   const void *data, size_t len);
 ssize_t mipi_dsi_dcs_read(struct mipi_dsi_device *dsi, u8 cmd, void *data,
@@ -311,38 +315,39 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
 
 /**
  * mipi_dsi_generic_write_seq - transmit data using a generic write packet
+ *
+ * This macro will print errors for you and will RETURN FROM THE CALLING
+ * FUNCTION (yes this is non-intuitive) upon error.
+ *
  * @dsi: DSI peripheral device
  * @seq: buffer containing the payload
  */
-#define mipi_dsi_generic_write_seq(dsi, seq...)                           \
-	do {                                                              \
-		static const u8 d[] = { seq };                            \
-		struct device *dev = &dsi->dev;                           \
-		ssize_t ret;                                              \
-		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));      \
-		if (ret < 0) {                                            \
-			dev_err(dev, "transmit data failed: %zd\n", ret); \
-			return ret;                                       \
-		}                                                         \
+#define mipi_dsi_generic_write_seq(dsi, seq...)                                \
+	do {                                                                   \
+		static const u8 d[] = { seq };                                 \
+		int ret;                                                       \
+		ret = mipi_dsi_generic_write_chatty(dsi, d, ARRAY_SIZE(d));    \
+		if (ret < 0)                                                   \
+			return ret;                                            \
 	} while (0)
 
 /**
  * mipi_dsi_dcs_write_seq - transmit a DCS command with payload
+ *
+ * This macro will print errors for you and will RETURN FROM THE CALLING
+ * FUNCTION (yes this is non-intuitive) upon error.
+ *
  * @dsi: DSI peripheral device
  * @cmd: Command
  * @seq: buffer containing data to be transmitted
  */
-#define mipi_dsi_dcs_write_seq(dsi, cmd, seq...)                            \
-	do {                                                                \
-		static const u8 d[] = { cmd, seq };                         \
-		struct device *dev = &dsi->dev;                             \
-		ssize_t ret;                                                \
-		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));     \
-		if (ret < 0) {                                              \
-			dev_err(dev, "sending command %#02x failed: %zd\n", \
-				cmd, ret);                                  \
-			return ret;                                         \
-		}                                                           \
+#define mipi_dsi_dcs_write_seq(dsi, cmd, seq...)                               \
+	do {                                                                   \
+		static const u8 d[] = { cmd, seq };                            \
+		int ret;                                                       \
+		ret = mipi_dsi_dcs_write_buffer_chatty(dsi, d, ARRAY_SIZE(d)); \
+		if (ret < 0)                                                   \
+			return ret;                                            \
 	} while (0)
 
 /**
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


