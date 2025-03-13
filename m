Return-Path: <linux-kernel+bounces-559220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D56A5F104
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163363A91D1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4412571BF;
	Thu, 13 Mar 2025 10:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPJDy0Ly"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC2B1D5154
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862143; cv=none; b=bRIT+CkfTUyr4ed3QQrQkMzO8JQe0D5mzRYKCRf1el4sGO+V93B9dVZRgaKJkI15fMfyGo5CopWmRcnv2KLjzSY0RBaC94d+X7kvOPTh9phbcJChU2HLKf0VNSC6HSCSh/lextj56tu5biintn9XW+Pg5aPhTOLbzBXL8VWyGX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862143; c=relaxed/simple;
	bh=HwddNMKoRxMnPfOo1Zy1wl6DJgyF9AKmbUbp/4mYZVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AB5/YTcQv3ATC7xGBproBMa1l753gHzTlnum6rFAYsJVvNm6qKkcZd9oMwJoczlAaVQOzIoTItRCBqrvw2hkUTHSwyA5D17FWHidFwYpHrsL7Nh+js37D03D+RdSD9X0MxFp1cJzn2nk6cEMKYuGtorju8f6pJH3pD/AfjjWn64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPJDy0Ly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E345BC4CEEE;
	Thu, 13 Mar 2025 10:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741862143;
	bh=HwddNMKoRxMnPfOo1Zy1wl6DJgyF9AKmbUbp/4mYZVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WPJDy0LysT8DO/IFgRSu1ybIe0REzyyiM7ojFXE5bnQbKp/p/UVi+89gj4xHJ/5xb
	 kNhyCFdLobiFV9uQCVwHo9KnJyt3XVHbChLvmqpQFRFt/ZkMwXWCZ7WUwkPNSp5tZm
	 oyCo4XZ0lea4vWlZctbPFoOdsfZ12Zqxj0a1+fAgOYXpRJPbkjd/MWotqgu/qyiACn
	 Qs2kiUEkSekfypds2s1uzlFZ81ruIW9OzJ2HCYe1hKacasjBiXAGMl92LCfg1yTHqa
	 9cA7nttj7NKX20MGggXOpDvVt1SPiaCfhIXCNgwz5X3RnhSOzzCOG+EiQ+RqfJ16Zv
	 I5azTI4BnjYnQ==
Date: Thu, 13 Mar 2025 11:35:36 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, jpoimboe@kernel.org,
	bsz@amazon.de
Subject: Re: [PATCH v7 4/8] x86/kexec: Add 8250 serial port output
Message-ID: <Z9K0-CFdaBkptAJR@gmail.com>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
 <20250312144257.2348250-5-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312144257.2348250-5-dwmw2@infradead.org>


* David Woodhouse <dwmw2@infradead.org> wrote:

> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> If a serial port was configured for early_printk, use it for debug output
> from the relocate_kernel exception handler too.

Does the early console output something once it's initialized? If not 
then I'd go one step further here: if early_printk serial debugging was 
configured, let's output some sort of message as early as it's expected 
to work. That way if any of this debug codepath regresses for 
relocate_kernel, the discovery of that regression won't be delayed 
until something nasty triggers within relocate_kernel that would 
necessitate a working debug mechanism ...

Also, printing something to the early console using these new 
relocate_kernel printing functions would be an additional bonus as 
well, for similar reasons.

Thanks,

	Ingo

