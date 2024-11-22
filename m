Return-Path: <linux-kernel+bounces-417768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B1B9D58E5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 05:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F261F22CA7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 04:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5CF15D5CA;
	Fri, 22 Nov 2024 04:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="aV+sFiTw"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90DD15531B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 04:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732250459; cv=none; b=LfGujVekBdQHrPECks66zVIUUSxxZhUf/5in9ciXCwW5pSB7WmgPJRSb0GqPAsGJCvpd9iQMHS/xQITq4XevXdnkqawoKZ3ONxD1vc9uQ0mjOE7MGWbJwT2LLMnyC8UA8+wWWrdzt6CjLrIEaJvtWu7aMkt+ZYc983zPgey7tmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732250459; c=relaxed/simple;
	bh=rEec2QI3lDHuUv5dFSdEg8+6K5yE1/oNnAPhmw2YwWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8V474PsesTzcTdRxYdr8PmRvUO0tox2Qhh0eu8v/i1rL+lQEV5czWslT9R8WbVyaGNqNYLz7ctG+1MzF7nwFBXI14olo1F72D5TemNuTAE/3fjtj53r7Nez9CryWLW2KGrnBzaLs6sb3p+1PAiYyblTBi4FBZOmuwxjI4Psdq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=aV+sFiTw; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-83abf71f244so52273139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 20:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1732250456; x=1732855256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrq9QDDyqlB6+9xg5qKRAM5E4/iGhQvqb5r8OZhoYvU=;
        b=aV+sFiTwv+CS6mWevpg2FBg07XreL3RfPTpyjevvbbTKDMkGzZE4Lt+BaAz9Ns9QXF
         9YL+Exolpaa+JCi69pph1Vue5GqTHA8jCWANpcSMG+krE9tkwDQkNUhAXt5GE7R+982j
         E8WFtbXPF6Ctoge+ytvsRl0deuoJml1o0v0UotdWcWtMODVxFuN1LO0VxMPLgiS1xRqr
         cOtmz/6pGHkUM1F2GW2K0OpVeCaWmxFphqLSygs1W0rUsAF15EzPizkIhlZwf9E9cEwH
         /aXEnT9bImC1t1WLwV/y5Qn9SXclUgRFmthbrtdUe+dHL9px4mvZJWMhu+pgMl70B3um
         L3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732250456; x=1732855256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrq9QDDyqlB6+9xg5qKRAM5E4/iGhQvqb5r8OZhoYvU=;
        b=bDj9FQg3lujhJNIWDHgPHL4xpNBZNLWo9rb9BS1ej7fH4t5+hOA7yH4sLEbzQj/qQD
         uzD6yWy+BibL6Urke1pEC4MV4OLhSid9JdW+qLwRTA7fO2zeGemy6zER5sgMVBSXgYaO
         Xshc5Cc9QB6LcVhZIR44sWKct8EDJj6oKqlK1lxbsHoCLG66zgVwRcVl3wke93guqzGK
         TIQL3wk3WgTkzv+PDsLoXEPp21c4x3OYRgKWnsIsQSJsFCIAvXBYy+AOSt2xOXfdID4p
         nl9pTti3gI122K7rKs92XrpX/+gZ3pDRpHWMxYkjpOE2QfuuWnNQOlXfr6JtYleIhpv0
         Si1g==
X-Forwarded-Encrypted: i=1; AJvYcCUMTOTaOrq+mkgCqZteCn3ABK/JB9VMKJcIAubFrpLDtSDQ36xnxICHIfgVRdV76Dm8+mOZcYNwyRr4hBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk0Nf4Hf65ciPKbKpohe8mWhOT2+vObsKTyvz6Jj9RTpi1b38m
	zYs4E7ldldZbg5/Xj6kFIio5MxpHzSA74NwUY6Q4/dLew4Qm2S9laogaCSQv4OyNGuGQnmNXYmQ
	F/IqM/mvq56Qr5fnkfa3DfSUJF/BsxfwAEpeBIg==
X-Gm-Gg: ASbGncvSM2wBq9uVz+jmUHV7mJdan5IrN5BmSMTC/GEKwU11xF04ZA7rl+S4ti500Nu
	lRT1OyKRnCLRpFiZIKKbhwUkFJQpREjGg
X-Google-Smtp-Source: AGHT+IGZWepgtK/CehACTEFXOquehGtc7AqzFe9KdaXsbBt78BlUCH1bpgHyJxB6jhIPgjVfA62Lix8LBgfhCnp9AQI=
X-Received: by 2002:a05:6602:2c09:b0:83a:ab63:20b with SMTP id
 ca18e2360f4ac-83ecdc52218mr179806439f.4.1732250456540; Thu, 21 Nov 2024
 20:40:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120135842.79625-1-pbonzini@redhat.com> <Zz8t95SNFqOjFEHe@sashalap>
 <20241121132608.GA4113699@thelio-3990X> <901c7d58-9ca2-491b-8884-c78c8fb75b37@redhat.com>
 <Zz9E8lYTsfrMjROi@sashalap> <d4048dc8-b740-47f6-8e1e-258441eb77d1@redhat.com>
In-Reply-To: <d4048dc8-b740-47f6-8e1e-258441eb77d1@redhat.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 22 Nov 2024 10:10:45 +0530
Message-ID: <CAAhSdy29hLvyetBa_LsegiBqvVAaDf92b5ZPUD=okNBSTLjdxA@mail.gmail.com>
Subject: Re: [GIT PULL] First batch of KVM changes for Linux 6.13 merge window
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>, Nathan Chancellor <nathan@kernel.org>, torvalds@linux-foundation.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 11:49=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> On 11/21/24 15:34, Sasha Levin wrote:
> > On Thu, Nov 21, 2024 at 03:07:03PM +0100, Paolo Bonzini wrote:
> >> On 11/21/24 14:26, Nathan Chancellor wrote:
> >>> On Thu, Nov 21, 2024 at 07:56:23AM -0500, Sasha Levin wrote:
> >>>> Hi Paolo,
> >>>>
> >>>> On Wed, Nov 20, 2024 at 08:58:42AM -0500, Paolo Bonzini wrote:
> >>>>>      riscv: perf: add guest vs host distinction
> >>>>
> >>>> When merging this PR into linus-next, I've started seeing build erro=
rs:
> >>>>
> >>>> Looks like this is due to 2c47e7a74f44 ("perf/core: Correct perf
> >>>> sampling with guest VMs") which went in couple of days ago through
> >>>> Ingo's perf tree and changed the number of parameters for
> >>>> perf_misc_flags().
> >>
> >> Thanks Sasha. :(  Looks like Stephen does not build for risc-v.
> >
> > He does :)
> >
> > This issue was reported[1] about a week ago in linux-next
>
> Yeah, that's Linaro not Stephen.
>
> > and a fix was
> > sent out (the one you linked to be used for conflict resolution), but i=
t
> > looks like it wasn't picked up by either the perf tree or the KVM tree.
>
> Yeah, that's not surprising. :(  Neither KVM nor I weren't CC'd on
> either the report or the bugfix; and the perf tree didn't have the code
> at all as Ingo pointed out
> (https://lore.kernel.org/all/ZzxDvLKGz1ouWzgX@gmail.com/).  Anup was
> CC'd on the bugfix but he must have missed too and didn't notify me.
>

Sorry, I totally missed this one.

I generally rely on linux-next to report cross-tree conflicts or issues
but this one was somehow not reported.

Let me know if you need any action from my side.

Regards,
Anup

