Return-Path: <linux-kernel+bounces-424894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F659DBAE9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913AC2820BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3271BD9CF;
	Thu, 28 Nov 2024 15:55:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDD01AA1D5;
	Thu, 28 Nov 2024 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732809347; cv=none; b=CLVzJDgs9zJ8MPtvvupUxdAopZo5qSzIOxtJHSVDwVlX9UK0ljbajssxM40OtA1lY/nRdSQ+HUEEZAgHt6aWPvjcWJC0fuPrzVY7+x1vI2ZoI/NqcWEOb1/eZYEVn39ZrZD0PGxwmtY6kXghQHYbypcLpajwYEoPyA81wRUiYo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732809347; c=relaxed/simple;
	bh=EhiOHahtYnjzms+p/HIrLiSiirGSQXSMhBfzAjTUHJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MlrdjNXmV9NYtVoVri7ag+n9gRkr6tAVWnklpFQIFwBBZktOkUCd6U3/f21WBk37gWM/241A8wWzOcl0IMv4vHcus+cuNM27w6hgCT7xXy36nt1DV22de+zC3NyX4EnXcmt7E9gU4GqXVFP8jDw0gGH0GZtc3XxtQh0qvQKIvZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E91891474;
	Thu, 28 Nov 2024 07:56:13 -0800 (PST)
Received: from [10.57.30.199] (unknown [10.57.30.199])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F36473F5A1;
	Thu, 28 Nov 2024 07:55:42 -0800 (PST)
Message-ID: <e2d83e57-ad07-411b-99f6-a4fc3c4534fa@arm.com>
Date: Thu, 28 Nov 2024 15:55:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: Fix invalid execution of clk_set_rate
To: chuan.liu@amlogic.com
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Mark Brown <broonie@kernel.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>
References: <20240910-fix_clk-v1-1-111443baaeaa@amlogic.com>
Content-Language: en-US
From: Aishwarya TCV <aishwarya.tcv@arm.com>
In-Reply-To: <20240910-fix_clk-v1-1-111443baaeaa@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/09/2024 06:53, Chuan Liu via B4 Relay wrote:
> From: Chuan Liu <chuan.liu@amlogic.com>
> 
> Some clocks have rates that can be changed elsewhere, so add a flag
> CLK_GET_RATE_NOCACHE(such as scmi_clk) to these clocks to ensure that
> the real-time rate is obtained.
> 
> When clk_set_rate is called, it is returned if the request to set rate
> is consistent with the current rate. Getting the current rate in
> clk_set_rate returns the rate stored in clk_core. CLK_GET_RATE_NOCACHE
> does not take effect here.
> 
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---

Hi Chaun,

Currently, when booting the kernel against next-master (next-20241128)
with Arm64 on the Qualcomm RB5 board, the following logs are printed
repeatedly. This issue does not cause a failure.

A bisect (full log provided below) identified this patch as the source
of the log prints. The bisect was performed on the tag "next-20241118"
in the repository located at
"https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git".

This works fine on Linux 6.12


Sample log from run on RB5:
------
<3>[   17.159611] cpu cpu7: _opp_config_clk_single: failed to set clock
rate: -22
<3>[   17.165534] cpu cpu4: _opp_config_clk_single: failed to set clock
rate: -22
<3>[   17.169338] cpu cpu0: _opp_config_clk_single: failed to set clock
rate: -22
<3>[   17.171850] cpu cpu7: _opp_config_clk_single: failed to set clock
rate: -22
<3>[   17.171913] cpu cpu0: _opp_config_clk_single: failed to set clock
rate: -22
<3>[   17.196804] cpu cpu4: _opp_config_clk_single: failed to set clock
rate: -22

------


Bisect log:
------
git bisect start
# good: [adc218676eef25575469234709c2d87185ca223a] Linux 6.12
git bisect good adc218676eef25575469234709c2d87185ca223a
# bad: [ae58226b89ac0cffa05ba7357733776542e40216] Add linux-next
specific files for 20241118
git bisect bad ae58226b89ac0cffa05ba7357733776542e40216
# bad: [864039014c6a549c57796b83f99cc7fe25bf1afe] Merge branch 'main' of
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect bad 864039014c6a549c57796b83f99cc7fe25bf1afe
# bad: [50c7979120c4cff994ea6eaf14747bb0c01a0cd0] Merge branch
'xtensa-for-next' of git://github.com/jcmvbkbc/linux-xtensa.git
git bisect bad 50c7979120c4cff994ea6eaf14747bb0c01a0cd0
# good: [daa20223dee942ebea45bc72b517480af226c370] soc: document merges
git bisect good daa20223dee942ebea45bc72b517480af226c370
# good: [5cc2c18659e40c5d2f93d429d2a4a38234184767] Merge branch
'for-next/core' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
git bisect good 5cc2c18659e40c5d2f93d429d2a4a38234184767
# bad: [618a651f965804164b2f8c446d729197a5fdfd3e] Merge branch
'linux-next' of git://github.com/c-sky/csky-linux.git
git bisect bad 618a651f965804164b2f8c446d729197a5fdfd3e
# good: [d3faed6e9d54a50ad2c505df7e9455752405888c] Merge branch
'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git
git bisect good d3faed6e9d54a50ad2c505df7e9455752405888c
# good: [44ea50e086eb287f923460c0119b95d263ec76de] Merge branch
'clk-imx' into clk-next
git bisect good 44ea50e086eb287f923460c0119b95d263ec76de
# good: [ae7a050d03ca95e8e57bc709af8c5a56d1c1b216] Merge branch
'clk-mediatek' into clk-next
git bisect good ae7a050d03ca95e8e57bc709af8c5a56d1c1b216
# bad: [d6c3666ba425fc5a1a4c938591e89279203a25e1] Merge branch
'clk-cleanup' into clk-next
git bisect bad d6c3666ba425fc5a1a4c938591e89279203a25e1
# good: [7b51444e86d11a346c338a03e96d142fc82b95ac] Merge branch
'clk-adi' into clk-next
git bisect good 7b51444e86d11a346c338a03e96d142fc82b95ac
# good: [5e01124a2c0a42dc6b587b0b09b204a5389f8d7b] clk: eyeq: add EyeQ5
fixed factor clocks
git bisect good 5e01124a2c0a42dc6b587b0b09b204a5389f8d7b
# good: [caabff73ef137ff183e4f6626332eb6b0a886522] Merge branch
'clk-mobileye' into clk-next
git bisect good caabff73ef137ff183e4f6626332eb6b0a886522
# bad: [eb70c83178b25e8d7934c51ba6f1b04da2867265] clk: Fix invalid
execution of clk_set_rate
git bisect bad eb70c83178b25e8d7934c51ba6f1b04da2867265
# good: [ac678a1810665f9820934b89157094afd0975a80] clk: clk-loongson2:
Fix memory corruption bug in struct loongson2_clk_provider
git bisect good ac678a1810665f9820934b89157094afd0975a80
# first bad commit: [eb70c83178b25e8d7934c51ba6f1b04da2867265] clk: Fix
invalid execution of clk_set_rate
------

Thanks,
Aishwarya

