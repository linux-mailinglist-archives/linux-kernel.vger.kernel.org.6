Return-Path: <linux-kernel+bounces-446222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ABA9F214E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 23:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03889165EEC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 22:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88711B4F1E;
	Sat, 14 Dec 2024 22:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlclXlT8"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880DB1AF0DA;
	Sat, 14 Dec 2024 22:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734216226; cv=none; b=MzYAxxtw3iS6ZvI6YQvgjxbHyY5hTl+WmU6n4TZ+04kPqXu0EOchHbzuekriRwvNQ4VlEmx+1EvYMhlaCWAleizUJJLffi2XfbwPvHOS+6O5YJHf3BRDyfRBN1u4ghTn/ZSety1sLGkZo7fOF26+I1rKZ1zjnTAA6tWJVtX8VUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734216226; c=relaxed/simple;
	bh=63py2pnMtgKUYe+UT2S5ELZyC52/xbXvveIXSsBqbuA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eZUr5DTsX6/AR76/UImSn0QmstTnQAR1GTQ6KYF5HTUA4ofhPUP2rzimN5zxBndtOWPyLA/GNptE+wIY29zo1O/GuvudkJnC6ZpVUQ3DNZ3BO58MBSAlhGL24DASBw68kvfVXctLNUO04QIdWWUdiSIRJpBe2N1kFY71L8+AMIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlclXlT8; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-467a37a2a53so24104641cf.2;
        Sat, 14 Dec 2024 14:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734216223; x=1734821023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PNDbc7G8jzn3foVKj5RIrzXm3mfQTgjskEhNJ1rJRDg=;
        b=VlclXlT8kKFVRX6yyT2j77mzg3HU+/CKH5OfNZUkuYcqMPcjGa+yy6HDl5f+wN2wTa
         9KfLnpHWoNRR/esF+/gJ21imJsqXwtaA3zsnQPXFDTqnRF7dP33kJ39c6vt/qzwsOrfp
         KZz7YNpPqzTWFUBGiok5HR+U10DGowKOFNc2k1PikSynwxYy6/7vW4P4SI6p4wZPXKDx
         tlW6st9OuOS6cNeAkLwosPy7OzuO5XDqp3TINqmdGZ5igBLKAD6zqP4/CkpUCEm/DfBn
         aijfLC/wUYuJkF+DGVeWN44F4hsrfaBP9E+Hgd3/uW7rrttOzXZSeBzfc/fqWD38q44J
         CPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734216223; x=1734821023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PNDbc7G8jzn3foVKj5RIrzXm3mfQTgjskEhNJ1rJRDg=;
        b=Jjf4SrSsgdoYAx8tuoRRDJbcWGYTF6nFJf0EXpSCDSSxJdHGvAIFDcbUJWdJq5M40d
         ph2qVLoLCi1CeT70TtOzGqFfeW+LGUhnCqZI8jPDKO4gmNulPrhtHtw5Bp8XKpCLSyvA
         w58Ad/LXGFiF2IlU4F08r52J4DxMMnVu+UDf0WpmRThXhJV1s18TFjbjlmOHcScjKygb
         Sj9iMNjTjcywfp1GusG2swxVXnCRiku0FigK0fku+Xi+cUTF+2v99oWRTr+lGD6cTw8X
         NDGshEoiSE3HH0A2uoQEwpPKW1LNEToh48lFBW1fIvpWzO+PhIJNYZkN/0oO9YgaM5fe
         nXew==
X-Forwarded-Encrypted: i=1; AJvYcCW+dBX3kqXiH/Ku4H+Ygmjkg5Aac1VnIdBJQcUSecC3VIcYHhTPQh1IB0i9llQo/r9ljanSCy46fl4K@vger.kernel.org, AJvYcCWmGfTA4WRcWUnGN5+C4UXPbAjn6TagT9KTZHn3DrwtBRufVBKlbbiAMzSMTAx9LRW+z7sivgepPs+hM7mU@vger.kernel.org
X-Gm-Message-State: AOJu0YwYNfYq+GLauRjWEZWRKDesiuVcV6DUsGYzFsnkLWefq9MGSULF
	9fO8XbrpA7vx3eNGPj88g6IFuw8r778c3K0nQPqaINnPfMCNg+4v
X-Gm-Gg: ASbGncu/c93UWRG0f/5SiV2etmdRglIgIbJpDAguNUamiYCPG/rn+yqa41oC9T85CIq
	crAjL4wUixAhp8pQrLdZbK0hZBf4EkZc9p1UIZLUR/3eRuh2ij34vLqvdq3/YUprrLS+YJ7AUpJ
	8s1L57OoTqz2xNre+fYhm2AWLb4sXA/2ff10y9ZeHa4YPKme4vQb3JJ00yBzGAW3CH3qE24eOrJ
	5miV3h04XB8bWCFBF+AXrTTxh8BMJflPLv8M6mmsxr+CsT0gs046X2mdhAvGFyYRQ21
X-Google-Smtp-Source: AGHT+IG7IXU/c0iNtY9MhcZRQQ569PFHhr3zCgYEkNpnGAd30NXOtGTn5aSphWyBODh5sqgfqfsOvg==
X-Received: by 2002:a05:622a:144e:b0:467:51d7:e15 with SMTP id d75a77b69052e-467a5718d1fmr139468471cf.7.1734216223365;
        Sat, 14 Dec 2024 14:43:43 -0800 (PST)
Received: from master-x64.sparksnet ([204.111.53.241])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e8097asm11434201cf.63.2024.12.14.14.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 14:43:42 -0800 (PST)
From: Peter Geis <pgwipeout@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Peter Geis <pgwipeout@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Alex Bee <knaerzche@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Diederik de Haas <didi.debian@cknow.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liang Chen <cl@rock-chips.com>,
	Rob Herring <robh@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH] arm64: dts: rockchip: add hevc power domain clock to rk3328
Date: Sat, 14 Dec 2024 22:43:39 +0000
Message-Id: <20241214224339.24674-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.39.5
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
rockchip-pm-domain ff100000.syscon:power-controller: failed to get ack on domain 'hevc', val=0x88220

Fixes: 52e02d377a72 ("arm64: dts: rockchip: add core dtsi file for RK3328 SoCs")
Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>

---
I am pulling this patch out and submitting it standalone. Otherwise
there are no changes from the first submission.

This was found via educated guessing and extensive testing. This clock
is sufficient to permit the power domain to function, but additional
clock work will be needed if the hevc block is ever enabled on rk3328.

For anyone wishing to attempt enabling the hevc or h265 blocks:
Currently the assigned clocks in downstream are not sufficent and the
board hard locks if accessed unless clk_ignore_unused is applied.
Notes from the rk3328 and rk3228h TRMs show the HEVC and H265 blocks
share common clocks and domains, along with a shared sram block that
also needs to be enabled.

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


