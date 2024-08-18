Return-Path: <linux-kernel+bounces-290980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C68D955BD3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 09:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7B7282275
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 07:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3364B1642B;
	Sun, 18 Aug 2024 07:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldZ0fAMu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74006BA41;
	Sun, 18 Aug 2024 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723966137; cv=none; b=ci7rhZ+tGbBaLsfROKzCcgHS6T8smy1KArIALhUX7U9DkdPIZfxokCclftzeFLtAx+nqyPDC7jsCl4lDd3RqGKk0sryEmkY3GvrPeu5HbUgKJx/NpalypVmWhVOKmAn3WbqOKrJI8ZZxxjpf0YHN1ga1iya7PS48Ih84F/K8m6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723966137; c=relaxed/simple;
	bh=7kqkLWEy+OLt/Z/7mO7cI3tSA8L9d/Dhl/E63oaEcyk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=swK8IBhMnttlSKPhPJpZA2fPdy4w4UlOIEB/YOluDdnuZCXlsIiw+W1uXUPC1CW1tSYe2O24VG3uPu/7IShBs5y6JPQy/8qgr7jaXErSPo8wx9pnFwzs8u+CGDZnJsSWCR0VgTmPGptI8UYmyd8xlTuPdoRESHr04ncDaZoOmZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldZ0fAMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58514C32786;
	Sun, 18 Aug 2024 07:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723966137;
	bh=7kqkLWEy+OLt/Z/7mO7cI3tSA8L9d/Dhl/E63oaEcyk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ldZ0fAMu89bRiKaMv3hGEAXpg/IFsqaIikDLJl9j8ENMbtBgjLRCTGUdOgnbgQBWQ
	 3KVggvb03CpBfIrPuNp5A/xWt/xdh9WLVo8OBp5kNp3Ph8qcswOiaEGPX1hgFAsGVo
	 JAqljn42uWkxdWO/oLgJtg/YzE+FkbMLGErKpVRKjQk4OgHpyOZNPTC4ndxRyW9u5x
	 2QNC2fWSp6ckNppe5PRiMljsgXGeg0uCQIn8JYQUOW4n1NC/diAo/8aofAOOyABtnj
	 RWeKsX44g8nDlsJm9Cugumf6dl+F36iXbdV/gjXeU7CfXz6Oydw6lQjbB+/1n1wxt4
	 48P2qnfIvqATQ==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
In-Reply-To: <20240805114921.88007-1-yung-chuan.liao@linux.intel.com>
References: <20240805114921.88007-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: cadence: re-check Peripheral status with
 delayed_work
Message-Id: <172396613500.999616.5825027141981948673.b4-ty@kernel.org>
Date: Sun, 18 Aug 2024 12:58:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 05 Aug 2024 19:49:21 +0800, Bard Liao wrote:
> The SoundWire peripheral enumeration is entirely based on interrupts,
> more specifically sticky bits tracking state changes.
> 
> This patch adds a defensive programming check on the actual status
> reported in PING frames. If for some reason an interrupt was lost or
> delayed, the delayed work would detect a peripheral change of status
> after the bus starts.
> 
> [...]

Applied, thanks!

[1/1] soundwire: cadence: re-check Peripheral status with delayed_work
      commit: f8c35d61ba01afa76846905c67862cdace7f66b0

Best regards,
-- 
~Vinod



