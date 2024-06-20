Return-Path: <linux-kernel+bounces-222794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3369107A4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 469C0B21379
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B25E1AD4B9;
	Thu, 20 Jun 2024 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ys2oz0Rs"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB8C4F211;
	Thu, 20 Jun 2024 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718892704; cv=none; b=tvhVUQWEICpk4I2IWBGK5FYp0gg76ljCSby7PEorr7fb9ernf8h1gty19ODxWzDF3al043cJDrZXhxs72Oz+wNQ0ZgXAXGwvJAXL+kdoAyZDVOI2IrBsfFC3azTQFfIopJ7nnIMpBHgTwhCtNDCpVKJ3fmjdFzTaPwuJzcbeGFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718892704; c=relaxed/simple;
	bh=UypyNJH/5Fw7YUZyk5xxbqlACwezSpBXOcNsj7LxJrw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=uDj88hXUzwHQxGKItl9bt7Ah/nGRI8TQkEtHuqVBTkkyMAkMTr/RBA8rAa/C1mGWCnyspdcdkppVWyUKJL7tzUCglogwSM+WdNu6+W1FbjTiD95gggdAdo6/ah5VOa57baHlQDEXKxG4Tyf5vIk8SUSx/a2ioaE7BPwufgU8QNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ys2oz0Rs; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6fb341a7f2so119593066b.1;
        Thu, 20 Jun 2024 07:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718892701; x=1719497501; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLF9zl+L8Mm7lU4AoqgefyMRhZ+wS9MBIn1Wjck2JRM=;
        b=Ys2oz0Rs9kMHKxxg8PP/AeVu25R60HtRaxp9wZAvfL62cYVor3anHUrjfDG17lofLz
         /E86v9fZSHkd/mL3x4fx6mOnfGuzmUIEFfEoFfw0cfnZb9MEVayX9C0ydOwCTvyv+Hq9
         J+I5zq0olbjPEuRXceRUuAg5A8TU1RzbojFDggPf49kkq+VwYi5Zm8/w8CXIq+Jalls+
         hujGrGpdTP9KFdedwvmXVc+o1hiu/OfAVrGMCN2jQilXCNjd6GTz5V7NHrLr2Elcuibm
         h/3QPbXDN66gP3RDprvAyoXbpaikLfIzmKocvzM9ysYd1LRhqImuPoPl9oe8dygZDjBL
         QuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718892701; x=1719497501;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bLF9zl+L8Mm7lU4AoqgefyMRhZ+wS9MBIn1Wjck2JRM=;
        b=Q+YyfIVuI3dGu62DEtFhUOGqX5Qmo3VzN/Jev5DXNcJoRH18Y4iZj24Nzk4MTC3nh9
         GOReGo71wH4ZlKDZfKtR9JbsX1WkGBz6aY2owZFCSVqkgiCFGDqh3YXeLlaQdrE1kjdo
         t5iAqElUQ6tSYbce17iE9bW63z5R6c7WDyV9BSQPcMTAJWBDVsKmIaV0LNn0GvCTEADO
         5G07bnkPC42LKjx0c9sXeXslULcb4XhLjYDqHnbDkJNStgRgN4c/LKdaZ/K5vjqSXb7r
         cAxcrmNw+VKhdpTFRQ4/MuRBZbh0pMJGeo1ks66hYWDf+zJN+MCN1X6BnSFLls6oaQs2
         SA/g==
X-Forwarded-Encrypted: i=1; AJvYcCWETHhnOZ53TezrAsQ3jsRHJOi+NT4DxG4bXSh6y8Di2EZPgE9kh3GCKx/bxMUIDqyjEJlp5RMUVh+5VwXUn0cQVoXur83TgMOPU2Cf7N0afBAJvn/EGmQUbwCyMZ90rG0qPlzqhsvatA==
X-Gm-Message-State: AOJu0Yyj+QYDSZ+XDPk3eqCYwxZMXsWsKyItE5JXUStAztaFOF9Rfasl
	QAETSsA9jYAPInNC1OU70rbxXMFw+qnmX8HbQVw7dTGM10x5uEeX
X-Google-Smtp-Source: AGHT+IErRFRQRmLH+rlW+KU/hVUJABPZ3okIiiRohJA06n+XOlP+9KDc1vb5BXSzerQN3sk+791O5Q==
X-Received: by 2002:a17:906:16ce:b0:a6f:cb3:55cc with SMTP id a640c23a62f3a-a6fab7d6d8emr320883866b.73.1718892701054;
        Thu, 20 Jun 2024 07:11:41 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? (2a02-a449-4071-1-32d0-42ff-fe10-6983.fixed6.kpn.net. [2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db62e5sm767879266b.84.2024.06.20.07.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 07:11:40 -0700 (PDT)
Message-ID: <aa79ff87-ea94-4f6d-a81b-5110724243f4@gmail.com>
Date: Thu, 20 Jun 2024 16:11:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] ARM: dts: rockchip: enable hdmi_sound and i2s0 for mk808
 hdmi
To: heiko@sntech.de
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Enable the hdmi_sound node and add i2s0 as sound source
for mk808 hdmi.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3066a-mk808.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3066a-mk808.dts b/arch/arm/boot/dts/rockchip/rk3066a-mk808.dts
index 06790f05b395..4de9a45c4883 100644
--- a/arch/arm/boot/dts/rockchip/rk3066a-mk808.dts
+++ b/arch/arm/boot/dts/rockchip/rk3066a-mk808.dts
@@ -143,6 +143,14 @@ hdmi_out_con: endpoint {
 	};
 };

+&hdmi_sound {
+	status = "okay";
+};
+
+&i2s0 {
+	status = "okay";
+};
+
 &mmc0 {
 	bus-width = <4>;
 	cap-mmc-highspeed;
--
2.39.2


