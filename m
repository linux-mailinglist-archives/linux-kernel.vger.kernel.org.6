Return-Path: <linux-kernel+bounces-569462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C79A6A34E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A841F3A7121
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3243B222582;
	Thu, 20 Mar 2025 10:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AdNM3GB/"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB76A209695
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742465282; cv=none; b=qoPWjMXEHJT4Kp600paoGonPQdfR6gn9CKLi8TsDIRQOnNV/BOpkTP+MQ+DMbY4HMjBl/TnPRryI/+XRpnTSvAqPugbs1O+ehNqDIEwVtdkbnFgtwtKvv8e596iyN4Cy8zmKwyKJUZb/XXk8iXOM17xZUav8ZoNbvGF6+H9x7sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742465282; c=relaxed/simple;
	bh=eRSrVtMxeOkRdLgzQZjJTcR4g+Ot8SyG6qMCg2wl0y4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Iy+6wUHhOPVmBha1opSq9EtbIDnZeCBJU0EteWELqMvlIFzT0tnj48fvVz/bSf/PRy3CbYxf+3kY82azCwXoZcTp6LglSEf8+N3/83tyU627csxBPMfmcSKlv3VjKbsF98n9rujBd+xe22tMd7hThF8yxxDmMgVKsbE5km6i4i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AdNM3GB/; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cf327e9a2so5091065e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 03:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742465279; x=1743070079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCckw45a7feLFYCzb/fWI3ZH/OLphPyC3sVMuHh/txI=;
        b=AdNM3GB/aNiXP2TsINsPrAtvTQK5cNOmULhw0TbwNP7c+Jy+zGn4JGMqH5C/YGThCd
         FvYFbNYQzGzZySU9g/kEAK9y5rhSRhQVBrxGIgU5CZmv1qbcTfd41HDlOFN9+ib+5YI3
         qN/Iew3VD/cRT5nCpaGTfKWtMZD35UN/pN2SqdNrg7/fBMGxkRL7StrZBZeO0hlht9Sx
         pj789F2bw4zszEC2UhfkRBBIxERVA5+C0Tuj34qPPgjWByR3PHfkutpUh5z+SnabCGBm
         9HjwQwk45RhXFwIO+h9mmAkc4Bw00bli8EpVBeHQF8ClUJ1dDCoSQ6TYfANOGOoM8I73
         UT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742465279; x=1743070079;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eCckw45a7feLFYCzb/fWI3ZH/OLphPyC3sVMuHh/txI=;
        b=EbK0VGy7cSx7y3g4zuQqfiqD5OxCTy18yJF+TvsFSBRC/U+hy1dWSDrBn6Cg1KMQBi
         vl4L/DdcUDJ8NazgMCfH4I0+ThXfcEU/OChBVDx1/iFoSIlb6zajn6Nna9jFpkUvMMHa
         id3808zwd240yIJAa4ox/OO8V+jxgV3uVYxH+LTtJFtNV4ngfGh06EM7oK+Hr1R/6Loh
         RIJPL9ig9qHBsrY/emVWEfoRGvM5uZ+4/L5eNdWt58TQj5H+F5SD1UHTAQduz6m2nE/r
         /gLhveQbfnXAhhENQYz5IrIS2GSRYhEpKYlITryM967geO6QeSadkvzJbU3wFDsCDwqL
         NSDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlRTcO6VeAXXX6SVfz6ZqK8CmZbog5/JMLRjC8Hi49Zfqiv6k6Ra3TlkUzcIh4L8dSJroc1EMSLeYaq90=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhJEFCIpcsdThWxzCsISl/ml3PFFUDIoJlHPqbn/juNadcSHjG
	Ib82t87W1aPtAm1osUvH3GeYuzHnHwrYgCcT1D2QPbX5fyqggsZE8RcZONNigkk0CN7EzBVEFgb
	y8f2sTSUkJg==
X-Google-Smtp-Source: AGHT+IHeNu1M0oFmTilVd3b1yzVV1iOJpMjgLNtvl5tVkcwp28TKKBFS2HmVJOJaGl8Njawv08xRnZzLVzx0xg==
X-Received: from wmbbi21.prod.google.com ([2002:a05:600c:3d95:b0:43d:cf6:81b9])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:548d:b0:43c:ec28:d310 with SMTP id 5b1f17b1804b1-43d43798880mr66076035e9.10.1742465279171;
 Thu, 20 Mar 2025 03:07:59 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:07:57 +0000
In-Reply-To: <CA+GJov4CDitQ0w2CU46rk_zwNxU_Mn1wwGNgn-xx3uA3MwDoRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313192714.1380005-1-rmoar@google.com> <CABVgOS=Pfp2_ZvCtxy6X_xoM6pGVgT6bD_4VxGVZ_SNWVgesGQ@mail.gmail.com>
 <CA+i-1C3ZORa0hFHz=d6F3ThVWUEFv8Qnyq-i6EFsrn843fSOtw@mail.gmail.com> <CA+GJov4CDitQ0w2CU46rk_zwNxU_Mn1wwGNgn-xx3uA3MwDoRg@mail.gmail.com>
X-Mailer: aerc 0.18.2
Message-ID: <D8L0E1Q6XSWX.2ZJ6N0FMGKEJ4@google.com>
Subject: Re: [PATCH v3 1/2] kunit: tool: Fix bug in parsing test plan
From: Brendan Jackman <jackmanb@google.com>
To: Rae Moar <rmoar@google.com>
Cc: David Gow <davidgow@google.com>, <shuah@kernel.org>, 
	<linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed Mar 19, 2025 at 9:11 PM UTC, Rae Moar wrote:
> On Mon, Mar 17, 2025 at 12:13=E2=80=AFPM Brendan Jackman <jackmanb@google=
.com> wrote:
> >
> > On Fri, 14 Mar 2025 at 06:37, David Gow <davidgow@google.com> wrote:
> > >
> > > On Fri, 14 Mar 2025 at 03:27, Rae Moar <rmoar@google.com> wrote:
> > > >
> > > > A bug was identified where the KTAP below caused an infinite loop:
> > > >
> > > >  TAP version 13
> > > >  ok 4 test_case
> > > >  1..4
> > > >
> > > > The infinite loop was caused by the parser not parsing a test plan
> > > > if following a test result line.
> > > >
> > > > Fix this bug by parsing test plan line to avoid the infinite loop.
> >
> > Hi Rae,
> >
> > With this change and this input:
> >
> > https://gist.githubusercontent.com/bjackman/220265699f346e16161c6534b11=
5019b/raw/a2e0e1aa75c0d8ab9814708b028ec78810a0471b/run_vmtests.sh.tap
> >
> > The infinite loop is gone, but it's still hallucinating a [CRASHED] res=
ult:
> >
> > [16:07:15] # SUMMARY: PASS=3D17 SKIP=3D0 FAIL=3D1
> > [16:07:15] [CRASHED]
> > ...
> > [16:07:15] Testing complete. Ran 19 tests: passed: 17, failed: 1, crash=
ed: 1
>
> Hi! Thanks for the response. This is an interesting problem. Should a
> test plan at the bottom cause a crash because no tests were found
> after? Again with KTAP, a crash would make sense. I feel this example
> demonstrates why there is a need for a general parser that can parse
> kselftest output as well as KUnit.  I'll see how difficult it would be
> to change the parser to accommodate removing the crash in a new
> version. Thanks!

Yeah, if this is difficult, it would be fine for the KUnit tool to
just say "sorry this is a KTAP parser not a general TAP parser"

With your new patch:

https://lore.kernel.org/linux-kernel/20250319223351.1517262-1-rmoar@google.=
com/

I get this:

[10:00:41] # SUMMARY: PASS=3D17 SKIP=3D0 FAIL=3D1
[10:00:41] [ERROR] Test: : No more test results!
[10:00:41] [NO TESTS RUN]

Which I think is basically fine.

We do want something that can parse this stuff properly but I tihnk
that's a separate little project.

Also, vanilla non-K TAP... is honestly a terrible format.  A flat
structure for the test results (i.e. no nesting) is a bit of a joke -
even for just run_vmtests.sh which has a pretty tractable amount of
tests, it's already a pain to mentally keep track of which results
come from where. Maybe if I want to be able to parse the output of
tests I should just switch them to using KTAP.

