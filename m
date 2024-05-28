Return-Path: <linux-kernel+bounces-191701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA95B8D12CF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 05:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67B1C1F22F81
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 03:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1322B13D880;
	Tue, 28 May 2024 03:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOJeQbJh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5603613D281;
	Tue, 28 May 2024 03:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716867184; cv=none; b=atvTvHOSvqHQAIUPpmUQpLk1oTRILGDkWekkWgTa48AHO8JPCtb1PyAFXG7qJv2Okajvnqv24rWCRQc2gQiNDevKEiN3130WuDEz3o7dpYXAEMqekT9O9fAOvNMrRl7RWVNFWfqkRvk9nVbMo0oMN/Ac+EkKld7urOV8S7vNziM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716867184; c=relaxed/simple;
	bh=s/y0iSpqTuTgo4xv1COA6aVgYk6FJJwv7aHh7ZTcrxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQA6si2M5mcBGLYYfhwg13gP5lNcuGxPZT6SHZTgQXsJpuDPiqcpcStHetYMd0i2oayhHY4rEE7Z9jMBpENSh0P5msb+OX3c9XiQz39Lem5999rjuvOFdHwPdbiOUoiFRFN7w2XIWT68PEtlYwbYXhLOmtRAaD1vtkIsWMGFphY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOJeQbJh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD26C4AF07;
	Tue, 28 May 2024 03:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716867184;
	bh=s/y0iSpqTuTgo4xv1COA6aVgYk6FJJwv7aHh7ZTcrxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QOJeQbJh9REnKpUjy2Ldwx3I20ibqTqsVDSFWvRi1VDnuOsxhngwqt8gEcC+Mlm4w
	 J58yx/bDn0EHhz9XamXcc/V720AlSI/BQeFU7E+6dEpqMbvd9Z9IzbOIiUgj63gqcm
	 lxu0uyIA/AEXNSN2edIZ6sx6bji2FeNBgipgPVyz+De9rlVsNM1jLe4/vgqXIkz/qz
	 FmOiuvrWBnbjl0gN+Yaf4YW10Xy7OpPm8PvXvOK7xUo/vcCfzRmu/OUHxosAz4po8m
	 JcILeoEBhoWYIpzo8Oi3pIaBOT4IfBm6u3QoWdTBDokP+3teE8rt7/QHXdPWHqY1FW
	 6I2YKbnixQb9w==
From: Bjorn Andersson <andersson@kernel.org>
To: konrad.dybcio@linaro.org,
	Chen Ni <nichen@iscas.ac.cn>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: pmic_glink: Handle the return value of pmic_glink_init
Date: Mon, 27 May 2024 22:32:25 -0500
Message-ID: <171686715157.523693.12527723864793317269.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510083156.1996783-1-nichen@iscas.ac.cn>
References: <20240510083156.1996783-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 10 May 2024 16:31:56 +0800, Chen Ni wrote:
> As platform_driver_register() and register_rpmsg_driver() can return
> error numbers, it should be better to check the return value and deal
> with the exception.
> 
> 

Applied, thanks!

[1/1] soc: qcom: pmic_glink: Handle the return value of pmic_glink_init
      commit: 0780c836673b25f5aad306630afcb1172d694cb4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

