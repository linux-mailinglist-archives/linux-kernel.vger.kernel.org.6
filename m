Return-Path: <linux-kernel+bounces-348725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F28D98EB11
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10281C20A6F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D577013213A;
	Thu,  3 Oct 2024 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqfZFW6E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F620136657;
	Thu,  3 Oct 2024 08:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727942925; cv=none; b=b0T2D3McWSuRmJvZs3x0VQnQAmfooEIihUconn8PrB1odiIGDkMW8sbol0tg8GeLQQcPE6Z+XoaxdiaSDNI1K3vF8Iu5CnGnllNlX0RvLwUfl7VuTxzCICx6YITYtmmwv8SDHw6hdFLAbAbxw5nPIjd/jQd852M8eBf2qT7K870=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727942925; c=relaxed/simple;
	bh=e5W2aYSP1MKqfdbHXFkLuzX4Zd/Z/L7WAazVK9xYHEQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DRnsCvI216bcjzRgCm9mOn7Qmfc6Mxf7PJm+L1Wxd+/OKm4zL3sYkTvv2ZEpzhtbd+qjpyT4kGsao/hfj5sJUlsj87SaOd6HZUzQ6Zn5Eswt3I5HwdsS1FOctxcu7uGDCM8Kbf0IcFqB77DUoFAyqM1MgoaQMZFlCQ4Y34imfVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqfZFW6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D226C4CEC7;
	Thu,  3 Oct 2024 08:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727942924;
	bh=e5W2aYSP1MKqfdbHXFkLuzX4Zd/Z/L7WAazVK9xYHEQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DqfZFW6E8ftGnXrPuTs7A+tykuu7TcfmXmDLQefs4Uc82jjQnHTsLbeOR6TfeyZI7
	 DEJ1U27tIbAHT+6yHsTDFKIVY0BZXAIoq0PdFQYGYMGlBik8koADz68tu9xEP6QFFM
	 gcY0YbXFpLs9szVzjOMFlPM6f2XlSTHCIbis7sBiW4oVWlwjob4eBtBd3NtIrfnz/x
	 vC2Z6NrIukyh8uCiYuv0RZxjY609DDhvdhWQPSI0buiflKsqvLRL8F99Est4FDa4NL
	 YEqw/Ika+TjAwleXlPraM3J9Jxc6C1KThEkzHE2VJAazf7MkC2XRHVJOaGy0QsYcVf
	 F59Qq4yfoHU7A==
From: Vinod Koul <vkoul@kernel.org>
To: broonie@kernel.org, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.dev, 
 yung-chuan.liao@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com, 
 venkataprasad.potturu@amd.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240924081846.1834612-1-Vijendar.Mukunda@amd.com>
References: <20240924081846.1834612-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 0/4] refactor amd soundwire manager driver for acp 6.3
 platform
Message-Id: <172794292092.250995.1839758557261465524.b4-ty@kernel.org>
Date: Thu, 03 Oct 2024 13:38:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 24 Sep 2024 13:48:42 +0530, Vijendar Mukunda wrote:
> This patch series refactors the amd soundwire manager driver to support
> acp 6.3 platform based on acp pci revision id.
> This patch series prepared on top of asoc tree for-next branch.
> This patch series should be applied at one go.
> 
> @Vinod: Please help to review soundwire patches and provide ack-by for
> this patch series.
> 
> [...]

Applied, thanks!

[1/4] soundwire: amd: pass acp pci revision id as resource data
      commit: ced20ea315fe8591093f19574ec32222c1ab71ba
[2/4] soundwire: amd: refactor existing code for acp 6.3 platform
      commit: 7b54323dde29452dd06e6acd2701d9b489c9547d
[3/4] ASoC: SOF: amd: pass acp_rev as soundwire resource data
      commit: 1bb50ead592ceaf2b1572c7d08797b8b3229432e
[4/4] ASoC: amd: ps: pass acp pci revision id as soundwire resource data
      commit: 425f598ea69713b9e60f08e48a19be56b7bfddbc

Best regards,
-- 
~Vinod



