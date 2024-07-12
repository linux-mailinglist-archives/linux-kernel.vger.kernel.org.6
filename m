Return-Path: <linux-kernel+bounces-250306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CDF92F64C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030BA1F22D9F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3FE13D619;
	Fri, 12 Jul 2024 07:33:44 +0000 (UTC)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70AE8F58
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720769623; cv=none; b=co1RJhpaA05cTkxSkdmZVo5Nck4rFLKzLKGxJ9xmypGnGP9dOEMlBwxguWxc2Smf2zwvPYYxeCPAbf7Ox8ZVDtZ0x+p/GuHefNx0gC1zGLy8QBIMMCXphz5PH8/MwpNMRouPgDiuUgf1e2m1pNAZyiQXA+hbkkzA6nIirsvQCL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720769623; c=relaxed/simple;
	bh=V/kKfskmGeohcGgTh/TWitjQ2ktSVRQ+jrz7Poi2ZCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+SHc8jsJvDPg/6KmVvVZQV27TWhpSvE+acJG59zsLVanzvBYaUH+spHZMRswQd4egGrTAesMLzqTeElQaryddFmvXi3+1ssOMnwqhCJTarLAxcCUmjf6ZbmSU1KijRAN9/UhTJjq4looWo2jmHUS+IC8fGYTohx63t2gKG+0XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-382458be75bso7101945ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 00:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720769621; x=1721374421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hn+o8AqZLo3hb96gEPNbR8OJxXzWCm+T0yWulB6rTQs=;
        b=MSmYAYU5Gcc98QhfPQkW9cjM2DNaxOuHcIT6B6hfLMHxU1GWBmzucihPPG95M3/6HG
         Fj9CM0dbB3f1lM55KAjElZyz4r9GkISgoHgiknd9+FjrddFdk1Ni95VD4hrdSSke2N4M
         rfsIpVWyah3fRtSot41l6iR+GeWVNo/cL7GmTZHeC9vCbZ31a+20io3XBgJ9j9LPWJPF
         dck3pfwg0e11ruCH1eFHjMbVquxxRxB15PIgAXudTdf346oBU0pidWQ3A9fo/2nftcDa
         kgTFsi9Mzc8V263K0XIXoxI8dVsE8UDekg5AhwbcSQMWoQQ5C4LmNaznZGEqq3Tk/K8d
         qMwg==
X-Forwarded-Encrypted: i=1; AJvYcCVWLTPsefAKnG8mOLUBsksKl+r82HPEC0rFRSLHpERFRdvjcFyIH3tou6REaydqTD8tT6z2Fiw65zuXJ8bNC5mwarZN3BFOuVsQo5px
X-Gm-Message-State: AOJu0YwAZTUkUdY9VMzswt7oxTV7hcjDhH5lZBPv0Slb0/P5qRuBjXrd
	SIhRCHn1/MEj8L/RD+w7j4Z+QjZuLbth8p1r1xw4+oYjfv8lId6hMqypId35
X-Google-Smtp-Source: AGHT+IGbQMjqFMpaULo80E2uxbUpy3EgGlFwaqZ+ciPbdnh24W4/zLrHJxvlMFHsD4vKrRb/CUQoUg==
X-Received: by 2002:a05:6e02:1985:b0:375:dc39:cfd2 with SMTP id e9e14a558f8ab-38a580a7215mr122140005ab.11.1720769620754;
        Fri, 12 Jul 2024 00:33:40 -0700 (PDT)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com. [209.85.166.169])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-38a4b870e83sm18431885ab.55.2024.07.12.00.33.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 00:33:40 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-382458be75bso7101865ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 00:33:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVR03iz4mfhzJYSaYO7ZZpVowwM6vxqKZmpezHb8iv9O7AS+BBwfzjQwhNaJx3nkMOhCHwElJ5pAqUygfBEnC1/QolW/ruKisCWvIy4
X-Received: by 2002:a05:6e02:1906:b0:375:efde:97a6 with SMTP id
 e9e14a558f8ab-38a570f909fmr133671515ab.7.1720769620042; Fri, 12 Jul 2024
 00:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712032140.4012667-1-lsahn@wewakecorp.com>
 <ZpCqkPIOCsnmf5lF@google.com> <CANTT7qi_qZfFH+T1z22GMQ-LmG1vHG1adzD=hxXiXyKT4kkhOQ@mail.gmail.com>
 <2024071241-entail-icing-58cf@gregkh>
In-Reply-To: <2024071241-entail-icing-58cf@gregkh>
From: Leesoo Ahn <lsahn@ooseel.net>
Date: Fri, 12 Jul 2024 16:33:40 +0900
X-Gmail-Original-Message-ID: <CANTT7qijsbExBqD0WNC-V+w8BWXDCB+s_Vn+=8GXoeA3D5c1Xg@mail.gmail.com>
Message-ID: <CANTT7qijsbExBqD0WNC-V+w8BWXDCB+s_Vn+=8GXoeA3D5c1Xg@mail.gmail.com>
Subject: Re: [PATCH] android: binder: print error message on failure of
 creating proc file
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Carlos Llamas <cmllamas@google.com>, Leesoo Ahn <lsahn@wewakecorp.com>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 7=EC=9B=94 12=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 4:19, G=
reg Kroah-Hartman <gregkh@linuxfoundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=
=EC=84=B1:
>
> On Fri, Jul 12, 2024 at 03:52:32PM +0900, Leesoo Ahn wrote:
> > 2024=EB=85=84 7=EC=9B=94 12=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 1:0=
1, Carlos Llamas <cmllamas@google.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
> > >
> > > On Fri, Jul 12, 2024 at 12:21:40PM +0900, Leesoo Ahn wrote:
> > > > It better prints out an error message to give more information if
> > > > calling debugfs_create_file() is failure and the return value has a=
n
> > > > error code.
> > > >
> > > > Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
> > > > ---
> > >
> > > What are you trying to fix? My understanding is that users of the
> > > debugfs API can safely ignore any errors and move on. IMO it doesn't
> > > make sense to add this without a real reason.
> >
> > What I was trying to say, users would predict that a file under
> > debugfs will be created while they are opening a binder device. But if
> > it failed for some reason without any debug message, they would get
> > confused that the file doesn't exist and have no clue what happened
> > without a message.
>
> And that's fine, again, the kernel does not care if debugfs is working
> or not.  It's just a debugging help, it does not affect the normal
> operation of a system at all, and as such, userspace can't rely on it
> being present for any functionality other than debugging issues that
> might happen at times.

Thank you for explaining in detail.
I hadn't thought about it from that perspective.

Let me close this issue.

BR,
Leesoo

