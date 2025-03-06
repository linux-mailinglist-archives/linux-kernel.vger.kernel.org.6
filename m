Return-Path: <linux-kernel+bounces-548509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D28ADA545CC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3ACE3A657C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ED519D071;
	Thu,  6 Mar 2025 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ThygRnQD"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8589F20297F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251923; cv=none; b=rDhSRg3NwqtYE8ogBaVmOPM6QbRv2iW+qcLt0sqE1WW6P59tZwpJEEx/MLPvyojZ4p5P1YU109S573MtkaLNNjBdbWSd75U68ZrOM866HTCJ+Tl2MsuselWoW4Cl9SR584/Zyh5NUm95Ghm0VPApRPwQIq7/OLBrsAEJBJza84Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251923; c=relaxed/simple;
	bh=JvhKk3j6bzUfojj0ONyioWlTV4mog5yq3Mn6X6smoCk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tXVu0iUilXHKCgCpHwyb0egEnK2jAp4YB7hfDD/JEQw95rXOOVB1zCLzPtQu9uk1R2meH0DU1SGV5lIrCZMXJS85z1rgsRWvytip1JSrjJsIRAqSJcI17n9Wn1XAtrBiCsUtrrcK9/s0EJR0TD9mvgAaLEnXiGRqw+IozfDNXg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ThygRnQD; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abf4cebb04dso85432766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 01:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741251920; x=1741856720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MAX58En/Hb1n0GC+JRkiHWBwbQ4TWebixhTAU0+fOXw=;
        b=ThygRnQDG2Qx03PRK56Kc2J8x8VUAsHZB65HWvdAfr6CpETxWydOTrcqdrcBZk6Fzq
         YHkMeHR65JQIUGHdTFVd8HVnZryDUfuQo/UE39Pvv4cpFBMdrKxFhS6cC+sFSwWY5tAB
         DlYC0apQ2XHAXd5U00Ng3H4LyBeWioukLuKa42bWYmx8qULJu3OFtGGMywLZFmzMTkEy
         ZF2D8YENn7P1VX/0ivlcxPaUUrKE+CrzraWNitniQd+6WH3DvYkwOn628gyuT7naXzvm
         bNcThKWj36pS07j580L/e1W3ABYyYs/4ZpYXl5UGAKdJutkLiHloaZIpTDK7H2GgPF67
         jCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741251920; x=1741856720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MAX58En/Hb1n0GC+JRkiHWBwbQ4TWebixhTAU0+fOXw=;
        b=ASngTAOatqbMu34OKY6yJ03d23BM9yE8c3lCWI3p8rUqg3iaHes5sLqQ0q0bG+y7Op
         N14Zv/VwQsntxKOhe5huErpJWuFyL+j9+V4Ik+Q6ZosWX9GiS6cHCVpXszPwBbCkk6oR
         WoqfqaHNqplLMV9Iv5k97fps8+cXZw/yprgzfn23eE1wBllYKHzoByyqBEs1MpH5EZZ9
         6OZUjkZP9++MEXDTnmH8xcxJGMMLCXn+sjf2Yv+iZdzOF03lIkX/3EE7DPenanHmQfRr
         6ACELTLHYGTPh2Y4t15JlmO/N1Pf84fCtXYYtAUjo3xgCQIxTFavnv1JeD16Z293uXiu
         LzSw==
X-Forwarded-Encrypted: i=1; AJvYcCX5tdibPQiAB6iMQY/q5myuHsIRvIJicQPi85hGB+N3zyM7pQTy/XwJWKf2QQL1cQfqRuzXbc/HN9E62LY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKPNd+81+v3zg6iDrRmsiQHg5YZqaLncPC8WKGU2EmOeiK7BL+
	5lvHjDLiLs9jKtT/Qoc6t6789f2y1BfBUCvQSaUBnEptoSmR0FVA2rxI4uZxTKQ=
X-Gm-Gg: ASbGncvb5YSuJM4u3aWnlwkh0eBJp+nF64BvnETaUlqMkhZbFXceVBWjXEsceTah3wM
	dx8C7ExIpoZpU07t/jHAC68QOeDlh8/4hUzTJuj4cHAwkOWZN2IzrWkxJ/Mwv4aJcl8837/KQ6W
	yeRWWTfGNp+DpGoqiy6LtdoCelojdNxHshKHLODBQtk5YBqXLWT9jzqyWo6R3spBirenUwKNyLt
	oOYk3XyvuIH1LmzR9tLr7Z8q5OlJ18vt3zKhb3JLxAZtN6u+gA/6RW+AI44oORfci1F8PlyhVy5
	1uOMTg0fKh+MZ6h6EVGJNIvXlY6qYPNtBhEsucPIGM4=
X-Google-Smtp-Source: AGHT+IFBF85ne/IZkMGc2B/0aHOH+ZFaKTA8+EhhThtignsfXZxxEqemHN79VLEWyfsCNJMyXOwolQ==
X-Received: by 2002:a17:907:608d:b0:ac1:e18d:a738 with SMTP id a640c23a62f3a-ac22ca9e8fdmr254010966b.3.1741251919650;
        Thu, 06 Mar 2025 01:05:19 -0800 (PST)
Received: from hackbox.lan ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23943a194sm61606866b.37.2025.03.06.01.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 01:05:19 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>
Subject: [RFC 0/2] arm64: dts: qcom: x1e78100-t14s: Rework devicetree for LCD and OLED SKUs
Date: Thu,  6 Mar 2025 11:05:01 +0200
Message-Id: <20250306090503.724390-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Lenovo Thinkpad T14s Gen6 comes in different SKUs when it comes to
panels. The only difference that is important is whether it is an OLED
or an LCD. The way that backlight is handled in devicetree between OLED
and LCD forces the need of two separate DTBs.

So create a common T14s dtsi that describes everything except the
backlight handling, by renaming the existent dts to dtsi. Then make the
legacy dts the LCD version, while adding a prepended oled dts. Both
include the generic T14s dtsi.

For the OLED version, I do not have HW to test it on, so OLED specific
bits will come at a later stage. Still, add the OLED dts in order to set
the stage for it.

Sending this as an RFC in order to get an agreement on the way this will
be handled from now on.

Had to format it using "git format-patch" since b4 doesn't currently
support -B when formatting the patch, and the renaming of the dts into
dtsi (plus the panel properties being dropped) would've not been visible
enough for reviewers.

Abel Vesa (2):
  arm64: dts: qcom: x1e78100-t14s: Add LCD variant with backlight
    support
  arm64: dts: qcom: x1e78100-t14s: Add OLED variant

 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 .../x1e78100-lenovo-thinkpad-t14s-oled.dts    |    6 +
 .../qcom/x1e78100-lenovo-thinkpad-t14s.dts    | 1190 +----------------
 ...dts => x1e78100-lenovo-thinkpad-t14s.dtsi} |    6 +-
 4 files changed, 64 insertions(+), 1139 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s-oled.dts
 rewrite arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts (98%)
 copy arch/arm64/boot/dts/qcom/{x1e78100-lenovo-thinkpad-t14s.dts => x1e78100-lenovo-thinkpad-t14s.dtsi} (99%)

-- 
2.34.1


