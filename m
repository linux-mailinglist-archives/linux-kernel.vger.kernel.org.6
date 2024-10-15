Return-Path: <linux-kernel+bounces-364911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD4799DAF7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66DE61C214F4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBEC158DB9;
	Tue, 15 Oct 2024 00:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="Lj9uvTCY"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592A415383A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728953610; cv=none; b=sNORR5NBsPhFpgm0nfS4l6UTkF025mkLyDyeze6ump+2mCBKFNDIbuwNHjTLvFs8bp+2swsCNFkm3iRraby3t3iFETq9H2w1+QNVWBDN2JJJqln/My0SfdAFUDpc6b4IB/YQY49DFKKM68Wi0QvGJuIpsm1psbht3RLlGGria04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728953610; c=relaxed/simple;
	bh=ARvTbpZoesd0jYRqz5wVnIxLACSl1t1S6Mt4dSv6f9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdD24eT1T9ez1uBgRaKNLtlVAzDJBEu1zlaPCgj+GDDiwKQC61bYVfiHLVO3H186GiD6R65y5kIyDGZd+DfohO2Qw+LomBRF7P2ZPLj0WW9zKLmtydPLjMH6fUpd9uN/u4nOf/62Ex92IUBfvWCdtKydKdhG0vnIhvOQ/fiMzxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=Lj9uvTCY; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cbe3ea8e3fso34758646d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 17:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728953608; x=1729558408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6yGSmyzg21J/Zpyi1ZX21XVWREXLzfX8fd72TE5Ubs=;
        b=Lj9uvTCYw/s1Y5RYSVWvx9QISU7CFXRr6Br3U3m6y6AgfIB5u1Iwn4AMkfZdsLpgDQ
         wcCs9d3RBsLMayvLD/ZYUQb9srx1i7ojpUe3m6PvXhrKJiDeRzTL132NWdmjHo4H3TpZ
         IKMtkf2zFglqYMuFvXyHm+MVqZ/l6BODr46TtDqiHcB2eQ07xoVwyvl4mpFYwr+8mxbX
         rp+lsjmvbj3wK868E1bdyqFzwr3SIU2etVwaG2nQKEiYdoC1VMtigTFFbFQwKIL7WKFW
         Jy5e4Vv5x7gLIlFeQ/8/O0LiUqc2RawEf1w8O//2UZGnrNVWCvM/2uIHKelxcLES2zJf
         xDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728953608; x=1729558408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6yGSmyzg21J/Zpyi1ZX21XVWREXLzfX8fd72TE5Ubs=;
        b=nwRNRyBLrhhBwAwE90qYs5/ftRDhYiB7yX58rOYykhpIIlHxaNfBBKnbfKRJ+dC1Pp
         WvnDXfdGQvBmqjySkMxo9HzNaOm1AiIY4Yt8NTi2wgECkklO3WsXcjJd6pRU1NeKDlXB
         rE9toU6gC08Krj7q/NTGocwEa2W74n0ggVIgv5rm2I1TL4VeZ92Vg65xSJv7GS6iUtpD
         +8FfhVZP6hYW4NzvTKk3YuwKv/DOYtLmrqapL2SoEINtfUonxOzg+4Lh67A/Gg3sd4NV
         Rh8SVj+Ac8Lv4QxE0C6bZ3QmIibnKEbOk4DR+MwSR3QPMH3VJiriaCmKAe4ix9YspgpF
         1F3A==
X-Forwarded-Encrypted: i=1; AJvYcCUvxasGfJtExsbwgkXpiBVWt5jvzP/kjc7D5aWcIdZSok1yMjlOW96rJ/Tmeni1zqnaOJQ3bLqWUk2S35Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7hCUTvJsJfFCK+VsGZpf3CTdFBIyewucoKrlN53uUbjPquJB3
	JjAy0o1cX3ZgDGFmgoH7QzJJzBpnnZWkb708uyfz/rU+ON4PuLlBRspWNayNpdQ=
X-Google-Smtp-Source: AGHT+IHf0nAGD+4xCXnuvCm+B5XwJ63HlvoTp9hlVDxHTSlAp5n2GzNISk9in5eaiN2OJu3vbb/nAg==
X-Received: by 2002:a05:6214:3b83:b0:6cb:6d58:eda with SMTP id 6a1803df08f44-6cbeffd31fdmr217094176d6.23.1728953608327;
        Mon, 14 Oct 2024 17:53:28 -0700 (PDT)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc22910f0bsm1213956d6.16.2024.10.14.17.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 17:53:27 -0700 (PDT)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-arm-msm@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 5/5] arm64: dts: qcom: x1e78100-t14s: add rtc offset to set rtc time
Date: Mon, 14 Oct 2024 20:47:30 -0400
Message-ID: <20241015004945.3676-6-jonathan@marek.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241015004945.3676-1-jonathan@marek.ca>
References: <20241015004945.3676-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

See commit e67b45582c5e for explanation.

Note: the 0xbc offset is arbitrary, it just needs to not be already in use.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 .../boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts   | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
index d18461c545547..f05523cb51cd4 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
@@ -897,6 +897,17 @@ edp_bl_en: edp-bl-en-state {
 	};
 };
 
+&pmk8550_rtc {
+	nvmem-cells = <&rtc_offset>;
+	nvmem-cell-names = "offset";
+};
+
+&pmk8550_sdam_2 {
+	rtc_offset: rtc-offset@bc {
+		reg = <0xbc 0x4>;
+	};
+};
+
 &qupv3_0 {
 	status = "okay";
 };
-- 
2.45.1


