Return-Path: <linux-kernel+bounces-389573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 925B09B6E91
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F05EB20F83
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB648215034;
	Wed, 30 Oct 2024 21:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ry2af5WU"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6001914F90
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730322889; cv=none; b=JNxFTLBGYmesQH+zy1MYUE2bsJfPzMsvXtGZR02TfsnO5gyIIcDm+orKxotYO7eyMJ1znybkck3atGdkI+fROCpwh/47p6NTBDoBncmdF4X0Pq8AOC5/mxpD7fUPeMXufFots9iZWv2/Pqd+ZBKD7CUtvOc0CmTjcMxYZkvTLjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730322889; c=relaxed/simple;
	bh=o534AfqHtN7RldxfitzK66PsnDX4NhPFj12yRB4Rmbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WkQSAHJ731HBkuDtYvauYfUzou/nDZRyNQBX6p8iyaPLABUCGD6uiYrW4wc3YmK5HgSM02NEevdEVeWZ+ILfnpmx8SiHB7gIuzH23oKzhxrKMP2OsDWss2vIdYEWcp/pj+ZGapu/FGntcQvMLYB0/6XErwL+T+VsPQvSIXi5Yog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ry2af5WU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43150ea2db6so37255e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730322886; x=1730927686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o534AfqHtN7RldxfitzK66PsnDX4NhPFj12yRB4Rmbs=;
        b=Ry2af5WUv/skSRNxT+7siplCwQWDhKtQfIsMjY9CKz4eMhiDaZX1feC5lYAe1PYbNz
         KNoCsxFUr1uBOAwYpDz8pWMPcz/SQtxG339IHGWDwqYztGZqfo22sfw5XoOMvVZJsl+f
         +twacZr2LJZsSmJBtLqUo4nwKOY8IxT/enb/U243vHrgZuhK6ZdUTMg9FPxNHD8lWP+K
         riMozXWSdTIv1OQR3UtxZU/nF3JvE8oOoKSnTlNpAMZEYs87ED4gijbier9TavT5e2pP
         XCwBYmqUx8tfgOtIIX/fLhhgI2Jfk1fqWyDYH2f32yzgDByNWx9UEjFSvRQbKWTsKg8E
         aABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730322886; x=1730927686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o534AfqHtN7RldxfitzK66PsnDX4NhPFj12yRB4Rmbs=;
        b=DzpldrM9e13bcaP1niiXfwJrlTVO5aSYmOmIvBlWlvIiZd4EZKXHCiejnaBshfRbcA
         /gHoUsPR8lpL/oBzDT7pmUBy4uIY9+Vscqf0NrbBpuKMJ2GH6Rk0cdMkE5gnP0097/PL
         zc6oSUNI6OpQWN+d4LH/70GcBh2+iOqq4vQX+iAFOQf7qpJcc/THgbZcJh4fHSUGalIl
         /KgGhXBEKqFysyvQys2attTb6j6zR6/AGbtfdCnIFrLClm0j4tbx7tDqhrAX/n+Qd9Sf
         fBh2kgmACL3MkuAiOqnEGqJXvI1YT48Bne0H+Z9QFACrea6miSazSkumlbpY4SAQ1eeG
         +wXw==
X-Forwarded-Encrypted: i=1; AJvYcCXeEinrAYpRRxi70FzbzpXvG1EyYAXoZs8kgtNFgNWKQ/XyahEGKoPN2gUNr3WAsQUH3w02Gk784ClfSeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNEG1jiTlEBTUZQQ5nL+ExDRdzzIIYwPkraWU3tCdTsK5R79ze
	LMSN7pfmSvJ3lrnR5UBIdn992T0tPE1tEdkGGPResJn83q9gmM4ObHWvKWWQ8+ty9BDx1TF/zm7
	ptD4eX4PnhzmA4sWMqIp3rc+KyijlW6UPh9lq
X-Gm-Gg: ASbGncvTNz56jqsonQOmcX7d7HM4aRqoL7w0l2uXsGOnnOzpb60oO0DGltjRxTUOnu8
	J5idqiqMmtkGy2KpTBQSRvQC9jFu+igk8y/s/mwwQZLij55JrqC7Ps7wCcmxzZA==
X-Google-Smtp-Source: AGHT+IGpbeaz+5KppTzbcYqEE1yAqTgZJWcDUhQHhbTL7VnBBuh5AYIfWrbwLxtiZ4nkFcdHa3790grpJGu5v7MdZew=
X-Received: by 2002:a05:600c:c8c:b0:42c:b0b0:513a with SMTP id
 5b1f17b1804b1-4327bdca213mr1401735e9.2.1730322885602; Wed, 30 Oct 2024
 14:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030170106.1501763-21-samitolvanen@google.com> <CA+icZUWTdgM7HQrnR_NzgZZQE3aXXk+tAqD3srNd1Eyjr5d7EA@mail.gmail.com>
In-Reply-To: <CA+icZUWTdgM7HQrnR_NzgZZQE3aXXk+tAqD3srNd1Eyjr5d7EA@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 30 Oct 2024 14:14:07 -0700
Message-ID: <CABCJKuepGSFcQa0F5iO4aa4V2UbhuKO+tyfhB3_ODaTGs3sM5Q@mail.gmail.com>
Subject: Re: [PATCH v5 00/19] Implement DWARF modversions
To: sedat.dilek@gmail.com
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, 
	Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sedat,

On Wed, Oct 30, 2024 at 2:00=E2=80=AFPM Sedat Dilek <sedat.dilek@gmail.com>=
 wrote:
>
> Hi Sami,
>
> perfect timing: Nathan uploaded SLIM LLVM toolchain v19.1.3
>
> KBUILD_GENDWARFKSYMS_STABLE is to be set manually?
> What value is recommended?

The usage is similar to KBUILD_SYMTYPES, you can just set
KBUILD_GENDWARFKSYMS_STABLE=3D1 to use --stable when calculating
versions. However, it's not normally necessary to set this flag at all
when building your own kernel, it's mostly for distributions.

Sami

