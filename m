Return-Path: <linux-kernel+bounces-228558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC3691619A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394EB286DF7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54CF148FE4;
	Tue, 25 Jun 2024 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IAofOHA2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D652148823
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305265; cv=none; b=XBokfhJJJ31A2C9AbQOGxvCDqCIeF9pnQ3JTf3hSeTQ9e/HOfbIOla8yN2+2r3cHKeEyhk4eN1NUsnAfgs6NSx5fiCIqgTC5lHFynv2imTULiB9NP0Y/po8/wiIk6dimJ3HRgvIqvIW8UjHWtzd7YMunsTBuQK+shyD7+l3LS8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305265; c=relaxed/simple;
	bh=khjT1qW4ZRdDYbiemFS9EcjMm6/guvFxZTFx7kX0BT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHiqZiJaejLdSqSHAjhXyj94JlcpInpcHojMEnstPw3xq0zNyTSLeo2Gjk7vVFsLHW43020A9Wq0p/CAiQGokrTgtAmSZu1krmBSayjP7mkTelO7V5rMp9A0cGHH66BEsLvcmisPaeRP4tTahlwb0PnkXceR0J976uJUdvL6ImI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IAofOHA2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 058EB40E021D;
	Tue, 25 Jun 2024 08:47:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wEX573EBUvLZ; Tue, 25 Jun 2024 08:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719305257; bh=nOfj2BKUC0LTV44iiPUObwzjmvg9jAdhTHWcWwPCMyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IAofOHA2nD4wOCyRGdT9l7Utyo7U+FEb+z/InhqptsHGAgh6z1cgLpw0x13WSq2UO
	 HQgnhat6qZ+JFgjDc2eCxw1RglEtbCj6I6myL/MVeL6EapUmKXqyMMTmaigvUPCUh7
	 Q3jHrJbfOgfyUyTs/cmbJHcpEEOtQ+vCCsvrL0zmPqhTBYtvMe2vV260vm3ty0R+rj
	 nYkinUx2rEB7lZGft19UcmCqesG5WDOXrt0oyMPMlG9v4jWDVFOGSs0PrPCu0+o1DR
	 B5Hghb+NpX1Y9yes0x1o1D0PRtGQ4RP2dqieRHkTjxymlL3Y0vmadw0DndS8Jocn1z
	 9gaqhiSSPBux/oxgJIFMw4LOuRXnkJvuw7QfODRzn/nPCFwxQomr1edMPt7IdpOqPU
	 EBcdEFj7xwEam2xgEe+4SiHsgkYoa5wOwS7JQFi8xJau695aRx/3+ATqif7fzSrGUk
	 8wj8WJcljN4T5KePTfmK/lbfk8jhM89ImIVmHzJhXCLH2rxPuFDQBJ+Yf8cquah+YF
	 B3gWGBIUG8WFbDGYTpcDEQKvVfd2CMpbyLMwiVE+CRnb1FQvoXEP1cagpLAIUhzXQ7
	 qIB1srpPv+Q2SJjrBXjwVTnjtf8BlIzmNbnhUb5ZJMYH5BofxuE/e/CspSdCUEbX2s
	 zjpvO4kjHT/g+w84GS6qD0P4=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B7F2E40E01D6;
	Tue, 25 Jun 2024 08:47:26 +0000 (UTC)
Date: Tue, 25 Jun 2024 10:47:21 +0200
From: Borislav Petkov <bp@alien8.de>
To: Alexey Makhalov <alexey.makhalov@broadcom.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	hpa@zytor.com, dave.hansen@linux.intel.com, mingo@redhat.com,
	tglx@linutronix.de, x86@kernel.org, ajay.kaher@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	Alex James <alex.james@broadcom.com>
Subject: Re: [PATCH] x86/vmware: fix panic in vmware_hypercall_slow()
Message-ID: <20240625084721.GCZnqEGbrkNNW6ZCfZ@fat_crate.local>
References: <20240625083348.2299-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240625083348.2299-1-alexey.makhalov@broadcom.com>

On Tue, Jun 25, 2024 at 01:33:48AM -0700, Alexey Makhalov wrote:
> Caller of vmware_hypercall_slow() can pass NULL into *out1,
> *out2,... *out5. It will lead to a NULL pointer dereference.
> 
> Check a pointer for NULL before assigning a value.

I queue your patches and *now* you find this?!

How did you test them in the first place and why was this scenario missed?

Geez.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

