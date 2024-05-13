Return-Path: <linux-kernel+bounces-177652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9318C426A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE82F1C216F3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E20153BD8;
	Mon, 13 May 2024 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AryBU4oc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98231534FE;
	Mon, 13 May 2024 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607896; cv=none; b=rmsXlcpKW3IK09WNMwsBfE8cArPZ1xyj+HE61e+BF46Q7pB48TZL2VjG6aUL1QXVCmTT3Zpq6+Uu4npueZ3cCSFWM0LGfqJzGR96AfRtzT3nhGdxSqo8o0Jw90Q0v0IZNKRJLUB9qSZ3469J/wBien+1tl7nAjWHfwBhNRpWRwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607896; c=relaxed/simple;
	bh=n87KKV+BF5dZ/93FCjBaWdbxZVC6KFuXqnr7dqwfO9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDQi0JCQxmZDmfeSPPGhIc0gE7xbToFVjs26MgjkO8FkR6AD6QxAiIvGrgB+zBf8rymbJe+c6NvrwZwXtoweQb3P85LfO48QZEf3CYCMjnmtYUUgf9Jf37ogTOsZpiVMXPHAK3El6hnlQtzmOzls9qtHBCWNHvnQiftFotiVXKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AryBU4oc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F040C113CC;
	Mon, 13 May 2024 13:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715607895;
	bh=n87KKV+BF5dZ/93FCjBaWdbxZVC6KFuXqnr7dqwfO9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AryBU4ocAifL7bA09c9DHou1/vDq9KNXExgVjrCdQTBHE76Yqe9jo0zhooKH8ybNV
	 1v413UT50CSml6IumZti56rDdVYLr8PzKNRuca+lEdqUuoSwKV0BohLTOFEzvp1uiU
	 IW8sGbo/FuicuNtqJ8sG1rL2UAnnCuUIgNZVP3FO31Nalpk/BxvXqQxsN36QYm5F1E
	 sDtRcosdnmSFjD1Ajtq9f/GBTRoVCJaXhTmzw6f7wd+hwHRNi0qW5dDKgiDOs7iOUL
	 16hFYqCg8lUoJQ/1wpWrOKNUsQUclYiwMlgzOaPN15AYBLD6LhzGVnxcqHeS5glEy8
	 qn+H3fHdZmWyQ==
Date: Mon, 13 May 2024 08:44:53 -0500
From: Rob Herring <robh@kernel.org>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>
Subject: Re: [APPROACH 2 1/2] arm64: dts: amlogic: list all slave clocks for
 audio clock controller
Message-ID: <20240513134453.GA2482519-robh@kernel.org>
References: <20240508144259.191843-1-jan.dakinevich@salutedevices.com>
 <20240508144259.191843-3-jan.dakinevich@salutedevices.com>
 <20240508175013.GA2244257-robh@kernel.org>
 <3fa610c2-1f69-41d4-b06a-035980483b3c@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fa610c2-1f69-41d4-b06a-035980483b3c@salutedevices.com>

On Sun, May 12, 2024 at 10:06:23PM +0300, Jan Dakinevich wrote:
> 
> 
> On 5/8/24 20:50, Rob Herring wrote:
> > On Wed, May 08, 2024 at 05:42:58PM +0300, Jan Dakinevich wrote:
> >> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> >> ---
> >>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 27 ++++++++++++++++++++--
> >>  arch/arm64/boot/dts/amlogic/meson-g12.dtsi | 26 +++++++++++++++++++--
> >>  arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 26 +++++++++++++++++++--
> >>  3 files changed, 73 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> >> index 6d12b760b90f..28f4ec5f39b0 100644
> >> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> >> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> >> @@ -1342,7 +1342,9 @@ clkc_audio: clock-controller@0 {
> >>  					 <&clkc CLKID_HIFI_PLL>,
> >>  					 <&clkc CLKID_FCLK_DIV3>,
> >>  					 <&clkc CLKID_FCLK_DIV4>,
> >> -					 <&clkc CLKID_GP0_PLL>;
> >> +					 <&clkc CLKID_GP0_PLL>,
> >> +					 <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>,
> >> +					 <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>;
> > 
> > All 3 cases are just unused clocks on the end. I suppose that's not 
> > always the case. You could just set 'minItems' in the binding to 
> > avoid needing to pad the end and the dts changes.
> > 
> 
> You are right. I mistakenly thought that 'minItems' can not be
> redefined. But not, it is allowed to redefine it and it works. Thus,
> this patch is not needed for this approach.
> 
> Anyway, what do you think about first approach? As for me, it is more
> simple and readable.

I prefer this one as it enforces the order.

Rob

