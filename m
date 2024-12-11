Return-Path: <linux-kernel+bounces-441128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438CC9ECA0C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46F9162DE1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B7F1EC4ED;
	Wed, 11 Dec 2024 10:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4W3H8eWz"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D5B1DF723
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733912098; cv=none; b=d6nd59Ya/UpwR+ctbz6MGbKEzCrneDp5K/4LPu3uS6lf/53ujd9j7Rq7h2Eb+FfGhnxg04RXRAUCbuT5hDkTkgvL1brDuBnNwYB0HlaIgh+MAbdpTz49WkXHT6vqr/jyAUW7/EZdYJnJGL9bYQ9CpI9F37wY/MzCATIwQO5mdfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733912098; c=relaxed/simple;
	bh=8kPuR/R4ZmuxjLQhM3C4+YPUUpyXPzxmYEFgc4jJ63Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXURn/TlL4Wt1g0hn5ervkes2CBfJrEV8gSJBcn8ROD9IHL3NoSxLeXOAqHQFQG2stYTjB5bky80z159GLQS03KdWbsbLJeFl25dkVOXEcLSQjVUrPldP6l0JYCyGdJonFgnEJUHQH2zsF3K6cXf06R2KwtXAA18h14vz2RbLyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4W3H8eWz; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa6a618981eso300998766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733912095; x=1734516895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aAYNlgaGtbIb3faMoAC6BM9L0RPwmWJIn6sYTEEwFWM=;
        b=4W3H8eWzHt8erSc9csUyqgbtW4jjuQEnTvuRy93EH5xgViRA0OpimzlGVhrN7jNhMD
         Na0f9FrJWvtjizqEi2+cJb/CclaQoQIauluV6tkI6mTVgkktt3yF30PWPIXpevWk4l4D
         E8KNSnT7e1/wgD3Wsyxe6EF4Odvbp9Mf1KZP64VNG6MrTQh6JNGOCbSx0vdxmUZBh1Ty
         LGAND8kTr3G8srlE3PeZqq4r5kIXf8PljWcfWfPbLOG82aReJJtJ6zlPjyX3nwxxvEFP
         L3r5/Feu2XSz1D3UstILChmusqIDZ6OWCJSIRkVG6lkoRhqPlS6qm0gM2yvpjxrvnMCL
         PscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733912095; x=1734516895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAYNlgaGtbIb3faMoAC6BM9L0RPwmWJIn6sYTEEwFWM=;
        b=Eb7wf5FXj8D9/x8JAixDHT8QxSn7BPCGqVzNQX934V9yOZwjA8i+TWoKmFGt9BLgdE
         lG0Ia+SdkKjWglGMcS97VHVwm/8kgJ1ki9filDI7ikUhxRrUGlpopiTG/zDjR3SdFj5k
         pwUuzuRjvO0eotHHvWPLluVuJjwItn5CvqFMjLSnnhBlFMpgmBe4zYj2wT9hTaQ3vFdE
         c2EYOk1cbGKerBDCpFtpwYLqZDRhMBCAtBR52X9Eax2f5bi7lXQ1bhuNrLn5heKHyD7p
         ar0pviibD6Lrj/iurVX1z/jrN2tJPUYLiFLtKDDtllNmmFsb8OO/YVEOG+JzHWip1ztd
         eLVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk+HE8573GB/BZ+tgTQC9QJ60uo/TQdB3BAWcrRPwTnouSb610cxou2IjgaQ4oWPoEat/6SA2mWeg2/2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxruvtmjTSNbn1SrzZrlcbJabUEW/s5DcWIpGyI/v0MlJTGuSrj
	Fr3VaiwZTBofbZwkLeeFnRQLDhg/SPhOncDp9Q1i44NDETfqwgZyg9OKZ5uhZw==
X-Gm-Gg: ASbGncuXWR+W/24JMB5ST9TXopl3D3B4sqnBBRgAHcQI8BWyyjIYvP6F1cc5OlJCKAZ
	1Byl8RKezlE5RSIsYLIPg0YQ1SPx681dNglzBvDfMOyFaSzgvbsZabJwIp+ZHzVGSEoYZ0rlCOa
	RSJQCoaqhj4q+KvEIWFfPhKKeKAPMhQZtIMZvHmbuxNH7Zs5GbjF95zkP2ndCnnfupMN1Q2Z3Lh
	ktpbrZsBUcSB2AuEigjK/ZwIXGqFExM71ioURt6kBlMgdnlK367TBkv+TWFgshoiPNXK3WTP32+
	S6F9nHQqKKWX
X-Google-Smtp-Source: AGHT+IFMcTlkeGboQKqbrDdMcECPHEth8gqU16Ievc6ebB6cHKDKOmVuqDalLIEjr7JcNgbRfs9Dnw==
X-Received: by 2002:a17:907:1587:b0:aa6:6e02:e885 with SMTP id a640c23a62f3a-aa6b13b1375mr155243166b.47.1733912095003;
        Wed, 11 Dec 2024 02:14:55 -0800 (PST)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa67557f0desm553688466b.144.2024.12.11.02.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 02:14:54 -0800 (PST)
Date: Wed, 11 Dec 2024 10:14:51 +0000
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
Message-ID: <Z1lmG-3KnOZrOCCa@google.com>
References: <20241203103735.2267589-1-qperret@google.com>
 <20241203103735.2267589-11-qperret@google.com>
 <CA+EHjTwHSyQ1FJc7axbLNuBxSWpRVE6brb34nO+F59=QRmfQEg@mail.gmail.com>
 <Z1hhHRdpCZcLs046@google.com>
 <CA+EHjTw4GX3j_ssN-tWnf780xkvyKO5mBN6fnvXeWvQcBDmcNg@mail.gmail.com>
 <Z1liL3BtoPnSyvlh@google.com>
 <CA+EHjTw+3oAcp3ujjPmbcu42=95nw8WA=rZHYFL91ZK_Wfs_vA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTw+3oAcp3ujjPmbcu42=95nw8WA=rZHYFL91ZK_Wfs_vA@mail.gmail.com>

On Wednesday 11 Dec 2024 at 10:07:16 (+0000), Fuad Tabba wrote:
> On Wed, 11 Dec 2024 at 09:58, Quentin Perret <qperret@google.com> wrote:
> >
> > On Tuesday 10 Dec 2024 at 15:51:01 (+0000), Fuad Tabba wrote:
> > > On Tue, 10 Dec 2024 at 15:41, Quentin Perret <qperret@google.com> wrote:
> > > > > Initially I thought the comment was related to the warning below,
> > > > > which confused me.
> > > >
> > > > It actually is about the warning below :-)
> > > >
> > > > > Now I think what you're trying to say is that we'll
> > > > > allow the share, and the (unrelated to the comment) warning is to
> > > > > ensure that the PKVM_PAGE_SHARED_OWNED is consistent with the share
> > > > > count.
> > > >
> > > > So, the only case where the host should ever attempt do use
> > > > __pkvm_host_share_guest() on a page that is already shared is for a page
> > > > already shared *with an np-guest*. The page->host_share_guest_count being
> > > > elevated is the easiest way to check that the page is indeed in that
> > > > state, hence the warning.
> > > >
> > > > If for example the host was trying to share with an np-guest a page that
> > > > is currently shared with the hypervisor, that check would fail. We can
> > > > discuss whether or not we would want to allow it, but for now there is
> > > > strictly no need for it so I went with the restrictive option. We can
> > > > relax that constraint later if need be.
> > > >
> > > > > I think what you should have here, which would work better with the
> > > > > comment, is something like:
> > > > >
> > > > >                 /* Only host to np-guest multi-sharing is tolerated */
> > > > > +               if (pkvm_hyp_vcpu_is_protected(vcpu))
> > > > > +                       return -EPERM;
> > > > >
> > > > > That would even make the comment unnecessary.
> > > >
> > > > I would prefer not adding this here, handle___pkvm_host_share_guest() in
> > > > hyp-main.c already does that for us.
> > >
> > > I understand now, and I agree that an additional check isn't
> > > necessary. Could you clarify the comment though? It's the word "only"
> > > that threw me off, since to me it implied that the check was enforcing
> > > the word "only". Maybe:
> > >
> > > >                 /* Tolerate host to np-guest multi-sharing. */
> >
> > I guess 'only' is somewhat important, it is the _only_ type of
> > multi-sharing that we allow and the check enforces precisely that. The
> > WARN_ON() will be triggered for any other type of multi-sharing, so we
> > are really checking that _only_ np-guest multi-sharing goes through.
> >
> > Perhaps the confusing part is that the code as-is relies on WARN_ON()
> > being fatal for the enforcement. Would it help if I changed the 'break'
> > statement right after to 'fallthrough' so we proceed to return -EPERM?
> > In practice we won't return anything as the hypervisor will panic, but
> > I presume it is better from a logic perspective.
> 
> It would, but then we wouldn't be tolerating np-guest multisharing,
> but like you said, it's not like we're tolerating it now anyway.
> 
> I wonder if it would be better simply not to allow multisharing at all for now.

That would mean turning off MMU notifiers in the host and taking
long-term GUP pins on np-guest pages I think. Multi-sharing can be
caused by many things, KSM, the zero page ... so we we'd need to turn
all of that off (IOW, no MMU notifiers).

That's more or less the status quo in Android, but I vote for not going
down that path upstream. pKVM should ideally be transparent for np-guest
support if at all possible.

Thanks,
Quentin

