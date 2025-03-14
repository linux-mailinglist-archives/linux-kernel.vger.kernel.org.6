Return-Path: <linux-kernel+bounces-562052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436F3A61B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECF2E7ADD47
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED93E2063EC;
	Fri, 14 Mar 2025 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jp22/KZJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D46C2063C2;
	Fri, 14 Mar 2025 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741982490; cv=none; b=XealilwZ9ulH/6F5XO0aIrxb5URDSYPjgF1/OJzEYafMk21uzSYtOt+7Tw30hP48GWrWL8AH9qC+qUldYINxNeUKrQpf2c226IiqVU59MWURZCu8ipsr97+X7GpPdNCeiKGNg9n6Mm7Hp3y5VhRdhE4d1uTsDLk319bk77rn/MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741982490; c=relaxed/simple;
	bh=56Y8WP4lJH2ArMkkBIQX60sbylVZzcXorl6dWgzw6T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqP0DwCsGe91iPvexrzGeLWYzELXw1RjPGRtLY/2+Ae+GWB8/Tul/tQ5fMxfwChVZ+DaL03SA3CD82Zx/epj73RUA9ttf7uZHRq+xKnXFfdKWeWAr33Vz7cu2QEc0/rFxfGBS93WwWhlTknAK9hn8o7Gq4XKJNGbjQkgy9qzMDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jp22/KZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAAFC4CEED;
	Fri, 14 Mar 2025 20:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741982489;
	bh=56Y8WP4lJH2ArMkkBIQX60sbylVZzcXorl6dWgzw6T0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jp22/KZJOO5vqMsS+q7+NQnpQ5VA/m1lYnArc9JZ8BpozZX+03q6MlGazdlejJj6u
	 h8hvZQh9kcV5+HS+0rppEBlwAamap3DwIU2l23c3nnnUbMrFpQPsaMi1wviLkrLPSs
	 tH51P7gf2Mw4AmuXYrwmNUwyCUW02owvcPSYjSErVmAndyq0QqeNQYPuwD2SPF+kRU
	 XU6dWBAREcisdvOTdNm7aoyWXWsZNZg3XW3vNy27hWG7J7kdbFuLmw0p8JLoQdaCh3
	 7aNMvMngnpTz5l4epWcZWG7e6FHgb1JGEat6d4kxKy/WknL1xyJnAZ/sCYuZ+SliBK
	 cWXu31G0uzJWA==
From: Bjorn Andersson <andersson@kernel.org>
To: Michael.Srba@seznam.cz,
	konradybcio@kernel.org,
	jeffrey.l.hugo@gmail.com,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/2] bus: qcom-ssc-block-bus: Fix some error handling paths
Date: Fri, 14 Mar 2025 15:00:46 -0500
Message-ID: <174198247884.1604753.16019573557353029968.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740932040.git.christophe.jaillet@wanadoo.fr>
References: <cover.1740932040.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 02 Mar 2025 17:21:33 +0100, Christophe JAILLET wrote:
> Patch 1 should be straight forward. It removes some ioumap() from
> resources allocated with devm_ioremap_resource().
> 
> Patch 2 is more speculative. It releases some resources in the error
> handling path of the probe, as done in the .remove() function.
> 
> 
> [...]

Applied, thanks!

[1/2] bus: qcom-ssc-block-bus: Remove some duplicated iounmap() calls
      commit: a9ac4ba7dcace2b3b91e7b87bf0ba97c47edd94f
[2/2] bus: qcom-ssc-block-bus: Fix the error handling path of qcom_ssc_block_bus_probe()
      commit: f41658cd081ad7697796b3dacd9a717a57919268

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

