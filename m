Return-Path: <linux-kernel+bounces-396275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA2F9BCA97
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930A51C21820
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3501D2B26;
	Tue,  5 Nov 2024 10:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2E9iggUA"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC9F1D14EC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 10:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730802960; cv=none; b=tWy1tjabJIr9gYn0qOOZG31kR1RZlOcRTNnzcpV3UiK1BEGbpkI0TdmJDYHe9SkhXTwGALdryF0QwLwq8UAHcDSEZJ3PqV32uOvq9IUskCYdKgIg16gfZtKxwkOxHD2ZBOavoOkc4yX+P0Y3fl8MZS9sfOAryQYkntbxfcaJjug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730802960; c=relaxed/simple;
	bh=6HhMrwij3Sm4Ez5HTdLMk1GmRfoKOqzP5Je5fYiFaKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OENSoaQAf8wZFh4EymzV+9A7MCLCNJPoRBeCfR60YACWonwjJ/KKi4xBl2r24CUL/Usrk61Fo/oUD4KRrFFLVFGIwjqDFmw5rDrTTl9/xJ/qN0pFf9zMnOjCrrV7w65WsngrilBkcz5yTbRO5dzEUMLKomUvBNKsKUbKgpQ56ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2E9iggUA; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1e63so6330050a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 02:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730802957; x=1731407757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDJ/Kctg4e0f30HvMWXY+UgoVtT+n9MKZZPRr6MzBqE=;
        b=2E9iggUAKqBSR1LN03HPKhPVOvgh2KKD9pzQ1sUyfa2Rmy33jiwJYmQBibQxNMljfx
         PJgAagA+3V4tVMaZmCtIhO9lJ0I5sSOqXUsVmxRx0vNzVRrd7Q875EwFCYaVvoRj7aVs
         itvpI7inseyDsLACySXkl5tF6tTFTPvFAG0VQYFoZz1s9Dh+b6wx8/RIStIZ/AxTg8U0
         LOP3sO8dnVNCWtPZ8bsJxWl0JM0vAKvKkp+bcs04MeYPRz2lWY+7VfSqAWwPVUH5iV44
         U4FkC+Qvm7WkVQDV4Ov2bADRCOHjQPrqRKLk4piQgt4d/j3IZIxEaAZuk2M/ZKCukxm8
         y5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730802957; x=1731407757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDJ/Kctg4e0f30HvMWXY+UgoVtT+n9MKZZPRr6MzBqE=;
        b=c3pw9A+vloBcbPRVgDuBSj2LL+Qk6oxW/qRpNR7GMlmGN3I1DdF1a8xDnetnl8ba2k
         MsVDeAzxcWIuJP9mjDfzhiTu2m3Wh7Hgy28ykIIg5ne3vnJqQPCs2Jwb8xdd+F5MW4RO
         IFUmJfQgJrWSDPvAJFmdwKQN+k3YeR4devvjl5Icxv/AVLg2kwfGxcbqhQZL3BfRoqEX
         qSFXPnAu5o4oHNdlwAEXotfsPNIxaYZtrW2VxWpQ+5sa7eAky7dwuUV3tXEgNRRmA8X3
         y2XoGMtKad4y4vvO/2gZSfYzRUpqoMExugjC9dgC5yMlwN0i4ZGjfUyEh2OMfVjJaU/1
         2slQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjqo4hCTzBZZRQPVqfhp+M6sdxZg1zFtt1M46gc3GEi4lsMwtu1W7HfRp7Npl6IrJw2qrBZ4WDqIdcsUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRNDuaXjLh/61mxM3Lvw/jhFBPtektqfa7opDFrcPdBOhYJKuG
	1d0DjNnomwGNPxSy9dRnsNxjSFxpjXj3WDYksLStJqFVSC7/GfoHfqC+XkXdwGy3vhsSvPKydEc
	2kips5C7AEL8HsAt5+sMdhN1qxG80peQQj5Kk
X-Google-Smtp-Source: AGHT+IG8aPze0kJVzo0IME8bHugDyPyiohoFX5zaBuXzmMbChOtscLPmMnEKHt24u7PgbFxdiPbd9OFtGrxcTJYEPSw=
X-Received: by 2002:a17:907:7e84:b0:a9a:123d:3f1a with SMTP id
 a640c23a62f3a-a9e508d4af3mr1757814966b.17.1730802956929; Tue, 05 Nov 2024
 02:35:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730244116.git.babu.moger@amd.com> <d27c3a15ccb11c6ba76794eba6cf7c013b0bb074.1730244116.git.babu.moger@amd.com>
 <CALPaoCh1BWdWww8Kztd13GBaY9mMeZX268fOQgECRytiKm-nPQ@mail.gmail.com> <6fd12815-98eb-469f-8477-0de12af29aa2@amd.com>
In-Reply-To: <6fd12815-98eb-469f-8477-0de12af29aa2@amd.com>
From: Peter Newman <peternewman@google.com>
Date: Tue, 5 Nov 2024 11:35:46 +0100
Message-ID: <CALPaoCgiHEaY_cDbCo=537JJ7mkYZDFFDs9heYvtQ80fXuuvWQ@mail.gmail.com>
Subject: Re: [PATCH v9 19/26] x86/resctrl: Add the interface to unassign a MBM counter
To: babu.moger@amd.com
Cc: corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com, thuth@redhat.com, 
	paulmck@kernel.org, rostedt@goodmis.org, akpm@linux-foundation.org, 
	xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com, 
	daniel.sneddon@linux.intel.com, perry.yuan@amd.com, sandipan.das@amd.com, 
	kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com, 
	jithu.joseph@intel.com, brijesh.singh@amd.com, xin3.li@intel.com, 
	ebiggers@google.com, andrew.cooper3@citrix.com, mario.limonciello@amd.com, 
	james.morse@arm.com, tan.shaopeng@fujitsu.com, tony.luck@intel.com, 
	vikas.shivappa@linux.intel.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com, 
	eranian@google.com, jpoimboe@kernel.org, thomas.lendacky@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Babu,

On Mon, Nov 4, 2024 at 7:21=E2=80=AFPM Moger, Babu <babu.moger@amd.com> wro=
te:
>
> Hi Peter,
>
> On 11/4/24 08:16, Peter Newman wrote:
> > Hi Babu,
> >
> > On Wed, Oct 30, 2024 at 12:25=E2=80=AFAM Babu Moger <babu.moger@amd.com=
> wrote:
> >>
> >> The mbm_cntr_assign mode provides a limited number of hardware counter=
s
> >> that can be assigned to an RMID, event pair to monitor bandwidth while
> >> assigned. If all counters are in use, the kernel will show an error
> >> message: "Out of MBM assignable counters" when a new assignment is
> >> requested. To make space for a new assignment, users must unassign an
> >> already assigned counter.
> >>
> >> Introduce an interface that allows for the unassignment of counter IDs
> >> from both the group and the domain. Additionally, ensure that the glob=
al
> >> counter is released if it is no longer assigned to any domains.
> >
> > This seems unnecessarily restrictive. What's wrong with monitoring
> > different groups in different domains?
>
> Yes. User can monitor different groups in different domains. But, they
> will have to use different global counter for each group.

What is a global counter anyways? It sounds like an artifact of an
earlier revision. This concept does not sound intuitive to the user.

>
> Here is an example.
>
> #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> groupA//0=3Dt;1=3D_;
> groupB//0=3D_;1=3Dl;
>
> Group A - counter 0 (Assigned to total event in Domain 0)
> Group B - counter 1 (Assigned to local event in Domain 1)
>
> We allocate two different counters here.  Now we are left with 30 counter=
s
> (max 32).
>
>
> This is similar to CLOSID management we follow in resctrl. This is not a
> new restriction,

It is a restriction in a new feature that resembles a restriction in
an existing feature.

I don't see what function the global allocator serves now that there
is already a per-domain allocator. My best guess is that it avoids the
case of an mbm_assign_control write that succeeds in some domains but
fails in others.

I admit I said earlier that I was only planning to allocate globally,
but now that I'm evaluating how to make resctrl's monitoring
functionality scale on large systems, I'm being forced to reconsider.

As long as this is only a limitation I can fix later, I don't see it
as an obstacle. There would just need to be better documentation of
what sort of internal data structures the user needs to visualize in
order to use this feature successfully.

-Peter

