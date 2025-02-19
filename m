Return-Path: <linux-kernel+bounces-521747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91635A3C1D6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D74170CC0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7F91FCD13;
	Wed, 19 Feb 2025 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bfWKhPSD"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904621FCFD3
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739974189; cv=none; b=LS61mgmK6ATyAKKCbs8tT2/61NV1SSqzyQe5nNnFsLVHICs+9iRl2yi8ad8Glu1f5rRgV7fmTlLKIJ2fuwVj7SnTGR8ocLWBNTHdZ5vGowUr40olrHtE3KNsDsoJWwycbzOYot602b0rH1Z74tTnBvI8w/nWuc+bJhsRYYkNNhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739974189; c=relaxed/simple;
	bh=10jMimjxuVlCFGM2ZCcbo0fe9PRhXfBjVBsvwxGav90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtCIzZtR5vcD7Ry4+iLaJ+p7XN+Dj4I3TN6xObtkmYtNWoNpLf5X0k3DyGbl16PPbYRSw38RhqcHMr8AO1qouhZr5uTCe5o9E9dSgdAyCOHZE1q/QU9ncx3NkMEUolzWN6Cgfaxo9c2lhtyEsicInoUW5fdiVaviN/d5q73GlWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bfWKhPSD; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso1136822966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 06:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739974186; x=1740578986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10jMimjxuVlCFGM2ZCcbo0fe9PRhXfBjVBsvwxGav90=;
        b=bfWKhPSDk8e/Tj1SrdFTLWWe5QpJEeMVISVVjF1+oCcweeLf6nd9X/Kxo2dRMFjnNf
         UpW1eAx4cb/tcvKIIhb3ua+uKsdd+p8Qmvy+IOzEZKj7/h+/iGPiAgicXMu2IRA7dSDa
         rcNPgKidKV7vXL07YfBbQJ1O8OBlTLRMWL4wg8+FJzfcaPmyRzoNifjvMd5fHQ/imNxn
         OYKsnbcNP32F3CBvcIXmXR4IIyOAGC0HsguB8nWVo5XXifOQGCw8j77+N1YBgfT02fDF
         nG9MdtXG3gZSyXDgis9AWWqE1MvKAGZ5JsUFtJ9ZJ17R11WwRr8/uF/jNGsB7lOO4O4m
         EByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739974186; x=1740578986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10jMimjxuVlCFGM2ZCcbo0fe9PRhXfBjVBsvwxGav90=;
        b=dSIxGBlkmnOgUXnYP0hN8mkVhk8wgTm8X6gtxx9I1+HsmEqqTEYHhUsZJ3Z/fBfxlA
         Yieg7Ae5y7+s6CFoeaIaTmH49cWNGZEuCqRBZPBxRUfyvFrev5BGbWUNK/12MKhyWFb7
         9/vkaCATVpgiAnknA9xpvojwqyymOSzFqR1+kZ9gF8Ur7BxvnFFsVTpeD3tJyVSZqWli
         umrJxNVtx3HP8mu4lypFEBpWLarT8BwQiiXxXP3OC/vf86gJYIodx1VXrQuU8U/eksW5
         J9IZq94t+QPDD7i2QsZCxbnasBM2KfxwkK+ky1IuJZriacD2kFKZUIUGPHbKkhfJmj1d
         wWoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI7fmeS98izW0pb1JJcQDO6agfsFdcnxOlHhGpvJAbMQweUFVewtgtzoLHrM27tr9/K0ly/qNW2Wevk58=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHJ/4shadRuasep5nWm+soaNpDBkKksvdKCJ/ezAzH6IjdTc9E
	bEeA9z0Fc+j5j8kElvRSSUufu0V4m0h+xgxsO3jvbVTBUfHhIIJqrSOaMf7yqVz1QpHXOyL0JQ7
	tSFGDn+dJqrsCm+iZkRLDQgJcQ1WPJJcuwtsnuTJ8Cn/OgeCd0lnjJ9o=
X-Gm-Gg: ASbGncuv2330E/FO8pMcajAE+/B3TA/WA40ol0gez5e9n7fbmw6BjM7KmRxDdFNmUHR
	gyjcJhzqi2nJrUQZpLISRzRriSbeZ3NKkx8G2EpSg34s7qK3wNRCO1efQ69zQLVQ8YXsiRjKnB7
	xZ3KXsj4SiJCrCHPMg8KcJ0sIRzQ==
X-Google-Smtp-Source: AGHT+IH8Kk8ypOlI+q0204bWOg0K+kei1efTO1AVFOuvMiUq/prv2i2qE+mN7M/RL4ubsnylAhdc2zfoJmjYvSACjtk=
X-Received: by 2002:a17:906:18b2:b0:ab7:d10b:e200 with SMTP id
 a640c23a62f3a-abb70aa66dfmr1211679466b.22.1739974166997; Wed, 19 Feb 2025
 06:09:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737577229.git.babu.moger@amd.com> <2119b76ef8be21b1d8b2deedfab23e8e33ba724c.1737577229.git.babu.moger@amd.com>
 <Z7XfcV05ZZkHm6bc@e133380.arm.com>
In-Reply-To: <Z7XfcV05ZZkHm6bc@e133380.arm.com>
From: Peter Newman <peternewman@google.com>
Date: Wed, 19 Feb 2025 15:09:16 +0100
X-Gm-Features: AWEUYZmLnt6t_Sm9Rq-kqfE53HCQG6LWj-INsRp5bS0oFoaS6xQL7aEZNuvjSPk
Message-ID: <CALPaoCiPkjbTf2He2tXsguxHDtGF+YfVUZScL8dseVc6rvAfvA@mail.gmail.com>
Subject: Re: [PATCH v11 17/23] x86/resctrl: Auto assign/unassign counters when
 mbm_cntr_assign is enabled
To: Dave Martin <Dave.Martin@arm.com>
Cc: Babu Moger <babu.moger@amd.com>, corbet@lwn.net, reinette.chatre@intel.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, tony.luck@intel.com, fenghua.yu@intel.com, 
	x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org, 
	thuth@redhat.com, rostedt@goodmis.org, xiongwei.song@windriver.com, 
	pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com, 
	jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com, 
	kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com, 
	xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com, 
	mario.limonciello@amd.com, james.morse@arm.com, tan.shaopeng@fujitsu.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	maciej.wieczor-retman@intel.com, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Wed, Feb 19, 2025 at 2:41=E2=80=AFPM Dave Martin <Dave.Martin@arm.com> w=
rote:
>
> Hi,
>
> On Wed, Jan 22, 2025 at 02:20:25PM -0600, Babu Moger wrote:
> > Assign/unassign counters on resctrl group creation/deletion. Two counte=
rs
> > are required per group, one for MBM total event and one for MBM local
> > event.
> >
> > There are a limited number of counters available for assignment. If the=
se
> > counters are exhausted, the kernel will display the error message: "Out=
 of
> > MBM assignable counters". However, it is not necessary to fail the
> > creation of a group due to assignment failures. Users have the flexibil=
ity
> > to modify the assignments at a later time.
>
> If we are doing this, should turning mbm_cntr_assign mode on also
> trigger auto-assingment for all extant monitoring groups?
>
> Either way though, this auto-assignment feels like a potential nuisance
> for userspace.
>
> If the userspace use-case requires too many monitoring groups for the
> available counters, then the kernel will auto-assign counters to a
> random subset of groups which may or may not be the ones that userspace
> wanted to monitor; then userspace must manually look for the assigned
> counters and unassign some of them before they can be assigned where
> userspace actually wanted them.
>
> This is not impossible for userspace to cope with, but it feels
> awkward.
>
> Is there a way to inhibit auto-assignment?
>
> Or could automatic assignments be considered somehow "weak", so that
> new explicit assignments can steal automatically assigned counters
> without the need to unassign them explicitly?

We had an incomplete discussion about this early on[1]. I guess I
didn't revisit it because I found it was trivial to add a flag that
inhibits the assignment behavior during mkdir and had moved on to
bigger issues.

If an agent creating directories isn't coordinated with the agent
managing counters, a series of creating and destroying a group could
prevent a monitor assignment from ever succeeding because it's not
possible to atomically discover the name of the new directory that
stole the previously-available counter and reassign it.

However, if the counter-manager can get all the counters assigned once
and only move them with atomic reassignments, it will become
impossible to snatch them with a mkdir.

-Peter

[1] https://lore.kernel.org/lkml/CALPaoCihfQ9VtLYzyHB9-PsQzXLc06BW8bzhBXwj9=
-i+Q8RVFQ@mail.gmail.com/

