Return-Path: <linux-kernel+bounces-309990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AA99672CB
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 19:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789E71F217F2
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 17:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866996A8CF;
	Sat, 31 Aug 2024 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V7VyYoBY"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372FC524F
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725125056; cv=none; b=haVZiF0cNwbXKxvcX+WwlAd5z6A6lMnW6vBX9FNPKGGKwG8rIqhm1WZtr6I/6GJwfAKHvnT0bRm70c/p2BeSZGsp5EZNJmH0DcKqQPdkUsAE1+Izl0unn/RtVfwfk1cf93G6TVwswD5NuXOTuG/XoFvdpwDJyKxMp/CSwCM4yZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725125056; c=relaxed/simple;
	bh=tJ0q3A8yy2y2YLXIJl/X+ha9pJWcwR/K2EInEsg7cEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NgXYrKNyhSwzwXFWwAqcpUE4Vlc8/G5+54dW62auhfe0eTvBQLvdKKqV11YvkbPjKxxtb0/Ie83mFqx236dhAurAXiN1zWbHKJHCjMMoyFm/5Zr83HLYn72hqck8n+7Bi4lrviAYHtf+GsCcPJxP6W5D/t6GoT0waWwaO0yVtGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V7VyYoBY; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53349d3071eso3781442e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 10:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725125053; x=1725729853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJ0q3A8yy2y2YLXIJl/X+ha9pJWcwR/K2EInEsg7cEc=;
        b=V7VyYoBYsaJhMyxfvqDApSt5CwDH1Scaz6QEtlElBU63Y23rrhE9sNM6PXCk/NUllp
         lm27JHErr/AWZOQeQ2L5oTUzmYxJaGERtr9aRgusb0VQwDPwg5KH3ZVGswmP0goxwHwi
         T4DA8eCH4Sv7ricuUitiR87/t95VcTsZRQkHKvVO7IxI9U8eGpcubdcf66juC6te6+fA
         LKjsioFA5XPeOSv6200TKet9Y/QYVgnM0ydXkxg3j/p1bYLEu2UBzqK/U2Ph374g/lPp
         gnMOLV+/n5Yy1byRl/iQtMvy3pAoW3uGCIgThD1sI+j+hKWHwLRowcF57BTgx8wpFb8R
         n/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725125053; x=1725729853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJ0q3A8yy2y2YLXIJl/X+ha9pJWcwR/K2EInEsg7cEc=;
        b=qI1Bp/f1wNE1822GlxZAguhele0UDrnCjwfohwT80+Gns5G2VZLstigTEfnkbgSCu6
         r4A0uyj+wsAL1naswPf0Ro1pXjZa5xXMUrOEYq7RcpbCsyt18v1Je2imM+8xDpaHm7CY
         8FO6RpX8/Y07o8lYV+nG9XsWw2+OOx/oX/7zMeBEJKNSZNhItuz2r//ejh09dql+l2JC
         yKaWc0t4eV6I6asEMxe9bUTliNmYxa6rad9M2NZsuonePfG4S/qo3fMdzrHLqgzQfV8F
         +Rmvrf2zaYAo8Zz0bNbI7RA7soQTNURTdopy0U+HlGMdCYOlznWkrzdsGSdPIf0Xgj61
         LL8w==
X-Forwarded-Encrypted: i=1; AJvYcCVN9NowajpIVUqwza2DlAsp7Yq/G/yHcxgSvojInbF0Oc58tLZ0eG9ZI4eKZiPrV2VPXICl5DdSBqTNAqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJWKXg3QZhl1VDtYAq37YPXC9htYH9bBYLh6/NQCrZT+G+vJAW
	JKDkLYHHBRlOSSGlx8mbt68TGIR7S5urlhjco0Qev+x/lq1Ip/T4YzlxPh9023dFJmFSAYB/nxs
	kvKMb/cLopL4yvASATYA+oBb3UePLHsnm5nk9
X-Google-Smtp-Source: AGHT+IENOBv8ACP6pLwuBirQULXM9TviCCKNyK0x9JmgMxPue2KVMRZODUSGaPP7Lrc4yxsEDKLzCVwVf/Ky6/MHkV0=
X-Received: by 2002:a05:6512:b9b:b0:52f:cdf3:2934 with SMTP id
 2adb3069b0e04-53546afa392mr4822016e87.8.1725125052523; Sat, 31 Aug 2024
 10:24:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <BD22A15A-9216-4FA0-82DF-C7BBF8EE642E@gmail.com>
 <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info> <ZsiLElTykamcYZ6J@casper.infradead.org>
 <02D2DA66-4A91-4033-8B98-ED25FC2E0CD6@gmail.com> <CAKEwX=N-10A=C_Cp_m8yxfeTigvmZp1v7TrphcrHuRkHJ8837g@mail.gmail.com>
 <A512FD59-63DF-48D3-BCB3-83DF8505E7E0@gmail.com> <oophwj3aj2fnfi57ebzjuc536iltilmcpoucyms6nfk2alwvtr@pdj4cn4rvpdn>
 <3D1B8F1F-2C41-4CCD-A5D7-41CF412F99DE@gmail.com> <CAJD7tkbF2Cx4uRCJAN=EKDLkVC=CApiLAsYt4ZN9YcVUJZp_5g@mail.gmail.com>
 <EE83D424-A546-410D-B5ED-6E9631746ACF@gmail.com> <CAJD7tkZ01PPYMzcTyX_cwr836jGonJT=fwT3ovc4ixW44keRgg@mail.gmail.com>
 <277CDE7C-7ED8-4840-9C30-533C9327B028@gmail.com>
In-Reply-To: <277CDE7C-7ED8-4840-9C30-533C9327B028@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Sat, 31 Aug 2024 10:23:36 -0700
Message-ID: <CAJD7tkaTcnuCFW+dWTzSAuLKBqkkGv9s5uByYm9DaJC=Cp-Xqg@mail.gmail.com>
Subject: Re: [regression] oops on heavy compilations ("kernel BUG at
 mm/zswap.c:1005!" and "Oops: invalid opcode: 0000")
To: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Cc: Pedro Falcato <pedro.falcato@gmail.com>, Nhat Pham <nphamcs@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 2:41=E2=80=AFAM Piotr Oniszczuk
<piotr.oniszczuk@gmail.com> wrote:
>
>
>
> > Wiadomo=C5=9B=C4=87 napisana przez Yosry Ahmed <yosryahmed@google.com> =
w dniu 29.08.2024, o godz. 23:54:
> >
> > I also noticed that you are using z3fold as the zpool. Is the problem
> > reproducible with zsmalloc? I wouldn't be surprised if there's a
> > z3fold bug somewhere.
> >
>
> Hmm - yesterday i recompiled 6.9.12 with zsmalloc and =E2=80=A6. after 16=
h of continuous tests I can=E2=80=99t reproduce issue.
> With zsmalloc 6.9.12 looks to me like stable.

Interesting, and a little bit what I hoped for tbh.

>
> With this - what will be your advice to move forward?

Well, it's possible that some zswap change was not fully compatible
with z3fold, or surfaced a dormant bug in z3fold. Either way, my
recommendation is to use zsmalloc. I have been trying to deprecate
z3fold, and honestly you are the only person I have seen use z3fold in
a while -- which is probably why no one else reported such a problem.

> Is there any possibility/way to avoid bisecting? (due limited time from m=
y side)

So unless you have a reason to specifically use z3fold or avoid
zsmalloc, please use zsmalloc. It should be better for you anyway. I
doubt that you (or anyone) wants to spend time debugging a z3fold
problem :)

