Return-Path: <linux-kernel+bounces-288251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3699537EA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B21AB24213
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008691B1437;
	Thu, 15 Aug 2024 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5MlLt8g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4966B19FA87
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723738062; cv=none; b=uPgPaBU0ij5cGmgYz+PKq0LUKPEmZe5UKai0M67yr6uqX6S1rCV0F09ePzHOi3h/cGsdcztCbqnXbInD2to1nAvfdMhh1Lu8mOowdV1vTWcl/20jAeG+jJvCdKUkt1wdOLYDTuuZ4ZOQcD5LGus1hwaTm/Cvsm+VoM2CKS6k89w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723738062; c=relaxed/simple;
	bh=CqSRzNnvmk1yA3FnJFDSAd2k79a1u4Xej/LtRM+fVZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOFRnb9fHm/uP4zI7IxDrP2dBhkBMUXzEyss3dn5NUCOF+2sO7aWaoN9vi6FOx9JZphSGutYBvrG2eURyJeqZ6Kbv0HQBsqAU52c08WPawiH6ivkaf8ccjMpu/fnMATyu6+Rs7zMij+oDKXX7xa8NLLVP9ghJ/C425XlICcRav4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5MlLt8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1469C32786;
	Thu, 15 Aug 2024 16:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723738061;
	bh=CqSRzNnvmk1yA3FnJFDSAd2k79a1u4Xej/LtRM+fVZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b5MlLt8g3jMAhQ/uLGUNDskKWbJFqHhk9vAY1Va6OS5YfbJRn4R5N/10EnkQBysQV
	 Ix1S8iTh8Wzp3+HNkzlGFUu6RjWGMmpBZaJz1eUK54iuuzAbnvmREFRz8Pf+h9U803
	 Zdd5GH6nG8OSzuymth0PAwdU37rXalmn7f3b3IBjcYxZrmw6g94LCtPpZ9Sgr+lEEW
	 FWPWQjY1Dc3QPOUr4rRHEjNpgpYl8hpRxq7obQVUIGWXtisyCQNxJTQ/tDVFk4hL8H
	 LJYX3+1DHvThJYkak2Z3W9uiHCDVUqhoLY78olT7fJ16LKd2Nm7mYbwJPyk1+ytcJQ
	 /ld0wUa8KUyDg==
Date: Thu, 15 Aug 2024 09:07:41 -0700
From: Kees Cook <kees@kernel.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 2/2] drm: use mem_is_zero() instead of !memchr_inv(s,
 0, n)
Message-ID: <202408150907.5B5C5FCDF@keescook>
References: <20240814100035.3100852-1-jani.nikula@intel.com>
 <20240814100035.3100852-2-jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814100035.3100852-2-jani.nikula@intel.com>

On Wed, Aug 14, 2024 at 01:00:35PM +0300, Jani Nikula wrote:
> Use the mem_is_zero() helper where possible.
> 
> Conversion done using cocci:
> 
> | @@
> | expression PTR;
> | expression SIZE;
> | @@
> |
> |   <...
> | (
> | - memchr_inv(PTR, 0, SIZE) == NULL
> | + mem_is_zero(PTR, SIZE)
> | |
> | - !memchr_inv(PTR, 0, SIZE)
> | + mem_is_zero(PTR, SIZE)
> | |
> | - memchr_inv(PTR, 0, SIZE)
> | + !mem_is_zero(PTR, SIZE)
> | )
> |   ...>
> 
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Thanks for these patches! Since drm is the first user, feel free to
carry it there unless you'd prefer I carry it in my trees?

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

