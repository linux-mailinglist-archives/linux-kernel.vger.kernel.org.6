Return-Path: <linux-kernel+bounces-442094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4F09ED7F3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179EE169420
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7512E23693D;
	Wed, 11 Dec 2024 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LN0YFaNW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3402236926
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 20:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950653; cv=none; b=UcrPJBcMsm31yGgULnItwEJt5dA7RuPnQ5IyoLnVICBHDIIYsUxXO8IAj+TXQNAvqbHRcDqmKGjvoLr0lfR50/q82VX7DaYwdokSg1lTlOP/uo67nF9TIYXL0SqC319QxS5MJlAFBmz/nwP/XXJl0TLWom0hXQBnpyZoMm8j0XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950653; c=relaxed/simple;
	bh=Y/MDmPX+r3gFiGkupbpCHeLUQbC0UW+h6X8OOkloMKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZJa/75YLb2HBAxpFUi2zLB5LRC0lG7yNVK78UQ9u1U6oYGCqkZzvzXJ3RkZgm9pXSkN6B/l1WHV0aqVsS4pf8BeD9y016of6f3snKrhiezApZ3vofKvNw4KRQkT8gJ8Rc4O04Q4ObvdZBjpArbp1YvzbehLpsmy2vBvLhBcgQbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LN0YFaNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76787C4CED2;
	Wed, 11 Dec 2024 20:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733950653;
	bh=Y/MDmPX+r3gFiGkupbpCHeLUQbC0UW+h6X8OOkloMKE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LN0YFaNW0XkbhQWrUu4KyYxoUxFeOOL/7gN/959Y/oZ4XosqkwUk6Ful1RaogQoXe
	 d0UADj0jmauunJXNMJtYTA68o52KnvAKrFoADSFc4baqVNTbsf8QO4NAxRyZVT1MBW
	 gcPjNKqg1R8UdZdA6xp84He5i51rheLtXsXe0hDoO04B9JmcTOZEIm6HwFZqV8wV5y
	 NeRys0hIIBzMlo7yDVjGVyTSP2NdJ4xiJWOwgW/ndGBeMUJzFl7L7oGy8tvlHorfK+
	 mhg1r5u5NYb/QVKhXBxLxRKYlVOLXE8D6Nzz3Ae5U7SOArctOsFvRDY8Qa/h6K87Cy
	 HJ8KM84ngZejg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Wed, 11 Dec 2024 14:57:14 -0600
Subject: [PATCH 3/3] mfd: syscon: Allow syscon nodes without a "syscon"
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-syscon-fixes-v1-3-b5ac8c219e96@kernel.org>
References: <20241211-syscon-fixes-v1-0-b5ac8c219e96@kernel.org>
In-Reply-To: <20241211-syscon-fixes-v1-0-b5ac8c219e96@kernel.org>
To: Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Pankaj Dubey <pankaj.dubey@samsung.com>, Heiko Stuebner <heiko@sntech.de>, 
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, 
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
 drivers/mfd/syscon.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index bfb1f69fcff1..e6df2825c14d 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -171,8 +171,10 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
 			break;
 		}
 
-	if (!syscon)
+	if (!syscon && of_device_is_compatible(np, "syscon"))
 		syscon = of_syscon_register(np, check_res);
+	else
+		syscon = ERR_PTR(-EINVAL);
 
 	mutex_unlock(&syscon_list_lock);
 
@@ -238,9 +240,6 @@ EXPORT_SYMBOL_GPL(device_node_to_regmap);
 
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


