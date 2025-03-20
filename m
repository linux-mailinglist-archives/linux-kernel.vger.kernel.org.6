Return-Path: <linux-kernel+bounces-570175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E9FA6AD20
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 760DD3ABD42
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A85022333A;
	Thu, 20 Mar 2025 18:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="jEvKYDQd"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3127B1C69D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742495465; cv=none; b=jxSrwuDfQOF85kr7LleuRETLrSVb9UR9HNN3w72qlOMuZMtwtb1UYaH/L+3+3wCpSL+j7xdkZO4UZnVAVMi5GPQ+PJqB5uxVNb/QJlhmRGqusFBr1mo2mXYvn0lPrszyoA03IXOFkLd+Nmg/6MHYhlXmGWx+zn9K1yV+vsTgMHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742495465; c=relaxed/simple;
	bh=cV5oj4ZggNIAvzqVAAEfs+LkEsZa276a7RdC8bBZG4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UR9C4C69AbNCNs6iBv9gOvjgMeP5jE4Y5h1LwQ11Yc8lDCo4ECdfpTbhV0RulbKpxEd7Br9wUodlg3ASLs3TZLVAqF2uEMqi54PmXDLF6a4Y64m9665Eca453r8iFeRJ52OpaAtavHI1ORicIzBlq844h1CA+mk8ln09tFcPlew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=jEvKYDQd; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4767e969b94so20780521cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1742495462; x=1743100262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtG9gf5FgKA6eY6YRT9BshPGwRpE+hENpTGe4jADqQw=;
        b=jEvKYDQdR9bnb3FvXo5Ps2OJJN1gnWr8Xh5dRth+0HUfljpWJ1wo6CU5Mvqp0Qjw9/
         pCOEMRcf4jOCnhZi5ec2pPg30VDkSc3Q4Dcjco9r0jGX9/kUBxvqZFb4Lif+cI3/4Aa4
         kxfLKD112Vh/AOTnsP89E+zmDDVvlXvliwWTEWa78f0INQtM6WHVGDBBearFkn44pJWl
         o11/nFbod/pnd3T8IxtK4CVYP7ovpcgyiFb6Q4reb1CN2cyuGYBITVobVqFnR3pkFj31
         RrXVbJem7ltZiJUKLeHxUCsIn7uLzyZYgU5Vwke8gu3bH4PlSV75Ql2+QvLgEh/xUHqX
         WouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742495462; x=1743100262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtG9gf5FgKA6eY6YRT9BshPGwRpE+hENpTGe4jADqQw=;
        b=XLrJwta2uVMJcCtT2EGZ9p94Uprw7EZ0LU/w7Rc3/rVRb1q0oSTDkL6u+6u+CpHUxU
         mhtb108f77UW3FOupAUCUXljkjiDcYnjk+3zOrnM51omHNo0w1xzyRp0YnBmUHCl1fNN
         3PV8QqPD6aPrKTYkAabfJLkxvK2cC5y5HytqBMELg6O6TYA3gp+ZNoxWawbhJueOHX1L
         2gshxp7MXJI2LFhlH0L8my6JEdNvcLA5hp569M/lwqXUOwHEo3tZ6ZX5LvFlNxXZTCii
         NhGaggQhn3+cxD2FPc/+pbGcnOLjQ+eDMBIOglVYjKIDS1v1NkLS+o8XbRejdaCliK6w
         2WgA==
X-Forwarded-Encrypted: i=1; AJvYcCVyjS3vkN8yBkYtcOJgmnqKkG1/QBRmzLidXP/5KXg5h2NL9yWm03nZGlndVrBw9qMknvFNVA8EOy6CVHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvk+3ALJY02WtTQTEUQsGdwJokxpYrqYNLe+dM83tQ29H2q0ff
	+33tZJoOkdSPlEhZjUBUozXJPJsH7JMRokmeAD7j21SKtPxJUxxMVTYpIIJOGEMVn52RpirHgmw
	YcsoDyL+/TwOgJBvKtW0lKyX+CIvNSngUTJV9cg==
X-Gm-Gg: ASbGncuVMhiu+emgL5pkQ3Sa5wb0aJ0GnrfDuvJJCI3krs17FI3md5r7OvNuHxBlQbv
	rl9HAJ0gMmJ7XO3K8jomNcDNTBo78Jz2MOOUPtoFhm7/0MayyUMAtGdmVJ5JvpEMKTJu2o6uq+A
	EthYw0l6tFGnO7h/tfPv3cFJYD6Hu3ozDuMA==
X-Google-Smtp-Source: AGHT+IFqX17oEVPuZbqf446QYtb2Di310WRkl/Dqk2wt6mMBXiCz6I8wulhvvrs+M761WPPyHRhMSYzgn47pKR6cr6k=
X-Received: by 2002:a05:622a:418b:b0:476:add4:d2c0 with SMTP id
 d75a77b69052e-4771de4792dmr4861841cf.35.1742495461873; Thu, 20 Mar 2025
 11:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320024011.2995837-1-pasha.tatashin@soleen.com>
 <20250320024011.2995837-2-pasha.tatashin@soleen.com> <Z9wan08CpbvddHhc@smile.fi.intel.com>
 <CA+CK2bDWJcrWpkk0asKUb46GYT-r9JdBMU-OUx3E4qjr6rVpGA@mail.gmail.com> <Z9xVbqyomZunipQL@smile.fi.intel.com>
In-Reply-To: <Z9xVbqyomZunipQL@smile.fi.intel.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 20 Mar 2025 14:30:25 -0400
X-Gm-Features: AQ5f1JpHpjz1VH8ikB3opDcdZI4T-5QV1E_LN4WKtkhP3V0qop2kKh_p816Drds
Message-ID: <CA+CK2bBQwC16W2Qmw5vXdMi7EaadAGXfUs6ym1P1UZ90PzbZvQ@mail.gmail.com>
Subject: Re: [RFC v1 1/3] luo: Live Update Orchestrator
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: changyuanl@google.com, graf@amazon.com, rppt@kernel.org, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, leon@kernel.org, 
	lukas@wunner.de, bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, jgowans@amazon.com, jgg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 1:50=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Mar 20, 2025 at 12:35:20PM -0400, Pasha Tatashin wrote:
> > On Thu, Mar 20, 2025 at 9:40=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Mar 20, 2025 at 02:40:09AM +0000, Pasha Tatashin wrote:
>
> ...
>
> > > > +#ifndef _LINUX_LIVEUPDATE_H
> > > > +#define _LINUX_LIVEUPDATE_H
> > >
> > > > +#include <linux/compiler.h>
> > > > +#include <linux/notifier.h>
> > >
> > > This is semi-random list of inclusions. Try to follow IWYU principle.
> > > See below.
> >
> > I will remove <linux/compiler.h>
>
> But you need to add something more...

...

>
> ...
>
> > > > +bool liveupdate_state_updated(void);
> > >
> > > Where bool is defined?
> >
> > in kernel/liveupdate.c
>
> Nope, I meant where the type is defined. It is IIRC in types.h which need=
s to
> be included.

Ah, I see what you mean, sure I will include types.h.

>
> ...
>
> > > > +     if (kstrtol(buf, 0, &val) < 0)
> > > > +             return -EINVAL;
> > >
> > > Shadower error code.
> >
> > In this case it is appropriate, we do not case why kstrtol() could not
> > be converted into an appropriate integer, all we care is that the
> > input was invalid, and that what we return back to user.
>
> The kstrtox() may give different error codes. User may want to know more =
about
> what's wrong with the input. Shadowed error codes are discouraged and sho=
uld be
> explained.
>

...

> > > > +     if (val !=3D 1 && val !=3D 0)
> > > > +             return -EINVAL;
> > >
> > > What's wrong with using kstrtobool() from the beginning?
> >
> > It makes the input less defined, here we only allow '1' or '0',
> > kstrtobool() allows almost anything.
>
> But kstrtobool() is the interface for boolean input. You may document onl=
y
> 0 and 1 and don't tell people to use anything else. ABI documentation sho=
uld
> be clear, that's it.

Sure, I will use kstrtobool().

>
> ...
>
> > > > +EXPORT_SYMBOL_GPL(liveupdate_state_normal);
> > >
> > > No namespace?
> >
> > Namespace is 'liveupdate_', all public interfaces have this prefix,
> > private functions are prefixed with luo_ where it makes sense.
>
> No, I'm talking about export namespace. Why does the entire kernel need t=
hese APIs?

These functions are intended for use by drivers and other subsystems
participating in the live update. They allow these components to
determine, during boot, whether to restore their state from the
serialized state, or, during runtime, whether a live update is in the
prepared state, causing different behavior compared to normal mode
(e.g., prohibiting DMA mappings modifications, binding/unbinding,
etc.).

Pasha

> --
> With Best Regards,
> Andy Shevchenko

