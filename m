Return-Path: <linux-kernel+bounces-521517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4325A3BE5A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1012C16AEBD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D677F1E0B66;
	Wed, 19 Feb 2025 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGeFGOHz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1EE1DF974;
	Wed, 19 Feb 2025 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968978; cv=none; b=IbtQNhstcpu8v+kY9TDI5s1V3pb7hRS0ED+wUTh9MvcHL/LAwJG+O+wCDP7Mh7mNkKlLSuqacdvmataU5yO9wwDY7yABSuroQABMZ/BdWnsVevmHig3wtbOnyeur+r54HrXrrfSlxFJMtI4ImlU2vECNHewS7tTgioKAcxCiBPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968978; c=relaxed/simple;
	bh=N2b5YBiD8Ug5lGLd2YA1Nf4Jy8KFodB2IWP6M3MqESA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0W9q0Av7cH4Ng8oRBIsP0w3EbRt3L78Joz0SRbwZpLdwNipRF5gFWvuPpWISbqtQocnEU0DUW/tVromnZSmU+WRCECPrhVmGaEu3ys3x5pMUb5Lkq1vh1LEO0KmxLP7zVxpOTDmnarb3aEy8I5C3D7VPXlxl2BICudy4WCvM7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGeFGOHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FD3C4CED1;
	Wed, 19 Feb 2025 12:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739968977;
	bh=N2b5YBiD8Ug5lGLd2YA1Nf4Jy8KFodB2IWP6M3MqESA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jGeFGOHzVoXR1H+/EtbaT9FQlUjfFd77IA9AsEy/0dGqtMJ3ngfjxFZXHjqv7iZZq
	 v2l5zc4+pHmSZyKZ18phjDlRj4/cShDiSkoFpS1gFRyJaC9OoHryzxP3RKd4H4e8sP
	 p7KXitCvSasc0c5GuNlicLnx/q9jZjpXVF55VyrXELYmgjZLMaQM+XGxtxxjS+kkL0
	 uspFOaCczSXc6Qedemt6gBgoXI/tl81l1hHE4iC2JkxMrbveo9ad1fH1mZsReiiYTD
	 bCNds8Tge5SqhRFFAvO5beT+26ZzdiLFe6moNAnX+jxXwbyh731Og4UInBfhszkCdc
	 oE9vPnLdMo4hw==
Message-ID: <5d96608a-8ed6-4b23-a725-ba7a8476a1c5@kernel.org>
Date: Wed, 19 Feb 2025 06:42:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] clk: socfpga: stratix10: Optimize local variables
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250219104435.1525-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20250219104435.1525-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/25 04:44, Thorsten Blum wrote:
> Since readl() returns a u32, the local variable reg can also have the
> data type u32. Furthermore, mdiv and refdiv are derived from reg and can
> also be a u32.
> 
> Since do_div() casts the divisor to u32 anyway, changing the data type
> of refdiv to u32 removes the following Coccinelle/coccicheck warning
> reported by do_div.cocci:
> 
>    WARNING: do_div() does a 64-by-32 division, please consider using div64_ul instead
> 
> Compile-tested only.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/clk/socfpga/clk-pll-s10.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

Applied!

Thanks,
Dinh


