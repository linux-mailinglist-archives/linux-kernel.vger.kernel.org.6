Return-Path: <linux-kernel+bounces-203302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8BB8FD923
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E710282424
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F168115FA7A;
	Wed,  5 Jun 2024 21:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tB52Sk6k"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8804327701
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 21:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623256; cv=none; b=aLYyKumDLQAAZEqQwTuptaUHUrytQHVmog7oK7A6A62OWjhzep8zkeqNsIsfuANxpQBnAiTPKDLaIgyAzMLDX6cLtVKa+fD5P5cE5P+kUSCq/zsjJDb2qajg2W4nqSPca2PaZRM+5Z3Q1aB0KuL1qBSpAjZu/qf0gz8mRwmSgz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623256; c=relaxed/simple;
	bh=gqBOns9NjUOwlItHcv+NKheaglPGkc3CfqGXO/RBcVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z80sH4qu/otmHiYRfUKKVqy1oiTBgw03hFmIlVRvE/Nss5YX9Q4NaXnm2SJxnOk2pbkpmVdR+19ZAoY0XseuSFSX5TeTXziyUF/bkLZn4NRRw/AHeJ9SBUHHwbaXkM+9C1khv9eU5n2AYBQNIAqPw5PqgUmCzkVhydLxqrimoEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tB52Sk6k; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eaa80cb573so2938031fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 14:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717623253; x=1718228053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqBOns9NjUOwlItHcv+NKheaglPGkc3CfqGXO/RBcVs=;
        b=tB52Sk6kmsPVIJ0rEdztut/FyDKAPnkuxmTbyyQdzDfrv0VMlVa/xaiTui2XHrSQMM
         nLLRCPszWUtIPYZ5N3A69/iCcq5eNWe1NsmAmkQdQ5loRbce/Z/F84S6eKR164pQP6G3
         X2Nr5d5NRuoHltONmWhwoGwjWu1ZD4SxCwBhl57JGl6uVRv3nJTdLB4pKge7Kv/K6jFq
         ckWwSQ/JW5N4/Gtcqe3I8o6Ey6NrPYUyIBAoXALxnqKfoolTCFwneRPmc8lCIrwrGFgi
         CSlG7Iq2P2+RRE5oN0lPg+M8QiKpOE7daM2G3jwkAHSNmLLYbaVYs+UHOOkMblL2B45C
         dOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717623253; x=1718228053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqBOns9NjUOwlItHcv+NKheaglPGkc3CfqGXO/RBcVs=;
        b=FaKZtUBA1fdXSJBLtYyATsmYvFhWG65oxazPwIje4du0Zfj0csqM7DxzZTGCmIiVJ2
         lSuiqgIOVJ69SS7WiplT+M6BirSRIB6rMxzhcJE22DwoxoJO7nlJqhd6SUpVdARYpaAK
         7ze6hmy627LBBKzBoEcmcTiyUCPhh89UmMEjpfXzkNkdJuOpEcOCPTxkbzemhXQRwy7X
         3bJmJ4taBSPopk7wB6cmBxxK0wBTE5CS410+ICLrCxy6kX0t8mCF6rMAJaq0iVwgiFTs
         YYAN/H3P/DwQnd877ik7WeQPsvMhcwu72wpw4qkQI1sVa5doAqcYFE8hXp6xxJNXVx2r
         6hBw==
X-Forwarded-Encrypted: i=1; AJvYcCU0M0IPmuFQFtUDqnrnIJFpJ4U7WbhNx+BtCl/Foqkuoo9kqnNXFvmZTKJVzxfD3CJir5QtmMDFLp8ELIllbfew9RGAmYWxmIbK/ICy
X-Gm-Message-State: AOJu0Yzi3YU5gKPlUc9Axm4Chs/IVmjrhPe9k9XC8I2+H1zhO5OL35x1
	4SGCiOEufepWjTii4XQExhon4KJMAkSoiBh7XkeLHcWXK6YygsRjj9+26szw84cFI88ibKhWNpq
	GzBjQBD6ydtV8JAqjh0HmhRD4E07/flzCXAzA
X-Google-Smtp-Source: AGHT+IEdOZb+muxjYVFTWY+aXKl9l3o8/b/myC7ur8bwb93sdKO2CQP6FMP/O90RUPwrcXgQ4CKHzfyeI1VCz7Y62vw=
X-Received: by 2002:a2e:8891:0:b0:2ea:7d0f:f6ed with SMTP id
 38308e7fff4ca-2eac7a53ff7mr21497191fa.33.1717623252490; Wed, 05 Jun 2024
 14:34:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com> <ce967287157e830303fdd3d4a37e7d62a1698747.camel@intel.com>
 <CAAhR5DFmT0n9KWRMtO=FkWbm9_tXy1gP-mpbyF05mmLUph2dPA@mail.gmail.com>
 <59652393edbf94a8ac7bf8d069d15ecb826867e1.camel@intel.com>
 <7c3abac8c28310916651a25c30277fc1efbad56f.camel@intel.com>
 <CAAhR5DH79H2+riwtu_+cw-OpdRm02ELdbVt6T_5TQG3t4qAs2Q@mail.gmail.com> <e161c300e9c91237c5585fab084101a8f46768e2.camel@intel.com>
In-Reply-To: <e161c300e9c91237c5585fab084101a8f46768e2.camel@intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Wed, 5 Jun 2024 16:34:01 -0500
Message-ID: <CAAhR5DF=wAVsshyX-JqcPhhrVp8rEF11uJkB-OSEUM-B-oEZoQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 00/29] TDX KVM selftests
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Verma, Vishal L" <vishal.l.verma@intel.com>, "vipinsh@google.com" <vipinsh@google.com>, 
	"Aktas, Erdem" <erdemaktas@google.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"Xu, Haibo1" <haibo1.xu@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"Afranji, Ryan" <afranji@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"Yamahata, Isaku" <isaku.yamahata@intel.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "dmatlack@google.com" <dmatlack@google.com>, 
	"jmattson@google.com" <jmattson@google.com>, "Annapurve, Vishal" <vannapurve@google.com>, 
	"runanwang@google.com" <runanwang@google.com>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>, "pgonda@google.com" <pgonda@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 3:56=E2=80=AFPM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Wed, 2024-06-05 at 15:42 -0500, Sagi Shahar wrote:
> > > > Hm you're right, I was looking more narrowly because of the kvm-coc=
o-
> > > > queue conflicts, for some of which even v19 might be too old. The M=
MU
> > > > prep series uses a much more recent kvm-coco-queue baseline.
> > > >
> > > > Rick, can we post a branch with /everything/ on this MMU prep basel=
ine
> > > > for this selftest refresh?
> > >
> > > Actually I see the branch below does contain everything, not just the
> > > MMU prep patches. Sagi, is this fine for a baseline?
> > >
> > Maybe for internal development but I don't think I can post an
> > upstream patchset based on an internal Intel development branch.
> > Do you know if there's a plan to post a patch series based on that bran=
ch
> > soon?
>
> We don't currently have plans to post a whole ~130 patch series. Instead =
we plan
> to post subsections out of the series as they slowly move into a maintain=
er
> branch.

So this means that we won't be able to post an updated version of the
selftests for a while unless we lock it to the V19 patchset which is
based on v6.8-rc5
Do you have an estimate on when the TDX patches get to the point where
they could support the basic lifecycle selftest?
>
> We are trying to use the selftests as part of the development of the base=
 TDX
> base series. So we need to be able to run them on development branches to=
 catch
> regressions and such. For this purpose, we wouldn't need updates to be po=
sted to
> the mailing list. It probably needs either some sort of co-development, o=
r
> otherwise we will need to maintain an internal fork of the selftests.
>
> We also need to add some specific tests that can cover gaps in our curren=
t
> testing. Probably we could contribute those back to the series.
>
> What do you think?

I will take a look at rebasing the selftests on top of the Intel
development branch and I can post it on our github branch. We can talk
about co-development offline. We already have some code that was
suggested by Isaku as part of our tests.

