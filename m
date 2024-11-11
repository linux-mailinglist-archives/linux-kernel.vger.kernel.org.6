Return-Path: <linux-kernel+bounces-404828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D88E9C4925
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 23:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EA51B27EC7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68951BCA01;
	Mon, 11 Nov 2024 22:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0bj9OHT4"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91771BC085
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 22:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731362883; cv=none; b=TtP3sYNmM+ssSZwWyJD7xpEhGbhl2RU8gUB2HC0AGCvWNnD8AOop4wGI+y089fdVJG+R2TQVRqtAGMo+HN8vuW++cqxvXlkv/xlbRlw/QPNpFR6EtoLaTdoo7Syr1s61+IzveTs1McNhGvB9haPJ46rdspaQ4UAO9ks2LqFanHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731362883; c=relaxed/simple;
	bh=Vkw9aiH8d9WZpxuAadKWoblhX0idLaFADugfMPK2FbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQJlJ9SDxMaiX0kZXhS8VbJOamd55PTLkTjnVFKriQsk592rsdko9NJyYxceq7rSylg87th5lbQprglYCLhfYhSsYA6hNuv9eIDK8WA3S/So6fMhPVS5IOuiUh0MfBsvSOFk3Kjr1AehjloRTj0EtK1ecUk12pYMxhtfs9cz5pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0bj9OHT4; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-84fc818f518so1672607241.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731362880; x=1731967680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vkw9aiH8d9WZpxuAadKWoblhX0idLaFADugfMPK2FbE=;
        b=0bj9OHT4NDD762ZwKsKRkpOlf3fMbGnSYP0Q0IjgkuCX4mzA+3xmTbzvS/+98aJmbC
         x9Cdhrxu9PDDSvBSsQ0ev0LgPTYPPeP4U0658R6shr34d7nOaG5fJ8lRc/LmncGbhgPi
         wkCvrcxe43qhp+TAehCzPCTnoAYuhpytBK/frxZo+oRvKFmgy8u2ajjnCF+u8R3XUYSl
         QuU9uygEaM3mVjxEaVLqXlopoL0vernuSifEIfbXJlI0TMuXoONkxtLT6uBA270BU8Jm
         0TPbCznueXlvGESjuUukuk6d9vuy54+nPsFKX/QsJMy+vAuBqMbnfbAqSw/PFbVJ+rX0
         0jHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731362880; x=1731967680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vkw9aiH8d9WZpxuAadKWoblhX0idLaFADugfMPK2FbE=;
        b=TeQEW+fLcSMZSKOPtjOJIxksYA1oukfCP4JEGD9SdpnsND6+Ypog6II5dDDQWULrE7
         zOUZ4La+pC/gDhsfI1pRhetViLsR2esPJslbTXdJgwAOegLFuON/l4NrLhJ8Q33+AiEt
         S5zAInk5LmWdS/haTh8NEVRfx/1t+VRCuBjlEdcjlmQvEOuEfInM69etUGXxGASIxuSo
         nBPUWxU2zpcz2fNKvQ7oFAloaqUp9jO5+06TCLrsRW/2Y96brCDHOMJxqy2FQUu640X6
         6h0LG3n2IRMi3+1myoCRDH0toT9lYpYJKYhh3Gz/Z/N/ZuBpmpfvtDymS09wXSK0ZpOe
         Fvew==
X-Forwarded-Encrypted: i=1; AJvYcCUnB6vnllA8oovYAxKxj8HKOSj1uVi4fs4YMTBPQXSLGqaIGrZrv4OBvhLuU6LG3Ca9Hv3xMySBnboLmFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOnvBJU7iriRlT3pe7b/5GJC1bx5jRs75QqISU73rdTGDL6hU4
	Fxno+QGRpV3GM96vWpNALijgGvxRSWfHMYfQ4qlZRPlkqQvoa/tRuqqs0tJ+0MvElNT5syq0uN6
	1eNxVxQsGb0JMjplHwVv3RL2morYNq9hxS1Ak
X-Google-Smtp-Source: AGHT+IE+mJ8YJxgETrhDpFyAtuqtDnXfdwAd4OrI/XYP3rp++8cJXIhZ4Rh+GEw10wPDdRd2IdP9vdmQ22jlVDEDcUA=
X-Received: by 2002:a05:6102:fa9:b0:4a3:dd83:c0ac with SMTP id
 ada2fe7eead31-4aae1634755mr13500294137.20.1731362880431; Mon, 11 Nov 2024
 14:08:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241110152906.1747545-1-axboe@kernel.dk> <ZzI97bky3Rwzw18C@casper.infradead.org>
 <CAOUHufZX=fxTiKj20cft_Cq+6Q2Wo6tfq0HWucqsA3wCizteTg@mail.gmail.com> <ZzJ7obt4cLfFU-i2@casper.infradead.org>
In-Reply-To: <ZzJ7obt4cLfFU-i2@casper.infradead.org>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 11 Nov 2024 15:07:23 -0700
Message-ID: <CAOUHufadwDtw8rL76yay9m=KowPJQv67kx3hpEQ-KEYhxpdagw@mail.gmail.com>
Subject: Re: [PATCHSET v2 0/15] Uncached buffered IO
To: Matthew Wilcox <willy@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 2:48=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Nov 11, 2024 at 02:24:54PM -0700, Yu Zhao wrote:
> > Just to clarify that NOREUSE is NOT a noop since commit 17e8102 ("mm:
>
> maybe you should send a patch to the manpage?

I was under the impression that our engineers took care of that. But
apparently it's still pending:
https://lore.kernel.org/linux-man/20230320222057.1976956-1-talumbau@google.=
com/

Will find someone else to follow up on that.

