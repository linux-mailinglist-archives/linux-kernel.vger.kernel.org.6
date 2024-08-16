Return-Path: <linux-kernel+bounces-289492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2769546B9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D835284DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8C718FDAF;
	Fri, 16 Aug 2024 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dGlAOokh"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8407218D622
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723803837; cv=none; b=C0zy6fpnbahCT8bPDWMKNXvw0epmK+D8U6p5X8USWqSLUiXK12LE1HcOdenz/uxXfSdagMIZxNRD2l44BGfwldfN57uwIO3i1Y2ihKbjTBU+yH3on8f2Fk4scoVmKc5DqOsxkjZhCCV0liYm5OUJgPntBW5iF5o2xPL7pr+Uwh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723803837; c=relaxed/simple;
	bh=8xNU6/k4w7gY54c2eh51kl7IfvMiOkBP5NcZ7EtPN3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGDJIIqjEIUuKBsposXW5+oYdgx6SuyLKXzXY9rguvmbgIw1Ry2mQpJcX8IuwD/htjLgsATbNTb1K6UrdDaCIGzoY6unu/ecGkgFwXdE9Pw6aCQeEXisypc00wRi8oiOB8AoKylEO/X44tcfw6pWKi0kevJfKJQ/SbV7qTlAEjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=dGlAOokh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428178fc07eso12340025e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 03:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723803834; x=1724408634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ac6PkEI7A1RP1coeC4Yj5cZXMittHI8EAxgX8fzSWd0=;
        b=dGlAOokhY+vYZupl3OK3NwFXfhaVDaoxHS4s7H4WePGx9EN661YCgy+6odESYhUki6
         HaDKl3h5tjgm+75VeSDALm9T7u1m48PFRW7CU+bhHGTJfuLG1iu0Elt4dMlATlMwD3sp
         qrEY9uYsLVzzFgJ8pHrKwUf+jjF1KsYB7cIfAUarygoxQvLAnTYJnCLnrQmLOLJ+MPqX
         Sh4qumibilXIkEw7cYCLNkyJkFb3pWIWqj4kRPrFH0TNxjIjQwtxhHEZw88EhYXYQGly
         sMRMoqOQiPL4Osw5L2EFi8ErdhxvMElSgWlp6ObHvVibWAbbVe2VSzAIaZ8fDZhSEFMW
         TWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723803834; x=1724408634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ac6PkEI7A1RP1coeC4Yj5cZXMittHI8EAxgX8fzSWd0=;
        b=NaE9u1iesC4EinTiRdpWWvaUxsZvqo2e5zxF4rzpLSxg8FRmptWph/ZYNeCVQ1qsYP
         mPcEF8mMlNOR49N8G9XTX7E7MhJliMoIsTp+lAUt+NL18EFHzqsJHq42IRZOuv5o2soL
         ujIGkqFHAo4XmgJ4WaFaZ+QfN7qPNx/wsZUT73UtEhv1j637QBSA3gEfH7UqyQj3ScBq
         ye1e4q7E+FsI3Nm6T0HVH17ORJv8eXys9eT+uZrQd0QcuisZKwoLbcgt7O0G+WpS6H+6
         4bDYCXWfUAxnbm4gBBlZfjkcHciYDEecFG20XWb7L+xDUxrIwWcqmd4ZpBijvf1g6iQ+
         9rQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcDUDX0ck9+SiFipJEegw/zehQk4Hhtwn/Dd+bJ89FAcI41smuREcSkpnhEsOTPPmOVRRwwhQTmbPdBG93RJRb03HVN+nEi9GYkCly
X-Gm-Message-State: AOJu0YxwseAEnsGgZXyJw04KMRuYiwBCW/C7RgZdW0bO2BaTHo8QXtVw
	rGTMY7j5IZsfelwAnEB/hmVFYA+MHKftPpmlYn0M46esf85v9nz4j632/NZCSEo=
X-Google-Smtp-Source: AGHT+IFSFTTtUJgs7F4KncBO3eji2OOP3lzw9DBVuEXpO1uGSfoBvSNrq4KRwIjzHiQxA2UzVx4jMg==
X-Received: by 2002:a05:600c:4e88:b0:425:649b:60e8 with SMTP id 5b1f17b1804b1-429ed7c1218mr16732045e9.18.1723803833264;
        Fri, 16 Aug 2024 03:23:53 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:aff3:cc35:cd8f:c520])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded18630sm72650125e9.1.2024.08.16.03.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 03:23:52 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Amol Maheshwari <amahesh@qti.qualcomm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Tengfei Fan <quic_tengfan@quicinc.com>,
	Ling Xu <quic_lxu5@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Ekansh Gupta <quic_ekangupt@quicinc.com>
Subject: [PATCH 2/2] arm64: dts: qcom: sa8775p: fix the fastrpc label
Date: Fri, 16 Aug 2024 12:23:45 +0200
Message-ID: <20240816102345.16481-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240816102345.16481-1-brgl@bgdev.pl>
References: <20240816102345.16481-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The fastrpc driver uses the label to determine the domain ID and create
the device nodes. It should be "cdsp1" as this is the engine we use here.

Fixes: df54dcb34ff2 ("arm64: dts: qcom: sa8775p: add ADSP, CDSP and GPDSP nodes")
Reported-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 801e8a92359d..5b9b68c634f5 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -4046,7 +4046,7 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 				fastrpc {
 					compatible = "qcom,fastrpc";
 					qcom,glink-channels = "fastrpcglink-apps-dsp";
-					label = "cdsp";
+					label = "cdsp1";
 					#address-cells = <1>;
 					#size-cells = <0>;
 
-- 
2.43.0


