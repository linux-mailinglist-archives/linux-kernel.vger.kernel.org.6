Return-Path: <linux-kernel+bounces-442383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1AE9EDC19
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99A11889F83
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04FC1FF60F;
	Wed, 11 Dec 2024 23:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s8Zow32v"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73F21FCFD2
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 23:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960534; cv=none; b=cT/proY9innSui+fjTlNkJQ4M+u75L5Y9MgelW9dm1HsmEDmiQ9XGuaX0G4dv6IIzl08ZfXlkSb7WG9nopYo/z0u4XielWId2h616sx4gC0LuK6uu3UptQfHckcG3fzyQOWN9XZINNWPqsFZ+jq4WcSa53EYfkOnQe/NS2GFtsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960534; c=relaxed/simple;
	bh=Vlr0qCr5Qq7Z1517nTZm3+a1T2qh+w8F5jSV1/zOj3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YUHvQFjKUr2YEV9anNmoU9Be+ntm/u3gdYH9DlcZNsze71kLPvOCsZlVt7C3gp0gWjls04oPbX6ivvjtSuhrIL3GLFW8QR2AEplIC9yLddRxNJo6T7hbwo7De4C3CoXOFkyvSqeV3tqdoJoRPNPilxIoS5/chfTp63rf8m/VkcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s8Zow32v; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5401ab97206so3110e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733960530; x=1734565330; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x313+1oN08qAZdGd7VU3lvJqWcuuSJ05LvyfKdPKUXc=;
        b=s8Zow32vvLfCStvq+Dna44aAHqcD69yWngPwHswrdUB9Ldu4uZQi9h+ss7RzcGpsGN
         3Mb/pMZlcZ/xgDg9+481UKXm+k1YVY6QXuSd/b1lR06UuDnD3JsLWsMrxuHlvqZV8Rrx
         1bGWAkMxoFCSNtFGtVU2OQxcABkwrREF0wPi5ux4iSNEhCO4EwD7AAYYB/2QgxoWhUx2
         REEXB+RNRpcmCglQ53GAzqiZlY0Ymx2pVg5mh0Rk/rR9eJyD3TZcxWwOkmc85OWZfhz2
         j23Oa77CBYnRWHsy/2qfKKZtGM+aDPDK4mm1W7dGeKsoH+XELdtb++DYTnddBu4rGo3g
         3g3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733960530; x=1734565330;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x313+1oN08qAZdGd7VU3lvJqWcuuSJ05LvyfKdPKUXc=;
        b=EUHDiHDF0w6jFZBWZExMWUAkZrdmkD1QvT09HwqNroLNKynBF0XxUyHX3LuhKT9oYN
         DUy7c+ohcEbk6ysbIa7oOfRC/39ou+USJ+PKKuxBcPS86Cy0EtOkzQHW4/PzHGNrxqga
         j5KF4awiNf6BeJIxvxhuaPdtSosMUrgSSSEct22jgRoKzTzBFqIMqn+EqFE1miHGgnRr
         nO/zTV8unfswUcD/G46F7Ie+Gwf6UTiODplVaxm7Zci+S2S3jOES6WVGohC9YJ65pZuZ
         mSDThChFLIpzMNoslrfQLKzpyfNzp5xFzbRxTGAkkOw7mww+zqI1vjE+gYybm6cK3z+0
         upKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoFHuwek7mP18eYGYDNlhAKDqA1WiGKrXFLF6wQQLYZGJUd7lioZg2iQjY5qOPSGivKkFrqqtOZunQUcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt01toIyAjkAz+cYInNPcd4qfjvHE3LFnBhtGbBx+ZEWUyM/7S
	grf46tMQxCQGufvaJCO8lOAxEQL9K5JEu1tgh2REI+SEx9w3UJdQs74AfsCAXmQ=
X-Gm-Gg: ASbGncv78PaqB0DO9vj8pYpP7FPg/nYtHsr0mQAljhQ2VdYW/D36r/TS89v41KrHTZF
	+Nvy5oO6+YBXoRHZOoSi0FmOTZeQSqVYGdSBcxyMs91YVkaS3qV6E0m+K0+gmwSwoLhMJqX/3Cc
	a+umh1Pv51hPYl+x56sd5jyIOA60912cpOxONWdyzYAYI3LCUfuDPS1OT0bIFPbSMZP7menZ6n2
	GoAidnx7GXKgaICgysnBscwmvBHfBX+VpKU7bB9eodMBpkzfK4CexhJ0XhIMA==
X-Google-Smtp-Source: AGHT+IH26OPMh39KbsRKFhuG8wSJzBlGEEWgCA7nuBmFlSHnd4AwCxaEymodGbIx7APuSpKz3DrCVw==
X-Received: by 2002:a05:6512:138c:b0:53f:5e23:fb73 with SMTP id 2adb3069b0e04-5402a60a611mr1400018e87.57.1733960530010;
        Wed, 11 Dec 2024 15:42:10 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5401cc76909sm1222207e87.58.2024.12.11.15.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 15:42:08 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 12 Dec 2024 01:41:44 +0200
Subject: [PATCH v3 09/14] drm/msm/dp: use msm_dp_utils_pack_sdp_header()
 for audio packets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-fd-dp-audio-fixup-v3-9-0b1c65e7dba3@linaro.org>
References: <20241212-fd-dp-audio-fixup-v3-0-0b1c65e7dba3@linaro.org>
In-Reply-To: <20241212-fd-dp-audio-fixup-v3-0-0b1c65e7dba3@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Paloma Arellano <quic_parellan@quicinc.com>
Cc: Douglas Anderson <dianders@chromium.org>, 
 Stephen Boyd <swboyd@chromium.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11630;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Vlr0qCr5Qq7Z1517nTZm3+a1T2qh+w8F5jSV1/zOj3o=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnWiM4aF+VaG/zc4iZHV3bokJhy6sF2P596G9nL
 yNQ6oFpFM2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1ojOAAKCRCLPIo+Aiko
 1d8yB/9Z7hhwYAMeHanlRg9fnfn5ei7cQfnFBn/JM0Hvxfxx7ZRNLXHO1jg0Fm7RFULhLS2kYoN
 shTpcjOqzQGLASJ5gSsHqO/Khi49upkI9/NVnuOfp8/UorJ9tLjfzrqBHrEnlLcjcZwRKNROhmq
 vC6Bf/A7saULjdxBWdgKLYFKocrFN5q0iDmhg8zBWdZmb4436HiyJDH1OqIppun/615HeKrHeG5
 ZizHWl09IJhmFjNIf/8qZP8arns9PKFvvoqRAmQZ2nzfJJmuOCI5yDNzqrr0DeGEisoJGOUuzLt
 TazR+o09FIuw0x6U+GqLVI7g+XjcOs2LBAyBs5koKJ11VaXs
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Use msm_dp_utils_pack_sdp_header() and call msm_dp_write_link() directly
to program audio packet data. Use 0 as Packet ID, as it was not
programmed earlier.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_audio.c | 288 +++++++++-----------------------------
 1 file changed, 66 insertions(+), 222 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
index 5cbb11986460d1e4ed1890bdf66d0913e013083c..1aa52d5cc08684a49102e45ed6e40ac2b13497c7 100644
--- a/drivers/gpu/drm/msm/dp/dp_audio.c
+++ b/drivers/gpu/drm/msm/dp/dp_audio.c
@@ -14,6 +14,7 @@
 #include "dp_catalog.h"
 #include "dp_audio.h"
 #include "dp_panel.h"
+#include "dp_reg.h"
 #include "dp_display.h"
 #include "dp_utils.h"
 
@@ -28,251 +29,94 @@ struct msm_dp_audio_private {
 	struct msm_dp_audio msm_dp_audio;
 };
 
-static u32 msm_dp_audio_get_header(struct msm_dp_catalog *catalog,
-		enum msm_dp_catalog_audio_sdp_type sdp,
-		enum msm_dp_catalog_audio_header_type header)
-{
-	return msm_dp_catalog_audio_get_header(catalog, sdp, header);
-}
-
-static void msm_dp_audio_set_header(struct msm_dp_catalog *catalog,
-		u32 data,
-		enum msm_dp_catalog_audio_sdp_type sdp,
-		enum msm_dp_catalog_audio_header_type header)
-{
-	msm_dp_catalog_audio_set_header(catalog, sdp, header, data);
-}
-
 static void msm_dp_audio_stream_sdp(struct msm_dp_audio_private *audio)
 {
 	struct msm_dp_catalog *catalog = audio->catalog;
-	u32 value, new_value;
-	u8 parity_byte;
-
-	/* Config header and parity byte 1 */
-	value = msm_dp_audio_get_header(catalog,
-			DP_AUDIO_SDP_STREAM, DP_AUDIO_SDP_HEADER_1);
-
-	new_value = 0x02;
-	parity_byte = msm_dp_utils_calculate_parity(new_value);
-	value |= ((new_value << HEADER_BYTE_1_BIT)
-			| (parity_byte << PARITY_BYTE_1_BIT));
-	drm_dbg_dp(audio->drm_dev,
-			"Header Byte 1: value = 0x%x, parity_byte = 0x%x\n",
-			value, parity_byte);
-	msm_dp_audio_set_header(catalog, value,
-		DP_AUDIO_SDP_STREAM, DP_AUDIO_SDP_HEADER_1);
-
-	/* Config header and parity byte 2 */
-	value = msm_dp_audio_get_header(catalog,
-			DP_AUDIO_SDP_STREAM, DP_AUDIO_SDP_HEADER_2);
-	new_value = value;
-	parity_byte = msm_dp_utils_calculate_parity(new_value);
-	value |= ((new_value << HEADER_BYTE_2_BIT)
-			| (parity_byte << PARITY_BYTE_2_BIT));
-	drm_dbg_dp(audio->drm_dev,
-			"Header Byte 2: value = 0x%x, parity_byte = 0x%x\n",
-			value, parity_byte);
-
-	msm_dp_audio_set_header(catalog, value,
-		DP_AUDIO_SDP_STREAM, DP_AUDIO_SDP_HEADER_2);
-
-	/* Config header and parity byte 3 */
-	value = msm_dp_audio_get_header(catalog,
-			DP_AUDIO_SDP_STREAM, DP_AUDIO_SDP_HEADER_3);
-
-	new_value = audio->channels - 1;
-	parity_byte = msm_dp_utils_calculate_parity(new_value);
-	value |= ((new_value << HEADER_BYTE_3_BIT)
-			| (parity_byte << PARITY_BYTE_3_BIT));
-	drm_dbg_dp(audio->drm_dev,
-			"Header Byte 3: value = 0x%x, parity_byte = 0x%x\n",
-		value, parity_byte);
-
-	msm_dp_audio_set_header(catalog, value,
-		DP_AUDIO_SDP_STREAM, DP_AUDIO_SDP_HEADER_3);
+	struct dp_sdp_header sdp_hdr = {
+		.HB0 = 0x00,
+		.HB1 = 0x02,
+		.HB2 = 0x00,
+		.HB3 = audio->channels - 1,
+	};
+	u32 header[2];
+
+	msm_dp_utils_pack_sdp_header(&sdp_hdr, header);
+
+	msm_dp_write_link(catalog, MMSS_DP_AUDIO_STREAM_0, header[0]);
+	msm_dp_write_link(catalog, MMSS_DP_AUDIO_STREAM_1, header[1]);
 }
 
 static void msm_dp_audio_timestamp_sdp(struct msm_dp_audio_private *audio)
 {
 	struct msm_dp_catalog *catalog = audio->catalog;
-	u32 value, new_value;
-	u8 parity_byte;
-
-	/* Config header and parity byte 1 */
-	value = msm_dp_audio_get_header(catalog,
-			DP_AUDIO_SDP_TIMESTAMP, DP_AUDIO_SDP_HEADER_1);
-
-	new_value = 0x1;
-	parity_byte = msm_dp_utils_calculate_parity(new_value);
-	value |= ((new_value << HEADER_BYTE_1_BIT)
-			| (parity_byte << PARITY_BYTE_1_BIT));
-	drm_dbg_dp(audio->drm_dev,
-			"Header Byte 1: value = 0x%x, parity_byte = 0x%x\n",
-			value, parity_byte);
-	msm_dp_audio_set_header(catalog, value,
-		DP_AUDIO_SDP_TIMESTAMP, DP_AUDIO_SDP_HEADER_1);
-
-	/* Config header and parity byte 2 */
-	value = msm_dp_audio_get_header(catalog,
-			DP_AUDIO_SDP_TIMESTAMP, DP_AUDIO_SDP_HEADER_2);
-
-	new_value = 0x17;
-	parity_byte = msm_dp_utils_calculate_parity(new_value);
-	value |= ((new_value << HEADER_BYTE_2_BIT)
-			| (parity_byte << PARITY_BYTE_2_BIT));
-	drm_dbg_dp(audio->drm_dev,
-			"Header Byte 2: value = 0x%x, parity_byte = 0x%x\n",
-			value, parity_byte);
-	msm_dp_audio_set_header(catalog, value,
-		DP_AUDIO_SDP_TIMESTAMP, DP_AUDIO_SDP_HEADER_2);
-
-	/* Config header and parity byte 3 */
-	value = msm_dp_audio_get_header(catalog,
-			DP_AUDIO_SDP_TIMESTAMP, DP_AUDIO_SDP_HEADER_3);
-
-	new_value = (0x0 | (0x11 << 2));
-	parity_byte = msm_dp_utils_calculate_parity(new_value);
-	value |= ((new_value << HEADER_BYTE_3_BIT)
-			| (parity_byte << PARITY_BYTE_3_BIT));
-	drm_dbg_dp(audio->drm_dev,
-			"Header Byte 3: value = 0x%x, parity_byte = 0x%x\n",
-			value, parity_byte);
-	msm_dp_audio_set_header(catalog, value,
-		DP_AUDIO_SDP_TIMESTAMP, DP_AUDIO_SDP_HEADER_3);
+	struct dp_sdp_header sdp_hdr = {
+		.HB0 = 0x00,
+		.HB1 = 0x01,
+		.HB2 = 0x17,
+		.HB3 = 0x0 | (0x11 << 2),
+	};
+	u32 header[2];
+
+	msm_dp_utils_pack_sdp_header(&sdp_hdr, header);
+
+	msm_dp_write_link(catalog, MMSS_DP_AUDIO_TIMESTAMP_0, header[0]);
+	msm_dp_write_link(catalog, MMSS_DP_AUDIO_TIMESTAMP_1, header[1]);
 }
 
 static void msm_dp_audio_infoframe_sdp(struct msm_dp_audio_private *audio)
 {
 	struct msm_dp_catalog *catalog = audio->catalog;
-	u32 value, new_value;
-	u8 parity_byte;
-
-	/* Config header and parity byte 1 */
-	value = msm_dp_audio_get_header(catalog,
-			DP_AUDIO_SDP_INFOFRAME, DP_AUDIO_SDP_HEADER_1);
-
-	new_value = 0x84;
-	parity_byte = msm_dp_utils_calculate_parity(new_value);
-	value |= ((new_value << HEADER_BYTE_1_BIT)
-			| (parity_byte << PARITY_BYTE_1_BIT));
-	drm_dbg_dp(audio->drm_dev,
-			"Header Byte 1: value = 0x%x, parity_byte = 0x%x\n",
-			value, parity_byte);
-	msm_dp_audio_set_header(catalog, value,
-		DP_AUDIO_SDP_INFOFRAME, DP_AUDIO_SDP_HEADER_1);
-
-	/* Config header and parity byte 2 */
-	value = msm_dp_audio_get_header(catalog,
-			DP_AUDIO_SDP_INFOFRAME, DP_AUDIO_SDP_HEADER_2);
-
-	new_value = 0x1b;
-	parity_byte = msm_dp_utils_calculate_parity(new_value);
-	value |= ((new_value << HEADER_BYTE_2_BIT)
-			| (parity_byte << PARITY_BYTE_2_BIT));
-	drm_dbg_dp(audio->drm_dev,
-			"Header Byte 2: value = 0x%x, parity_byte = 0x%x\n",
-			value, parity_byte);
-	msm_dp_audio_set_header(catalog, value,
-		DP_AUDIO_SDP_INFOFRAME, DP_AUDIO_SDP_HEADER_2);
-
-	/* Config header and parity byte 3 */
-	value = msm_dp_audio_get_header(catalog,
-			DP_AUDIO_SDP_INFOFRAME, DP_AUDIO_SDP_HEADER_3);
-
-	new_value = (0x0 | (0x11 << 2));
-	parity_byte = msm_dp_utils_calculate_parity(new_value);
-	value |= ((new_value << HEADER_BYTE_3_BIT)
-			| (parity_byte << PARITY_BYTE_3_BIT));
-	drm_dbg_dp(audio->drm_dev,
-			"Header Byte 3: value = 0x%x, parity_byte = 0x%x\n",
-			new_value, parity_byte);
-	msm_dp_audio_set_header(catalog, value,
-		DP_AUDIO_SDP_INFOFRAME, DP_AUDIO_SDP_HEADER_3);
+	struct dp_sdp_header sdp_hdr = {
+		.HB0 = 0x00,
+		.HB1 = 0x84,
+		.HB2 = 0x1b,
+		.HB3 = 0x0 | (0x11 << 2),
+	};
+	u32 header[2];
+
+	msm_dp_utils_pack_sdp_header(&sdp_hdr, header);
+
+	msm_dp_write_link(catalog, MMSS_DP_AUDIO_INFOFRAME_0, header[0]);
+	msm_dp_write_link(catalog, MMSS_DP_AUDIO_INFOFRAME_1, header[1]);
 }
 
 static void msm_dp_audio_copy_management_sdp(struct msm_dp_audio_private *audio)
 {
 	struct msm_dp_catalog *catalog = audio->catalog;
-	u32 value, new_value;
-	u8 parity_byte;
-
-	/* Config header and parity byte 1 */
-	value = msm_dp_audio_get_header(catalog,
-			DP_AUDIO_SDP_COPYMANAGEMENT, DP_AUDIO_SDP_HEADER_1);
-
-	new_value = 0x05;
-	parity_byte = msm_dp_utils_calculate_parity(new_value);
-	value |= ((new_value << HEADER_BYTE_1_BIT)
-			| (parity_byte << PARITY_BYTE_1_BIT));
-	drm_dbg_dp(audio->drm_dev,
-			"Header Byte 1: value = 0x%x, parity_byte = 0x%x\n",
-			value, parity_byte);
-	msm_dp_audio_set_header(catalog, value,
-		DP_AUDIO_SDP_COPYMANAGEMENT, DP_AUDIO_SDP_HEADER_1);
-
-	/* Config header and parity byte 2 */
-	value = msm_dp_audio_get_header(catalog,
-			DP_AUDIO_SDP_COPYMANAGEMENT, DP_AUDIO_SDP_HEADER_2);
-
-	new_value = 0x0F;
-	parity_byte = msm_dp_utils_calculate_parity(new_value);
-	value |= ((new_value << HEADER_BYTE_2_BIT)
-			| (parity_byte << PARITY_BYTE_2_BIT));
-	drm_dbg_dp(audio->drm_dev,
-			"Header Byte 2: value = 0x%x, parity_byte = 0x%x\n",
-			value, parity_byte);
-	msm_dp_audio_set_header(catalog, value,
-		DP_AUDIO_SDP_COPYMANAGEMENT, DP_AUDIO_SDP_HEADER_2);
-
-	/* Config header and parity byte 3 */
-	value = msm_dp_audio_get_header(catalog,
-			DP_AUDIO_SDP_COPYMANAGEMENT, DP_AUDIO_SDP_HEADER_3);
-
-	new_value = 0x0;
-	parity_byte = msm_dp_utils_calculate_parity(new_value);
-	value |= ((new_value << HEADER_BYTE_3_BIT)
-			| (parity_byte << PARITY_BYTE_3_BIT));
-	drm_dbg_dp(audio->drm_dev,
-			"Header Byte 3: value = 0x%x, parity_byte = 0x%x\n",
-			value, parity_byte);
-	msm_dp_audio_set_header(catalog, value,
-		DP_AUDIO_SDP_COPYMANAGEMENT, DP_AUDIO_SDP_HEADER_3);
+	struct dp_sdp_header sdp_hdr = {
+		.HB0 = 0x00,
+		.HB1 = 0x05,
+		.HB2 = 0x0f,
+		.HB3 = 0x00,
+	};
+	u32 header[2];
+
+	msm_dp_utils_pack_sdp_header(&sdp_hdr, header);
+
+	msm_dp_write_link(catalog, MMSS_DP_AUDIO_COPYMANAGEMENT_0, header[0]);
+	msm_dp_write_link(catalog, MMSS_DP_AUDIO_COPYMANAGEMENT_1, header[1]);
 }
 
 static void msm_dp_audio_isrc_sdp(struct msm_dp_audio_private *audio)
 {
 	struct msm_dp_catalog *catalog = audio->catalog;
-	u32 value, new_value;
-	u8 parity_byte;
-
-	/* Config header and parity byte 1 */
-	value = msm_dp_audio_get_header(catalog,
-			DP_AUDIO_SDP_ISRC, DP_AUDIO_SDP_HEADER_1);
-
-	new_value = 0x06;
-	parity_byte = msm_dp_utils_calculate_parity(new_value);
-	value |= ((new_value << HEADER_BYTE_1_BIT)
-			| (parity_byte << PARITY_BYTE_1_BIT));
-	drm_dbg_dp(audio->drm_dev,
-			"Header Byte 1: value = 0x%x, parity_byte = 0x%x\n",
-			value, parity_byte);
-	msm_dp_audio_set_header(catalog, value,
-		DP_AUDIO_SDP_ISRC, DP_AUDIO_SDP_HEADER_1);
-
-	/* Config header and parity byte 2 */
-	value = msm_dp_audio_get_header(catalog,
-			DP_AUDIO_SDP_ISRC, DP_AUDIO_SDP_HEADER_2);
-
-	new_value = 0x0F;
-	parity_byte = msm_dp_utils_calculate_parity(new_value);
-	value |= ((new_value << HEADER_BYTE_2_BIT)
-			| (parity_byte << PARITY_BYTE_2_BIT));
-	drm_dbg_dp(audio->drm_dev,
-			"Header Byte 2: value = 0x%x, parity_byte = 0x%x\n",
-			value, parity_byte);
-	msm_dp_audio_set_header(catalog, value,
-		DP_AUDIO_SDP_ISRC, DP_AUDIO_SDP_HEADER_2);
+	struct dp_sdp_header sdp_hdr = {
+		.HB0 = 0x00,
+		.HB1 = 0x06,
+		.HB2 = 0x0f,
+		.HB3 = 0x00,
+	};
+	u32 header[2];
+	u32 reg;
+
+	/* XXX: is it necessary to preserve this field? */
+	reg = msm_dp_read_link(catalog, MMSS_DP_AUDIO_ISRC_1);
+	sdp_hdr.HB3 = FIELD_GET(HEADER_3_MASK, reg);
+
+	msm_dp_utils_pack_sdp_header(&sdp_hdr, header);
+
+	msm_dp_write_link(catalog, MMSS_DP_AUDIO_ISRC_0, header[0]);
+	msm_dp_write_link(catalog, MMSS_DP_AUDIO_ISRC_1, header[1]);
 }
 
 static void msm_dp_audio_setup_sdp(struct msm_dp_audio_private *audio)

-- 
2.39.5


