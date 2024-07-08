Return-Path: <linux-kernel+bounces-244294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 349B892A246
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6598A1C215B5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE5613C3F6;
	Mon,  8 Jul 2024 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0vvqDe8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86D53C08A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440496; cv=none; b=pmqSuapibdUOIRbV6oMv7V5f5U6SFuLHy2Ww24gfbN7Wzu2OKYieqIQ0inHlPnelaJxr7FNsKDOUGX4IvmVz83r7W0674RsRUtRXoR2OQBKVq7eyma7Z9EL1D08N0MCGHgw+3+BDL9uyM6wll5oLpLuKXaGzHWkpT4t8s3Wnyw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440496; c=relaxed/simple;
	bh=CZz0OjF+N3d/uH296pPaOfWKFpaq9SpRo0F+caUTF6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7ZtRAFuldGGL/HDL987y1TuXTs3E7GzqJke3Rjcq9lq5u9j5c4mRHjzyLmceL3sp15q3FJBqphWgtzAAeZP5yGzXu3i5WDSvYT/7fdbMaenfVYhimho/25bjPGXX1A//mmXA3q4FSxV6SxSgC10IrYcqk+0Qr3hVo3Au2NXz0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h0vvqDe8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720440493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nwb/NHCNDPBbNOYdrz+GYj8J2TCseSslvd8sX/M8mWk=;
	b=h0vvqDe8ogmpj3+nSGVKfQmMZMw9Hiw/9bf973evxfzsnfJs4kayuvF5qez0SUe0KeYA+Y
	HzEhrGrjgq9pU8kLg+GZMsXFSaycgVBWJ21frk8ZllG0XaRO8R+UAS8HWr7BHYWFFGlzcH
	MZeDg/yeH0emLnO+2fPVQ8YWYf+G+J4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-bq_DEXeJOnu7jSAyH_mHaw-1; Mon, 08 Jul 2024 08:08:12 -0400
X-MC-Unique: bq_DEXeJOnu7jSAyH_mHaw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-75ea23782f5so1586812a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 05:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720440490; x=1721045290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nwb/NHCNDPBbNOYdrz+GYj8J2TCseSslvd8sX/M8mWk=;
        b=VAn304rVmjsElbx/WKmn39Z2RKn8EWPWGL3TdyfPh5uRHYY1zmZWP4NwxceTkVOJnC
         TTyYqvKocG4fAXwWBIzgH5dY+p2YoS9OYqoM4XCzCb+ArNpR3YuKbMOgEQLYNxHuFlp4
         VSNO5x29bE61V7clxB32nazbOdzwponVOe1zZRfa7SYayKMoL+blUVNLj+G5q9DRzZkb
         s9wKIWTe+HTL1dLurP6wLydPaBZHGV9tsAfPN8Bm9bmJ+kT5LM54YaUOU8HPaQZPYRe2
         3O+ieQ/xW4EFg92eUfNalFJlqOGjWfa2zrgfimN2a6LZFEU6pHjiP+o2J9Ivk/T1rVx8
         OJpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYMaQxfu9Cea1u09J7BAU9bZjFN3ReQxuHgE3WRLwtKE5uT+O04WePpTSishEo2myG2ugVjQHIU6ksJev4+j2kj/QGktKxuFOcw/XZ
X-Gm-Message-State: AOJu0YzerT1bKX5dzkQdUmd39SBy88afSKtMj7DxMveyJNtZUZVAmftP
	70tIlNUWa+wWOtsrkj5QaXZkGH9XV81O/3iGjPsM4adYEPatlB+5IXRrCXSF85fCNa2U2pMsz0o
	kcyjAQx35V/dUDZ2T10r5lEbnF7IXWGeYuTPNFyBhqMdi+gtEYOCpIXYnzZ0J2T1zUTEVJN5GYS
	MwhkloimjgoG5pYrVR/IyN62hjl12sVjSWKHZr
X-Received: by 2002:a17:90a:ac0d:b0:2c9:7616:dec7 with SMTP id 98e67ed59e1d1-2c99c54186fmr7125412a91.6.1720440490510;
        Mon, 08 Jul 2024 05:08:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPwHzsQDzGu+xR3DQUoweoTT1Kf7TAdTBOw1dFR4nyWDCgQYp85Jk5+a4EU54LIpsTE9hEkS0qlGqZ3527u2o=
X-Received: by 2002:a17:90a:ac0d:b0:2c9:7616:dec7 with SMTP id
 98e67ed59e1d1-2c99c54186fmr7125397a91.6.1720440490094; Mon, 08 Jul 2024
 05:08:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705133348.728901-1-ast@fiberby.net> <20240705133348.728901-2-ast@fiberby.net>
 <aadf8f7c-2f99-4282-b94e-9c46c55975dd@fiberby.net>
In-Reply-To: <aadf8f7c-2f99-4282-b94e-9c46c55975dd@fiberby.net>
From: Davide Caratti <dcaratti@redhat.com>
Date: Mon, 8 Jul 2024 14:07:58 +0200
Message-ID: <CAKa-r6u85yD=Ct4nq2xZLXLT+3vWsz+WoDZ__xS4tkpge=yf-Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 01/10] net/sched: flower: refactor tunnel flag definitions
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Ilya Maximets <i.maximets@ovn.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Ratheesh Kannoth <rkannoth@marvell.com>, Florian Westphal <fw@strlen.de>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org, 
	Stephen Hemminger <stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello,

On Mon, Jul 8, 2024 at 1:12=E2=80=AFPM Asbj=C3=B8rn Sloth T=C3=B8nnesen <as=
t@fiberby.net> wrote:
>

[...]

> Davide, I think David Ahern would be happy [1] if you could post a new ip=
route2 patch,
> since the kernel patches should preferably hit net-next this week (due to=
 uAPI breakage).

I will send an updated patch (don't use "matches" + add missing man
page + rename keywords [1])  in the next hours.
thanks,
--=20
davide

[1]

> Nit: I would prefix all of these with "tun_".

"tun_" or just "tun" ? please note that each flag can have a "no"
prefix, so is it better

notuncsum
notundf
notunoam
notuncrit

or

notun_csum
notun_df
notun_oam
notun_crit

?

(I'm for not using the underscore - but I'm open to ideas: please let me kn=
ow)


