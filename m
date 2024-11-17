Return-Path: <linux-kernel+bounces-412289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EA59D0717
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 00:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05056281E2A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 23:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836E91DE2AA;
	Sun, 17 Nov 2024 23:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cZlcw9ZN"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110942309A7
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 23:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731887379; cv=none; b=KZ+DqR3rm5W75G31u5iAkdvYB7KkvJDoSczHzkNgChuchN9WJQ/7RoMNMv/luckEjVodHt7zyGzFa4CPelTDwoIn7dGGjUZa/VkYDTDPglBTvwlM5d4sWeSct/Sb4Y7fC7geKnIA0oKWPJZgzI4Wizo7wHoPGzcUNnbyc4htzm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731887379; c=relaxed/simple;
	bh=RXy9zM4D/wtkk/3vzQbpW9uPjA0eh8924g1+lxWfxKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFm1ES7h9s+3FIcPhySu+N7ENzceS//c8Zbvd4R32G+s87N7yaV3P2qHo7A7CUFztrAxxGDVdOKwrippfG2XfI62g1vzKdhWCV6d4kar/Fo74YrK4QmQTdeTOzWFZR4zKAY8jLyqR9vgnm0uwuORyX6F1PxHC/OWBojIp9hRQ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cZlcw9ZN; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 17 Nov 2024 18:49:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731887375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Agxt+AwFYrRD7m03b1C+qujn1oHH+KdH2UDB7HCD1qc=;
	b=cZlcw9ZNLPwWBytyWFSWDwgTuttuToQm6D5j3CkbbJ6h8r4TBm72DQNwIsDtegBlOiNVju
	FMvMNXAqLMPvC9yHJp3BFF6AWaK7r+luT/XslxBCVN63Dg/hJnkqys3BqOfIRfJtzaAL51
	tKoKaixMwDS4Lmys4QYzXZfEbaTWOmA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Piotr Zalewski <pZ010001011111@proton.me>
Cc: nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, 
	justinstitt@google.com, linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, skhan@linuxfoundation.org
Subject: Re: [PATCH] bcachefs: initialize local variables in
 bch2_evacuate_bucket
Message-ID: <enjo6na4qnoamw74tyfabwriczmwo4ir3hs7hc7ma2p4eomwec@q54ebukphsiz>
References: <20241117234334.722730-4-pZ010001011111@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117234334.722730-4-pZ010001011111@proton.me>
X-Migadu-Flow: FLOW_OUT

On Sun, Nov 17, 2024 at 11:48:23PM +0000, Piotr Zalewski wrote:
> Compiling bcachefs sources with LLVM triggers uninitialized variables
> warnings.
> 
> Signed-off-by: Piotr Zalewski <pZ010001011111@proton.me>

Thanks, applied

