Return-Path: <linux-kernel+bounces-370117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4922B9A27D6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0762E2884FC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7E41DF253;
	Thu, 17 Oct 2024 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W9I52Vqr"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2981DEFC5
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180886; cv=none; b=Cz4Zs9YNE1kpoz1cho0aA1B5+b0Gt/2m+tM/s6yjyJ50ETRQxCE4rR3dJJNvv8veRRelg77YvXp1+qTamqYDw4JYZnhqx5v24s+n9MubPQpGcn+cwnUBxCaG/OzCHHoroHLoVdWI6JIK6PHYuMR2o+bcCq+5clF6cENMv44bJlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180886; c=relaxed/simple;
	bh=8tYhk1/X9rTC5CRRriMRdyo9FAY7gz/olIfFEpVUSqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=J+uFI9H+O0X/iPYx0QB4JcDunw2F9zQvlHuPIV/k6ROl1RRcDFsSWwjLWklTRk3ybnvX5fTDEWOQvGDfM/bWDZxCGUmAQYwRYLPKvg+wdJON4t/+JeVoZHSdB1K0XW7MU6Cb7Za+dJ/buLbze6/Z8mNeYtTD3L22FQPVNBDTCdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W9I52Vqr; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d4b0943c7so818612f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729180879; x=1729785679; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N17aF7uxh0G6GGML6WHZ8HBEXLTUCV/jQt7rlNZei0A=;
        b=W9I52VqrAwjAtlvNPFc8Uf7KCI1P2Ijd/p6YEmTf0Nfu28fyX6X+ywK7VIhCtnCfzI
         mRXjM0zuieWktR62QRf5PK7+EUKIuSf5N5E0xfPMJ22AFQZE+9HNki/Fw+SufAe114FG
         tCCdFgJ0ad9cQM8N+MKia9wQMgoJLRt41h6S0ByTwMEQQK5lFomPl4isZvCldirqbvI9
         BLcz9bEU4oWW7GS/ngbffLw686OEgJwBC/yyiNB2sd/00IA8bVIekN85W37hfc9e5Nwe
         mkP2B4F3L8nHL5OyUYYRqEu937EGIvWs16z5PWTYOIbsT1aO7+ZTccFbojIUvzRKUIrB
         F8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729180879; x=1729785679;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N17aF7uxh0G6GGML6WHZ8HBEXLTUCV/jQt7rlNZei0A=;
        b=AYVCjywI8fIVqc2HrR4uqZISF+fr7Bo1vGEvGBPtPtxZ7tG/9Q1vt5Th13/7N8QRq8
         +DLLKkc3ptS16OiqgQJfEz2yBir2UMeaZphWnAMs1eIBt5V91uwj1fcnydQIceOelI6W
         p6qiHyhIrn+Dk4aVI7sYSJINdzlyPvLmPooHP5EnChdAPn1n5t3OfmIpO71tqrzvarhu
         /N1HLFVcCF56rTvr6MdgFfc4hXWnswupac0d2w5sOdCr5Qc6MMCsnyMgLP/D3OV0x3Gw
         tHGP7wIQg6PfUV3OX1c1+U4DlRYLOCg+h4LrkgPuEk0w7LA5JFexWOXunwx/9tA2lc0M
         HoFg==
X-Forwarded-Encrypted: i=1; AJvYcCUy3eN5wvrvmjwPPNjdVvOPgR2WwrBpXW2PLh5GEUXfchyMlzTzSbvTtFUXhMcixqFoqej2jzL9XEd8i6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRbxAgNhhK4z1uZgX2nbHXNa5zEkon7OLiQD6Cz88DXPDe53/r
	u6rRqmkIHFibUGsgv7UbkQo+6PFSvI2M65MgKFkxnBuCCCkXWUHREX80fhs4diI=
X-Google-Smtp-Source: AGHT+IFBPyquqYu3U/ycusam+CJOvnQy8PGDhkcYeNxarlFbkDu6daoyWAcSns52Jl1oBt3KtvI9ig==
X-Received: by 2002:adf:e405:0:b0:37d:50f8:a801 with SMTP id ffacd0b85a97d-37d86d64357mr5772759f8f.47.1729180878429;
        Thu, 17 Oct 2024 09:01:18 -0700 (PDT)
Received: from [127.0.1.1] ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d94626094sm2879927f8f.88.2024.10.17.09.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 09:01:18 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 17 Oct 2024 19:01:01 +0300
Subject: [PATCH RFC] usb: typec: ucsi: Set orientation as none when
 connector is unplugged
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-usb-typec-ucsi-glink-add-orientation-none-v1-1-0fdc7e49a7e7@linaro.org>
X-B4-Tracking: v=1; b=H4sIALw0EWcC/x3NQQrCMBBA0auUWTvQRKXEreABuhUXMZnUQZmUJ
 BWl9O4OLv/m/RUqFaYKp26FQm+unEXD7DoIDy8TIUdtsL09mN4MuNQ7tu9MAZdQGacXyxN9jJj
 VkeabAihZCId9MskerXXOgXpzocSf/+sK4+UMt237AdrDBXiAAAAA
X-Change-ID: 20241017-usb-typec-ucsi-glink-add-orientation-none-73f1f2522999
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1460; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=8tYhk1/X9rTC5CRRriMRdyo9FAY7gz/olIfFEpVUSqo=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnETTA/U3r6RWF7+v6bA21+7iIdUM8vuV+1T/kR
 i+7DtVoe4CJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZxE0wAAKCRAbX0TJAJUV
 VrEkEACGayQYM4WKq/w2n8qQIvjm0A8YPWxzcHKPdeNPeAVefJ9k8RYxWVIX3ZPfT+2PwIeC9Ll
 7Hv+ApTjaa/1uT0nliWXnusInWEJS0aYw9lwtO4FvG90B/39qfnEdQpTI0ZVub/KWxmDlYUoaoF
 KniXIHpjI4QakeD9xQkYublNGsG1r0YXJzyxy2GH2G0JrYk0/UjPB9zptGtLzeCJnv4S+LYKrZY
 R+dPwKQcHkVOnfsvX1ix3bkNP1x6CQ7hfxNvH5/igiIu5bXPkSJ9Ak7ku153c3axRHJTXjT+27u
 HSjiSXniIdb8N+VnPskurc1/amV1316MfggfpVmKrl65d+/KFvTni8WSzARxhI3Wo/2AfxMrE8G
 TGpSHJwq1rm06XkUJPDtZsx/NViyNQhCGaRsvvhuzHoRhV/5NmjKvmiTvgSzEfxO003dXhxFgGA
 zZNkqgcba0vyl2JdS71rxSv7KPlMAvMDs6Dd/Kor9iIUpaxZJLv1iXgQO+hjEp8LMGbeYyP682H
 XQPrxJE1eEisob+2YlT1cemmH1+Ic/cthIAoYn/L+hw1IMBd2nqIerqyEAoB7wiydlPFymx1oqm
 PZ5ns2yAAcV0x7mGL9RIRw/loRimIWxnFrissjuuWyz1DhooOj41b14BsFhal1gSqf9vT84Ztzu
 XSRSc02Jv2kccwg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Currently, the ucsi glink client is only reporting orientation normal or
reversed, based on the level of the gpio. On unplug, it defaults to
orientation normal instead of none. This confuses some of the orientation
switches drivers as they might rely on orientation none in order to
configure the HW in some sort of safe mode. So propagate the orientation
none instead when the connector status flags says cable is disconnected.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 3e4d88ab338e50d4265df15fc960907c36675282..b3bc02e4b0427a894c5b5df470af47433145243e 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -185,6 +185,11 @@ static void pmic_glink_ucsi_connector_status(struct ucsi_connector *con)
 	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(con->ucsi);
 	int orientation;
 
+	if (!(con->status.flags & UCSI_CONSTAT_CONNECTED)) {
+		typec_set_orientation(con->port, TYPEC_ORIENTATION_NONE);
+		return;
+	}
+
 	if (con->num >= PMIC_GLINK_MAX_PORTS ||
 	    !ucsi->port_orientation[con->num - 1])
 		return;

---
base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
change-id: 20241017-usb-typec-ucsi-glink-add-orientation-none-73f1f2522999

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


