Return-Path: <linux-kernel+bounces-255565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5374193424B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13CDC283FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5113F184112;
	Wed, 17 Jul 2024 18:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U2F1ASVo"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E56918308B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721240980; cv=none; b=NbNGgSyu1dMjxyRHajtesDx+f52thAsn3/SELk8cnuGVx0NI8PqVqS+UNze/aXvRfUXjAwyBfkPz6qtzpbMpHrh3Y+3lfjnLDY2Bb2Obq2D+C5NaQNDEb9BBzhFtlpBvdYJm/xD0CreIc51Anhp1CN8QniIIv+P2G6Qn+47AAFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721240980; c=relaxed/simple;
	bh=edGrCSJm+law+KF7LhbA7dAPSwnDxE8NYbwNz/ehPtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUbgyt1LeubwkyPhpihwWWxci01myzKE8X/EMqAJ/bTgEjxLi9tFkNc41QWXEVam1mYy0LLtZaDfq1tiNunzkp/7SGlBiK2Ntwi2eZCMYF3Y8gwD/AD1pX4y5XZZ3kkbWK3cCt+d7YTZCQ7cHeON939Z5aHixZ7DYyAI5bptOf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U2F1ASVo; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52e9f788e7bso8571516e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721240976; x=1721845776; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YrjH0zcFGf3tvo90DQ08Zfhtgyqf6QERcMviRds6bQ8=;
        b=U2F1ASVod5iLwjLUM2WSZAZ7BsbYLYuAmyf1Ce9EoiJRCGIxrTaHzpDv7Z5R2RR8Ko
         AbJU1MTZDbKPr6K8UcH2NAD1YVEmMIzGESZRJfG/3wgyMQUgs/9Z4G/fvAEhFbzA3ruQ
         YIRg0gJfEx5L6PGbUNDpCqloa0uB2U16/vnI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721240976; x=1721845776;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrjH0zcFGf3tvo90DQ08Zfhtgyqf6QERcMviRds6bQ8=;
        b=Mmoa3IC7yyiqKLxDBQIrYNt/31oRuhysFNauQFVNub/Hh07Cax0a3LB3WZHxu1MiKb
         2WLtTkIsqXU2Iry1N5kWTmB5vaHj6tsyb/Vl0EwxzxB6eyFNkJfN5UrSKJDPcG9kg6Ih
         sImg0BUXJwAYM+5yKszkGIAtk39VOqHilPuuizgxmgFNo2bOdMUE2n/LOu+mbvZSU9it
         i5yY9hFHh6nZgZ7bPheP6pyWisNE4LwiHPDFZ2ZzrGo0oyJ+ba0bgYgSOKtW79l302/x
         SXbTo0vT7mcqU+0WmZnpSjcChfsN3kkQHPtEZtkxp1LOUr+2H4NrHKRBn551Vw25T1Rr
         7zoA==
X-Forwarded-Encrypted: i=1; AJvYcCXJUuJwRKAc8pwmtZVO35pnIT7hMUzugOW3INvwXw/tz6+clnJoeaML7TpJlx5CGNQMeKRiXtySbgw+ADmNCw5Zo24RroyKAz3+S+eZ
X-Gm-Message-State: AOJu0Ywm/40vglFoYHdS3zHFL7Bw6DftOE1tm+bAFIXLu9mhVVk1xBCs
	sdCijUxnpTUXBtMs5Wpb9bDM5DUhHX3e8nFQKBdTPGO2A1O2vOzFZwkqXO5oiJlf5stUcQ44nn9
	5pZ5rgw==
X-Google-Smtp-Source: AGHT+IEEE/1PoFl6AGb/qlg1unn40bFkfxChnup449z3IOknlREcrQfRoySEcLbocbHoD/iZ8gRgew==
X-Received: by 2002:a05:6512:3f0b:b0:52e:9b15:1c60 with SMTP id 2adb3069b0e04-52ee5426f95mr2004624e87.48.1721240976464;
        Wed, 17 Jul 2024 11:29:36 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed24f5938sm1551716e87.117.2024.07.17.11.29.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 11:29:35 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52e9944764fso8306781e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:29:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWNn3f+HMBlF2xRC+ck0hOS+WZGkpR5BZLOTlO1nNJXe7/pyEIvcInFrSm6q+cwmtf/62PVgNV4Awj/AOaFMjC9PnVFMkobdWh3M/m
X-Received: by 2002:a05:6512:3089:b0:52c:95d1:87ae with SMTP id
 2adb3069b0e04-52ee539ea93mr1968354e87.12.1721240974589; Wed, 17 Jul 2024
 11:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709161022.1035500-1-torvalds@linux-foundation.org>
 <20240709161022.1035500-2-torvalds@linux-foundation.org> <ZpfxLrJAOF2YNqCk@J2N7QTR9R3.cambridge.arm.com>
In-Reply-To: <ZpfxLrJAOF2YNqCk@J2N7QTR9R3.cambridge.arm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jul 2024 11:29:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjrj-qLVxvtxf+uOBPNp8dJv1R-64E0s7k7uTpKk-1B9w@mail.gmail.com>
Message-ID: <CAHk-=wjrj-qLVxvtxf+uOBPNp8dJv1R-64E0s7k7uTpKk-1B9w@mail.gmail.com>
Subject: Re: RESEND: GCC asm goto outputs workaround (Was: "Re: [PATCH 1/3]
 arm64: start using 'asm goto' for get_user() when") available
To: Mark Rutland <mark.rutland@arm.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Jakub Jelinek <jakub@gcc.gnu.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sean Christopherson <seanjc@google.com>, Alex Coplan <alex.coplan@arm.com>, 
	Szabolcs Nagy <szabolcs.nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 09:28, Mark Rutland <mark.rutland@arm.com> wrote:
>
> [resending as I messed up the LKML address; sorry!]

Bah. And my reply was to your original.

I'll just leave the lore link to the reply (that did go to the arm
list successfully) here for anybody that only gets lkml..

    https://lore.kernel.org/all/CAHk-=wghzGt7J9XaQgcmLniYrQMtoXGcv+FvdGcyspkb+FxUsw@mail.gmail.com/

but the gist of it probably boils down to the final few sentences:

 "Maybe we just need to give up on the workaround and say that "asm goto
  with outputs only works when ASM_GOTO_OUTPUT_WORKAROUND is not set".

  The set of broken gcc versions will get progressively smaller as time goes on"

which is sad, but not the end of the world.

Unless the gcc people can maybe come up with some variation of our
current workaround that actually works (because the "workaround at
target label" model looks very inconvenient).

           Linus

