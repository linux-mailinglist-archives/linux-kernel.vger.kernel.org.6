Return-Path: <linux-kernel+bounces-294555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 156BF958F2F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A54C3B21C9C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 20:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201CD1B86F8;
	Tue, 20 Aug 2024 20:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tgRtuVRZ"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B6018E37E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724186057; cv=none; b=JBs9yDuLObj6xczjlHj/XVrAx+h5q2tdQYllrb9fjTMv4Iso1DBNM8pP9WYEZyh6Ym81dTc8n+koD7IO9IL2TacRe2El8uz9GTBkr9uEJHAqsjEUdzhy9RkcRkoRIwvIzWEQfOLKVh6VKhvkkTpNYi8AwR0Sqgu+WdnnJ06FwGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724186057; c=relaxed/simple;
	bh=5RSjYAptncdnAFs9hgIluwZIfQYIr4GHh6ncopv/BTY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XGjue3AoBFtDLTHa7wsKaWE74GOg1i87iTf96yMFZZbnofRzuUhErt1YKUo6HiUH9JqjLBss3NVAbmc62ANaWCsnB/MTgFGB7UCfkWS7lbwhDxAyqCyg2iFD5pCd+wKDAJ1X/HDD3r4pLWNTBWtRYme17f2IlcbdlHGcpqE3ags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tgRtuVRZ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-713f3b4c9f7so1989545b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 13:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724186055; x=1724790855; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kd+ewASCpW77J5gF5QDORqnMd64hp17cU2w/2dYfqY4=;
        b=tgRtuVRZDb3e2uFoxpKEIiIqJBbUWVQ2efphsREpSd9VCUUeg/+ZCkH2IxoGzfHqUU
         HutxHCvx7yavrjXWJh/HR13VO21ZSMezY15uDPgHH4zXfWKOG5A7IzgmW8ALaBq0NIXT
         SvAJSDV7EVLLb4mNxS5Zq6YpPGxo/pK25I+yW0MqiiORhzbhYqMHRSZ/5SneezkwjH1n
         2o36wKsm+S38kmNTCUkWdyyVk36ekDH4Ds8R225rAHUVB5V4izGzI6BPDrVmKbaO4yyx
         +deWRj9F+xtqT92dijbUebbqj/t5R0ZjSkGmwR75DRS6Kr0NBmbx5Fk2pKfHFWHlfpcC
         Ll9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724186055; x=1724790855;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kd+ewASCpW77J5gF5QDORqnMd64hp17cU2w/2dYfqY4=;
        b=M4wtVYj/bz0AkHQd82dBCgthiUz9I0yqE2mKY1i45ABKqalTTtMqDvr3pi0sz4vI26
         N0Rx7pflZf3BcfOciw+u9vlW1EZcMWBUD0kTzu213vuICCHpg29gO5FVmJTDbwniAuZX
         6tAYGsLS5kJlL4cCGMSNnbGhqr1d6ro2h80ziLs27iHw53luOYtpPqqwvWqJbz/q5k2w
         YP2W5xmoo+4AhiZWytRcacoEyNqoaruecF3CL2mGc/Y1Gm5u1j4Hzeex0DHyk+c6CuIv
         C0TRMEaStRlSaglqFTQaGSXVE7Z2pIP801u8egs+z5ZnPPJHKfEPYQK+SJkQj+FkaJci
         wb8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWNtyBZVLE4O+yQT3m/xvb71XI7f6XdarP+NB4ksTkWFB3DUqIY95cFppLSvf3/INDerguqak7aDJCNjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqlgKKO2SOeapk7f8+Kr34J1f9jv1jds0Bz845wWNN+LRIXa8b
	w5jWt+mHc63X0t1M0UQ5iqZD54qkCfIr/64U4x+XgbzEHw2OVQ5FVbEnyNe+3g==
X-Google-Smtp-Source: AGHT+IEagC2uQewyGBn9WX/jNwmgC7oC1B57d2Rg81j/emB0euZaM2zxQkM+LosTYuLqvTx7CZiEmQ==
X-Received: by 2002:a05:6a00:2296:b0:710:4d08:e094 with SMTP id d2e1a72fcca58-7142374a879mr403138b3a.2.1724186054994;
        Tue, 20 Aug 2024 13:34:14 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef5457sm8629985b3a.127.2024.08.20.13.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 13:34:13 -0700 (PDT)
Date: Tue, 20 Aug 2024 13:33:59 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Vincent Donnefort <vdonnefort@google.com>
cc: Matthew Wilcox <willy@infradead.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    David Hildenbrand <david@redhat.com>, 
    Andrew Bresticker <abrestic@rivosinc.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, maz@kernel.org, seanjc@google.com
Subject: Re: [PATCH v2] mm/memory: Don't require head page for do_set_pmd()
In-Reply-To: <ZsL_XvRL-OgEqmvv@google.com>
Message-ID: <0d4f99bd-609a-8c76-b665-adcf942e6a74@google.com>
References: <20240611153216.2794513-1-abrestic@rivosinc.com> <8040793f-e9e9-4a2e-807c-afcb310a48f5@redhat.com> <20240611110622.8e9892e92618ddc36bca11b7@linux-foundation.org> <ZmiVy8iE93HGkBWv@casper.infradead.org> <ZsL_XvRL-OgEqmvv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 19 Aug 2024, Vincent Donnefort wrote:
> On Tue, Jun 11, 2024 at 07:22:03PM +0100, Matthew Wilcox wrote:
> > On Tue, Jun 11, 2024 at 11:06:22AM -0700, Andrew Morton wrote:
...
> > > You know what I'm going to ask ;) I'm assuming that the runtime effects
> > > are "small performance optimization" and that "should we backport the
> > > fix" is "no".
> > 
> > We're going to stop using PMDs to map large folios unless the fault is
> > within the first 4KiB of the PMD.  No idea how many workloads that
> > affects, but it only needs to be backported as far as v6.8, so we
> > may as well backport it.
> 
> Hi, I am reviving this thread after noticing this comment attached
> to the fix.
> 
> If you intend to install PTE level mappings for faults that happen outside of
> the first 4KiB, I believe this will make THP support for KVM ineffective.

You can relax, it's okay: where Matthew wrote "We're going to stop...",
he was describing the runtime effects of the bug (now fixed) to Andrew,
not proposing to make a change to mess up THP support.

The fix was backported to v6.9.N, but was too late for v6.8.N EOL.

Hugh

