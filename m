Return-Path: <linux-kernel+bounces-345923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A46F398BCF5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21DB0B213E4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294B41C2DDF;
	Tue,  1 Oct 2024 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="boyZI+KI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="byYIEL80";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="boyZI+KI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="byYIEL80"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6791A073B
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727787581; cv=none; b=uBk1n+WX1kCZitulhdVyHeYpE4qezQPTORcxQCgkBN9RIH4JtEdckjnh9CtEuNg4lZFxfLfsmaZ5sM/ZChgnZEXANaspIPlLob19J0W4ouBSwlmxoUPjHSzKu3Ox5/8fveb8XZFencs3p5n4c3jVjJGx4k0egSB6Zg3NpTWov8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727787581; c=relaxed/simple;
	bh=WumEu+2vcgYw100M4Psr6ICyQUp0ZNMMiYlmqhvRPC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrrB8vaLrU151l57NSniBimqXeeZkylG6DSWUDa5BmPUpLzowHVZOiyrRXeK3omcd7nxZknzVGluCZXMGdKDDRw9S4TWx9iXlqiO5rLfeEcpChDLDscRAIAaRC3BVI1tpYwicE9Kok/pBIHyBYOj9eF1ZKRy4ueS2ezQjzYnb3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=boyZI+KI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=byYIEL80; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=boyZI+KI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=byYIEL80; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 637C31F813;
	Tue,  1 Oct 2024 12:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727787578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sGTUDG4axiShkcwI3wZMimVAzEVDdTcIdqsEhf/QAj8=;
	b=boyZI+KIR6ZecL5qzIHb4AUOSgjpFtX4Y4/2JJ25AcBvLgIPDIyBvQX9UOjasUCMWsY4r+
	YAadDRz1TPpbsi/Upe5P4tyWAc0MasPTLHE1+tWjbTgOs963LbDUVhHM9ZvGX8D2lNvSNX
	3NlqdpWbV0jvTQNrpwVHadQGJ7HSwMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727787578;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sGTUDG4axiShkcwI3wZMimVAzEVDdTcIdqsEhf/QAj8=;
	b=byYIEL80dQ/Mlau3nuPBqf+opzYwPr+MbtoZgs5MI5pJ6AHhR89MsncXQDfiviobMtwLez
	YbCBuP4lLHcuDxCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727787578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sGTUDG4axiShkcwI3wZMimVAzEVDdTcIdqsEhf/QAj8=;
	b=boyZI+KIR6ZecL5qzIHb4AUOSgjpFtX4Y4/2JJ25AcBvLgIPDIyBvQX9UOjasUCMWsY4r+
	YAadDRz1TPpbsi/Upe5P4tyWAc0MasPTLHE1+tWjbTgOs963LbDUVhHM9ZvGX8D2lNvSNX
	3NlqdpWbV0jvTQNrpwVHadQGJ7HSwMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727787578;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sGTUDG4axiShkcwI3wZMimVAzEVDdTcIdqsEhf/QAj8=;
	b=byYIEL80dQ/Mlau3nuPBqf+opzYwPr+MbtoZgs5MI5pJ6AHhR89MsncXQDfiviobMtwLez
	YbCBuP4lLHcuDxCQ==
Date: Tue, 1 Oct 2024 14:59:37 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Mackerras <paulus@ozlabs.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] powerpc/sstep: Unexport analyze_instr,
 emulate_vsx_load, emulate_vsx_store
Message-ID: <ZvvyOeT019FoMPPg@kitsune.suse.cz>
References: <8ecdbd907a8a92cbf9c7308df13f9d19f5ba5621.1727777273.git.msuchanek@suse.de>
 <8e6c75db-5c98-4f82-8151-5f86c53f4cf2@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e6c75db-5c98-4f82-8151-5f86c53f4cf2@csgroup.eu>
X-Spam-Score: -8.25
X-Spamd-Result: default: False [-8.25 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.15)[-0.737];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,ellerman.id.au,gmail.com,kernel.org,linux.ibm.com,ozlabs.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Oct 01, 2024 at 02:08:18PM +0200, Christophe Leroy wrote:
> 
> 
> Le 01/10/2024 à 12:08, Michal Suchanek a écrit :
> > There is no modular user of analyze_instr, and the latter two are only
> > used by sstep itself.
> 
> analyze_instr() is used in arch/powerpc/kvm/emulate_loadstore.c which can be
> a module as far as I can see in Makefile:
> 
> common-objs-y += powerpc.o emulate_loadstore.o
> 
> kvm-book3s_64-module-objs := \
> 	$(common-objs-y) \
> 	book3s.o \
> 	book3s_rtas.o \
> 	$(kvm-book3s_64-objs-y)
> 
> kvm-objs-$(CONFIG_KVM_BOOK3S_64) := $(kvm-book3s_64-module-objs)
> 
> config KVM_BOOK3S_64
> 	tristate "KVM support for PowerPC book3s_64 processors"

Indeed, missed that it can be modular thruogh this indirection.

Thanks

Michal

> 
> 
> > 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >   arch/powerpc/lib/sstep.c | 3 ---
> >   1 file changed, 3 deletions(-)
> > 
> > diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> > index e65f3fb68d06..a0557b0d9a24 100644
> > --- a/arch/powerpc/lib/sstep.c
> > +++ b/arch/powerpc/lib/sstep.c
> > @@ -863,7 +863,6 @@ void emulate_vsx_load(struct instruction_op *op, union vsx_reg *reg,
> >   		break;
> >   	}
> >   }
> > -EXPORT_SYMBOL_GPL(emulate_vsx_load);
> >   NOKPROBE_SYMBOL(emulate_vsx_load);
> >   void emulate_vsx_store(struct instruction_op *op, const union vsx_reg *reg,
> > @@ -955,7 +954,6 @@ void emulate_vsx_store(struct instruction_op *op, const union vsx_reg *reg,
> >   		break;
> >   	}
> >   }
> > -EXPORT_SYMBOL_GPL(emulate_vsx_store);
> >   NOKPROBE_SYMBOL(emulate_vsx_store);
> >   static nokprobe_inline int do_vsx_load(struct instruction_op *op,
> > @@ -3172,7 +3170,6 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
> >   	op->val = SRR1_PROGTRAP;
> >   	return 0;
> >   }
> > -EXPORT_SYMBOL_GPL(analyse_instr);
> >   NOKPROBE_SYMBOL(analyse_instr);
> >   /*

