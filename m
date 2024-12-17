Return-Path: <linux-kernel+bounces-448355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C169F3F02
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F621890E2D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C5874C14;
	Tue, 17 Dec 2024 00:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dU22ezaa"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65BF142E7C
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734396048; cv=none; b=LT/Al/kngPle6KQu3DTuNaIpIT49zn0/MCif5tRangG768zrSVZp559FQFE3GUfJXGScHw6Yu+VONnhPTAcZR+LRgJ4gze7C7znk1w6HMm+0nQPBPzdCGrE8t2spNURrwzdVdioSC/7hiajSFwnIq1QCBSdSKuLkiM6WxT/gxNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734396048; c=relaxed/simple;
	bh=jOa+xmrHN60EcTtWZxceM55LJJb7yZ7lw0Rtlyo5CRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I0GyFJh+wgi+EfmwNTQDkquzLMeqdD4sUEwyYTNn+PzJNT+PtZ0K0OMxtBFYqT1starms6tbRsB1rQu2p4mEX0WLHoXc+Ekg3FCXDq7CajcPJAxVOtZQlYSUzOo09x6YUs56wma1fq6uZVaBp7QS5K90oHqwb5KCgt74ZnN1l4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dU22ezaa; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53e3a37ae07so5137048e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734396044; x=1735000844; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzOQetYap6JlXujjWm1yaqFwEQG+fs4gdKxS6/azxrk=;
        b=dU22ezaa1x6bgV+L356j+9doHYVmRrHXb5UKXOXHSVBCNhyprpXtPS1Nxa4XuRrWXM
         00PsWkSZW0SkfezB0viQzfe5Ejx2FdJ4oGJk6nLDBsmu5vTxKB/5CRTlhklrvdWyfXVG
         EVSU6YnwFl97opd1WL14642eCse69Q7Qi8NzD31YzQcbEdCsLLyJ3UFXSj0i3AVUuz4m
         qU/wL/CYXjGLW+f4z+0bJRFphE2ng7tZicBW6UMifUxXHUvCEXhJHheobpJ9+SoHnI/v
         Dod08z/wFk9DcOrutJrpyndrhwatK4k6+Yo44C0b6zPd2kvu0e8HgipBcTQtPpIwh47H
         Mv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734396044; x=1735000844;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzOQetYap6JlXujjWm1yaqFwEQG+fs4gdKxS6/azxrk=;
        b=C4Il6elDWVkJJLW+790Vh10Yoci9lq3ZGxEB23K6exkIWCdBL1Kqfu1xnbZRG7HHZX
         5cGdiVKbyX766wLxNYuLc6ZiCgHK8iw2dpQpS5b8dfMhW4D505Ps8eWHipO5MHOqa92n
         2r1T8XUtUDzF/5xr2PefoT9WM3C0B8+DLvrwv34PDV6MENWgFdv9K28k6TsQdORHKheI
         1BtNjkaI9FhfIU+GtRKw/+tOoeRdS9nle/Wi6wgwWgE2GoMUiKBkKV/O7I9zeoIHYGwD
         x3YKLdumBemwJV2MJ28GedjM2JzHnB0CPNtgJn+Jp14gtPQIeTLJRJAZHfXC6XDPuCSA
         HeUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2v5uiF09+TS0WNsqtrX7oTFzI9do5wuCFs5lXrB9rIECPZ6Jfe2SaWMS79dQLBKURp1VV+3p7O2OpvjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqjNlXHf6H9SA5+Tt792J8Yf0DiY/V2QuCcmqyfVzJU4nKxS3X
	c2t8UEhatHxh5UJvAlhSlpCTS8VESfFF3fEczDHsTDv9vywlj+BztzeBfEPiriY=
X-Gm-Gg: ASbGncvk7O/GsJDZCUoSphB7Adnrdi4Vc1gtYX5ICHl/LeiZ1xt3ONaQXDvTQtpmVD9
	O7/w0sDJXRDV58+F+U3AnqXrTp3Qw3CFGjHmm8Vsch1/ZTazwKNF5qUDW+N8BzZpWizICo0GG3+
	+EB0BakD5bY7SXBGeTKbpxJ/J/1D7AGOmpGLSA57gZXi6X5CHIS2T4PJsbEDHGCRxBDvOGD8LGZ
	LwOvCrGkPug11ncXQwem2CgrZL2cSKWwMG8bch0QVRPNYqg8sW015i8L4PZ3FtE
X-Google-Smtp-Source: AGHT+IFtRuuo2fJF2WRiUyFfticNHErCMSgKEibB8GOCt/FpctKGI+IFSd6o87o+qJVqIfNTG9ocsQ==
X-Received: by 2002:a05:6512:3188:b0:53e:349c:45b6 with SMTP id 2adb3069b0e04-54131050b2amr443087e87.17.1734396043862;
        Mon, 16 Dec 2024 16:40:43 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120ba9ab2sm1009122e87.74.2024.12.16.16.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 16:40:42 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 17 Dec 2024 02:40:28 +0200
Subject: [PATCH v7 06/10] drm/display/hdmi: implement hotplug functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-drm-bridge-hdmi-connector-v7-6-cb9df2b6a515@linaro.org>
References: <20241217-drm-bridge-hdmi-connector-v7-0-cb9df2b6a515@linaro.org>
In-Reply-To: <20241217-drm-bridge-hdmi-connector-v7-0-cb9df2b6a515@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Phong LE <ple@baylibre.com>, Inki Dae <inki.dae@samsung.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Russell King <linux@armlinux.org.uk>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5694;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=jOa+xmrHN60EcTtWZxceM55LJJb7yZ7lw0Rtlyo5CRg=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ3rCiUolXV5D50aBgykmX6M9NRqbpZhyV6jJc9qKbGaec
 D3u5bZORmMWBkYuBlkxRRafgpapMZuSwz7smFoPM4iVCWQKAxenAExkkQkHw7I/GXvq5uvveN10
 RzyEe9nZK20WF20Dl799ZtBjUrOe33DWpP5jC7RDGMrWrvujfs6tVKXNpv3zynfrvPXicoOmr/f
 Va/GbLuJX9XjNvBehy1jULC7nt8/4ufBtZ5zbQhvu9YIWzvN28j5Rfs26+6/RPHXO7lKrVaFSvc
 9lmV4+zme5aXCiwp/D2HO+i2KXeNfvoGkS+hsfcx+8+uuku2aDnpmLfkJZ9zk3LfNJczO7df5na
 +8IX5y6fH5g0Zy5tnlf5f9K7JZZLCGy8+a+6xdrDis0+L3/L3W5OvLibJvroV+DW3b9u3/+baHS
 7nTrO27X3wZNO/Up6apjZg/bfh73Qt8wTTauV+xujlJHAQ==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The HDMI Connectors need to perform a variety of tasks when the HDMI
connector state changes. Such tasks include setting or invalidating CEC
address, notifying HDMI codec driver, updating scrambler data, etc.

Implementing such tasks in a driver-specific callbacks is error prone.
Start implementing the generic helper function (currently handling only
the HDMI Codec framework) to be used by drivers utilizing HDMI Connector
framework.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 56 +++++++++++++++++++++++++
 include/drm/display/drm_hdmi_state_helper.h     |  5 +++
 include/drm/drm_connector.h                     | 16 +++++++
 3 files changed, 77 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 80bf2829ba89b5f84fed4fa9eb1d6302e10a4f9e..e175c0eaa1cdc0b8b8b8408bdc3fdcf49067c634 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -769,3 +769,59 @@ drm_atomic_helper_connector_hdmi_clear_audio_infoframe(struct drm_connector *con
 	return ret;
 }
 EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_clear_audio_infoframe);
+
+static void
+drm_atomic_helper_connector_hdmi_update(struct drm_connector *connector,
+					enum drm_connector_status status)
+{
+	const struct drm_edid *drm_edid;
+
+	if (status == connector_status_disconnected) {
+		// TODO: also handle CEC and scramber, HDMI sink disconnected.
+		drm_connector_hdmi_codec_plugged_notify(connector, false);
+	}
+
+	if (connector->hdmi.funcs->read_edid)
+		drm_edid = connector->hdmi.funcs->read_edid(connector);
+	else
+		drm_edid = drm_edid_read(connector);
+
+	drm_edid_connector_update(connector, drm_edid);
+
+	drm_edid_free(drm_edid);
+
+	if (status == connector_status_connected) {
+		// TODO: also handle CEC and scramber, HDMI sink is now connected.
+		drm_connector_hdmi_codec_plugged_notify(connector, true);
+	}
+}
+
+/**
+ * drm_atomic_helper_connector_hdmi_hotplug - Handle the hotplug event for the HDMI connector
+ * @connector: A pointer to the HDMI connector
+ * @status: Connection status
+ *
+ * This function should be called as a part of the .detect() / .detect_ctx()
+ * callbacks, updating the HDMI-specific connector's data.
+ */
+void drm_atomic_helper_connector_hdmi_hotplug(struct drm_connector *connector,
+					      enum drm_connector_status status)
+{
+	drm_atomic_helper_connector_hdmi_update(connector, status);
+}
+EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_hotplug);
+
+/**
+ * drm_atomic_helper_connector_hdmi_force - HDMI Connector implementation of the force callback
+ * @connector: A pointer to the HDMI connector
+ *
+ * This function implements the .force() callback for the HDMI connectors. It
+ * can either be used directly as the callback or should be called from within
+ * the .force() callback implementation to maintain the HDMI-specific
+ * connector's data.
+ */
+void drm_atomic_helper_connector_hdmi_force(struct drm_connector *connector)
+{
+	drm_atomic_helper_connector_hdmi_update(connector, connector->status);
+}
+EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_force);
diff --git a/include/drm/display/drm_hdmi_state_helper.h b/include/drm/display/drm_hdmi_state_helper.h
index d6d65da6d8f9ee46de33114cce2d6fbe6098a862..9ae19f3caf727f9a0fe06e6afe5fc46db924444f 100644
--- a/include/drm/display/drm_hdmi_state_helper.h
+++ b/include/drm/display/drm_hdmi_state_helper.h
@@ -8,6 +8,8 @@ struct drm_connector;
 struct drm_connector_state;
 struct hdmi_audio_infoframe;
 
+enum drm_connector_status;
+
 void __drm_atomic_helper_connector_hdmi_reset(struct drm_connector *connector,
 					      struct drm_connector_state *new_conn_state);
 
@@ -19,6 +21,9 @@ int drm_atomic_helper_connector_hdmi_update_audio_infoframe(struct drm_connector
 int drm_atomic_helper_connector_hdmi_clear_audio_infoframe(struct drm_connector *connector);
 int drm_atomic_helper_connector_hdmi_update_infoframes(struct drm_connector *connector,
 						       struct drm_atomic_state *state);
+void drm_atomic_helper_connector_hdmi_hotplug(struct drm_connector *connector,
+					      enum drm_connector_status status);
+void drm_atomic_helper_connector_hdmi_force(struct drm_connector *connector);
 
 enum drm_mode_status
 drm_hdmi_connector_mode_valid(struct drm_connector *connector,
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 536d604b6fb27368c43805a2ecf57fac06b3d472..23340696bf36313952da0089b9dc24dcf772a9c5 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -45,6 +45,7 @@ struct drm_property;
 struct drm_property_blob;
 struct drm_printer;
 struct drm_privacy_screen;
+struct drm_edid;
 struct edid;
 struct hdmi_codec_daifmt;
 struct hdmi_codec_params;
@@ -1247,6 +1248,21 @@ struct drm_connector_hdmi_funcs {
 	int (*write_infoframe)(struct drm_connector *connector,
 			       enum hdmi_infoframe_type type,
 			       const u8 *buffer, size_t len);
+
+	/**
+	 * @read_edid:
+	 *
+	 * This callback is used by the framework as a replacement for reading
+	 * the EDID from connector->ddc. It is still recommended to provide
+	 * connector->ddc instead of implementing this callback. Returned EDID
+	 * should be freed via the drm_edid_free().
+	 *
+	 * The @read_edid callback is optional.
+	 *
+	 * Returns:
+	 * Valid EDID on success, NULL in case of failure.
+	 */
+	const struct drm_edid *(*read_edid)(struct drm_connector *connector);
 };
 
 /**

-- 
2.39.5


