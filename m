Return-Path: <linux-kernel+bounces-368738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6219A144B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E496C1C21413
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DFF218D9B;
	Wed, 16 Oct 2024 20:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSFjSa/2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49421216A0F;
	Wed, 16 Oct 2024 20:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729111364; cv=none; b=QRKjlbbrc49wBR/PGVZIeUArZDizv8A5GC8vC3qoD+/vgjiD5PTGSxarPA1YiP5vpfwqlXkahWQ8VG5WeDO26U2dSTVqIbQkp+xuwKLvcG27AWk2hK/aqjPRUCTwy7e39AnzdxY493TNs5MdFYUui+p6JZHiLgUgV6bXFTOjo6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729111364; c=relaxed/simple;
	bh=pgWZoF5eeKu+3/pcgpuD0KBnYOPOn7dfryN6ilFh+Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atoyTLsxKFQTnmRhKD+iVs3GH3E/46cHDm5abzcr+eSg47TMRYF7RIxnWNMS9QpAFWnV3xbf295GXlhf6XUskFkV9xrkLmoqOsv3LomALr3hWijfOOgyN0O+V4DZwaNmZ9eY4o+anyCVDF0gSmbORMwjejwgsDq7DI1UQEg1xxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSFjSa/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6DDC4CED0;
	Wed, 16 Oct 2024 20:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729111364;
	bh=pgWZoF5eeKu+3/pcgpuD0KBnYOPOn7dfryN6ilFh+Yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fSFjSa/202Yo/ylHo23gAYBNGc4ZBCKolpl7g8ohdowdI7IGe6AV8JGoaTTaT8kVK
	 CTa5dtydvsGuOboQanwM40a55vxOP5Jm/ECwgLptTAw9t1IQTCfBT2afoqNvNThqg3
	 uKFniicsK1/FDGRZIChQ0pSFEMvOj8+Ap9CqgJnMxDPdIzNnDkyrI26wa8qAbG1Z3I
	 UAjqiqomy+RxsxQUXrJMtQUZh9zRPpNL/qvjGttAiYGUQxvE94FH7Y4oEUt0i+lqUP
	 nMmuGMHBc4iPS1b+BBD/Ne/KMnDINv50iAoUZl2W7lxIpk+h6H3XPlLaVByiHBNCFG
	 YzT+T6mzX76lQ==
From: Bjorn Andersson <andersson@kernel.org>
To: linux-arm-msm@vger.kernel.org,
	Jonathan Marek <jonathan@marek.ca>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jagadeesh Kona <quic_jkona@quicinc.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: videocc-sm8550: depend on either gcc-sm8550 or gcc-sm8650
Date: Wed, 16 Oct 2024 15:42:30 -0500
Message-ID: <172911112241.3304.13495301010907431462.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241005144047.2226-1-jonathan@marek.ca>
References: <20241005144047.2226-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 05 Oct 2024 10:40:46 -0400, Jonathan Marek wrote:
> This driver is compatible with both sm8550 and sm8650, fix the Kconfig
> entry to reflect that.
> 
> 

Applied, thanks!

[1/1] clk: qcom: videocc-sm8550: depend on either gcc-sm8550 or gcc-sm8650
      commit: aab8d53711346d5569261aec9702b7579eecf1ab

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

