Return-Path: <linux-kernel+bounces-218308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCD590BC5A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07CDE1C22C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3429198823;
	Mon, 17 Jun 2024 20:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="PxYk1Iam"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA917492
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.40.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718657443; cv=none; b=KUut4Gf7hb+pakOl5tsoZCefVqvRka17rM9B7bOVdT/IGV7lr19VmI+kDcDeHALC7XqgufrMo4j4OANO56cogxzv8J+u0R6N/hO/Gucz92peaf9n+ktnKmAFZsIqLiFdxvGcLry3XyslgUq+Cbv1cTaFcnx0bVwDuO4hBQwPrUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718657443; c=relaxed/simple;
	bh=zTsAYl2uFIKstL2dBaOpyYeryqx0Fdvq7tfYbSW4sMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhIkOaH0U8FEh1ZtETok4OSa0dIfoWzNOiSuL/iC9/rPPArbue4MsqjIcDIh+D7AskA3I+LuYLe2zqF/8W2kTO8V5J0KHP6dFFB87NqUOMo+LEBHOSdLm2g7oS33ngAF6nkXt9//StGq1z2llSWhwLLemwce+QYs6TFo4/aLON8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=PxYk1Iam; arc=none smtp.client-ip=167.172.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1718657414;
 bh=MdDBTGJOD4DdU6inKQlvAasJgqrrJixgcL+TEIP3eQw=;
 b=PxYk1IamHYUgmtr0pYTSbeD9f2l8ivE953U5ON6Q0l+AbNsV7h0T6+Bweph6P5Kh89wM8EaYd
 s0aegGRFeyX+rsdR6mr1f0x93RnQ1yp0OaTABCedjE3rShZW2F9WFQ7sESTuXhBMg19qj8y8M5r
 cOx+rwmLBp90yz2CHWFCpEyeJ+vu/g/v4qCTZsvehuW/WFZsCZbeiNdIOKMV3QONIkc3b4yC87z
 OC9m+6YNmaizp4IFqgKJZjwnBwwBMT5/6tF86fFM5oUqEuIhLw9rACfsMLZGzlF0cT8fiFALyWs
 6Q7JQhHes0bYZWQdpW3P1vmuuRg6KawNYxNcRZip8LLA==
Message-ID: <6a2293ec-1506-4fe7-a3cf-fcfc594c19cc@kwiboo.se>
Date: Mon, 17 Jun 2024 22:50:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] clk: rockchip: Set parent rate for DCLK_VOP clock
 on RK3228
To: "=?UTF-8?Q?Heiko_St=C3=BCbner?=" <heiko@sntech.de>
Cc: dri-devel@lists.freedesktop.org, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Yakir Yang
 <kuankuan.y@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20240615170417.3134517-1-jonas@kwiboo.se>
 <20240615170417.3134517-3-jonas@kwiboo.se> <19757196.sIn9rWBj0N@diego>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <19757196.sIn9rWBj0N@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 6670a183c06db152bdd50c23

Hi Heiko,

On 2024-06-17 22:30, Heiko Stübner wrote:
> Am Samstag, 15. Juni 2024, 19:03:53 CEST schrieb Jonas Karlman:
>> Similar to DCLK_LCDC on RK3328, the DCLK_VOP on RK3228 is typically
>> parented by the hdmiphy clk and it is expected that the DCLK_VOP and
>> hdmiphy clk rate are kept in sync.
>>
>> Use CLK_SET_RATE_PARENT and CLK_SET_RATE_NO_REPARENT flags, same as used
>> on RK3328, to make full use of all possible supported display modes.
>>
>> Fixes: 0a9d4ac08ebc ("clk: rockchip: set the clock ids for RK3228 VOP")
>> Fixes: 307a2e9ac524 ("clk: rockchip: add clock controller for rk3228")
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> 
> did your mailer have a hickup? Somehow I got patch2 (only this one)
> 2 times
> 

Strange, not something I know about, each patch 1-13 are listed as 250
Accepted (heiko@sntech.de) and patches arrived to the ML and patchwork:

https://lore.kernel.org/all/20240615170417.3134517-1-jonas@kwiboo.se/
https://patchwork.freedesktop.org/series/134926/
https://patchwork.kernel.org/cover/13699322/

Regards,
Jonas


