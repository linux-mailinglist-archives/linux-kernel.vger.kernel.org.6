Return-Path: <linux-kernel+bounces-441586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E569ED069
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88504188384C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97241DDC14;
	Wed, 11 Dec 2024 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEavVGp6"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C271D61A1
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932134; cv=none; b=GxyoMfLV/eRmyKnCuV2fwVbYJ6jdX8ubfHxW/Rl2Qu+y/XX9u/VyVsjZ9cJa227JGlG1964CU3HusEhPl76ubyGk0UQDEW/WafdkLtbXa6OutopsW1BQuF6t/7nokhQLldmoUXPfBf0Yfyejl00J05utFfO2UB6lEn/sOM2a/NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932134; c=relaxed/simple;
	bh=VtnQsl9zx+k+ubF9Cz317sI2/lD0BCOgoogtPRBY+k0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gpe8tm78B9DCLIqDn/74CCjqmEbIUpRCBaMlIztNsOVU0+/OIyCkhU2OmWlV20LBNRbLrqsodZOnrj21C2QJexZGWpmNgI5SJBuNVl+kJzw+JEqTN5zeRmSd4Zi8FE54UcjuN4o/rWcDB0ElLVQzR5uVlEfoAq4sl13AVqnCAOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEavVGp6; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-216395e151bso6012675ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733932132; x=1734536932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUyQM6sPB26ijwTRoR0dvI4sIp4E1qaATJkXlSbU4zc=;
        b=lEavVGp62RUC9vcBaf72/kSgYEPo5csg6c7lr/lLlxNSaXk2oLzpmFmolxMCcz6iZ0
         mYNc9O2XKZ5iIDL0QV0De2/Y87a4xtz3szMpOVKZnjgdTgoiBiaS+l2vrwI5/OAjxwox
         51pYh1X2ERcT4FCabimdJ5CZMGp92rAjrQYyJArzJQFvsJYhvkpUFisoIU9vp/WU4VB9
         mX1tOepD0QCXbLN0l0MHGsBooDn/gZ5+eVvIGRwgVKiSUX2WjkU3L5w/QMQYumcB9Vji
         mKrd4G0j09hcoDXlYVGhmlmzfUszGcFXEeCXkQ/ziKWL7ld6sk1PJpwLB2dcLvktWlLF
         v4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733932132; x=1734536932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUyQM6sPB26ijwTRoR0dvI4sIp4E1qaATJkXlSbU4zc=;
        b=TuJhTOW7cu6IsCXtmta1T7ZInuY4rHTsseNtp0KP1f1A/2BqM8EPhezIYGlyAEWkUr
         +GnnNP0QAvbQm1EaN2V+o5ND9BfznvsDfdMySMAZ0QeXWSL1POOCcuP36XXQ33zfn37+
         AMvLV8ySs3sVQO1N9MA1xwQLdaH9yCBlsvFHInXS3dwwXSr0LRckjBtjAx9a3y3XqmN9
         faWcrArfasdUltzLK+10EudW2ZmdZYciKWscIuyg8eH4V3v5YozxluWbZnEtxxJrYsbI
         xj9aWmU1q/BWZokRZseJGQ2X/gV0K8jJxuyK064tSadhRCNz1420XCGuWLjHOLpZjdxJ
         hCeg==
X-Forwarded-Encrypted: i=1; AJvYcCWyUQKl+XFJ6AMshAaEg8ikhrQjayAScUDS57MCh1tYkA2055ebOHkyQ2lOSpx6pSxn/y6Mjf+tYFcsI/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YymNbVNWxNLODYFf6/p8FPl83ncr+SlXPuChHKGvrwHq6mXYxbw
	2l0f1z8MK50L1zCrHJUnxa+YbGz+JAa4zz+TLyisUFn/uAwbYHFlZyDvWZu+AVswNb2soDm3uSr
	ZInSFsfSfaTCwdHoEpMaMOn1XrtU=
X-Gm-Gg: ASbGncunP1ddyMJJDuAF8c0s6cFf6hxnH+87GWo9jaAbbll7jT3R+CrhgpORhBHZs6D
	6nkwsQB8UQ3rZ1G6UkS/FJjC+rQO4JNo8
X-Google-Smtp-Source: AGHT+IFKKOunXsjn4hXooZcv50p8WF3a7dxui616l9bO0fyzpMsTfI84K1HzN1Q65fm2cm9yZV+gLtwd4NTSnvr+pLs=
X-Received: by 2002:a17:902:d2cc:b0:216:6ef9:60d with SMTP id
 d9443c01a7336-2177a55b1a2mr46879645ad.23.1733932132125; Wed, 11 Dec 2024
 07:48:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127172908.17149-1-andybnac@gmail.com> <87ldwxot7i.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87ldwxot7i.fsf@all.your.base.are.belong.to.us>
From: Andy Chiu <andybnac@gmail.com>
Date: Wed, 11 Dec 2024 23:48:40 +0800
Message-ID: <CAFTtA3NKxxh9=ZAfU1tS_4Jg0+6K3R6NWOPpRJHpPhurWKdOFw@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] riscv: ftrace: atmoic patching and preempt improvements
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, llvm@lists.linux.dev, bjorn@rivosinc.com, 
	puranjay12@gmail.com, alexghiti@rivosinc.com, yongxuan.wang@sifive.com, 
	greentime.hu@sifive.com, nick.hu@sifive.com, nylon.chen@sifive.com, 
	tommy.wu@sifive.com, eric.lin@sifive.com, viccent.chen@sifive.com, 
	zong.li@sifive.com, samuel.holland@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> =E6=96=BC 2024=E5=B9=B412=E6=9C=88=
3=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:18=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Andy!
>
> "atomic" spelling in the Subject line.

Sorry, I will fix it

>
> Andy Chiu <andybnac@gmail.com> writes:
>
> > Changes in v3:
> > - Add a fix tag for patch 1
> > - Add a data fence before sending out remote fence.i (6)
> > - Link to v2: https://lore.kernel.org/all/20240628-dev-andyc-dyn-ftrace=
-v4-v2-0-1e5f4cb1f049@sifive.com/
>
> Hmm, the fixes tag was not included.

Do you suggest adding fix tag to the entire series? Or is there any
patches that is missing the fix tag? I am not sure if this is a fix
since we defeatured PREEMPT 2 years ago.

>
> Also, there was a lot of comments from v2 that was not addressed:
>
>  * Minor spelling nits
>  * Breaking DIRECT_CALL, and include Puranjay's CALL_OPS work in the
>    same series for DIRECT_CALL, to avoid breakage.

Sorry I didn't get it at the Plumbers. Yes, I can test and merge
Puranjay's series and send a v4.

>
> I'll have a look at the barriers (which came up at plumbers)!
>
>
> Cheers,
> Bj=C3=B6rn

Thanks,
Andy

