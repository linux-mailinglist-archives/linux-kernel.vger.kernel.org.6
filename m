Return-Path: <linux-kernel+bounces-334533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9343097D868
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56D31C22919
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E4014A4FF;
	Fri, 20 Sep 2024 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JGIwn20b"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8330282F7
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726850253; cv=none; b=ONrSdROnNzDU7pk0i5fgNN1ZXSMF64zp41MvPFP0xwGDniEAfJYgLKkzuwyrU+UjOHxOxSdEhrlvqhZxfNnALeK+YsjA+c0OhI8nuQOoE7xHxycs2VQbQcvniOEJDlnJiFXGx3AyplbJsc055Sn1sC/5NXLhFDogIHqBnNLbPNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726850253; c=relaxed/simple;
	bh=CLdeFhcXjFW/Rn670pgZvMahwb04Xg2afg6QSLEsW9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNs/HjUA+cjCQSEGfFAmtB1RmG8fPOFLBhl/odU9E3739mF66fNwth2znomINOyNQ+tEgTTAOYC3Vl1ayVG6nPViE/lmidgRZ58C2c1lqQ7IPRC1mP4Hy3I5XUa1oedDfdjznSYvd2TSgcMMT1vBnfHDh/eyRuUZV/x8V2J+7CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JGIwn20b; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3db3763e924so223934b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 09:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726850251; x=1727455051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeUoiC4xV3CiCxio8wPUbYZ9DxOg+zY+E1xCmjqF+qE=;
        b=JGIwn20bV1Jl3+RqvTu6eBnUUzjlhm69/EXrjM1sItTAwffQkPpUm2xD0+k/P9zNEU
         EcrkwBbhaTnRZGqj1CjUveQ68nYirkXhWFqXVmnLNAGOacknExPmHBQouGr+aAwVMwov
         ULan7rNbT5Bmf+8sm1xkHP7+epfKPqeqbiGS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726850251; x=1727455051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeUoiC4xV3CiCxio8wPUbYZ9DxOg+zY+E1xCmjqF+qE=;
        b=SqPswLiUJWEhC0eihUSuS1hiwreMXwQuDEqCBi7YWU5Fh4Yg0L7iucRPX5kX/UAzyw
         OZ5+wSfx/biGoMUnu2ZsQKD+YfW8QUATr9ael8ClBfchh+DGtyaGGoQIjV3id7lf3mvI
         Ttd1M6Kp4ITGxQpH8YIg5PFZs7D6Kja0BIEKCeCM2Ftbl5BxySyPm0KRpun8bGxrdtB6
         LM+kQymKqDAs/z94AFzz7ZAEbasYWSkX9kZE52SjkhflatskPxvYqsEGz2ZcB+nbPUm/
         ag+z7Rvpo7007gVdajRiRqKWQLFU803UpJ8QRy/bZKHE5ak6bWi/ESpotV/+0hX8lCuQ
         ltqw==
X-Forwarded-Encrypted: i=1; AJvYcCWbbXAqAmGwXv+tvxS0zJ7D5cCupnYLU/lC38URkfH4tRA4hy6+S0p6g5zWOnbinEJy9ZINk6kx460gGdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRE/QSPZLVLf0n4ZvCYjhbLsNlQFRVokh72GeigWwY5782OZ32
	16CmcZMhQ5Buhqf6CRHK8vlrIugHpFPLm54EpYz8CeEkurT1ybHeAJ6uNtwgfmlOt24Y7m5RYHQ
	CeyElc1S3OiLvJxjH+/zaZR8hgnx55TSwLbt4
X-Google-Smtp-Source: AGHT+IEgc6oFjG/AVNeyCwNJdiZ7/4I53v5fqxBfmjiWXrV2OLBvKIkIyisPGyrs125247P4H7Q2d819NzxIHSA2I1E=
X-Received: by 2002:a05:6870:870c:b0:277:db1c:7c6a with SMTP id
 586e51a60fabf-2803a62c744mr749865fac.7.1726850250833; Fri, 20 Sep 2024
 09:37:30 -0700 (PDT)
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
 <ZurTHc1C27iqofjp@finisterre.sirena.org.uk>
In-Reply-To: <ZurTHc1C27iqofjp@finisterre.sirena.org.uk>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 20 Sep 2024 09:37:17 -0700
Message-ID: <CABi2SkUQM8girk31jDYMfx8kVoG0xXMwaSDWmu90b4ZmtdmHHQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
To: Mark Brown <broonie@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, akpm@linux-foundation.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pedro.falcato@gmail.com, willy@infradead.org, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, rientjes@google.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark

On Wed, Sep 18, 2024 at 6:18=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Sep 13, 2024 at 03:50:00PM -0700, Jeff Xu wrote:
>
> > Even though the number of lines is large in these patches, its main
> > intention is to test Pedro's in-place change (from can_modify_mm to
> > can_modify_vma). Before this patch,  the test had a common pattern:
> > setup memory layout, seal the memory, perform a few mm-api steps, verif=
y
> > return code (not zero).  Because of the nature of out-of-loop,  it is
> > sufficient to just verify the error code in a few cases.
>
> > With Pedro's in-loop change, the sealing check happens later in the
> > stack, thus there are more things and scenarios to verify. And there we=
re
> > feedback to me during in-loop change that selftest should be extensive
> > enough to discover all regressions.  Even though this viewpoint is subj=
ect
> > to debate. Since none would want to do it, I thought I would just do it=
.
>
> > So the Patch V3 1/5 is dedicated entirely to increasing the verificatio=
n
> > for existing scenarios, this including checking return code code, vma-s=
ize,
> > etc after mm api return.
>
> > Patch V3 3/5 are for unmap(), during review of V2 of Pedro's in-loop
> > change, we discovered a bug in unmap(), and unmap() is not atomic.
> > This leads to 4/5(mmap), 5/5(mremap), which calls munmap().
> > In addition, I add scenarios to cover cross-multiple-vma cases.
>
> > The  high-level goal of mseal test are two folds:
> > 1> make sure sealing is working correctly under different scenarios,
> > i.e. sealed mapping are not modified.
> > 2> For unsealed memory, added mseal code  doesn't regress on regular mm=
 API.
>
> > The goal 2 is as important as 1, that is why tests usually are done in
> > two phases, one with sealing, the other without.
>
> That's vastly more detail than is in the changelogs for the actual
> patches (which are just a few lines each) or the cover letter of the
> series.  I don't have the MM knowledge to assess the detail of what
> you're saying but I can't help but think that it'd help a lot with
> review if all this detail were part of the actual submission.
Agreed, will update and give more detail in the next version of the patch.

Thanks
-Jeff

