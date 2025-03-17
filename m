Return-Path: <linux-kernel+bounces-563327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B286EA63E2B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 05:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B679B3A9CF9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 04:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34E62080F4;
	Mon, 17 Mar 2025 04:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDdF4YCA"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C4379D2;
	Mon, 17 Mar 2025 04:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742185628; cv=none; b=lTLit0xDfvLN88iCBccHzSRtrLM9E4pcyFsroYcCuxcLvv1wIWPhzclzMx+HnpDZYP9anmE3K5k11bojFUOtykcweXhkNER3itfMRq6nug7IYRRu5LHOKD0BZXmANWywyEl8vVp/rqLMcjA485cEunNlc8hUKHyCzYGI7RePS5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742185628; c=relaxed/simple;
	bh=AgtBxj/n5u7Itf1qBybXgrDtPW1FAxI6g48lwbFGmgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AdqME/nqHRsFyQLU30WOsz75dVMZ/t7xxBYuLDiNfUZPpjDKdODMFuStgGZ05yPWbPyjskIYjCxVKnaDAe9KxAgjSfAo5w3OPovpzFYfu8r9uYtD+XTdzqrafV8ZDsk9QjAQThaR2Bed6B4trgp0thMOTxCXGXjoa0jJsY4T0qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDdF4YCA; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff4a4f901fso2290740a91.2;
        Sun, 16 Mar 2025 21:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742185625; x=1742790425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgtBxj/n5u7Itf1qBybXgrDtPW1FAxI6g48lwbFGmgo=;
        b=BDdF4YCAx//adktHwe3nbBC9tn3GZQFIJSRgKWDnQClWifvuTcOYEKEa+azS9oWs+G
         9+S2iGJ1l5uoUmbrn2cYINj2MuPqVpcvHsvDG2aKshhtv1WonbPa1JxfWNUNrAeT399R
         aZXOsFyKGLiPIHI2HIXy6PAJLlFbSnt2ayBmH/nI1ZXcj7ehAKgRPPPnq5y/ZNcWsxIF
         J9VbAJTcl4LAnJcvXlR1jl19HtwV5lmsj74Etd9PdGdcelMXpFsIhvUnCuXy8R+3t0aT
         17Bf73sxpmAdiwUgpHiEnnh2hRqK+wCZoPwqx5UkbHBwr//IyFcWu7weert8gPTkWWg0
         jREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742185625; x=1742790425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgtBxj/n5u7Itf1qBybXgrDtPW1FAxI6g48lwbFGmgo=;
        b=XAJoELvc4nLDhiH1JVGwy/JI50AICuUbRCRVjvN5w3D0WYyyBOS1PRcDns5IKRnI+a
         C/kC8EMup2syuG6fDNVa0l+luz7MGjXlrDmTnvYRWDc9QvpTlDnJ6kFlMQ16IcTsNWD8
         XgzLcqRkuG3u3SdS8wYy+fHrzdy8xoMHX4EhYdTKZ76eUf3qJCbKdJk7kjevX4nM7Ium
         RGdUeIlQnOFD+VPkk6UmLfhvyKSO1d92xhgKudAP+y8YztruDc/ust0xWPqqvELDw1zL
         Fz3dAYAVMrhczB4IDyY61za0qBINrhBoQ0KNK9IBG95C49vPy3PQknbM2XNnwzKpPto/
         ma5A==
X-Forwarded-Encrypted: i=1; AJvYcCUThfoRUoFECLclP38gn0jWKR/mKIHGUxk+mf6Z3iTezPOelsMCeEXnsWcL5Y7cgAa6DkT00wbir1Zc@vger.kernel.org, AJvYcCX04Dz4oqtWtvqViZu4vE6b1dJ5srpCEb0aBUsOqXGF0p2cAM58kO7iXvoBeZdF12siXQVHXrm2Qdsg0dH3@vger.kernel.org
X-Gm-Message-State: AOJu0YxuJrOieHjsD5zZG8hmP0y3/2cKQQY07zaXCk1/hjkidjkSuoR4
	2fMdckF6mtgSBW+TGmjzwe+ZxBIbndcuFFfv5O1Q6I2ej8CXxsS/v6Qjqclhmom5NptRW+JGpbt
	ZDJmRKSdAp7vWG0ZyOfJzMxd3whM=
X-Gm-Gg: ASbGnctYpUMOzi9NorI6QxNg2lepNbBZVBRYv2GOsuHowTk17nEGc9ZG96kQ2xJR65s
	ma1VM5zngVRqENdl9m3OaRVVGV1I9WwtJIzGhM4Gawry7pgtFGFd+r1O7UVX6/32op9oJJNSp54
	nhFy46J95Jzcysv4pZlLjaPJtoPss=
X-Google-Smtp-Source: AGHT+IFyNG/dsUI+ZNZxH6N7qbP/lk6L75Yj4d83Rj08EmzIRycu9pH4DGPprCpXrJrf7PTggG7vaz1r82zS7GQ7rVk=
X-Received: by 2002:a17:90b:1642:b0:2fe:994d:613b with SMTP id
 98e67ed59e1d1-30151db9cd5mr13101676a91.35.1742185625064; Sun, 16 Mar 2025
 21:27:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241222002957.2582212-1-masahiroy@kernel.org> <CAK7LNATVrJLPQSCVTxKARm_4wk=Piem1ZHMA-8c8CfaZPs0H7Q@mail.gmail.com>
In-Reply-To: <CAK7LNATVrJLPQSCVTxKARm_4wk=Piem1ZHMA-8c8CfaZPs0H7Q@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 17 Mar 2025 07:26:53 +0300
X-Gm-Features: AQ5f1JruVnqdoDpIbkTEVdgv2q-Jd1nrTbkp8_d_-yN6ALX9eZvRWcJtS-P9b_s
Message-ID: <CAMo8BfKgLgWiTVre_zSy3SMm-tJySgmJpVDphtE7C1kFZsuwZw@mail.gmail.com>
Subject: Re: [PATCH] xtensa: migrate to the generic rule for built-in DTB
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2025 at 1:37=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Sun, Dec 22, 2024 at 9:30=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > Commit 654102df2ac2 ("kbuild: add generic support for built-in boot
> > DTBs") introduced generic support for built-in DTBs.
> >
> > Select GENERIC_BUILTIN_DTB to use the generic rule.
> >
> > To keep consistency across architectures, this commit also renames
> > CONFIG_BUILTIN_DTB_SOURCE to CONFIG_BUILTIN_DTB_NAME.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Ping?

Thanks, applied to my xtensa tree.
Sorry for the delay.

-- Max

