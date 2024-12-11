Return-Path: <linux-kernel+bounces-441395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A02059ECDBC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D888B163392
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DBA2336AF;
	Wed, 11 Dec 2024 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeQhTxK/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914D9381AA;
	Wed, 11 Dec 2024 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925303; cv=none; b=n4fVZXLMskVK7G3Dj4bpTd7fE+mE57n98NDoApkU3Qp2nPP4w6QAqhMCT+k4b8EZ1qIVzCexv8ieD39PzCh82D3UHGFUzEU6Xpx0NPYy/EJucVoSM2xbs7Flo3VqhGLt8dPJWZGSw11cI9H4w+6j+vVx/IKcDW04O9wqV9uWfQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925303; c=relaxed/simple;
	bh=UwwBh/u8TLkS9PRQCaDBKq59MLVL8DMYlsHPs/22a1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzcFxB89M9cY9jEf+IdABWid2a9ePC6nJkda8jH0vk68sk9I0teJ6I8AOIvUIcthvR8rMKUuBg1FWj5HIOJz/qsDaYLdgb7VP6/JpmWu6WBfKq71Abyxtof8BO65zfVP8jLUzo9G/DKzWvou2bRfxgpywIxP+wKw9vElg/4UpvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeQhTxK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279EFC4CED2;
	Wed, 11 Dec 2024 13:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733925303;
	bh=UwwBh/u8TLkS9PRQCaDBKq59MLVL8DMYlsHPs/22a1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MeQhTxK/2q7mV86nOQY6Ycud8YPRqQeqaixT/rXrS/t76jkU60N2SIzFOWqhG2XiS
	 nAj00+Rwi3U35BYYRertJnS16M63xDG8h2qOVMRQfEw7H6VwkiPJ9DQ0bcGWGIze2C
	 R5wvTipLoMSK0keDsQpoE3mpzA9Iu6z1MWfL/jDgXcDOCXMJRBuLTnuRfoXCkril2P
	 z/Rt+cL5HA1WHii3VyA3+HT0zkAxETITBIzWQtqYrGMYEeAZccKC47dMaxoMrIobQJ
	 I76uUfJeRvLCWPWPqjLCeAgch60CJ/RDT+bt6bisQoMpv1gtlitrTZGhO8mqiugcQ9
	 0WqEJg3GHcwtA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tLNBB-000000005Kf-3imc;
	Wed, 11 Dec 2024 14:55:06 +0100
Date: Wed, 11 Dec 2024 14:55:05 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] soc: qcom: llcc: Enable LLCC_WRCACHE at boot on X1
Message-ID: <Z1mZubWYMxPaHx70@hovoldconsulting.com>
References: <20241207-topic-llcc_x1e_wrcache-v1-1-232e6aff49e4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207-topic-llcc_x1e_wrcache-v1-1-232e6aff49e4@oss.qualcomm.com>

On Sat, Dec 07, 2024 at 03:04:26PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Do so in accordance with the internal recommendations.

Any hints about why this is needed? Should the fix be backported?

> Fixes: b3cf69a43502 ("soc: qcom: llcc: Add configuration data for X1E80100")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Johan

