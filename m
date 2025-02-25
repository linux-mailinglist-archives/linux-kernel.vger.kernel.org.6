Return-Path: <linux-kernel+bounces-531674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B9FA44382
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5D4189FEEF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9186D26BDA5;
	Tue, 25 Feb 2025 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofxdzDoy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFEB21ABA7;
	Tue, 25 Feb 2025 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494676; cv=none; b=CK/2f0bp+ilMS50BecrA/9dS0uXgSRgDeDZXkdzLoEmBi0hd+zD17YBEM0LlI7blSq0w1glJNsUaVsew+gO2TBCLzQQh7u/2L+KMUBijT116SdYn3yODBi57++ZMuKe/aubOMPPoQwhf4SE0a7TibX5WOsBM3JbtrTR4ih+13mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494676; c=relaxed/simple;
	bh=piWag+aE73hC+BAhq7Xjluh+9mTw+B1F5W4G3Q988hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdULLm/bRgnd0NUveDageQhR8N5geXd/VvvoVWmuRIiGPaFAdkBErLd7eyZmp0GDgtpqC1sPFsJim7KFpCasuMk06Z++3k4vC1LR21/m4Vtvyk2PXrz+ny3NGUuzN9w52PGBDLkybAUzPCSwzfMWfetu/45QXEtzH6n0z7SW4DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofxdzDoy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1EFC4CEDD;
	Tue, 25 Feb 2025 14:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740494675;
	bh=piWag+aE73hC+BAhq7Xjluh+9mTw+B1F5W4G3Q988hA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ofxdzDoyNGd20I9eHrr6IZMMhU/f3hyVyhvB0L6O0TndcKqqvQMyGdacmHVGTC4jo
	 /fQ00av2FHYh4HwWpdzJfem0x1QoChMrJ/KfYfyAXHOEn276Pa+4IxJxvuDM+V204T
	 dzUwFTyCT93MpuPk71RHkg2lhfA70asSq7PO5MUmM/NMRjbL1TurzvLxVybsV6Gs4K
	 4/Y/rN3eYbXZzGYZluSbIOq0rtq7vRBaUB9kAyQ9zgJYcA7AiOAq+iXe4EyLuRRhAP
	 73Kp3bTEk0YwBRhURqGaxvA6D+BP2fCFWtdt6OoI+1do6sJlVJIR2lZhdbobb9q7xf
	 C/Y35MrY1Dk1Q==
Date: Tue, 25 Feb 2025 08:44:33 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: devicetree@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] of: Introduce and apply private is_pseudo_property()
Message-ID: <174049458073.2358434.7158444780792381835.robh@kernel.org>
References: <20250224-of_bugfix-v1-0-03640ae8c3a6@quicinc.com>
 <20250224-of_bugfix-v1-2-03640ae8c3a6@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224-of_bugfix-v1-2-03640ae8c3a6@quicinc.com>


On Mon, 24 Feb 2025 22:27:58 +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> There are several places which check if a property name is one of
> 'name'|'phandle'|'linux,phandle'.
> 
> Introduce and apply private is_pseudo_property() for the check.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/of/base.c       | 4 +---
>  drivers/of/of_private.h | 7 +++++++
>  drivers/of/overlay.c    | 4 +---
>  drivers/of/resolver.c   | 4 +---
>  4 files changed, 10 insertions(+), 9 deletions(-)
> 

Applied, thanks!


