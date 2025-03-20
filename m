Return-Path: <linux-kernel+bounces-570106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAC6A6AC23
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992B6188830B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6D5224B1E;
	Thu, 20 Mar 2025 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/2l5o1j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2771E3DFE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492187; cv=none; b=Mchv1VECkAASmUF2K+48LNSvNj57AOlyUrHygvBqg63P/F1eO+0KYXlhLIel+i+4p+UkAQHYmQ6jPD3Qa2nfX03dC8/K8PObXgkh6hkNwHeA3S6QuHWb7o00pa/rqykB+eoocWvdvF0+meqFqdUfLRiStCpb+imr84wW1+nmcbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492187; c=relaxed/simple;
	bh=BsxCuARzgsXF0fZ/cJynLwC1BadWBfylj8v4JP89yYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZ+r+sFNC3OS2AylmbHVYp/k1TgXOL5WvgYw0spvEw14hhgYxsusvMzc1+ClVR7Qg71Mpa1qRCbW6VZkY6OUGsU7J10btvc8dfU7xrC9/Nn9eI/s+/E6m3obKZ6PY8GGAa+fIwNEFJVwKlChDw8S8VSdESZ8o2pahWFL1wDiNrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I/2l5o1j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742492185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TS+4w9CAl2tIEOQMQq3dJT2Sg4uIiNyRqIfuwfurzGo=;
	b=I/2l5o1jlvVC3nE00iCUuPKqYZv875zcpd5z7375GSJ8HoGJmcu3ra/3Xey5rBKnFphP+5
	+2eg7dU/SuTXs10hBUgxISF2mPXvDZiqTc0NYCDcsD2i+NCy2YhHB/iiIPPZQqZRuVj1TR
	jJ7x+pU1KXnbJfm/zKzPvViK/vbberw=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-pqUuhmq-MX2mpu2tvewl0A-1; Thu, 20 Mar 2025 13:36:24 -0400
X-MC-Unique: pqUuhmq-MX2mpu2tvewl0A-1
X-Mimecast-MFC-AGG-ID: pqUuhmq-MX2mpu2tvewl0A_1742492183
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e5798866415so1643969276.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742492183; x=1743096983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TS+4w9CAl2tIEOQMQq3dJT2Sg4uIiNyRqIfuwfurzGo=;
        b=rfhZnLH7FhN2+EIfIcni66KO6RmdUl2MoRXv9uGVaG/w4KlrqVUrQmv8nZh+IZUXED
         bCGx7XhME/lsmxhtd77NejilSkW8I4dtESeYiW7Lruz9ujgdiMPBsEf40s5fGiupaxEi
         TtP3YUv6dq0E3TPSeXMJx0ztfNBJZ/UFlnM2cvD5RtONyI84zzhtX23fEbA3vw8Frq6L
         fjl5std7Sm179tu7lllGigqLgGY2lkqL/xQa9aJYfKnY0IiL6SUS7iFsJHBdjVNdEzC8
         RaOLXbShINuhvWdxhvBk3ju4LPYPOTO3LNSIh+F9IPUupO8CRytEAL7Z1LGIoZcsgP/8
         vdrA==
X-Forwarded-Encrypted: i=1; AJvYcCXPg/JlyjoPSuTKGF438Mly4eQBPBE8I+7W3xBtApOphiBTy2Vozb6qUIvPe2jFwoc8Rxq8EGt+4E1EIyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlM3Iqji+i+9/nUCzAIQo1tfScnwnWRg1I/3MAHHxPH5TorO3G
	MnUm9XiuV/WLg49U9tPIqQRWlYgeo0/kVwdiCLRDe5bY8gK5NvMmnJJZKGXdXcwbCKZm+t5f4wN
	nG6Yk6JiSN/O/Hgj1nObwC8HtQp7WsYbY/e6ul4npMO84BNlmlm57ggNf7Sghz8d4RgmMVNepl8
	J3ZGY0abc5M3xk1Zue8McO8jpZ2EFhn6DCSSoc
X-Gm-Gg: ASbGncsW6uGlpv1RzjsFr+SFxHS43wBEp0pKV7QGpCPpkRqSv9+rwvEaHv4xV0xz3FO
	EhhzeZc8stNPEyMgQiqx8gyBRBkA7DF3932pusB6ilmYYv8fgCi6lV/+aIOBYudOJCcpe1x50YE
	Ws+umrLrMLFnU=
X-Received: by 2002:a05:6902:1202:b0:e61:1c56:d65e with SMTP id 3f1490d57ef6-e667b440ef8mr10265003276.39.1742492182653;
        Thu, 20 Mar 2025 10:36:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4DsqqSKudGoKHtTUn4Fmd3OoauVYJ8GzOdn97tjiAKk4pZ909yot7m2DdxBTPxvcnexGeBhyy56vFTgpGLlY=
X-Received: by 2002:a05:6902:1202:b0:e61:1c56:d65e with SMTP id
 3f1490d57ef6-e667b440ef8mr10264952276.39.1742492182191; Thu, 20 Mar 2025
 10:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319230539.140869-1-npache@redhat.com> <CAA1CXcD2g=sRRwgLSudiOAqWXq3sCj+NPuE1ju7B2gFXXefjXA@mail.gmail.com>
 <d8fc1f66-f220-42fb-b58f-f5f9c7d30100@opensource.cirrus.com> <CAA1CXcA460xfy48JMNeX5rNTfUqsahER8SDF6tWu82V35ripLg@mail.gmail.com>
In-Reply-To: <CAA1CXcA460xfy48JMNeX5rNTfUqsahER8SDF6tWu82V35ripLg@mail.gmail.com>
From: Nico Pache <npache@redhat.com>
Date: Thu, 20 Mar 2025 11:35:55 -0600
X-Gm-Features: AQ5f1Jp6vn-oRetNEyCNIJpnAAyYyOS_O9jU7OObd_b5NCpGJ35-7np594Rfj8o
Message-ID: <CAA1CXcD2RF6aXNH0ix=GN1+LTR9+dV7yRz-HGKZfUbSu+8ZM_w@mail.gmail.com>
Subject: Re: [PATCH] kunit: cs_dsp: Depend on FW_CS_DSP rather then enabling it
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: broonie@kernel.org, patches@opensource.cirrus.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, simont@opensource.cirrus.com, 
	ckeepax@opensource.cirrus.com, brendan.higgins@linux.dev, davidgow@google.com, 
	rmoar@google.com, johannes.berg@intel.com, sj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry links got mangled

X86_64 : https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-ar=
tifacts/1723153780/test_x86_64/9451298630/artifacts/run.done.01/job.01/reci=
pes/18353773/tasks/7/results/1742341634/logs/resultoutputfile.log

X86_64 (debug) :
https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/1=
717840829/test_x86_64/9419724200/artifacts/run.done.01/results_0001/console=
.log

aarch64 : https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-a=
rtifacts/1723153780/test_aarch64/9451298664/artifacts/run.done.01/job.01/re=
cipes/18352965/tasks/7/results/1742330044/logs/resultoutputfile.log

aarch64(debug):
https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/1=
717840829/test_aarch64/9419724214/artifacts/run.done.01/results_0001/consol=
e.log

aarch64-64kpagesize:
https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/1=
723154540/test_aarch64/9451303359/artifacts/run.done.01/job.01/recipes/1835=
2963/tasks/7/results/1742331192/logs/resultoutputfile.log

aarch64-64kpagesize (debug):
https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/1=
723154644/test_aarch64/9451304808/artifacts/run.done.01/job.01/recipes/1835=
4911/tasks/6/results/1742356729/logs/resultoutputfile.log

ppc64le: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-ar=
tifacts/1723153780/test_ppc64le/9451298644/artifacts/run.done.01/results_00=
01/console.log

ppc64le(debug):
https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/1=
717840829/test_ppc64le/9419724210/artifacts/run.done.01/results_0001/consol=
e.log

On Thu, Mar 20, 2025 at 11:33=E2=80=AFAM Nico Pache <npache@redhat.com> wro=
te:
>
> On Thu, Mar 20, 2025 at 6:21=E2=80=AFAM Richard Fitzgerald
> <rf@opensource.cirrus.com> wrote:
> >
> > On 19/3/25 23:11, Nico Pache wrote:
> > > On Wed, Mar 19, 2025 at 5:05=E2=80=AFPM Nico Pache <npache@redhat.com=
> wrote:
> > >>
> > >> FW_CS_DSP gets enabled if KUNIT is enabled. The test should rather
> > >> depend on if the feature is enabled. Fix this by moving FW_CS_DSP to=
 the
> > >> depends on clause, and set CONFIG_FW_CS_DSP=3Dy in the kunit tooling=
.
> > >
> > > A further note here:
> > >
> > > This test is failing and panicing across multiple arches, and
> > > triggering kasan slats on debug kernels. I think this test needs more
> > > testing ;P
> > >
> >
> > Please supply details of failures or links to bug reports.
> > "is failing" and "panicing" doesn't tell me enough to fix anything.
> > Failing how? Panicking how? On what architectures?
> > I tested it on the architectures I have available, and the kunit um
> > architecture. Unfortunately not everyone has hardware for every
> > architecture supported by Linux so we have to trust somewhat that
> > other architectures don't do anything unexpectedly different from
> > what we _can_ test it on.
>
> Some of the runs return not ok on a bunch of tests, debug kernels
> print splats, and some seem to brick the system, leading to a reboot.
> Below are all the failures per arch/variant.
>
> Failing on
> ---------------------
> X86_64 : https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-=
artifacts/1723153780/test_x86_64/9451298630/artifacts/run.done.01/job.01/re=
cipes/18353773/tasks/7/results/1742341634/logs/resultoutputfile.log
> X86_64 (debug) :
> https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts=
/1717840829/test_x86_64/9419724200/artifacts/run.done.01/results_0001/conso=
le.log
>
> aarch64 : https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted=
-artifacts/1723153780/test_aarch64/9451298664/artifacts/run.done.01/job.01/=
recipes/18352965/tasks/7/results/1742330044/logs/resultoutputfile.log
> aarch64(debug):
> https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts=
/1717840829/test_aarch64/9419724214/artifacts/run.done.01/results_0001/cons=
ole.log
> aarch64-64kpagesize:
> https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts=
/1723154540/test_aarch64/9451303359/artifacts/run.done.01/job.01/recipes/18=
352963/tasks/7/results/1742331192/logs/resultoutputfile.log
> aarch64-64kpagesize (debug):
> https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts=
/1723154644/test_aarch64/9451304808/artifacts/run.done.01/job.01/recipes/18=
354911/tasks/6/results/1742356729/logs/resultoutputfile.log
>
> ppc64le: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-=
artifacts/1723153780/test_ppc64le/9451298644/artifacts/run.done.01/results_=
0001/console.log
> ppc64le(debug):
> https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts=
/1717840829/test_ppc64le/9419724210/artifacts/run.done.01/results_0001/cons=
ole.log
>
> >
> > Also, are any of these failures the unterminated string bug that someon=
e
> > fixed recently?
> Not sure. That fix doesn't seem to have been merged yet.
> >
> > >>
> > >> Fixes: dd0b6b1f29b9 ("firmware: cs_dsp: Add KUnit testing of bin fil=
e download")
> > >> Signed-off-by: Nico Pache <npache@redhat.com>
> > >> ---
> > >>   drivers/firmware/cirrus/Kconfig              | 3 +--
> > >>   tools/testing/kunit/configs/all_tests.config | 2 ++
> > >>   2 files changed, 3 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/drivers/firmware/cirrus/Kconfig b/drivers/firmware/cirr=
us/Kconfig
> > >> index 0a883091259a..989568ab5712 100644
> > >> --- a/drivers/firmware/cirrus/Kconfig
> > >> +++ b/drivers/firmware/cirrus/Kconfig
> > >> @@ -11,9 +11,8 @@ config FW_CS_DSP_KUNIT_TEST_UTILS
> > >>
> > >>   config FW_CS_DSP_KUNIT_TEST
> > >>          tristate "KUnit tests for Cirrus Logic cs_dsp" if !KUNIT_AL=
L_TESTS
> > >> -       depends on KUNIT && REGMAP
> > >> +       depends on KUNIT && REGMAP && FW_CS_DSP
> > >>          default KUNIT_ALL_TESTS
> > >> -       select FW_CS_DSP
> > >>          select FW_CS_DSP_KUNIT_TEST_UTILS
> > >>          help
> > >>            This builds KUnit tests for cs_dsp.
> > >> diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/te=
sting/kunit/configs/all_tests.config
> > >> index b0049be00c70..96c6b4aca87d 100644
> > >> --- a/tools/testing/kunit/configs/all_tests.config
> > >> +++ b/tools/testing/kunit/configs/all_tests.config
> > >> @@ -49,3 +49,5 @@ CONFIG_SOUND=3Dy
> > >>   CONFIG_SND=3Dy
> > >>   CONFIG_SND_SOC=3Dy
> > >>   CONFIG_SND_SOC_TOPOLOGY_BUILD=3Dy
> > >> +
> > >> +CONFIG_FW_CS_DSP=3Dy
> > >> \ No newline at end of file
> > >> --
> > >> 2.48.1
> > >>
> > >
> >


