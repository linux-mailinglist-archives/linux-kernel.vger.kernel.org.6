Return-Path: <linux-kernel+bounces-385826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4209B3C45
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5BC282EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08881E0E09;
	Mon, 28 Oct 2024 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="weMxdim4"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8011E5720
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148584; cv=none; b=BqX5GMpJCvAQR9q5TAcnKiyKb4FTjsGqDgEXC6X/YicVAblcEgii6mqfVMd0InB4Gw1n9B3lnxIjCV8aBOhYn2vGQCVh1hVvooXlA7/E8KF7KCmxUizuJSq9Blf4h6ML4ADr3UEksrSDTRGhCGNanYQmZR4/tNNXuq9ZpK7QjRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148584; c=relaxed/simple;
	bh=SfhnIHVJ+vj9IlVi1e3u20baHrkIO1paJT4mCU9ygBs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G/Kc3ezUC/Gby2F729/EL90ULaf2vODz8x0UacjtBFA7PxIlQQlGybmfZjoJJ6AS8aXOAwHC5YoOkpDB+KvdXFmO+Xkx4hfnPWceNshysAQsUhYdFeVW/cr9MVwPzXF22cM66lWuojXOa4cMXUHn7B9iV+q6Eu0ksmW9d7LJeS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=weMxdim4; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e297a366304so7432577276.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730148581; x=1730753381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtfQuf+/IVmapA4aIhxdfxLoHCYLyfTkGP4/1HViN3Q=;
        b=weMxdim4nPiA9tKDyZjRrHTKemilqFEwrklJJbDsM+5J0Av8t0Rr3n/taTkQ5DFVh6
         8fTnCfw6s7DYyjLSzQlyzC15XnYAIje2WNkMCPyxlrnr8/0ZX5CksAq2QnK30P2xfrUZ
         Y/H3pMb223ITHcjDKJpiJ2T9c9U6a/gUggQF9JrQtg41tQs2w/xLwLveOg4heVF7c8vD
         ZJKUNs3aziPl9JCwDzrN4ItcBhegQpuuqvjL7emQI1Izmjq/irHnx07rBlkezQSScMrq
         HWyIpIjcStnE/gZiVEgkr+iB4x/ORPwv7WHoN4p9RCl9+m9QFHIQLcjYaVyCfIotCUkE
         xLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730148581; x=1730753381;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vtfQuf+/IVmapA4aIhxdfxLoHCYLyfTkGP4/1HViN3Q=;
        b=WY1PF6JkO6ibKdotkWY9H/9B0ybdao/oKUSgchSRCSY1JQn61pPwE68GWH9cTSfWXk
         1xwZvX7KhQgnJentGfr19By1f0M0pvtNulXCvkYXonbrr1GxtPgLRAUgzK+vt8tIMRNp
         TiocR1xA44ZS++Py0bShe+RzsfBEwhDL4SRoqkln9QTVT9hQekSsc6Z9K7VM+Dn4z0HI
         byxBdKtHkGF4wVHlwPgNRAuo/Xdq2ujcihloRksQQuvSx7bE+AQ6q0FAzTu44c5Pl2V5
         SuIVvCxXgExrqabtfwoVRUQJZTfPy1U6qXnrG13aepUWBb+EnSsrtcaPGERrpox+pISN
         E2fg==
X-Forwarded-Encrypted: i=1; AJvYcCW7nhIl/zhrJQ3JJpF/Lvq3nWuXsjByAxCg+Wpl91+KUBkDTGmgm6+3yYBKz0LAXCOG2bwDrrtirpMyzwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgBtRGeySMkMoVL2n7H9IzyTv9N0oh4enzQvMV/TJkufuhRk8b
	fnEPVMcPnZgrrBhj6dNbmfvxAb5Jhg5ijc5E86LtBPxo3HL1oBgJPU6dgL48A4+LlxR8tMnxTpF
	Njw==
X-Google-Smtp-Source: AGHT+IHju2rUMowBvoYs5Ted4d1E/57gEN8eqYbNOQK5SftV4h1ibOdpNwto7tvScRDuqRb+0B/3lYEobNM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:f301:0:b0:e28:eaba:356a with SMTP id
 3f1490d57ef6-e3087c10916mr30169276.9.1730148581284; Mon, 28 Oct 2024 13:49:41
 -0700 (PDT)
Date: Mon, 28 Oct 2024 13:49:40 -0700
In-Reply-To: <CALzav=e7utP8wT_0t2bnVjyezyde7q86F3BHTsSpR1=qVbexQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004195540.210396-1-vipinsh@google.com> <20241004195540.210396-3-vipinsh@google.com>
 <ZxrXe_GWTKqQ-ch8@google.com> <CAHVum0ebkzXecZhEVC6DJyztX-aVD7mTmY6J6qgyBHM4sqT=vg@mail.gmail.com>
 <CALzav=e7utP8wT_0t2bnVjyezyde7q86F3BHTsSpR1=qVbexQg@mail.gmail.com>
Message-ID: <Zx_45FUW1QddzqOU@google.com>
Subject: Re: [PATCH v2 2/3] KVM: x86/mmu: Use MMU shrinker to shrink KVM MMU
 memory caches
From: Sean Christopherson <seanjc@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, pbonzini@redhat.com, zhi.wang.linux@gmail.com, 
	weijiang.yang@intel.com, mizhang@google.com, liangchen.linux@gmail.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024, David Matlack wrote:
> On Fri, Oct 25, 2024 at 10:37=E2=80=AFAM Vipin Sharma <vipinsh@google.com=
> wrote:
> >
> > On Thu, Oct 24, 2024 at 4:25=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Fri, Oct 04, 2024, Vipin Sharma wrote:
> > > > +out_mmu_memory_cache_unlock:
> > > > +     mutex_unlock(&vcpu->arch.mmu_memory_cache_lock);
> > >
> > > I've been thinking about this patch on and off for the past few weeks=
, and every
> > > time I come back to it I can't shake the feeling that we came up with=
 a clever
> > > solution for a problem that doesn't exist.  I can't recall a single c=
omplaint
> > > about KVM consuming an unreasonable amount of memory for page tables.=
  In fact,
> > > the only time I can think of where the code in question caused proble=
ms was when
> > > I unintentionally inverted the iterator and zapped the newest SPs ins=
tead of the
> > > oldest SPs.
> > >
> > > So, I'm leaning more and more toward simply removing the shrinker int=
egration.
> >
> > One thing we can agree on is that we don't need MMU shrinker in its
> > current form because it is removing pages which are very well being
> > used by VM instead of shrinking its cache.
> >
> > Regarding the current series, the biggest VM in GCE we can have 416
> > vCPUs, considering each thread can have 40 pages in its cache, total
> > cost gonna be around 65 MiB, doesn't seem much to me considering these
> > VMs have memory in TiB. Since caches in VMs are not unbounded, I think
> > it is fine to not have a MMU shrinker as its impact is miniscule in
> > KVM.
>=20
> I have no objection to removing the shrinker entirely.

Let's do that.  In the unlikely scenario someone comes along with a strong =
use
case for purging the vCPU caches, we can always resurrect this approach.

Vipin, can you send a v3?

