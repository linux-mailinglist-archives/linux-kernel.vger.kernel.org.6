Return-Path: <linux-kernel+bounces-180083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923038C69E6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54171C2144B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C08156237;
	Wed, 15 May 2024 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WpSUaiWh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E020815622F
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715787831; cv=none; b=T1NgzF79UYzHS/hl0wtgsN5bo0F9fmNJll+z3GatV/AhVT40Fc6DBzfybET4htWFmi+DZaOP6uVVhNwddjcGM+xpOjnLPTrA9JFuD8Ro7NGg3gBUJzLjXNgdjXEIWo714O9k5CePVF7VFsq8BCWU9gFTdMalKLtqa7d+cI3BNFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715787831; c=relaxed/simple;
	bh=sVxFSbL3YtTiW/g14Gv6p0q8nZLKnH+spwUtKK9cJ9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4DOpATJOHqs8ob665ErOmqjzxsRawrrPw33omF7Xs0AgBATIPh4ilk4pETinpYe/M5pircohQEZJ4JUGWwPScxHg2R53QonUvJDjtz/DIMHjEg67h8HmudOPhnX5sXu9wqF9CISwIxyvZvYs+p0s7fwkaiC3d2yeujm3c9ziGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WpSUaiWh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715787829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sVxFSbL3YtTiW/g14Gv6p0q8nZLKnH+spwUtKK9cJ9A=;
	b=WpSUaiWhKAH4YlO2TN4U5GV2ZiOwAX6EJALhDJPzwYScn5AOgYaTftWvnFb9ETzwMguiLA
	IAUNFayzV9EQghWHX47AY1gsE/9+gTaex07noFs/V1BNTGNMii3nCLXDVwSFY9jmV7Cvej
	womIBjDXieeX7r9tjQG4zqSxZA648fY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-WrPe04tvN8qa89qxw5DYcg-1; Wed, 15 May 2024 11:43:35 -0400
X-MC-Unique: WrPe04tvN8qa89qxw5DYcg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 867498016E9;
	Wed, 15 May 2024 15:43:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.39])
	by smtp.corp.redhat.com (Postfix) with SMTP id C19983C27;
	Wed, 15 May 2024 15:43:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 15 May 2024 17:42:08 +0200 (CEST)
Date: Wed, 15 May 2024 17:42:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "olsajiri@gmail.com" <olsajiri@gmail.com>,
	"songliubraving@fb.com" <songliubraving@fb.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"ast@kernel.org" <ast@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
	"yhs@fb.com" <yhs@fb.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv5 bpf-next 6/8] x86/shstk: Add return uprobe support
Message-ID: <20240515154202.GE6821@redhat.com>
References: <20240507105321.71524-7-jolsa@kernel.org>
 <a08a955c74682e9dc6eb6d49b91c6968c9b62f75.camel@intel.com>
 <ZjyJsl_u_FmYHrki@krava>
 <a8b7be15e6dbb1e8f2acaee7dae21fec7775194c.camel@intel.com>
 <Zj_enIB_J6pGJ6Nu@krava>
 <20240513185040.416d62bc4a71e79367c1cd9c@kernel.org>
 <c56ae75e9cf0878ac46185a14a18f6ff7e8f891a.camel@intel.com>
 <ZkKE3qT1X_Jirb92@krava>
 <20240515113525.GB6821@redhat.com>
 <0fa9634e9ac0d30d513eefe6099f5d8d354d93c1.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fa9634e9ac0d30d513eefe6099f5d8d354d93c1.camel@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 05/15, Edgecombe, Rick P wrote:
>
> On Wed, 2024-05-15 at 13:35 +0200, Oleg Nesterov wrote:
> >
> > > I'm ok with not using optimized uretprobe when shadow stack is detected
> > > as enabled and we go with current uretprobe in that case
> >
> > But how can we detect it? Again, suppose userspace does
>
> the rdssp instruction returns the value of the shadow stack pointer. On non-
> shadow stack it is a nop. So you could check if the SSP is non-zero to find if
> shadow stack is enabled.

But again, the ret-probed function can enable it before it returns? And we
need to check if it is enabled on the function entry if we want to avoid
sys_uretprobe() in this case. Although I don't understand why we want to
avoid it.

> This would catch most cases, but I guess there is the
> possibility of it getting enabled in a signal that hit between checking and the
> rest of operation.

Or from signal handler.

> Is this uretprobe stuff signal safe in general?

In what sense?

I forgot everything about this code but I can't recall any problem with signals.

Except it doesn't support sigaltstack() + siglongjmp().

Oleg.


