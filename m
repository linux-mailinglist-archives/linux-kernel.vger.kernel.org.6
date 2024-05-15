Return-Path: <linux-kernel+bounces-180266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E478C6C34
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 20:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0811C21E2E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A791598EC;
	Wed, 15 May 2024 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NNcmssn5"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8A65B1F8;
	Wed, 15 May 2024 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715797995; cv=none; b=PV6WEeCC4WiqA1eauqn9WszCHHzWmb+lYFZPIbmNt1Bo8oAhgN8q527XkKkXksSI4+XEfDwYPDd5NXBuzmKckJIvBCr9A04ShVyZUqYvmDYAAL+GkWOzmVsjWtZ5XucFrtVw7gS8QVCDRLBjdsdTvn748isW781SnT4t7MUYyEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715797995; c=relaxed/simple;
	bh=9Zoj/Ih6opWfl2+fhCL2K4ue5IU/qwFB7ZFSvwZcETU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRfSkOcwjPcUTGJizXRDt60JICGrF//snlIEJmWPol/LsVLlnru0XPDMoS+ADJFyKdNT7PfcYB3lqEzZYNbTePgJnltu6UESUNxl7TJSMOKc35fdzwf99UznuNWLTgkfkxETHMtgriVrOxNWiaqzh1M7tmFkNJGSMZnwyILH6xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NNcmssn5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C9CD440E0244;
	Wed, 15 May 2024 18:33:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9vDdpDFf5kxS; Wed, 15 May 2024 18:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715797979; bh=Hm7EEfZwJI4EYLlWeG98fmfbg67gUcFmPW/+3Lw+0eM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NNcmssn5qPrIpNNCkSfiTnfWD2z1w21vdoZu1NS83caf/javSnvE1oJXT+ZlXNp5G
	 mylWM8TFisrlSNRpcQ3QQUneVDN3u8tAOR49ZzTVUC45U3ROdrBp7IfKMmX/7t1LqA
	 5TcLzqUsT5yLDImfC7YT5HmUsx+BdgFE+vTShmPP3x3kcB65tPo0V6qL707YzidMw7
	 lqQoTm3p7XuTNoOIFjBWfpD+q8N9zcRvPzA4BtKg5GQ1VkqCj87ANfFS9Q5UqpKPx3
	 4uDufH5nyuc3d4/fjwQMqimEshOgxSeDlKKTjlUyvGKaS6DiOkY/3HLz54XzekSFQQ
	 Vh36R3bGRbKxksUZUUCjvUqWKPQ7HPoOJ+HDku4E1Kz5adIF8dHVkUn0McK4LNFcyL
	 woIewpgBkUvFMn8rqC65+jq7h7VyTMAOUXHqd2FSUJj+iufewUmeYbXHDiM3/nYDV8
	 CAZpPHRcwxRmeAfb2RpMrWKW8lfvw9Yl/ezfkC3ZQAjJa7AMx8VAemzLBa/52ZMFCx
	 WsvtIubJzBZJKHvT8or3pk0cLynKdR4Sooc7+g1mbqRaNNBomRgiJX44xcazeGspJf
	 rcMtWXcZ8SZXHxXkzvfnw1JrUuF8C9FjvAW669dUA98YboAOpXNSlKba7sqXLBo2rD
	 7xvQMItMtRQAEQ24XsxQ/6ww=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EA18940E016A;
	Wed, 15 May 2024 18:32:30 +0000 (UTC)
Date: Wed, 15 May 2024 20:32:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
	Ingo Molnar <mingo@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Liu Shixin <liushixin2@huawei.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Muchun Song <muchun.song@linux.dev>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 1/1] arch/fault: don't print logs for pte marker
 poison errors
Message-ID: <20240515183222.GCZkT_tvEffgYtah4T@fat_crate.local>
References: <20240510182926.763131-1-axelrasmussen@google.com>
 <20240510182926.763131-2-axelrasmussen@google.com>
 <20240515104142.GBZkSRZsa3cxJ3DKVy@fat_crate.local>
 <ZkSUaVx3uCIPkpkJ@localhost.localdomain>
 <CAJHvVchGGJkEX=qroW=+N-RJDMDGuxM4xoGe7iOtRu9YcfxEEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVchGGJkEX=qroW=+N-RJDMDGuxM4xoGe7iOtRu9YcfxEEw@mail.gmail.com>

On Wed, May 15, 2024 at 10:33:03AM -0700, Axel Rasmussen wrote:
> Right, the goal is to still have the process get a SIGBUS, but to
> avoid the "MCE error" log message. The basic issue is, unprivileged
> users can set these markers up, and thereby completely spam up the
> log.

What is the real attack scenario you want to protect against?

Or is this something hypothetical?

> That said, one thing I'm not sure about is whether or not
> VM_FAULT_SIGBUS is a viable alternative (returned for a new PTE marker
> type specific to simulated poison). The goal of the simulated poison
> feature is to "closely simulate" a real hardware poison event. If you
> live migrate a VM from a host with real poisoned memory, to a new
> host: you'd want to keep the same behavior if the guest accessed those
> addresses again, so as not to confuse the guest about why it suddenly
> became "un-poisoned".

Well, the recovery action is to poison the page and the process should
be resilient enough and allocate a new, clean page which doesn't trigger
hw poison hopefully, if possible.

It doesn't make a whole lotta sense if poison "remains". Hardware poison
you don't want to touch a second time either - otherwise you might
consume that poison and die.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

