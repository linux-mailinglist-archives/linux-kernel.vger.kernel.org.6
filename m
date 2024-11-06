Return-Path: <linux-kernel+bounces-397714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9F09BDF69
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A9C1C22C61
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E671CCB2D;
	Wed,  6 Nov 2024 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UOWQFnyz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC96A192580;
	Wed,  6 Nov 2024 07:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730878074; cv=none; b=ssffImeJigkjW4/1U0NA7ZRBWevAC1pCIKYZ3uHSC/3Pz3xiHhp1E/10zvnjOeFJ1jE0DtMCQZPxe6goibkkr/xf/glzklCeq2+wZwp5pAKs1kJvGdgtzAqXTAtsU/s9dhUsLBqEmEG5Y4oC2sdJkpyz0p//G7zd4KQTO7JwGBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730878074; c=relaxed/simple;
	bh=/A+HW5n513t0yCsOgKDg7mmDaz+/dgCUyIewoSqhw3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZkDM3OXe3jSqYYxx1/pBtsX69bK9qG6jBcguR8x82lmWKePB/kQBKAy7gmFu/rytOsXIX4yF7ONSPBhX+riA0aB0V54VF3fXdxuBWdxWm2g51SIv2tlBEYC6TIgoVINKN9CsOYtKdpWV65bd6C2KrfjZ5XIY0F9i/W7+Iwj2FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UOWQFnyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5000FC4CECD;
	Wed,  6 Nov 2024 07:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730878074;
	bh=/A+HW5n513t0yCsOgKDg7mmDaz+/dgCUyIewoSqhw3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UOWQFnyzskQjvmkwESYXS95F8PYnz43quEZUT0hPx+QHRAcW4FEzQ073OvBqUjNOj
	 Z4pb0HtFJyigHWmV6ASSqNePBsnCghlHoejx2OExzRPmeb4UCDTZR3prHJ0KnNAlA+
	 Af9OYw6JYU0sycb4juok7/N5g6h94ysvhF0ytqd0=
Date: Wed, 6 Nov 2024 08:27:36 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev, Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y] LoongArch: Fix build errors due to backported
 TIMENS
Message-ID: <2024110622-dejected-underfeed-ac4a@gregkh>
References: <20241102033616.3517188-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241102033616.3517188-1-chenhuacai@loongson.cn>

On Sat, Nov 02, 2024 at 11:36:16AM +0800, Huacai Chen wrote:
> Commit eb3710efffce1dcff83761db4615f91d93aabfcb ("LoongArch: Add support
> to clone a time namespace") backports the TIMENS support for LoongArch
> (corresponding upstream commit aa5e65dc0818bbf676bf06927368ec46867778fd)
> but causes build errors:
> 
>   CC      arch/loongarch/kernel/vdso.o
> arch/loongarch/kernel/vdso.c: In function ‘vvar_fault’:
> arch/loongarch/kernel/vdso.c:54:36: error: implicit declaration of
> function ‘find_timens_vvar_page’ [-Werror=implicit-function-declaration]
>    54 |         struct page *timens_page = find_timens_vvar_page(vma);
>       |                                    ^~~~~~~~~~~~~~~~~~~~~
> arch/loongarch/kernel/vdso.c:54:36: warning: initialization of ‘struct
> page *’ from ‘int’ makes pointer from integer without a cast
> [-Wint-conversion]
> arch/loongarch/kernel/vdso.c: In function ‘vdso_join_timens’:
> arch/loongarch/kernel/vdso.c:143:25: error: implicit declaration of
> function ‘zap_vma_pages’; did you mean ‘zap_vma_ptes’?
> [-Werror=implicit-function-declaration]
>   143 |                         zap_vma_pages(vma);
>       |                         ^~~~~~~~~~~~~
>       |                         zap_vma_ptes
> cc1: some warnings being treated as errors
> 
> Because in 6.1.y we should define find_timens_vvar_page() by ourselves
> and use zap_page_range() instead of zap_vma_pages(), so fix it.
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/kernel/vdso.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)

Now queued up, thanks!

greg k-h

