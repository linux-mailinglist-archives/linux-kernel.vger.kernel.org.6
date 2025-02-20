Return-Path: <linux-kernel+bounces-523514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D25AA3D7DD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D82D7A9606
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4E31F1538;
	Thu, 20 Feb 2025 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FkQ9bk2A"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFB01EBFE0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049715; cv=none; b=LE876tonM2rtzRnFPaVAFgux/Tg1n9q9ZqM9piPXjSyzOXcLbW4LDVOtF/R0bgUdWBgtEHo8eIBPvicmuncBGVsFKwbrd1vyGgo1m+nOf6zfyTc/qLSqKko9+T9l1ZYBNJXRau1nODzMqXhYP1OGCTGs+0QRN9M5T1O9OfNbrkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049715; c=relaxed/simple;
	bh=oXJNr/gxxvxCZ5rhqqjVPyBrGe3PMFy7vb+NY47McLg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CwVvxJYXY6I9HNHOX7fJ9qCX1Aq5iN65N/XT9Q/blhrIS1LFMfXi47pPtLaGCigcnngjh2CH6oeWYOBkq4NST3J4bkUlI42n9eb7DcclMEepzPjfJz3wMAyX27BqCv+u0PGOJHdtJdKmS5kKXzK7cKMH5Ymcn2UHB9wfDrnfztY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FkQ9bk2A; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740049701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DN4B67Rzb5ZccHJbDxzAn/tcklLewziqHZr7OFYX8jU=;
	b=FkQ9bk2AuLs0vWYjGGMFl6Lj+vVHipDJNXzsfpR7qS2n8jL8M96eIdFpqZE0mkEsqBqrup
	cXcIpwu3Kelk+l0cIb0cIlOSPBSR9iJueirwtjD9w41qDY85XqUVQ5MafO4G2AYBfQMMUO
	sq+0vFTMJlrysK918r42sAWxc6fsiew=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] net/mlx5: Use secs_to_jiffies() instead of
 msecs_to_jiffies()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250220071327.GL53094@unreal>
Date: Thu, 20 Feb 2025 12:08:07 +0100
Cc: Jacob Keller <jacob.e.keller@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Yevgeny Kliteynik <kliteyn@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>,
 Itamar Gozlan <igozlan@nvidia.com>,
 netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <9694B455-87B0-4A70-93C0-93FE77E3CD17@linux.dev>
References: <20250219205012.28249-2-thorsten.blum@linux.dev>
 <48456fc0-7832-4df1-8177-4346f74d3ccc@intel.com>
 <20250220071327.GL53094@unreal>
To: Leon Romanovsky <leon@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 20. Feb 2025, at 08:13, Leon Romanovsky wrote:
> On Wed, Feb 19, 2025 at 03:45:02PM -0800, Jacob Keller wrote:
>> On 2/19/2025 12:49 PM, Thorsten Blum wrote:
>>> Use secs_to_jiffies() and simplify the code.
>>> 
>>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> 
>> nit: this is a cleanup which should have the net-next prefix applied,
>> since this doesn't fix any user visible behavior.
>> 
>> Otherwise, seems like an ok change.
> 
> IMHO, completely useless change for old code. I can see a value in new
> secs_to_jiffies() function for new code, but not for old code. I want
> to believe that people who write kernel patches aware that 1000 msec
> equal to 1 sec.

Using secs_to_jiffies() is shorter and requires less cognitive load to
read imo. Plus, it now fits within the preferred 80 columns limit.

This "old code" was added in d74ee6e197a2c ("net/mlx5: HWS, set timeout
on polling for completion") in January 2025.

Thanks,
Thorsten

