Return-Path: <linux-kernel+bounces-256927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C669372A0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 04:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 234B5B21688
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 02:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065FD17BD9;
	Fri, 19 Jul 2024 02:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="QZYKBXW/"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA9B125C1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 02:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721357814; cv=none; b=f3T23ne1QndjuaUXOTUmTPlO+zD3qoHoQi8sYm2984qZgdt/eLbUx951mvUl0BnI544gGJlAszIBUj9iFrTI1QL+kFUBgqIw3rt3Fx2B25ccgU5gqBvspwL385z2CO3hTVA/BJ5LmBTrg2kAxwPgVOaTMdf+AaGlBeFQ/zDG74o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721357814; c=relaxed/simple;
	bh=jg8amgsqBxJEisE5Ex24Edv12WNot2unJdqz7eY+lBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X1ZhuwWl5aBveNXoH2NeZ3OWFD6z1mavnfq988K+Uuybt1WOxMYVDvNSYM7ziHkEtmcChKSzZTFl1c9Vil8a+RGbwtdagAGI4bSwROIO9Mu8mmPaVlVIDzTZNCnvl43t78ogmUNK+jYgzBNsLDfsvTEaoJAE8AU2AX15iFB8Sh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=QZYKBXW/; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44931f038f9so7705311cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 19:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1721357811; x=1721962611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jg8amgsqBxJEisE5Ex24Edv12WNot2unJdqz7eY+lBs=;
        b=QZYKBXW/u6gEdjhdj2a0GwkHZNQRcQGMB+ic78L6/HMhfvZ5OpqgWPdmEQJr+potd5
         3hQOVyUp9jNJemPyQg4R/rQynt0Djps8xAALyFxfgKkFF+1R8Tfky7FzVz/HtwFLNOws
         OxBYWKXLC/qGyx7lTWJNNyag1k02cmXoEBFVNPmOtYphZYQzipxXv9DjeOM/worN3iy8
         eHWgF5g0he0SgvSX4x+PeJGiMRRKJpTEAkW2MghHUDa5lOMYqBBRiKzUpjM8yT/WE8ht
         4Beue6fBVs/iAaDFTBcUNMq58Z9dUuEtsy16Ensx/rViqJcEpFvckEmrvDI6b6ENxUjc
         tQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721357811; x=1721962611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jg8amgsqBxJEisE5Ex24Edv12WNot2unJdqz7eY+lBs=;
        b=j3ooSPFrGgnyittSdBpBLx6nC2t83nbhTMp7fTz4sjWADsjWx7UM25Sa+6Fr1uE5DL
         v+ZpEdU6GNfJhEyUW+XcQim31q+nBz4pf6qDXKEjdZpj69EMJIam5qgzq35K86fAa/5y
         RUEb0s50Q7l/b4SEeWkEtYawOp35PvDmBhZpMrkV4bh54QewaJgk03ubOjJI93EBDKjn
         nU/bgrmwZddmePbdRQoJYKyuPgbKWfznvaVj0fPi1iY80GpcToeYLwrZ1N6+QAWqCKZD
         vjB1gESezdH5R9YotfgW3xLsgeI5IFkw1zhNzJqZPEsvAj8MxaXz7kGFnYLseAAxYHyd
         jdmA==
X-Forwarded-Encrypted: i=1; AJvYcCU0iiGqIhLHKx/HZoWRL1ylMnDum2oR7AtMOepF2RTQ+vV85vw2BBq8IClSDAZFtibTjQxlj9RzM+pfo7CbxACoVxYvrljAPrHDaW0g
X-Gm-Message-State: AOJu0YyTYUU2La0vzIpfDv7Lg7wJne2IBFYYFRxCWgL2ZRh6HevwmIzo
	2PFkwwd6QTaEEybG95QKfg2vBm35c47OQeqxsKVz8Vez7KnF7oLhN2ovuC7mVcu7MNbuBBx5hY0
	dHeNp/gOrYGFQ9cCpWGMk3FlZlhd6pjVg3OGpPg==
X-Google-Smtp-Source: AGHT+IHDYSY1eEWlCkMlOjWqhFRE+smxx4jkS72e66X+P6QkOxFFEn6nUns7K7tfje4IuetMmXBjcF7nLqyNYpTu8+s=
X-Received: by 2002:ac8:574e:0:b0:447:f87c:6b9f with SMTP id
 d75a77b69052e-44f96aa07b0mr45218021cf.17.1721357811654; Thu, 18 Jul 2024
 19:56:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530170259.852088-1-pasha.tatashin@soleen.com>
 <cq7537bswpnbsmeiw3rh4ffrgqky4iufsaurukpk2flxts6jcu@6ctttkclvf3f>
 <CA+CK2bCuiDAv05Xu6OuKB=gqJ5NM20F_uUyJV8E=XH=r47ik=Q@mail.gmail.com>
 <i66bzhgnbql7bvuteqttpijml3ze3nngxapv32k7paqv25c5th@wd37oaastkvz>
 <usfcwyq76np42s5b2rpzgjrvvtdpwakaum7ayy4zumaa73ke3u@txbukb2464bl>
 <CA+CK2bBm4COW+jZifyjFEyJNcW1cAXWYzCpuO81jL3YziKxfRw@mail.gmail.com> <dz2ryasq3bbshlayah4dja3esvpwu5hzftgaapzbmjf42n7gzk@qs4wfnuuixtu>
In-Reply-To: <dz2ryasq3bbshlayah4dja3esvpwu5hzftgaapzbmjf42n7gzk@qs4wfnuuixtu>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 18 Jul 2024 22:56:14 -0400
Message-ID: <CA+CK2bAWRN7-UHc0C1u6UAqT82tQXgO6a4AnHEHWN-qqij1LQQ@mail.gmail.com>
Subject: Re: [PATCH v3] vmstat: Kernel stack usage histogram
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: akpm@linux-foundation.org, jpoimboe@kernel.org, kent.overstreet@linux.dev, 
	peterz@infradead.org, nphamcs@gmail.com, cerasuolodomenico@gmail.com, 
	surenb@google.com, lizhijian@fujitsu.com, willy@infradead.org, vbabka@suse.cz, 
	ziy@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 7:19=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> Hi Pasha,
>
> On Wed, Jul 17, 2024 at 12:50:00PM GMT, Pasha Tatashin wrote:
> > On Wed, Jun 12, 2024 at 2:50=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> [...]
> > > >
> > > > One more question: Is there any concern in making
> > > > CONFIG_DEBUG_STACK_USAGE not a debug feature i.e. enable in default
> > > > kernels instead of just debug kernels?
> >
> > We enabled it in Google ProdKernel. There is some overhead when
> > threads are exiting, because we are looking for the first non-zero
> > byte, but that is minimal. We haven't observed any performance impact
> > on our fleet.
> >
>
> So, you would support making CONFIG_DEBUG_STACK_USAGE enabled by
> default, right?

Right, I see nothing wrong with having this enabled by default.

Pasha

