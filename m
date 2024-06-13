Return-Path: <linux-kernel+bounces-214074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F61907F1B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 00:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B3F1F23933
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 22:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D133414D290;
	Thu, 13 Jun 2024 22:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bw2lHbS4"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E4A137923
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718319095; cv=none; b=pcQh/hU6a4vArUjIne7lv6KGsBOU2sCsmTXeae+9JiohxIEpnicokkKGV+059QH6SV34VmcH17SaE+//ZfcqPBMvatGpTf7es2R1viNuopsYd2pkS4vLlae9PX8th+iCAXeLhXKRe8XXg8grItzOi9MgOgcS9SiSekvfzueIUe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718319095; c=relaxed/simple;
	bh=cM7R9IPExKeeYUKwbsYPLbKU9uudKno2amAnYVfn58U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TsE0J4wTiwk1YkLDzGqeP7BQ2c6FB9ThqCqvsGgdWvfRlwAJ09tNN3prWwvS3Koqwqt8HXeUw+uZ5Czxw9R9vnBhRy1vjWRF3yeLomZ6PWXdz/mAKHQ+AcXflBPV/vt14jrGQLzpCYnImb7QM2njn765/q5Zih20upmpqlxyJHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bw2lHbS4; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35f275c7286so1475245f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718319090; x=1718923890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HorDNxGasx7enGcHReiWx5w77pQt/y17BoL+anTgpOo=;
        b=Bw2lHbS4GWEAko2VqzHdn+qybDja1xM/fqPeAiJswSrka/TJPPHPCuNnL/y88H7aum
         kSqSrTM/FGSo3K11lGaCS3tfOUuG62Ul0myvk+VOJiXFzowKIBPgADiZ7UioYp2UmwSb
         /H7uMv6FmfCKFxssF0pso+f1h9A9Z3nHrxooWWSHpvSicIh/2dQ9ziG7RAq2d053DzF2
         Qoa9z7uXY2SDHhpdLRnfqy7TDPlMA6reGytODDmIh+KkRvMJvhfyOTxnjTleIfJpdz2j
         WtIXsTEtPW23j3DPhCp9CeCG7iSo0kgZWL/TPpcB+GqbxIeZ6A3hPfFGTwATL1ehmK1y
         Zg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718319090; x=1718923890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HorDNxGasx7enGcHReiWx5w77pQt/y17BoL+anTgpOo=;
        b=g1U8jdBpegxceVvsLMICampQ2curnndM/bvI1bwL5LTJQ3xNDzVXsRfSmDVNqD9awt
         /ERdWqvyMIS3np7qgI1UsqCvFzRDllzMBIhXV88wt7CRlIn9cEQPPGa8JuT5L6C86IbK
         +msbvtgoagtwOC5KpUMXVwMKCTAqeThkxJsO232eSxVgcJ8LScfICIEHfHty13ySR0l5
         5iRsq3D8tOumcFX47iLWh/ayV5DJnJSCXT+nvkeSg5mHRkk2itudL49jjV8TsLzabMoo
         eiNUKBK2dXIDl5ldE/zMkYAWcJLsp9rWXkLScy2ahVmxvdvMCI7gqRfc2xfcZPbCpR2P
         utzw==
X-Forwarded-Encrypted: i=1; AJvYcCXx/qc1+Czm78JFDClVHkJeJzAhq3JdfOCL/2rFWaiEr4sOd89VpPwD7bvAl1Y3rmyEoUuqwyOxJZUTMgWfH6PpHX1Xt96W4gz+Lb7z
X-Gm-Message-State: AOJu0Yxs9TTeDpfKKbRgXiiAXszBCzMaAtiuxSYRlFYNo3tSrz2G+7t9
	hKqP8cpNZx4uvhef96eGIail6uQ16iHpTt/9nXBroTkKAm23lV8Rkx5qYFNF3B4W7y8yMe9HiMG
	ToGRMefKAVMOtn6YcgqvuJYNCb0M=
X-Google-Smtp-Source: AGHT+IGngVKLO1YvDvhW+sYs6Ge2ODrq88wKN6MpzHc/XA79Y9VHwXIxUFzRDqiJuFyZRQAv/RJrQPvuLa/9FVOC+SQ=
X-Received: by 2002:a05:6000:10c2:b0:360:82ae:19a6 with SMTP id
 ffacd0b85a97d-36082ae1ab0mr63554f8f.7.1718319089753; Thu, 13 Jun 2024
 15:51:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718092070.git.dvyukov@google.com> <eaf54b8634970b73552dcd38bf9be6ef55238c10.1718092070.git.dvyukov@google.com>
In-Reply-To: <eaf54b8634970b73552dcd38bf9be6ef55238c10.1718092070.git.dvyukov@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 14 Jun 2024 00:51:18 +0200
Message-ID: <CA+fCnZckGWuo=wViH8xfwXKjq9WH7URZqhxh-7bdHFTr67r8fQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86: Ignore stack unwinding in KCOV
To: Dmitry Vyukov <dvyukov@google.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, elver@google.com, glider@google.com, 
	nogikh@google.com, tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 9:50=E2=80=AFAM 'Dmitry Vyukov' via syzkaller
<syzkaller@googlegroups.com> wrote:
>
> Stack unwinding produces large amounts of uninteresting coverage.
> It's called from KASAN kmalloc/kfree hooks, fault injection, etc.
> It's not particularly useful and is not a function of system call args.
> Ignore that code.
>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Reviewed-by: Marco Elver <elver@google.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: syzkaller@googlegroups.com
> ---
>  arch/x86/kernel/Makefile | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 20a0dd51700a..cd49ebfae984 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -39,6 +39,14 @@ KMSAN_SANITIZE_sev.o                                 :=
=3D n
>  # first second.
>  KCOV_INSTRUMENT_head$(BITS).o                          :=3D n
>  KCOV_INSTRUMENT_sev.o                                  :=3D n
> +# These are called from save_stack_trace() on debug paths,
> +# and produce large amounts of uninteresting coverage.
> +KCOV_INSTRUMENT_stacktrace.o                           :=3D n
> +KCOV_INSTRUMENT_dumpstack.o                            :=3D n
> +KCOV_INSTRUMENT_dumpstack_$(BITS).o                    :=3D n
> +KCOV_INSTRUMENT_unwind_orc.o                           :=3D n
> +KCOV_INSTRUMENT_unwind_frame.o                         :=3D n
> +KCOV_INSTRUMENT_unwind_guess.o                         :=3D n
>
>  CFLAGS_irq.o :=3D -I $(src)/../include/asm/trace
>
> --

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

