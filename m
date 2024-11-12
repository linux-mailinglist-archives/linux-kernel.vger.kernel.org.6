Return-Path: <linux-kernel+bounces-404928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65799C4A77
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C97B281462
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418CA7494;
	Tue, 12 Nov 2024 00:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYtWjqgo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD954409;
	Tue, 12 Nov 2024 00:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731370327; cv=none; b=ilHE1VyUbD0dtdMSVCJzLAouV2veYmRKzqG/XuH/H9G1VDjOkpTKX0N6xmMlRTn4NaZFb4phbfMl0U2lSkinnYpnY3Q2F1kynR2Z/PfqPP8aXsiEkq22d7ECL/MCK4JfwmP91a8RHby+14eql1jTP8K9IaB/bahl+k4PGNW5zPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731370327; c=relaxed/simple;
	bh=F6KtVDx7kefgsDbbvSvre0SI4ek2HJre6EpkN5nZLpw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1OQkdDdsZ8a2XjqEkj3dpe+WC9a5T2/bMe9sEhjRLo2Yqv5REDVRUzhThcUZRHGfwv5DQ/3I3Fysi19wyREP4pf0U9PX+wtAkxIJgN6vUJdk16Obfv9UrviFxEJ8yN9olzelEaSY0NH0PMFnVMUMiOV2HtwhiNpjFB45Vq1+v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYtWjqgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB5FC4CECF;
	Tue, 12 Nov 2024 00:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731370327;
	bh=F6KtVDx7kefgsDbbvSvre0SI4ek2HJre6EpkN5nZLpw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FYtWjqgoyYor2KQxuCduFyVPGGug7Lae6Zmq//DBd3J775HaM3IaD89LNwlzGfzg8
	 OTbdTKXJNxQ7RyTm/Uf3WjPXmMeT5O+324PbmckBkAIr+vu3Hisv/RQ+px6riH/ew9
	 EvzwcyclN8+IzKBkfEDqUbK5gE4mrRnEDF5MObJoeQoQxwuk1cOoO6ls0My5yu96wx
	 AslbCPGQqKPkw4swgS1D4SPmEY0D2GeJvPbvqytMxbsfghFSySvHDlc7/qImqc3ZgG
	 frjtrVU+2NYAa3e1d2JYggboGUkn5HZd4Q36XxubIDtQnn2ie3QdpX7feyV1rmruUu
	 dFA/HxKRYepAQ==
Date: Mon, 11 Nov 2024 16:12:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Richard
 Cochran <richardcochran@gmail.com>, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/9] net: stmmac: Introduce dwmac1000
 ptp_clock_info and operations
Message-ID: <20241111161205.25c53c62@kernel.org>
In-Reply-To: <20241106090331.56519-5-maxime.chevallier@bootlin.com>
References: <20241106090331.56519-1-maxime.chevallier@bootlin.com>
	<20241106090331.56519-5-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Nov 2024 10:03:25 +0100 Maxime Chevallier wrote:
> +		mutex_unlock(&priv->aux_ts_lock);
> +
> +		/* wait for auxts fifo clear to finish */
> +		ret = readl_poll_timeout(ptpaddr + PTP_TCR, tcr_val,
> +					 !(tcr_val & GMAC_PTP_TCR_ATSFC),
> +					 10, 10000);

Is there a good reason to wait for the flush to complete outside of 
the mutex? 

