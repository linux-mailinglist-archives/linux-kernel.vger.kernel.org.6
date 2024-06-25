Return-Path: <linux-kernel+bounces-229121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2738A916B32
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D004B289712
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273EE17335B;
	Tue, 25 Jun 2024 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="taXzIsgv"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65330170825
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327279; cv=none; b=PoxQeRoch716wxDqZhbklt4HX2s1tdVqFu9t/loCL9iXZJLqw4VvI6zSVmITheyjOHLsaAg4XkNjj3RAvYLKfL4cdIsI9qD3oC4SV3OmX1tW4YZW8XCc1lEMwttvD4bsvRNdrslQkXODFFcMXe39htMbcRBJOZ8w4iywDaH0Tgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327279; c=relaxed/simple;
	bh=c1mFXRw/1F7jX+PLOZli37YidJtYzYIZwD0eERkZXpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p4c4h81nLCbnjrk8lM9ed9sT4L/90X8itK0Qy9MMHRT+a3aSA3jlMhI3tqgZondYmiYoaM5G8SsbeTiQ85t9tdUggMJ3BatRQaE9NEpv3e+3gzkTbJCDHhPeoH5T+qM1CWw+GFtzqCcTyxAg49I7gnMVrrokPdot7xKzK7LxCLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=taXzIsgv; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52cf4ca8904so428180e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719327275; x=1719932075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2gxtQIN+xKJeYZrrZg4eTx3pd8ql0F1T/zN9SBRQsY=;
        b=taXzIsgvpysuGi9cEp+t84xI8DTRmvYy+7KRZHNOqNUe8RfBM7kMRi0dg+9QaDO1Dh
         vu35FRL0SVHMz1ncI1n8/HlmNufUbOdA7kdzb2QJd5GMTxM/HIIujG7PJZCkMvw+Z4TC
         C5maMj9MPgFD49JHA+Nm4edre5AcML2X/waqsrG1kWG+gQONLajC71ZN74ZgVnCdqGyJ
         z7DN3vKAyf49SDLZTlNYdw1KFtUPpeHNmU+MqqGPkvqJ6WLjc+6tHmr1ihoqWHbHdAQt
         DdmdvmC+48ANffjhduprSFRcbH8g12rDqXVlIwrzAQsYI40nDTOr4q6oQ3NHaFY7XAR9
         oWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719327275; x=1719932075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2gxtQIN+xKJeYZrrZg4eTx3pd8ql0F1T/zN9SBRQsY=;
        b=RawlhkaRW7QaopyXIqZCyIUkayM6sz/iOWgYmJK/bMBKTxpR6huxNYwvON7kA0ZDER
         9eb5SPyPCUPZwD6wAYRhDTRoITvgbYJV+5BEILytVNsg5QmHkXwLq52xpKDSAol8ACQL
         2/jUN5uGXZ7KNV6bUn/P03ijshpL1vqqk+TevUl0sfgTPx2pBjF53n5whq0kb2DZwb8R
         Rb4uPZkhPCuxrfIgTdCkfoZ2AV+4Qjs9bnmnDT+UF2YQz0MVznLANUqMI9o/f1Hh5esD
         O2riGt91qvANEllvlOd+KuwcF1JF4oiPao+K1kyyi8MIagk1O6qBI6GR1jglppZ6nL3y
         sAaw==
X-Forwarded-Encrypted: i=1; AJvYcCWLa+cCUt+wUva9a+0GTcaWWcKL8bsGib8pvl4Ha3Wx3J09oZNdhsiaKrl2Y+lrEUPivNJCOeKKtlEv6uaoDlWDNjJEih1yFwK6TnEc
X-Gm-Message-State: AOJu0YyJgRHfIlscr4UjaJpPD7FrGZBsskAkiZ/XukCfgvhCLvKXHqp6
	B1qVnXzA0VPj4q3kJdrZ0B2hRdW3q8OKHv79ZKy3i1PItzWl3+qNamlCyvi4Y5w=
X-Google-Smtp-Source: AGHT+IFgTfwsx7ElY5vsvTSzReP2HLuqQHHg6f+F1C3RO23ndtkGTJu8+wBSZAIAD6eWetNxoUG4Kg==
X-Received: by 2002:a05:6512:46f:b0:52c:9f9e:d8e3 with SMTP id 2adb3069b0e04-52ce064e3d8mr4973783e87.31.1719327275739;
        Tue, 25 Jun 2024 07:54:35 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd64328b7sm1251877e87.221.2024.06.25.07.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:54:35 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 25 Jun 2024 17:54:32 +0300
Subject: [PATCH v3 7/7] usb: typec: ucsi: reorder operations in
 ucsi_run_command()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-ucsi-rework-interface-v3-7-7a6c8e17be3a@linaro.org>
References: <20240625-ucsi-rework-interface-v3-0-7a6c8e17be3a@linaro.org>
In-Reply-To: <20240625-ucsi-rework-interface-v3-0-7a6c8e17be3a@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Nikita Travkin <nikita@trvn.ru>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2070;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=c1mFXRw/1F7jX+PLOZli37YidJtYzYIZwD0eERkZXpg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmetokKTBUAvA860F4TZ7LaGT2vn3//h0eO5fRP
 eXnVpE4f++JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZnraJAAKCRCLPIo+Aiko
 1Y7VCACNYuSM7sEYoqQvGqND2MRdAoZLFky1iBiqT6oimIP7qis1KVCv3F+gBFz/bdKtij+cztp
 Z5awCnGfW7Httm4zKIIT7NjJpuUDn4ia7oZOW3FAe99Zdq92p1EKUvXKnXApxNz6eom/iOY7qGH
 ZuClKE5VA15dUN4sl0zW6TTatSGt7zTfkToJ2jq8u83k9ID/maCxlb5V8FISVxuKEqgOJwLGGoE
 OvAeeooTh9x2NFAt/eeMWZ2D8kgVxeDZw+j5aVfO6x8v8emzAdbZuHaM+qRTH+T7uUXJOiJNXkB
 9HVHfVpFVz76fdbmU925vbf0ul+6bFBUI9SNsbusDr5OPJul
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Streamline control stream of ucsi_run_command(). Reorder operations so
that there is only one call to ucsi_acknowledge(), making sure that all
complete commands are acknowledged. This also makes sure that the
command is acknowledged even if reading MESSAGE_IN data returns an
error.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 3fb5d3a52b80..0d091f06abd3 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -95,7 +95,7 @@ static int ucsi_acknowledge(struct ucsi *ucsi, bool conn_ack)
 static int ucsi_run_command(struct ucsi *ucsi, u64 command, u32 *cci,
 			    void *data, size_t size, bool conn_ack)
 {
-	int ret;
+	int ret, err;
 
 	*cci = 0;
 
@@ -120,30 +120,24 @@ static int ucsi_run_command(struct ucsi *ucsi, u64 command, u32 *cci,
 	if (!(*cci & UCSI_CCI_COMMAND_COMPLETE))
 		return -EIO;
 
-	if (*cci & UCSI_CCI_NOT_SUPPORTED) {
-		if (ucsi_acknowledge(ucsi, false) < 0)
-			dev_err(ucsi->dev,
-				"ACK of unsupported command failed\n");
-		return -EOPNOTSUPP;
-	}
-
-	if (*cci & UCSI_CCI_ERROR) {
-		/* Acknowledge the command that failed */
-		ret = ucsi_acknowledge(ucsi, false);
-		return ret ? ret : -EIO;
-	}
+	if (*cci & UCSI_CCI_NOT_SUPPORTED)
+		err = -EOPNOTSUPP;
+	else if (*cci & UCSI_CCI_ERROR)
+		err = -EIO;
+	else
+		err = 0;
 
-	if (data) {
-		ret = ucsi->ops->read_message_in(ucsi, data, size);
-		if (ret)
-			return ret;
-	}
+	if (!err && data && UCSI_CCI_LENGTH(*cci))
+		err = ucsi->ops->read_message_in(ucsi, data, size);
 
-	ret = ucsi_acknowledge(ucsi, conn_ack);
+	/*
+	 * Don't ACK connection change if there was an error.
+	 */
+	ret = ucsi_acknowledge(ucsi, err ? false : conn_ack);
 	if (ret)
 		return ret;
 
-	return 0;
+	return err;
 }
 
 static int ucsi_read_error(struct ucsi *ucsi)

-- 
2.39.2


