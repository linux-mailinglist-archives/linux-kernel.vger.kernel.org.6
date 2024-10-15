Return-Path: <linux-kernel+bounces-364906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AAD99DAE6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65841F23143
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4196856446;
	Tue, 15 Oct 2024 00:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="BOcee/EW"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2494502F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728953605; cv=none; b=IpvuF6MOd2nNisPN3G/uOIILwj5YXAer5atfBjsutKggOEOqR7ZRo5thy6c1fMl6fPzWXdB8X3N4ZD+NJjGN3+NyXqsO01wBlx3kxNE8IsDTC8QpDP5qQSOPNRLCtykIeKMRvSqBAvwCf5v2n0HBrcavbYqwDI9aFu0LMh6Sywg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728953605; c=relaxed/simple;
	bh=7/bYDZwG5gQSOjxXtGNG+aCpL4QOwMiPuf40BsF41LE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=grFMPkX9HR6G3V4R39tsyGjiSavYVE6928BVcvFGAHIG/0mYrfsJEKzG0/0h9oM1h7xnR+2T8Mk7DW4kbXVyhXytlLF7mWT1ZRD5yKrlvTbW2n9QOOdJubso1EB2nleCJNqgLGdBuUCihWaAqIfEkmFPVlJb+hUKGHf2XY14tKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=BOcee/EW; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cbe700dcc3so37711846d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 17:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728953602; x=1729558402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jqrv9fCsGQoNutoN42YBjCpBp+qUvSGmeJ+vISLCIE8=;
        b=BOcee/EWfRL62xc3R8JZB/z5H2B1+MQQcatjXln8iEWlwnIDVaAk1+rJ4MOBMLXsdk
         +r9SjQAVtPM/mfGFC2zjEDC0g4cLqui383J+SZYwL6pVKLRz9W63vtagr8UR/fYiYorh
         AUFLAg22HRg3YDC0br1mDNg++EHu/4d4TXEdFpZcb+WNeSLcLlbD0XdN4FLWbeQ8d+pE
         MpNOFtC5g8uBU06B9CuMwW/75Z1Zz/e/HwMD7lS3eIS+6KZCiuUsNgdRTxI6gsLsRlNo
         sScOUaYJGecTr+K2uutwNrBc9t+tuwDPVgJycWc8+ycl3I2KpZzGHspB29hByepGtmlm
         28ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728953602; x=1729558402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jqrv9fCsGQoNutoN42YBjCpBp+qUvSGmeJ+vISLCIE8=;
        b=dUmu9V6y2sj5ClGTDccftfWl7y6n7c0DEA46/NzBVVOMObJn40yWCI1ga6iETVag8s
         fLvSSAXheF+fDEhF7biFxn/8f7/QjQnR29zLDzanaT0609jhAElZYMHsCSHnDOsxnvud
         AcrXtT5WCX/jesjzOqsRipWJGDk5XRuS1IDSO4d0jBhd43DL+5kWffgJpGAVvsdUzsIi
         WDk1iH1SCh5JYIOZMhz0xFAQ3C+GD5nhBvN2J1byTxfc2jEKuBAt+XTt13yPwPc6zAML
         /q7U0VUM4U2uX3IpYEfEdV2ii4NrhSu9cuLnV3Smstx+tciIz2/9Ycpi1Llc6AO32Xyo
         Vi3A==
X-Forwarded-Encrypted: i=1; AJvYcCUEqNrGLek1nEBKD6aaTnThBKssBhuG0ua8xa9jLHZCPg2cwC7qBflpJuaHlKnknz0//19kYSJxTLblOTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIA0B8Uq+aFeqFy92eqhN+jvxwQhq169HS+BcdrjbTYgFNdZfy
	PqVgNsYJ7A98XPGTElTI0SBdh30YGRUHS46475LyqWljyCOzBsQmccaSGVUDbnM=
X-Google-Smtp-Source: AGHT+IFfCoP9g5esUnZD9NdkTUNwRKk5/mdnFQRGMYxzk4NzOKyEkw7d+u0WCrNS3asHWRpShXg3EQ==
X-Received: by 2002:a05:6214:3a8c:b0:6cb:f654:55ac with SMTP id 6a1803df08f44-6cbf6545880mr201576446d6.11.1728953602008;
        Mon, 14 Oct 2024 17:53:22 -0700 (PDT)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc22910f0bsm1213956d6.16.2024.10.14.17.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 17:53:21 -0700 (PDT)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-arm-msm@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-rtc@vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM),
	Rob Herring <robh@kernel.org>,
	Satya Priya <quic_c_skakit@quicinc.com>
Subject: [PATCH v3 0/5] x1e80100 RTC support
Date: Mon, 14 Oct 2024 20:47:25 -0400
Message-ID: <20241015004945.3676-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x1e80100 needs a workaround because the RTC alarm is not owned by HLOS.
It also needs the same offset workaround as sc8280xp/etc.

v2: remove duplicated ops and use RTC_FEATURE_ALARM instead
v3:
 - renamed flag to qcom,no-alarm
 - don't remove alarm registers/interrupt from dts

Jonathan Marek (5):
  rtc: pm8xxx: implement qcom,no-alarm flag for non-HLOS owned alarm
  dt-bindings: rtc: qcom-pm8xxx: document qcom,no-alarm flag
  arm64: dts: qcom: x1e80100-pmics: enable RTC
  arm64: dts: qcom: x1e80100-crd: add rtc offset to set rtc time
  arm64: dts: qcom: x1e78100-t14s: add rtc offset to set rtc time

 .../bindings/rtc/qcom-pm8xxx-rtc.yaml         |  5 +++
 .../qcom/x1e78100-lenovo-thinkpad-t14s.dts    | 11 +++++
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts     | 11 +++++
 arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi  |  3 +-
 drivers/rtc/rtc-pm8xxx.c                      | 44 +++++++++++++------
 5 files changed, 58 insertions(+), 16 deletions(-)

-- 
2.45.1


