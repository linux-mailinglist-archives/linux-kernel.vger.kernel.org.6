Return-Path: <linux-kernel+bounces-361396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D31699A7A7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D33A4B2154B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8978F1990D0;
	Fri, 11 Oct 2024 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="ZG8n9i8z"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3F6199BC
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660456; cv=none; b=INRrA3YTFVz0O/cDh1+MqVKwQXnzgFdrHr+jd0kl1/Dty5HRdc+X5WAN/A4qe/dusQIJvw/nYtJhVtr361EhudrYG6OXcdZO54gLrdlgOD0JjSJytPewYt5bn8v1HNRofctu5zfB+bKT49V7tdeSCliadS7Ht4HadXXG8wvn0Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660456; c=relaxed/simple;
	bh=Gx8UGYyCoJLkmTfYCCLLqZ+vI7a5HA77QIzlDLw8kbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZsdFYtQ7W7IcqSQaWLrsR4wnA1IK+MDKzNI1Ax3mdL1sVYI42kg/cUHdsiupuvCrQtiAglMj1mqrfOARAmx0OTOtqG8yRYKqSViYWT+KRPU/wcZfU/WoS+nYf3qRWO+jHC8AARwMJhFR9uVwafKpOWVYSNCKbi/nKIJ6nL0B1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=ZG8n9i8z; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4604d8f162eso5601871cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728660453; x=1729265253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvVQKd9PLxbemSCsM67gMOfDNJDIxXsysvUovMumA3I=;
        b=ZG8n9i8z9nKjdmPOMvK/qohYGGfjl+Ja/TS3pKgck6GbYlIAqBzCiDYhcOQM6kjiCf
         CUbo+dO0aMxlFxIxDI0NPjVyX7C9PjMH42QHs8zJx3wOecaHNJNY51wRZh81+d4kIUfm
         sgb2LYqfy8RxX4Zld5o4oosQ0NfTPFmFtXKZZxgSTs3dWEsQsY6kf1xKrhnl42uBcRv6
         cx03c2c9wcm54Yy84NIXIMoRuQgtdziRbHvTsKnPvOGgZzMfDjKdKr+pQxmZvb8Lz/tQ
         qHzjqBXiMiwJDPT5hxtqw5zZ1u0ZzbKWhfMZcjSwUlFnvfoGMnQ48cwCu43gpaE32U8x
         2bMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728660453; x=1729265253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvVQKd9PLxbemSCsM67gMOfDNJDIxXsysvUovMumA3I=;
        b=iRtWdL+fRjpqk11LxUn1X7drxj0mTcziNd0L9BfeR5KQFDA/Bysm/xSeDmTSh7zI3C
         gA8ozdU3lav85VWn+E4gaZYp9tJWBgp+S/IduoSgoQC4Dy+lTgn1dPaoC1LFbWmGpQsa
         HMhu+YSlbZJpDqNXPt/biH/obOGfehav/KsKGw9IzRaErfRzEYv6z2qNVDDs1fZPt0dW
         okMi4zjqlvoiqi2lmPYyTJz47Mxj+uNd0rtD5i6lDdWQQ9HoDoQsXsjNqX45WfbNXlil
         wVyoAHqHM1bBC7m8BvqNvhfRtEl2zNhjLz5QgS/cc7iWf9V0qEQRzNJhkGs9u8DeTMOG
         Xf/g==
X-Forwarded-Encrypted: i=1; AJvYcCVEWGjOHbVrj3zBzmQ9sC0nD5kEMxXWm80jXs1o1DozTLB6Da2sEMxCkWoxOSSVaIfzmA5SIWE36xiA1e4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBBtyaYye5ZjynMRR23Nc86B5wi6TtvUigFfKvRtojsprxjHKO
	ilsJeY0pkwUqxdsFTOrbmF84hdAH+dpEqNYHEtrMgGM/5LlcCEpCxGnNCn9Msqg=
X-Google-Smtp-Source: AGHT+IEXnQ/LD2VsUTesyG1k3Rzr18V6yq2EmOcJVW7Bge/+h5oQISsyZXZcWyI3JbjmbvZ/MrE3dw==
X-Received: by 2002:ac8:7d46:0:b0:458:2764:37d5 with SMTP id d75a77b69052e-4604bb93e90mr37264241cf.6.1728660452820;
        Fri, 11 Oct 2024 08:27:32 -0700 (PDT)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460427d5220sm16344131cf.32.2024.10.11.08.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:27:32 -0700 (PDT)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-arm-msm@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/5] arm64: dts: qcom: x1e80100-pmics: enable RTC
Date: Fri, 11 Oct 2024 11:22:41 -0400
Message-ID: <20241011152244.31267-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241011152244.31267-1-jonathan@marek.ca>
References: <20241011152244.31267-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only access to RTC alarm is blocked.

Enable RTC access by setting the no-alarm flag.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi b/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
index 5b54ee79f048e..304a98d60472e 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
@@ -220,11 +220,9 @@ pon_resin: resin {
 
 		pmk8550_rtc: rtc@6100 {
 			compatible = "qcom,pmk8350-rtc";
-			reg = <0x6100>, <0x6200>;
-			reg-names = "rtc", "alarm";
-			interrupts = <0x0 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
-			/* Not yet sure what blocks access */
-			status = "reserved";
+			reg = <0x6100>;
+			reg-names = "rtc";
+			no-alarm; /* alarm owned by ADSP */
 		};
 
 		pmk8550_sdam_2: nvram@7100 {
-- 
2.45.1


