Return-Path: <linux-kernel+bounces-552644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1586A57C32
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 18:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335C51893677
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAA0BE65;
	Sat,  8 Mar 2025 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dKXt1izW"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B382114
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741453276; cv=none; b=PBc87Lubty4O79Iq2FajHY0ThUy5PnANMfFcqFprM1WQi8S3X4xay4K8s0Aqmi6DTUSx6mUV4Jm00ZEKzHkDb03A3tfVB3okPDAsH/dP4LQEwygU6l0NR4MS8RTzjS1f1ggwq5z2ZvfgvtP3m3r5938QI/Is9XDw9t+TE4d+ygM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741453276; c=relaxed/simple;
	bh=Dx6rJMU2Aa2BXhNkBCMTd2gVPqi/oI/g6qHcSPTD7jA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WO0bIg8umfb4RJ5Yj61Jd3gMAqfKZxme/EyCwn4w1j1KGvKFJXIaSe1QLHoLvfAWdo6yYbU5rdjDErvoaLJWF0/9LeILvuVBcMn26FKGItpPqcI7J892NLYftu1UgKPSXETkDXv3tE9mIAqeaj4naDPbYeNitaOViGRJJ7s57DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dKXt1izW; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6f6ae4846c7so27240587b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 09:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741453273; x=1742058073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmU+CWNXZccbcHW1q3uz+b5fXx3M+S2HFEH+0ERFG9M=;
        b=dKXt1izWnmZMxCuZTMk/qBXfhQfdWU1GS4C/CnY5aIuntEL1V0WqLtW6kI8wourAMz
         Tqcs57+CMWhD+Muxzzp1Mb8HTipRVMBKKhgwFlBPG+NB0Sn1n8zDKuWsEp60KvaPyHqq
         1cdOZut6DjbKkpHYXYkliohdQ/I6sWW2gZPWxOFqUfbEHbId7uXLK0MTz64eId98MF1F
         ykS6OrAwuU2EjQTmrnWVB86VhkaLMGjJd/0KGKUVriM/H8BbPvzhWARbKeF4NJp9Uskc
         KlQGXF/co87rlSKUXw/1s695H1NwxhfL+SkrAAFICBN6EzqchAJfMqziYKOtcC/TyuvN
         lnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741453273; x=1742058073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmU+CWNXZccbcHW1q3uz+b5fXx3M+S2HFEH+0ERFG9M=;
        b=q2dliYoeozo4t/5EPIxakPpTe7wwsL3itRVVicCStp6VjV+2YG11B6Mdru7JobPsPv
         hwgrO/bRKJ3JahCmxjxeRswPPR2sqsgKaACAa2kDFkNwOBbtd6WrgXZzzi0nxtmMGPHs
         zF5JA0J9NiCaQygpGM7k1Fvy/XoPWkFIeL3ZdPTRN8kJAbT3MiB9j+txBdS6AVODeDC9
         k7qZ1akwpjBBkllkSl5k7KirV6lq9JD+5omyuFgHMK8iJEtG7iOvkV5V0aSztscQtoWy
         h4CJlFiopnlm+WCSsvfqbrhqiA2G8mEu9ulf31UttDAeodG/1w4yq3OcNrmjbahHqjCx
         y8ng==
X-Gm-Message-State: AOJu0YzjLOXoDuyPhuFgFa+YnEl+gX+XY5WO8WPtd0m88572CxhH1r2a
	rBHdfsRwHh1QxlH3C8pKMnnGeOdv2sB5/iaOg/VVLtqZehOdjql+FP9lDi4hINHDKN6Dyis0n10
	zbJb2kUwCZoLHsLYWmMkZR0j5OAFp14WaL/4p
X-Gm-Gg: ASbGnct3si66U0A6FLiWev/BiQ4MDe8Qz47JkDuJgjbPXc50S4Qx/FWPABB2a1j9bCb
	XJIWZkolMG/F4g5r79g1L427mdAjRvjMoBAMPWSaAbNCCaImXZzZ4g6NAyfEw3D60sX1PtAY9/S
	6eqm5GwmdEZEy4aB1PfySpIW5e9Q==
X-Google-Smtp-Source: AGHT+IEdoA2pzvwsBgCVYgy3VFXsbjJiFBjc99H/kSSHggt/Gl81bhyinq3kxKbz6IfR8ZdbGM9xI5KXR5Mi/sjmYFE=
X-Received: by 2002:a05:690c:4a08:b0:6fd:22fb:f21b with SMTP id
 00721157ae682-6febf30cca3mr115767447b3.18.1741453273308; Sat, 08 Mar 2025
 09:01:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304222304.214704-2-paul@paul-moore.com> <CAHC9VhRW4Be+uBbtgCRvSkUj1-CtYFZ9jbD9MZM70i7GhF624Q@mail.gmail.com>
 <Z8uvrJRfu4-0lk-I@lei>
In-Reply-To: <Z8uvrJRfu4-0lk-I@lei>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 8 Mar 2025 12:01:03 -0500
X-Gm-Features: AQ5f1JrDhQuuVCtCOMPwtA4d7RolNXy-kZ5gmPEkGaZ-wOfYqIaOrMTTM5vQMb4
Message-ID: <CAHC9VhQBJuBq8y8WMMG5cgAvXM6AeLT79_9uYTy5ia357kaf4A@mail.gmail.com>
Subject: Re: [RFC PATCH] MAINTAINERS: add an explicit credentials entry
To: sergeh@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 9:47=E2=80=AFPM <sergeh@kernel.org> wrote:
> On Fri, Mar 07, 2025 at 12:13:08PM -0500, Paul Moore wrote:
> > On Tue, Mar 4, 2025 at 5:23=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > >
> > > The lack of an explicit credential (kernel/cred.c) entry has caused
> > > confusion in the past among new, and not-so-new developers, about whe=
re
> > > to send credential patches for discussion and merging.  Those patches
> > > that are sent can often rot on the mailing lists for months as there
> > > is no clear maintainer tasked with reviewing and merging patches.
> > >
> > > I'm volunteering for the cred maintainer role to try and reduce the
> > > confusion and help cred patches find their way up to Linus' tree.  As
> > > there generally aren't a lot of cred patches I'll start with simply
> > > folding them into the LSM tree, but if this changes I'll setup a
> > > dedicated cred tree.
> > >
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >  MAINTAINERS | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> >
> > I haven't seen any objections, or any other volunteers, so I'm going
> > to go ahead and merge this to send up to Linus during the upcoming
> > merge window.
>
> Sorry, I managed to not take my personal laptop charger with me
> on a trip this week, fell behind.
>
> I'm very happy with you as the maintainer, but I do volunteer to
> try and step in here, if that works.

Thanks.  Send a patch adding yourself as either a maintainer or
reviewer, whichever you prefer, and I'll happily merge it.  For
reference, I've merged the patch in this thread into the lsm/dev tree.

--=20
paul-moore.com

