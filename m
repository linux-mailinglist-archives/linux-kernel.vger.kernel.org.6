Return-Path: <linux-kernel+bounces-421945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 377919D9272
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00CD2839CF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D25192D89;
	Tue, 26 Nov 2024 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTfEGcwy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EB6187FE0;
	Tue, 26 Nov 2024 07:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732606151; cv=none; b=CfWsrGfOsOwP8A5OG28R46rxEcbzV1Zb3Q25aCCu//0yu2/Ahuxxm0z+SXKplAUl061b7XjUc5kATC7u5WoapTEnMEAPSvNAk/iZsqFCI3NjiBTAwkh7rxOWKodRZDthSbcnxD7j8QwZr3UIqxtTCmOQXdPYJTUc97Gf2oUTBFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732606151; c=relaxed/simple;
	bh=Mcu/a5c69/Xbyw1swe4mti/DRiZDVPWbHzcwyN7POHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xn3q81d8KCgF+S4lsdqCKuY6wEeKKtDMLlEfYtIaya9iQClW1UaR+vi1eokLkYLFdK/lOFjTkV/ycmMSce0xyKZYK6NJpcYc3pDImg/eUS04+boWh/jl93cC4TAhUD37IftNczHlO7QbmGNbPO7NPMTYx3Z1a92ACRupN31f7K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTfEGcwy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A840C4CECF;
	Tue, 26 Nov 2024 07:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732606151;
	bh=Mcu/a5c69/Xbyw1swe4mti/DRiZDVPWbHzcwyN7POHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TTfEGcwyHYaYOCmK8LgynQPv+TntjLfujCqlGGu0v+m4mM0y2NrDQRTMskqiMIhYH
	 D8UhKV+KW0EnHGi2uLGCSPIgQYHHbn0VFg/7JXJi0fe575GtrtNO+i721Yom8Offae
	 5SR+eLm++GjdwBnedkejdssmDrme7ea1CD/F+qkjut5400Eo3Wz79k0WfPaVk+Bvh7
	 vEUIHyE6F+PHPQ5KTBCmDK+WPHbQPINNP9DWzOY9Bz5wAkcm4HctzN3VAth78vAEqp
	 futWnsPVCc5p8r0g8avVc++AinInL1YW0FTYKJ1ZL+IJ46a/sKv7vbl6nybLmAs391
	 cYH9aS8gxr8Yw==
Date: Mon, 25 Nov 2024 23:29:09 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/10] Add jump table support for objtool on LoongArch
Message-ID: <20241126072909.nyvqagvmtnivh36w@jpoimboe>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
 <CAAhV-H6B_-y6ebR=GJmazzukW8Ad-=VRJPvT=ZF+41+rTX7D1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAhV-H6B_-y6ebR=GJmazzukW8Ad-=VRJPvT=ZF+41+rTX7D1w@mail.gmail.com>

On Sun, Nov 24, 2024 at 01:33:43PM +0800, Huacai Chen wrote:
> Series applied, thanks.
> 
> Huacai

Please don't merge any objtool code without maintainer acks.

-- 
Josh

