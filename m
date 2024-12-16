Return-Path: <linux-kernel+bounces-447163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B4E9F2E37
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94691887B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4E820371E;
	Mon, 16 Dec 2024 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ab95bM8g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4E01CD1E0;
	Mon, 16 Dec 2024 10:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734345237; cv=none; b=iAsrHCzp3mMy9t4Bi7/NIV7sqgspKHgIN1eAOq3XLwR3a316vPcKoAGJc48K5VHQ7g2b2wfFVsUJyqTMLM9QyYpFBaFJhRlsDvAB2y+OYh4oJr/b50dbv3Qix+jS9w7sHpWRWPhrWlJfuIVFDmJ/vpQJpspAqUDd2oCTo14Ak9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734345237; c=relaxed/simple;
	bh=qk4tHCi45AeYn35KUrKNzZZJMfz9AxiHC3bgwhgpFGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJ0SDybcBLEHclkhU33fdXxut57XXnBLB6/c4401qgv9YJDqjlhgEYdF0ii9ITQd1qjv+mCg+1vF+4wUVcs69/dxNQSPkCbOViz7d3h0LmWsPbG8O4OQHGB5WlMw7FAkYjVtXN8puuCl6cXHyXvstY8BCldF+HMCnAgVbuEHRw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ab95bM8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CB4C4CED0;
	Mon, 16 Dec 2024 10:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734345237;
	bh=qk4tHCi45AeYn35KUrKNzZZJMfz9AxiHC3bgwhgpFGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ab95bM8gPDCkWA+Xp0DacngeOp0lk2RjC/00gs1l9s2bcCagH62jezq/foo4g2z/l
	 GXnjtA6ENxBFTaMSN6hB2Ds2lwuVwXDuOBq5MKb64YRzZypYFCF6xPaQ6FrOQSWsYg
	 9PJHH8BjMSLRvVmoh01wpWkvZHbmlBjpCBfG8CtfHgnMW9BnjwhyS+d+0Tq+8nL5S1
	 Pao6eIvlKU6hVSR5zh65d87sU3Rxf+eFQ8ykFH8Kj6V9f7qrDdjJNqCv5GQcsKbbQu
	 o7DIg+/DIhv5FRFjcBlbdnDnQhT9s4T7bRp89UtSQE8bOAJVsnDETDKSO3B3gLt1/+
	 Ht1Ihk2db1yAw==
Date: Mon, 16 Dec 2024 10:33:52 +0000
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Aviad Krawczyk <aviad.krawczyk@huawei.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Zhao Chen <zhaochen6@huawei.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] net: hinic: Fix cleanup in create_rxqs/txqs()
Message-ID: <20241216103352.GA780307@kernel.org>
References: <0cc98faf-a0ed-4565-a55b-0fa2734bc205@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cc98faf-a0ed-4565-a55b-0fa2734bc205@stanley.mountain>

On Fri, Dec 13, 2024 at 05:28:11PM +0300, Dan Carpenter wrote:
> There is a check for NULL at the start of create_txqs() and
> create_rxqs() which tess if "nic_dev->txqs" is non-NULL.  The
> intention is that if the device is already open and the queues
> are already created then we don't create them a second time.
> 
> However, the bug is that if we have an error in the create_txqs()
> then the pointer doesn't get set back to NULL.  The NULL check
> at the start of the function will say that it's already open when
> it's not and the device can't be used.
> 
> Set ->txqs back to NULL on cleanup on error.
> 
> Fixes: c3e79baf1b03 ("net-next/hinic: Add logical Txq and Rxq")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>

