Return-Path: <linux-kernel+bounces-344484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C91F598AA4A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC17D1C20D60
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1914198E9B;
	Mon, 30 Sep 2024 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X8qcnoAu"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A75119047A
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715072; cv=none; b=L8nAMpUdjz7fCZq7zDGDrE5bpdnBDB4pn+auqONyC4DO37+NX/fK/LUAT6oO4DCJVMOegOSH0el0CVae8zfnTZxGhSFcVrEn5B1caEPx2b9hM9uf/gZ1qtoJksnDbElrfhGqf0tiE0nLz0LyqJtcgRry5wouBRjDQMowyPoBcOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715072; c=relaxed/simple;
	bh=Sj7JFYd945j6IHRijQpRLIAWRofqJPTr17Y9N8BVeEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=STTtXn2hNMUHG1QOVBWk4f4gnrYLQrE5uvqGJr6ZUTn++gUTmm3on5tJ+nnx5DE+Ww7n/Uv8Ndk8SKua8/OnpCX1aHRsvCX8ILAmyBEOJ++ccrcZcpPfU9BNIJPgy/0x/1dw/x3eSxBKW2aHiKmI+hmLMF+tnbBXW0c1JuWuPq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X8qcnoAu; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5398ec2f3c3so2109949e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727715069; x=1728319869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sj7JFYd945j6IHRijQpRLIAWRofqJPTr17Y9N8BVeEA=;
        b=X8qcnoAuX08d+0XtO+3Jthqplc7lCKv4PI22oDmHB61WqbFLBE5GMjLCxjBqglt3Br
         Rtyi9WJsu/Iia5O4IGYdVXeiRGmml5UGwaL0y8eqiV69r2l/u90AbwVjuvZcFVpGZXAQ
         f6QWoYYJgaVF7qWtTpFC+hhZHf7h3PZZTIp7q34V2h1wKmZ530dg6seAv6qWArYtPbot
         P3uUnnr25ENMbimRfVKnjw9eM3RLlP0GLkqlY7FwWTmzBCJty7+GHPPSQRojRf9uBKi0
         h+CGUsbySgPnL9gnHdOfTKicnvzFrUgNufFJRBhf0xnKRXU2m4cs/dqrYXwt7LDxORPG
         ln2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727715069; x=1728319869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sj7JFYd945j6IHRijQpRLIAWRofqJPTr17Y9N8BVeEA=;
        b=cscdCjt/Vi0TkY3MTrAyapYETtA2vvTlB2Lz16JT1BaESStVGmf+/nle3a4x8Hb7Lv
         bOFgChyGEWPVrWhEZRz3dh27rD/czBzxIC76fBYBp+C41Q3pFUiMMol5/vw0Ze20tE5s
         8KWkhe21LrOco92FwY0bY8HjxqDjCWwOEqvXVLvkhT7xq0EmsdProiQb6lzu9sCwUBM0
         W8Xzr/a1QPhUezsqVcd6k6JOadP0HrtCpxwXWhkOVNkD/va49Q3C0lj0y1qpfDsfaasm
         hPZemYm61QGjYUbXCzaOLqgp3Dt5yKjLp7WwGS3FKvLhudwIAB4uukgWPiRmYRH0Qb6s
         G+yg==
X-Forwarded-Encrypted: i=1; AJvYcCXqBhCUS3QlrlSZ2B4p+oWSRJSEHif0vlWbvSun0/ArUrZLw/ChkaTBcnccA2DPhDn43/C914bzLTYly2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUghhd8s5+InfcdTp57oFhUsHMA8CgOG373aDBLHiVKWmKwjVD
	YJWvt7m1PFrn6LMcZw+KfFHIVUXdmOcAA1i2eGSIl8d0coGw5bmlszxGHKeHY8kb59UZkoh3O5m
	62fORg48/FGYLUpzaCl8u/bx/FcB23BjUoVwE
X-Google-Smtp-Source: AGHT+IGt9nS7r3XQNTCdU3DUtjAMuOjHQE8h8bN9HqFFWlLuCm3zXtWDU2M0+sBMpgx07rporX8sPdXigossegPag0c=
X-Received: by 2002:a05:6512:3e24:b0:539:8f68:e037 with SMTP id
 2adb3069b0e04-5398f68e09amr3293661e87.48.1727715068525; Mon, 30 Sep 2024
 09:51:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913214316.1945951-1-vipinsh@google.com> <ZvSiCYZv5Gban0VW@google.com>
 <CAHVum0dpHrW3cDX9FCcd5wTsetFxzWP0B6WL3uXnqmwrVJnGcw@mail.gmail.com>
In-Reply-To: <CAHVum0dpHrW3cDX9FCcd5wTsetFxzWP0B6WL3uXnqmwrVJnGcw@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 30 Sep 2024 09:50:40 -0700
Message-ID: <CALzav=dmv8U8O6cFnyXNbUeTDrLs5Wj-ufYHNxDEJ14UZqrL9A@mail.gmail.com>
Subject: Re: [PATCH 0/2] KVM: x86/mmu: Repurpose MMU shrinker into page cache shrinker
To: Vipin Sharma <vipinsh@google.com>
Cc: seanjc@google.com, pbonzini@redhat.com, zhi.wang.linux@gmail.com, 
	weijiang.yang@intel.com, mizhang@google.com, liangchen.linux@gmail.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 9:43=E2=80=AFAM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> On Wed, Sep 25, 2024 at 4:51=E2=80=AFPM David Matlack <dmatlack@google.co=
m> wrote:
> >
> > On 2024-09-13 02:43 PM, Vipin Sharma wrote:
> > > This series is extracted out from the NUMA aware page table series[1]=
.
> > > MMU shrinker changes were in patches 1 to 9 in the old series.
> >
> > I'm curious how you tested this series. Would it be posisble to write a
> > selftest to exercise KVM's shrinker interactions? I don't think it need=
s
> > to be anything fancy to be useful (e.g. just run a VM, trigger lots of
> > shrinking, and make sure nothing blows up).
>
> My testing was dropping caches (echo 2 > /proc/sys/vm/drop_caches) in
> background while running dirty_log_perf_test selftest multiple times.
> I added printk in shrink_count() and shrink_scan() to make sure pages
> are being reported and released.
>
> I can write a test which can spawn a thread to drop caches and a VM
> which touches all of its pages to generate page faults. Only downside
> is it will not detect if KVM MMU shrinker is being invoked, counting
> and freeing pages.
>
> >
> > There appears to be a debugfs interface which could be used to trigger
> > shrinking from a selftest.
> >
> > https://docs.kernel.org/admin-guide/mm/shrinker_debugfs.html
>
> This is interesting and it does what is needed to test KVM MMU
> shrinker. However, this needs CONFIG_DEBUG_FS and
> CONFIG_SHRINKER_DEBUG. I think using shrinker_debugfs will be better,
> selftest can just skip if it cannot find shrinker_debugfs files. One
> downside is that this test will not run if these configs are not
> enabled.
>
> Which one do you prefer? I am preferring shrinker_debugfs but
> concerned about its dependency on those two configs, not sure if it is
> okay to have this kind of dependency in a selftests.

Configs are there to be enabled. If shrinker_debugfs is the right way
to test this, I don't see any reason to shy away from using it.

