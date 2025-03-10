Return-Path: <linux-kernel+bounces-553923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2A9A590AE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C93E188CA48
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74A422577E;
	Mon, 10 Mar 2025 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PZstQ6vC"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FFB2222DC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741601042; cv=none; b=lf/AeSddWXpIy1U5qftgtBXV/lqn6EOV/YUahr7oX3LibaDaUAaJ49duca7NYI3RbHDUayNkNMhBWIXjPKNtMM9YPKGnc8BpEGD7i8RLAGJTrcxayg7jgRAQiZlwQcd0X901p+pFuqyVk3KtyOVZ7vYXRpM+I0+0RT4xc6oHmHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741601042; c=relaxed/simple;
	bh=H/S3Y44N4VAuIcWo8Ihrabio+errHBpuSbSPjm486UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGDKY/Z/qkO7C6KcWY8427SC4bc9AIGEpEipKUDQDUFOj8gBMP8pKYwDvRb9SWRKmytT8FkSRtMCHPl3+oLFaEtyy8ZK2gP+xfqEVzoMojsSjcJazF92QBOV5txs5EcbBDcO4XFm54vGg6kr3jJFPAUHyuH0BLVSpntvuPZIQEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PZstQ6vC; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A9A0A40E015D;
	Mon, 10 Mar 2025 10:03:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KL1VY6luX7D2; Mon, 10 Mar 2025 10:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741601033; bh=Cs9A1juJp8qHBfb4SkRCxvjenGctob0HC20wRc/Sqyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PZstQ6vCKP6sGJ0Wjmq6ZKvKQ73yNH2kugrf+kmQ0NCbosquCQZpSPduKKZZ7U8L2
	 fYe239Mq02yWzWQ7IS+YyJ5LhrmCUzkbmDM0VrcZs/VlG7nrDnmoJE3Lh/Us/0z0JE
	 T6qTOdyumBvZ+KvpAtUphdqUz2X1IFER0Ix5hQ7vD18YLdJs3fpmbykZpu3xbtH0Yg
	 5w5EidgYGDlicQT/MQxrcGtXlHiPaNEA0NbzRO5UB0pHoko/CRdUlLbv95vDt0/wcA
	 47OCNJKctntq/rrFKo6bx0WBNSuNINlXMv7UBRxF4lpleB1gl5MeXOOv+3+2wD+fUn
	 intXxJDBJJePNbubUFIKIfjk5rXsqC/ly/uZilBdmsMzLSBS/r/4+gZCgLgQgzLyEc
	 oq5IZcu0afue77zF9fuaJ2eDz0peaBNPNqrDHElZ2Z9pFd09xWFmiyAvjQtAMCa1i5
	 9dL3fU2+UokW55aOA2ff3Lojyjx1l5zdD+vVHt9C7qskQi47bRCHamDZpMckbyX59T
	 sTeoh3DQwy5/NO4wV2SbrPEwKwMFGSVnzNFHyvTRRJyvWoMcGDA+RIJ3zkRv/qK99m
	 vi4HIeGL+G/VtGa9my6FRbqHnmPjw2pWSya6dkb3ogWFvELQma8nVfvE4Weyd208RQ
	 g2aBsmqi8Y8PloqsPADfSKMs=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2EB3E40E0176;
	Mon, 10 Mar 2025 10:03:50 +0000 (UTC)
Date: Mon, 10 Mar 2025 11:03:43 +0100
From: Borislav Petkov <bp@alien8.de>
To: Avraham Hollander <anhollander516@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: microcode: You should not be seeing this. Please send the
 following couple of lines to x86-<at>-kernel.org
Message-ID: <20250310100343.GAZ864_yV_vqXUCFQw@fat_crate.local>
References: <CAP1mzZS7=Vpc0wXeD259S02WP2KTHd3CcnwJrKqzxBJTVZ-b_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP1mzZS7=Vpc0wXeD259S02WP2KTHd3CcnwJrKqzxBJTVZ-b_A@mail.gmail.com>

On Sun, Mar 09, 2025 at 06:46:43PM -0400, Avraham Hollander wrote:
> After upgrading to Linux 6.13.6 (built myself with a tarball from kernel.org)
> with the microcode loading patches for the AMD vulnerability, I am getting
> the following at the beginning of dmesg output:

Thanks for reporting - fix is on its way to the next stable tree - simply
fetch it when it appears there.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

