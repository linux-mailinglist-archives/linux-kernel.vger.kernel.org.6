Return-Path: <linux-kernel+bounces-388806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3269B649C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0BD28325F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A6013FEE;
	Wed, 30 Oct 2024 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECSgIwLR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB563D551
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296134; cv=none; b=u/MG2XoMKqENmbiQyxSS6NG6KlR/+aj+hfvAe43Rt7Ns4uz9jcJWHVrKjA0U3/QxX9O0rTHcLbC9KIetWix3HcxtKfomnoanZJJLuV04h6iOJE+jdo7o738z2oy4VgjueVFtKVvH6TidSqrJXcHRy2Y9wHVf0QhwIZztG3yrWMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296134; c=relaxed/simple;
	bh=l29xjMvWd5IzFEym1SdeJT/5uE5SzAyDVBZM5T+wfow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cjsflnQv6pom/lvjyjWTrsUvJZqIZCffnE3en2T5zv7tW3T1FRvTrvSuy8BBGZliFb54fu29vAfJyaW9xpeVUXGS4ICDtaMetX+9RisfX/I5l+M0L7JB3MmoG8H+H4zxp0wMlHOZ50s4wuBxgd5/Qzc/NW14vpsd07I0Q7lEPmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECSgIwLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CCBC4CED1
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 13:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730296133;
	bh=l29xjMvWd5IzFEym1SdeJT/5uE5SzAyDVBZM5T+wfow=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ECSgIwLR13qCsQcxcgWKx7mLKaXwrrDJdUvpmzsgGQ4t9HeIcU5CDu02sQfbIMAmx
	 YVW2lrpSs8NnRQrjA0dscfJgAK3ZozIP40i3SGrpMiJoAnoACZbltghK8IlGpMEhPK
	 I9RUmm5zX6UqFjN6G8wtNAWtIS2XIGF+2sJDY739CoZegLmk9T0ZwYOe9DdQxqxg1+
	 0WChpy3Zm9s5Z4jik6W2sK8R4y5T136x/A4bUz3c3pXFYrb312+OBNxUcWzDD/pcgK
	 OFHU3R9pcJJMLguit0l6o/4GqvYxvd3r6mcScMZMr45abDPCpFTBQh44Iyqp3JDAZb
	 LmH4a62aIcPWg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb4ec17f5cso59672321fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 06:48:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVtgxv06ZhlpfEQCEW/aX0twS/y1HGq3J2gdfKiBBnZ0tDGByW5FefJT5uizP6SiQLOEeGyMGbv1CY0X9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywut0sKCjXYSBC5eok7qG0yASFDFsBOJ4Z7tjYkww+483EtTLL
	c2Cy+2RntCMBKdf9OD9SavGCF+vibbFttJSNev+uTQ8d7CPVpZTxk8LsrozedCUMg6gLAuRMOWS
	yH5yAGHaKeMAvHxj82ZUZdf2N9H4=
X-Google-Smtp-Source: AGHT+IFtq4EtnqrroYItyFo72u+yn8LxIyPbI0vN4T1+ioELAZ476zVUyFG3o8hJBQBfVrJOI3bVhga2K4K/hCe5Hag=
X-Received: by 2002:a05:6512:1047:b0:53a:40e:d547 with SMTP id
 2adb3069b0e04-53b7ecd58damr2272034e87.5.1730296132256; Wed, 30 Oct 2024
 06:48:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009160438.3884381-7-ardb+git@google.com> <CAMj1kXHzahaLRH_0nSQaS7L+so0WRwh4R6SLdb1R+Hm3s-o1dA@mail.gmail.com>
 <1dea1f19-c247-435b-9c73-a0181914024d@suse.com>
In-Reply-To: <1dea1f19-c247-435b-9c73-a0181914024d@suse.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 30 Oct 2024 14:48:40 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFgoEk65bJBU=eZccYUdZCqF3Bk2pMAZCA4TviC3U9ExQ@mail.gmail.com>
Message-ID: <CAMj1kXFgoEk65bJBU=eZccYUdZCqF3Bk2pMAZCA4TviC3U9ExQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] x86/xen: Drop absolute references from startup code
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Jason Andryuk <jason.andryuk@amd.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Oct 2024 at 13:54, J=C3=BCrgen Gro=C3=9F <jgross@suse.com> wrote=
:
>
> On 29.10.24 13:50, Ard Biesheuvel wrote:
> > On Wed, 9 Oct 2024 at 18:09, Ard Biesheuvel <ardb+git@google.com> wrote=
:
> >>
..
> >
> > Ping?
>
> I have queued this series for 6.13.
>

Thanks!

