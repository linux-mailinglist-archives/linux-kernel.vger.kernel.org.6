Return-Path: <linux-kernel+bounces-521944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9344A3C425
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CA4C7A4F22
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC991FC0F5;
	Wed, 19 Feb 2025 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m0POihFq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45401EFFAB;
	Wed, 19 Feb 2025 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980338; cv=none; b=DXVdw/TpymRnsagiBCJikcvOxL7fZdHwAOz/CXHPtn8Gzgj4oWiK7NyQ3QiQnsTL6MZqUY2LJho7bBDYqMWxGmc6VTAvs7Rz+6gMfQSFqZ9mSkBWTPJdSMfmyjl6xeNic+miHR6fljOBVWjpoUb0hUXeLUL3aFhYAMWw4wtQgs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980338; c=relaxed/simple;
	bh=vGCZAqT9hz+4wWL3g//rfYKEYTrNorKguYAWiUhPgDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqHyoojtb7HqWuD15CnaVo4CucnYX7i/u3W1Mw9GyK4AKOHNBdE/XXLPKTAXTidY9B3aOewWImslw7G2R3TQU+l8PwPLFWpzynPl/o2JpaqVJ56buWsmZni8vBm3x255Cbbih90DhbVWQ6lLTk7D0LcxhK6c45MXNoECLxOE9so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m0POihFq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF10DC4CED6;
	Wed, 19 Feb 2025 15:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739980336;
	bh=vGCZAqT9hz+4wWL3g//rfYKEYTrNorKguYAWiUhPgDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m0POihFq1/O5dOBEpojbWiyVOlGtWwRZretEFsZKsMLFQVGUnVVksdI9ibg0hhC3V
	 3pCUrsc1rAguxAl3rJak5tvSBzv2yto5Kwym+5McZo/aRAsx+mpnojS1wTpSL8Cxgu
	 OvbESJIXQ2rJmeWSkpGLUSSVIo/jYLLc7Ou/Wlv0=
Date: Wed, 19 Feb 2025 16:52:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ravi Kumar kairi <kumarkairiravi@gmail.com>
Cc: dpenkler@gmail.com, kuba@kernel.org, rmk+kernel@armlinux.org.uk,
	broonie@kernel.org, arnd@arndb.de, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] staging:gpib: Fix error message formatting and
 adjust memory allocation style
Message-ID: <2025021908-fraction-impulse-7bcb@gregkh>
References: <cover.1739794938.git.kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1739794938.git.kumarkairiravi@gmail.com>

On Mon, Feb 17, 2025 at 06:26:15PM +0530, Ravi Kumar kairi wrote:
> From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
> 
> This patch series includes two minor improvements:
> 1. Updates the error message format for invalid base I/O addresses to use hexadecimal notation.
> 2. Changes the memory allocation style for `private_data` to use pointer dereference rather than hardcoding the struct type.
>    which is perfered by checkpatch.
> 
> Ravi Kumar Kairi (2):
>   staging:gpib:hp_82335: Fix error message format for invalid base IO
>     address
>   staging:glib:hp_82335: Refactor kzalloc size calculation to use
>     pointer dereference
> 
>  drivers/staging/gpib/hp_82335/hp82335.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> -- 
> 2.48.1
> 
> 

No longer applies to my tree :(

