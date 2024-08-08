Return-Path: <linux-kernel+bounces-279464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E35894BD98
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50496287E2A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FFB18C911;
	Thu,  8 Aug 2024 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiFwmG6W"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D48126AFF;
	Thu,  8 Aug 2024 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120530; cv=none; b=RyhNUXmMAa3Nzj/goRJHVJefSX3ySQJ9gav7eH/o4eN+0/1QP5og8IfoRz2ee06Y/CbBa+/3DCOpDJB0WhV1rO7Zrg6FDBVoW1tDfONC6UkqnUhL4pYneGsFOf94g1xnHSTBAu9eOAOrjfQZZiRzbNC1y2WxVTnLJQZiI9tihsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120530; c=relaxed/simple;
	bh=uKQOm2SBha/Im1yZQMaKmqXPXDOIeCDU1/a4R247f3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mxU++6GySlWRvdEnHzT7xFwJq+0xDdKUMQChs9n6qgWHKkn/UqjnEc/Ah34IKtrOolIdJdsizuOG47ydPCqd1jm7IQUD5UbzNB+24KGWydD8PVYtzqda1HtxMcEaVC29YpyRp57huDbt3JAhIoM7g4OAKtE/E5MjTmJ51lRsxJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiFwmG6W; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f01e9f53e3so14189391fa.1;
        Thu, 08 Aug 2024 05:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723120527; x=1723725327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nbjZvVaCZ0386E9l/US1czroDOauP6L7rtIUKqoC7PI=;
        b=QiFwmG6WGw95pn+SFu0sqCsSsJ60Ww1E5Fbv6Ug9CcBHgFh46/1YyAxXKwVqZJn4fy
         7Zh6z0wYQd3LCuqi8rqnvEpL3vZ/by1V+xqUAG0KmUTeZyFdcl0lZYmPa63ErNC5EyGr
         mxY3vVXKpfKaMkPd9cVTimdR563u8wwhbhBXgBWhYkCrCAuEy0Pxx2iXnl6HMfV01CQR
         2Vo2k26CgdQnu9Ay6w7ejkN3SMVP+0Vyk3WGmQAR6NjTMEgKzfXMneXZYx/VQxxNwKwm
         k/dnz5PwzOsAkTc/1as8I+K0eahh4SL6JF2R+KUO46oMn8mwAKCia6mmD2jY05/IjDM0
         yWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723120527; x=1723725327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nbjZvVaCZ0386E9l/US1czroDOauP6L7rtIUKqoC7PI=;
        b=X7Zp951ADeQTdqYoYN6aRrSqgQ8VPvISPscvXXVoSHowv4kPyBTrjG92HaJvxoTmyG
         OR1QU9ahTd2l+VXVSHZiuAH2k/dahjRwsj3u0x4yX1U2tJci6N6WtLkKWqGkA9z2tDsT
         41XZIGKczDPBjv2kPE5G5tXeAzpNuneJL1g5ol6qE+KztWAr4u22S9rEwr0uJpx8HQCd
         WjqPMMAEnIYw8D9djKegyXoERvoR+m+KQyaFoQuZKRYB0/eYnVFqOIDQySfTz7dFNgmQ
         ZpP411fncL6+cBTKTN+x+YYvQTQkl+aSVNqBRVRMVWF/ZZ+oYECA69tqH0gHEC/hJUSW
         3zzg==
X-Forwarded-Encrypted: i=1; AJvYcCV/4YieSzoEwmitFdJ6Ncd8z7ycxVIUV+reWl4avxE6FBRvBDHlwHhLBhUP9sWiyBt0d+KhUh0IHOL71unD5MUN8sY+G7P3pfNQm7o4
X-Gm-Message-State: AOJu0YzG4vmpwMAdncEyhLqdr0/kbah8nqs0KIeRv17e0kbyBWgDG9Ah
	NvQvwVgd3ZsxlNYzNK+UkQKCM/eSaK1VS/Qw+78My/xP03rPZfYCI7z08g==
X-Google-Smtp-Source: AGHT+IFWR771BHx21zDBqFhqt9dwZYU9slY+FeBuWcmPV7TkCmsXiwID11FP/YAZkPYNwIe+tvMpbA==
X-Received: by 2002:a2e:5152:0:b0:2f0:1f15:5a16 with SMTP id 38308e7fff4ca-2f19de2a52dmr12155621fa.13.1723120526732;
        Thu, 08 Aug 2024 05:35:26 -0700 (PDT)
Received: from yoga-710.tas.nnz-ipc.net ([178.218.200.115])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e17e835sm21072261fa.21.2024.08.08.05.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 05:35:26 -0700 (PDT)
From: Dmitry Yashin <dmt.yashin@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dmitry Yashin <dmt.yashin@gmail.com>
Subject: [PATCH 0/2] dts: rockchip: add USB-C support to OK3588-C
Date: Thu,  8 Aug 2024 17:33:52 +0500
Message-ID: <20240808123354.260797-1-dmt.yashin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for USB-C ports (labeled as TypeC0 and TypeC1)
found on Forlinx OK3588-C board. The changes are split into two 
commits for better readability.

Dmitry Yashin (2):
  arm64: dts: rockchip: add USB-C port 0 to OK3588-C
  arm64: dts: rockchip: add USB-C port 1 to OK3588-C

 .../boot/dts/rockchip/rk3588-ok3588-c.dts     | 217 ++++++++++++++++++
 1 file changed, 217 insertions(+)


base-commit: e8054c08dada20f1bfb4d41a7f3902ae053d4499
-- 
2.39.2


