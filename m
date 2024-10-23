Return-Path: <linux-kernel+bounces-378373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1179ACF17
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64C9F1F221C5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAC81CF5C9;
	Wed, 23 Oct 2024 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="weYPVsfa";
	dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="HlXRoo4z";
	dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="kcWy5FHC"
Received: from e2i55.smtp2go.com (e2i55.smtp2go.com [103.2.140.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C4B1CEABD
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.140.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729698000; cv=none; b=KHGSw5K2fC3tSFAjeVgYtX4svEfdiszan53egyFBSUh9LFUOk5UpZnP0EGbH0T09d2re15IaEcGnLiYSqWgpzFMWghOZ/gPpjiM4uN8/PJU+hXmakUr7JuMZPaELF1hBZyt75Avinu9uwIrbBEPPp6Nh1/GH4SZmN+VOwZNG3H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729698000; c=relaxed/simple;
	bh=FDw35vGF6tl6GWiJ7SwQ87WQQoIjAq+chZGhk2ZdmXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyGbvVjeHJi2F245E5qavrpdQVFAq5Gp+XZlU0IXTXnk4vBqtdto7nYZ2fzk82H6MXfIu9J1nuBztkN8oWQ46yaF6kM6lfD6IGl7u2PqL2asj1a1FckIz8i6ubt2e7ny2Z+647x9AjhuYnekesigsOv4jw+yvRHX9vLNoN2myEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=em1174286.fjasle.eu; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=weYPVsfa reason="unknown key version"; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=HlXRoo4z; dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=kcWy5FHC; arc=none smtp.client-ip=103.2.140.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174286.fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=mp6320.a1-4.dyn; x=1729698894; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=464vsXYS0hOOkK2rayvez/v1qncVJ1hO6GgCfkPidww=; b=weYPVsfak6unaRUNwQg1g6DFzh
	E4jDo/PYxwOOATuQHBzmQryFSI+NOGvzymRvxAIQGN0nUhqcKTgW9FTFeBnlFU74JSSUDhVQECv4a
	8+jMkOIpmYsAnpoqZT2TRIXWrcMSv6PwMg1gqOqcxGqApUkZKP3V4kBc2srIDVziojFOrom7SnhVw
	atXaFCa1fmI63gsKxHA7u9YklHdN/35KkVzqTGXiGuXaIxbix6M6HS3BXvH8Meg+6xANR2zQatw8Y
	wn9WWkLqnRuZZdzSCPvtAnpQKFM1RD9Z8VFWmTjs1AV+jEVYwXW1YX5jfT5pgmXsbIGfcPV89iQTl
	D5P8vEng==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjasle.eu;
 i=@fjasle.eu; q=dns/txt; s=s1174286; t=1729697994; h=from : subject :
 to : message-id : date;
 bh=464vsXYS0hOOkK2rayvez/v1qncVJ1hO6GgCfkPidww=;
 b=HlXRoo4zTscf8B6wlJ9VqrJPrelwD46K00YtiasycZkVGOL6wtDZ0C5h/vtDXrE7BY1jb
 Sdli2AfuQH9+6vbXTYHCNhRAHTB1pS0Ykm+EzuQWRxpb7KOY7O805wYKxCeew2HNmdB3D7D
 FRevHaS5LhVRNUm29TbdEALXkCjiHO+3YUykgfxdzm/Qi/rXUFaEEKNRXuWPbO+09X5OUM6
 xLv48f1eMvRbAj+cOz+wH6J5xBaGyuQmPFf9wLAIdRFBWCyGi4UciWBISu2BEhCzLN3YheR
 FqPFuAuQqsPKU/+yezOWYrRGOn2bQvR6v/tAUldKoeu9Gk9fSHajUEgWwYow==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1t3dSB-cp4aFr-E0; Wed, 23 Oct 2024 15:39:19 +0000
Received: from [10.85.249.164] (helo=leknes.fjasle.eu)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1t3dS9-4o5NDgrgPTO-nPcT; Wed, 23 Oct 2024 15:39:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
 t=1729697957; bh=FDw35vGF6tl6GWiJ7SwQ87WQQoIjAq+chZGhk2ZdmXU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kcWy5FHCHInf1XRg7ovXWYNvkN5R9wGcnzyX8pZbr3/B9FshLLlohhjEG4v55kgxf
 BwuMedehcz0Sn+RfhKjRMtK1qKRD8RehZsoCBnmz7EVGG6bR8INUvwuzeeQo/+69l7
 b+zTmbzxShzjF1F2ufCmxmWza72IdA9jaYBUoDWg=
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
 id 55C3C3D2A2; Wed, 23 Oct 2024 17:39:17 +0200 (CEST)
Date: Wed, 23 Oct 2024 17:39:17 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Ben Hutchings <benh@debian.org>,
 Ron Economos <re@w6rz.net>, Nathan Chancellor <nathan@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] kbuild: deb-pkg: add pkg.linux-upstream.nokerneldbg
 build profile
Message-ID: <ZxkYpWKMA_GIOjP4@fjasle.eu>
References: <20241022181703.1710116-1-masahiroy@kernel.org>
 <20241022181703.1710116-3-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022181703.1710116-3-masahiroy@kernel.org>
X-Smtpcorp-Track: ybF0TiyvdBb7.UJ7mYz2uxqVD.-aezaQXLvO5
Feedback-ID: 1174286m:1174286a9YXZ7r:1174286sf9napyMcG
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

On Wed, Oct 23, 2024 at 03:16:59AM +0900 Masahiro Yamada wrote:
> The Debian kernel supports the pkg.linux.nokerneldbg build profile.
> 
> The debug package tends to be huge, and you may not want to build it
> even when CONFIG_DEBUG_INFO is enabled. This commit introduces a
> similar profile for the upstream kernel.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/package/mkdebian | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> index 93eb50356ddb..fc3b7fa709fc 100755
> --- a/scripts/package/mkdebian
> +++ b/scripts/package/mkdebian
> @@ -245,6 +245,7 @@ cat <<EOF >> debian/control
>  Package: linux-image-$version-dbg
>  Section: debug
>  Architecture: $debarch
> +Build-Profiles: <!pkg.${sourcename}.nokerneldbg>
>  Description: Linux kernel debugging symbols for $version
>   This package will come in handy if you need to debug the kernel. It provides
>   all the necessary debug symbols for the kernel and its modules.
> -- 
> 2.43.0
> 
> 

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

