Return-Path: <linux-kernel+bounces-377847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB1D9AC7A0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C92B28263F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39E319F46D;
	Wed, 23 Oct 2024 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOC2hJm0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFDE1509A0
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678764; cv=none; b=Hheh1xqBvZII3BvCm1mZ/1YR2fPacc35zV7AJke7/HaHRh7VyMTm/DyguNPkaCWTr33LBRtP5i6YN6dciG6dM4b7Y/l2T6GAobya1/6/05KRJkHB0k3RqAfeiqn+HHEC/JsH+zBoLUR+MWbPdWBTv+Im60JD4wEOFQ8E90ShrRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678764; c=relaxed/simple;
	bh=mWCRLSJj/TvXUSkpen0uTAfHbeXIjD1El7HiqxuVzPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGGFRbzzbzULFJ44JtJpYk71mcKrvC7Yd38vt9VshEHeopoyEkw62ITVI/XOXrX3pi03webKxWAB+SlDrHdnAJDGGN3LxQChTKlBI/4UdnstV4OX27sIsIqn+M2c5qPvpwypxqpM5lZaH+wkCML/sOeHzx17v4ppUuIeoRkUcQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOC2hJm0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D5FC4CEC6;
	Wed, 23 Oct 2024 10:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729678763;
	bh=mWCRLSJj/TvXUSkpen0uTAfHbeXIjD1El7HiqxuVzPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aOC2hJm02CUZwfjyJ6E0eK7PY/Ts7s++pEFYj8jtwQ6cIkvEcQcHFpbIjAiq4xKbb
	 CkMlDGPGBsEkox4QetJ1cx/wfQmjoygjiZutXJRACrmaoEj0cKp+ZMemReebNDwHRj
	 IsjOkfQrHxfR0UNNAMAK6iC6v+o0R/21YQa+Safid+vxUNAKI1FoSoh4G8qYr4+Jwq
	 q+yb0RwTP5ZU7G9KAu1/RDkEat/d5BbzvA8g3aCq3sDOF5Sq1vFAfUbTxho3/8jiAE
	 NPoGCyMHqhsRBwjQgYPgy4bhCM5B/LRgRUjLXn4BeC5MoMTXQDUKAyJqnkoiLfGDZT
	 6/GPFdZ36PsGg==
Date: Wed, 23 Oct 2024 12:19:03 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Joel Granados <j.granados@samsung.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ucounts: constify sysctl table user_table
Message-ID: <krio6coieilcbe43cikb3r2hnm2cdve3no6eztgd74dgzzgflv@sy2ehddvy4jm>
References: <20240825-sysctl-const-ucount-v1-1-b4e9277c62a1@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240825-sysctl-const-ucount-v1-1-b4e9277c62a1@weissschuh.net>

On Sun, Aug 25, 2024 at 12:53:14PM +0200, Thomas Weiﬂschuh wrote:
> The data of user_table is never modified,
> but only used as a template to create copies from.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> kernel/ucount.c has no proper maintainer.
> This patch is meant for the sysctl tree.
> ---
>  kernel/ucount.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index 8c07714ff27d..4f6dd1a30117 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -70,7 +70,7 @@ static long ue_int_max = INT_MAX;
>  		.extra1		= &ue_zero,			\
>  		.extra2		= &ue_int_max,			\
>  	}
> -static struct ctl_table user_table[] = {
> +static const struct ctl_table user_table[] = {
>  	UCOUNT_ENTRY("max_user_namespaces"),
>  	UCOUNT_ENTRY("max_pid_namespaces"),
>  	UCOUNT_ENTRY("max_uts_namespaces"),
> 
> ---
> base-commit: d2bafcf224f3911b183113b2fcb536c9e90684a3
> change-id: 20240805-sysctl-const-ucount-5da084520770
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>
> 
Makes total sense.

thx

Signed-off-by: Joel Granados <joel.granados@kernel.org>

-- 

Joel Granados

