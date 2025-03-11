Return-Path: <linux-kernel+bounces-556321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D50A5C404
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A325F1899E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D5C25A632;
	Tue, 11 Mar 2025 14:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnYJEFzL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C2C2253EE
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703913; cv=none; b=TZ87W38RTXn9NnLE3pndX9BDHHUzzlHI66L4/vQMMj447gqiVoI8FjRgXcZJ4r1S4nfAS4vOMQJLZc8pwz2SbcCzL722VAArba+a5H+o9fUI2LccHgH2WiW1D0ho7ZAPg6pkBUsffF8yWw1w8oYhrNoosyFx+kIkM+ugjofhab8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703913; c=relaxed/simple;
	bh=m/eEMxP8Xj8yG2a7Hu4kR+mrcgF0OixHM7fnWN4XHvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4HnO7tcHxTcAAmpGkEB2qB5rRMi76Q3GKkct2H40+rJnjCsovSeSDO/713Oi8/sBSLoBMVj/yxntENi7oa/j+sVqhu/hb7UmiwAAC5te1kJN+Uxxss2ZuZCUw8ji1lcfK/uYmokT8a1cNYtEgbP+cvtaR27OVKqWVLvHYJngew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dnYJEFzL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741703911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cpTpvcWE2P9qSD301paokWQsARnj6IAdwHTa1z+B9WQ=;
	b=dnYJEFzLXL+PomIkbo6VPAzhTFd81njTuigVmFtWaKf8RvE8FHGEv22EeIrojPdiH5Zp5f
	Nfahj1b95QhmviHPfWVAIwxgli5UOFFcX27KEu4OdyQdzbsctUijAx9MljROePNN24FYe2
	CtaPUAjoEqg3Zx9JCnvpLHN2Rrh4XGg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-H1IGM8NeOoSottojaFFw6w-1; Tue,
 11 Mar 2025 10:38:28 -0400
X-MC-Unique: H1IGM8NeOoSottojaFFw6w-1
X-Mimecast-MFC-AGG-ID: H1IGM8NeOoSottojaFFw6w_1741703897
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27853180025B;
	Tue, 11 Mar 2025 14:38:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.22.90.58])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6848C18009AE;
	Tue, 11 Mar 2025 14:37:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 11 Mar 2025 15:37:31 +0100 (CET)
Date: Tue, 11 Mar 2025 15:37:25 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Brian Gerst <brgerst@gmail.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>, stable@vger.kernel.org,
	Fangrui Song <i@maskray.me>, Nathan Chancellor <nathan@kernel.org>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86/stackprotector: fix build failure with
 CONFIG_STACKPROTECTOR=n
Message-ID: <20250311143724.GE3493@redhat.com>
References: <20241206142152.GB31748@redhat.com>
 <CAMj1kXGo5yv56VvNMvYBohxgyoyDtZhr4d4kjRdGTDQchHW0Gw@mail.gmail.com>
 <CAMzpN2iUi_q_CfDa53H8MEV_zkb8NRtXtQPvOwDrEks58=3uAg@mail.gmail.com>
 <CAMj1kXF8PZq4660mzNYcT=QmWywB1gOOfZGzZhi1sQxQacUX=g@mail.gmail.com>
 <20250310214402.GBZ89dIo_NLF4zOSKh@fat_crate.local>
 <CAMj1kXEK0Kgx-C8sOvWJ9rkmC0ioWDEb+tpM9BTeWVwOWyGNog@mail.gmail.com>
 <20250311102326.GAZ9APHqe5aSQ1m5ND@fat_crate.local>
 <CAMj1kXHTLz4onmR5iyowptRE38RCK4jNT3BoURBkq2FoDOMTxQ@mail.gmail.com>
 <20250311112112.GEZ9AcqM2ceIQVUA0N@fat_crate.local>
 <20250311131356.GGZ9A3FNOxp32eGAgV@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311131356.GGZ9A3FNOxp32eGAgV@fat_crate.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/11, Borislav Petkov wrote:
>
> On Tue, Mar 11, 2025 at 12:21:12PM +0100, Borislav Petkov wrote:
> > Yap, that fixes the build:
>
> Lemme run randbuilds with that one, see what else breaks with it.

sorry for the off-topic noise, but what about the

	[PATCH] x86/stackprotector: fix build failure with CONFIG_STACKPROTECTOR=n
	https://lore.kernel.org/all/20241206123207.GA2091@redhat.com/

fix for the older binutils? It was acked by Ard.

Should I resend it?

Oleg.


