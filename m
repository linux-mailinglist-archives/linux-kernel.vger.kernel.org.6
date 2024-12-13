Return-Path: <linux-kernel+bounces-444322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD039F04B9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 07:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10891188B353
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F41C18BC26;
	Fri, 13 Dec 2024 06:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5wMcZ0k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A7316BE20
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734070900; cv=none; b=TtZFRnsqIbQL4N9z0BU2qxleViBc5s9V1cQ826MsFjqVsPZVpnLAtUrkRXEDM/K5pw5BiGZ/4ib79zRbUgdUoQRo/KthaWHd39nb9sX9Wri6OGssuWKiB2Ac01i4FlqfE7niMehkmw0hqoe9LMKy3joBBTWyRHUCfL8k9uVHPS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734070900; c=relaxed/simple;
	bh=BpbPCI1d2Pz9shxI/uLK8sUVSC9atfWpmTqqpJr0L8w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArAOVgqRBu/aKUMrbu/rL4qZOJx+wLonIiG6QBltrrWw8Kj1rcebPY91Hazdc1lXXlf/VDILW9ZByG6pjik+PW2sUpJEbF20PAcw5aZP+0313GjbkxxynmT6SmcpzBtVojljCAX6A5QB0SqKcza6Sgyhjoerr//X2y/gj53NnA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c5wMcZ0k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734070897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DPZgmo/qtMlwMvcQyJOYmy+B4bLTXtZ7sK39x78OQXc=;
	b=c5wMcZ0k4Df4V/PZiZwljGwTyT8DWpxwUmvcYVnQT9vnIKs32zA9nsp0FJ807rzhzdmJuW
	8gG/wqPYTADNytJKalH3BiudbvfK205/ur+UCKiEIZeZ9JCuSVkT5a0/adNL87W9C3n/RG
	CBFeMp2+1aw0Rnf6WhnoMvD/n4oJaUE=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-Iux_r6qROQucyUSc48FQsw-1; Fri, 13 Dec 2024 01:21:36 -0500
X-MC-Unique: Iux_r6qROQucyUSc48FQsw-1
X-Mimecast-MFC-AGG-ID: Iux_r6qROQucyUSc48FQsw
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-844e9b88efeso62083239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 22:21:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734070896; x=1734675696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPZgmo/qtMlwMvcQyJOYmy+B4bLTXtZ7sK39x78OQXc=;
        b=jU9D65ayEGqjm8mC4R8A8IzxfSIR36Vz94LaaZgsz8bQScadGcwHBKM657lkGcTQmX
         xNfuq8SDaDhFzqIn3uDTPcz4KU8CUzgJerZ9//Gts2EK/YflR1+x5T2TXlu2HGtXf2Au
         4arcpi5pTabKzXTnbGGTq01eYEjXKA5JQg3h/DmbfgaC9yYWN8xyOiKg4hWQZxh8Qggw
         Na6ssllKFCeV97BnjcWf9BgVkdpAXv3AzkVEA65amd9ycJk8WYoB2sJEM/b6QlNsXjMk
         H1VOIqSBB+XBefIdAOfqLO0klE1ndq1urqehiQHnrMWmtga/RfcjDw2XlooNQHDXJkmt
         Xk5A==
X-Gm-Message-State: AOJu0YwyUCw43GpfItFncSXiQuei+wf1wgwkGN/wu6t2JglCnBfCIBFt
	b3zg8l6WshCapIKsqGKa/+zBQvMK7KuibPaRrL1fpXfefPGVgAT/vOLG7yI8dgexicLalaXw1Xn
	20wDL0Jeodt8W1+JAirTFfiYvudHKDbZfl+fF0WNLfkK3ETGm9IQ/vmN+8ahtnT4fOigobg==
X-Gm-Gg: ASbGncuYNo5Dw0hHC81yysHzAK4NlMsBv/3zdzbTPipoh/3t5oFHE8KNdJntBQf5+K3
	CYk99PTJnkBZjKgc4DJWs0ZAWZNfwhfdLx15qQQxB3ark1YpWxwgPYI38TcBe69DSl5VFULb+Mc
	RMlQCVWPd8E6g/X2GJ8byHvPhKGyXbeVWN/vgQZW5lUJrvYjzank+Vmnncze/jlx9PNsd5g0Dwp
	ALRbyQSgFuab/U0TbwgpppR+asFugd5bFypUphRo4biDK8vqQ==
X-Received: by 2002:a05:6e02:1a07:b0:3a7:1f72:ad3c with SMTP id e9e14a558f8ab-3aff0961e22mr15794615ab.19.1734070895896;
        Thu, 12 Dec 2024 22:21:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGI7oXY0ZPz4ZIHxMFwUGuCfrmAhdHwjA+NLE/o4LVPglmKzGX2hU0P4ZlBxkSthZ+rlMb6xQ==
X-Received: by 2002:a05:6e02:1a07:b0:3a7:1f72:ad3c with SMTP id e9e14a558f8ab-3aff0961e22mr15794515ab.19.1734070895649;
        Thu, 12 Dec 2024 22:21:35 -0800 (PST)
Received: from jpoimboe ([76.14.162.30])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2c0b71ec6sm2414473173.121.2024.12.12.22.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 22:21:34 -0800 (PST)
From: Josh Poimboeuf <jpoimboe@redhat.com>
X-Google-Original-From: Josh Poimboeuf <jpoimboe@kernel.org>
Date: Thu, 12 Dec 2024 22:21:31 -0800
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 3/3] objtool: Add noinstr validation for static
 branches/calls
Message-ID: <20241213062131.gk75bqcm3eclhb4d@jpoimboe>
References: <cover.1732682344.git.jpoimboe@kernel.org>
 <51fd13276df848dcb320bf7ff423f73364b06266.1732682344.git.jpoimboe@kernel.org>
 <xhsmhed2p560i.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xhsmhed2p560i.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Tue, Dec 03, 2024 at 01:02:21PM +0100, Valentin Schneider wrote:
> On 26/11/24 20:47, Josh Poimboeuf wrote:
> > @@ -3532,14 +3577,29 @@ static inline bool noinstr_call_dest(struct objtool_file *file,
> >       return false;
> >  }
> >
> > +static char *static_call_name(struct symbol *func)
> > +{
> > +	return func->name + strlen("__SCT__");
> > +}
> > +
> >  static int validate_call(struct objtool_file *file,
> >                        struct instruction *insn,
> >                        struct insn_state *state)
> >  {
> > -	if (state->noinstr && state->instr <= 0 &&
> > -	    !noinstr_call_dest(file, insn, insn_call_dest(insn))) {
> > -		WARN_INSN(insn, "call to %s() leaves .noinstr.text section", call_dest_name(insn));
> > -		return 1;
> > +	if (state->noinstr && state->instr <= 0) {
> > +		struct symbol *dest = insn_call_dest(insn);
> > +
> 
> Interestingly only after I tried making __flush_tlb_all() noinstr did this
> start causing a segfault due to a NULL dest. I added a NULL check here but
> I wonder if I'm not just plastering over some other issue?
> 
> > +		if (dest->static_call_tramp) {

Yeah, this line can probably just be:

		if (dest && dest->static_call_tramp)

-- 
Josh


