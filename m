Return-Path: <linux-kernel+bounces-441115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C439EC9CF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7035A1889DB8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3730B1EC4D5;
	Wed, 11 Dec 2024 09:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TfnDwz7P"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF68F1DFE26
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733911094; cv=none; b=eP1z3Cp7UUBeKos5Iy/WflkJKn4J6I1ZpdI2dfbJIRBv2vLj/yDJUjlYfRj7nJYM5WzTEWUBUqqjqokdnBNaRuG1JQMH8yHDgG3Jpid0htnxOuiNLdUEbamtdb8MGOxDYpOe0VZXFCMtAwNab06egJiU4xVj9OExl0pjCadXHpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733911094; c=relaxed/simple;
	bh=y55wIex4pQa90iKPixPdpPl4dg3F27VPnM0gGblWQU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsc644qNFOIc4PZtgV9/P6/VWWm3twnFxnE749xJo7Ym7IWssLvIw51aR73d6SEKgoUlJVuRf9h/CnIFlHW4LFBHF/BA6Q7iPdmmmaGZV02V6bJZjUj4w2iKiVITd0GvYdaB8/DvVivMFzw0QiK8gTK5u6gsNfE7tHNCWD3Vd2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TfnDwz7P; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa696d3901bso502292066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733911091; x=1734515891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NoxTFED1OV6IIvC50S+pNWi2oVo0JYbWqlKUFL/WbNs=;
        b=TfnDwz7P/Es/1+oaRhrBdgIW6swgsVmB63F0CKqhNnsCTQI8srKuh1IrCxVYzmHFZ2
         vzy4ughepjnl1jJVytDqG6V9fsW6ok/kvwagCcDfIbdgAcyLK0FirT8Jij1vndvmr6sB
         8wl3GO3+/sZxIzXihGYJ2aotX7QrOn7XvAQYEDZt/MYwrcWr6/aPcS+Si1IhoSPHyZll
         Q3DwuT1tOnGDhhmqh4q5t0boYfM9EXFJxpybOaabb/bGKhTyx7TYdtezBnGZwpIqCHfg
         pAfvYJAHj91P3A1vQpCfgkEsotg6OQ2tsUzLKwHReezNPEQw3XJaVwhYqnOgyc2jOKJb
         oyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733911091; x=1734515891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoxTFED1OV6IIvC50S+pNWi2oVo0JYbWqlKUFL/WbNs=;
        b=MRCSjZbMod7EYJ4HtR3NFdZEdozm2AW902Dhymgqqjx4L8trYYiHZO3yWtOz8WhrSS
         VR+/izrOmW6vG2Grz1K2MupkjFohjrsy0COkwb7bgBVwbrI6g/BSGOusgwhgFG3zi2Mo
         Z1n2viNSwgAIEaIa3QCqjXrcHBnANE2Vi5PmWmopNQ3qZGbl57kgKubaQr/TmyPHBT5W
         YV0d72NDPoosHnaP3oGXnKr77dPvkK4B89xEOEUhIVxBjkHLTE5mEtAOaveyNb4vJrQf
         2dftStal6dmLnuPFfIHMYbfp6oltxcf39wlWXNCGmIWodXz9hdHPma3L3j8dqur3tbeh
         jA9g==
X-Forwarded-Encrypted: i=1; AJvYcCU2jizj1delKyCUtHEzbdUle3BvCUmLaYeB9+THtcxJmszPd565qvj/fQnGi5Ltc9nI6VYUUP8p9jQkcB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK0wfLrNA8bJPvgvmiqGEscax1SHpD8noJ6CaCdnlVz5nNzRRt
	/Q0xJ+9HYTAn19rubS+JDhZRO3ThuCwYOKa/S0y7DJviwg+W58ouTB5lcxSJRA==
X-Gm-Gg: ASbGncvYb+dbF8AND+R5Kpl7I6EO/ArBoR2niDIgxu/YsJ3BC+4275SnEtTy0BNWrCh
	1b5Cl3Nfz/9Ver8jyvoxAb9srdKprCHJFa4oZkpPKalVpr4AoURvYsWMW3ZIJlnQBS78u51LIss
	A/1b5pn/2kbwVir72FICxtiQsBoIH5ipdtNV4ehXrpch0xTKUyxyV05ypUU605KMtnTXjtA/it2
	dH+6hR6lGzpHiVwQ6HrpUcttmf4clkk90TzKbwrkdWhhkayhpddoOeVIIDzuAzQEGEF3RCMh5r1
	LaYLepfIKByv
X-Google-Smtp-Source: AGHT+IF/0ntKZsypMhJqLoHZz7Y4KeXzGESSzQOBIbmcxUlmHH3DEZpbKATmONAsAAvwZztD3FrYtg==
X-Received: by 2002:a17:907:7707:b0:aa6:79fa:b483 with SMTP id a640c23a62f3a-aa6b0f1f0c0mr192342966b.0.1733911090953;
        Wed, 11 Dec 2024 01:58:10 -0800 (PST)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa68880b3f7sm432885166b.92.2024.12.11.01.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 01:58:10 -0800 (PST)
Date: Wed, 11 Dec 2024 09:58:07 +0000
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
Message-ID: <Z1liL3BtoPnSyvlh@google.com>
References: <20241203103735.2267589-1-qperret@google.com>
 <20241203103735.2267589-11-qperret@google.com>
 <CA+EHjTwHSyQ1FJc7axbLNuBxSWpRVE6brb34nO+F59=QRmfQEg@mail.gmail.com>
 <Z1hhHRdpCZcLs046@google.com>
 <CA+EHjTw4GX3j_ssN-tWnf780xkvyKO5mBN6fnvXeWvQcBDmcNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTw4GX3j_ssN-tWnf780xkvyKO5mBN6fnvXeWvQcBDmcNg@mail.gmail.com>

On Tuesday 10 Dec 2024 at 15:51:01 (+0000), Fuad Tabba wrote:
> On Tue, 10 Dec 2024 at 15:41, Quentin Perret <qperret@google.com> wrote:
> > > Initially I thought the comment was related to the warning below,
> > > which confused me.
> >
> > It actually is about the warning below :-)
> >
> > > Now I think what you're trying to say is that we'll
> > > allow the share, and the (unrelated to the comment) warning is to
> > > ensure that the PKVM_PAGE_SHARED_OWNED is consistent with the share
> > > count.
> >
> > So, the only case where the host should ever attempt do use
> > __pkvm_host_share_guest() on a page that is already shared is for a page
> > already shared *with an np-guest*. The page->host_share_guest_count being
> > elevated is the easiest way to check that the page is indeed in that
> > state, hence the warning.
> >
> > If for example the host was trying to share with an np-guest a page that
> > is currently shared with the hypervisor, that check would fail. We can
> > discuss whether or not we would want to allow it, but for now there is
> > strictly no need for it so I went with the restrictive option. We can
> > relax that constraint later if need be.
> >
> > > I think what you should have here, which would work better with the
> > > comment, is something like:
> > >
> > >                 /* Only host to np-guest multi-sharing is tolerated */
> > > +               if (pkvm_hyp_vcpu_is_protected(vcpu))
> > > +                       return -EPERM;
> > >
> > > That would even make the comment unnecessary.
> >
> > I would prefer not adding this here, handle___pkvm_host_share_guest() in
> > hyp-main.c already does that for us.
> 
> I understand now, and I agree that an additional check isn't
> necessary. Could you clarify the comment though? It's the word "only"
> that threw me off, since to me it implied that the check was enforcing
> the word "only". Maybe:
> 
> >                 /* Tolerate host to np-guest multi-sharing. */

I guess 'only' is somewhat important, it is the _only_ type of
multi-sharing that we allow and the check enforces precisely that. The
WARN_ON() will be triggered for any other type of multi-sharing, so we
are really checking that _only_ np-guest multi-sharing goes through.

Perhaps the confusing part is that the code as-is relies on WARN_ON()
being fatal for the enforcement. Would it help if I changed the 'break'
statement right after to 'fallthrough' so we proceed to return -EPERM?
In practice we won't return anything as the hypervisor will panic, but
I presume it is better from a logic perspective.

Cheers,
Quentin

