Return-Path: <linux-kernel+bounces-315563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D4896C43A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F5D1F25B2A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1266A1E00BD;
	Wed,  4 Sep 2024 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DGp4l2k9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F60A6E619
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725467862; cv=none; b=mh6isGeTu0gXzbku/4b/iwXV22EDL+/+vVxQUgYSYCUXVlYgpuIHMNrLbpLbOG+GKi88nmeymRMvclCAb+40PTnTA7ULIfFM3xlYqFH/6SnNc/rnXPgcQWOZIgvSbij/aaBpbtWHduzmXV3aaXh+AC1bofV//voQmxbHi09d2kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725467862; c=relaxed/simple;
	bh=M5xpsYMrrh+7L6ZbKTC6zzNdJMf41WwinksoXjY18xI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVFb+aejNE83X47eWfsWpLk+1C1DXdZGJKZ9hw6mZ1IcRE9T1VvFGwHBVBiu5ZrXMeRCySfkrQqgteB1TFfuaHSnljjOtZSPgt7kihbGUmSMWoI3LkRR9+5wklPanh3AxAGVWoKChNUkEnkQVbbbY+dCR0fDGRLsO7V/roiwyRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=DGp4l2k9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4550C4CEC5
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:37:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DGp4l2k9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725467859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ytl0r9TAcD8O+89JumHN4lgJwo80RLVIXPusfUj9giI=;
	b=DGp4l2k9B6siCZLTRhfUMPNvqx7RUP3YZ/VN7D80hrgSMRlSLNEob+oI5e0mhUGE/iedF8
	8gw60beZtSxBbGbmjWHFz2DT61CGfX2ysW1a1wTSga1HkDt2Ejif9Ok/PytgnRqmcSRPxq
	RixMdQibl7uqIkqUDdxSGeXDRrmfV0o=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f1675147 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Wed, 4 Sep 2024 16:37:38 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-27830bce86bso651979fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 09:37:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWKjCkQVP7YJ6mnfuOB2yyfEZx2f3Rn3F3B2GrNOROmrg5dzFpvtkRZ0gaVZ5nRY7D2Ef1lNu8MU9aH6kI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy749j84ASy09adG5uQLDLb/4k+LePX2/cxWoaSV5uhNnfodG+l
	Q3Q8hku9QG9ZguM1dan1R3b+p0i37KkWyV0IgSGvws0SxL4odCig/8VXW2s6ZB+XrTi3h0Ys9U8
	qebdPpC838yK0ZMzlq81at4Ox6K8=
X-Google-Smtp-Source: AGHT+IENXxGDivKi28BOw6DECCQW3as/v8z5ANaZ8b8VDAnQEdV7BaJeDtYlSJIrSgzEy1UJ/kozOSe9JEidGKhqYRM=
X-Received: by 2002:a05:6870:170c:b0:27b:5890:bd38 with SMTP id
 586e51a60fabf-27b5890c337mr2227565fac.7.1725467857891; Wed, 04 Sep 2024
 09:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <30e9575c-a53e-4e17-bbbd-7127798efb05@csgroup.eu>
In-Reply-To: <30e9575c-a53e-4e17-bbbd-7127798efb05@csgroup.eu>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 4 Sep 2024 18:37:26 +0200
X-Gmail-Original-Message-ID: <CAHmME9riDsWbfQe898EAGPCU1k-pasnVV=fXu_JWKdB9AJru5Q@mail.gmail.com>
Message-ID: <CAHmME9riDsWbfQe898EAGPCU1k-pasnVV=fXu_JWKdB9AJru5Q@mail.gmail.com>
Subject: Re: Profiling of vdso_test_random
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Adhemerval Zanella <adhemerval.zanella@linaro.org>, Xi Ruoyao <xry111@xry111.site>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 1:41=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> Hi,
>
> I'm done a 'perf record' on vdso_test_random reduced to vdso test only,
> and I get the following function usage profile.
>
> Do you see the same type of percentage on your platforms ?
>
> I would have expected most of the time to be spent in
> __arch_chacha20_blocks_nostack() but that's in fact not the case.
>
> # Samples: 61K of event 'task-clock:ppp'
> # Event count (approx.): 15463500000
> #
> # Overhead  Command          Shared Object        Symbol
>
> # ........  ...............  ...................
> ....................................
> #
>      57.74%  vdso_test_getra  [vdso]               [.] __c_kernel_getrand=
om

Can you run `perf top` to see which instructions are hot? There are
some smp barriers in there which might be significant.

