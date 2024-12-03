Return-Path: <linux-kernel+bounces-430368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239389E3001
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF826B25412
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA0120ADD3;
	Tue,  3 Dec 2024 23:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D6GHsOy8"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0689208983
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733269388; cv=none; b=XKQe02MJcgbQihEe2Q2rei76QjZB55GkuTmQ8CLd1PiwIQjnrjrJYqOEfPCEjpYSwOrF0k4aAT8niH/0MrdjcNCroEahjgdLSZ4XijnA8hKfyFIWfLy4VommQKNBAlTOCZBhynPfLT6il0SU3s/w1+3YnuN/n3OmkvL10q1TjGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733269388; c=relaxed/simple;
	bh=/CZ2yNFlNF/WOHHJXMK+Nyg+piMw6SzQPGnPsKv0u+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BmSfTL3FgEAZCSuWfl3gS1PNUOeaFBHZQyHdoMtHIZ7P25TTbX0W9viycEmHOHxGJtU9mYW4v+UN7i3+jIHVqKvWs5cwsBVGAcBN5CDozPg9BcE0qryB4KzBzVk6gyM/kUwfP1AKSUbE8Ear/TsxyuG7rfGVsbQo/ZxZF39quPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D6GHsOy8; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4afa4094708so179153137.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 15:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733269385; x=1733874185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efxAKMGIsYtsJH1TfFadrRu53b/jP4XGduoqdQKfUDs=;
        b=D6GHsOy8YGm1W+pxxz9XTuNI24U+7ECkrmNetaIqMTpybghBkKEp9eLPz6u7fqBR5H
         Cc+YL05qQjSDB4MAGxv6f+Ozz6rFg71zhsTbmSFO6tRsrfVJEYHEovmc0cKncu62xByO
         eJpXVMjtLYw0/MxeFSqFOkgft5DyY3Bd+jCFieNcRnScMoI93VAYORD3abwqUYaUBsEZ
         kMQ8DbLKNmHsvrP+H1/NQ5PfOYUH/3SJEYn35g+JGBYhq1joOfUc+KO7T1UfieTb4ABz
         9EeslIU+YiGq5nZq3n9JKu3bTXqdwSnU5IPdk8WpzeYxM8UyLtRJ/W6pZr4UXX21ygXM
         IKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733269385; x=1733874185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efxAKMGIsYtsJH1TfFadrRu53b/jP4XGduoqdQKfUDs=;
        b=Eu2aR49z5sOaA9Rr+BqBSRLEgDW5756XPWe+TOg8YMUFPmrFps5bBbTaoY65YzVqnj
         GvpizWsnZpdj3gvtjdHDYtQh2OLVn/gjp49tn/jCiptxggYeogjdgEf5b/fxa/lqje2Y
         6jDwzq73h8yysN3TqB5OuLzgzRlVaWsewJlSgBoCkFWBDwy2+LlOBAfV6r4WTeLg3KCB
         BYAyZSIwpGsvZpT61CwJGbaWNpSFX5l52vIhZA4EhGg6bSF2odl8KIixbR8d90/xltaD
         iHTLV6vVWbqtmsdSuehr1AaIH+pH6HXi3BglQRBRmgnKLuY19XCyg13JXQNSYKIH3+o8
         AHDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbvF9gateBr/IvUxYUALXiHFgnFATygIhAAIJBG5WGr9+Zo6hODOUGmjJiRty9meXVX2ECgXBYOuPMTPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmFKBZscW3fRq2Z9FoApxlNiT/+HsEHYPydr6JJFDaBpFXsbo9
	ropRWkV+43UI8IAmmgHcZ59ur3TJI07sp8mhXO+Bnd3b/tZg6hyuhvp8TROWkbDlnSxPVrfeTd4
	f6nEXfKOEmHSsdLOPHyR3QLbbmeoLCHUpLfmB
X-Gm-Gg: ASbGnct3fm/ipNcMN0KdzqCAR2k9+2BbWeUKu00lBm/tQzCzucA6k29GIjHsv7d35om
	YfvWSbUWTybMIcwqrBRQB81xE+/m9bDalodirfLyPxq0yvBkyVjRl7NMGjNmq
X-Google-Smtp-Source: AGHT+IFnoxNObCnxOJ19RTHQOfy3IS0mP97qq1D+ZXM9Cr4w6i9KeiYqycIxeXsC6V041VYgYczgtjNRhEyAzhN1RZQ=
X-Received: by 2002:a05:6102:548e:b0:4af:ab78:f383 with SMTP id
 ada2fe7eead31-4afab78f4b5mr933855137.24.1733269384628; Tue, 03 Dec 2024
 15:43:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203005921.1119116-1-kevinloughlin@google.com>
 <20241203005921.1119116-2-kevinloughlin@google.com> <a9560e97-478d-4e03-b936-cf6f663279a4@citrix.com>
 <CAGdbjmLRA5g+Rgiq-fRbWaNqXK51+naNBi0b3goKxsN-79wpaw@mail.gmail.com>
 <bc4a4095-d8bd-4d97-a623-be35ef81aad0@zytor.com> <24b80006-dcea-4a76-b5c8-e147d9191ed2@suse.com>
 <25fa8746-3b36-4d43-86cd-37aadaacdf2e@zytor.com>
In-Reply-To: <25fa8746-3b36-4d43-86cd-37aadaacdf2e@zytor.com>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Tue, 3 Dec 2024 15:42:53 -0800
Message-ID: <CAGdbjmKwMrioAq1b1v_UhhOxU6R2xPztZ9Q3ZizC9iMA84s+ag@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] x86, lib, xenpv: Add WBNOINVD helper functions
To: Xin Li <xin@zytor.com>
Cc: Juergen Gross <jgross@suse.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	linux-kernel@vger.kernel.org, seanjc@google.com, pbonzini@redhat.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	kvm@vger.kernel.org, thomas.lendacky@amd.com, pgonda@google.com, 
	sidtelang@google.com, mizhang@google.com, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 12:11=E2=80=AFAM Xin Li <xin@zytor.com> wrote:
>
> On 12/2/2024 10:47 PM, Juergen Gross wrote:
> > P.S.: As the paravirt maintainer I would have preferred to be Cc-ed in =
the
> >        initial patch mail.
>
> Looks that Kevin didn't run './scripts/get_maintainer.pl'?

Woops, my bad. I somehow ended up with the full maintainer list for
patch 2/2 from the script but not this one (1/2). Apologies and thanks
for the heads up.

I saw Juergen's patch [0] ("x86/paravirt: remove the wbinvd hook") to
remove the WBINVD hook, so I'll do the same for WBNOINVD in the next
version (meaning I shouldn't need to update xenpv code anymore).

[0] https://lore.kernel.org/lkml/20241203071550.26487-1-jgross@suse.com/

Thanks!

Kevin

