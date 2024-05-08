Return-Path: <linux-kernel+bounces-173817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 060748C05F2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04B8284114
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8722131BAD;
	Wed,  8 May 2024 20:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J8tHLvvi"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB89B13281B
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 20:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715201607; cv=none; b=EUn+T0Jaq5XKUIEfYT1sgUf6Em/d+UAGDffkQYMh8ebOdc8LkqOyFz1Ly+4kpLvFfDSdhN7SV72Q1czGqoRBrku0/lg63qAJlA7ja78NTx+hUEFqifn9nZNnQvBnWAdH4mgcnv2RvYCoHRm7GgqnSYRPOQ/tco4xCiewunp9QE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715201607; c=relaxed/simple;
	bh=CqNHX9JWyhE8yB/L0439PfYYQCLxog5tUZhwe2qQH8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAyXm83KKWXVFLBLsON6sAPEncarZY2HObW9xMneAHpDz+WBIYWZgFpbT8qrCZUB36QpdsU87alrw8Pnd/HXzFKMZNrMBWaBCCGEroclNjXjKD0bMJEnQ6Y3WszXWCiDHuqYmo8C1Q16zMLU3LwFlgH3Dfmr5898O1BOTgRoXTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J8tHLvvi; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2b37731c118so188894a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 13:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715201605; x=1715806405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzcpGszDYfYDvpAtJ9I5+W4SIWDBCKlbuPhkejfhvkU=;
        b=J8tHLvviQ21vFFgPZ5dxS7dsr5XkDQ0jNq+Li6PgZt95PeNgOhPdUZfU76fCW0kLII
         EdG96yUugpm3sU13arSklB+j8Z/wuHJJCt6iJWJjaq5/kJHrtfbsieHxQ1BlS4kO37R0
         bb7d4DqWel0UeY/yH8pbS55zYptzJbY7xmZmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715201605; x=1715806405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzcpGszDYfYDvpAtJ9I5+W4SIWDBCKlbuPhkejfhvkU=;
        b=P+lyIbLMoRvzlZYB6AHPO/eBVoESQKuCcmFcKvs60IGPORWHFTG7fxVT+e9xu8vS6J
         ruQorRYEZGw3lnJHPMRW6XS4WR9EhPH9d+eYb6Ko+8MrIWevh3DzmrfENPi+2QnSvyJM
         HrApkcgMGSAtx8q2z4bT6hRCXd617GunJcQnh2HK7QieFbsF/L2Gb5aTVBiNhUmVDvVT
         e2gvxzGdqJN8U/Dax+tA59iPHJEgp1m8taFZFX1B92G24bLO/9udvSUOjHyXjG04CDi6
         at51BSKxJ7i4GAWmeyywTgNCrOAkJGZ5v+xO5Y5h/PHanXsE+y4YcjJI2q1f2eWjiDZm
         t0pw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ5/izy5JhViYZO+J8i6Ud+fhQ/H3C9SBYjGyNo4kpF8UC9rbbmU2Rtu7/CwaSOKKevnBg5VUGxgsdELrY6turImtl0M92FlDBNTv/
X-Gm-Message-State: AOJu0YyJMaST+HqRrhg20JuPzzK4T+DU0PzeRT86MTaQMymPtdQDZYRl
	uZhSAYhxVV2fTvWOEAJsUdtLNgQ6Rvd1yp0kH41i1AlXcMvUUR3ufX/EM8hB2w==
X-Google-Smtp-Source: AGHT+IHBvDm5AOB1l7xVKhM38HiKJm0yG0yn39vA4dLcvbwfI+I4vyt3bJTsCzuKdgtRxySdr6+LTQ==
X-Received: by 2002:a17:90b:b17:b0:2b4:36d7:b6ad with SMTP id 98e67ed59e1d1-2b61639c45dmr3572050a91.4.1715201604990;
        Wed, 08 May 2024 13:53:24 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:40f4:feca:59e0:d3ca])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67126ad51sm6887a91.25.2024.05.08.13.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 13:53:24 -0700 (PDT)
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
	Jonathan Corbet <corbet@lwn.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/9] drm/mipi-dsi: Introduce mipi_dsi_*_write_seq_multi()
Date: Wed,  8 May 2024 13:51:47 -0700
Message-ID: <20240508135148.v4.5.Ie94246c30fe95101e0e26dd5f96e976dbeb8f242@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240508205222.2251854-1-dianders@chromium.org>
References: <20240508205222.2251854-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current mipi_dsi_*_write_seq() macros are non-intutitive because
they contain a hidden "return" statement that will return out of the
_caller_ of the macro. Let's mark them as deprecated and instead
introduce some new macros that are more intuitive.

These new macros are less optimal when an error occurs but should
behave more optimally when there is no error. Specifically these new
macros cause smaller code to get generated and the code size savings
(less to fetch from RAM, less cache space used, less RAM used) are
important. Since the error case isn't something we need to optimize
for and these new macros are easier to understand and more flexible,
they should be used.

After converting to use these new functions, one example shows some
nice savings while also being easier to understand.

$ scripts/bloat-o-meter \
  ...after/panel-novatek-nt36672e.ko \
  ...ctx/panel-novatek-nt36672e.ko
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-988 (-988)
Function                                     old     new   delta
nt36672e_1080x2408_60hz_init                6236    5248    -988
Total: Before=10651, After=9663, chg -9.28%

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Right now this patch introduces two new functions in drm_mipi_dsi.c.
Alternatively we could have changed the prototype of the "chatty"
functions and made the deprecated macros adapt to the new prototype.
While this sounds nice, it bloated callers of the deprecated functioin
a bit because it caused the compiler to emit less optimal code. It
doesn't seem terrible to add two more functions, so I went that
way. There may be cases where callers who aren't writing many
sequences prefer to use the "chatty" versions anyway.

(no changes since v3)

Changes in v3:
- Add a TODO item for cleaning up the deprecated macros/functions.
- Inline kerneldoc comments for struct mipi_dsi_multi_context.

Changes in v2:
- New

 Documentation/gpu/todo.rst     | 18 ++++++++++
 drivers/gpu/drm/drm_mipi_dsi.c | 56 ++++++++++++++++++++++++++++++
 include/drm/drm_mipi_dsi.h     | 62 ++++++++++++++++++++++++++++++++++
 3 files changed, 136 insertions(+)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index e2a0585915b3..2734b8a34541 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -494,6 +494,24 @@ Contact: Douglas Anderson <dianders@chromium.org>
 
 Level: Starter/Intermediate
 
+Transition away from using mipi_dsi_*_write_seq()
+-------------------------------------------------
+
+The macros mipi_dsi_generic_write_seq() and mipi_dsi_dcs_write_seq() are
+non-intuitive because, if there are errors, they return out of the *caller's*
+function. We should move all callers to use mipi_dsi_generic_write_seq_multi()
+and mipi_dsi_dcs_write_seq_multi() macros instead.
+
+Once all callers are transitioned, the macros and the functions that they call,
+mipi_dsi_generic_write_chatty() and mipi_dsi_dcs_write_buffer_chatty(), can
+probably be removed. Alternatively, if people feel like the _multi() variants
+are overkill for some use cases, we could keep the mipi_dsi_*_write_seq()
+variants but change them not to return out of the caller.
+
+Contact: Douglas Anderson <dianders@chromium.org>
+
+Level: Starter
+
 
 Core refactorings
 =================
diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 8593d9ed5891..d2957cb692d3 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -792,6 +792,34 @@ int mipi_dsi_generic_write_chatty(struct mipi_dsi_device *dsi,
 }
 EXPORT_SYMBOL(mipi_dsi_generic_write_chatty);
 
+/**
+ * mipi_dsi_generic_write_multi() - mipi_dsi_generic_write_chatty() w/ accum_err
+ * @ctx: Context for multiple DSI transactions
+ * @payload: buffer containing the payload
+ * @size: size of payload buffer
+ *
+ * Like mipi_dsi_generic_write_chatty() but deals with errors in a way that
+ * makes it convenient to make several calls in a row.
+ */
+void mipi_dsi_generic_write_multi(struct mipi_dsi_multi_context *ctx,
+				  const void *payload, size_t size)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	ssize_t ret;
+
+	if (ctx->accum_err)
+		return;
+
+	ret = mipi_dsi_generic_write(dsi, payload, size);
+	if (ret < 0) {
+		ctx->accum_err = ret;
+		dev_err(dev, "sending generic data %*ph failed: %d\n",
+			(int)size, payload, ctx->accum_err);
+	}
+}
+EXPORT_SYMBOL(mipi_dsi_generic_write_multi);
+
 /**
  * mipi_dsi_generic_read() - receive data using a generic read packet
  * @dsi: DSI peripheral device
@@ -908,6 +936,34 @@ int mipi_dsi_dcs_write_buffer_chatty(struct mipi_dsi_device *dsi,
 }
 EXPORT_SYMBOL(mipi_dsi_dcs_write_buffer_chatty);
 
+/**
+ * mipi_dsi_dcs_write_buffer_multi - mipi_dsi_dcs_write_buffer_chatty() w/ accum_err
+ * @ctx: Context for multiple DSI transactions
+ * @data: buffer containing data to be transmitted
+ * @len: size of transmission buffer
+ *
+ * Like mipi_dsi_dcs_write_buffer_chatty() but deals with errors in a way that
+ * makes it convenient to make several calls in a row.
+ */
+void mipi_dsi_dcs_write_buffer_multi(struct mipi_dsi_multi_context *ctx,
+				     const void *data, size_t len)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	ssize_t ret;
+
+	if (ctx->accum_err)
+		return;
+
+	ret = mipi_dsi_dcs_write_buffer(dsi, data, len);
+	if (ret < 0) {
+		ctx->accum_err = ret;
+		dev_err(dev, "sending dcs data %*ph failed: %d\n",
+			(int)len, data, ctx->accum_err);
+	}
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_write_buffer_multi);
+
 /**
  * mipi_dsi_dcs_write() - send DCS write command
  * @dsi: DSI peripheral device
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 6d68d9927f46..5e9cad541bd6 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -197,6 +197,27 @@ struct mipi_dsi_device {
 	struct drm_dsc_config *dsc;
 };
 
+/**
+ * struct mipi_dsi_multi_context - Context to call multiple MIPI DSI funcs in a row
+ */
+struct mipi_dsi_multi_context {
+	/**
+	 * @dsi: Pointer to the MIPI DSI device
+	 */
+	struct mipi_dsi_device *dsi;
+
+	/**
+	 * @accum_err: Storage for the accumulated error over the multiple calls
+	 *
+	 * Init to 0. If a function encounters an error then the error code
+	 * will be stored here. If you call a function and this points to a
+	 * non-zero value then the function will be a noop. This allows calling
+	 * a function many times in a row and just checking the error at the
+	 * end to see if any of them failed.
+	 */
+	int accum_err;
+};
+
 #define MIPI_DSI_MODULE_PREFIX "mipi-dsi:"
 
 #define to_mipi_dsi_device(__dev)	container_of_const(__dev, struct mipi_dsi_device, dev)
@@ -258,6 +279,8 @@ ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
 			       size_t size);
 int mipi_dsi_generic_write_chatty(struct mipi_dsi_device *dsi,
 				  const void *payload, size_t size);
+void mipi_dsi_generic_write_multi(struct mipi_dsi_multi_context *ctx,
+				  const void *payload, size_t size);
 ssize_t mipi_dsi_generic_read(struct mipi_dsi_device *dsi, const void *params,
 			      size_t num_params, void *data, size_t size);
 
@@ -283,6 +306,8 @@ ssize_t mipi_dsi_dcs_write_buffer(struct mipi_dsi_device *dsi,
 				  const void *data, size_t len);
 int mipi_dsi_dcs_write_buffer_chatty(struct mipi_dsi_device *dsi,
 				     const void *data, size_t len);
+void mipi_dsi_dcs_write_buffer_multi(struct mipi_dsi_multi_context *ctx,
+				     const void *data, size_t len);
 ssize_t mipi_dsi_dcs_write(struct mipi_dsi_device *dsi, u8 cmd,
 			   const void *data, size_t len);
 ssize_t mipi_dsi_dcs_read(struct mipi_dsi_device *dsi, u8 cmd, void *data,
@@ -319,6 +344,9 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
  * This macro will print errors for you and will RETURN FROM THE CALLING
  * FUNCTION (yes this is non-intuitive) upon error.
  *
+ * Because of the non-intuitive return behavior, THIS MACRO IS DEPRECATED.
+ * Please replace calls of it with mipi_dsi_generic_write_seq_multi().
+ *
  * @dsi: DSI peripheral device
  * @seq: buffer containing the payload
  */
@@ -331,12 +359,30 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
 			return ret;                                            \
 	} while (0)
 
+/**
+ * mipi_dsi_generic_write_seq_multi - transmit data using a generic write packet
+ *
+ * This macro will print errors for you and error handling is optimized for
+ * callers that call this multiple times in a row.
+ *
+ * @ctx: Context for multiple DSI transactions
+ * @seq: buffer containing the payload
+ */
+#define mipi_dsi_generic_write_seq_multi(ctx, seq...)                \
+	do {                                                         \
+		static const u8 d[] = { seq };                       \
+		mipi_dsi_generic_write_multi(ctx, d, ARRAY_SIZE(d)); \
+	} while (0)
+
 /**
  * mipi_dsi_dcs_write_seq - transmit a DCS command with payload
  *
  * This macro will print errors for you and will RETURN FROM THE CALLING
  * FUNCTION (yes this is non-intuitive) upon error.
  *
+ * Because of the non-intuitive return behavior, THIS MACRO IS DEPRECATED.
+ * Please replace calls of it with mipi_dsi_dcs_write_seq_multi().
+ *
  * @dsi: DSI peripheral device
  * @cmd: Command
  * @seq: buffer containing data to be transmitted
@@ -350,6 +396,22 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
 			return ret;                                            \
 	} while (0)
 
+/**
+ * mipi_dsi_dcs_write_seq_multi - transmit a DCS command with payload
+ *
+ * This macro will print errors for you and error handling is optimized for
+ * callers that call this multiple times in a row.
+ *
+ * @ctx: Context for multiple DSI transactions
+ * @cmd: Command
+ * @seq: buffer containing data to be transmitted
+ */
+#define mipi_dsi_dcs_write_seq_multi(ctx, cmd, seq...)                  \
+	do {                                                            \
+		static const u8 d[] = { cmd, seq };                     \
+		mipi_dsi_dcs_write_buffer_multi(ctx, d, ARRAY_SIZE(d)); \
+	} while (0)
+
 /**
  * struct mipi_dsi_driver - DSI driver
  * @driver: device driver model driver
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


