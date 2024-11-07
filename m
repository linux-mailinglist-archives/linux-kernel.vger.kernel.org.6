Return-Path: <linux-kernel+bounces-400370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291C29C0CA0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9734DB232A9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F80A212639;
	Thu,  7 Nov 2024 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDsMOhmN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E6E2170B4
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730999399; cv=none; b=j69YCHDNQMSisHH5VLT+x6lfmRfb1WsagUoCW5xUDXrZjPck0dPgYl3mWeF2Isk4Za76GR2t3sjidm14YpOA5kGUP4TT5Av03JCqrpyjt9ov2LEifZpmow+W+6K3dTkpQzTeN7XiLnqc6zZvHIY+/8+qPWRTO/Dd4SCfERCFPLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730999399; c=relaxed/simple;
	bh=Sc2kkmVag8JZmDQQOGAev4MWjffkUtOpARZ1iWbbcjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbUtQJsAZgV3kimDbgVbelB7yHy/0Q5NbDsO6QsfU0q/v/NrJSPjJ9Re/zgxqp2cAdW3hz509Sm4UgUAbhAIT6vB6E/xDjx0gfAD3Jlf4YUBzwQR19ZbNZiJHki/56B5bt4tb8cjvJaSDvJ2OwCowSaZ440jjUMfjONGawtuyow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eDsMOhmN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730999396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+AA5XAlWwCizTNJ1aw2XWsbcfdnUBQq1EXYsuL1VNjM=;
	b=eDsMOhmNa0G6fnYMNCD2yRiK0MZHN5VWRSNr9mDOMfFEV5Z29IvktVllzaOtaWg5MinNt4
	eOh2vWgKlP/LAE2GLei9elXupAd9LW0cTR5zbCAxNO+dJRPVJT9He2bR7S03HxNKdarHO8
	yzQgQmubcPyCIcKahmY/5t3vKCuVNis=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-R5_5PKKvM_-8Jd4rn86yCw-1; Thu,
 07 Nov 2024 12:09:51 -0500
X-MC-Unique: R5_5PKKvM_-8Jd4rn86yCw-1
X-Mimecast-MFC-AGG-ID: R5_5PKKvM_-8Jd4rn86yCw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 429FA1955F10;
	Thu,  7 Nov 2024 17:09:47 +0000 (UTC)
Received: from f39 (unknown [10.39.192.153])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53B811953880;
	Thu,  7 Nov 2024 17:09:40 +0000 (UTC)
Date: Thu, 7 Nov 2024 18:09:37 +0100
From: Eder Zulian <ezulian@redhat.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tglx@linutronix.de,
	williams@redhat.com, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	jlelli@redhat.com, peterz@infradead.org, mingo@redhat.com,
	will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
	bigeasy@linutronix.de, sfr@canb.auug.org.au, hpa@zytor.com
Subject: Re: [PATCH v3 0/1] rust: helpers: Avoid raw_spin_lock initialization
 for PREEMPT_RT
Message-ID: <Zyz0UWH--MHjTy8r@f39>
References: <20241107163223.2092690-1-ezulian@redhat.com>
 <CANiq72nmWeyXkV0fhKwQESm10OdVuS7UGAux2N3ic2B0zNhuuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nmWeyXkV0fhKwQESm10OdVuS7UGAux2N3ic2B0zNhuuQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Miguel,

On Thu, Nov 07, 2024 at 05:50:50PM +0100, Miguel Ojeda wrote:
> On Thu, Nov 7, 2024 at 5:33 PM Eder Zulian <ezulian@redhat.com> wrote:
> >
> > As a note, at the time of writing, RUST support for x86_64 depends on
> > !(MITIGATION_RETHUNK && KASAN) || RUSTC_VERSION >= 108300. Miguel Ojeda
> > pointed out that this can be avoided with Rust 1.83, to be released in 3
> > weeks (2024-11-28).
> 
> I was referring there to the "or" in that condition, i.e. the "||
> RUSTC_VERSION >= 108300" part. In other words, it was just a comment I
> made to explain in the other thread that disabling KASAN or RETHUNK is
> not needed anymore when you use 1.83 in the future. :)
> 

Yes, I thought that was clear all along.

> But that seems unrelated to the patch here, so normally you wouldn't
> add it to the cover letter. Or am I missing something? Same for the
> `make rustavailable` note below (i.e. `RUST=y` already implies that).
> 

Noted. I don't think you're missing anything. Thank you for the hints.

> (Of course, no need to resend anything for this -- it is just a note
> to clarify, and anyway the cover letter does not go into the
> repository :)
> 
> Thanks!
> 
> Cheers,
> Miguel
> 

Thank you,
Eder


