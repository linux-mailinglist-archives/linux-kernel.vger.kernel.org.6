Return-Path: <linux-kernel+bounces-201042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 227308FB892
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60E25B33F6F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCEC63E;
	Tue,  4 Jun 2024 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJ2Apo2Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D091474D4;
	Tue,  4 Jun 2024 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717517292; cv=none; b=MjW4Z0SxbjlRik8bOCGi2MrhbBe/0LR1V6FfeETOQXteOO0WZgwD+DY48fePTj34GBjG6zQ2b6ke9wa5Fgd6EinxkYuQTbYCSe3b/0FPvB4SiRZH2IEYYlgybe0FpBIujlTwIsY3aHn0NLoeZMMc9IYnDgIQOvkjeD8Ekvu8zf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717517292; c=relaxed/simple;
	bh=nei+SOKSc6thGKa4Dt93c6j8LtKtL1IB/f1d/ptLbA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOpkzZq3ERDTBI7rJG6uFrpCl5GSgq8p6kT+vF2rQQcqJAZ9hz1fpfnZ7C93ClNuBaYMTwnqNDChtSGjunnjxG+92KgYeS1ejbIp1TieqtggL0pLbCfJYhQoveulVG7TYssT8/c3biTmDvTE8Ezxb8mlO81vxzM96F2FetwAuv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJ2Apo2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F96C2BBFC;
	Tue,  4 Jun 2024 16:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717517291;
	bh=nei+SOKSc6thGKa4Dt93c6j8LtKtL1IB/f1d/ptLbA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJ2Apo2ZBxetosKifpxr+CgZtwcGzOvva32RymAgiBeGK5SAFdWYjAXt6Ox9SnwJv
	 yUQXKf0TUft3VcdUXaEhCBwcwul2/xfQ17Nx6MTxxAa5fteq/Jg+maV5Ga5LHjsyj4
	 QO1na6Ga3KN1//KwGNRQ5GEFr5yofQAwvZ7H/nxZYQweqFx/qTxF7I4CgKzBMTWPA7
	 E1aH6IUkPebZTUL8qH8IUS1hTNLXV0vPfdCoW4HIdPYnlVDjN1BDor81xWfZVL5ieq
	 4NhS1b+P0C2gRtUmoIA+Gokclp9NcqcsVMkxGE2DGcXDu9uYk/nvGSAIdOiM0yYeT/
	 OWVRm7xZ/aOKA==
Date: Tue, 4 Jun 2024 11:08:09 -0500
From: Rob Herring <robh@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] of: Add missing locking to
 of_(bus_)?n_(size|addr)_cells()
Message-ID: <20240604160809.GA1060206-robh@kernel.org>
References: <20240530-dt-interrupt-map-fix-v1-0-2331d8732f08@kernel.org>
 <20240530-dt-interrupt-map-fix-v1-2-2331d8732f08@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530-dt-interrupt-map-fix-v1-2-2331d8732f08@kernel.org>

On Thu, May 30, 2024 at 08:03:28PM -0500, Rob Herring (Arm) wrote:
> When accessing parent/child/sibling pointers the DT spinlock needs to
> be held. The of_(bus_)?n_(size|addr)_cells() functions are missing that
> when walking up the parent nodes. In reality, it rarely matters as most
> nodes are static.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/of/base.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 20603d3c9931..61fff13bbee5 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -91,8 +91,8 @@ int of_bus_n_addr_cells(struct device_node *np)
>  {
>  	u32 cells;
>  
> -	for (; np; np = np->parent)
> -		if (!of_property_read_u32(np, "#address-cells", &cells))
> +	for_each_parent_of_node_scoped(parent, np)
> +		if (!of_property_read_u32(parent, "#address-cells", &cells))
>  			return cells;
>  
>  	/* No #address-cells property for the root node */
> @@ -101,10 +101,9 @@ int of_bus_n_addr_cells(struct device_node *np)
>  
>  int of_n_addr_cells(struct device_node *np)
>  {
> -	if (np->parent)
> -		np = np->parent;

This isn't going to work... This drops of_n_addr_cells working for the 
root node. Callers wanting to get root node's properties need to use the 
of_bus_n variant instead, so those callers will have to be checked and 
fixed first.

Rob

