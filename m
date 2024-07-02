Return-Path: <linux-kernel+bounces-237865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B974923F16
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE45A1C21E3B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580E11BA07A;
	Tue,  2 Jul 2024 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbcLIZiK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21281BA06E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927361; cv=none; b=FesRXnVt7JArk8e8k7eq0US2GvQCS4fRqH4JWyJYnYZnizmH3EELHJOL09kz1zNYs3RFnoxEpDDbMfJEXZvcnK6Hb102mUQt8oa3knJNYX/tV5SvCVMXcDxg9mwY8are8zk1esuaUy2CPbSyNGIBbMgWxJlR9UgxO+z2BpU4EwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927361; c=relaxed/simple;
	bh=IF+Kvrk7vBoksuSkESPNjQBIFMwOljqOLFQSXyYEjAM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LitnRSn9LCq9gfsGmkYGdnXl5qiL/CvP/mSvndCV0wY0q7A466BQXE+QgqhVYeF6SztTRVRIqjBAEttFzHxUrNg68aaTpOxt/UXjIPeoz8d64vlvpria3LN7/k6oJjHDkEr5u45NnjdnZe4QxnG48vzEM7Qqx1jtBBNjkC/XSCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbcLIZiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85B5C2BD10;
	Tue,  2 Jul 2024 13:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719927361;
	bh=IF+Kvrk7vBoksuSkESPNjQBIFMwOljqOLFQSXyYEjAM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZbcLIZiK8kcjZy+gUzDYRLul28q6XZ6AG1Zg9LdFargZohRmwXC6gkYXbWXQzg65B
	 uW59qtFbXehBPW8twKsB3dSin7deF3DrOmmAbl5IozNnuS5ISPudMzoGOX1nQL9hAQ
	 +hkNFYyb43YtKAS9aJABjs5Mwa/VBo1KUp+BZ+vgfumn+6WdZ4nUagLwffepF82Ic3
	 sJwRtUo8vp9aEGz6UVa68lx+xlyZdE91yWG3Sv9/rDp5t/fJiXt5WuV+2KmwiuA/hT
	 9n3RNkBp8YG1vOimGgC5YiNChdrSbRr+ugIlahOid6ubwhV1wR2JF90GM9hc8vTsRm
	 OlFRkgR7XlenA==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Keith Zhao <keith.zhao@starfivetech.com>, 
 Shengyang Chen <shengyang.chen@starfivetech.com>, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240627020059.163535-1-changhuang.liang@starfivetech.com>
References: <20240627020059.163535-1-changhuang.liang@starfivetech.com>
Subject: Re: [PATCH] phy: starfive: Correct the dphy configure process
Message-Id: <171992735936.699169.7926536201956741462.b4-ty@kernel.org>
Date: Tue, 02 Jul 2024 19:05:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 26 Jun 2024 19:00:59 -0700, Changhuang Liang wrote:
> We actually want to calculate the alignment values first, then
> use the alignment value to look up the data from reg_configs[].
> 
> Fixes: d3ab79553308 ("phy: starfive: Add mipi dphy tx support")
> 
> 

Applied, thanks!

[1/1] phy: starfive: Correct the dphy configure process
      commit: 8d2a3539517dbf13e970b3aabdf94b04a65d276c

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


