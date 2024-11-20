Return-Path: <linux-kernel+bounces-415103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F4E9D3193
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 02:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3541F23635
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 01:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8E222EE4;
	Wed, 20 Nov 2024 01:04:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45901F5F6;
	Wed, 20 Nov 2024 01:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732064666; cv=none; b=kQNrZsVz159j29ffIzdXvzXlGIjeNPccbZ28MAJniQT/nMqU9F2sKjbGnlKG0pJTsCWEnzJWGMDFRNJaV9T37vsqZ4ghlQFlIXwYqhuNHs0jtcd08ggLBeQTNpAUB2o5WWKyD4UV5dgq3wPiKSbZpjcAYGcBTRRvenyErD6GJBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732064666; c=relaxed/simple;
	bh=SGujn3QLXu0lUqN3LH5SI4PokXL7Zzhtbkcs0qlwMZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dB/BbUO+YX9Q5crVSaXmwQnweIaMu902d9dRjkGRrzkjQSoNuSc0ABjSOkEbnSnV54KYoCQD4ZU0jGVCR9wXhBqxzMywEhChnvPiRBXNzlhZoMFD/Cx4BJk6+rmzMaB2T+D/EFEz09RZytnMmdDTUYi14lMJQ7eBspgKnFl2yL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7300C4CECF;
	Wed, 20 Nov 2024 01:04:25 +0000 (UTC)
Date: Tue, 19 Nov 2024 17:04:24 -0800
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
	jthoughton@google.com
Subject: Re: [PATCH v2 01/12] objtool: Generic annotation infrastructure
Message-ID: <20241120010424.thsbdwfwz2e7elza@jpoimboe>
References: <20241111115935.796797988@infradead.org>
 <20241111125218.113053713@infradead.org>
 <20241115183828.6cs64mpbp5cqtce4@jpoimboe>
 <20241116093331.GG22801@noisy.programming.kicks-ass.net>
 <20241120003123.rhb57tk7mljeyusl@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241120003123.rhb57tk7mljeyusl@jpoimboe>

On Tue, Nov 19, 2024 at 04:31:25PM -0800, Josh Poimboeuf wrote:
> On Sat, Nov 16, 2024 at 10:33:31AM +0100, Peter Zijlstra wrote:
> > On Fri, Nov 15, 2024 at 10:38:28AM -0800, Josh Poimboeuf wrote:
> > > On Mon, Nov 11, 2024 at 12:59:36PM +0100, Peter Zijlstra wrote:
> > > > +#define ASM_ANNOTATE(x)						\
> > > > +	"911:\n\t"						\
> > > > +	".pushsection .discard.annotate,\"M\",@progbits,8\n\t"	\
> > > > +	".long 911b - .\n\t"					\
> > > > +	".long " __stringify(x) "\n\t"				\
> > > > +	".popsection\n\t"
> > > 
> > > Why mergeable and progbits?
> > 
> > In order to get sh_entsize ?
> 
> Is that a guess?  If so, it's not very convincing as I don't see what
> entsize would have to do with it.

Oh, nevermind... I see it's a gas syntax issue.

-- 
Josh

