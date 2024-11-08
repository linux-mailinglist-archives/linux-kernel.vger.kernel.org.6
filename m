Return-Path: <linux-kernel+bounces-401670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0D69C1DB9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DFD41C22D1C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BCC1EABB2;
	Fri,  8 Nov 2024 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIVivLnF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96B3C8CE;
	Fri,  8 Nov 2024 13:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731071729; cv=none; b=IFEEkgyGfJ3IjqCnxRxM4su9vEqKdeyFreRM3wjdmnu6ZWcbFRkAqPdc0rO/UkHhpLfrsaKVSZFIc+CsAQbJwFJjD9rGeZU/82cL5L0lrc/IipTtfJm1pozJAYHuM6JcL/16v49w0YRbmevHuwL9FZwhfva5NUMGKlzDF75NJ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731071729; c=relaxed/simple;
	bh=mSeGncNFKtK9hy+rJgXDlS6AGgK9Ibz8GvNuTiYk7TI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMvAkl2CbqZy2OUsYXNY4Vjsxmz2n8/8mqhLYzxGeWqZfiVneHI3GMe4VF/IUp2av/W/lct2lvzF524wLjzwdlGhQGXP+yRXZslyUVkUo2eXCaPurTrZe1donjZWAKZOjIKQ4WrmmyHy1PdbV3NhZZ7efN+vV+WaGf5f/YcyTvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIVivLnF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFA0C4CECD;
	Fri,  8 Nov 2024 13:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731071727;
	bh=mSeGncNFKtK9hy+rJgXDlS6AGgK9Ibz8GvNuTiYk7TI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nIVivLnFFsFMeNsY5Rpgo291/7sQLhmov713rmRKVwfOIKSx/CSVPoRGIsoh3Tg9e
	 FLukWyZA64TZ/iCW5imXYsoYN50uoyQ9k/b7MX7WjqIgMytUrmJK7emSZJ9YvdIM8I
	 e8eHmDI8UBiY/NCCHmxE6XHFYo3DYLLsq58UXEPNfRaGCCXtEpEHI0N/sEEEJhfQ7E
	 Rs4H1Ff85FvJITFNslXzJyPWfxsMGTkIMck1PIvDquOkO8LUGoScz/4n4/q1+MfdBg
	 CMae7pQYaUchHPUD1OMjiP+qsQ7l4lRQvhTZkvdKi7ZxNP6E49vzK2YQ/sf/x11Msn
	 yXZI29sL8yYZA==
Message-ID: <aba3bcb7-3144-49c7-8acd-added30bbfdd@kernel.org>
Date: Fri, 8 Nov 2024 07:15:25 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] clk: socfpga: arria10: Optimize local variables in
 clk_pll_recalc_rate()
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241026155304.159716-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20241026155304.159716-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/26/24 10:53, Thorsten Blum wrote:
> Since readl() returns a u32, the local variable reg can also have the
> data type u32. Furthermore, divf and divq are derived from reg and can
> also be a u32.
> 
> Since do_div() casts the divisor to u32 anyway, changing the data type
> of divq to u32 also removes the following Coccinelle/coccicheck warning
> reported by do_div.cocci:
> 
>    WARNING: do_div() does a 64-by-32 division, please consider using div64_ul instead
> 
> Compile-tested only.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/clk/socfpga/clk-pll-a10.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

Dinh

