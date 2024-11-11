Return-Path: <linux-kernel+bounces-404371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F63A9C42F4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46082842A3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B0E1A2643;
	Mon, 11 Nov 2024 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMA3htcY"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2BD14AD3F;
	Mon, 11 Nov 2024 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731343844; cv=none; b=GosBu1PewpZnqjX54AyQBcrsV5LkjNFIoyOUozL8YuRKlwDt+aw8emvP8TAZCsZPWmGYRY9HyijFrLsIzbW4b1UmBnXrKH9nX3dCa+QAPgfai0BCSat001jwQZnhlPYwBQcj/1KtPdjLugqHCl4aAEAzF8C8hguXcWqIQrk7MCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731343844; c=relaxed/simple;
	bh=sElvzsHvrd+4hzyW0PrhVJdn9RdhnUYT/nACWV1KTB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y/rQYbl4/5vAWdn0h/8pOIzFgrhSll0PywFAf81IZslxvyrL7psPTprOkbVJgILyj3JCKUhwLhT9iTrEg/byYgGwkyydvvgrwZLFRF+5EXVYZxrbfff0lf6sW1ut4FKcofJMP+YdpMgmLGMxFbzLuW+H4GKBxsRiL+d/0fjRdAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMA3htcY; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e4eb91228so521984b3a.2;
        Mon, 11 Nov 2024 08:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731343842; x=1731948642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EdWdARSqH7VvgDN7UrZIngwwkVF/tqPP+awpBPVeunA=;
        b=gMA3htcYUDt0sBL6aQqQviAEBgpJ4MrOxjNcy7875sLw8peVJExwy44GcaXVmYjlcC
         h1ofeKRMuiaqgdythFwhRt75tGNenmtBYSbGCeWfGH39VaSv0X2PdWL/PeHkCJ11CltS
         HJR80O9526mmMY5gZVn6qrmMTk97Cf5v2GuwGkjSaihO9eJHiwtGBtm/y2Q+iRFzXNPV
         sR8wqYDtpZgy0o7B0i6/Eza/O6vJklH9mP8gA66fJS7wqgBabLjF+feVH8H7I96gwKQ7
         54+H1xuzwem2BV9vq3oKZncyfcdc+KFjOLOhcM0QT7H15Yv3bwacxG5JL40frRqPAxj9
         KNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731343842; x=1731948642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EdWdARSqH7VvgDN7UrZIngwwkVF/tqPP+awpBPVeunA=;
        b=cGB1Yr5UQ3vPu3TE4hNs+jUyzLsQxBWMPgb8em6xSLTGYB5INVYXNUHMXvmN44RAbo
         hDrNz1s376uWyT4cF6yYFgWRb/mjezWpqJYNs9KY74pLtZlDqJ7A12VTi+j8/bdTPhfW
         LJpaQdDHxVgwsU8+G4AB8D+xQJpP3hb2XAIbwVI0362vjxg4p85aA5fb1neL9Y8Jvue4
         5Ch7c4YApPbMMzlp+bPKACfCV3qEN5rGIUBRDYrvF5nqSoi7IcXtN+53UJccbfR9jkI4
         K/LGhGWnig5GID3EYfpaObMqUEFHjKk/rjFCD2cMYeUavKJI1aQhV+uvkdRhlhlv/UrM
         LpUg==
X-Forwarded-Encrypted: i=1; AJvYcCVXgY+DMVeRGvN15QDRMdrkkrroD0tdlb9kXSUhDpMpIgSY24OS9IU1tM1vV0Q5fACgeftFnYqJx5WGE1Mn@vger.kernel.org, AJvYcCXpcI3mK4r+H+lAF+H+ElnMM3Kcz+vJcW6q/6pJIc1hcjFUF9RF20VH/EE2A0lXdUsskftDPwtD/tBU@vger.kernel.org
X-Gm-Message-State: AOJu0YzfNBHZZj9YoeiZSJ/9BQ7a2Lxao4Fbk9o320d5f8MLQaT2EVdl
	e+JAunedAe9MYxLXPOm8k4v1WuchDckXe+KtjuoGIRWGODAnRO0B
X-Google-Smtp-Source: AGHT+IG+XccuE4KvYTSXke9l8OsGYWA/KjiYABk6ydRkJ/0nKNr6Qq+wuMabAt9nkiEhGa67coCiQg==
X-Received: by 2002:a05:6a00:18a1:b0:71e:7bcc:a0de with SMTP id d2e1a72fcca58-7241335ac30mr7232729b3a.3.1731343841891;
        Mon, 11 Nov 2024 08:50:41 -0800 (PST)
Received: from rock-5b.. ([221.220.134.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a19dd8sm9401955b3a.157.2024.11.11.08.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 08:50:41 -0800 (PST)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Enable HDMI0 on ArmSoM boards
Date: Tue, 12 Nov 2024 00:50:02 +0800
Message-ID: <20241111165026.60805-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since HDMI QP controller driver of rk3588 is merged, we can enable HDMI0
on ArmSoM boards.


Jianfeng Liu (2):
  arm64: dts: rockchip: Enable HDMI0 on armsom-sige7
  arm64: dts: rockchip: Enable HDMI0 on armsom-w3

 .../boot/dts/rockchip/rk3588-armsom-sige7.dts | 47 +++++++++++++++++++
 .../boot/dts/rockchip/rk3588-armsom-w3.dts    | 47 +++++++++++++++++++
 2 files changed, 94 insertions(+)

-- 
2.43.0


