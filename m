Return-Path: <linux-kernel+bounces-247043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC8992CA3A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9C45B222B1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91F96214D;
	Wed, 10 Jul 2024 05:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+E90/GV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4955BAF0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 05:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720590359; cv=none; b=EXcuyog05x4QvDjsKTzkRHf7je8f7xmOkpgJlNLd/5+gL9V/Ntt7SECSp9OhUV+ExKPnHLwVBCxYwSR0gseWjgQHCW/bLrc3Rt3PVwisw6cFLBve/bjvzUF3EdAeL1odRDWsmozpKZlGhBoxoKv+ZK1zachhiRbA/ckmkFu0ec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720590359; c=relaxed/simple;
	bh=nxY3bmwxzmUjpGJqiGyt0zCho88LtDR8cLyci2z6gm0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DagkduLeTCQif5WjATMFXb+X9sWGToqDvSfbMmTVhvdVfNgWU5IbwnxaCnACxYYFhwmFSYdWWJxD9uOg80xHjI9uandj+SIrj0kyvSuYRWrAhnBzpvDA08QPehhC5cPI/SyEZBO9xeaEvraj2nqkuLdrwWl8FOW0DHqXGLdadNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+E90/GV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3B4C32781;
	Wed, 10 Jul 2024 05:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720590358;
	bh=nxY3bmwxzmUjpGJqiGyt0zCho88LtDR8cLyci2z6gm0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=a+E90/GV6BqjiquWrReBLSRMqeR731DKWbhPn+cWvGXmWcAqyj9zlOONrDN1hmkIn
	 b6trdmcAfa0rCAmhDH7YMHlK2lxX4C58Fwfsra4Ooq0rtLt2/zpcJdyUZCSa96Gkk2
	 zWsUMOqOciFYxUepWp7z5bszRk0tXcuMgqAZGsA+y5J5j/wqqkkGRlby1cQ7qi4hOW
	 Ie16VhGFHjGi7R9AyodWrdXutDmntSONywLHnvPIU5fwxOYyyuCqFGI101Vg7YP4T5
	 KaE0HQ1NlrccDnwQpl1TVT6/B2VDntkqihWhjFtlEQWwa2wOsrpzC8qptEDqeB0Rzi
	 vVWiI2PfHT3jQ==
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Sanyog Kale <sanyog.r.kale@intel.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240703-soundwire-cleanup-h-v1-0-24fa0dbb948f@linaro.org>
References: <20240703-soundwire-cleanup-h-v1-0-24fa0dbb948f@linaro.org>
Subject: Re: [PATCH 0/9] soundwire: simplify code with cleanup.h
Message-Id: <172059035617.363871.9938538584566291024.b4-ty@kernel.org>
Date: Wed, 10 Jul 2024 11:15:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 03 Jul 2024 12:15:52 +0200, Krzysztof Kozlowski wrote:
> Allocate the memory with scoped/cleanup.h to reduce error handling
> (simpler error paths) and make the code a bit smaller.
> 
> Best regards,
> Krzysztof
> 

Applied, thanks!

[1/9] soundwire: amd: simplify return path in hw_params
      commit: 89cc1354d388ba8c8f8b41095736202a83591497
[2/9] soundwire: amd: simplify with cleanup.h
      commit: 02611eeec5893c17ad85769007ecfb5cbe7a5987
[3/9] soundwire: amd_init: simplify with cleanup.h
      commit: 1f93cb229b0e2d78233690c9ca65715e1f798803
[4/9] soundwire: intel: simplify return path in hw_params
      commit: ba874a8c2f895d898bbaf67f9e952425aff1557d
[5/9] soundwire: intel: simplify with cleanup.h
      commit: e4fcf153d91809aefa6860d285e747fd7dd9e61c
[6/9] soundwire: intel_ace2x: simplify return path in hw_params
      commit: 13814ed162687be08e34762040cfc2e58831219d
[7/9] soundwire: intel_ace2x: simplify with cleanup.h
      commit: 3dce65898e0911aa76a0a321540b78e9218b9a6a
[8/9] soundwire: cadence: simplify with cleanup.h
      commit: b72d4af98cae2f74dc8061befcc3c0c2a174894f
[9/9] soundwire: debugfs: simplify with cleanup.h
      commit: fdd3d14ca3c8c5269174f10d33d6181173cbd0b4

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


