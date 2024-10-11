Return-Path: <linux-kernel+bounces-361948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3122C99AF41
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD5F1F2232D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74591E412E;
	Fri, 11 Oct 2024 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="bc4Uy37e"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958341D1721
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728688825; cv=none; b=arip7Rig6FrPSdgravrfEV9klgZsTg2UstDSs9pBPkBdgRHq1KSaL/NUL3wEVG3eznHIVZ2KCJpiJmjCvGymTv8znl+102kwASPxDy4eYULau6J2uXwutCHP30Y0r2r5ESZK5hRYCL9WcFqeSE8bxc0Bn4u6Wdg+Fp+1i4JMocc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728688825; c=relaxed/simple;
	bh=nDNDo7ALv+O3cxUau8Fj+PX+xIMtyBWTHRXfMjz46/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jn1I1wZQEJzv1QFIyUOxf+gi+7yUN4pl22r2q3HgqBpwhF1pkCXnXVZe5nZmGYqH6zrezVHjyhZF5vhOyKXWCIQHJ2hxokiJyUwiec8AK1WrU8GCNPyEv/wSHMrWRcN7cI56b5OeI1caas8YmFcrldqdknu/M0+SGgdvw0LS9xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=bc4Uy37e; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7afc592ca19so163691885a.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728688822; x=1729293622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AduvL8sRkCTgfrWSsu7rKhjd0f6vDDJasPZpnT/qEYQ=;
        b=bc4Uy37eU+yFaQyNBGmAEw/avs7Q/VVscCax3yO4kzspawxhHSj41mf7dXyQ/NqncQ
         249Kt4Z7Co010gdTpFKh5ffAa5P7H99z4rNTc13KQLYhyR8IUxey9+bKS7b6qd3XuzOd
         qwLzlEgTp17BjX0vW9U93axNcfwUGYgus5rbH054QWcijpcEmr0jHl6n1j43V0a4Wyja
         82d9h4XhtGkyVh5o5Qgf7TY+cuJZl0haNzvbXMppOIE0a9br3rJp4SzMrsY658N67piP
         i3oz2HLCmzu81rdnXbjKATx1DGlABConyu6+FMBWQ3DrwrDKF+mWK7Fj/J/E3hoKQ0rP
         x3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728688822; x=1729293622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AduvL8sRkCTgfrWSsu7rKhjd0f6vDDJasPZpnT/qEYQ=;
        b=a3PW1TNkY5tr3j/SeoNuWvdDSFYqIZdT54o/Yf7UCo9VKFytvJpCOzMr2yfg/29n98
         SFJkjyjPnQ+GdAyswRrlBHMH1yYs9XpEk1G5udexg142iI3AJve/9d8QwxIRRIhzwzH4
         iDlgUbOMAZm8yalXptH24OpJdgEy4YS+Gg5/C/+0wkqMBQ2FzKWm8X9qYlazLH4w5gyO
         +o7f1lTXopr28uAHxFRw7I2i5uYF330R3wxfnz1COTp4vIh3kJbOuZ88FiL8ZmT0wUJC
         Ms2KUxVhFqlDWMWD5oGOQZ4I7dtRH0uwuzOY8OZ0KlPJ2dRoLaSeMeK6PCNW0kXHLa6p
         9i2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+ERKxu8wT3R/5LG8y5k0Jf+fh8GjayWdv3zuR4JGnmy6ji97gcZBUhr3IW/cSjB0X9iYkE4n0hiv44pI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoZLr/XaBjeOxsN1T1zMXBc/iEE4qtXwSvk4bj1iVD5kNut27W
	Uemo060dlFSVVxdZtw3I1O+vzCUOOQrtVwUqTeBhXSJIPv+e/tzy0tmPYq65K+s=
X-Google-Smtp-Source: AGHT+IHERRNksDcH4woDGxy6Xo1Vuyyg8Mbm887V41NlviKjtKHNlpNjAXx0lyE4C/9XGCG4TpjpNw==
X-Received: by 2002:a05:620a:3f85:b0:7ae:2f04:bf9c with SMTP id af79cd13be357-7b11a35f56dmr600500385a.18.1728688822487;
        Fri, 11 Oct 2024 16:20:22 -0700 (PDT)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b11c0a8902sm89949785a.31.2024.10.11.16.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 16:20:22 -0700 (PDT)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-arm-msm@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/3] arm64: dts: qcom: x1e80100-crd: enable otg on usb ports
Date: Fri, 11 Oct 2024 19:16:22 -0400
Message-ID: <20241011231624.30628-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241011231624.30628-1-jonathan@marek.ca>
References: <20241011231624.30628-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 3 USB ports on x1e80100-crd are OTG-capable, remove the dr_mode
override to enable OTG.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index eb6b735c41453..bc66f4713b231 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -1568,10 +1568,6 @@ &usb_1_ss0 {
 	status = "okay";
 };
 
-&usb_1_ss0_dwc3 {
-	dr_mode = "host";
-};
-
 &usb_1_ss0_dwc3_hs {
 	remote-endpoint = <&pmic_glink_ss0_hs_in>;
 };
@@ -1600,10 +1596,6 @@ &usb_1_ss1 {
 	status = "okay";
 };
 
-&usb_1_ss1_dwc3 {
-	dr_mode = "host";
-};
-
 &usb_1_ss1_dwc3_hs {
 	remote-endpoint = <&pmic_glink_ss1_hs_in>;
 };
@@ -1632,10 +1624,6 @@ &usb_1_ss2 {
 	status = "okay";
 };
 
-&usb_1_ss2_dwc3 {
-	dr_mode = "host";
-};
-
 &usb_1_ss2_dwc3_hs {
 	remote-endpoint = <&pmic_glink_ss2_hs_in>;
 };
-- 
2.45.1


