Return-Path: <linux-kernel+bounces-194132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD008D3727
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6501C21A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12318DF58;
	Wed, 29 May 2024 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMwr4x20"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70A9DDAD
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716988244; cv=none; b=UUm+l2nep5EwDK7ys6Rz5h/pX3PRllj4TZrr8PpFXUUFV8oY7ArKn5BNZyEBJfTdBR8r25m9MXZOCy1xIRlWLXEEpfk9XoSpu7l99nJ2r97SmSUVYcav+6YAEV5Lwyu9EYzKDIc9OWRqghRnA9uCLrcor/teWwEbnciACLgpkDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716988244; c=relaxed/simple;
	bh=cLMWqTZ4eP4dETUfafvDYBzH6ujk3BWpl5aJZcG0BWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pEF+ZXBn23+fpYhNb/sIBwbMZFQu8ttSP6TDgeqhDidlOd5aLphK9ksA5kI2ckiyjzea0xTclywPZwWumjQ8LpqqKBd2i7brBS50BhwFvj+TQdmspPxanD/lmgWsjjjHWpP9u3WXoAWSP53hQ2tjIZQvEW+Mf6xbbYn5u9ekZ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMwr4x20; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4211fb904a8so2843985e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 06:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716988241; x=1717593041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dyAFBwewJ+RHjYJS8brY7i+iKSDpb+pqY0B3wakOdQ=;
        b=SMwr4x20r+cpyxpq22s/pXt0e1geWqQsR9cVjS1DatdlIl8BRx+fANBywZVbQkIE1S
         aQZz7GM6sq4Gj7u24OydHLUa7v73yOo7+waNeVTTgp3r4R1OIECF0GNFGIDpuTElJxuN
         E2vzgLhQ6NH3qOnXGvmN1G4jGRpiiaq3Y0v3ZTGCQiUkfCQ7Wf7lYSsDb5FjlpEe82uq
         YjGjJO9nQ+7sVLR44zUC7DkAQsK3hBbYekuqjZYcb48KXHHz+ISniLkrcO9bRppMG7jS
         O98+WoTuDeuZKsHVKJ025Kd/Aj+OLbwG7NJjNZPYHHIth0Pygj0Vtlx/Guo7LBJxSqZf
         d6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716988241; x=1717593041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dyAFBwewJ+RHjYJS8brY7i+iKSDpb+pqY0B3wakOdQ=;
        b=HNHoN7f46WitOk9PTz9CwanwatPRSdjeR5mY1fZrMJgFIhyraz3w/+Fc2YlyJ4JWgn
         xnkakMgRTb/uWa7RDEpDWPyB2jR5/d/1/LsrnZkGnc7J5rR+ydN+WyPksVBhcdBthkJX
         siSyyhcV43qOdMgvVvlozcCFnvxhavYRoOFyyWPjchLM+lrCZ/loDnjMxpce087YcFQt
         8wJ+N6fbznTZcV19lrbsEprfh294VEE4BQci1RmT0dQ9rTpapfWGrB4luz6FSn+hYyeH
         y9rHDtKvzFEoIRyZ+vN6jzCPaGql2aOcHIlUe1TnxMSeLDp5WSv0WcXETH6CUw8sfUGR
         52tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf3QmMvONXEUCMURjnT3z9TCJcASGiBSgdobyn/ObTiAlN5D/Tq5gU12wkA3r/8XhdkBf5noBZGMtFWHD/ooZgmkDczZOkaPCxgQkd
X-Gm-Message-State: AOJu0Yxy8WhBs0OZ8GtKpT11L8DunrMs0Trc+f7vCNBkst7sJ26dz8vg
	vf+ddTTYCFSScWDZ3hwipGzSVkk9RXAI/Ma5J+pFkNxkMDiwmSHSjhTPj6i/QSBpVB6VAkJhgoc
	oQjZWB0vxKBUo8p3xEsxUvlKpmqc=
X-Google-Smtp-Source: AGHT+IGA/M/hJXwlEOyt6h3DY7L4fXZNrF3jZ9FvZ6aVVsxzgoo9H8gw3knpd8eHwKo0UObNN/izdY73yxFYV9PdCyE=
X-Received: by 2002:a5d:5309:0:b0:34d:b5d6:fe4b with SMTP id
 ffacd0b85a97d-3552fe02ee8mr10973005f8f.4.1716988241174; Wed, 29 May 2024
 06:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZlM_Ndng_JstAee3@kernel.org> <Zk9UCsZdizqC1_36@kernel.org>
 <ZkxN0yQ7Fb0X26hT@kernel.org> <20240521023957.2587005-1-jaewon31.kim@samsung.com>
 <20240521025329epcms1p6ce11064c0f0608a0156d82fda7ef285c@epcms1p6>
 <20240521101753epcms1p50443f6b88adea211dd9bbb417dd57cb1@epcms1p5>
 <20240524090715epcms1p274939a1d5954be3423f6ce14a3df6f92@epcms1p2>
 <20240527013504epcms1p22bec7b83f2a42e76877b97ed0d769009@epcms1p2>
 <CGME20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76@epcms1p7>
 <20240529095119epcms1p73f0e9ff756bcb2ee6a14db459128a644@epcms1p7> <20240529113519.jupuazcf754zjxzy@master>
In-Reply-To: <20240529113519.jupuazcf754zjxzy@master>
From: Jaewon Kim <jaewon31.kim@gmail.com>
Date: Wed, 29 May 2024 22:10:29 +0900
Message-ID: <CAJrd-UuiDq-o=r7tK=CG6Q3yeARQBEAtaov2yqO6e6tBwJZoqQ@mail.gmail.com>
Subject: Re: (2) [RESEND PATCH 00/10] memblock: introduce memsize showing
 reserved memory
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Jaewon Kim <jaewon31.kim@samsung.com>, Mike Rapoport <rppt@kernel.org>, 
	"vbabka@suse.cz" <vbabka@suse.cz>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tkjos@google.com" <tkjos@google.com>, 
	Pintu Agarwal <pintu.ping@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(Sorry I might forget to change to be plain text)

Oh good thing, I did not know this patch. Thanks.

By the way, I've tried to get memblock/memory and kernel log from a
device based on
v6.6.17 kernel device, to see upstream patches above.
memblok/memory does not show region for
0x00000000_80000000..0x0x00000000_8195ffff.

   0: 0x0000000081960000..0x00000000819fffff    0 NONE

The kernel log shows information for 0x0000000080000000..0x00000000813fffff=
, but
we don't see information for 0x0000000081400000..0x000000008195ffff
from kernel log.

(I removed the name.)
<6>[    0.000000][    T0] OF: reserved mem:
0x0000000080000000..0x0000000080dfffff (14336 KiB) nomap non-reusable
AAA
<6>[    0.000000][    T0] OF: reserved mem:
0x0000000080e00000..0x00000000811fffff (4096 KiB) nomap non-reusable
BBB
<6>[    0.000000][    T0] OF: reserved mem:
0x0000000081200000..0x00000000813fffff (2048 KiB) nomap non-reusable
CCC
<6>[    0.000000][    T0] OF: reserved mem:
0x0000000081a00000..0x0000000081a3ffff (256 KiB) nomap non-reusable DD

A smart parser should gather these kernel log and memblock/memory log
and should show
log like my memsize logic shows below.
0x0000000081400000-0x0000000081960000 0x00560000 (    5504 KB ) nomap
unusable unknown

Thank you
Jaewon

On Wed, May 29, 2024 at 8:35=E2=80=AFPM Wei Yang <richard.weiyang@gmail.com=
> wrote:
>
> On Wed, May 29, 2024 at 06:51:19PM +0900, Jaewon Kim wrote:
> ><!DOCTYPE html>
> ><html>
> ><head>
> ...
>
> Would you mind sending it in pure text again?
>
> --
> Wei Yang
> Help you, Help me

