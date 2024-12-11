Return-Path: <linux-kernel+bounces-441150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4B89ECA61
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92463188C8A1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B5F1FDE00;
	Wed, 11 Dec 2024 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lmaLzb9E"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60AE236F89
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913214; cv=none; b=WHaaSWFLYFutuiTZMkUquFW/+9lS/3JnsZxxg08Uwm0SHd1D/Lef6fRsGhOG7+WpLAVGGyZT6tSm/TfLQVaT8w5eLeuusNUsXlijEnhU+RA+IxydMp9qxKEkBOAENEo0hcJRKYbkq/v+ACjP+PFkx6JsvJ91Cz5vGmLhzn2ePOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913214; c=relaxed/simple;
	bh=Klh/2rs0ugl0MobkIjhQMC3zR6rDn7Fgg36xGZ2/BqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8teYbfBBQJZ/jHo72pxGrNbkYG0ZAkDsV2NLVptv0XGdh7BsaNNnNEqs0taIx8NiyhyOINGZA4LViCKy5hBdQ4iisTOzGNArjVJW5R2XcbMWLqdP9VwtOEHe4y7vGjwOnsogdgBAURSpAe5lR7J7EV5ZtzuZlloZ0kXSvMyPhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lmaLzb9E; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434f150e9b5so30155e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733913211; x=1734518011; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xejb4B30VvRcDJwNO3f4C7XdZV+B2J5itS09MkCZKps=;
        b=lmaLzb9EB7hNyGEzs+hXS5HkbXFwHmaSBLCXKhRP5cIDfDrFj07OP5dpuYP8aK2C5w
         A2UsljyVcRNM6BgvW7n7oF1Cwxey5rBZxrgl6IF1BzuoeDPtmkbA06OcHp4bkl1+DsXS
         sXUrisbuiZ1DiJxVfTRCg1x3c81TDGVi+5AIJtpCGjCUa44WlL6uqsw6ARNfX/fNaajl
         S+UNsepOTGl5RWhmNb4FVT++hOx7uIbOPuhMbZ/wk2gTL+7T8++jefyLIE52ojrrFk3T
         1pgG16svGs0JX86ioUz6N/fJzoSaYR4PpIRMwRDTHDc/8UORjnLEVy6DghF1dsr+l0SW
         Bhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733913211; x=1734518011;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xejb4B30VvRcDJwNO3f4C7XdZV+B2J5itS09MkCZKps=;
        b=dTSwEnJ/B3de9NQaQ2VRWKS3QBVn8FTMBNA1FJLRxINocAaOo6C0JBrtxv3m1DDCB9
         Xbr9rDv502dtdhoZhHrzIJohWruDnY8bmdtlwrYRX5q27yw6kbJPkmDRL5CG6h0VqEbu
         rmvf2WGLjT/Oza2py9skF2qgmz9yQaU8+d9kuurNo7vDjDniuVSKhGq5Ac7hOJ9C7xsm
         3z4q6zT0OjYX2n8feBKiVzxU7zReciNKLvbWWaxgfsSkLfSyj7f3sHItkC50v1R0AwmW
         fZcxSiOOZt4N/sWWI8NdPgmYjyIv+1ipGGsJdKjwaqUlB0Q1nNebMVRsaqNhQNaWoorA
         dVNg==
X-Forwarded-Encrypted: i=1; AJvYcCW25dua7YnjUyjkcS63n4YIZA5yCuGi3VQfhGn5y4TDxMGa9yPktOiRcI+cq/T9Z5ZSDwZxim9WPpkGEiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNK9YScnZrIEbqwtucxHDZplHLEtFqPAty4Ot70j8VZqCLAWhP
	pKmjXce6SR4QF8D49GkWPr6+9aG4BXB/wEubBon1leGDvfCadYmvDpMHVCSL6Zthi+T5rQ6b2/W
	D8nx2/xqI6RYWxS+Og7EmU29zHjgy1t3APPof
X-Gm-Gg: ASbGncshMER5aRJ5cfFa2OHl7hbn7YvJaIpy44vSND6oIL9QpQ0iVKmgByN5DsuvfB7
	cFcSnPHjOB38iqWSOtdt7nuK7T6g5GeewmPDBSaxisyn2Smo6+F17PTunm1ZNRpX8
X-Google-Smtp-Source: AGHT+IEPQlrax4O3EDsziNcytBk/dvrQmghx9+yaCRsduLcL2uYnUAAv4LiQBh3FRM86KVDBUO7qSFBLmZPR9owFjyU=
X-Received: by 2002:a05:600c:490a:b0:42c:9e35:cde6 with SMTP id
 5b1f17b1804b1-4361c0e320bmr1012235e9.2.1733913211090; Wed, 11 Dec 2024
 02:33:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203103735.2267589-1-qperret@google.com> <20241203103735.2267589-11-qperret@google.com>
 <CA+EHjTwHSyQ1FJc7axbLNuBxSWpRVE6brb34nO+F59=QRmfQEg@mail.gmail.com>
 <Z1hhHRdpCZcLs046@google.com> <CA+EHjTw4GX3j_ssN-tWnf780xkvyKO5mBN6fnvXeWvQcBDmcNg@mail.gmail.com>
 <Z1liL3BtoPnSyvlh@google.com> <CA+EHjTw+3oAcp3ujjPmbcu42=95nw8WA=rZHYFL91ZK_Wfs_vA@mail.gmail.com>
 <Z1lmG-3KnOZrOCCa@google.com> <Z1lnwZPrx9GzgFCG@google.com>
In-Reply-To: <Z1lnwZPrx9GzgFCG@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 11 Dec 2024 10:32:54 +0000
Message-ID: <CA+EHjTzrL9v3DBGRht_-JPpfpd0eW1xYAMcbeNA83B1K64oPgg@mail.gmail.com>
Subject: Re: [PATCH v2 10/18] KVM: arm64: Introduce __pkvm_host_share_guest()
To: Quentin Perret <qperret@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 10:21, Quentin Perret <qperret@google.com> wrote:
>
> On Wednesday 11 Dec 2024 at 10:14:51 (+0000), Quentin Perret wrote:
> > On Wednesday 11 Dec 2024 at 10:07:16 (+0000), Fuad Tabba wrote:
> > > On Wed, 11 Dec 2024 at 09:58, Quentin Perret <qperret@google.com> wrote:
> > > >
> > > > On Tuesday 10 Dec 2024 at 15:51:01 (+0000), Fuad Tabba wrote:
> > > > > On Tue, 10 Dec 2024 at 15:41, Quentin Perret <qperret@google.com> wrote:
> > > > > > > Initially I thought the comment was related to the warning below,
> > > > > > > which confused me.
> > > > > >
> > > > > > It actually is about the warning below :-)
> > > > > >
> > > > > > > Now I think what you're trying to say is that we'll
> > > > > > > allow the share, and the (unrelated to the comment) warning is to
> > > > > > > ensure that the PKVM_PAGE_SHARED_OWNED is consistent with the share
> > > > > > > count.
> > > > > >
> > > > > > So, the only case where the host should ever attempt do use
> > > > > > __pkvm_host_share_guest() on a page that is already shared is for a page
> > > > > > already shared *with an np-guest*. The page->host_share_guest_count being
> > > > > > elevated is the easiest way to check that the page is indeed in that
> > > > > > state, hence the warning.
> > > > > >
> > > > > > If for example the host was trying to share with an np-guest a page that
> > > > > > is currently shared with the hypervisor, that check would fail. We can
> > > > > > discuss whether or not we would want to allow it, but for now there is
> > > > > > strictly no need for it so I went with the restrictive option. We can
> > > > > > relax that constraint later if need be.
> > > > > >
> > > > > > > I think what you should have here, which would work better with the
> > > > > > > comment, is something like:
> > > > > > >
> > > > > > >                 /* Only host to np-guest multi-sharing is tolerated */
> > > > > > > +               if (pkvm_hyp_vcpu_is_protected(vcpu))
> > > > > > > +                       return -EPERM;
> > > > > > >
> > > > > > > That would even make the comment unnecessary.
> > > > > >
> > > > > > I would prefer not adding this here, handle___pkvm_host_share_guest() in
> > > > > > hyp-main.c already does that for us.
> > > > >
> > > > > I understand now, and I agree that an additional check isn't
> > > > > necessary. Could you clarify the comment though? It's the word "only"
> > > > > that threw me off, since to me it implied that the check was enforcing
> > > > > the word "only". Maybe:
> > > > >
> > > > > >                 /* Tolerate host to np-guest multi-sharing. */
> > > >
> > > > I guess 'only' is somewhat important, it is the _only_ type of
> > > > multi-sharing that we allow and the check enforces precisely that. The
> > > > WARN_ON() will be triggered for any other type of multi-sharing, so we
> > > > are really checking that _only_ np-guest multi-sharing goes through.
> > > >
> > > > Perhaps the confusing part is that the code as-is relies on WARN_ON()
> > > > being fatal for the enforcement. Would it help if I changed the 'break'
> > > > statement right after to 'fallthrough' so we proceed to return -EPERM?
> > > > In practice we won't return anything as the hypervisor will panic, but
> > > > I presume it is better from a logic perspective.
> > >
> > > It would, but then we wouldn't be tolerating np-guest multisharing,
> > > but like you said, it's not like we're tolerating it now anyway.
> > >
> > > I wonder if it would be better simply not to allow multisharing at all for now.
> >
> > That would mean turning off MMU notifiers in the host and taking
> > long-term GUP pins on np-guest pages I think. Multi-sharing can be
> > caused by many things, KSM, the zero page ... so we we'd need to turn
> > all of that off (IOW, no MMU notifiers).
> >
> > That's more or less the status quo in Android, but I vote for not going
> > down that path upstream. pKVM should ideally be transparent for np-guest
> > support if at all possible.
>
> And to clarify my suggestion above, we should fallthrough IFF
> host_share_guest_count is 0, but break otherwise to retain multi-sharing
> support. So it's not a simple s/break/fallthrough change, that needs a
> tiny bit of added logic.

I think this would make things clearer. Thanks.

/fuad

