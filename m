Return-Path: <linux-kernel+bounces-441140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F269ECA38
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F7E1647A4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F43208986;
	Wed, 11 Dec 2024 10:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S9AOKAcj"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE9F1EC4DF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733912520; cv=none; b=sHpibo7qJVyCfPDTy3xek3kzAZ0U01Vc9TvJIOLTfgakgTiVilTWU72qCfuAFEZcMnurlN1TruxyhC8DaxsN/VVD6YLlGmcJZVjr7Voda6XQTb67jGD6/DKVbTTCFtspgKfmWevzQ4aWDzWQShyIEHD6SaBXhRFnapy5C9S6x3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733912520; c=relaxed/simple;
	bh=1ajsGx5epWGwETVA1PUvGD6fRkYAWzEtK6sJbfZFdYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5I71uPDzyXAYwmNsiErQV8p4WtbESJVyQ4E3crOIPOYJtv1BRjZ3i2u74HY3hIOEsV1LGFwN2dTFqf9Dh42v7nVdLq4QQxR87MpgeQW1XSGumNKEBTPtVclbN7N+7T0WzTKcW7F3E6gcd5v4//ejWvcfWXhUkKgV+jB/wyU5nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S9AOKAcj; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so8501848a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733912517; x=1734517317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h/i8dNvXTaun9z8Q9pOEyBWkakhPhjAhJI5wRL2G2nQ=;
        b=S9AOKAcjUTH8psqn6MnFf+USJ3q9F3Aj3bwVv+IqJF0Awk2hvwRYkKTmBHsH87SIkE
         fWcDWQArmp2JbWXAjZCopES+qKcoe3KFiOW6PICgvkWcPOrkL/xOsYVX6cFm9DMUszgq
         6ShaY36V0F3uVfNfSEVXMUPXzoO5vBaawpncYS0jgVm2xosherwf8u9blzQjvdkgVxf4
         jJErXngXntrLb01JsnVu+UuJrjdgTM6BRsr9DENuY0vf2+wGLf7J5PYPVkcAZYanS3Bb
         d5w96ep+mbPSWQ54QisxO/l/oHnSt7PitKkhzZ4NMr5dO0lnCd4BCwYn2PgESmfZfuJi
         oW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733912517; x=1734517317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/i8dNvXTaun9z8Q9pOEyBWkakhPhjAhJI5wRL2G2nQ=;
        b=hX+qduc45ykVdX6bS9OCjvRRUZ+cwQMKfW8h0P0U9ehxcgnDI2X9IAQHSlUfpBvsgU
         wC13vfRzE9kf97totIOza4HILsbnUyqCULKiBni9KuVVVh8qUHNVAuZ0lbHMRf3MjM7M
         xzZOd87Un4FQGGfocF8OlFRPcH0SFbpQYZSplvYfFYGpqUcXH1hi0302elkYewx1Kdhk
         Uht9eDbYfNuhv4Vo39TQZNGUN8qV0sPh0F0fQ3WFAwUxPpWD1KcUFz5JVHhO9hPHDB8c
         s4r8b5hDIIqsKmhHC4xXUp0x4am5slNgAyIsYrFtLldR4T1jk4a+zUUdFwfo3w5lGAz2
         JJNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWftFrG6PY2hlB1cNHl55MfWl1a567iDIfJfnEGV0dvlbJT+mEKPLrsc5svLedGk/i5L/EAJEwK+87K/bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ3/LM9vPugRtwV6YaBtQJzpmcdf2pLVEYG7a+ZqxiUaRqs4Cm
	lXOKrHZwiBloCG/YjKLnyLaV/TO7YMCznCp2N8bw1hn3v8dr1EMdvNPNSpZwEQ==
X-Gm-Gg: ASbGnctR/fDUss3nARHnni/6gMLf5vpgaex43wLezdYYSCDCv4dd1dD7Jgphh2a7Gwz
	yeeHUqYMWCTWB5TdFk9ud1hhq18+YiFZ42sk+bRbWdbI9pPokqmBAHPV/ezEFqG2IYelrFxbSux
	/VXTZTF/RkLWX5vvYeAdX86JBRBznLbIRk/zqtWj6RuGdO/IHIFzbf/A6AGsMWZUKDEd8pH4dJM
	Xr2A3rX1pt39DFhZ1oiJGDFDOf5Cj6ww2TVGoaGFJCN6ck7W7psEi2/wSvmcXbuMxbXi8eaaxsO
	0gj55UdrkNgZ
X-Google-Smtp-Source: AGHT+IELT5UzTgOIXuU7LZ69/dEjIwcPQX35BOSNVLAIcwuMifyoSthPeY6StXkxja6PnQSGI29ikg==
X-Received: by 2002:a05:6402:3806:b0:5d2:7396:b0ca with SMTP id 4fb4d7f45d1cf-5d4330a5108mr2074782a12.12.1733912516917;
        Wed, 11 Dec 2024 02:21:56 -0800 (PST)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3d871f1c8sm6587655a12.13.2024.12.11.02.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 02:21:56 -0800 (PST)
Date: Wed, 11 Dec 2024 10:21:53 +0000
From: Quentin Perret <qperret@google.com>
To: Fuad Tabba <tabba@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Sebastian Ene <sebastianene@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/18] KVM: arm64: Introduce __pkvm_host_share_guest()
Message-ID: <Z1lnwZPrx9GzgFCG@google.com>
References: <20241203103735.2267589-1-qperret@google.com>
 <20241203103735.2267589-11-qperret@google.com>
 <CA+EHjTwHSyQ1FJc7axbLNuBxSWpRVE6brb34nO+F59=QRmfQEg@mail.gmail.com>
 <Z1hhHRdpCZcLs046@google.com>
 <CA+EHjTw4GX3j_ssN-tWnf780xkvyKO5mBN6fnvXeWvQcBDmcNg@mail.gmail.com>
 <Z1liL3BtoPnSyvlh@google.com>
 <CA+EHjTw+3oAcp3ujjPmbcu42=95nw8WA=rZHYFL91ZK_Wfs_vA@mail.gmail.com>
 <Z1lmG-3KnOZrOCCa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1lmG-3KnOZrOCCa@google.com>

On Wednesday 11 Dec 2024 at 10:14:51 (+0000), Quentin Perret wrote:
> On Wednesday 11 Dec 2024 at 10:07:16 (+0000), Fuad Tabba wrote:
> > On Wed, 11 Dec 2024 at 09:58, Quentin Perret <qperret@google.com> wrote:
> > >
> > > On Tuesday 10 Dec 2024 at 15:51:01 (+0000), Fuad Tabba wrote:
> > > > On Tue, 10 Dec 2024 at 15:41, Quentin Perret <qperret@google.com> wrote:
> > > > > > Initially I thought the comment was related to the warning below,
> > > > > > which confused me.
> > > > >
> > > > > It actually is about the warning below :-)
> > > > >
> > > > > > Now I think what you're trying to say is that we'll
> > > > > > allow the share, and the (unrelated to the comment) warning is to
> > > > > > ensure that the PKVM_PAGE_SHARED_OWNED is consistent with the share
> > > > > > count.
> > > > >
> > > > > So, the only case where the host should ever attempt do use
> > > > > __pkvm_host_share_guest() on a page that is already shared is for a page
> > > > > already shared *with an np-guest*. The page->host_share_guest_count being
> > > > > elevated is the easiest way to check that the page is indeed in that
> > > > > state, hence the warning.
> > > > >
> > > > > If for example the host was trying to share with an np-guest a page that
> > > > > is currently shared with the hypervisor, that check would fail. We can
> > > > > discuss whether or not we would want to allow it, but for now there is
> > > > > strictly no need for it so I went with the restrictive option. We can
> > > > > relax that constraint later if need be.
> > > > >
> > > > > > I think what you should have here, which would work better with the
> > > > > > comment, is something like:
> > > > > >
> > > > > >                 /* Only host to np-guest multi-sharing is tolerated */
> > > > > > +               if (pkvm_hyp_vcpu_is_protected(vcpu))
> > > > > > +                       return -EPERM;
> > > > > >
> > > > > > That would even make the comment unnecessary.
> > > > >
> > > > > I would prefer not adding this here, handle___pkvm_host_share_guest() in
> > > > > hyp-main.c already does that for us.
> > > >
> > > > I understand now, and I agree that an additional check isn't
> > > > necessary. Could you clarify the comment though? It's the word "only"
> > > > that threw me off, since to me it implied that the check was enforcing
> > > > the word "only". Maybe:
> > > >
> > > > >                 /* Tolerate host to np-guest multi-sharing. */
> > >
> > > I guess 'only' is somewhat important, it is the _only_ type of
> > > multi-sharing that we allow and the check enforces precisely that. The
> > > WARN_ON() will be triggered for any other type of multi-sharing, so we
> > > are really checking that _only_ np-guest multi-sharing goes through.
> > >
> > > Perhaps the confusing part is that the code as-is relies on WARN_ON()
> > > being fatal for the enforcement. Would it help if I changed the 'break'
> > > statement right after to 'fallthrough' so we proceed to return -EPERM?
> > > In practice we won't return anything as the hypervisor will panic, but
> > > I presume it is better from a logic perspective.
> > 
> > It would, but then we wouldn't be tolerating np-guest multisharing,
> > but like you said, it's not like we're tolerating it now anyway.
> > 
> > I wonder if it would be better simply not to allow multisharing at all for now.
> 
> That would mean turning off MMU notifiers in the host and taking
> long-term GUP pins on np-guest pages I think. Multi-sharing can be
> caused by many things, KSM, the zero page ... so we we'd need to turn
> all of that off (IOW, no MMU notifiers).
> 
> That's more or less the status quo in Android, but I vote for not going
> down that path upstream. pKVM should ideally be transparent for np-guest
> support if at all possible.

And to clarify my suggestion above, we should fallthrough IFF
host_share_guest_count is 0, but break otherwise to retain multi-sharing
support. So it's not a simple s/break/fallthrough change, that needs a
tiny bit of added logic.

