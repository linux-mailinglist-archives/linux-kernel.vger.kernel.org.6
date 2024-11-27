Return-Path: <linux-kernel+bounces-423789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5685C9DACAE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 18:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2643164975
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF4B200BBD;
	Wed, 27 Nov 2024 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kB4bif05"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49862030A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732729554; cv=none; b=sgvm2L31DClfKmslIquTP6sOWzOpz3oyZBkovkkcJhoJ8CKIq2k+mfnvEFf/1pInR13bo9HiHKvt41HtQNX+5lPeDy1TvsZImd2BQu18EFk2jyaAMW8EufZUTxEhVjAWCFrXrEqEV9GbfiAJQKJ7o9Ol3jPpiKmmtQzZDbvOf0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732729554; c=relaxed/simple;
	bh=8OfaUvJ9o9eIT//2viRH5VonqIyT8g3R4krV9Hm2+Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8fiKsl9NfMDr/E/NkwJoZgPwTGxptNpcvqana6BhTqtCFn5dAwC3/Stb2ngVQ5EIXIC+TI5Pz+ZLWVPsG8OEaE7jBkCLURRG++7Bndu/aKC2uacyXQggfRjY3g1lOUUBDiQegCTqOqfeNOTTIpkc1gVjVriOsEE8doOuWIhO4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kB4bif05; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa51bf95ce1so874889166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 09:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732729551; x=1733334351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GM1k7e/CGPkjphrw4jyDzxyswsZTnM5h4OmjO0f7EY=;
        b=kB4bif05Zf6YlnCDKItBnDAaKojMN+EKXmPrYtYaJAbP0locEAL0qB1v8pRUWdGgBs
         O15Hqy4FuBtLN8ECGLHeR/n+Zd2gu4csNudretILc1TPXspLO2MdrE1FsYwHs8gq/jVU
         ZgRHsR7jAe035K0wwkmO8YGTcybXM5a4QyhkHKOrrhALFzyfUmAdZhtfPVJMamx6nind
         jCM/AJEPX0R8fgWYOWcZOtdED4sJle2lVRRvbI8jAYk7AXknuIxRfnNrH3YFJTPPxx6P
         u+vNL500GXOETX5g1KqioP3WXYBiYi8MjilxbXAdu5B8Jqj1him9NMHhEC331apwzcM3
         8zxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732729551; x=1733334351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GM1k7e/CGPkjphrw4jyDzxyswsZTnM5h4OmjO0f7EY=;
        b=LtzGSVLGxxDi58KdOZujkrR2ZP3gEt3MKAcrAl31wmMs8U6v60xx8q5nVIOpHIfZVS
         s3PeqEuMZYPrs+v1Vm4BRSD1WF6FfSAf5eCUy5G8A0h3OcjrUOHLat/CxJX36nPBb9v6
         xM9cAYqg591xsrj8mZFm89tu7tyTo0OnjF3HNF6cbltZQT5lKu3Q10EKHfo3OI2uZMVN
         s7zYAbqOSK6mxoEf+tmRLjhRXngzWbp5bhyIRqJWS5PvYmHgStW35zIc5owFTUBCMQ1P
         yaO8ywZidmD5idRNEUG9ycdlARoI8qp1TzOIRuaksPJ37agzjC+eSLpotM3SaYhjzVDK
         y7Ww==
X-Gm-Message-State: AOJu0YwxEfJ1VjiXy599T3A91sIDD1lLBw33ZsU9Wa9yoXgklplGPgxV
	aKa9/mXHu69ZvE3nrId4EagfM5rKmkgC6Thsx+AsnfNQsiIE8Ewxutkyd/fQjc9f5kyu7nEIcYG
	qwVR5jXoj/Mn/9XPO411qcRxw4ng=
X-Gm-Gg: ASbGncuZIJpP2uFyIe2VbOoMFh6og50LqRrmheVjHqczwBJGl4mTj9IIQw4gMqBIg8W
	E24i22oYtB7jIg19HWPrW3UYyiVcqNa8=
X-Google-Smtp-Source: AGHT+IEU+8rlp9swAa8yRpNgrrvRbJDFo5WKcO/NokGdy7on0sT9HWVZf7T7pR+rv2OwOGDtoxYZO5X/CiiVRTRc7B4=
X-Received: by 2002:a17:907:2cc9:b0:aa5:49a4:9189 with SMTP id
 a640c23a62f3a-aa580f5753emr388982866b.33.1732729550833; Wed, 27 Nov 2024
 09:45:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127165501.160004-1-vschneid@redhat.com>
In-Reply-To: <20241127165501.160004-1-vschneid@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 27 Nov 2024 19:45:13 +0200
Message-ID: <CAHp75Vd2T0-k-RuVK37zmEzWPAnWAhpRN2cBANvg=ENT0_oGFg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Remove CONFIG_CFS_BANDWIDTH=n definition of cfs_bandwidth_used()
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 6:55=E2=80=AFPM Valentin Schneider <vschneid@redhat=
.com> wrote:
>
> Andy reported that clang gets upset with CONFIG_CFS_BANDWIDTH=3Dn:
>
>   kernel/sched/fair.c:6580:20: error: unused function 'cfs_bandwidth_used=
' [-Werror,-Wunused-function]
>    6580 | static inline bool cfs_bandwidth_used(void)
>         |                    ^~~~~~~~~~~~~~~~~~
>
> Indeed, cfs_bandwidth_used() is only used within functions defined under
> CONFIG_CFS_BANDWIDTH=3Dy. Remove its CONFIG_CFS_BANDWIDTH=3Dn declaration=
 &
> definition.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thank you for fixing this issue!

--=20
With Best Regards,
Andy Shevchenko

