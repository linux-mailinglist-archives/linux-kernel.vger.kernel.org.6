Return-Path: <linux-kernel+bounces-190156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEA38CFA57
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04C41C21087
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83203C463;
	Mon, 27 May 2024 07:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JSqiuXJA"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3CF2207A
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716795938; cv=none; b=exOFvgj30+F01HWblNg64Prl+/kot3nJ8CRihaSIGhOE+SzjIJAnS0/hjkU4M5cGr4WydDgpdw7mNuHUNGTR45ysBSN+D4pHSi5F0SGetlLaF+7e0w38HGRMxdnR2vtdV31T8e3FTzB9b8mVyct0QJ+01m9rb4ozNvo/Lae76BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716795938; c=relaxed/simple;
	bh=EqZSzqE8Uz9Ib3ESf+gE2A4x76Hw2LGSsCP2tdfN2Ck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qQw/7NNzjyViTNZkTyXZFLffaE6JPrgDAvYD9ojYufiM5aAL5/EF8SV5M6ueWRXwEcnmTQDDjMO3v3yEx+G/vCYddk9605i5APJbIErymrcuOuO9R2zMsOhpv33s8cuO+7gPfJJR6nR4YhAdl50XOB+lNeOurLzkH04I/V4o9YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JSqiuXJA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42101a2ac2cso32014305e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 00:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716795934; x=1717400734; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVVIAsfOZApr+HNaR0RI7FBaDwsiaxTYT7tyd/OSU34=;
        b=JSqiuXJAZd+rbmg8ed3VSDk0bgBKHiog1JeZvRqkJ77eQzZ2M1kHAWhvNr1fL0wVD4
         M1tZzx9m3qVqFUAArw0fcmWWuB/R5aCtuDrZaD7t6RgKFzX+hGasg12L+w44nMcqphzM
         jXMZoKZ8D0i3evCBDIAd026vxik2gAeXoZ0Ag2m9SryTW4KPvveLgkK3dZDOT7uZl5s6
         cbdQYn6DGcJxkn5O63cdFC/eFDhvD+mOv14JsZmreQSBDW2e1kMK0YFgWvt+TMUYU7uj
         pbxrxKOdZciUQFLhues9ZNnx1Du15uMBC0LcAV8aaB0OkUsj8H1dh2DkkTOtRzJuVyZ6
         26pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716795934; x=1717400734;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVVIAsfOZApr+HNaR0RI7FBaDwsiaxTYT7tyd/OSU34=;
        b=Z2+5ms6oOpTPjBCzqZHZcuqnLFDzlTVUxLYsT9lQsyxy+jGWscPzpVsExL76W6WSIo
         k0MW9pkAlkupH6qa4GZ/J0JqBhd7WwRlrJX5X6sdi9rUZpnxDFScfHUoZFC16yb84wBC
         CXKie3eJaVNup6DXVATAJK9pCGzPnMdYuLaFs1BvfDceiIa7HHYoGLgf3TrIJ+KRWA/Y
         jLYpRkja3vsN+5BBymYrTOJws+1xK8GXNcCTx+F+OPo/SdbdMqfREkOk7hol/9GINe22
         Szy1Yz2eTMJVCIlP+eio1I3sqKW1Zv6Zfoj2xc7SgfYOH8bHtdPbcpRQ8inl9mcEi7Ae
         Ai3w==
X-Forwarded-Encrypted: i=1; AJvYcCU33YY5XFxQbV/irRUO/9Mz0APRTYUmYEDwmBJ/uVPc+KuKiuaNTxcCfKbYyVuEI5WGEbTpOrMBwEoHnq9PTavJs7IHDGpOet5Bv05T
X-Gm-Message-State: AOJu0YwmsoWFCaVWlj7XgqA/A6mFdEdgCW5vouIN8i0CbU+dFF6SMswS
	a6+ccWdOFcPyYFe6fwTzJwbzW9q7QVbbJGM6mn44KMS1DB2pbFz0oO2MTabkN3k=
X-Google-Smtp-Source: AGHT+IHjF6xkM5kkha76hP1SHiRckOOBY4DNPPXaD7LX9t3aondXvXfhGv3huVHEh6L8n4YI6bMsvg==
X-Received: by 2002:a05:600c:4f13:b0:420:1551:96ab with SMTP id 5b1f17b1804b1-421089d784amr67974945e9.10.1716795934400;
        Mon, 27 May 2024 00:45:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7d96fsm8293353f8f.12.2024.05.27.00.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 00:45:34 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 27 May 2024 09:45:29 +0200
Subject: [PATCH 1/2] usb: typec-mux: ptn36502: broadcast typec state to
 next mux
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-topic-sm8x50-upstream-retimer-broadcast-mode-v1-1-79ec91381aba@linaro.org>
References: <20240527-topic-sm8x50-upstream-retimer-broadcast-mode-v1-0-79ec91381aba@linaro.org>
In-Reply-To: <20240527-topic-sm8x50-upstream-retimer-broadcast-mode-v1-0-79ec91381aba@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3204;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=EqZSzqE8Uz9Ib3ESf+gE2A4x76Hw2LGSsCP2tdfN2Ck=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmVDobsPV7EfbgPqlnGiesUkJu8CXk8Aah36DLe7nm
 Fqt36QOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZlQ6GwAKCRB33NvayMhJ0dWCD/
 0fStU3L/9MMSOEkFnOq1jZ4/HhApgXksh6yUH5NIHFoHL2sDqf8JxX3aE5NiHKX2QjIAZ4ZVYVHNxz
 U8FLuB/B53aT0ETFfgvwBHEdjrL6+oqsqfsmpFgLnfeuVjOP8lo6A2Pj1+wcHFYWI+8dgn46pM8n+W
 PWXlQ/WJxKwni69eKUtRN+DEz4GYsZazA4z5714qhQzSLU4GTPtb6Mnlt3e4ggUZwVVoBTp3Gpja3e
 atJrXja9qinY3gj+VdR7G08JmmriLMe6RasDyA2KM7t2/FAoBIKalWJG8ADohwFneXG3lWgEym9/Mh
 3KsP5vGwGGruCAgcCV9SGHSPw/70Grptp654RQJXoENGOBAq5t+2ANxqj/mt2P6psBhg4lVoCOdQqa
 U3ae9i1wg2+9wI6ynS551LgYoyVheMTVtHhR4YN3Rzfs6hcuhU/5uEFsLogYsTTeZFd5LnqS7QVQHL
 Lue04Zeivf3zOI3JEWpSb6LxoDd3gTKs7U+Pn7Kzhy7tpejMbWk+Mt3ALyISQOOMICmohepDTTXK3w
 rZokfFIZse/s+yoNrifw+qO/gwheLw5VC8Lliiw+PTdnWf00BwPIm/r7xxJ8qHVYzjZxktVBZY9pHw
 a104codX9wVfUsyMGeqBzaRZ+WJ2aey0zvu1xf1FTnPuhWWYo+ykH38uumEQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

In the Type-C graph, the ptn36502 retimer is in between the USB-C
connector and the USB3/DP combo PHY, and this PHY also requires the
USB-C mode events to properly set-up the SuperSpeed Lanes functions
to setup USB3-only, USB3 + DP Altmode or DP Altmode only on the 4 lanes.

Update the ptn36502 retimer to get an optional type-c mux on the next
endpoint, and broadcast the received mode to it.

Tested-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

--

Reported Tested by Luca in [1]

[1] https://lore.kernel.org/all/D1HOCBW6RG72.1B2RKGKW2Q5VC@fairphone.com/
---
 drivers/usb/typec/mux/ptn36502.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/mux/ptn36502.c b/drivers/usb/typec/mux/ptn36502.c
index 0ec86ef32a87..129d9d24b932 100644
--- a/drivers/usb/typec/mux/ptn36502.c
+++ b/drivers/usb/typec/mux/ptn36502.c
@@ -67,6 +67,7 @@ struct ptn36502 {
 	struct typec_retimer *retimer;
 
 	struct typec_switch *typec_switch;
+	struct typec_mux *typec_mux;
 
 	struct mutex lock; /* protect non-concurrent retimer & switch */
 
@@ -235,6 +236,7 @@ static int ptn36502_sw_set(struct typec_switch_dev *sw, enum typec_orientation o
 static int ptn36502_retimer_set(struct typec_retimer *retimer, struct typec_retimer_state *state)
 {
 	struct ptn36502 *ptn = typec_retimer_get_drvdata(retimer);
+	struct typec_mux_state mux_state;
 	int ret = 0;
 
 	mutex_lock(&ptn->lock);
@@ -252,7 +254,14 @@ static int ptn36502_retimer_set(struct typec_retimer *retimer, struct typec_reti
 
 	mutex_unlock(&ptn->lock);
 
-	return ret;
+	if (ret)
+		return ret;
+
+	mux_state.alt = state->alt;
+	mux_state.data = state->data;
+	mux_state.mode = state->mode;
+
+	return typec_mux_set(ptn->typec_mux, &mux_state);
 }
 
 static int ptn36502_detect(struct ptn36502 *ptn)
@@ -321,9 +330,18 @@ static int ptn36502_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(ptn->typec_switch),
 				     "Failed to acquire orientation-switch\n");
 
+	ptn->typec_mux = fwnode_typec_mux_get(dev->fwnode);
+	if (IS_ERR(ptn->typec_mux)) {
+		ret = dev_err_probe(dev, PTR_ERR(ptn->typec_mux),
+				    "Failed to acquire mode-switch\n");
+		goto err_switch_put;
+	}
+
 	ret = regulator_enable(ptn->vdd18_supply);
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to enable vdd18\n");
+	if (ret) {
+		ret = dev_err_probe(dev, ret, "Failed to enable vdd18\n");
+		goto err_mux_put;
+	}
 
 	ret = ptn36502_detect(ptn);
 	if (ret)
@@ -363,6 +381,12 @@ static int ptn36502_probe(struct i2c_client *client)
 err_disable_regulator:
 	regulator_disable(ptn->vdd18_supply);
 
+err_mux_put:
+	typec_mux_put(ptn->typec_mux);
+
+err_switch_put:
+	typec_switch_put(ptn->typec_switch);
+
 	return ret;
 }
 
@@ -374,6 +398,9 @@ static void ptn36502_remove(struct i2c_client *client)
 	typec_switch_unregister(ptn->sw);
 
 	regulator_disable(ptn->vdd18_supply);
+
+	typec_mux_put(ptn->typec_mux);
+	typec_switch_put(ptn->typec_switch);
 }
 
 static const struct i2c_device_id ptn36502_table[] = {

-- 
2.34.1


