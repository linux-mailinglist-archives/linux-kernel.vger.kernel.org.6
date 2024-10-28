Return-Path: <linux-kernel+bounces-385980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1359B3DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5EF51C21F0F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02641D88D7;
	Mon, 28 Oct 2024 22:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s0IQAS6r"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD30C15B12F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730154785; cv=none; b=RBeNBnvY5qtTX6t/GqJDdflbWg0MQHKlpDSv8PqApk2i2rPirnWYeKCUlYYlMNzNlk2RrJ4wcWjJpLAXUk5cvNooLvf7hRT0dYBevYR5pqVS+csu5Q5IsvLf3tT6UZ5VP8qtE3/0+RcEfLYjn1Ek+zMwAb3URcaTm8ZPhdSAKKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730154785; c=relaxed/simple;
	bh=kNHEHMV0zY+1aYzhjiKwyR0TGgGP9KUxL3tta/OZWR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVB4AugfJzDDw96F/rhl52KhOxojZgpd9gkVf9Khr/jzFKUcMirQsE+hLrsP90BHx7AKUYaglBaUGsUGv0vxLkwoAecvJvuh8iDHoQ3N8ht0yBs2jZPT7RbhUlKk4q/HllfldYS+gFCbbcniH2oLDUeFd6QrDo5Aygktuw0lxIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s0IQAS6r; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e66ba398so3767e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730154781; x=1730759581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PXUdti5B4GGx8N5cDYO9ntXy7OHOZuPm7RsuKd7wHM=;
        b=s0IQAS6rKOf6N01eEjcXLT2LDYThHwd/oT5rWD1AhkNx8GB+fIgiLhB9D6Rv+zS8vj
         Ll9vX33ZBj2HLkdCLT5ubV1E6cIHU7prRX9kBolXdMFOKJAP/yWMh1uHJWSP0QjO9mEQ
         dNDcgSVHAFifDUnZt23WKV+82N+0EVEQqHSCfstCX3fHUvFX/Cpv61p5mVFdGXVFPZxq
         2Db6BM9MG/A/R/qO0EICNqpjHiK5ZWbACVu5oUZFDvWtv0VQLu+Uma1PHXPV7J+jTzql
         Fcy4gvxD1eMAlr9w2JnwDZFKQaKq6qZV8hTYU69UQGoK25wdPHZbVFq6qRrifEmtmDL7
         12Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730154781; x=1730759581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PXUdti5B4GGx8N5cDYO9ntXy7OHOZuPm7RsuKd7wHM=;
        b=vgiFaXKm63KPXKx/IkKpjeNl2WqsWHfpySRVe3cnVsoUpTOIyznSBpTh7/9vK9y3k7
         uQjIeCa7w4rQGycKf2RigDmzv9PkQo+d6Bo3sH9UPZjb6LQnjaa7nccqcQOkk8hF/Avu
         MDyI6lx7dLEYi0d6owpKsov6i9P+dleSd0H36UbWEhb1OoG3/sSO4025OXV8pXmx+gcM
         KeEwQrQsCupsBBIUiVx+c1KmGrX+6i9KSEDZCx76OQXaMy8PHsRSjyjzMXyfEI1Z/0J3
         CHyfJJtLFMNbQ26XV1Jv2Y1vDraYKFpOArL+DToQonbCL5MixtLqZ4qWVKpT4/MbxHTT
         lZYg==
X-Forwarded-Encrypted: i=1; AJvYcCUD7Xo0FEK1gI20P2hvNKLno2XOmQlk1kAxVpQ64mzL2vl6E7KB8MyxwwO91YneamoXxMtYgh5qzG92zFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGe0ERVYYEhT90a6ndohuE4n+n85gch0RB6voxAOQ/P73iTX5c
	ycZpBl/P4+gleuHQuJmArc0PnClevBdXql2kFiBLA33AZu8/4j/JePZpSRiyAqPWzxNWThELXbZ
	iw7AR522S/4PDs5Qr1H27zhQq9MKg1UPeh8C5
X-Gm-Gg: ASbGnctuDNXwQyI+HU7azs7/bQqfIscqDhrdSZffZfULKRpHx6UV2jB11CxDbPo8ozQ
	bSzF4LpMVaq8TiZdqxojW7Nm702cF0EN0ViDVL+y/grLc2wPo7swSBRLJTeRVpQ==
X-Google-Smtp-Source: AGHT+IFRClGAbqzMEgpB5HFrgsld+skZharIDl6h4zzXmGC+APYDTqAblfanhlkNcbb8hQiK1ZC37WX2geMLM7RCpFE=
X-Received: by 2002:a05:6512:158e:b0:52e:8475:7c23 with SMTP id
 2adb3069b0e04-53b48c0935cmr69374e87.7.1730154780695; Mon, 28 Oct 2024
 15:33:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004195540.210396-1-vipinsh@google.com> <20241004195540.210396-3-vipinsh@google.com>
 <ZxrXe_GWTKqQ-ch8@google.com> <CAHVum0ebkzXecZhEVC6DJyztX-aVD7mTmY6J6qgyBHM4sqT=vg@mail.gmail.com>
 <CALzav=e7utP8wT_0t2bnVjyezyde7q86F3BHTsSpR1=qVbexQg@mail.gmail.com> <Zx_45FUW1QddzqOU@google.com>
In-Reply-To: <Zx_45FUW1QddzqOU@google.com>
From: Vipin Sharma <vipinsh@google.com>
Date: Mon, 28 Oct 2024 15:32:23 -0700
Message-ID: <CAHVum0eNy-4nnv-9vPmG7cVM4JO0L_v-s4V6-NFWxYRumt5a=Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] KVM: x86/mmu: Use MMU shrinker to shrink KVM MMU
 memory caches
To: Sean Christopherson <seanjc@google.com>
Cc: David Matlack <dmatlack@google.com>, pbonzini@redhat.com, zhi.wang.linux@gmail.com, 
	weijiang.yang@intel.com, mizhang@google.com, liangchen.linux@gmail.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 1:49=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Mon, Oct 28, 2024, David Matlack wrote:
> > On Fri, Oct 25, 2024 at 10:37=E2=80=AFAM Vipin Sharma <vipinsh@google.c=
om> wrote:
> > >
> > > On Thu, Oct 24, 2024 at 4:25=E2=80=AFPM Sean Christopherson <seanjc@g=
oogle.com> wrote:
> > > >
> > > > On Fri, Oct 04, 2024, Vipin Sharma wrote:
> > > > > +out_mmu_memory_cache_unlock:
> > > > > +     mutex_unlock(&vcpu->arch.mmu_memory_cache_lock);
> > > >
> > > > I've been thinking about this patch on and off for the past few wee=
ks, and every
> > > > time I come back to it I can't shake the feeling that we came up wi=
th a clever
> > > > solution for a problem that doesn't exist.  I can't recall a single=
 complaint
> > > > about KVM consuming an unreasonable amount of memory for page table=
s.  In fact,
> > > > the only time I can think of where the code in question caused prob=
lems was when
> > > > I unintentionally inverted the iterator and zapped the newest SPs i=
nstead of the
> > > > oldest SPs.
> > > >
> > > > So, I'm leaning more and more toward simply removing the shrinker i=
ntegration.
> > >
> > > One thing we can agree on is that we don't need MMU shrinker in its
> > > current form because it is removing pages which are very well being
> > > used by VM instead of shrinking its cache.
> > >
> > > Regarding the current series, the biggest VM in GCE we can have 416
> > > vCPUs, considering each thread can have 40 pages in its cache, total
> > > cost gonna be around 65 MiB, doesn't seem much to me considering thes=
e
> > > VMs have memory in TiB. Since caches in VMs are not unbounded, I thin=
k
> > > it is fine to not have a MMU shrinker as its impact is miniscule in
> > > KVM.
> >
> > I have no objection to removing the shrinker entirely.
>
> Let's do that.  In the unlikely scenario someone comes along with a stron=
g use
> case for purging the vCPU caches, we can always resurrect this approach.
>
> Vipin, can you send a v3?

Okay, I will send a v3.

Thanks

