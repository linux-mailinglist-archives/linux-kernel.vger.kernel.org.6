Return-Path: <linux-kernel+bounces-262480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB6C93C78B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 970B4B2259B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C71D19DF7F;
	Thu, 25 Jul 2024 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OxSU15V/"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EE319B3F9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721927522; cv=none; b=V677ccoruCH+YWB6LjXrntCE7A+AtfOjPfAHEsYNZevgk0KxMxjbnRI7DPsJ0WVJLOWTd99MY4SKqKJpj9DcsFkyB17U09+gmWvmeW6IUfhPB5bWaZPEhgSPOMoUX+I/q55Nsf9Or4Wclf/qpx4odi4ELRgT6Eh+WYTYTtSfTpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721927522; c=relaxed/simple;
	bh=RBvveK3q34K8kjZG2JWeztuV3CxvsuNu0VJGLmoCGvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWSuiE3rxBA1/lVYTJSfTWf/MCbQuqKswxTDsN0xlK7yXYm/LLOhDODvj1n+6no/q2acpyoVPDn0EGoVGZ1LPMACOI5rjQdrzAu68qKBJHjs/HBa1rpKTsyXirabWX1bYlRneY6WasQuaUOP4bzEjCA+sgJZ/oJUFY+RF8G5i/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OxSU15V/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so760a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721927519; x=1722532319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h70lOV3n7u1xdXwh+MQKksDG4X07HM3XUttX39/0xs8=;
        b=OxSU15V/YFEbPTKlBuNJsjPIsxNTgwSvsFdVS67sCeLH/c/jQjRCnlUT71s2BUWd3G
         WltRHNdBPDBdgWCCXVfACHV+JSFajrltqMDn3YLZMpN3tIBqW/YGoKe/1l5OP5KRBJZ0
         ki8CXTt+ZVP79w+HAo42wFfoSN0VoOa+zBty4F6dbCte2j9brnWPXmgpy6GLll3u2nl4
         9+zYiHyCPChs1opwr/mWfaLQXbL/TKKNWgnKG6WKm+/k/OCCh7nHpqsMk0vH90Q/ED3j
         ttV2Jrb77rJJI0vQUxdBe3BuwH1XZZRSlLluMdXqbmGXOgs8f0w40cuj+W+N9pcY7pEx
         oi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721927519; x=1722532319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h70lOV3n7u1xdXwh+MQKksDG4X07HM3XUttX39/0xs8=;
        b=XSbDOxpjfcW5x2ClbIqy1Jvq9OSKfpF0CuWvFNSUGciPdewvJqzJyjMl7v9kmfeuW5
         zPGoGIOE5tQ2ellpuBWljTtd4mbwSPMxywewcPNo2VaSAK0UZ4ATcy/SjHC71QGIHEZD
         x4wHajlvvgXt5pcDQS5oY/lVa8pQGs1P2U2Gx22cvr/XTBDRIYPkAw5jZrP89PEvu5xL
         8H72wdq920fam+vssgoKrGtN6ZV8l98NWDFGFthVi8X8Kq+YyqaJUx3JyVD2a6lqmLMI
         HgaePp9BeKXUZiVYwy1+83uzBBria98cIe9e74cnteJk4/aHem3PAb5IXAT+tDzWvs2f
         Li0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwAINK67OPXuxo42tKQUhUceIdUcQD8OQ5ASdERvIe1n07G9V7QklaxBwzAH6eQw5hCcBDcUovehPjYgSqMzAYGrkw7I/VlEtX3X5T
X-Gm-Message-State: AOJu0YzG0EaOn9AOl6AkhJrnyp+FmCr9SwSr0ecYF0jCaYtnf5q0ZV4W
	/lVXLy8LtxAbdYhLAWZH+nVEx9mnGeajba9Nf6tVSSxZSiYjVTj6LOh/H0a7mJwdXFaP5loAXNw
	+PVWQkElYCArib9Sr+SM2hlWpWaC5nFMOBCN4
X-Google-Smtp-Source: AGHT+IGf+6lSI4qFFarQ0+G0tgl4raSviPNkL3zM1ta4TtBqeKQ5E4vnd254pihwECoRP6wIsmWYqjEKHdIGMxFmd64=
X-Received: by 2002:a05:6402:34d5:b0:57d:436b:68d6 with SMTP id
 4fb4d7f45d1cf-5ac2d0513c3mr280213a12.7.1721927518444; Thu, 25 Jul 2024
 10:11:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720043311.git.babu.moger@amd.com> <49aa5321f6e81825a0e9e44cef06c243634e341a.1720043311.git.babu.moger@amd.com>
 <CALPaoCjL92Jwm=Ynt+pEpSt5KLVxnJL8KOKymZ=WP+cUufy_Uw@mail.gmail.com> <54127ad5-8dce-b783-acf2-61bebd0db86d@amd.com>
In-Reply-To: <54127ad5-8dce-b783-acf2-61bebd0db86d@amd.com>
From: Peter Newman <peternewman@google.com>
Date: Thu, 25 Jul 2024 10:11:47 -0700
Message-ID: <CALPaoCiv9pFg2kzG9i-mVy4D4EP600x38F+WSXR2DqoZ9GjecA@mail.gmail.com>
Subject: Re: [PATCH v5 20/20] x86/resctrl: Introduce interface to modify
 assignment states of the groups
To: babu.moger@amd.com
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com, 
	lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com, 
	leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com, 
	kirill.shutemov@linux.intel.com, jithu.joseph@intel.com, kai.huang@intel.com, 
	kan.liang@linux.intel.com, daniel.sneddon@linux.intel.com, 
	pbonzini@redhat.com, sandipan.das@amd.com, ilpo.jarvinen@linux.intel.com, 
	maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Babu,

On Wed, Jul 24, 2024 at 6:23=E2=80=AFPM Moger, Babu <bmoger@amd.com> wrote:
>
> Hi Peter,
>
> On 7/24/2024 7:03 PM, Peter Newman wrote:
> > Hi Babu,
> >
> > On Wed, Jul 3, 2024 at 2:51=E2=80=AFPM Babu Moger <babu.moger@amd.com> =
wrote:
> >>
> >> Introduce the interface to enable events in ABMC mode.
> >>
> >> Events can be enabled or disabled by writing to file
> >> /sys/fs/resctrl/info/L3_MON/mbm_control
> >>
> >> Format is similar to the list format with addition of op-code for the
> >> assignment operation.
> >>   "<CTRL_MON group>/<MON group>/<op-code><flags>"
> >>
> >> Format for specific type of groups:
> >>
> >>   * Default CTRL_MON group:
> >>           "//<domain_id><op-code><flags>"
> >>
> >>   * Non-default CTRL_MON group:
> >>           "<CTRL_MON group>//<domain_id><op-code><flags>"
> >>
> >>   * Child MON group of default CTRL_MON group:
> >>           "/<MON group>/<domain_id><op-code><flags>"
> >>
> >>   * Child MON group of non-default CTRL_MON group:
> >>           "<CTRL_MON group>/<MON group>/<domain_id><op-code><flags>"
> >
> > Just a reminder, Reinette and I had discussed[1] omitting the
> > domain_id for performing the same operation on all domains.
>
> Yes. I remember. Lets refresh our memory.
> >
> > I would really appreciate this, otherwise our most typical operations
> > could be really tedious and needlessly serialized.
>
> >
> > # cat mbm_control
> > //0=3Dtl;1=3Dtl;2=3Dtl;3=3Dtl;4=3Dtl;5=3Dtl;6=3Dtl;7=3Dtl;8=3Dtl;9=3Dtl=
;10=3Dtl;11=3Dtl;12=3Dtl;13=3Dtl;14=3Dtl;15=3Dtl;16=3Dtl;17=3Dtl;18=3Dtl;19=
=3Dtl;20=3Dtl;21=3Dtl;22=3Dtl;23=3Dtl;24=3Dtl;25=3Dtl;26=3Dtl;27=3Dtl;28=3D=
tl;29=3Dtl;30=3Dtl;31=3Dtl;
> > # echo '//-l' > mbm_control
>
> What is the expectation here?
> You want to unassign local event on all the domains?

Correct.

>
> Domain id makes it easy to parse the command. Without that it parsing
> code becomes  messy.
>
> How about something like this? We can use the max domain id to mean all
> the domains. In the above case there are 32 domains(0-31). 32 is total
> number of domains. We can get that details looking through all the
> domains. We can print that detail when we list it.

This sounds like only a minor simplification to the parsing code. It
seems like it would be easy to determine if the final '/' is
immediately followed by an opcode (+-=3D_) rather than a number.

-Peter

