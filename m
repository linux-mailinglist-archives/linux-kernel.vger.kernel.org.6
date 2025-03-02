Return-Path: <linux-kernel+bounces-540176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A122DA4AEFB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 03:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3997216F352
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 02:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FFC78F5D;
	Sun,  2 Mar 2025 02:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IhjWvbJL"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D38199236
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 02:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740883812; cv=none; b=WlBXG/Yn++PEA6E47HBXTPPs9bBy1Ncffc89FLwjLdz1zJI89zUj5oLt1hWSCW+SZj/JSOWZfUapDH7/YgQ9ZiNemRARoR5uCShpmG928i3ox7jIp3x+LwFYxtBZgzZhoSP6jasSHhL/BCjxlw7bWqb+82Q1nHoFSCSh+mIni1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740883812; c=relaxed/simple;
	bh=WmCZFWg4ML7GDPYAsV0qX5TtydV+wOYSlwU3wZJ3AAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rv6Z6J4seawgGUoLJaUByd6q4yezhJkn+kJfHEbhrk8ehXvIPBpNcz4oGVmXLaedm59lJVDIIhmQ55XjvnSrpkktbRdmOnqr8y8yTheD+yJ1gi2urU3+d4UCcchw6kZp9v7tMnP+52Ef9I46ER1oKomAWj5DIjzoZYr00f5bSXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IhjWvbJL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso21713995e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 18:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740883808; x=1741488608; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/BlW7bL7bZaerou9YY75ViQDu87Xxz4VuPFkpQ+pcTQ=;
        b=IhjWvbJL0QeLZ/c8ReNMLIBrZeosn4L3GBpal5htcZ6PoVvnOCWzAqOPsgpCsmdasQ
         w2SUlyYUMPMJ8R1b2mWG5gpFvDAe+yydrqGi2Bt5wjWmDovxkb66IwvvCE2wgNMhDsRR
         o0YYmultkCrWbqIC+NLyevSf0txFIRarUFNrMS2Qt9ZlGBhiKbC2X8YGctrXrOzLg+li
         0lI3PlK/vi6p/6Yc4oQVtcNR19lwkh3D5722SW4FeJr3iq3ttiCnjlGcvPK8O/EHSldM
         srLWBzN4vteraGW0kaVrh0WkNx7ISc7ukigTMHdeGuo8h01KNL4u5rWQhuYigqy8uvCA
         eGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740883808; x=1741488608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BlW7bL7bZaerou9YY75ViQDu87Xxz4VuPFkpQ+pcTQ=;
        b=J+1HUq1tOyRondVVTTQDHNRDYmKFFDiZthMAW2ST0SSax5j4WNjcKdX+3PrCMy7O45
         ZQPa/4bk1ozNE2m/C80xHLrBrfQ/AvH7H45xeZKThWVkZvlh1xtNF+A/k6WheMXTT33a
         73hZOuVTAaZTlg7KIh5teqObaFRbiqbqwA+YhdEaOpK981NIWerzJSeTUDlMeK1RVX0m
         SqnEZr36qZp+J/EpbeqrG5hKjMetKCONchW/xkyl/uGpBkg02yR+OFB5/2TyJ+eYFbuD
         Ts0D0pqbcGaJi63rgyXUp9lyOU0TbNmuGmpoO/+BoNdJBCA/O6r04CpTL5cucsLujUQH
         VONQ==
X-Forwarded-Encrypted: i=1; AJvYcCVju4oOnt42Tiq9P/0cuBEl3Qe/kG9KJ5RZRtVIg6N5esVhR3xsw8WYENNcFFlF5+4T011TrutUmWTPAw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbTzvj3QyJdX83OMbDNDgTu4f0i2DXEjT3CO91s/4tzqgL5x1g
	g54vA+uolYXUL6ZN9Eca825V60Qdgm8ya/c3YzcUJIdXUvlaAziutss1gQ9r8qA=
X-Gm-Gg: ASbGncv3FMO4GgVwgudFXsa3unQkHha1kSPaXRhLrqTBuONRor85xoG/IQRBh2atV4O
	7XgZ2K0ECpkt5na4AQnoKJA24gxId8Ldp79CTn9ntoRiC6crJGf93yr/AB6MMElyFAs+DEA/ZlO
	UxuS/0GIlSdnyJe7qwjvMbZQfH9zkae75hb6nIfExNGyp7MyQw/BtqC2E5PgrzbZg0+RDGSY4JW
	QYKcbreqHM3cvSwB8mJ4RtI+xeCoZtJWLBWgg4bBH7/OATSxxqU5EkSogWPE3exSgTilwr2nDMY
	5RihP8/+GpOfoEZyWK75+Gxf4gYZc27RzGxD6vCI7B8NGNdhUoZ3mQ==
X-Google-Smtp-Source: AGHT+IFeHuGQXMsmrSnBRal4IqzNKKtnYK1nduyi/tzxHd9ITPXT123pL38GlhYP4gu7c5gygvjf1w==
X-Received: by 2002:a05:600c:5246:b0:439:98ca:e390 with SMTP id 5b1f17b1804b1-43ba6774a26mr66722485e9.27.1740883808377;
        Sat, 01 Mar 2025 18:50:08 -0800 (PST)
Received: from [127.0.1.1] ([2a02:c7c:7213:c700:e992:6869:474c:a63f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba532b0dsm137845975e9.13.2025.03.01.18.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 18:50:07 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Sun, 02 Mar 2025 02:49:55 +0000
Subject: [PATCH 5/5] arm64: dts: qcom: qrb2210-rb1: add HDMI/I2S audio
 playback support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250302-rb1_hdmi_sound_first-v1-5-81a87ae1503c@linaro.org>
References: <20250302-rb1_hdmi_sound_first-v1-0-81a87ae1503c@linaro.org>
In-Reply-To: <20250302-rb1_hdmi_sound_first-v1-0-81a87ae1503c@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 Alexey Klimov <alexey.klimov@linaro.org>
X-Mailer: b4 0.14.2

Add sound node and dsp-related pieces to enable HDMI+I2S audio playback
support on Qualcomm QR2210 RB1 board. That is the only sound output
supported for now.

The audio playback is verified using the following commands:
amixer -c0 cset iface=MIXER,name='SEC_MI2S_RX Audio Mixer MultiMedia1' 1
aplay -D hw:0,0 /usr/share/sounds/alsa/Front_Center.wav

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 49 ++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index 7a789b41c2f1887f0c41ae24da2e2fe8915ab13c..e547537cffdbc13cfd21b8b8b7210b62996ff431 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -186,6 +186,47 @@ vph_pwr: regulator-vph-pwr {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	sound {
+		compatible = "qcom,qrb2210-rb1-sndcard", "qcom,qrb4210-rb2-sndcard";
+		pinctrl-0 = <&lpi_i2s2_active>;
+		pinctrl-names = "default";
+		model = "Qualcomm-RB1-WSA8815-Speakers-DMIC0";
+		audio-routing = "MM_DL1", "MultiMedia1 Playback",
+				"MM_DL2", "MultiMedia2 Playback";
+
+		mm1-dai-link {
+			link-name = "MultiMedia1";
+
+			cpu {
+				sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
+			};
+		};
+
+		mm2-dai-link {
+			link-name = "MultiMedia2";
+
+			cpu {
+				sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA2>;
+			};
+		};
+
+		hdmi-i2s-dai-link {
+			link-name = "HDMI/I2S Playback";
+
+			cpu {
+				sound-dai = <&q6afedai SECONDARY_MI2S_RX>;
+			};
+
+			platform {
+				sound-dai = <&q6routing>;
+			};
+
+			codec {
+				sound-dai = <&lt9611_codec 0>;
+			};
+		};
+	};
 };
 
 &cpu_pd0 {
@@ -321,6 +362,14 @@ &pm4125_vbus {
 	status = "okay";
 };
 
+/* SECONDARY I2S uses 1 I2S SD Line for audio on LT9611UXC HDMI Bridge */
+&q6afedai {
+	dai@18 {
+		reg = <SECONDARY_MI2S_RX>;
+		qcom,sd-lines = <0>;
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };

-- 
2.47.2


