Return-Path: <linux-kernel+bounces-308957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF4E966446
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939421C231DD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D3F1B2519;
	Fri, 30 Aug 2024 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="O11OjRep"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2380418FDA7
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725028530; cv=none; b=Byg4in4/5iOkE4eQ9HpR5b5AuosyfuFqBZL1BjnkTXmclvw71VguoTdLlRsuqD2yeJ2Xtnw7tfckgG9cea1rd7RnhE5iRhzXJb3WmBEZTC11AB7pK8HMNDv/mxm/lzLCXqAtao8KbSJlnGUzC2BMRArqaMa48DXXF7w63bLEf/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725028530; c=relaxed/simple;
	bh=eIAO9pwEamQIUf2s4yl7Gxg/tKOF3aWd5ZF622pGQUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQg7l+CGuRsnt/RhPaorMA2impLNVTKF2ww5p9N8sboSIV+FXjil0eom+/YZ8DbONLDiH3RUfOlFMgNJyelPoWZPF6LzmE+q5L7j5SIFWS3fUEVZYa4DUTCfMK5k/CZLgOtUGQq6SuZXuoFNUboEgNUIo7PX+ChWfuYzdVPDN+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=O11OjRep; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BNdRKEuqYftPoGFclr9De5Rzd8g3r15IkdyxOL3+D5M=; b=O11OjRepTkhzXEamXqQ6GTGFKX
	SSykeaYAl5O5hxBDIC5QPduI9tc27lvMjq6dh3UTpS3hiZW9amaBgf8TjA3soXk8f/ePsFZfWdP2t
	My2TrhBOSoCBcE7ncyDIdHfWSZIXlPUmtKop5X3MLzfT9ZvBGP09wWcof/BKv7DrCZMA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sk2ig-0068VF-H8; Fri, 30 Aug 2024 16:35:22 +0200
Date: Fri, 30 Aug 2024 16:35:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	krzk@kernel.org, jic23@kernel.org
Subject: Re: [PATCH -next RESEND] soc: dove: Simplify with scoped for each OF
 child loop
Message-ID: <4ecbf16c-7ca4-4cf8-b6f5-2c6386a6b502@lunn.ch>
References: <20240830040956.3508919-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830040956.3508919-1-ruanjinjie@huawei.com>

On Fri, Aug 30, 2024 at 12:09:56PM +0800, Jinjie Ruan wrote:
> Use scoped for_each_child_of_node_scoped() when iterating over device
> nodes to make code a bit simpler.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

