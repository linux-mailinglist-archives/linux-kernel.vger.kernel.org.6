Return-Path: <linux-kernel+bounces-251752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A93C8930953
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 10:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FAA91F215CC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 08:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A32208A7;
	Sun, 14 Jul 2024 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulzzKus7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B0B1BF3B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720946429; cv=none; b=Vqm6K9Ck4Pau85V4uphYGIWS8ECdwEM/G3m2/4BDBjsS1TycC1JW1yVTdmPhG+FbThwFPzpzeOyupaHD3Zs6o8X3YNGGaA7eqgbsi4yM2mfFPtr3vz5BA6YC/GZDVGEZ1278AM/BLkEqA0LhIZ59BmCTuvwxi1GJcBRU0tTr1PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720946429; c=relaxed/simple;
	bh=s8soivgswzKr34xn9NybnkAsHMLba+0++ujftpyAp+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EH9hZOrgXZEkPO5UlOc2jOR/obvyvDkrrpqWR/MAHlHDPh2PXsC5RSZgE+Azs70mWgjbl3Bc93UseoCRZV2FRjPnyyaKm8l7N4kqag98crl8yC9XDcjQ0zUzqMLT4mm/5UiqxKmQyeTEPCdCvxF/BkORPTkjQ90ZpsoNMqTHI+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulzzKus7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B606AC4AF0F
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 08:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720946428;
	bh=s8soivgswzKr34xn9NybnkAsHMLba+0++ujftpyAp+8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ulzzKus7lpIXaoeA6m38ml/q7gdaAQuUuqzA0vGYqWZX9GHxSiwOLzCq41NTh/Xlo
	 QhZQTs6I6YM8kGIcOUWthF+FkPkmBF6Ox5nB9Qq5b9LIeNP2LumIvyn7yLelfhXQNd
	 Drlkb1RGyHnqeEqEWNzCU1S0P2OLKrapZ0zbfuF1CR0dEm4kSOFNrdZkFLO93vzyvn
	 ghDSwYSGN5ZkvFTrdto65cVSJAkbjS/n96faFDo8WNxQvPVt+kYIc52gRX5Jazjqhd
	 Ski9OufniAK5B6Yll68GxKwKz101OVE/fQQFDzW5A/yLrJEFIaiYUCy80E734M6SS6
	 K2/b4RAEsZbAw==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a77cbb5e987so401280666b.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 01:40:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXw7Fe3/zBvo973bWPraLGmDmHLfkpTaZFRILJTvysS8m8b0qESqtcRgmg50Km5R3gQzoc8m5563YRf5Jd/A2OhxwMKb2+sTv7O7+5r
X-Gm-Message-State: AOJu0YzvoCWzfZFdeXcRylyEYuidKIgt/62Tz7SR1aNmlU611wgrjMgl
	FnJE52z6aI+gKm6LsOWwEL/zVbQVeXFyu1DgSAzTnsY65VGU32c/C3H9t5LZLVbMAhhpHyp8T5d
	aHWQEeCY7DgGgAqiTDPP8OfC6QNA=
X-Google-Smtp-Source: AGHT+IHk0B/KQ0UHpO4zRyQ37JCRdbe5R3p6F7IAMzuKLMcl5DciHhWTkd2Fb9CtK+utm6IM1/0+1te65nTHb8dpIqI=
X-Received: by 2002:a17:907:3fa3:b0:a6f:51d0:d226 with SMTP id
 a640c23a62f3a-a780b89ed3bmr1274072766b.66.1720946427193; Sun, 14 Jul 2024
 01:40:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711111508.1373322-1-ruanjinjie@huawei.com>
In-Reply-To: <20240711111508.1373322-1-ruanjinjie@huawei.com>
From: Guo Ren <guoren@kernel.org>
Date: Sun, 14 Jul 2024 16:40:14 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTAVoqpeuWyVQGoqg3baQt3HLZ-1ircbtdaXJj4BbG08w@mail.gmail.com>
Message-ID: <CAJF2gTTAVoqpeuWyVQGoqg3baQt3HLZ-1ircbtdaXJj4BbG08w@mail.gmail.com>
Subject: Re: [PATCH] riscv: Remove unused _TIF_WORK_MASK
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	samitolvanen@google.com, debug@rivosinc.com, andy.chiu@sifive.com, 
	songshuaishuai@tinylab.org, bjorn@rivosinc.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 7:10=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
> Since commit f0bddf50586d ("riscv: entry: Convert to generic entry"),
> _TIF_WORK_MASK is no longer used, so remove it.
Yes, you got it.

Reviewed-by: Guo Ren <guoren@kernel.org>

>
> Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/riscv/include/asm/thread_info.h | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/as=
m/thread_info.h
> index 5d473343634b..0eead6b7b790 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -111,8 +111,4 @@ int arch_dup_task_struct(struct task_struct *dst, str=
uct task_struct *src);
>  #define _TIF_UPROBE            (1 << TIF_UPROBE)
>  #define _TIF_RISCV_V_DEFER_RESTORE     (1 << TIF_RISCV_V_DEFER_RESTORE)
>
> -#define _TIF_WORK_MASK \
> -       (_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | _TIF_NEED_RESCHED | \
> -        _TIF_NOTIFY_SIGNAL | _TIF_UPROBE)
> -
>  #endif /* _ASM_RISCV_THREAD_INFO_H */
> --
> 2.34.1
>


--=20
Best Regards
 Guo Ren

