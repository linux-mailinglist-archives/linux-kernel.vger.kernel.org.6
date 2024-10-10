Return-Path: <linux-kernel+bounces-359614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE35998E1A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDD71F24BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A675719C572;
	Thu, 10 Oct 2024 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQImqnCz"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0B538F9C;
	Thu, 10 Oct 2024 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728580320; cv=none; b=iGTjHvDXZA3fobO0bPLN6jfyvh1H16vY8Mhd3cXz6aWLfGNe/TNcHbSVGjIHQclXlgXacniydaqMCXgJnvNCqsW6eovXAkQ2lWT4lNk/JBLV6QcE4E4fa1cQw6HWQgV7FLAifRGHKRHhajV1n4nOxRU+0DYRyG/JvMBGNfo36/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728580320; c=relaxed/simple;
	bh=1RpRdsGO3jaA0TDmTTsokF9K2G0CK52NDNqsAWdq0yU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FV12cqap70kuG/0CQO5SBcZW3KyBK0kjee+hY97ddOxIHyk6UGXZ1/7KnadgKd0t/vCB7sCQ/nvHOwvF9+yL9sLGdplHAT2tEiNEXZvSuoTNh9dkh+RaKbxzpyOiTFdS8t3w8Mxfso1QZZ+6Ak1koShxuaj5WiBViE89FBFPX4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQImqnCz; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso849643a12.3;
        Thu, 10 Oct 2024 10:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728580318; x=1729185118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AWNpFyttizV4KmPkZEHOHP1DUhGOOJ5aGc8EFxnmw6g=;
        b=YQImqnCz9PkcRBS+K3oI432sKJg+GLfl5zoZ+mLu1UxB2NNflDZjb9gyIEQiM0QwP5
         Jo1KELUfZeNlEZUZ9kXxiIFOJj+KU3bv0JxfCpPQZkTGWarR0F/UgJIBT2Efj0rUzMXg
         RcwsHl59Mr+MgyWFaWYzfla2ZdHfm2EwR0HLFeGsd3J1FqoTie4+omLh2IbA5VQ3zTbG
         PEe374wGqIZxIwEaMd9ZNYPWdKjvrf9tW0rJOSn30AFqT1fkKqyWXKzs8vjTvo/AxxB0
         tW2qIonyLfH43uv2ZIqGsOGBUWVvrO01CdnospOczn1KONpan1Cn5LopJZ4g0HsRmOy5
         S+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728580318; x=1729185118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWNpFyttizV4KmPkZEHOHP1DUhGOOJ5aGc8EFxnmw6g=;
        b=OJuGzsDuDfAaKpGeSv6T/rkZTnCdeeIhgfpI998t7zkt1mFbbqtdHWyyTGEWFwwwai
         MuyzY47Jx9dMnNCXHdZmRsHfSG8+ey8VjVYQ+mqEgtQSr8AE/c0CLxpyxX+Tz+7g20wo
         Wc4rVUkCi86I0qC+lQ6cBcLVw7YMXlSMKmuXHgdcjEHO8+hm0jPta3Y5Z+WEwYs0mr6W
         xue1QeU3VeJzN3CViOrN3pJPrD3LFg2ublP34JdLzDNKqN7LB/1bpVQW1GBxJ4j3xMDs
         jGJb5EQFIicw63Vw/vNjHtax6YCZOv9FJESBwl4i5DsihA2LvUdr/aD4w2R+rFMrYIZg
         oV+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1d1wpnHqlEw/L8mN+gLOjg3hobNFjuSeT54z+pW2Ps9qsbqFKaARKnhDaeBmc/kSBaIARj+EaUwI3Qvfy@vger.kernel.org, AJvYcCV7MR8mtBwM01wZ/b3UkgJVrBo4LI2mqXN8KjwXYJ9eameBdKYcpDPxtxqyxBb8Tk6cvTGXHYoeHcrV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+fVKaE7NXRk10vtbW/s6+2UOYpbhKTRudg3hXV2aSWw0mTt40
	RR+RNY7UlP/+6pLiRDOEqp1j1qEwwGjhiXTLENqQ7vNM5o4/MQq4
X-Google-Smtp-Source: AGHT+IF8/tO/ZwooAvWXV18apVDxs5Q5LHIxa5XRsn0nnhK6uLRlS1lqRXA1h7+5ixNhdE7BmxZ9Zw==
X-Received: by 2002:a05:6a21:9688:b0:1d8:a6bb:2782 with SMTP id adf61e73a8af0-1d8ad86106fmr6810637637.45.1728580317886;
        Thu, 10 Oct 2024 10:11:57 -0700 (PDT)
Received: from hiago-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2ab0b5d3sm1251245b3a.198.2024.10.10.10.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:11:57 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH v2 0/3] ARM: dts: imx[6qdl|7]-[apalis|colibri]: Update audio card names
Date: Thu, 10 Oct 2024 14:11:25 -0300
Message-Id: <20241010171128.107819-1-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

This patch series update the audio card names for Apalis and Colibri
iMX6/7 to match their specific SoM names, making it shorter (less than
15 characters, as shown in [1]) to fix warnings related to ALSA in
Apalis iMX6 and Colibri iMX6. For Colibri iMX7, also do the change to
make it compliant with the other card names.

[1] Documentation/sound/alsa-configuration.rst

v1:
  - https://lore.kernel.org/lkml/20240909114902.82380-1-hiagofranco@gmail.com/

v2:
  - Update commit message to make clearer these are breaking changes.

Hiago De Franco (3):
  ARM: dts: imx6qdl-apalis: Update audio card name
  ARM: dts: imx6qdl-colibri: Update audio card name
  ARM: dts: imx7-colibri: Update audio card name

 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi  | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi | 2 +-
 arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.39.5


