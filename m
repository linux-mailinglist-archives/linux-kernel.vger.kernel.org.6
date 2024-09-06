Return-Path: <linux-kernel+bounces-319503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398A296FD73
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 23:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1572819AE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D3915AAC1;
	Fri,  6 Sep 2024 21:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SH4bQPVF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C9815A873;
	Fri,  6 Sep 2024 21:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725658456; cv=none; b=CYiWFFHdXO/b72Q+6OefscjiDcC/h5AbOmrTT4DSJqAo2nAm2nFhzhnIFga+uzZ/Rgu4lPQmHKi/tvMhtGRMFkfviAP1/9zeHX/taeQDaYpRLhJni/hswDNC2YvB7qUctHB9g+wgLbkmr2WBSfPTKesPo3qwH68p/PtQtfEaock=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725658456; c=relaxed/simple;
	bh=LsqIGW0rsV7PA/R0xtnA8cvL6IwTl0TYb2NNhWWD+gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcczQJgCZXiMA8aI4pEqO4klO7XtUbGGuEDr3ga3uqWemguBwLKyhnd5YMLJZJHdYNsLbbpafW8sUIixLcNCyU7fZ/EgR/nWHU8Cb1BK+Rsyv9+Dt6dv+02mhlwcBx8EuXUzJPg1YMgzz1qZJug1OfRmA9fV+b6ktc0zkKi+dYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SH4bQPVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A537BC4CEC4;
	Fri,  6 Sep 2024 21:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725658455;
	bh=LsqIGW0rsV7PA/R0xtnA8cvL6IwTl0TYb2NNhWWD+gQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SH4bQPVFOKoVzj9dZ63y9w5QXlawr7DaSYhk3RX5UC4WCNyIs7igo96lsO8ceFvSB
	 OL2odBd59sT2FBH2cr09PwheO27x2Nc8vfPVuP44u0tvI43U+eUC1ezadra5UPS9Tf
	 8mHglVvvVxeSNC54ChoLfEZkyxDlbG/TcsKCizkkK6Ub7eMvEXMNOuRAnWbdKcgam9
	 o9PDe+ydof0uukLOND0NAZcgy8yLmp6wxRQ/N5jAOso/iqfIgI3bOgfaWPoEEJhnyu
	 SazBDQ6JLW2H+wbTLqFLdWI+fFHIVQCmJ5FFDJpZP0iPyChd6kbkONotC4d2yg7F71
	 szhnMD6OAAUVg==
Date: Fri, 6 Sep 2024 16:34:14 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH] of: address: Unify resource bounds overflow checking
Message-ID: <172565841388.2236408.1589932943840066610.robh@kernel.org>
References: <20240906-of-address-overflow-v1-1-19567aaa61da@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240906-of-address-overflow-v1-1-19567aaa61da@linutronix.de>


On Fri, 06 Sep 2024 14:25:19 +0200, Thomas Weiﬂschuh wrote:
> The members "start" and "end" of struct resource are of type
> "resource_size_t" which can be 32bit wide.
> Values read from OF however are always 64bit wide.
> 
> Refactor the diff overflow checks into a helper function.
> Also extend the checks to validate each calculation step.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  drivers/of/address.c | 45 ++++++++++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 19 deletions(-)
> 

Applied, thanks!


