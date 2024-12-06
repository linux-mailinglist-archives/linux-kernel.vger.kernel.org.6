Return-Path: <linux-kernel+bounces-435130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36CF9E7008
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCB0287324
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CF2207E02;
	Fri,  6 Dec 2024 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDqUkGnd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19FA206F06
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733495327; cv=none; b=F+da/AOZc/iDelvI+K3+DpWDJ14Qq9UCGnjrjlIk4nsgRwxgxlX4Rgjhk+E6bE+R6tbGqnDEFDOP5hViJAq8547xH3Bnys4JpbhNtmaH44WjOCxsbrUolUZ4pY2SesQmxfdY30iZvRvLxv1TilWxca/+hqrHA00E6RyulEKd2xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733495327; c=relaxed/simple;
	bh=XhX2ZQdCCZuz9Ph7uA5JfB1Xp1G8lJhcSAqHnXUhIBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dtp2YpTp6vqD5+L2YGzQvyjsqn3zzGEhl6hYaO5Z25k9aDGcXUPXG41gQlS77U9bswBkhNNCjz37i5SfwdTrTycC421WEJBLFq95R2h5cw2mr8nS0MD/hCdL3PipTgxVztHayiypEiRNMMXzkIqBee79KNpxBxjn+a0QEgcGF4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MDqUkGnd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733495324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s4vMfwGH4rmj4T5SDjqpaQ0vlQVTTVo3RrQSsivYqTs=;
	b=MDqUkGndo4K0AG0N3/HPugNASpj1ncqcuu+eOP5W4tqsUcu1dWkThU0bkcUVNUwVXhMSnM
	GPRXM2wwrUt+Q6PLEKL1Kl9kxa/0K9BLek5lDOsA28NznFkjGr3j+g5OYBGVdEaHZ4qWEX
	wv/b/qADpF6TntRzX3KXkqAltbuBMaA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-dNlhEnVaM9WRD4qADXkiAg-1; Fri,
 06 Dec 2024 09:28:39 -0500
X-MC-Unique: dNlhEnVaM9WRD4qADXkiAg-1
X-Mimecast-MFC-AGG-ID: dNlhEnVaM9WRD4qADXkiAg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF6FB1956071;
	Fri,  6 Dec 2024 14:28:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.103])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4651D300019E;
	Fri,  6 Dec 2024 14:28:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  6 Dec 2024 15:28:14 +0100 (CET)
Date: Fri, 6 Dec 2024 15:28:08 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>, stable@vger.kernel.org,
	Fangrui Song <i@maskray.me>, Nathan Chancellor <nathan@kernel.org>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v5 01/16] x86/stackprotector: Work around strict Clang
 TLS symbol requirements
Message-ID: <20241206142807.GC31748@redhat.com>
References: <20241105155801.1779119-1-brgerst@gmail.com>
 <20241105155801.1779119-2-brgerst@gmail.com>
 <20241206115154.GA32491@redhat.com>
 <CAMzpN2g8eenLASqXA36LwP=Zr+8Z1cO7Cpz0ijiUdOr_+7G-3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMzpN2g8eenLASqXA36LwP=Zr+8Z1cO7Cpz0ijiUdOr_+7G-3A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 12/06, Brian Gerst wrote:
>
> On Fri, Dec 6, 2024 at 6:52 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 11/05, Brian Gerst wrote:
> > >
> > > --- a/arch/x86/kernel/vmlinux.lds.S
> > > +++ b/arch/x86/kernel/vmlinux.lds.S
> > > @@ -468,6 +468,9 @@ SECTIONS
> > >  . = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
> > >          "kernel image bigger than KERNEL_IMAGE_SIZE");
> > >
> > > +/* needed for Clang - see arch/x86/entry/entry.S */
> > > +PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
> >
> > Don't we need the simple fix below?
> >
> > without this patch I can't build the kernel with CONFIG_STACKPROTECTOR=n.
...

> Which compiler are you using?  It builds fine with GCC 14 and clang 18.

gcc version 5.3.1 20160406 (Red Hat 5.3.1-6) (GCC)
GNU ld version 2.25-17.fc23

See also my reply to Ard

Oleg.


