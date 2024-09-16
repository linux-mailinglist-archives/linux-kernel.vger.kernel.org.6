Return-Path: <linux-kernel+bounces-330296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF92979C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ACDC281318
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BDD13AA38;
	Mon, 16 Sep 2024 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U8N5fwwj"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD6D13665A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726472968; cv=none; b=DFt1BIVugFNJLn6dfIFs8MijWMdmqdWMVkeVtaspLO2o33yNYnxfeFBf4e9WfRyzFHwXBQD9KQXkL2JnEaFwHKGm7GSAUhb63FsIEwasW1JONZJ4k7GA+zThOUt0Hp4Kj7useO8+Q7vOrFjiTuDm8RIbLOUMkPPjfD33LjIu1CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726472968; c=relaxed/simple;
	bh=1MHpCDQVQqqgzqIbyzMgzsTbZZWoH6F3IUKjcpevkQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YdKt1VrNW/oTh9AxxsEwAbBcCsjCdrQcAZqkzVJsATowaVi6Dt/eCWuMQFKLIu9RSZ3KopjSD0nj59fORsatGr2A08B7rW2G5lB167pSCEljSVuR88W6fw0Ydo4fEphDfjYIJvXFbJxJMrmbxMo5VOsNEpbEsWqnAWcKLe57+Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U8N5fwwj; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a99de9beb2so240247685a.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 00:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726472964; x=1727077764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRuvIqIMwhOwH+lOG9lXtXVM6bFb+PSyQglSW2kHCV4=;
        b=U8N5fwwjkgsWN/5xmr/y8j9N9mqlKBk1NMxYobeeGnHginG0pXS3a0jbphGND2llGQ
         Tf0+oSWi7s14UyHt+P1JwWZBEc2MiMXPq8MB6B7gyB/A4Xr9KnW1jsw3aSFcvr7v9hez
         60ESxX++oVlGK0+kvCJooIIBDp8wpiw7dXYII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726472964; x=1727077764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRuvIqIMwhOwH+lOG9lXtXVM6bFb+PSyQglSW2kHCV4=;
        b=Xn2vsrrxSMY7cR/FNk9gFPC8OqYBlCsXuwgnuKdPDtACGMtU8Q0hXzc0q6WoW7Uzue
         kY9qBGGsHiSCWvNTgtfArzNAe09DMCO86901DB0NCfWzKdt+Um+khikNwvDs6SlbbPfy
         Tvwtoho56ghiy2TWiktSiF+y6NQP9aGnM7l/yrS5q94WmdyclY4X4kbwRyE9/mVI+XjL
         qA2pwLq5MUzCiESqrUB6FUoUJ2wWq0EGgGHNNOKFqymq6gWlbR1igfEMwzyduTgSWz/F
         nRgJKyKWk9KLUFQGRUaERRiIL2+i55MWqCLH40RZ3Md0r3Khatnb5+tCWig/FezxAYsA
         5zBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU11d1aa3MrUIluvZ67NJSii94hJ/um9axKcFe9DYnQ/IDfBqfP4o4FK5Ft1kmNSjTmxVJ33be/jfTYhgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBJvjVR4za6lIPhm/6H1Re5dbTJv8aVKnHdktYzwCHuqm36R4w
	6aFPiRG7OGYqBBrTwX4shGKb6Q8UTvmTexFoPs98A1+/rd1IS582Nvln4awf2xifdOSy1rVKCDH
	OJQ==
X-Google-Smtp-Source: AGHT+IF0BKng10opq7shziMND9IXJXJ+jABfLYcWz+60m4uEhL0uCT4sGEBa0qg3f/W7ZNnxPBSVCw==
X-Received: by 2002:a05:620a:3725:b0:7a9:d0d2:a5fd with SMTP id af79cd13be357-7a9e5f7a7a1mr2050477385a.49.1726472963721;
        Mon, 16 Sep 2024 00:49:23 -0700 (PDT)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com. [209.85.219.45])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ab3eb64ab3sm225782385a.108.2024.09.16.00.49.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 00:49:22 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6c548eb3380so19155216d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 00:49:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVuuth+qyoS3YkggKIygVC/pX6fJnMeBsiw4Zx0nhB9BNqUz/rN9vuY3b3lWDtQp7+NxY9guObTyPQWmpM=@vger.kernel.org
X-Received: by 2002:a05:6214:3b84:b0:6c5:17cf:d9fc with SMTP id
 6a1803df08f44-6c5736ecb6dmr232219486d6.46.1726472962244; Mon, 16 Sep 2024
 00:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240914070300.42936-1-changhuang.liang@starfivetech.com>
In-Reply-To: <20240914070300.42936-1-changhuang.liang@starfivetech.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 16 Sep 2024 00:49:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XBsBMogRYF3NH7qtZ0rDq+7wie8n_Dmyf6X_TfNJbcVw@mail.gmail.com>
Message-ID: <CAD=FV=XBsBMogRYF3NH7qtZ0rDq+7wie8n_Dmyf6X_TfNJbcVw@mail.gmail.com>
Subject: Re: [v1] Documentation: kgdb: Correct parameter error
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Jason Wessel <jason.wessel@windriver.com>, 
	Daniel Thompson <daniel.thompson@linaro.org>, Jonathan Corbet <corbet@lwn.net>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, kgdb-bugreport@lists.sourceforge.net, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Sep 14, 2024 at 12:03=E2=80=AFAM Changhuang Liang
<changhuang.liang@starfivetech.com> wrote:
>
> Module kgdb had been converted to debug_core since commit c433820971ff
> ("Move kernel/kgdb.c to kernel/debug/debug_core.c") be added, so let's
> correct the module parameter path.
>
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  Documentation/dev-tools/kgdb.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I guess this could have a "Fixes" based on the commit mentioned in the
commit message. Patch looks right to me:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

