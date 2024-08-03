Return-Path: <linux-kernel+bounces-273487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7139469DA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 15:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F5A1F217AF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 13:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC20614D28E;
	Sat,  3 Aug 2024 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPGyMIEm"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2CC6A357
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722691268; cv=none; b=Dn/Y8tUh4wS7LiL+lbotsGITmyM0s/iMVa/cSzoYcqQ0hVlEgzPfqKeY/fK6+L2mKMh4FQ9dRVSREu9Fr6KBPri2EXArnzQEKoh+A+iHdVoSaHLrjo52Tf3BQFdTzv8JtueXKa76pGUifJApnj0jwYmr7pGY5O9pmlT2Vap4iEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722691268; c=relaxed/simple;
	bh=f6R35pGQnEE+OUaUdiSnnzokVlXIPFeyl5dRZpjvRWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWcNOVbo8gzzrUDVoYRY3IrjKyiUI2yUeZhHX0YDWpp0FfFEkuLzgioLxc332US4xu+WGXjuwmlFC7aY75xEQi8zNLlgH7i63jLztb+OJ8CQW++YXo2/FfDCTGL8+wkbuPhSf3gKfvA08L/Ic6Nk/jGugThGqxlHtIG396rIk/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPGyMIEm; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7104f939aaaso3255052b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 06:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722691266; x=1723296066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rSxbAxWiCYHnoojmJCKUKHvb2mNiQ81YKSAEmx498m4=;
        b=dPGyMIEmIbwldKyb7kuKZnahThSkbyiVP9mYW3hBjUKe1lB5rdLsrM5IJxzJlTh6L9
         N3aR9GsfGSZ+tR6G+QGJQRF3B0ypcuR9f/qKrR99+g0EwurItto6iiw2IRBp4zxR5zkP
         ULbqDBk//JKFh7Cq1qV//iISxfKnsF0AaxpsGHj3HXjg47gUzXvl+tOolwTvDepIhbAA
         p0ARdoLz00N2sT2cVNR6/c9t98tEqUyhrBpRVB0DDdIgI7O7bZKs1Gs2MTiFnLesYWcl
         nthHXbmvMyge9VR4XmjfQi+aNWFgA18zu0ZyftXdemuzJIPb3fnbcpzzrMNi+mq0a7cK
         NSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722691266; x=1723296066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSxbAxWiCYHnoojmJCKUKHvb2mNiQ81YKSAEmx498m4=;
        b=rjTkf2DZwo8p1R5IB/3W9vP5fmAXJCMKES8F3ZsD4aeDhnw/B3373qBm9wuxcbwtUt
         2ykHfkck5VZHlROJ9kQYexBwbRIoUGduSvAJEMkuYt4ZdopqdjiVnqJqGDDFRP7xNMUC
         BL6VL+39Czz7rS2QWeTVmUEzr646oReNRkaRif4Cvi7L5pn8OE1M1iJEepW5ZBujnNIo
         FwGAbMMowbnbssqY0qMxc6g79SqPPY9tAEEYIFKnVs9XB5Qws6BXsT9tB8BDHkgPL0Sg
         cLV5CMU9NzvnLXHDFLr6p0rYrifVe0+/gn77pXhIOgPmsCtzDbH4M4CkM1/q5YiwqxP1
         5JaA==
X-Gm-Message-State: AOJu0Yzt8H8FaKsyQ4NJ3c5Kl1BH0+JMsZdiYAyLRVKYB1M7Sd55pMfW
	ypDTENEvGeoBW36gmSG6b77Jyqi6CBIp5kVt6whbpuUo3poQ3EEdS6YXoDJV
X-Google-Smtp-Source: AGHT+IHCwgmBveAW2qJ+PiL/7zd0ZtGuSdGk5zkbP7ueLupnEbZEFoDjfebhz0nHcq1iusormWcvrg==
X-Received: by 2002:a05:6a20:d80c:b0:1c4:bb9f:c574 with SMTP id adf61e73a8af0-1c6996279b8mr7374455637.43.1722691265989;
        Sat, 03 Aug 2024 06:21:05 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592976b3sm34608455ad.252.2024.08.03.06.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 06:21:05 -0700 (PDT)
Date: Sat, 3 Aug 2024 06:21:02 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>, llvm@lists.linux.dev,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 3/4] cpumask: Switch from inline to __always_inline
Message-ID: <Zq4uvqU3yg7bJ1Lk@yury-ThinkPad>
References: <20240719005127.2449328-1-briannorris@chromium.org>
 <20240719005127.2449328-3-briannorris@chromium.org>
 <Zq1NdFXhN3IoYm3M@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zq1NdFXhN3IoYm3M@google.com>

On Fri, Aug 02, 2024 at 02:19:48PM -0700, Brian Norris wrote:
> On Thu, Jul 18, 2024 at 05:50:39PM -0700, Brian Norris wrote:
> > On recent (v6.6+) builds with Clang (based on Clang 18.0.0) and certain
> > configurations [0], I'm finding that (lack of) inlining decisions may
> > lead to section mismatch warnings like the following:
> > 
> >   WARNING: modpost: vmlinux.o: section mismatch in reference:
> >   cpumask_andnot (section: .text) ->
> >   cpuhp_bringup_cpus_parallel.tmp_mask (section: .init.data) ERROR:
> >   modpost: Section mismatches detected.
> ...
> 
> Hi Yury,
> 
> I'm wondering if you've had a chance to look at this latest series. I
> believe I refactored it the way you recommended.

Yes, you did. Applied in bitmap-for-next for testing.

Thanks,
Yury

