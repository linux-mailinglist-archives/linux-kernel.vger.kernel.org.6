Return-Path: <linux-kernel+bounces-365705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852BE99E6F2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B783C1C25843
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E1F19B3FF;
	Tue, 15 Oct 2024 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2P4o4Du"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1B01AB534
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992843; cv=none; b=noItYcYxbpf2stQnvFFMPoR3GHd+eO4UgQCWqTLkyIPsLD/ihbOLi6o+blK+rmSvfKG7LQ6UDHL6yFZhJ8k0wPoFSrYbRp8KVIinN+IuxIWERmg+/apstPmBY0XOvBZKcw957sI/Hwx780FIQaliGakTdo9Oac3Tu2n52nw/YmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992843; c=relaxed/simple;
	bh=YPbiicurnH1dDhqb6FYnrHy2d2a+IagWqrjbCs+mflM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VCQfxaRiX5Hds2pRY6S9rS2ECRzIB+A9dWpaEEkff15GCjTMds4XdelftHwB0R5bzGdP9lUeuzWDubAtTOf4ej012IfvBHdMVwBI4ZaAyteVZry7/PKup10xjsBi9B57nQE5bkq326WqP6OrYlEb/tVFgYIMXfrXcazex2UT9do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2P4o4Du; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867ADC4CEC6;
	Tue, 15 Oct 2024 11:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728992842;
	bh=YPbiicurnH1dDhqb6FYnrHy2d2a+IagWqrjbCs+mflM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Z2P4o4Dufu4e2X8yqYcxKbC0bLxAhhO91HdiyF7wF7Vz4cth8k0KHFxlE3sKnHmvz
	 qzaAfVsLtBT8vEMI34Dcn5R38mtldxxC0jpBE00ANwemaoSHL/VFZC2YvxnB0J2XSA
	 fxQgP6N9T+c1/kuwh1Qj3X/Vkj4DS6Fr958ngz7ClzewG4lItuXBLfRwQNg9jthWah
	 A2lbd1p83UHKZXUalReRiiiHkIkfZzIF5PXicf9C5Rak/dol2pStaY+OVTHXgtbBex
	 G7En1VyNL4HMT52sML1mrt15NeaMXNTu3vAQkBm6NfZBHbWarlhImn/PSjm8kF4yp2
	 q3c9gJc8GXXeA==
From: Lee Jones <lee@kernel.org>
To: linux-kernel@vger.kernel.org, Dragan Simic <dsimic@manjaro.org>
Cc: lee@kernel.org, heiko@sntech.de, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Diederik de Haas <didi.debian@cknow.org>
In-Reply-To: <08d4e88974c205eba124086ce156622e2e4cdc20.1728397516.git.dsimic@manjaro.org>
References: <08d4e88974c205eba124086ce156622e2e4cdc20.1728397516.git.dsimic@manjaro.org>
Subject: Re: (subset) [PATCH] mfd: rk8xx-core: Check
 "system-power-controller" first
Message-Id: <172899284126.514208.13664393546425275514.b4-ty@kernel.org>
Date: Tue, 15 Oct 2024 12:47:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Tue, 08 Oct 2024 16:30:10 +0200, Dragan Simic wrote:
> Commit 961748bb1555 ("dt-bindings: mfd: rk8xx: Deprecate rockchip,system-
> power-controller") made the property "rockchip,system-power-controller"
> deprecated in favor of the shorter, universal form "system-power-controller".
> Following the updates to the board dts files, [1] make the favored property
> name checked first, to save a few CPU cycles.
> 
> [1] https://lore.kernel.org/linux-rockchip/20241008105450.20648-1-didi.debian@cknow.org/T/#u
> 
> [...]

Applied, thanks!

[1/1] mfd: rk8xx-core: Check "system-power-controller" first
      commit: ebced0587bacdce9a69adbc289ec1c35c1c6b85c

--
Lee Jones [李琼斯]


