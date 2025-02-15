Return-Path: <linux-kernel+bounces-515973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DCEA36B70
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 03:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE933B2568
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1C685931;
	Sat, 15 Feb 2025 02:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dc7yVfAb"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B411078F;
	Sat, 15 Feb 2025 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739586634; cv=none; b=S+pJTtJ54AVSCVYIJ8HpMSgFzBBkSV8V8vkG+1HAD1NnwuuQeNvZYpk5CIZFjSm/PtpU8fTUriI81EXUPNXOiD6lhxy8oTd07UpC6BITm3UShrVYouJkR/K8GDXr9jOZroml3VBlHhhjvI2aIx2fBxslp+LPWIsBFdR5loghJ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739586634; c=relaxed/simple;
	bh=D369WBKeu8TFEygIotiVqLqyRdxlYvNjsg2mw27k8us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DNlUtPat6m0BHoCmtpy++ntsJEhWyXJc+0nI3A6LFbitUfhbIeDHmRZQmL3Y9pHHyjRVo0BdiGDuVE/IRk7wfIfVI2i6j+euXmkClkhlB3tKDELOn2cy/Y0AQQqDPpvisWSqK/QGEe17KY0aUiF7XONrnZEm30Dfp/NUQSJn2aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dc7yVfAb; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-307325f2436so21846381fa.0;
        Fri, 14 Feb 2025 18:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739586630; x=1740191430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D369WBKeu8TFEygIotiVqLqyRdxlYvNjsg2mw27k8us=;
        b=dc7yVfAbfBa74dFpLm8Sr3DPIXorH2RKnLl2cg2sn9QI2sp/XtyXEh2MajDRDZt1zi
         FFpJuveDyRMExqv/bCm8avTwdK0+801LivfpPv7h92U4c34PEcwEjB1FcfJRxQUOZTFa
         0xqUIBF1oXxDofMFjuLFkBrZnWumdHlGpVW5AcD1uoQVDEWOatxGAWU9q0G9fX0HVmR1
         MX7Byi2ga00VzoJkZQjE/mQ4fEPIFbsJAwyDjZJocv/LWQsiDrJSOcob9Dlwb6L5d3Q4
         GxU8+q40iaUY4x4jQLi3UjCth9U3HnMpo6elJBP4ecRkJ0u8HO8F81mtHaMA4KC7qmIx
         X0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739586630; x=1740191430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D369WBKeu8TFEygIotiVqLqyRdxlYvNjsg2mw27k8us=;
        b=KkMRqm67alrM+jtOAQEWahlSqUka6LuzRA/ADTtBt8l09pPU9A0u8EfJA3wPcPBYNW
         EHIknCD3FvbOJO3gEgSx7h4UlBexQNvhG4Qb3N9ETt5A7ARpSVimFyAdzbCq6ssC034l
         uJQlwV5ndLm/UjQf0Ir+KpbWcpdIO1jrR8HIYbr6v5MQMXHwTgWUTApU8dXmjrjJkkT8
         32F1BYS4/AqJ8ICJSDwsAgzTOWE1M3SElx1/zUSIfWtYlzBKdUVyKJGEDsmWFREF4c6P
         6jwZhuceb3AUffx7hSepNPkqPOG+tyR6rrTO/ApQ7aAgYePwSZvx4IVHGvW8D/PHCWj/
         03Xg==
X-Forwarded-Encrypted: i=1; AJvYcCU6JD7OqC/uf8+KOg0Annt815cyCeRt2JsAdECIJPvPXNCzQQUE3Ed0A2ZT60Q3FIiiBPIu8mVP7plp5w==@vger.kernel.org, AJvYcCXWa4/s1ssRq/87VK6DTOQOTDs2g57WbuE+sA6MbtarTxgyO3tvySBsCVfnplsiSYzKV36p8RwWK/SV2qMR@vger.kernel.org
X-Gm-Message-State: AOJu0YyfHDv2PwR+rrIggv//YwsosWkTVC1EzrEnp1JY0b5ai1syGG6R
	nr5dxXPBtPxlr/6uK1Vnbl1zIroH4np8RGhdJHKUX3iTzLdqkJdDijwPl4+5DY1RtolagdlcMBD
	RnGJWoqdNKsjMHK4Jy/I6xxr1F+M=
X-Gm-Gg: ASbGnctMSSzQNHT5tdVOeTekbsp1oSXafN8GgeKEsajoRgvd906UCBJcF/csszbSIAW
	j48rjFZelQxHqjux5l+MFkz5SYgDzuE0PyPpF/TMVLMtVYFq9Hbn9EU8keByRd44/GttfcaI=
X-Google-Smtp-Source: AGHT+IGk1UPld8tjyXJBsoSuF3AoB16JdMfnCUhOzHyNeb/6VlijV/s+yBjbUWSQCNwa371iKB2lVmu9ge6V//K90ew=
X-Received: by 2002:a2e:9c97:0:b0:308:eabd:2982 with SMTP id
 38308e7fff4ca-30927a630d6mr5872341fa.4.1739586629835; Fri, 14 Feb 2025
 18:30:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <w3rw6n4cbgmlcylf5gbzzocqhyxjoyjy3qiedb7fzvd7jdwgap@44d323cbjljd>
 <CAEdQ38F6ts1qXj2xb+PN=O_byGwZAp1mvF8aRdTEq2zrzLBFSA@mail.gmail.com> <173956921724.2112695.11506562234571397782.pr-tracker-bot@kernel.org>
In-Reply-To: <173956921724.2112695.11506562234571397782.pr-tracker-bot@kernel.org>
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 14 Feb 2025 21:30:18 -0500
X-Gm-Features: AWEUYZlhaKTR3D2o6uPCa2kbT09oRwJpUvXlYtyZ6sqVc6SNMSLt6xdfM7k6XbM
Message-ID: <CAEdQ38E7nHFf96BWDEB_15jiRLepg=_dmaoFvO1JgiL6GxPpUQ@mail.gmail.com>
Subject: Re: Re: [PULL] alpha.git
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: pr-tracker-bot@kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 4:39=E2=80=AFPM <pr-tracker-bot@kernel.org> wrote:
>
> The pull request you sent on Fri, 14 Feb 2025 16:36:43 -0500:
>
> > https://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git refs=
/heads/master
>
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/3447d220155bd9f4b5435ea6e9d58b536c7e94d=
d
>
> Thank you!

This doesn't look right, and I don't see the commits from the
alpha-fixes-v6.14-rc2 tag in master.

Did I screw something up in my pull request?

