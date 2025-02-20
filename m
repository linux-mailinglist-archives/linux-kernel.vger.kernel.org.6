Return-Path: <linux-kernel+bounces-523971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215EEA3DD84
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1E33AFD05
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B361D5160;
	Thu, 20 Feb 2025 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgtemQxb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ED9DF58
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063509; cv=none; b=GJEOaQL9E5oz5g41c7zMII8qfwzj+15wtPnoHLnu4VSpS6jUyl2iY3ve/g/tB70JC8klaz5aekxI0v5mtYEnYP7JPwgkE1hg1txIE8/ngY0HYs/e6sqQJ3kFaENCVkw09cde+p8dnAi/SdwXhuCjYMQ6dGDAMh3njaLuYi+PMIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063509; c=relaxed/simple;
	bh=6MFzkfW9uvZannGiDDbpy+c9W2mbwebkRYX+ehbCh+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqseyfEzkqYG9gfO6a8IWZeWOegmjTcXhZVMdq37Ths+8myR3z82l1EWLyNOTiK4qgwOGswXHSSntU1BGuWoAKj/irx2eQ6pHuIxpJ7+QiBRgNvozjz3HBOhSNJ/znzW9y8OxhrPq+c9pxj0X+p8BybX44b84RNraWOSzi8TLfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgtemQxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9732C4CED1;
	Thu, 20 Feb 2025 14:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740063508;
	bh=6MFzkfW9uvZannGiDDbpy+c9W2mbwebkRYX+ehbCh+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CgtemQxbX0vGSFf6F62Qs9d8tJ3l49vaIZ+FLlP8j4sSAQcaEuasFZEbSSAaytCHa
	 EtOYrs2ZlDDZkdjbrb4YRB/r/n2f3PVuOVpIxO/TYflrkCfPwSj11tmQJQ9hFnGRf+
	 pZn35pGsPDfmf24zOkBujRhvjFf/W0mx0lbULES0b3aScauoSYqRbx75Glhd++AJF8
	 +O48buHGN1/ajCIMb6gmRyHnk3HyZWn5DpGKWKSCgfQctl3xIOEMtoMjGugCtdQVqI
	 g2UWyPE5PgVjuBv8k5j1JUpFb835ZLk17uSsNBK43I942yulnoyHtJmsh/qJ/UTBjP
	 cjFnBKqT8busw==
Date: Thu, 20 Feb 2025 14:58:25 +0000
From: Lee Jones <lee@kernel.org>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: lkundrak@v3.sk, linux-kernel@vger.kernel.org, zzjas@gmail.com
Subject: Re: [PATCH v2] mfd: ene-kb3930: Fix potential NULL pointer
 dereference
Message-ID: <20250220145825.GB778229@google.com>
References: <20250213022509.2154603-1-chenyuan0y@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250213022509.2154603-1-chenyuan0y@gmail.com>

On Wed, 12 Feb 2025, Chenyuan Yang wrote:

> The off_gpios could be NULL. Add missing check in the kb3930_probe().
> This is similar to the issue fixed in commit b1ba8bcb2d1f
> ("backlight: hx8357: Fix potential NULL pointer dereference").
> 
> Fixes: ede6b2d1dfc0 ("mfd: ene-kb3930: Add driver for ENE KB3930 Embedded Controller")
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> Suggested-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/mfd/ene-kb3930.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please submit one more time with the following line above the tags:

Cc: stable@vger.kernel.org

-- 
Lee Jones [李琼斯]

