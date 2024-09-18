Return-Path: <linux-kernel+bounces-332672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D15C97BCDA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41C92842AB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 13:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF12C18A6C8;
	Wed, 18 Sep 2024 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WG1QDtUk"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703BF189F3C
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726665183; cv=none; b=RAL1M8RJ2ZU9Edc6r4JDPB9F4c06mjzJsdsR1l39JoyoI/CiuM4TLul+K+Kq6PWp6I0U2R/RukYltZmKMwIgM4yQKG4iXJ/F8EElqRrTXOV9L+gJrO2nV7Es5mNELJaN/SSOJicCPFpZ2pBL+LHtM7mOn2UkdFC87Ic0fXI5+n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726665183; c=relaxed/simple;
	bh=/dQvIwB7C6GOBY9sPOH493ERq7mD9MX2ud8ZZgiIyE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hla3omhrS/QBDvisgkJ0neyuh4FxcOHQazKs0ApekBdYkZLH1S8nnK601yawnNEG1ukScD/aGUhXlPwB3IG57dD7zefIspt2+3vwLBSZrCypb7Z+DEX9Ur9IB12O302LedFOl+Lgei+shE6tBHeH5qFigoJDwocVFpfQHEgwgq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WG1QDtUk; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso6694715276.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 06:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726665180; x=1727269980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDbiwY+9v6W/l/Dp0yY8ts7e186+P1Z8FGGOzgOdKCw=;
        b=WG1QDtUkB6p4UhQd7AuKU9GhpRzr1yr6FxgBrEbdtF7QT1p6JA6zquNsv8HPWiet7p
         mH2MgFvQ7tl29NvkVo2OUMMd7vxiQ1W34Zw40nnOpkdu4QOUavauGhtsS0BghSb8U85D
         ITeRePyFjC/IDt6gumZKecDlm8rSh/ZSX7syo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726665180; x=1727269980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDbiwY+9v6W/l/Dp0yY8ts7e186+P1Z8FGGOzgOdKCw=;
        b=VrtOT7kWfNckMb0oH5mrTzYqgkZ2CaG6IEewTmrpyidopmhHtRGsydVXpJH3/NuTcG
         SeREtNDSRarjO86a39vO7fDwXVFR0RpviNKYO1zRpzIHwH964mL7sM3IreAz4MiutyLe
         oN6XqZGDsCiqxh5xIW+E5KSDJ2yQL5GIBh69E6OCU41hhXV+h3htSJ42vIP+TMtjETks
         hBG3IJXMvVgb3A1857bZQ5A+CeoJ4BMYrrV8rcUnmke4kIdjCwZeH7mxcmmUPF2pTUxy
         NVF2WQVSlOpp/6jKdtq//DbfhxiApfzZqGWieygLKvQbCrtcCptG2qNdb/oKSarC4J/e
         nwIg==
X-Gm-Message-State: AOJu0YxLkEsSGR8PDvwj9ChkTphwAElI/2XgB/m41hP00JyoNIa3EeRt
	FnZO2VhUDgLlTuzJ6HmmfbcBGs/iMLF5elLDlzcddzVPZUju9hpVP9OYkNuvoyYnR1ApHVHsgG9
	r1jaQctd27NSz7/sr8XtCBNgne+DoViw/Oys1CQ==
X-Google-Smtp-Source: AGHT+IG9ydQ0Munqm74igbyRIPkxfC8xFAKxQRSKZIGBKbfOv3i8qSAysIoEaKK5iD5Z7skFQQQFI71KH6ffNGSkZb8=
X-Received: by 2002:a05:690c:3811:b0:6db:dede:ec63 with SMTP id
 00721157ae682-6dbdedef10emr148891457b3.28.1726665180443; Wed, 18 Sep 2024
 06:13:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZurLc9qEjBH9MkvK@gmail.com>
In-Reply-To: <ZurLc9qEjBH9MkvK@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Sep 2024 15:12:49 +0200
Message-ID: <CAADWXX_mJr=hDkOWne831Fcm+wRxRnh9VvD2AMJJ5fStodyAgw@mail.gmail.com>
Subject: Re: [GIT PULL] Performance events changes for v6.12
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 2:45=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>  arch/x86/events/core.c                                |  63 ++++++++++++=
+++++++
>  arch/x86/events/intel/bts.c                           |   3 -
[...]
>  kernel/events/core.c                                  | 586 ++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++----------------------------------=
---------------
>  kernel/events/uprobes.c                               | 505 ++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---=
-----------------------------------------------------------------

You seem to be cutting-and-pasting your diffstats from a *very* wide
terminal window, resulting in a very messy diffstat result.

Please either pipe the git request-pull output to some tool (I suggest
just piping to 'xsel' or similar that does the 'cut' part for you, but
anything works - you can just do "| cat" to make the stdout not be the
terminal).

Or just use "--stat=3D80" to set the output width to a fixed sane thing,
instead of that insane 250+ character window width that it seems you
are using and that causes those overlong diffstat lines and makes it
all hard to read.

               Linus

