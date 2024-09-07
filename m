Return-Path: <linux-kernel+bounces-319602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E5296FF15
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 03:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA9B8B23EF6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 01:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AB5107A0;
	Sat,  7 Sep 2024 01:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6MHrqil"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B81DDA1;
	Sat,  7 Sep 2024 01:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725674147; cv=none; b=aohmIyMRmVgW7SI+HSI3lZ8gcMPGHl4wchVNA2ZCLesxYKssPJqBhsRe2KjF0IUrGEZiN4eqCoPTPnPH/YRycv1ks7F3USBwR9YVehCM3zYZHz9pazJ6X9eQYGyYOwwinOKfLctR8obDhKR03iXZpyWyrpWrUtpfdiYeUaWK+ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725674147; c=relaxed/simple;
	bh=59Cs32ix/tIL2TCspeZn2rp7YsU+U42yvvGmm/YBk4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bhRG60bDn/wig3Vj57hBIGGV3keSk2gW3QBt+SU5luMDTxJiVt/4wLHfFVjgIKDvb6LqXfQpRkEiQb+aSmMiVJ7zjkJvOLxVH4sHWjunlNzkeZd26AcorKjrpSAayWF3WDyNYwTw7be5B9ws/1jquI/LC1o3Z7uYHCrOC4znMA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6MHrqil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FB5C4CEC4;
	Sat,  7 Sep 2024 01:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725674147;
	bh=59Cs32ix/tIL2TCspeZn2rp7YsU+U42yvvGmm/YBk4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z6MHrqil7Nr8YQgbxNaFqfjiPk7aWwQ1XCYbSIqljoIqkKw593woTx9aaB9R4I95D
	 FOpq0BHhhbK4a0pOvoOqP8IFH7he35rEBVdxuwKKh2VhebI/ZAcIvccDlDynNavPAC
	 70Oc8gtjzLSSMWPNf/gcsYeVyWDVXIQxDThBf+bocct4xYKK91DHo6XvINTCw0Png6
	 xGZ6xuKdoXkMAOK9j8mH5QmcTqHQQ7E4ScENfILop34hMEdEzUDCX+2quezqh+U5F/
	 yk7m77JOzb5tHNMkeu/Emp5FszvtN5ASNBqOZjpKe44FcVv+8cULzHFHLQQPIDOuti
	 4lWAV43TaRYSg==
Date: Fri, 6 Sep 2024 18:55:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yan Zhen <yanzhen@vivo.com>
Cc: marcin.s.wojtas@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 openkernel.kernel@vivo.com, horms@kernel.org, David.Laight@aculab.com
Subject: Re: [PATCH net-next v1] net: mvneta: Avoid the misuse of the '_t'
 variants
Message-ID: <20240906185546.123b6d65@kernel.org>
In-Reply-To: <20240905063645.586354-1-yanzhen@vivo.com>
References: <20240905063645.586354-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Sep 2024 14:36:45 +0800 Yan Zhen wrote:
> In this case if someone tries to set the tx_pending to 65536(0x10000),
> after forcing it to convert to u16, it becomes 0x0000, they will get
> the minimum supported size and not the maximum.

Core validates against tx_max_pending before calling the driver.
-- 
pw-bot: reject

