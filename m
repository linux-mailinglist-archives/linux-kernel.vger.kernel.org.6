Return-Path: <linux-kernel+bounces-569648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B2FA6A5A5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFC51894E43
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCFA21E0A2;
	Thu, 20 Mar 2025 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qdxths+v"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCDE1E1C3A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471803; cv=none; b=MZYDEVC1l8qZWTnntPGc0tm5oAvwdCrC/MuuafFMlJHHdCIercZkIaTOmFJP98PdZUFvhTF2bbnUXQiqhPLGU/V8I0CioI44Du61Ut1RqCxp7gGSdzojZl9Fj3nNk6ldxHhpVv7/nUl8iVgMnAwyDwYPgEWeEVM6RuFfF3K+NLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471803; c=relaxed/simple;
	bh=BMShRTcWJEQSaIviUcz1ALmaZ6O0uj4o+VfvJ359y5E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CocslQuvJECu6/2Dt+S5hhfQAM9fv5KRgaWspDGK1bUymMWyMewwFd0M2mq+FcIM2wFymBsPVxYouwTwpA9BSpHj/P4heEJWMhgdiYPrkTfk6vNJIcqNA0dLmhYRwuV9ct9VCZtwbGXz6r+ancCV5kyv5Z+dWjcKitz3mH8QUE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qdxths+v; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so313645f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 04:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742471800; x=1743076600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BX8azcuPUPcGmYXdX3K49oOlARId2JPIzgFIvQ9dQ4g=;
        b=Qdxths+vOfIaseJUEsulczxWszpVXnki9fEhPVxKbaTIn84YNKsgTCXEKx7xkIgs8M
         k28IWfLxjLeTRf0SOcTGf08a2AAkb6LdI+6WYWZxkTrekAP57Bsn1qV22PeNscObkjAk
         qZXVfNdMOMASggAZD7FcHcIl40E4bhW9XyT4lbpEC6F+c6+HSI2/nKLoRP/ZURFAVJDA
         +7ZCi9y/hrbqVc5Jc/Fn9hKIBF19eJcoXafVOv1degNtNiwp7+w3qML1p7wkylTgwQa4
         RHx1KHWVZ2QPFaGGpk664pUObT8zcXkAh5f6O1+iQEl5hbqgs/W5w26iy/IDPMK3Q+3F
         ExWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742471800; x=1743076600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BX8azcuPUPcGmYXdX3K49oOlARId2JPIzgFIvQ9dQ4g=;
        b=hi5ut3QQe13Vzp0e8A1kHM2slwdHmj8J8GyLRkz2AFvEU+LI6s/Om+ufW0G2s20cTy
         J4Z01qmiaSPIPuBjn7xRAcmNfHLTYyK1MT59V2JEhboMG3Z4CbXQBrTGuFR/ESSeWsmJ
         M1pcL/3ijTs+nD4UGbeRhw0ZcCwJwq8yUx5RwksV5QjqwP1Ru+Ny2J/px4oneqgQ8Tmz
         nAK6usxVuwM8CQYnlEcBRoIoftKw8WqsQO5oPVDW0QOjzdv0Yoet9pvDJ186wg2uQNpy
         LP7Ak1YgmhEAbTLPctC7O63MLHtMNmumt/rOnhbx3Q2CnOtXoAHGAY93Z6oDEcrSc5BJ
         fTuA==
X-Forwarded-Encrypted: i=1; AJvYcCXw+Gyg1no4NG3n7OFkXVLvz62tgkRKenPNb4H5YNK0zBc56R1fGPpBVfEcoSvKRZFuGDV3blk46HtToJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXb1un7T6dtJCK8fPgs3zOIl85u0eQaUghqUTIJ9lkaDta4aCy
	R/IqPAunSGtd9ubDrCRA6+BKxa+gtFo97/RJXtQoAAVidoB50Ja/mbwREUce0Gc=
X-Gm-Gg: ASbGnct5qvkgaujJ4uqv+bVflIbqyseuzaEkVdxnskj6kIRFl+5rDKm/aoSLf8tQ9wf
	1ddq4MHeaqg5Pn/DKZGX1/BZzL3L1BGbXJ0zGgiaWnmt6G+ziI6j15bQq/CeT+8YD1D913Vi0je
	+FRGVSenLzw5yOjbPvn/2UEP9NyFUVBJukNxgz/VNNEVe89ZL7Dw/TjE5v3MpIV4y8FpML+iFkh
	wsArWbEqYqBv5/eKPxei6N33ZNqgooLZcsWjFWtGuy0V6PvUHuhxkQXEel+U5aINdSsJMx/sN0z
	lVJIGQITv86OBSLpa4WAQQtvJd5MK6lXkJu26kuHnQTS3t3Sxp3qa1YihIR9dsEQKaoHvQ==
X-Google-Smtp-Source: AGHT+IFuA3/VMVKcDf3fFvwvPD1gU5PkZBOsrXrba5zDC7lgg5k/5Q4hY20InWuM7OSFEj3sUpm5YQ==
X-Received: by 2002:a05:6000:2cd:b0:391:2fe3:24ec with SMTP id ffacd0b85a97d-399739bc8c0mr6784071f8f.14.1742471800069;
        Thu, 20 Mar 2025 04:56:40 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c888117csm23257857f8f.44.2025.03.20.04.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 04:56:39 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: peda@axentia.se,
	broonie@kernel.org,
	andersson@kernel.org,
	krzk+dt@kernel.org
Cc: ivprusov@salutedevices.com,
	luca.ceresoli@bootlin.com,
	zhoubinbin@loongson.cn,
	paulha@opensource.cirrus.com,
	lgirdwood@gmail.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	konradybcio@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	dmitry.baryshkov@oss.qualcomm.com,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	johan+linaro@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/5] ASoC: wcd938x: enable t14s audio headset
Date: Thu, 20 Mar 2025 11:56:28 +0000
Message-Id: <20250320115633.4248-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

On Lenovo ThinkPad T14s, the headset is connected via a HiFi Switch to
support CTIA and OMTP headsets. This switch is used to minimise pop and
click during headset type switching.

This patchset adds required bindings and changes to codec and dts to   
tnable the regulator required to power this switch along with wiring up
gpio that control the headset switching.

Without this patchset, there will be lots of noise on headset and mic
will not we functional.
   

Changes since v1:
	- moved to using mux-controls.
	- fixed typo in regulator naming.

Srinivas Kandagatla (5):
  dt-bindings: mux: add optional regulator binding to gpio mux
  mux: gpio: add optional regulator support
  ASoC: dt-bindings: wcd93xx: add bindings for audio mux controlling hp
  ASoC: codecs: wcd938x: add mux control support for hp audio mux
  arm64: dts: qcom: x1e78100-t14s: Enable audio headset support

 .../devicetree/bindings/mux/gpio-mux.yaml     |  4 ++
 .../bindings/sound/qcom,wcd938x.yaml          |  7 +++-
 .../qcom/x1e78100-lenovo-thinkpad-t14s.dts    | 25 ++++++++++++
 drivers/mux/gpio.c                            |  8 ++++
 sound/soc/codecs/Kconfig                      |  2 +
 sound/soc/codecs/wcd938x.c                    | 38 +++++++++++++++----
 6 files changed, 75 insertions(+), 9 deletions(-)

-- 
2.39.5


