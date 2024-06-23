Return-Path: <linux-kernel+bounces-226473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E7C913EDF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 00:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A8AFB21890
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 22:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9641918A929;
	Sun, 23 Jun 2024 22:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CP09Wyka"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA851891C3;
	Sun, 23 Jun 2024 22:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719180559; cv=none; b=NVJo7SgC4cnqEBR28NuexX1HpioG3o4HHk8cjdYQLQezY1q2B30eNjNULEMoNvBkIEtTD+SrmLTMWhFO0PyTgzM+Q0tMVgs8QB+R5Nb+SUBroOqkDxqirJHP2tRH0VQ38YIpFC0P4q2rwYcxgPsD/5hemvly/LFuAENdCu8VZ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719180559; c=relaxed/simple;
	bh=8BE5FAoz8bL9DWzYkZoVSfpn2zyeWa88V1qPBTyp/dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4ohaullPPUocJ/bs4cKyX57TN5sgVDdAkqmKtMCErjrkiPhOrusFz3/q4h1gyM7uOjhpDN38xuijxA7fiKZfQJY+6mOvIf0UjD9vyjNEASBsj2t/65eFvsWt5SDZJIpJw1566yZJJaoboOdqIH+j9jJv2smSNMVWMmLQ+1Ii2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CP09Wyka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7748AC2BD10;
	Sun, 23 Jun 2024 22:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719180559;
	bh=8BE5FAoz8bL9DWzYkZoVSfpn2zyeWa88V1qPBTyp/dQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CP09WykaKYk3Ly9oEzyXB2TEGKSsZSilAbyZHnD6YRo8Ewbbdwrfk0zL1HAwpBswi
	 AUe6HXxYz62JDp9kRgylsvfcPi4fTxigzBYig3RTBHiVlcGhFcMihlKQ7W5OMlTwmI
	 gqOFn2BAJ4PminxV6DA7fAdaz10WrNUFFi7AyIxmWjdf9NWh0jZHc1DWVSAp7Zr15F
	 X7sXST1/XoSm1F6ZMQQej1ZYcxtuEAKmFR2uvyqiwUDSzyn4EQ4QSjPMXMJ/Eo7oCi
	 X74M3eRaDSmRG6fQC2VHMHsvzLIOp0MdP2FCsq8U150CsfQI+43AdGWA7z3aEWuTTh
	 l5VGg6t+vrDRg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robert Marko <robimarko@gmail.com>,
	Das Srinagesh <quic_gurus@quicinc.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Alex Elder <elder@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Andrew Halaney <ahalaney@redhat.com>,
	Deepti Jaggi <quic_djaggi@quicinc.com>
Subject: Re: (subset) [PATCH v10 00/15] firmware: qcom: implement support for and enable SHM bridge
Date: Sun, 23 Jun 2024 17:09:15 -0500
Message-ID: <171918045249.6755.6497330725295979529.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240527-shm-bridge-v10-0-ce7afaa58d3a@linaro.org>
References: <20240527-shm-bridge-v10-0-ce7afaa58d3a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 27 May 2024 14:54:50 +0200, Bartosz Golaszewski wrote:
> SCM calls that take memory buffers as arguments require that they be
> page-aligned, physically continuous and non-cachable. The same
> requirements apply to the buffer used to pass additional arguments to SCM
> calls that take more than 4.
> 
> To that end drivers typically use dma_alloc_coherent() to allocate memory
> of suitable format which is slow and inefficient space-wise.
> 
> [...]

Applied, thanks!

[15/15] arm64: dts: qcom: sa8775p: add a dedicated memory carveout for TZ
        commit: d7aeff30093888649789dcad070fe954745adf53

b4 gets confused by me applying patches across multiple branches, the other 14
patches has obviously also been applied.

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

