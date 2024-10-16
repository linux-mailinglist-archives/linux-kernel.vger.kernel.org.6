Return-Path: <linux-kernel+bounces-367489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 417BF9A02F4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B64B2587F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE8C1C32E4;
	Wed, 16 Oct 2024 07:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B2WtYMlf"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FA918D634
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064805; cv=none; b=aCxVsj92PWGHx7Y9f1DF02bi/Q5bb0e8WAGlGvo7BgRD62PpP/pBe4Ukko5M5UkEQ6cdkgQ3gZ4ffPlaOuy9WHlxILFzPruJQYXEnYOP6+BTtmcKHe+nKXl/C2G5Fv7gEh4WRxYSmGYQLpmSCQOhbpIUJmX+x115F1Bc/Xb4K7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064805; c=relaxed/simple;
	bh=PY2RPYYXdOkd8vVTO80tY4AYemyG78rVTayaLlavAe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BtLzkVdNHnw0Mc30G9eJCR/gXP300qxa9TA9tnbmzQGVU1/qN6Itr4u9SNtqjJh9o8AlBngc8j4Z60tjcl56OpwfotZgDnTZ0n+dTEYN85VXdzLVTZ+FBIyTu3vAEIrEa1cc4KiPf65BUW3hZivZbR9BVEYdhPSnIM4IaZhLNOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B2WtYMlf; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <05861e8b-a26c-44f8-af47-50f31db1b720@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729064800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SDwnOcmLrw4/aOp+EBc8mjZmSVVRXU40AAt9IRfu8M=;
	b=B2WtYMlf+GwdZiya/dwwsrhzOPdj61kFpBCHGC3F/KxT843JmFEg2fcj2TE6WhfTHJ6yeE
	QJIc9wy8xllRDN8pegqxm+Fk4LjPBAae6CW7eQDsiPrRvTj3kJ0PZ4GTdUT27X5CFhONor
	k4R0MMTkaMkkah63MdmwXU8iH5LsZsg=
Date: Wed, 16 Oct 2024 08:46:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] eth: fbnic: add CONFIG_PTP_1588_CLOCK_OPTIONAL dependency
To: Arnd Bergmann <arnd@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, kernel-team@meta.com,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241016062303.2551686-1-arnd@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241016062303.2551686-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 16/10/2024 07:22, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> fbnic fails to link as built-in when PTP support is in a loadable
> module:
> 
> aarch64-linux-ld: drivers/net/ethernet/meta/fbnic/fbnic_ethtool.o: in function `fbnic_get_ts_info':
> fbnic_ethtool.c:(.text+0x428): undefined reference to `ptp_clock_index'
> aarch64-linux-ld: drivers/net/ethernet/meta/fbnic/fbnic_time.o: in function `fbnic_time_start':
> fbnic_time.c:(.text+0x820): undefined reference to `ptp_schedule_worker'
> aarch64-linux-ld: drivers/net/ethernet/meta/fbnic/fbnic_time.o: in function `fbnic_ptp_setup':
> fbnic_time.c:(.text+0xa68): undefined reference to `ptp_clock_register'
> 
> Add the appropriate dependency to enforce this.
> 
> Fixes: 6a2b3ede9543 ("eth: fbnic: add RX packets timestamping support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks!
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

