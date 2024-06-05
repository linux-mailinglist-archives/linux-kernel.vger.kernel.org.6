Return-Path: <linux-kernel+bounces-202957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2441D8FD390
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B573E1F266E4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D92D191471;
	Wed,  5 Jun 2024 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgEXsunN"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0122837A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717607159; cv=none; b=QR7RjloJ+KEGsg07xB8T2/6x7gjqUtD7PUnwb6B1SOI66OXgFVFm1ocf3YMgGhtHOQHRcBW1MNiOqPGs9LbvCPDhbGZZdNUWljgzW99SlOaQGSFO8TrA8WHIQOAsaeNtr8JbNU3fgs+rsGJctr7ya7uYd/bhAy4hjVJ5BNWnks8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717607159; c=relaxed/simple;
	bh=Zuf8btuKWalmhChHnYF6Zs4RJxXpua8dNN2r4Rf6cWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OcrAKDJScIfrCd9i+ysIkGTbMUzToIWOx3CQAntchxmPuUY+vus2l8bRpQUSipb2oLJ12PScZXQq+441Q5+fQfpAYunHpC9iKdHBU2NAlD8wikVl7uepNsXgLJtECdiLj5KGj/DisLCQTkzsa3yrkSMjTj0RTF+JS7jQYdZNdqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgEXsunN; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2512a0b6916so9085fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 10:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717607157; x=1718211957; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H3zTo46io+/7RGOWkcXF2UOVMch9m0QPNz90dItucSw=;
        b=kgEXsunN1vUocqgan4PIZpUqm6JirA3S1FuarNwlYkvVH+PfuCMR1UroU06mJkvA4V
         kiq4Le8x9vxYBYm3MPm5md9Lpe+tOZQn0Q3djQQ5wYyjQ+rzWT50f65Is7Tyh5DNkgZy
         FZUj0e9vy9PamFPnozeFkMeTx36BXt0dAPKEBmLQBulgRLGtmplaY0PHO2gcQfyQTU34
         NgQvcGx91RThT/s0PkrZjVn2iDJ0V1MAdwnBQCafU8uUyCIJ1j3PqWEN9NqBt2V+rLUe
         BvXhxVnqZTAckjbuDXow8BTc3bh085zfipLi/1vRhk5RJqiGWs4rNgZsUB60Kzk04kGF
         uxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717607157; x=1718211957;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3zTo46io+/7RGOWkcXF2UOVMch9m0QPNz90dItucSw=;
        b=aVza+L7StZHg2kLFZI3tl5TJUT3esp/Ce4kEz1AfecJktGC1UlrLymzduCdzZ3/9X/
         VcD3qt664HxOLOIj+W0MPTY0HiI1wGdXzwxEBfZPo5mZxRIinYEt/kRfIwYkyM2euQsf
         /GzSEEH8uCJcuRswcdTeibmoYwdiJQBISgh3qOfiwmhcZFjoaikUwTTXZiwgzhDLDYbs
         XQCXhdzu29woAR8mt74ZGGyoXF+DPV2XHqKmGClxkSzdyV2dkLqcGKPz6nViemG07thS
         6wDLSol9Vyr6I+e6sjhnKAttfHahwf1B1N/Fz/LGzoufxJRDLtmSrfltvdJAAGGI3wUd
         E4eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnOZQfOPcUom1UBhXFmhL8PZsOiIWe5SVBw6AD3huUEFeRPDDQWvfsDeM967ELQ2ibiYkdERUXfVjkKCrCVIkmN5Ad+e+2t3hxPN+/
X-Gm-Message-State: AOJu0Yx1JHOsZs/iwVLQYJau1Ns1gfV9jVhVZZ2gWmXZt8xjVw1i2dBw
	ZfLakgDZKaud/RUxIKO/fZS480LiFMLwmgEqWrTzkKStWuH3A86caaR/OPm+Kccf29Sbblwwjcj
	W5LJpnf+nbSCLIIAv19Q1bcuFGbc=
X-Google-Smtp-Source: AGHT+IHQEBrPAkxWoHscGpgooWUNneyz6aeprNkAeu/ei7oNi2n2hk4dWtQTqRF3n/MXaPWjI95ER+FlvBrfo8rWSw8=
X-Received: by 2002:a05:6870:9a23:b0:250:6aa0:7c8e with SMTP id
 586e51a60fabf-25122b08365mr2624950fac.53.1717607157045; Wed, 05 Jun 2024
 10:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516174357.26755-1-jim.cromie@gmail.com> <CALwA+NZ7Cdd9M2Cus+Lv3yoc+eWNdUjCmECGJbfoin3ikHLbxQ@mail.gmail.com>
 <CAJfuBxxus5_0=ydNWwQhDNhe1++oh8nBe-+3Egt6mKk_W=0w3w@mail.gmail.com> <CALwA+NbtX4pkFm35L7bjL0D-c=RMOu7vVC0=cUg4Q6n7uD=u-A@mail.gmail.com>
In-Reply-To: <CALwA+NbtX4pkFm35L7bjL0D-c=RMOu7vVC0=cUg4Q6n7uD=u-A@mail.gmail.com>
From: jim.cromie@gmail.com
Date: Wed, 5 Jun 2024 11:05:30 -0600
Message-ID: <CAJfuBxwSXVLnis6T=ybbyxQRdSV6mHMBbDJ_CwUr93f=adSHDQ@mail.gmail.com>
Subject: Re: [PATCH v8-RESEND 00/33] Fix CONFIG_DRM_USE_DYNAMIC_DEBUG=y regression
To: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Cc: jbaron@akamai.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, joe@perches.com, 
	mcgrof@kernel.org, daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, 
	jani.nikula@intel.com, ville.syrjala@linux.intel.com, seanpaul@chromium.org, 
	robdclark@gmail.com, groeck@google.com, yanivt@google.com, bleung@google.com, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

>
>
> > Im thinking that a combo of 1, 2 would suffice.
> > And we could probably drop the config constraints,
> > especially if the test avoids failing on configs where a failure is expected.
> > IOW - if no test-modules/builtins, run only 1st 3 tests, ending with PERCENT
> >
> > That said, I wonder if the exit 127 should be success instead ?
> >
>
> I don't follow you here. Could you please elaborate why exit 127
> should be a success ?
>

well, exit 127 is sort-of a monkey-patch.
(this) monkey, sees it used by git-bisect to not be a normal fail,
but a special signal that bisection itself failed. (maybe..)

I have no good reason to think its useful for selftests.  RFC.

WRT success,  if /proc/dynamic_debug/control doesnt exist,
thats probably intended, and we shouldnt complain.

>
> > thanks Lukas,
> > ~jimc
> >
> > > Thanks,
> > > Lukasz

