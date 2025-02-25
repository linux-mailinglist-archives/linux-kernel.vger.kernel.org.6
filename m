Return-Path: <linux-kernel+bounces-531672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9451FA4437E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD6A863A87
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DBE269CF0;
	Tue, 25 Feb 2025 14:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uobK+4u+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31A521ABCC;
	Tue, 25 Feb 2025 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494576; cv=none; b=dchoHlsUg1XXLS8uXDsGPZGtmQLgCT2Md3q5xNdPTU/CEbB9gXGMCJYtPWsIHWiS3gPjwPjjqVqjlJTSffIjYOS69FvH/pCtOMKs0Tt9/6D2OGLoJ08TrCvJ05gfzv8yNEa5JFX/J7htQ/4sbe7xyDts07ExvYIPxDhm/bYONJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494576; c=relaxed/simple;
	bh=+Rrz6dKLybJ666Hl5ZyN6uqa+5HptLGCNy0acRXjVb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V52vO1dL5A05UqCElRK3LhenSDobr+oZlrnRqpd1Y/uc6C0wRaz8ZQ6iNPmkifkXHt6e+jDzCzj7gbV0KzFlKY9Ut9xl5/YTCiTSEQpEjpNALuwn89kEDWuSqes6JxkniUvjwQpDZRrLr4lLAZq9pW0omVVnYa/mxLQRBSVtpJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uobK+4u+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEF1C4CEDD;
	Tue, 25 Feb 2025 14:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740494575;
	bh=+Rrz6dKLybJ666Hl5ZyN6uqa+5HptLGCNy0acRXjVb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uobK+4u+kcrDBl9pDK/oh11ozIVZknTD64VJOaNxKNg12MY8iAC3cDUvGvDWhdZIm
	 wq9HkF9G59LOVZDfaWCwcm1L4q83C18tzMuUeBznriJF1wHrdvO4h+n0qnGSi9t9ro
	 Adqbayr3luCD0/iScdgaNkANPZNm/i14qZIamc8tYNRTOrJZcRI6pjXNqQcxnsdX9u
	 YXm2KLcZ8glUpuwmq1SSJQgazwcZPbmhYdZSCwg2rqDMr1mfk+Shum5X5ZsSPT36r1
	 AK4zELDqgq0/39zn0fGdEkgDxjI0fHoW8UqCWqTVQ/WOy2pTDKiQm10PiVcOHy0CPx
	 adx+e6fdWr0cQ==
Date: Tue, 25 Feb 2025 08:42:53 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH 1/5] of: Compare property names by of_prop_cmp() in
 of_alias_scan()
Message-ID: <174049456365.2357875.2320414832055737654.robh@kernel.org>
References: <20250224-of_bugfix-v1-0-03640ae8c3a6@quicinc.com>
 <20250224-of_bugfix-v1-1-03640ae8c3a6@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224-of_bugfix-v1-1-03640ae8c3a6@quicinc.com>


On Mon, 24 Feb 2025 22:27:57 +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> For these pseudo property names 'name', 'phandle' and 'linux,phandle':
> 
> Use dedicated property name comparison macro of_prop_cmp() instead of
> strcmp() in of_alias_scan() to:
> 
> - Make property name comparison consistent.
> - Prepare for introducing private is_pseudo_property() later.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/of/base.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Applied, thanks!


