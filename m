Return-Path: <linux-kernel+bounces-430857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AAC9E3693
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8BC1692E5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5321AC429;
	Wed,  4 Dec 2024 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EqisiMma"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8411A38E3
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733304543; cv=none; b=p/8ODUVKdLGqmJRNFobi0VKaeipOoTO6lg/jFdNxem4vskS86zJ992UvGUKBb30+xXXd9g+2SDwKwiOEG/DauoUEZPH146O6xgCiryViCtD/Nd3ztu5Kpf6JKTlABuyjSvhNVjCW+9kOiUMVibk2PYCYv/h1xhspIIbGfujsNwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733304543; c=relaxed/simple;
	bh=pNiUJqMvkF3meLNvGaIv4zqxKa3SDQGFsOEQTo+IM0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T7KSnKvQ9iKkS8OBIP61sjptQiXPWNGFJaqrRcPU4LtYi5GuUp2y9zSRrxhE1/HSUx7DvdsF+eLKlngD7k9BoOTSQ1EnyjZQEbIdG5vTpaqqatwdi404aiTHpFaTuYva113KRQskoDnQ+iwAIUmpeqFEaioRyC275iPHD30IK/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EqisiMma; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71d41932d32so2858800a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 01:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733304541; x=1733909341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rSvjzybcpgZsvOT9TlMKPiZLpA7cHiGiwj+87vtqrQI=;
        b=EqisiMmaW5U25z7UrOhCsxY3tp5oIIAcFWVlkvU6fSL83i6z/WOItnSXIZIU54pbK/
         /JVOk0WuKXYEi1MVb5MNyOSfAd84JhU7d2T3+s9QWMXJGiCDU4JnBYKUJpGc0fiVvs1n
         1Wx9oxS6s69Fy5u8z5np4OE9Tn2vCA/fbBP40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733304541; x=1733909341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSvjzybcpgZsvOT9TlMKPiZLpA7cHiGiwj+87vtqrQI=;
        b=LNyaBJ82gJw6VEaD61JDbNMLK349oOhiv4C2zVciFcDvn+1Cf4U/KrP+zXOxh1qW6E
         c9weQ+6n5JoSEzBkvFC6BSca58F0eeJP1ETjYHPyhtiTM1LJl94i14XZAOmhvMrxT816
         XVd5nmR3PGVSgfTCjy6C/s0PMDSen244VciMsLejJHNaIsr7V9rV9VIjohcoDLXHEpWr
         871mCRXImknbNvONcpkc30GoUgXFgPfSYmhOXSNs3ptNZNRYbfVC5k3mp4VMsNDyL3yZ
         mLQ0U2s2uorWdSNR0XQQIGOWc9ulfqpoaUDdZ2A6S62D4vrRSKPyHEWrA5mdQ0sX9gyf
         Iltw==
X-Forwarded-Encrypted: i=1; AJvYcCVTSoeD8Nuuef8jQ0nTeO4bqvI92tYVmNwdwWaRZgsPcB757hpEHuWc2mzuDD1ohvpBRTAGdr0F4nKqdO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJeSFfPgRC2ROnfgX+P37ccXWKx6w97gUIkymxoPYNwiCau7rD
	NwDbPP5NDOZQCDKsLOys+up6f17a9vMlDjVw7Q3I+lOqFyaemWR1gQZMifaDfg==
X-Gm-Gg: ASbGncvshnkBN980ofpwlmZ2ubG8x6+A4TaUyUqBY8tU5ByNw2Tn4WPI7HIUTSnOFgH
	fvZ6ezyKcJ3ZGV58vpqN1BVUgaxp60fqJxZAz/TXIthk74NioO6oclno6otmkznuLiU7mBldeGJ
	xQvP6YVt2o9iN1SODFuejJd/nqrHU2pZVm6kT3znshBx4aG+mEfZdsfP9FnYixAH3s4Te5idWRp
	u+gHE/luTXkLasg+VGJ1xMHCgat+AeOqitPMXJkIkeCN65y6IB4sWnYQD1KYlOX3sYU
X-Google-Smtp-Source: AGHT+IEDEK2nhMPbAOsuMuh6j108aGwGF9PHLhxq9QdnWZtG1dV+KYKtrNgMaqBZ6YJiiA1s1lmFsw==
X-Received: by 2002:a05:6830:b93:b0:71d:5a8a:1a37 with SMTP id 46e09a7af769-71dad652b13mr7062531a34.15.1733304541404;
        Wed, 04 Dec 2024 01:29:01 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2eb1:a68a:2625:b944])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c2d38dbsm11049024a12.15.2024.12.04.01.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 01:29:00 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wenbin Mei <wenbin.mei@mediatek.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	Frank Wunderlich <frank-w@public-files.de>,
	Andy-ld Lu <andy-ld.lu@mediatek.com>
Subject: [PATCH 0/2] mmc: mtk-sd: Limit second register range to SoCs requiring it
Date: Wed,  4 Dec 2024 17:28:51 +0800
Message-ID: <20241204092855.1365638-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the usage of a second register range for MediaTek's MMC
controller is seen only on a few platforms. However the driver tries
to grab the register base regardless, and then ignores any errors.
This makes all the other platforms that don't need it produce confusing
error messages.

Instead, make the driver only grab the register range for platforms that
actually require it, and correctly handle the error. Also fix up the
binding so that validation of the "reg" property is as strict as
possible.

Please take a look.


Thanks
ChenYu

Chen-Yu Tsai (2):
  dt-bindings: mmc: mtk-sd: Document compatibles that need two register
    ranges
  mmc: mtk-sd: Limit getting top_base to SoCs that require it

 Documentation/devicetree/bindings/mmc/mtk-sd.yaml |  9 ++++++++-
 drivers/mmc/host/mtk-sd.c                         | 15 +++++++++++----
 2 files changed, 19 insertions(+), 5 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


