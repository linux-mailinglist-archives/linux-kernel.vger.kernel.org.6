Return-Path: <linux-kernel+bounces-366944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF5899FC85
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418CA1C2453D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802451D63F8;
	Tue, 15 Oct 2024 23:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="g56BOkyL"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC8D21E3D8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729035380; cv=none; b=WFFqsTY1HVJxF8wsRDfK1EQFerExoiOjMAMIKWiKeBUQMPeAps8kSZwkCMdraMS7AxLTtp0e3vbNxL1sgSxFb8nppACWfYHO3DjIwaCab954PcqhHFhKge9aLCGL7JaY06NzjWAugqAtoIiCdyMBlFIaClZjYVoJCnymJsHa+MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729035380; c=relaxed/simple;
	bh=55UBsPdRtOcIjcCsj/e/8n9kJFKSwZFPBbjn2WcQN54=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RxHDPUKnaObYbGyOKgpCBsyh3uRfbs5mo/qTDs2vgh+mKKfZ6Bxvj7JGLOl23Wx+KRj3jqShlxrr9eVqXguf1976f50CNxauKZuq3ebwLtTXBtxksYQUAZ47E5Ijb4LG4K+/P+jKlrsX640/SV8jXt8hH5pjJOs6Iin91q7NpgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=g56BOkyL; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1729035373;
	bh=y8JBzTUQ2PNFr0hTYT1Pi6MtMBjSnIDl/kCCddB1ycU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=g56BOkyLhact54vh+u915qEjLQKMxwTn7KNscVIYoE26bdnoLUeQTfDlxO87ArgXS
	 yVhG+wqPglztDR/i6goFl4VeaayUGOK3fghy1EbwPX/GIblJM4t2XHpiIWho3fUjBS
	 zc5oIOagvoHUAC5H8UOm8WZs3DDc9qAOJ95nP38pBRWMB/n30uFyhI805V7JyJlSvs
	 2FLoF0AtpCdZX4k4Nwhbi+n2q4VT+xNN1dD3WeUJRRkgVmQzcflrvxUaUZ+L6aFKi7
	 yERvmKOZ+YGMdw4PTeUxFgn7xYOyE1GKjeLxAyAJPdfZGUW0UWAwXeJ0efQm89GvBH
	 kg4Sg8A6UjxJg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XSr8F439tz4wcy;
	Wed, 16 Oct 2024 10:36:13 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bart Van Assche <bvanassche@acm.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King
 <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Bart Van Assche
 <bvanassche@acm.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 04/22] powerpc/cell: Switch to irq_get_nr_irqs()
In-Reply-To: <20241015190953.1266194-5-bvanassche@acm.org>
References: <20241015190953.1266194-1-bvanassche@acm.org>
 <20241015190953.1266194-5-bvanassche@acm.org>
Date: Wed, 16 Oct 2024 10:36:14 +1100
Message-ID: <87y12pndld.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bart Van Assche <bvanassche@acm.org> writes:
> Use the irq_get_nr_irqs() function instead of the global variable
> 'nr_irqs'. Prepare for changing 'nr_irqs' from an exported global
> variable into a variable with file scope.
>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  arch/powerpc/platforms/cell/axon_msi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
> index 28dc86744cac..d243f7fd8982 100644
> --- a/arch/powerpc/platforms/cell/axon_msi.c
> +++ b/arch/powerpc/platforms/cell/axon_msi.c
> @@ -112,7 +112,7 @@ static void axon_msi_cascade(struct irq_desc *desc)
>  		pr_devel("axon_msi: woff %x roff %x msi %x\n",
>  			  write_offset, msic->read_offset, msi);
>  
> -		if (msi < nr_irqs && irq_get_chip_data(msi) == msic) {
> +		if (msi < irq_get_nr_irqs() && irq_get_chip_data(msi) == msic) {
>  			generic_handle_irq(msi);
>  			msic->fifo_virt[idx] = cpu_to_le32(0xffffffff);
>  		} else {

