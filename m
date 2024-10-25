Return-Path: <linux-kernel+bounces-382104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F06B89B096C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5AF1C22D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F11A18BC33;
	Fri, 25 Oct 2024 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asN56JR+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8E1189F3F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872744; cv=none; b=PbiDFyCp/sZg52e/K1RZPcJpnDbyy97nDiw9o2oJ4u4LIzwg67rsur1b2BY0Wj/kb/Z25BJQhQtQvs0VlgaF1OTkPYbzqE1eKHfAKEh/9L0VCToQ3Jeb2q98toopajSelVe2r5cRmCuK+Megxu7PimGXROUR8OxOQ7zk/dkBzXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872744; c=relaxed/simple;
	bh=MbYu/8B6N5thTChedfbAC/pUmjngI2T0nNWhkoENNLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYaiWUzMIcVtQ6ZWvs5qQPB4nVrxAvqJLiDtnoilSt6u2k5aKFIImQUFW1oG1M14dCxTo7yydAnIXTPbFTafFKX6LmZx9qn39KqIBi2wW2vI73cDAAnuLjQZr+ZaKhgOkbGKZyLz3sGVqMU7239zFJSBaH2xeUHKRW+uBk1QCS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asN56JR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8C5C4CEC3;
	Fri, 25 Oct 2024 16:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729872744;
	bh=MbYu/8B6N5thTChedfbAC/pUmjngI2T0nNWhkoENNLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=asN56JR+FfzlsRyeT6tL4SS8+KS4tVoKiGnLM+K5BvmO77+/aTNcMaiT60miDak4t
	 bx8AOqshbszSdRVXahXQILtBLdj7qArL7iUDOpOnuCXqYaNoaKFtkgQ3SBmvGOd9/E
	 VqBcogseFDol1SbqsdFxgDQSFStRdlaZ2VLFaQw6+F1UhccivAtCeQ9sqaFzGV2Lx7
	 WeQRun543ZOkUbhkFDTgULpHO/pGwOKPsK20uJeHKZ0/MWBhl/tBewSEt+aCmPtqxx
	 QpE7O8t4NXf92dgYM4FkwUYlbxLm4HL9/UiEtyyK+yFI+JpJUCdGBXzgxFEO5d32kY
	 eVRDRh0+8X9Lg==
Date: Fri, 25 Oct 2024 10:12:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] nvme-pci: Force NVME_QUIRK_SIMPLE_SUSPEND on Qualcomm
 hosts
Message-ID: <ZxvDZVKtM9qGYBP_@kbusch-mbp.dhcp.thefacebook.com>
References: <20241024-topic-nvmequirk-v1-1-51249999d409@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-topic-nvmequirk-v1-1-51249999d409@oss.qualcomm.com>

On Thu, Oct 24, 2024 at 07:33:07PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The Qualcomm SC8280XP SoC requires that all PCIe hosts are powered down
> before the platform can reach S3-like sleep states. This is very much
> similar in nature to the issue described in [1].

The "SIMPLE" quirk is only supposed to affect kernel managed runtime
suspend states, s2idle or s0ix. Shouldn't s3 already be using the simple
suspend?

