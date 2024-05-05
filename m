Return-Path: <linux-kernel+bounces-168951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAE68BC01E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 12:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5853F1C20C25
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 10:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A697F182CC;
	Sun,  5 May 2024 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBuoPbCP"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F4D134C4
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714905859; cv=none; b=hsLj3pJTn08ZfRnOLB7AN9TXrIEpN7eeigFPuuop0OAK6XO3mD5AXBeqn7yPg0doZS5rhHhIc8BvywvDwq7s8vTVoSqSlXmzkIfndfUu9Mc5keY79ALBsdJMP1fBAreO31UwfxT+wYHcEfOt1RJLJit7j+iU8+PiWljGN3grMjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714905859; c=relaxed/simple;
	bh=gCDN8vSpXsgSqp6/aF3SDEonm9JaIJPtc5i44GKRcbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8ZQuKF/hA4FGpdSK4PoEIjIrZATpwHJLPXcu1D5IuBCcBa2JkJWU0FLyzZECk7zKeeoPGHeEPRTgZN/8wUS1oCNSiofSOyBMtXOUJvmBSkKvB2xn3uBPIj0skKNqLZZJ8Vj07w220zMUj5C4dzPpuWt/iUx+1lG0yQ2nRkSs1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBuoPbCP; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f449ea8e37so969854b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 03:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714905857; x=1715510657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCDN8vSpXsgSqp6/aF3SDEonm9JaIJPtc5i44GKRcbo=;
        b=KBuoPbCPl1f+nckI529MLdKE7krbCpYJ9jMrGjrr3oFce8fpkPV31PaDCb90mXokfe
         nZKaB4gsFJuAkR4VooEJCL4IhXtoU18lvWgnehykyUrhtoXXEs4zp2iaXSIh/M9X3B03
         CZ0+s9T4z/nCoYHL/AoLtEVzi5Uw6lW9VodAdYjYNJn94hAf/3aGQ7LczlSnWyDsYpcn
         N4/J0FXRF2QVSJQkNZbThT+LaBuydrCrkenx2ouyrczhMveQA4H6PLEiu0ZM85DebwtW
         2e9flaVW7zIu4ymqWjPutQAbBuCPhwigu5ZrzDoPdjgOfbbovl7urAAs01pBpB16z7nn
         7emQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714905857; x=1715510657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCDN8vSpXsgSqp6/aF3SDEonm9JaIJPtc5i44GKRcbo=;
        b=mX4y5OrXDtzTEDLTsCaqW4nzee8PQEhSGAJEQbUe3VBqIwPxTKO5V7PZCvPxNCLo/t
         s9+tn3GKPsgptZkBvwlLi4LlgitPl5nyMHvYUJklXlRd3W+6I+jCIH3LsPSSuDByySsr
         ECosbn6hHicwKqP/sT0GPlOOPHzy2JC1elgefBFPaVaJ0yCGEDByUeMnefFp/gSvcuPL
         29rJCDmYDOYsjmf86IJuxt3NOMMwT9bJAovlrP0YbHiGi9kV21kj8Zk0oKtmxYoUnfiT
         J8y6ZHsuUxRAztTZxTDOauAyDUiwTzb3d8+VvNxWIVdG7GP5497ESpYlaAmkUzy1KLsz
         Y6kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvmhiJaVLqpZLhuVEjSx/rxgIr8cnE6Un3mVBBiBt65lCSd1liN5DlDFfG7e1ziwzjFETc5TasKJ2paJ6wzbzDIG6JI6s2Va9Xwrld
X-Gm-Message-State: AOJu0YzQUYgB6RfRlHKN1NkL1bSKvuj+t0e4iKTHGE2k8kx+SL/Jg1Qx
	kh4vZd/VgCdssVWacuW51fAKwt5iLD9RhNvnN4+seBuYfC8ywXpvMyykJg5pr7jEw3T8SHYQGXM
	OwlXsO48+5BGWm4TUdv44P9lrjRI=
X-Google-Smtp-Source: AGHT+IGVLcuJCQO8ZtaVJ6zUtvr+xIexPYoqf1aVfa8AKhUV9aw4qDoRseG4SiaBuv7b625uHalXRpGlahzy5H9xYeU=
X-Received: by 2002:a05:6a00:8c4:b0:6f3:ea8a:f973 with SMTP id
 s4-20020a056a0008c400b006f3ea8af973mr11693922pfu.7.1714905857121; Sun, 05 May
 2024 03:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502092443.6845-2-visitorckw@gmail.com> <202405030808.UsoMKFNP-lkp@intel.com>
 <ZjQ/JOpcdgWZXo0y@visitorckw-System-Product-Name> <20240503041701.GA3660305@thelio-3990X>
 <ZjSSylciH+qJeEEG@visitorckw-System-Product-Name> <ZjSUk4vgsQ63wfcn@visitorckw-System-Product-Name>
 <20240503155401.GA3960118@thelio-3990X> <ZjVdbavKgDo8a0CZ@yury-ThinkPad>
In-Reply-To: <ZjVdbavKgDo8a0CZ@yury-ThinkPad>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 5 May 2024 12:42:53 +0200
Message-ID: <CANiq72mYPV_rNFirr1q=hjjz2yDzw98qrwqY5c14G3odt+shcA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] lib/test_bitops: Add benchmark test for fns()
To: Yury Norov <yury.norov@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
	kernel test robot <lkp@intel.com>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	Miguel Ojeda <ojeda@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 11:56=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> + * The __used attribute guarantees that the attributed variable will be

We should probably mention functions as Nathan said (unless it does
not work for some reason).

> + * always emitted by a compiler. It doesn't prevent the compiler from
> + * throwing the 'unused' warnings when it can't detect how the variable

Nit: "throwing the" -> "throwing" (I think)

Also, perhaps "when ..." -> "when it appears that the variable is not
used" like in the documentation of the attribute or similar? (e.g. in
the case that triggered the report, it is really unused, while one
could read this as the compiler not being able to detect a use
somewhere).

> + * is actually used. It's a compiler implementation details either emit
> + * the warning in that case or not.

Is it an implementation detail or rather that they took different
alternatives/options on purpose (even if not documented)? If we think
it is just a consequence of their implementation, perhaps we should
mention that and what GCC/Clang do today in their latest version, in
case it changes (so that we know whether we need to remove the macro,
for instance).

None of the above is a big deal though -- thanks!

Cheers,
Miguel

