Return-Path: <linux-kernel+bounces-202886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 459108FD27B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EF5CB2745E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE59114E2CA;
	Wed,  5 Jun 2024 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FgLFTgqo"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2906C2837A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717603710; cv=none; b=II/7geE17/aaLiL2iIw3xv/2zuTiWTyB5fOP/K7o0doPDuT0vejo8dutpmxZJaftaDqUdYF1zgwKu0R5V2dndnGE9KZNzpBZwI71Aqkjvg8wbeltkqAGLPBsSuwAmRDCWBeRhqiD0M01K9e5u+PzMJ40U6V34uMZKf9fCQRbnK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717603710; c=relaxed/simple;
	bh=H/FJ2N0FwApJ96TxD1B509Iuy8DXiL1iOz47w9oFOJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WMPytfetiq7VOsCc1TtXNDshLu8lrrt8v9Xebd6MK3jfD2IghxWRtT1I7QcH2lChxCXtBOjAAqWiVtXZNm/gm2VhW8fA8Jq+JJsd1j9uOzHC3z8browoE+13pLsB8+kr816x/K/grjdi4tszvDgJikQjY7vCB3/ClvcFsmdBifI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FgLFTgqo; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a626919d19dso214808466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 09:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717603706; x=1718208506; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rjT+iRyc5GfiUIlZUEFmZp09PKDBzpzR2oZ+eeDSlg0=;
        b=FgLFTgqo5yPGq6dfzPTTC/LKyh7Ldfc1GRxISTA1FbcaM/hiYp7Yo74MS+b3MVPmnF
         w4H71a2QZzr5EoouXufBAUkfJ4T/WmORfTDrCILnmmoY8/HyNpk2msyT+Xj1enihGWlm
         t5bmsWs/yp74srEeZ9Py79BrlyG2m/Qo1RcHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717603706; x=1718208506;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjT+iRyc5GfiUIlZUEFmZp09PKDBzpzR2oZ+eeDSlg0=;
        b=PvsnXUheU4KPX7JBDDSe7t/UQGDwTemaidu5qG03yTIrmmQmWXY6+v4CMxIIg1QH/9
         6+wrDNEgcMOmk1kQslwjg882C8Hu0ATaPZdHhCOwktZHzAFfcebhMfyDW4Aat7NmnVWA
         64br9J44LQSPlqXSgEZ2kgXiKTkfSNVfrI4IzyeYjlbIRe3up1qFRYPO2OCMzirMtfSD
         OeqBrZ+pp6YK68RQ4mjl0zvPeimYukj+t++RGk2TMUvfu01tUPVgPu59oqU0Ce2QqE0m
         XP5Dgl5JTV2weDR8lTp7oIrAaVckpCN0iLKNgb5rStwsEjs8rLA6up/1f3U0wG3E2wfQ
         06tA==
X-Forwarded-Encrypted: i=1; AJvYcCVFvI2B/beHlQu27Mw4Sg4qEGaxxDQI0GCrilgtPz8CEL1hjf9rhudROrAxFFNq9radwM5e1zLEM9Ev43GPYEODADA0kSaGmFkuvXDe
X-Gm-Message-State: AOJu0YyVfYC7Z0mFgm0nLcbRAWCOFJJidf0maK7A3EXNgYXAWV7CMc4a
	0xvKGY/THhg5XMa5AgtLw4AbiIy1OUKAv9GFkssAWNTkTjHRLTxJgsdz6OUuFTwKbs8/83OEkls
	AfiyYEGQo
X-Google-Smtp-Source: AGHT+IG3mlurokBVkNGL1059OrqPmsYrYTEHH3IeG2MLJ9Of6kMrvRgptaRJR9A0dEbUrUnBZue++Q==
X-Received: by 2002:a17:906:270d:b0:a68:f6b8:5239 with SMTP id a640c23a62f3a-a6c75fadd7dmr8605666b.13.1717603706234;
        Wed, 05 Jun 2024 09:08:26 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68ba7fd6besm649355266b.190.2024.06.05.09.08.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 09:08:25 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6269885572so196033366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 09:08:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWeWOvAdsCJs4NGUnlWqq9lUnIatpvCK13Sr5RSAV8u94WXtGXrksEimQe1A1k4L2l0a5QhurLa3/HHxl4baq+Hpe8SQRPdaKD2IWQB
X-Received: by 2002:a17:906:dfe7:b0:a68:c70b:5555 with SMTP id
 a640c23a62f3a-a6c762bcb4cmr10056866b.17.1717603704589; Wed, 05 Jun 2024
 09:08:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605083557.2051480-1-mingo@kernel.org> <20240605083557.2051480-4-mingo@kernel.org>
 <20240605141733.GC25006@redhat.com>
In-Reply-To: <20240605141733.GC25006@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 5 Jun 2024 09:08:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi4773Ls82kqVbPmM1deghS2NXkHNCCzWPc270kcByXPA@mail.gmail.com>
Message-ID: <CAHk-=wi4773Ls82kqVbPmM1deghS2NXkHNCCzWPc270kcByXPA@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/fpu: Remove init_task FPU state dependencies, add
 debugging warning
To: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	Andy Lutomirski <luto@amacapital.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Hansen <dave@sr71.net>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Jun 2024 at 07:19, Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 06/05, Ingo Molnar wrote:
> >
> > But the init task isn't supposed to be using the FPU in any case,
>
> Afaics, the same is true for any PF_KTHREAD/USER_WORKER thread?

I don't think so. We have various users of kernel_fpu_begin()/end()
that are very much about things like crypto and RAID xor memory copies
etc that will be used by kernel worker threads.

In fact, as far as I know, we'll use the FPU in the init_task too
thanks to irq_fpu_usable(). Look up the  nft_pipapo_avx2_lookup()
function.

Maybe other patches removed that, I didn't check the context, but the
"init_task doesn't use FPU" doesn't actually sound true to me.

                Linus

