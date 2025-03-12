Return-Path: <linux-kernel+bounces-558069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF56BA5E14B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7688E3BC1F0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA732561CA;
	Wed, 12 Mar 2025 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8bN7JUO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D81198E76
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795105; cv=none; b=cc2crNNcLSDCfAk13pMPTvV7/AklYfi0FpTN4I68xWKoLnatvBXA+xtDwAI+XCW//AUJ/9lwlOuwXv/SvVtZS3N8egFQH39Uuk+5xElGBSFH/inbJvucj3Z5eG1WhfnzE1yjgnc1sdrj2MU83orkjn7QWyzxA0xumI2iA4Vr5ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795105; c=relaxed/simple;
	bh=ZuLRC2c2lu1XseA0j5TSbjY+tOYPxAbjeD4uttbJjII=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c8NrUbozK6UZvdv7+DBkVUYkurwtuXjdtZyd3M2di/jv/3iyjlKnXyAtTmTGcLFVLTWwUFxYo4/iaKdx4u44pJYHfa0oK/ZzTINEerIlXKRAUvkG+Mzt9Y41Wh4k27+amvBRxNoIetiXgajQ4MnUw0kcZvo93V0ncFK0Sbfrwms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8bN7JUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F819C4CEDD;
	Wed, 12 Mar 2025 15:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741795103;
	bh=ZuLRC2c2lu1XseA0j5TSbjY+tOYPxAbjeD4uttbJjII=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=L8bN7JUOiBW46qpqFUeuhB8egu4tV+PgzPEjTvF9KFXsbCx+ss32YHPlVmXXes9M7
	 zpMdO9oekpkZRLLSxjUVgrRPLkG7b31KSf1ME8AKedbkOQZkZC6+gAIGbF6Labr8GN
	 gmdRvERzqWWci+ww/FJZ5GQ8LfuP0edRW7Paah4IEes7He5YMu4lIhVzbay3dBkP2S
	 eXCK5e/SNZo2UixrOnKBj8ZyXuxAjMQmtCoRwBLxOy+LlBnsIEh8mPT4injbuootcK
	 mOqHcMGerb2/71xTauXAnpZv4G1+LKFnCrp6TJxCNepGYRj6a4QTwMr+PBtMSl1szz
	 6EYraxT9rK9Qw==
From: Vinod Koul <vkoul@kernel.org>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, kishon@kernel.org, sebastian.reichel@collabora.com, 
 yubing.zhang@rock-chips.com, dmitry.baryshkov@linaro.org, lumag@kernel.org, 
 frank.wang@rock-chips.com, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <20250312080041.524546-1-andyshrk@163.com>
References: <20250312080041.524546-1-andyshrk@163.com>
Subject: Re: [PATCH v2] phy: rockchip: usbdp: Only verify link
 rates/lanes/voltage when the corresponding set flags are set
Message-Id: <174179510031.536552.7442060711637646022.b4-ty@kernel.org>
Date: Wed, 12 Mar 2025 16:58:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 12 Mar 2025 16:00:07 +0800, Andy Yan wrote:
> According documentation of phy_configure_opts_dp, at the configure
> stage, link rates should only be verify/configure when set_rate
> flag is set, the same applies to lanes and voltage.
> 
> So do it as the documentation says.
> Because voltage setting depends on the lanes, link rates set
> previously, so record the link rates and lanes at it's verify stage.
> 
> [...]

Applied, thanks!

[1/1] phy: rockchip: usbdp: Only verify link rates/lanes/voltage when the corresponding set flags are set
      commit: 969a38be437b68dc9e12e3c3f08911c9f9c8be73

Best regards,
-- 
~Vinod



