Return-Path: <linux-kernel+bounces-438689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC189EA466
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF36163992
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945A919E993;
	Tue, 10 Dec 2024 01:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7VE8rPe"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6E219DF7D;
	Tue, 10 Dec 2024 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733794235; cv=none; b=Ql+ivXCHUIeoLQPfFXVDgEo365PKjBSJke8Gy9Lm3NBkrgIvUgvNxnn5L95o3y9D1bkTV9d6BIBrQ8B3qGlQnb3BKw3QHXaGC5XMVLA316tlV2ZQjPhwDaH4cvqARCwfeZ5HmOteSU10yYdUrWHvnCinU0z7gcnAPe8yPCyDiaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733794235; c=relaxed/simple;
	bh=ASCKekPDWvwthwVMcENIEemFajBQNC4WJRFy+efGCHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J+xfiOchXgXyJjjCKcbJ/MfKKXJf/186QqivOeoUnwIkRr5RmAQekZ39TorrlVq01EhzWh1t45OvLO1bW5uNg4WAku/LcL9z0R3bMfE/EpK/UFP5MPUXRM+SYnsftgsJWAJitwDWXP3dBf31A6KgbGB3qbfYSK342OjL6vDKwXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7VE8rPe; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6d87ab49423so49439506d6.0;
        Mon, 09 Dec 2024 17:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733794233; x=1734399033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nes5VB2VcAfNvacXIUYzGUAIsX7gVlGNiJVgrHet/68=;
        b=f7VE8rPeEW9YNscAhASNR3btviHkoCx2s7ieWqfJ3JslsEezeFPTyZa+J0pXvj337E
         yecibvXXxBE6gQHMvtOGnXkI1KxBYvL3LbmPCdLEUlYjBkj/5abbQ83ckfqlCByVyEVB
         xNiSKDtepToGbz4tJYmTH3JxBv44nzKqw//WLVADEBf8YOVpDZhdg/nulTuusZMJomva
         mdNCXDqhs0NFH/A3TP8dmfQmzHmYruYM7Ne3bc8aEZWbkSoBwQ2mn/XO+brrZM6sFcgc
         zE78wirZMaoB8ZliaqtbwxIcmVIOhiWN8lqwvduNwemstvfPGq25wMyJzgg3M4cVIRRM
         SbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733794233; x=1734399033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nes5VB2VcAfNvacXIUYzGUAIsX7gVlGNiJVgrHet/68=;
        b=VCzoUDh3XMPRQi2XEeXXL07Zou9mmOU+8hWT0eIy3kIaL/DJB2NqUxUWhekWqZkybe
         67FX40kRVK17NRxyPmyoveVwQiRA5NncUGAwSJnMFDnBxF2TYI2dbOycMaa71KR/alTF
         LA9pIe5h3KIgbIvYBl8UrCVw6SKbUJyWxJVnb9115S0bFop+xwS7bH+/cPuOnHfZl8sw
         4VTIyj7WylLF0pgw7t1i5Br+5bv5kRvb8SGeyPCYHXh4TCLMTdW4qXnvVflLtEP2czYL
         1v7/whpPXnEd9iCtTj2Gfh+4y7Cg+plahILGpXRvyt+3AMQbMB7R+/bATCYohyBzzk3D
         rwjA==
X-Forwarded-Encrypted: i=1; AJvYcCVwUrBezJdRdEsDoBYFPNw9Yj/BBYXafgFjs9z2kcmkTpUKsbGnsl2982DP9GIdaCyciM87/B/MfvYI@vger.kernel.org, AJvYcCXArYkLQUcr21Efq6zFockhvFCgtUj/28mgrxrXE+7dQysBMmEBBU/3be/KUwv+4j53eaoqOkl2HdIvuGHv@vger.kernel.org
X-Gm-Message-State: AOJu0YySsdWDjTnNJ1Ii7OoR/BWZnLTSLPjstAgud9DQnD+zh8BsE3rZ
	qVBf8MYX6odAOvJYL5Ea6JT6T26ArYMK90OT0+TUCKpOmP1TNCEa
X-Gm-Gg: ASbGncvMr6k0Fv7iG7yQkKh4APmSo7fdQfwX5gVTGwZQY4KOp3uYsqUZ7QGmxmYTnjW
	5nksVnyToGtuumFXOD3b2a9e8i70pp4dA+gz/rA2muFjEDRcKDqpzJjx6h0ZjnU3XB6kimdHLlp
	BlIWFMUwp2Rd5HZeenwzjnmHEBYb/f9l8fBfZma+AqAVE3iJJ9DiKL13x87tj+SwNum9+hjVRtc
	oiQ4FAoXTySP3ocBIEnvBtpCsrJl+nLnKHSOJLHWdX9R+pGoE+jdsga4cFar68Hzg==
X-Google-Smtp-Source: AGHT+IGDRUk9+gv8pP1CJieucgxw/FIyVkf5JoAn+WsrS/JAfYgwU4trbE3sWTyJ4SkA4cp4lgjq+A==
X-Received: by 2002:a05:6214:d06:b0:6d8:850a:4d6a with SMTP id 6a1803df08f44-6d91e2d2bf2mr47046016d6.1.1733794232931;
        Mon, 09 Dec 2024 17:30:32 -0800 (PST)
Received: from master-x64.sparksnet ([204.111.53.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8f429a79csm36834346d6.72.2024.12.09.17.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 17:30:31 -0800 (PST)
From: Peter Geis <pgwipeout@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Peter Geis <pgwipeout@gmail.com>,
	Alex Bee <knaerzche@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Diederik de Haas <didi.debian@cknow.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liang Chen <cl@rock-chips.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	shironeko <shironeko@tesaguri.club>
Subject: [PATCH 4/6] arm64: dts: rockchip: add hevc power domain clock to rk3328
Date: Tue, 10 Dec 2024 01:30:08 +0000
Message-Id: <20241210013010.81257-5-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210013010.81257-1-pgwipeout@gmail.com>
References: <20241210013010.81257-1-pgwipeout@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a race condition at startup between disabling power domains not
used and disabling clocks not used on the rk3328. When the clocks are
disabled first, the hevc power domain fails to shut off leading to a
splat of failures. Add the hevc core clock to the rk3328 power domain
node to prevent this condition.

rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks: { 3-.... }
1087 jiffies s: 89 root: 0x8/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 0 to CPUs 3:
NMI backtrace for cpu 3
CPU: 3 UID: 0 PID: 86 Comm: kworker/3:3 Not tainted 6.12.0-rc5+ #53
Hardware name: Firefly ROC-RK3328-CC (DT)
Workqueue: pm genpd_power_off_work_fn
pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : regmap_unlock_spinlock+0x18/0x30
lr : regmap_read+0x60/0x88
sp : ffff800081123c00
x29: ffff800081123c00 x28: ffff2fa4c62cad80 x27: 0000000000000000
x26: ffffd74e6e660eb8 x25: ffff2fa4c62cae00 x24: 0000000000000040
x23: ffffd74e6d2f3ab8 x22: 0000000000000001 x21: ffff800081123c74
x20: 0000000000000000 x19: ffff2fa4c0412000 x18: 0000000000000000
x17: 77202c31203d2065 x16: 6c6469203a72656c x15: 6c6f72746e6f632d
x14: 7265776f703a6e6f x13: 2063766568206e69 x12: 616d6f64202c3431
x11: 347830206f742030 x10: 3430303034783020 x9 : ffffd74e6c7369e0
x8 : 3030316666206e69 x7 : 205d383738353733 x6 : 332e31202020205b
x5 : ffffd74e6c73fc88 x4 : ffffd74e6c73fcd4 x3 : ffffd74e6c740b40
x2 : ffff800080015484 x1 : 0000000000000000 x0 : ffff2fa4c0412000
Call trace:
regmap_unlock_spinlock+0x18/0x30
rockchip_pmu_set_idle_request+0xac/0x2c0
rockchip_pd_power+0x144/0x5f8
rockchip_pd_power_off+0x1c/0x30
_genpd_power_off+0x9c/0x180
genpd_power_off.part.0.isra.0+0x130/0x2a8
genpd_power_off_work_fn+0x6c/0x98
process_one_work+0x170/0x3f0
worker_thread+0x290/0x4a8
kthread+0xec/0xf8
ret_from_fork+0x10/0x20
rockchip-pm-domain ff100000.syscon:power-controller: failed to get ack on
domain 'hevc', val=0x88220

Fixes: 52e02d377a72 ("arm64: dts: rockchip: add core dtsi file for RK3328 SoCs")
Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---

 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 0597de415fe0..7d992c3c01ce 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -333,6 +333,7 @@ power: power-controller {
 
 			power-domain@RK3328_PD_HEVC {
 				reg = <RK3328_PD_HEVC>;
+				clocks = <&cru SCLK_VENC_CORE>;
 				#power-domain-cells = <0>;
 			};
 			power-domain@RK3328_PD_VIDEO {
-- 
2.39.5


