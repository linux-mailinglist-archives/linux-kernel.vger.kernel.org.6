Return-Path: <linux-kernel+bounces-370396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE52E9A2C11
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 680E9B28804
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285C11E04A3;
	Thu, 17 Oct 2024 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="So5tK1yo"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8692F1DF960
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 18:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188877; cv=none; b=qgnmBVFQv+Q25TjIdgpZjyPUO15wfGCCjYdhau3/Dq3d3pxKWBH2QPNcgHqvmuK0tImNQbUMNKBFYIIJept1JYkZGtczHtghaO4+E7Tc4J0VMSvBpKILCEHR3/XbdcBxL54kEIoj5gGw2ybS2cN6DCqlKW0yW9iPO2LUqmJagMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188877; c=relaxed/simple;
	bh=tuc4W4AtYfN2GY+JESTW7Xxp5b6QqoT46D1gF0g+QEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwHjPMBqhjqgSm1GimEhOgrHo0RsRLE+ZSx3r8DduxXLZAstZ7nT4dBjYBiFcrfSVMxYgY2n13mMl9EJFi63mCTWy1VvJfbLG4okLbyaLac5YvZJQhka94RgcK3wkTgfPU71rmHl9g42Gdrk0Z3ZIRjVoTPWrwaCRKsOvJlA+7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=So5tK1yo; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2888bcc0f15so155556fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729188871; x=1729793671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuc4W4AtYfN2GY+JESTW7Xxp5b6QqoT46D1gF0g+QEw=;
        b=So5tK1yoNCceX/2d5lckMMUnim05kGN+RDyKXhAqf6mHwushwu+HPnt24J2JKjQXkw
         R3o12IZLSwFCr66RSh6ltG5RfyL973KXfzhTR7Cblw18BKoGyzA5nCAigElUf0I4NPNz
         yTLbv4/J2EOWvgkNnIBwF6AhhokbtyP/XVBew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729188871; x=1729793671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuc4W4AtYfN2GY+JESTW7Xxp5b6QqoT46D1gF0g+QEw=;
        b=i1IGuU+YiCanv2IoZoRTYScDRcO424nF/VBwVppfEFgHvf1+DbSAF9CiUaFi1H4nIV
         4cC+e6jPCUsYVP05jD3gGQyitsy78sSVJYdLTEH3a4/MxW8WQ1eKmLNXaTjOHOQJmFa0
         XM3NcXysq/f8vrf0f640K8wTaebC1IJHymFvCenHnE38wCR4bqF6lr6kIU3Wq7kJiEZh
         L0i8NdGBAEMD7BnmQutRKwdncNNYdY/U0yMaY9FyM7nldgGdbcYP1e0iJtibrQ3ZGcO4
         JSRHdFYicansIKWi03ZZp4kNt3S6yUgYxrF4T66DPCaBJ3Y/Piev6czvejknsu2X7jqX
         onBA==
X-Forwarded-Encrypted: i=1; AJvYcCUfF/yC4HDu64qskfZp8WwAziINPZV5+jxUDVDgsGjWOfHc9uFc+U8P7r4KEhUIA+H4FEWJvlsiC4V9OvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Xv4PpXYr23LSuRd5MQUDG78Bwbi1Vvdm86SLr4vm55p+eCi2
	mchHNYiIBr61jzFrCBy7IrmRGf3SgXeK2yUIdnC3YsDNgvrffcUZozbJNCSHdCTcHVeuvUa6Ee+
	Zcv6Sp+A6Nc7MpKCPcjtaepIwTmxBW57SeKN7
X-Google-Smtp-Source: AGHT+IEVVY3x9zDyAxMQtSpj1wu+AKPQttF5+Qsw65HIRp9QuQsb3AQbNuaft90UaiRUD5a3DfimZkgaCjLSlrpmkTk=
X-Received: by 2002:a05:6870:e414:b0:25e:44b9:b2ee with SMTP id
 586e51a60fabf-2890c617250mr1177242fac.2.1729188871620; Thu, 17 Oct 2024
 11:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830180237.1220027-1-jeffxu@chromium.org> <20240830180237.1220027-5-jeffxu@chromium.org>
 <e7ea2b84-8d10-40fe-a14f-837bca851ea9@lucifer.local> <fd927106-2fc3-4b96-8014-2c517229bc99@lucifer.local>
 <CABi2SkUpCf+aOa2sPED8CosG5ccqjFd7ouot8gXi9ECqsHiZhw@mail.gmail.com>
 <4944ce41-9fe1-4e22-8967-f6bd7eafae3f@lucifer.local> <CABi2SkUgDZtJtRJe+J9UNdtZn=EQzZcbMB685P=1rR7DUhg=6Q@mail.gmail.com>
In-Reply-To: <CABi2SkUgDZtJtRJe+J9UNdtZn=EQzZcbMB685P=1rR7DUhg=6Q@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 17 Oct 2024 11:14:20 -0700
Message-ID: <CABi2SkVEMRHV3swrbb6M5RA6GQpFVVx855CGwdQ1xiz3tygiqA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pedro.falcato@gmail.com, willy@infradead.org, 
	broonie@kernel.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	rientjes@google.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo and Muhammad

Reviving this thread since the merging window is closed and we have
more time to review /work on this code in the next few weeks.

On Fri, Sep 13, 2024 at 3:50=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrote=
:
>
> Hi Lorenzo
>
> On Sat, Sep 7, 2024 at 12:28=E2=80=AFPM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> >
> > I also suggest we figure out this FAIL_TEST_IF_FALSE() thing at this po=
int
> > too - I may be missing something, but I cannot for the life me understa=
nd
> > why we have to assert negations only, and other self tests do not do th=
is.
> >
> My most test-infra related comments comes from Muhammad Usama Anjum
> (added into this email), e.g. assert is not recommended.[1] ,
>
> [1] https://lore.kernel.org/all/148fc789-3c03-4490-a653-6a4e58f336b6@coll=
abora.com/
>
Specifically regarding Lorenzo's comments about FAIL_TEST_IF_FALSE

Muhammad Usama Anjum doesn't want assert being used in selftest (see
[1] above), and I quote:
"We don't want to terminate the test if one test fails because of assert. W=
e
want the sub-tests to get executed in-dependent of other tests.

ksft_test_result(condition, fmt, ...);
ksft_test_result_pass(fmt, ...);"

FAIL_TEST_IF_FALSE is a wrapper for ksft_test_result macro, and
replacement of assert.

Please let me know if you have questions on this and Muhammad might
also help to clarify the requirement if needed.

Thanks
-Jeff

