Return-Path: <linux-kernel+bounces-449759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D669F55BE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17171883B15
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5011F8AE7;
	Tue, 17 Dec 2024 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeGJV7Tz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2920D1F8AD9
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459122; cv=none; b=EPiniv2aZweT8rD0Tq44sWGOqThPR/0aTSgWyODmwaDDpXdOlj1I41F2/OolhxA1NgW4hLiSq7yqM0WLsONgAlKGYdUUASTIsp0m7U8X/DFOGEkbb34M04GkjBeNkFxuIkYl6K7oTaczEG5q50/uLeofu/77/TKi65Ay6OBEjAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459122; c=relaxed/simple;
	bh=d9mGnZDHaJzDeXuKCaPy+9xk0XBg5gLpu9ArK0AHMKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rZBIKihVfYERF6LPFVkzLbjZiX1oYRgpomejZ2Bt1C89ILwKBEkMzmiNd1gekPHh9JExIE85BPwEdb8klXcqog17UaMun1RKN9dtIuRHOmEg/zM3Q4IRHXNdCDS1Xo5QMLMRR9oK+XqUwf+u6cRYCIBSNKvz1UIJytLIq+0NRhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeGJV7Tz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357FFC4CEDD;
	Tue, 17 Dec 2024 18:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734459121;
	bh=d9mGnZDHaJzDeXuKCaPy+9xk0XBg5gLpu9ArK0AHMKM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oeGJV7TzMO2K/f4KYDTiE7oK8pvu0X6kilCxjF5oFugyKqzLn+6n34touk83bBI+F
	 skpEqsPKCkHdiNdFIBGSRhJndcH41NadHgdnnn5LSoCdZbpBoE8+VzsUH/3UA4VE5D
	 /zyFHELz5BOhGK0S0aS5NwjPHbFEMTOE8v7gKxCgg7Kl2Hf/nrFywk2LbP40jJ1e1P
	 G7yGDFVr1i9vvN69t0G1BcnUbV/qjvlPQi6C9CHQfZvaivfRTBfRJL/VMASFIM4xpa
	 syn1KdPb9tFSzE25V9vueRU9bBIJ6fFv6Zu4RAF5vbZl7O/L6ErrPliOQVDL8iAjp2
	 /BpPqY4vXonMg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 17 Dec 2024 12:11:42 -0600
Subject: [PATCH v2 3/3] mfd: syscon: Allow syscon nodes without a "syscon"
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-syscon-fixes-v2-3-4f56d750541d@kernel.org>
References: <20241217-syscon-fixes-v2-0-4f56d750541d@kernel.org>
In-Reply-To: <20241217-syscon-fixes-v2-0-4f56d750541d@kernel.org>
To: Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Pankaj Dubey <pankaj.dubey@samsung.com>, Heiko Stuebner <heiko@sntech.de>, 
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, 
 John Madieu <john.madieu.xa@bp.renesas.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15-dev

of_syscon_register_regmap() was added for nodes which need a custom
regmap setup. It's not really correct for those nodes to claim they are
compatible with "syscon" as the default handling likely doesn't work in
those cases. If device_node_get_regmap() happens to be called first,
then of_syscon_register() will be called and an incorrect regmap will be
created (barring some other error). That may lead to unknown results in
the worst case. In the best case, of_syscon_register_regmap() will fail
with -EEXIST. This problem remains unless these cases drop "syscon" (an
ABI issue) or we exclude them using their specific compatible. ATM,
there is only one user: "google,gs101-pmu"

There are also cases of adding "syscon" compatible to existing nodes
after the fact in order to register the syscon. That presents a
potential DT ABI problem. Instead, if there's a kernel change needing a
syscon for a node, then it should be possible to allow the kernel to
register a syscon without a DT change. That's only possible by using
of_syscon_register_regmap() currently, but in the future we may want to
support a match list for cases which don't need a custom regmap.

With this change, the lookup functions will succeed for any node
registered by of_syscon_register_regmap() regardless of whether the node
compatible contains "syscon".

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - Fix logic when a syscon is found in list to not return an error
---
 drivers/mfd/syscon.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index bfb1f69fcff1d3cd35cf04ccd4c449e7d0395c79..226915ca3c93dcaf47bdd46b58e00e10e155f952 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -171,9 +171,12 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
 			break;
 		}
 
-	if (!syscon)
-		syscon = of_syscon_register(np, check_res);
-
+	if (!syscon) {
+		if (of_device_is_compatible(np, "syscon"))
+			syscon = of_syscon_register(np, check_res);
+		else
+			syscon = ERR_PTR(-EINVAL);
+	}
 	mutex_unlock(&syscon_list_lock);
 
 	if (IS_ERR(syscon))
@@ -238,9 +241,6 @@ EXPORT_SYMBOL_GPL(device_node_to_regmap);
 
 struct regmap *syscon_node_to_regmap(struct device_node *np)
 {
-	if (!of_device_is_compatible(np, "syscon"))
-		return ERR_PTR(-EINVAL);
-
 	return device_node_get_regmap(np, true);
 }
 EXPORT_SYMBOL_GPL(syscon_node_to_regmap);

-- 
2.45.2


