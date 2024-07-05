Return-Path: <linux-kernel+bounces-242737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D99E5928C65
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 18:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4B8282F06
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B30E16B38E;
	Fri,  5 Jul 2024 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8NUoOxn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E5A2F52
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720197499; cv=none; b=TAaDRF/IlkWeI2uXKYJmWZxkxFj0LXfSKI/lWhwRfvNB5xqCExa60LBKm06BlKL9CvdP2VYIl+LgmdpY5L6a7LegS0jotlj4C/eT5noS1/N8cY/aYKtC6GL6oYyUCD+bv6zrhGJBVeLgONABg0t6YapLrazAZWYDfciR0M1Hidw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720197499; c=relaxed/simple;
	bh=vbEdn9s1bX9Apz+VH7pesh77e94L7MUUh+JZaxSbQzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIIlbV+s5FAwZkJj7gkHfAma1sa8Oph/tCNe2vpVFvjQPkR1veAPj3NXrUOkf/9waQtts/E+WB6AW4AtO28zE2xYSfdMHdk7lEcWiT5Kbe9KB6EUAb56FNM4thwqJfJb8nURvhHWgL7hh+38IE7AO2/UGyxPD1ORHDVHpbABPzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8NUoOxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5875EC4AF11
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 16:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720197499;
	bh=vbEdn9s1bX9Apz+VH7pesh77e94L7MUUh+JZaxSbQzo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j8NUoOxntYSpnSlMTLUAI5bZjgxR2AVn3JqH938neZinLF8bkWcRIXQIJ2jCTsZcu
	 ZqZCfGsAkHgfuXa9x+Q9dfFgDii4UTv1ewBWYBzUHqz2q9sqiGqSO2JDYTU9FMJwUj
	 8gbaYF3OWIaAC1PVVA3MQ3a3n7gyaFKeKvjUvOzvXOr6Pr0nD7D4kBgwGMmbiLdizS
	 FFbH9XZ2ywtP9dFkzeZGLccsBhn2zvq335kDBbmAe9EUaE+pSMdiE0DJHCg6FVzZBw
	 XD1TRjI5K1JMAw7yf1a6qCRnnQ63f1N0ISOArumcWp6cwUEt7aNXjkQIhhFABNqjMW
	 SZ4PMVE0AtL8A==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-64f2fe21015so16455267b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 09:38:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2bclEML/S+dXarpjIbT4Pp+PuQ42Zxk+mYPac8FV6flB6FeNHgzH1bUwyuuEvU8XqCvcGINse/y8iUySf/ZMHq/Uo3tfukp7+hzq+
X-Gm-Message-State: AOJu0YwJRBpX2H/00t1M5/kcahZwTDvwiG9PRnyeFbJuWNVeiVXtzx2I
	/Pt+v9dM+MRZfh2w4QlN8j/TMiluufmdL2lvImkDW62QWd6IpZdHn8apq9zh6I7l63qgK/WHKpp
	A9rjwufGyEXTwr8LOu936XsSLfDkwU2Hx2xcZHQ==
X-Google-Smtp-Source: AGHT+IHbSmRZsNNYS2h5JtG2DnZP9kYtxEWmUQAgUpRZSXspcNezTrPrXYVQUe1Q5P4n1ZSFupmxsu/uD5ug/y4uiYI=
X-Received: by 2002:a05:690c:6801:b0:64a:7e85:9a90 with SMTP id
 00721157ae682-652d5c08344mr67634497b3.24.1720197498594; Fri, 05 Jul 2024
 09:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240622071231.576056-1-21cnbao@gmail.com> <557d7f05-6ba9-482d-b3fb-29eb72cdf09c@arm.com>
 <CAGsJ_4zQ0vjX1UM62o0Wsgh9XYW0SGv2cyG5gUpbP_+Tx3WZLg@mail.gmail.com>
 <76876c5f-f769-43f1-ad53-a4af288af467@arm.com> <CAGsJ_4zpn5dMNNNcVcMngT-mJpWV-bzUV+RfQaLLjxMC73xfig@mail.gmail.com>
 <f9fde05b-0340-49fc-92f9-7fa091580444@arm.com> <CAGsJ_4xf_s57g5NmxbzFSZqyU05n4CoF5PFTZO73CE4CmB9fEw@mail.gmail.com>
 <fba6439c-9710-4b0a-873c-334058166c03@arm.com> <20240704161026.1e10805b184d7c7f07158622@linux-foundation.org>
In-Reply-To: <20240704161026.1e10805b184d7c7f07158622@linux-foundation.org>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 5 Jul 2024 09:38:07 -0700
X-Gmail-Original-Message-ID: <CACePvbVoTxEuMUcoOn7r8z4uLSnOZKDhciKLwOFr2+os5DyHHw@mail.gmail.com>
Message-ID: <CACePvbVoTxEuMUcoOn7r8z4uLSnOZKDhciKLwOFr2+os5DyHHw@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] tools/mm: Introduce a tool to assess swap entry
 allocation for thp_swapout
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org, 
	david@redhat.com, hughd@google.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, v-songbaohua@oppo.com, 
	ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have been using this tool to help me develop the swap allocator
patches. It helped me reproduce the kernel crash.

Acked-by: Chris Li <chrisl@kernel.org>
Tested-by: Chris Li <chrisl@kernel.org>

Chris

On Thu, Jul 4, 2024 at 4:10=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> This all seems to have gone way off track.
>
> acks or nacks on the patch, please?

