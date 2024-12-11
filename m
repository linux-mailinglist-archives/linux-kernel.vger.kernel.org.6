Return-Path: <linux-kernel+bounces-441124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8414A9EC9F3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3B6188664B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F081DF755;
	Wed, 11 Dec 2024 10:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q900rVDd"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCA4236FA9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733911676; cv=none; b=Bl0SP6Azxu6a4xEQs7U/ZKSaHgSbJBc+kYI8oivTRzzbPD/9Q5ZJMMplGwFhqHL0U0Hj5j5TFyp0O3jrt13jgUoPGOjpxOWaqPVVrlJcffi2LUca2z80YPCuaUfwdDZ+1MdpiwMHkzbxGrKk3xuDIqmodh0dP03hWSpESwgG8zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733911676; c=relaxed/simple;
	bh=IzJHcTYEe6dNyeAoXCkYo1Oyp5gniRm+ej/UyY7tdNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHDIIhTPcG7CJkrV4ZTv+iaK3J888Od9CjPF7TfPSMs5aCrBobf3pOmo55nytqTOvvRmahIw2fiAFMrYWvkbtMjoLV3Ckyqk6BPeplTfvI/3LnctYosOMhS91yk3/R5X304qND32KWLsAHnSCNxkKY/HVTDJHeI6zec7Gw7S/94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q900rVDd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-435b0df5dbdso28415e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733911673; x=1734516473; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x1c2ofmQLNeYYeju/JrDqhCfX9sIwSgC4rLZyCHsseg=;
        b=q900rVDd5Odql8902tc1eo201XowNQj6kNLhsWEO2S+SuNyDFb1kskc0r/nrAIpCyP
         ghAb4TFRRMiR6isgyOH29zojClWQS9WjGFwZmsX9fKS5iVIaF2h5iEmWG0kwbQf0wLlP
         PMST0vzJWV7R783jPWb1sx0rT7sgojUf09GwOMio1v9b2BCgcUzoT/NVJSzD+q1XEVbo
         LeUhA3pwauvUlj3issB/zn8U9d9R/5ON/xTheCJHd1Blw8ELvlcxSirQF82dzLM6ZzrW
         EWzSGRSPccbvfMijKREzXlDmwZwZ+CrQZLqurWLkLU0HRiLpwEriaXo9en1cAHh4IM39
         n1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733911673; x=1734516473;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x1c2ofmQLNeYYeju/JrDqhCfX9sIwSgC4rLZyCHsseg=;
        b=E3gqlpB4/NIsEfMd8K7aTJo1bIVsx9IzYCgkgUBlWru4ZcWoqhOMtxcWyZv1ezcx+B
         aoHSRUF0tTBdpIhFIj49OYGXrcGjhV5aA7hE+5Nad4X76hDP1ynmDMi7oXIfsV7unU4w
         8FXoxAG1BR+zR4YRCeij2h7v883UgrNFLlbvRQPMtmQkMk1p9UoDyv7jwl4F8PceQIWv
         Xoe9Iga07v54fSJOt2nDJ9imTxk36WPBwJswbwAjpiSWZAVjCKOa0ZPqCkTJlYJnIZls
         DaIrynkUoY5culfuG1gh3nbGCrTzDezFRd1o/RKz2kKjztQcaknBgIMqb1yt3DvES3BV
         VwBw==
X-Forwarded-Encrypted: i=1; AJvYcCXY68MrzS4DVizgrnurEomHf2MXIvvYENNC7PPDNTU1qLh1HWMf5jgMkIPs1mqBPA03QcZJ8tywdNwKv8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9dGLq+6jzINBK5HzRJ+eY+hKDEl+3M5ESMyD3iqnnJxxHZTaq
	YLYU5MLj45qT7Irp9w3r/85ZRPbyt5QrxIseJsJRgIgwvJhQ+u3vLjLPD1vY3vUlMl6pjHTquAh
	A9BR//3tEHxZBc7nMoWpDMMGvlFBo5JKF5GA7
X-Gm-Gg: ASbGncuNLRAT3tCHr6xpooAYzk0Zg7V71tzdSM1wxbuGtObk0R8OQrE0bfx/cZG2ZcL
	M7dRi6G2i51hW0Atkb9UyX45O4J9lJUN6NPCFJHSR9GlFp4ZEbwgZGoQTuloT4Z9X
X-Google-Smtp-Source: AGHT+IGEK/kmaBbvJg7dQQuM7x7JBMiV8OyKxexKpfiXpXx2u22fSrw6Y0U2iME6zU8KhU7EMyWrc0PbCi5O2GMxpU4=
X-Received: by 2002:a05:600c:2105:b0:434:9fac:3408 with SMTP id
 5b1f17b1804b1-4361c0f4f80mr1026945e9.2.1733911672546; Wed, 11 Dec 2024
 02:07:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203103735.2267589-1-qperret@google.com> <20241203103735.2267589-11-qperret@google.com>
 <CA+EHjTwHSyQ1FJc7axbLNuBxSWpRVE6brb34nO+F59=QRmfQEg@mail.gmail.com>
 <Z1hhHRdpCZcLs046@google.com> <CA+EHjTw4GX3j_ssN-tWnf780xkvyKO5mBN6fnvXeWvQcBDmcNg@mail.gmail.com>
 <Z1liL3BtoPnSyvlh@google.com>
In-Reply-To: <Z1liL3BtoPnSyvlh@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 11 Dec 2024 10:07:16 +0000
Message-ID: <CA+EHjTw+3oAcp3ujjPmbcu42=95nw8WA=rZHYFL91ZK_Wfs_vA@mail.gmail.com>
Subject: Re: [PATCH v2 10/18] KVM: arm64: Introduce __pkvm_host_share_guest()
To: Quentin Perret <qperret@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 09:58, Quentin Perret <qperret@google.com> wrote:
>
> On Tuesday 10 Dec 2024 at 15:51:01 (+0000), Fuad Tabba wrote:
> > On Tue, 10 Dec 2024 at 15:41, Quentin Perret <qperret@google.com> wrote:
> > > > Initially I thought the comment was related to the warning below,
> > > > which confused me.
> > >
> > > It actually is about the warning below :-)
> > >
> > > > Now I think what you're trying to say is that we'll
> > > > allow the share, and the (unrelated to the comment) warning is to
> > > > ensure that the PKVM_PAGE_SHARED_OWNED is consistent with the share
> > > > count.
> > >
> > > So, the only case where the host should ever attempt do use
> > > __pkvm_host_share_guest() on a page that is already shared is for a page
> > > already shared *with an np-guest*. The page->host_share_guest_count being
> > > elevated is the easiest way to check that the page is indeed in that
> > > state, hence the warning.
> > >
> > > If for example the host was trying to share with an np-guest a page that
> > > is currently shared with the hypervisor, that check would fail. We can
> > > discuss whether or not we would want to allow it, but for now there is
> > > strictly no need for it so I went with the restrictive option. We can
> > > relax that constraint later if need be.
> > >
> > > > I think what you should have here, which would work better with the
> > > > comment, is something like:
> > > >
> > > >                 /* Only host to np-guest multi-sharing is tolerated */
> > > > +               if (pkvm_hyp_vcpu_is_protected(vcpu))
> > > > +                       return -EPERM;
> > > >
> > > > That would even make the comment unnecessary.
> > >
> > > I would prefer not adding this here, handle___pkvm_host_share_guest() in
> > > hyp-main.c already does that for us.
> >
> > I understand now, and I agree that an additional check isn't
> > necessary. Could you clarify the comment though? It's the word "only"
> > that threw me off, since to me it implied that the check was enforcing
> > the word "only". Maybe:
> >
> > >                 /* Tolerate host to np-guest multi-sharing. */
>
> I guess 'only' is somewhat important, it is the _only_ type of
> multi-sharing that we allow and the check enforces precisely that. The
> WARN_ON() will be triggered for any other type of multi-sharing, so we
> are really checking that _only_ np-guest multi-sharing goes through.
>
> Perhaps the confusing part is that the code as-is relies on WARN_ON()
> being fatal for the enforcement. Would it help if I changed the 'break'
> statement right after to 'fallthrough' so we proceed to return -EPERM?
> In practice we won't return anything as the hypervisor will panic, but
> I presume it is better from a logic perspective.

It would, but then we wouldn't be tolerating np-guest multisharing,
but like you said, it's not like we're tolerating it now anyway.

I wonder if it would be better simply not to allow multisharing at all for now.

Cheers,
/fuad


> Cheers,
> Quentin

