Return-Path: <linux-kernel+bounces-400334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2819C0BFF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A3B1F235A5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6555216211;
	Thu,  7 Nov 2024 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wi9nSMrh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AA02161EC
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730998371; cv=none; b=W2Kk9I4qBgDAL7xj9lrcjnAv8l2WF6iG06IQgl8zmxeC/8VVse+9s7HJLGrggbjq/zq7M+udNtlkdslFNXKEBcqBjpDP893gK/NFyIsoF4eRuAjFR8Ij64LIXTP8mCTDp2pWTVe72JvOEPg/DhZ29esbA2G0ErCYdkQaRFiV5wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730998371; c=relaxed/simple;
	bh=hv9v9AzQ6K820PB3rtICot8mkjZv1lgJlv2EWsR6Td0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0mdc1XVO0NbFcVZ8daTslhJRGW9ehTwpFozRyxrkAIbZnJfRq7qeWBKHZtjYbZRPJ0AywyVGOh2JWu+bFrdvCXCnPChDT32Em4W5OZ1a7hmQZinHwjK4Kef45mS/KDKBqO3hHi6VH78wD2ZCzI4MCDqBUHTvooxdbx4ZuixlOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wi9nSMrh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730998368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y+xR3kROnh03SwqMnzrOSS+5q00AO7yoiGg1SbP66tQ=;
	b=Wi9nSMrhGn9JFbALr0N8mlJ2atr3DOIYZyNPpIgboTI4+iIiHB69gZrbXToLgYtoltxKDF
	bK7r5WsIiZnuURdHF0yEYoGFhb2YNf9VFE1MnfpNRzvoc9PDUJOG1OKEJSYk8BfNg/F01c
	CU/c7JvoEwzjrteouFxYiBvbIfBPovI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-tQxljRhWNj6xxGAxGAT9Jg-1; Thu,
 07 Nov 2024 11:52:45 -0500
X-MC-Unique: tQxljRhWNj6xxGAxGAT9Jg-1
X-Mimecast-MFC-AGG-ID: tQxljRhWNj6xxGAxGAT9Jg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2518197731A;
	Thu,  7 Nov 2024 16:52:43 +0000 (UTC)
Received: from f39 (unknown [10.39.192.153])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FBB5196BC17;
	Thu,  7 Nov 2024 16:52:39 +0000 (UTC)
Date: Thu, 7 Nov 2024 17:52:35 +0100
From: Eder Zulian <ezulian@redhat.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	miguel.ojeda.sandonis@gmail.com, tglx@linutronix.de,
	williams@redhat.com, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	jlelli@redhat.com
Subject: Re: [PATCH v2] rust: Fix build error
Message-ID: <ZyzwU2JD41JLSqiv@f39>
References: <20241106211215.2005909-1-ezulian@redhat.com>
 <Zyv6unk_tRyv_v7m@boqun-archlinux>
 <ZyxpA2ez-9E4c7G5@f39>
 <ZyzoR4JLPOm9Pi_z@Boquns-Mac-mini.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyzoR4JLPOm9Pi_z@Boquns-Mac-mini.local>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Thu, Nov 07, 2024 at 08:18:15AM -0800, Boqun Feng wrote:
> On Thu, Nov 07, 2024 at 08:15:15AM +0100, Eder Zulian wrote:
> [...]
> > > > Fixes: 876346536c1b ("rust: kbuild: split up helpers.c")
> > > 
> > > I'm not sure this is the correct "Fixes" tag, that commit is a code
> > > move, so it's unlikely introducing issue itself. Moreover, we really
> > > need PREEMPT_RT being able to trigger the issue, so I think the correct
> > 
> > One may argue that we need 'RUST=y' in order to trigger the issue.
> > 
> 
> But RUST support was in mainline earlier than PREEMPT_RT enablement
> (again I know we have RT code quite earlier than Rust support, but we
> are talking about mainline and potential stable backporting here), so
> when the lock support in Rust was added, although the code was missing
> RT support, but it's fine from a mainline PoV, and when we really
> enabled PREEMPT_RT, we should have added the missing piece.
> 
> In other words, would we want to backport this fix into an early version
> (say 6.6 stable) where RT has not been enabled? Would there be users who
> want to use RT and Rust in that version?
> 

Got it.
Thank you, Boqun. Appreciate your clarity.

> Regards,
> Boqun
> 

Regards,
Eder

> [...]
> 


