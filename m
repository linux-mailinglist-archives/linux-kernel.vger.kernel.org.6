Return-Path: <linux-kernel+bounces-351907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E14199177F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 16:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 277C3282D17
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 14:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D918515532A;
	Sat,  5 Oct 2024 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="XnL4Orna"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A69D4CDEC
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728139539; cv=none; b=DgWGIMuoZLRBWTFwZIHFjr+cibqpzVZw4VFvi3IuuPninqOK9CFcxu/wWR/WfcO7LJi6pZPJRqmLKr+f8PEU1SbIy90FAFP9xm5sz+SdRD2E45AQjwpZJW4q4qvGckKJEstnuvhsXDYy/+oKf6vGhpOpt8XUauESvxKhKDvLPMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728139539; c=relaxed/simple;
	bh=R6ytXgEwWolY5FMfxKOluJmAUWIacFrrSIoP5PhuTac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WGz1tVVq8UOgYd5L2u5N66n76dWjfx2D9z5r/l3x5ZS+SeitKMJBQ2JMDq+FtfI5ayZ9UIORtTNHN6va3Ve/jJOswosC8DrCzkC1xpuavZGYjDLixI3nrKObTf/u4JyJGHZxqkGlI0Ll1MpkFHrE37QUlG1wxzCrM//xM8x+WIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=XnL4Orna; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a99d23e036so325731885a.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 07:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728139536; x=1728744336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y+XluEkvRL8QfNohRXB4nX3BEfu3BFvUBCb0tOvo608=;
        b=XnL4Orna0zXcWb1q0DemTssm/eConNkXPo8tohdgVhbCtgF/eqF2t/R6xMZrDxBd6r
         y3RrUxaCXK+q97PYAAw5ryMwEwXd8AP+diTbVgeuivEcphciI219CpATfhSyrwhKziKH
         wIchHSQxyjZmICgETsBSADu6+I6S6/qhnoLKdgvIM0p42Xuqv4k73x3tKNzJbc6QDV8l
         GSO4yIfz/IIQfnVGT5H5V/N2T/2EmpDYsnmjXPr3sS3ALzeH6Pr29bGlPF99bGUvhVFJ
         02bW5V2Dm33C3BxXaQqALRhOQe0FmNHx9spSDS7wPYXO2iN7Y/WfO431y6iEYcHXHfK6
         /KXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728139536; x=1728744336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+XluEkvRL8QfNohRXB4nX3BEfu3BFvUBCb0tOvo608=;
        b=B5urdQ+ARV2JpgDQtPqOmmXE5n5vw/5V5PmztEgDefUMj1rlY24D/nEAxsPSBjXVtw
         h4C8awVPoj3okDUzDp7f9Bx3CI7mtH8t+bicXvlwJB5qVU2TKfRUhxOMd/nh48VoDjxa
         2JWpSIQOlQBK9fCqysLx6wxS99BQ2OWUBL0eIXaL99PUVsZ6A9ObopflMtKRODlqmC8t
         juqosbME5dB8h84et+bF1mlGYllaXOHKmQ+51Pbm0/oZSzlgSOEj8Z1HMPOIMScrRDsK
         2TpWPjsfyk3ZnwhY6i+HARGNX4tgTBp+8HB2q+2J+wEyCjyLErgmjc6sI/5LjexBM1Ki
         EI3g==
X-Forwarded-Encrypted: i=1; AJvYcCXCQMveqvP3pUXJEnhIG67QU0dUxmrgbLng5c05rGhY+zIQTA1rD1aT4Hi1JBKb4hptYOejmoCbP97iIuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YypogInFatQBr3UMagSdVGe71e6OcwJUbSH87remUuALIDtNLOl
	BPai6QGp6XRIjOnnMNzbVjVAexXleNNk9a9GUKnUc4HwDf0V1WNoLdvonK2wq84=
X-Google-Smtp-Source: AGHT+IFBlO9hp1EEq6eeZIwmtBu7626Wfp+mPjRch+fwjE9zC5N1TjETE8tWbqnRJdaSQ8fRu1ObKA==
X-Received: by 2002:a05:620a:29c9:b0:7ac:b93b:b21b with SMTP id af79cd13be357-7ae6f3af94dmr974750985a.0.1728139536141;
        Sat, 05 Oct 2024 07:45:36 -0700 (PDT)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da74e9a87sm9039161cf.22.2024.10.05.07.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 07:45:35 -0700 (PDT)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-arm-msm@vger.kernel.org
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-usb@vger.kernel.org (open list:QUALCOMM TYPEC PORT MANAGER DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] usb: typec: qcom-pmic-typec: fix sink status being overwritten with RP_DEF
Date: Sat,  5 Oct 2024 10:41:46 -0400
Message-ID: <20241005144146.2345-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This line is overwriting the result of the above switch-case.

This fixes the tcpm driver getting stuck in a "Sink TX No Go" loop.

Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
index a747baa297849..c37dede62e12c 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
@@ -432,7 +432,6 @@ static int qcom_pmic_typec_port_get_cc(struct tcpc_dev *tcpc,
 			val = TYPEC_CC_RP_DEF;
 			break;
 		}
-		val = TYPEC_CC_RP_DEF;
 	}
 
 	if (misc & CC_ORIENTATION)
-- 
2.45.1


