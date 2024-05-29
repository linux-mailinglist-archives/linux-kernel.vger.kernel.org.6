Return-Path: <linux-kernel+bounces-193802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1F58D3255
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2FB51F21357
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6546B169AE5;
	Wed, 29 May 2024 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vJEWMipw"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408F71667E7
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972793; cv=none; b=D24npv32Exzglm3vMAlxjnZfCyqMFh0wTmhEFeaapjvFXPEJc8c8A7koFm4+p7Nh0VeRxhSza/OKWnwJW6dTygBv4RKhzEyXbwYuJ/rSQdaHzdEEpDI/o+/UCv3/RpV3pkH/RWgsb5oy4iQ7adylViTHitAp9YZZtMaKtEnkwnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972793; c=relaxed/simple;
	bh=QCfVXtnCs7WY3k2qMYQ4vLPo1KSeBO4uzrNDFx+BWog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6K8vg6Jbe9V/ou4bjF0Rn4wPiK7PbLTnz82O6ni3guK9NhN3R/xzd4SLK/+nvVLU6g85qkWnWLEh9cWhfDd5YX3ohF+zJgytUevX+XTyIwvd2MIyLG2eQJlm7+tnUZNkLG4+thj8ow1ZeDgze1CxEOXBVFA9hyewsLaUNI88Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=vJEWMipw; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 218A73FE64
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716972783;
	bh=QCfVXtnCs7WY3k2qMYQ4vLPo1KSeBO4uzrNDFx+BWog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=vJEWMipw9P5h2xDaJtdufVoVvBfYaDmscDiRRSyQ7URaIQnLXf5Z99ZlIzB8kpBY7
	 vDk2WQQGrg8yrkfyjDFR52mI1ibWrRsR+NqMJtXUL4oD2k+o2CLdqqbb5g++6VuHMU
	 kJdrVjXHwqa3fVkLMnZTIvUWzqHlhIpF1RP7M0O+DMavysUlJHC204fOgm8a2RroSS
	 WIgipwH2q8/Ob5y0Nc51shEZ1txHgVNCugVoXEkSfNCwcev/4u5zQDFDyZ9jnfHlRK
	 XOGC4tohmEczcI8Myeyp868GlOjaptN0Drg+0xCU6SLSoxp+n2VtgaCJGRnZkaQFyU
	 Snh2rF1jvUdTw==
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-804e5ab903aso600778241.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716972779; x=1717577579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCfVXtnCs7WY3k2qMYQ4vLPo1KSeBO4uzrNDFx+BWog=;
        b=cve6t5vwqulRPLIA81CvH3/quWeAN8ugvJWGFUn0qkWPc1q44o3EbUZ0U4hpBCtUJK
         CfDQVmNEiwUMy7WcIjNQigEL0gYfa1w28gidGAzA6Fo8fXGsaqgeFEOYRkWKcWV11iN3
         DP7I1EqCLmu4gaPq/gPID7DfkSGhvBwbSRjC9wexndJatGEqjWAd+HfbU6M9BlsyGcpF
         rOu58tRipIRYrEBu8r3oyee07TQurVoZN+aug3+DaJdd1vaLwcodfIdePFydJxjp4RSB
         SgIucyLJ+j/aIHNmfaG2d20G2e4FZpm+20YV1bj0yHnxkzU7cxmDZYg6Cxx+MVJVo/JH
         Nn6A==
X-Forwarded-Encrypted: i=1; AJvYcCVefFc0OpEnNRCvWto9YNhVJ1gxvbtfeUHEsYapIwtX6iGcNskX+aSDQmVrG1lzLSlsGdZWlYwa8Ii8LPqevGt9yXQ+/smNn6vLmAY7
X-Gm-Message-State: AOJu0Yy8fktqkFXpCB0I1yMmNgWNZ5Bo3LAzUs4GqP1SGrvCe+WI/xnd
	fenJpjGjcnSDWDqN1qRQuz2GmfkIUoClAGIJeK+2MLpl2N8TSx04C5Nhml7XEarShhCgGCefCOw
	irvT4AktDLbGeDJtYGV13S/BIcKPSnSN22FC0iLnMbYtmZVQlQepjy4XCEa4BPhQmuh+v7ZeQcR
	lSZi7CTO6betC9zKr2FdhC465+AqprFHoku0YA+SdZEVmrUShaKC+9nUU8y9tlXzo=
X-Received: by 2002:a67:c785:0:b0:47b:9a99:1095 with SMTP id ada2fe7eead31-48a386578a9mr13864469137.22.1716972779569;
        Wed, 29 May 2024 01:52:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBU76YpQlFY2UJv0tgEjKDgWppXEyfB71ym+oY7J1c/WWZcbXXSNxBYobvE3FHejzdUgE+u4qAdOFVsGnbUdA=
X-Received: by 2002:a67:c785:0:b0:47b:9a99:1095 with SMTP id
 ada2fe7eead31-48a386578a9mr13864453137.22.1716972779220; Wed, 29 May 2024
 01:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528203030.10839-1-aleksandr.mikhalitsyn@canonical.com>
 <20240529-orchester-abklatsch-2d29bd940e89@brauner> <CANn89iLOqXZO_nD0FBUvJypgTA6NTL2dKvXYDxpMuZReYZXFDQ@mail.gmail.com>
In-Reply-To: <CANn89iLOqXZO_nD0FBUvJypgTA6NTL2dKvXYDxpMuZReYZXFDQ@mail.gmail.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Wed, 29 May 2024 10:52:48 +0200
Message-ID: <CAEivzxccCgT17u45c3fRG4=+X-rxLz04L8+B5B4GD=weA5khmQ@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: correctly iterate over the target netns in inet_dump_ifaddr()
To: Eric Dumazet <edumazet@google.com>
Cc: Christian Brauner <brauner@kernel.org>, kuba@kernel.org, dsahern@kernel.org, 
	pabeni@redhat.com, stgraber@stgraber.org, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 10:29=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, May 29, 2024 at 9:49=E2=80=AFAM Christian Brauner <brauner@kernel=
org> wrote:
> >
> > On Tue, May 28, 2024 at 10:30:30PM +0200, Alexander Mikhalitsyn wrote:
> > > A recent change to inet_dump_ifaddr had the function incorrectly iter=
ate
> > > over net rather than tgt_net, resulting in the data coming for the
> > > incorrect network namespace.
> > >
> > > Fixes: cdb2f80f1c10 ("inet: use xa_array iterator to implement inet_d=
ump_ifaddr()")
> > > Reported-by: St=C3=A9phane Graber <stgraber@stgraber.org>
> > > Closes: https://github.com/lxc/incus/issues/892
> > > Bisected-by: St=C3=A9phane Graber <stgraber@stgraber.org>
> > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical=
com>
> > > Tested-by: St=C3=A9phane Graber <stgraber@stgraber.org>
> > > ---
> >
> > Acked-by: Christian Brauner <brauner@kernel.org>
>
> Thanks a lot for the bisection and the fix !

Thanks, Eric!

>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

