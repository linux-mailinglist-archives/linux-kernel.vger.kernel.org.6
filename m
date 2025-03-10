Return-Path: <linux-kernel+bounces-554942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC04A5A3A4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BCD5188F67D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD5122D7AF;
	Mon, 10 Mar 2025 19:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QmA8KErU"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7C8189B80
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 19:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741633803; cv=none; b=qkKFWXWfVdkHorX0Tf4Zt7Z0mGr5FeGtXdO06pfGQYq/tWY08XSTihfu2HmXoAV9RT3oiPnPXVuz97eG9rHxc9Rz+b8vQYpj1yx1PJwIIWdbiiZtZsjRC4N8dXN04Dbj0IsE8FirUSteCNaPz3bP3OlO41gNhRyIPNTXAPWlq8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741633803; c=relaxed/simple;
	bh=ZDkOzTn4lQFqn/QoRZQS9+zhRq8N4dkYWc6slJj4MFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suWD12/3m0SqWh6vZEnVzTurOujr0+WIr42kYi9rpXVXYskn8LcwOz/B/L3ttbne7luGhUe+dtewIhQ1/KT14uRAevDsqYIxkEOkU6K/ED+NRJotJ/JY6LOX3TrY2oNfAjwnOcO6VzXqV4F1e05/pdy5llasl8fqs0zzF2+OpaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QmA8KErU; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A140340E0218;
	Mon, 10 Mar 2025 19:09:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dRU0QODA3P-H; Mon, 10 Mar 2025 19:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741633787; bh=dbQcGvEKcrnLR81w8hAcq9VOn5tgU/LJz+HG0sgbIOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QmA8KErUZU8ZBQuCx9qlLdyJ8ykKD9gkC0V5okjeLWtXpPfePiJpm/vGDhMr4oFsr
	 yku5ly7D5qSGTYe+5ndahan3m2BvBEOn0vmAJeIFuPCBrzDncVNYXS6HrYVQvYnYlf
	 T81KAMHbDp0M5DSjoxeB4wroUmzX3wY/BiI2Z4kZqhkby/jGY5z6/JUmmtCmk+KsNZ
	 pGYUhcUCFTRN00IktBlVR/d4tg60YguZURHz3ZrBrQKtFp49WWObm87VnPEGo3U2kc
	 sQZfYszGBwiAHUP2bF8A8e7gZWOs3QAyxGiBmWOfrhxS+e6RhGVBJilkBoqm9mXjdf
	 JQjWBflpwL/3R0IL2rl3cCEOsuiUhD0q1ChCA4IzUY5fp6XtcAInKt2l/F+eDrSKhk
	 3JXiIif6MybyYZlfp0NFISkh/nzgO2P2MQO7/q4kxW1vQvq6VzVIITePw888Ody8fp
	 fO/vt8tgdBHb7vCgn1FJlaIGf77oLQnR4vUG2D9RR8azU1AnwKxOpdqG01XXc3hWU2
	 q7v7EQ53UF9p08vlYBj8F40eZ9mOheg5ASoXL/FszF1WO0BDYMTJkUD9h50tAmp8Ku
	 EHzL/gGrOaZ8FsdJRoJtrY7xlDKD5pN92yZL1/UShALfHUq6uJOpk/PC8ExGMEiRvf
	 DFxT6xJpu2PrdOgTjd+lF0fE=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C781D40E0216;
	Mon, 10 Mar 2025 19:09:20 +0000 (UTC)
Date: Mon, 10 Mar 2025 20:09:15 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com
Subject: Re: [PATCH v7 00/49] x86/resctrl: Move the resctrl filesystem code
 to /fs/resctrl
Message-ID: <20250310190915.GAZ8842wfIn043W56k@fat_crate.local>
References: <20250228195913.24895-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250228195913.24895-1-james.morse@arm.com>

On Fri, Feb 28, 2025 at 07:58:24PM +0000, James Morse wrote:
> Changes since v6?:
>  * All the excitement is in patch 37, turns out there are two rmdir() paths
>    that don't join up.
> The last eight patches are new:
>  * The python script has been replaced with the patch that it generates, see
>    the bare branch below if you want to regenerate it.
>  * There have been comments on the followup to the generated patch, those are
>    included here - I suggest they be squashed into the generated patch.
>  * This version includes some checkpatch linting from Dave.

So, Reinette says that 1-30 should be ready to go. Care to send them ASAP with
all the review feedback addressed so that I can try to queue them, we all test
the branch this week and thus I can empty a considerable amount out of your
bucket of patches...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

