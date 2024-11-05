Return-Path: <linux-kernel+bounces-396432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CD19BCCFF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F115B218FA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47681D5AB6;
	Tue,  5 Nov 2024 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IF7yjyQ0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9141D0B82
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730810871; cv=none; b=lXwJVS1EFbBEvFEMvG9J/qF24qmL1T9MaO3qE9faGKLXhWm+YG1Zer8FO1ZHTrmtaHoDZq92anvKrIWbC54PFrYqsydu/pz2Ibkz1vLxRLRBeMMmSJ0/0aB4fEqgU+RVRf4g0YeW1aK39+FFNatYcWvdyJyeYgnHTlSOuVHhcM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730810871; c=relaxed/simple;
	bh=lveH6tT8PYd75EaksRx/fIK3ax0m1rOysCm//zZ0jbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlEEmjsziIm4dR8SY5CEfPD14NnM+oZ0MZYvINixw9haWiQZwoT8i2Lalach+f2ZcVM7nComINgRmlWTziOfikziPrcMjD74d/6372XqU2zYNXCsZQrLw03oyCMxiH7433rJ+EHWuA5cVSX8UkMf0jHCzroPK5KUhCAUeaE0ASI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IF7yjyQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A96C4CED2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 12:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730810870;
	bh=lveH6tT8PYd75EaksRx/fIK3ax0m1rOysCm//zZ0jbY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IF7yjyQ0JMG4lqmP309bmGa0ewkjehQ2pSMgcaAm/+j5iSFS4sLxWASfhA773qrGt
	 N9k6W+RDjVBHK0tolLAgAwpBz+RD/BWQIqLwLkIeTC4ex7Kk+QM2sUPdzqpP3uQfne
	 7kHqt2YJ9leuqgZX970b67wSvUkyg9EeA3Vg6O2MJMOkAyipQbenJY2rtuIffp9Srb
	 yg2/3ViNI9LxBLnju6HADDVgPdWBt9vz12C3BHobp3Hkiv6ji96Ay4gn9DJA3lCj70
	 dIc7S+eKlR2YN3daFnOwgvfPYp+DXQI3sy/uG1DfhCC7+/eap54qWU0+gbQpOJgaa2
	 lZjsSgJBAcjkw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9acafdb745so929657766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 04:47:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXcESokqNK4BKORkGZ0nVT9H1tp3mLMw0besikbINqhqK/cXXMCUCXoNrlpxhl16bvd1fCnJSkD8HTBEBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxctXWvBljr1nM5t+wXW+ucTPEnt3tolIzk/qfd5ktxPlPjn1PW
	u+Wo9akS3L2msJdqZBMNaIb+k1yPuAQGhPZDfv8NK5LZxEin7gh1DXnoYgnjFZ6sflkr4/0Qapw
	7kNiv2dCQ6lJHEGd9LX3JEGW21/w=
X-Google-Smtp-Source: AGHT+IFJof42E96idgajIHqchgbc252pqsbEamBR/iwZg6ZGziZCu88uMtfAh0CLeFO7bPYac0zaeGXRXvPRPuhpJDM=
X-Received: by 2002:a17:907:7205:b0:a99:facf:cfc with SMTP id
 a640c23a62f3a-a9e55a87862mr1669744566b.17.1730810869475; Tue, 05 Nov 2024
 04:47:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105123906.26072-1-yangtiezhu@loongson.cn>
In-Reply-To: <20241105123906.26072-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 5 Nov 2024 20:47:36 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7tDvxVeT5nJSVL88_OGzVuE-rJu=YJTjMd6KpenvWbgw@mail.gmail.com>
Message-ID: <CAAhV-H7tDvxVeT5nJSVL88_OGzVuE-rJu=YJTjMd6KpenvWbgw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Add jump table support for objtool on LoongArch
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Jinyang He <hejinyang@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jinyang,

Could you please take some time to review this series?

Huacai

On Tue, Nov 5, 2024 at 8:39=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn>=
 wrote:
>
> This series is based on 6.12-rc6, tested with the upstream mainline
> binutils, GCC and Clang, all the changes are under tools/objtool and
> arch/loongarch.
>
> It is time to remove the compiler option -fno-jump-tables to enable
> jump table for objtool if the compiler is GCC and it has the compiler
> option -mannotate-tablejump, the next work is to add the corresponding
> support with Clang after addressing some corner issues due to different
> compiler behaviors.
>
> Tiezhu Yang (5):
>   objtool: Handle various symbol types for rodata
>   objtool: Handle special cases of discard.reachable
>   objtool/LoongArch: Add support for switch table
>   objtool/LoongArch: Add support for goto table
>   LoongArch: Enable jump table with GCC for objtool
>
>  arch/loongarch/Kconfig                 |  3 +
>  arch/loongarch/Makefile                |  9 +++
>  tools/objtool/arch/loongarch/special.c | 83 +++++++++++++++++++++++++-
>  tools/objtool/check.c                  | 38 ++++++++++--
>  4 files changed, 128 insertions(+), 5 deletions(-)
>
> --
> 2.42.0
>

