Return-Path: <linux-kernel+bounces-385843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F4A9B3C7D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142E41F2278E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0561E1327;
	Mon, 28 Oct 2024 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gK8kCnVa"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE211E04AC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 21:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730149809; cv=none; b=fZAbLpPBd9NVito44d617osYAgl4lY5gy/jvcwWzIxyElRF3OtQXIquua08cFFq0+JfsxkTRnxrBrmM7QPOMgBRT+/e6tB/YwNdwUGOwHAKLeMLPjXe5sNDTpFuTq93B5M7PpQuridKIInujVv8hTNYGzi8fsXZhiVLH5dgoaww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730149809; c=relaxed/simple;
	bh=U5fBolRnKer5O7b+t+buSpViHWFwAOhRMo1EaMEr+5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXCKey1GgUfIkpYQFl2i6nilzSNhwcM9kFPjvf9LQR7DyZ+LcDI0V72I38avaFCUDCIYT/lpSg2IxypSbs956vd3eNbbUGYb22QAQv/I9kRJRotllEuW6bUSwU3rE7PztvJ5Kk/+jj8/7hQSXO7gMF+Nc1NLZc9RiWkWepyL5/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gK8kCnVa; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb3ce15172so51273151fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730149802; x=1730754602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fg5LHsnihfFMeaE/D0viDwbqHN3M3/7wht3hCbvfo84=;
        b=gK8kCnVacaOTsybP5EmUXGNp7JNyaEEBp4JKXvuSIkQ2R57IJgvO9TbHvbkmPsdNG5
         EkFuenhR9CYabXcJYzhon7mIw9OtlLfTrBYf44K6r97CvNIlPw+x3JltXgHvGYShgFGe
         SxbYP/M/ogx4VspXgjaVmmr0iuikpUv/C5nrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730149802; x=1730754602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fg5LHsnihfFMeaE/D0viDwbqHN3M3/7wht3hCbvfo84=;
        b=NX3z8OWQuafi0ro6ZzES1fV2eCJa3oMdGaEWsLLzXTFbQXUOlju3WzMlDoEv0r30TW
         DWm8LZLJIOckGJJ1MSXpJX32kf3BJ28spcu//5s9n2NUNRoPzh+RAxk+0h7sHLESh0BA
         rNowiLo4hYzK/o3ThN0Gul3yALB6bDYmN0EP/CA4Ybzx15PFtsrRfN9VbzfzonoUjldb
         NL2WJ5Afc+Z4wtmzNp0+xlXbPk9RSglklxUjAWM7GLlB/M4MRRWLbZ8YOxtDQH+HeNc9
         xc9vZ6vKxIGnloWCTLaxOusM+u+ug8hcLoNWB50T2EzMRaxpR41BwssNzEluuUZYpbv/
         6zHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoIe0a3dShOsRCOUA7dwXNivxOne1Xj9WyFwC6j7iJvyytQy53eNKZNxwl1JCal6y/AmBgzQblDYTFAUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmFwTwb9Z2L6YoaC4BSwlbYJS+Tybc7WaX8nUaIyEkYBf1YKhK
	SaBZNtPPcGctS+UrPRDJcWbKYFWV+/qW2eM1aoFYoqJq1I2eGxUJhG9Ze4tG9oTp1eDE44LInDx
	rzQ==
X-Google-Smtp-Source: AGHT+IHZ8qfLh+lWl/xk53ZZMc5dSbI1Tr+4+cknbGOVQpUSdMJaYTD0iU5UkWl8cyKb0TeqnAuGJQ==
X-Received: by 2002:a05:651c:2119:b0:2fb:46af:2b36 with SMTP id 38308e7fff4ca-2fcda10f310mr2795011fa.14.1730149801875;
        Mon, 28 Oct 2024 14:10:01 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb453e52fsm12233651fa.63.2024.10.28.14.10.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 14:10:01 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb5743074bso39137401fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:10:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXnjkvgOPKAFa+sPATb3L5992wZJCDwQdFokoqwu636t4ZfQO+qfYkQDkmiHksWN/rgE0Ydbb2SFT2j10=@vger.kernel.org
X-Received: by 2002:a2e:be20:0:b0:2fb:50e9:34cc with SMTP id
 38308e7fff4ca-2fcda112689mr2795051fa.17.1730149799851; Mon, 28 Oct 2024
 14:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028191700.GA918263@lichtman.org> <20241028191916.GA918454@lichtman.org>
In-Reply-To: <20241028191916.GA918454@lichtman.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 28 Oct 2024 14:09:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X0TYPpLow=GGAcNGz5_joKG7-d=-DorDcxh9ppgNdQaA@mail.gmail.com>
Message-ID: <CAD=FV=X0TYPpLow=GGAcNGz5_joKG7-d=-DorDcxh9ppgNdQaA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] kdb: Replace the use of simple_strto with safer
 kstrto in kdb_main
To: Nir Lichtman <nir@lichtman.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-trace-kernel@vger.kernel.org, 
	yuran.pereira@hotmail.com, jason.wessel@windriver.com, 
	daniel.thompson@linaro.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 28, 2024 at 12:19=E2=80=AFPM Nir Lichtman <nir@lichtman.org> wr=
ote:
>
> From: Yuran Pereira <yuran.pereira@hotmail.com>
>
> The simple_str* family of functions perform no error checking in
> scenarios where the input value overflows the intended output variable.
> This results in these functions successfully returning even when the
> output does not match the input string.
>
> Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
> simple_strtoul(), and simple_strtoull() functions explicitly ignore
> overflows, which may lead to unexpected results in callers."
> Hence, the use of those functions is discouraged.
>
> This patch replaces all uses of the simple_strto* series of functions
> with their safer kstrto* alternatives.
>
> Side effects of this patch:
> - Every string to long or long long conversion using kstrto* is now
>   checked for failure.
> - kstrto* errors are handled with appropriate `KDB_BADINT` wherever
>   applicable.
> - A good side effect is that we end up saving a few lines of code
>   since unlike in simple_strto* functions, kstrto functions do not
>   need an additional "end pointer" variable, and the return values
>   of the latter can be directly checked in an "if" statement without
>   the need to define additional `ret` or `err` variables.
>   This, of course, results in cleaner, yet still easy to understand
>   code.
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple=
-strtol-simple-strtoll-simple-strtoul-simple-strtoull
>
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> [nir: addressed review comments by fixing styling, invalid conversion and=
 a missing error return]
> Signed-off-by: Nir Lichtman <nir@lichtman.org>
> ---
>  kernel/debug/kdb/kdb_main.c | 69 +++++++++++--------------------------
>  1 file changed, 21 insertions(+), 48 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

