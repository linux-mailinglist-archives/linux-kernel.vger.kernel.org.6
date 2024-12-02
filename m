Return-Path: <linux-kernel+bounces-427278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F6E9DFF14
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41615B2C7AD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDA11FC7E0;
	Mon,  2 Dec 2024 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZISxf7DL"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA421FCFDC
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733135538; cv=none; b=LPkWTmVM9OPN5vv8WXIvAscyx6XbvNnpCjRAZgThr+X4sNZHUhJcIyKW6JtmfMap5Beh58ptR+wYN7ECf6/khC2C3FNjYgbYfEHjzZz6+fspZTl/AkKDi70wF1c54yMRJeqz10O/Mx/oMMa1DIPd60DmOquypDPTTpgdF2YFc8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733135538; c=relaxed/simple;
	bh=ko1lhsUdO/gxKjsyX+tvsyj4tOyMuctUUwwnT5Q9xIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbguxMpBwEbL5rUuNt7N4HS/ZDy+7xvCkFJPXFGCKinobqaY9hFBl/1Ex7fS0ghi8Vsa+FYQ7ZCl8vzqYGJiYdWhsblm9bdXxJgPHmq25h8K67mE08ueJWtV0qaoxiIN5C9ROeJLEHwp0M8HjQhTLcLjUZCXxObvf9RkbrPdCq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZISxf7DL; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2710B40E01A2;
	Mon,  2 Dec 2024 10:32:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uxykHN0koisN; Mon,  2 Dec 2024 10:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733135524; bh=WiCxRKoBdkZGcvb2ic7UOpJ1UPYeFSnjI67Gz2y01dM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZISxf7DLSS4lMO5CXuNn+X2LkCjuHjHiTv24kBb8meth2KIGjCiWsBSgObuSPSdMG
	 IoGTqWhcXEuNHM0YhahrOng2RRwgIHKmIPk3+7+9yOR8E+pEVwvB6tmWOwdL0Fv4cg
	 WPj4B6GI2rMgdnUf33UjPa2txwuZbdio4XF9oA1t7QgKePSwP/oI0uGJi5l1rXCn9H
	 Pb1Bj/OzGMBc5QP9vOyHJCsmchp1jNRgC/8FGzJaJ0fuU48QfOCXG47vJo7xC7Gpfy
	 2B1fKJsLJpesJHS4YKVty0SA66hoGWDMs7fNvKislGBmf/SjvU373/4iujW5v1hsep
	 TDJA6tM/chMBv+gmctFAzeXe7dyA+AEv9BbpAgbrRWHoHielrtXWePeR4D1W2kj8ct
	 uGZmfx7QSSs+AbqZkPph/LB0Lbp6bNksttQaIk+xEEPg6eakpRJfkYQQMS7cUxDF6n
	 xI8XrskuNRTQE/Mf7NCysCyO4Q9fr77JYGb/lsVzhPp4ENGwYnt0xQ9U5EEbN++3bY
	 pVceWukEh2EKEsKLzwYQDljOqV61tMFPpG04okxWNVmGP5aUlOjpPnlCvum3V99N74
	 zxUVZlMdMWIu3bm5E2oX4mnL0vGJr59GFsIlYBJLk/6roQSPF1+IjmuYX9ZQ8H4qia
	 Qogl8mTP7YwGD1elYgxcGyUc=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AB04040E0274;
	Mon,  2 Dec 2024 10:31:45 +0000 (UTC)
Date: Mon, 2 Dec 2024 11:31:39 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Radu Rendec <rrendec@redhat.com>,
	Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen <puwen@hygon.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Huang Ying <ying.huang@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/2] x86/cacheinfo: Set the number of leaves per CPU
Message-ID: <20241202103139.GAZ02Mi53I6XNgSrxd@fat_crate.local>
References: <20241128002247.26726-1-ricardo.neri-calderon@linux.intel.com>
 <1C6C4601-9478-4020-B4A7-47017E9A57F2@alien8.de>
 <20241201224126.GB32487@ranerica-svr.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241201224126.GB32487@ranerica-svr.sc.intel.com>

On Sun, Dec 01, 2024 at 02:41:26PM -0800, Ricardo Neri wrote:
> OK. Should I post a v9 without the tags? Perhaps I could wait a few days
> in case reviewers and testers want to chime in.

Yap, and then I can collect them all so you don't need to repost.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

