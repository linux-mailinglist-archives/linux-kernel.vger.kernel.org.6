Return-Path: <linux-kernel+bounces-380700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B21C19AF4B0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A721C22296
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E8B2178E4;
	Thu, 24 Oct 2024 21:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XUeV0ZSa"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D680216A34
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 21:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729805393; cv=none; b=Edk6bBGE7u5Ie4NNXtyk6j66wnL0TZKuCRUagmBBxj1YcwZOQB054yzKTrhvNotPBO8/meoR/Cn0W8QHybkBbcb501A9lC+GSgBuCGH2phviN4Ye2nlOay+ZCWbl/hQzgT1bCgaSY3z4CiCg023bdBPsT2r7tN+jvWDFwvhDiG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729805393; c=relaxed/simple;
	bh=YA/P/In7rP8GovREPn1yjuxDXKgKVxF1U6E81Df3qWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kquzfs2uuWNmXrPXNAPb+2E+42Soui9WDihK35keGlgpkhKaYGcn07OF5ckqRo9OFbkIqCcSU1qXMCqWDMHU2LccgbL9xd05VmkBYWfZX3fjfhmHikY7Ac3AGQBBYcHdOOS5aZ111c3+cu65d7aylwNpw5xELvS9eYaH6VUb6us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XUeV0ZSa; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a4031f69fso188337266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729805389; x=1730410189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYpolzpXf/XOEV5ZFrEOn4ooeYoU4Vxqbus2f3WNZpE=;
        b=XUeV0ZSa53siUGPH5ILal65X6/iJFYxWFAcaInVKyelNYmxnzG+xsK2HC5MTyka84W
         59ZJhQLu2wMGraQ2vO+J7lJGNfJ3iQ1C5oD0bZEvWDOYx9wvxvL6IJjFZdYNLLOqdfq3
         sge1mENr9cS/Y2TZe20rzeH4bpw0UMk5vD2o+vxjtRMIDqlUN1xoUzMFJKJVwNVCdOdm
         I/AKsnvqrJp5YSA8Hbe24tg+mR2HotIHRxSJDk6OEE8MwMDTjnAzufVBd3lfW2+BjbVJ
         +ow5NMRK8+FNsQb/TTOjsF2NNtdo+Cr+47CkeH+UeCjj7HPS5caXr88GnO60ZdP7AZG3
         0S7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729805389; x=1730410189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYpolzpXf/XOEV5ZFrEOn4ooeYoU4Vxqbus2f3WNZpE=;
        b=Me78xtOwB8+DkXpYf8cBCAn1QiZ3OVwnJAEsSVPBABItCmUxlLTLYFHdmsGYziFkqY
         KwlVeJ26tSSdY8FeIeboz4W4nw5qyl7qoRSN46OxsEuCLFWZoszf518LciWYMyQVdcWy
         TuKlzvgwNuXaJI37c9OhZr9Hf6cOIJvHOsJ66gGPPIBvXYyYEcYI+Z3hvcfiyVEvLgiW
         VezoLykVU52gKlLaH9+Qo0e3B6FH6uHKbnMe2pTPcSo8+xa7hD+F6hc9cJMlbVAiMdi2
         qaW/oK9JIUbNqJZ3GWdx6tviTsRCY9cIEfjU+b9fU+Nrrp4T+NtzCy9bSOxY6w6lMWc5
         1a3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXA5cvuBMvQ9pYWGMJCydwoIS2Q8JoiB6kq/A/2N+/Jo3drjreIlV1Idh7fgALG/Ki3kMLfBGN3dcs4Mz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxzWHJVX/Wo/1kIv9rkxpXN9wsLqUqtOwmGltIAagH9Mlybjjb
	WuwgG771kRReXKs4yDj6l7qjTO+guq6C0bHmtFPTZR1e3dUF8gzXxXJSyRHwvzjp6jxU2q3eWVH
	d7UhgG09x5nPw2cR5n3eC6+wBMs4WNaS1iqI=
X-Google-Smtp-Source: AGHT+IGvJMbSx0Y6aTcJFwXgcAfpZOUq1JQ1REJL46QvwAUrl7/djKOwE0tCuvqyjLSa3I6UjR/UIHmDnVIg/yoJx74=
X-Received: by 2002:a17:907:3e0a:b0:a9a:2523:b4ce with SMTP id
 a640c23a62f3a-a9ad2710931mr287071066b.6.1729805389288; Thu, 24 Oct 2024
 14:29:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-12-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-12-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 14:29:38 -0700
Message-ID: <CANDhNCrShVYQ4OXPVq9MAFGZhGqZ1-yEPpe_aCTpWCBRLE2XTA@mail.gmail.com>
Subject: Re: [PATCH v2 12/25] timekeeping: Add struct tk_data as argument to timekeeping_update()
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 1:29=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Anna-Maria Behnsen <anna-maria@linutronix.de>
>
> Updates of the timekeeper are done in two ways:
>
>  1. Updating timekeeper and afterwards memcpy()'ing the result into
>     shadow_timekeeper using timekeeping_update(). Used everywhere for
>     updates except in timekeeping_advance(); the sequence counter protect=
ed
>     region starts before the first change to the timekeeper is done.
>
>  2. Updating shadow_timekeeper and then memcpy()'ing the result into
>     timekeeper.  Used only by in timekeeping_advance(); The seqence count=
er
>     protected region is only around timekeeping_update() and the memcpy f=
or
>     copy from shadow to timekeeper.
>
> The second option is fast path optimized. The sequence counter protected
> region is as short as possible.
>
> As this behaviour is mainly documented by commit messages, but not in cod=
e,
> it makes the not easy timekeeping code more complicated to read.
>
> There is no reason why updates to the timekeeper can't use the optimized
> version everywhere. With this, the code will be cleaner, as code is reuse=
d
> instead of duplicated.
>
> To be able to access tk_data which contains all required information, add=
 a
> pointer to tk_data as an argument to timekeeping_update(). With that
> convert the comment about holding the lock into a lockdep assert.
>
> No functional change.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

