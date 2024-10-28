Return-Path: <linux-kernel+bounces-385805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4A39B3BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E02C1C21FC7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107EA1E009E;
	Mon, 28 Oct 2024 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GZs+indq"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A99B1DE4DC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147858; cv=none; b=Vm4qwmbs7uHsweZ/o/QrwAGqMGPoqpTclYSspr2ILGLxhOmtn2eIXACpqKVvoTGyrrA8XPZS+5dS+/heKABb6NT4Soyvq8gjmKmTx/II7Or8JAlJSgdlw+gP9RjZ9+s4soRJAWC13jf1/5fgwdF1xwHpFvkW5qVKl8sUZyIpwmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147858; c=relaxed/simple;
	bh=4tI3tevwWJFEabw0MDqHvv30EkiuHDShjv3zKsQqCHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M17T19Ype3biwbmIcIZucMjec3hT1l5eidigBRRA9hypMcSKBRGBtkOUyrmPH5wYgwlR1TcGPQvgbh5QxCIabcOtWQmiPlfwQqxPJYBPjq9aEIvZ7bUr/R8nmywzJlV/zJpF3srQofbdoqSaoyhGrOeK9KfIhwYgav8urfvNpX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GZs+indq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so47311475e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730147855; x=1730752655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=950tvZToDH3Xz3HQmCJhfPPgLkFTybdofF+TRroBG40=;
        b=GZs+indqNZR4qGc0NGZzAuWE4JciaJmNgZvBhihzXFrJV4EeU8Plrh3pOz6KahXf5Q
         ANT81VCMZkNISH9x3PGSrxrYfVnUFww66Rlf2vVWjze931avVwSAJzCWO7EiX82daGA0
         jqD/QaOWqAfZYMPNRPvVXbDKb7AqNiO3e7jPFRFuJavxOEMJC5DhIVG3/d1XjwZCG4fk
         1sH+pJ1FlBxBBPcczAAoNiKd0zbmaDiLiSLHR/nIXqYSa+RZzzffSeZrmoQgl75xyiD/
         lzygc2QxKRbk6nDNR4iyA7if40F2VfKGMH1IZ6Fo0yyUEDITEZ04EgNW2jLBY6jE2Ujs
         goxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730147855; x=1730752655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=950tvZToDH3Xz3HQmCJhfPPgLkFTybdofF+TRroBG40=;
        b=XuW21pcNAVGOrpviIwswgkXZmX3gk8ArOOUCAn7hyZ6iaXtPVGOWx37xRxVETS3JHB
         WrLvZs4fUvA78sG74OMNrwC9a83ziFm8PHiS06UzvqV+vfCjcUpUSpByfbqZDzDe/x9P
         hmBK2XsOsmKPYea08EUavx+llAGb5kMx34YiXBTt8/e4C7bGNt6CA035tgoNG0/KYOn5
         BtmCYxy+aZFnBIC4frHfLEqS4VZ4CIS1ZTIfjVI6g2/GASG3DcdAjSG6DIMuR73viiUA
         oVHayQddQx8VzuJUFkM3ew1CwcTTgayorlSrwT3Q8rk6Tmv4jMPpoKGy8uAdSQG67QZ4
         eecg==
X-Forwarded-Encrypted: i=1; AJvYcCXwwZkauP7NaI07ZhEkaT6peB4qFBUHCPKdcHJmuC9x4BWYtFlVanQg4Nh6r2WnFj2vhhEM2q/d+pyrb3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNOLis+QxFnLtw2izv9Ry65IG7pXULMDDrK2KtZxHtzrD1aLcS
	Z+jIcFSlmKW0nXuadiQXJMh/weIetqr7ax2HaaKkw4ESoj8G2LKiczZ29VC/gQBHQjTpyfc46/A
	vLSmF13EM/J1oaLLWDWqIbSqnnFnvOxrIg1+x
X-Google-Smtp-Source: AGHT+IFxle8Yr8gOyEf6jQju2CPCM+MD1nHdoAA2boJlnsRNm3EFrW5KeQpfbiUJ8885NxdK4k/tlauPCp5mRUo5twQ=
X-Received: by 2002:a05:6000:c83:b0:37d:33a3:de14 with SMTP id
 ffacd0b85a97d-3806110aaafmr7437579f8f.7.1730147854503; Mon, 28 Oct 2024
 13:37:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004195540.210396-1-vipinsh@google.com> <20241004195540.210396-3-vipinsh@google.com>
 <ZxrXe_GWTKqQ-ch8@google.com> <CAHVum0ebkzXecZhEVC6DJyztX-aVD7mTmY6J6qgyBHM4sqT=vg@mail.gmail.com>
In-Reply-To: <CAHVum0ebkzXecZhEVC6DJyztX-aVD7mTmY6J6qgyBHM4sqT=vg@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 28 Oct 2024 13:37:04 -0700
Message-ID: <CALzav=e7utP8wT_0t2bnVjyezyde7q86F3BHTsSpR1=qVbexQg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] KVM: x86/mmu: Use MMU shrinker to shrink KVM MMU
 memory caches
To: Vipin Sharma <vipinsh@google.com>
Cc: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, zhi.wang.linux@gmail.com, 
	weijiang.yang@intel.com, mizhang@google.com, liangchen.linux@gmail.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 10:37=E2=80=AFAM Vipin Sharma <vipinsh@google.com> =
wrote:
>
> On Thu, Oct 24, 2024 at 4:25=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Fri, Oct 04, 2024, Vipin Sharma wrote:
> > > +out_mmu_memory_cache_unlock:
> > > +     mutex_unlock(&vcpu->arch.mmu_memory_cache_lock);
> >
> > I've been thinking about this patch on and off for the past few weeks, =
and every
> > time I come back to it I can't shake the feeling that we came up with a=
 clever
> > solution for a problem that doesn't exist.  I can't recall a single com=
plaint
> > about KVM consuming an unreasonable amount of memory for page tables.  =
In fact,
> > the only time I can think of where the code in question caused problems=
 was when
> > I unintentionally inverted the iterator and zapped the newest SPs inste=
ad of the
> > oldest SPs.
> >
> > So, I'm leaning more and more toward simply removing the shrinker integ=
ration.
>
> One thing we can agree on is that we don't need MMU shrinker in its
> current form because it is removing pages which are very well being
> used by VM instead of shrinking its cache.
>
> Regarding the current series, the biggest VM in GCE we can have 416
> vCPUs, considering each thread can have 40 pages in its cache, total
> cost gonna be around 65 MiB, doesn't seem much to me considering these
> VMs have memory in TiB. Since caches in VMs are not unbounded, I think
> it is fine to not have a MMU shrinker as its impact is miniscule in
> KVM.

I have no objection to removing the shrinker entirely.

