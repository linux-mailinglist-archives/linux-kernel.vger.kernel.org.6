Return-Path: <linux-kernel+bounces-212412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685CF905FCC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 02:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C651C20F29
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 00:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2B68F54;
	Thu, 13 Jun 2024 00:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUOLdfmc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A1F8BEC;
	Thu, 13 Jun 2024 00:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718239393; cv=none; b=MhlpinD17eUEJAs50bAIUCFJL8eGs4Dne7Lo4TCDmK9qixZT7MM2NWOjs9EnUzdu3jMVyEm0pdZ95h6e0pP8SfCRnwqAWHZaGXAK8S4fi88e0M05aikWRv8DRnG23b3NltZhv0bHfVrmEpAyezA4A44jX0eNLmFG4NZozHxErvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718239393; c=relaxed/simple;
	bh=7N3EQc3+IGIhNfJtXalwM67sSrGSvDvKQ/XagDYR96Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JISNiu6MmUmG75QmaZFTuVt2EwUo+LyzVT8U3mE6T33R0R5m8nzISTfnUn+UenNAJOkHL+91uxpEvNA+eKV1C5TUekzxFrvu35LoeSKG343Kp0aYk0vCTwjS6Ljz6O39P/uTtl32TrByIqK+AV88p3UYnHdOKPED3yJTuNV1Ous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUOLdfmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8FBC116B1;
	Thu, 13 Jun 2024 00:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718239392;
	bh=7N3EQc3+IGIhNfJtXalwM67sSrGSvDvKQ/XagDYR96Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eUOLdfmcf5juairra4nesr18UCpgKbxbrVPS/aBOiFOzc0/+1XOaD470PUT7Uh5cy
	 a7Po70oDqI9GxqAJLGxxEtJwiS6f6398Buf6Kjm6YoYg1eiknoliDCB1yorfr4ObBL
	 +A1BLBUvnxSZvqH0HxRDNQStSd2zyYi49eTFRnH48UKYIYOx/NRhlyOT/Spn6HPSiW
	 NZBGOFS7Zyo87mN5gDpDHqXvXGJfE7M2ZIgKDrvkXpmR60UCZnbjobkZ/IBofz6bbM
	 fUu2FCc5GZLktHKnMXDLqT7GoeI5Xpea4BqbMNQbyE7YG0nbIFDhIH/yZQ+vMfiChV
	 IOO/3cibLEbBw==
Date: Wed, 12 Jun 2024 17:43:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <andrew@lunn.ch>,
 <jiri@resnulli.us>, <horms@kernel.org>, <rkannoth@marvell.com>,
 <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v20 07/13] rtase: Implement a function to
 receive packets
Message-ID: <20240612174311.7bd028e1@kernel.org>
In-Reply-To: <20240607084321.7254-8-justinlai0215@realtek.com>
References: <20240607084321.7254-1-justinlai0215@realtek.com>
	<20240607084321.7254-8-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Jun 2024 16:43:15 +0800 Justin Lai wrote:
> +static int rx_handler(struct rtase_ring *ring, int budget)
> +{
> +	const struct rtase_private *tp = ring->ivec->tp;
> +	union rtase_rx_desc *desc_base = ring->desc;
> +	u32 pkt_size, cur_rx, delta, entry, status;
> +	struct net_device *dev = tp->dev;
> +	union rtase_rx_desc *desc;
> +	struct sk_buff *skb;
> +	int workdone = 0;
> +
> +	cur_rx = ring->cur_idx;
> +	entry = cur_rx % RTASE_NUM_DESC;
> +	desc = &desc_base[entry];
> +
> +	do {
> +		/* make sure discriptor has been updated */
> +		rmb();

Barriers are between things. What is this barrier between?

> +		status = le32_to_cpu(desc->desc_status.opts1);
> +
> +		if (status & RTASE_DESC_OWN)
> +			break;

