Return-Path: <linux-kernel+bounces-538403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19412A49834
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2391F3B2BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D3625E81C;
	Fri, 28 Feb 2025 11:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="bMM5WSxf"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8321C54A6
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 11:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740741504; cv=none; b=uAPvwbJ+j4V5XrDMFGAE6MhiSBgmNaYUZnOKdE/vKGietxIiL2ZaRDHNGamCP6KHPP+eG5dJGKG8Ohs9mDoy2UvpCf8RwHmhEVBS+YsxIc8SRJzeMaHAzsehKYJ3dmRx5OgX5vDZSK7udWQbIBoaxHqfhAna4hTYFdSi/EsbhqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740741504; c=relaxed/simple;
	bh=uQTgHoCFKtedWfTENTgJ6xsrJTdimOdPQ9eKGGYbtac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xvi23oOY7YgPPVhA3nYuAPI7VN1O0cS1uMWHGFW2mvZnNQLTr4H0aqC7G12E+rClLztOsgHaIs3DYL9rRb+1T3wwaq3geN6ZmfBO7452wd6fc67mGkLa4M8Z1nijylHWPwhBMC+h1q6dDE4+n8rU/4aLTPdxPEzXAO1Iqcwd1A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=bMM5WSxf; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1D3EF43F38;
	Fri, 28 Feb 2025 12:18:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1740741501;
	bh=uQTgHoCFKtedWfTENTgJ6xsrJTdimOdPQ9eKGGYbtac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bMM5WSxfMbP5DxeYOoJyeh3mcuXzOULdqMS4orWV7Rw/71rP+bvOOP3HHn+bymIyV
	 dt5bkiM/AG/7EWRqLur8/SGMCugfhsvPuc1mzQm6ki8PLUQFx1uKbgGKru09H/ekyh
	 QMRuQn44p53JAQQ0BYCO0kn4/XskQv6nSz1Pzb5IFAkPnsP5aJSfUEQncaTzcnqvmi
	 rI3nOQW7rCjH7Ab9QNldvHHKpJPYj7+nod7E2eqkWAluWMERutzv2+O6PLyoap5pjo
	 JeXPPWpk7K+7Vt/IEZn/FRb5ttDL4JdZaeGRuITeFPdI76997NdJXOGcaIeYxFDfaP
	 ZmpQnuY2CJKIw==
Date: Fri, 28 Feb 2025 12:18:19 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
	will@kernel.org, jgg@nvidia.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH 1/1] iommu/amd: Preserve default DTE fields when updating
 Host Page Table Root
Message-ID: <Z8Gbe6InZ862dn6E@8bytes.org>
References: <20250106191413.3107140-1-alejandro.j.jimenez@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106191413.3107140-1-alejandro.j.jimenez@oracle.com>

On Mon, Jan 06, 2025 at 07:14:13PM +0000, Alejandro Jimenez wrote:
> When updating the page table root field on the DTE, avoid overwriting any
> bits that are already set. The earlier call to make_clear_dte() writes
> default values that all DTEs must have set (currently DTE[V]), and those
> must be preserved.
> 
> Currently this doesn't cause problems since the page table root update is
> the first field that is set after make_clear_dte() is called, and
> DTE_FLAG_V is set again later along with the permission bits (IR/IW).
> Remove this redundant assignment too.
> 
> Fixes: fd5dff9de4be ("iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers")
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>  drivers/iommu/amd/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

