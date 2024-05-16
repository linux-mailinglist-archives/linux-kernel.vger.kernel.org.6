Return-Path: <linux-kernel+bounces-181051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E128C76CE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F721C210E6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC0F146580;
	Thu, 16 May 2024 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbWIxIwt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7276D3A1B7
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 12:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715863559; cv=none; b=qTrz1q9y0ch211ez1/sSr3fphvihY1iNGzZpNLHN7ew1RC33TepWhl2sWLloJ5F+Z1ymvCsGWNP4qBVmWM4mZgwzKKApq+5XydB93wLcvAcFWTbmMp9pynlTbWVgyiYa05rt1uY+gaNTI4KXzyTUQkM+keTqKB5CgFHLtnYkOZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715863559; c=relaxed/simple;
	bh=xHfa5u2tqq62Z2Yqj7BohljmTIio2h6h+05EN60Voxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/SE0Geiyeeu5L9URVR/Irls2m6D2VicUJRcUm1KeU/xAks513yRhyCtxJQRpVlwa3gfg3KQPQx4DJOcu5sZcGu1wkr20TqcjHGREdIxbsigHjbeZW3BmSr5cQv6LR8ghEWdfrizly3KCnsfo0o0r0vMhBckcBRxvCKczyN7OLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JbWIxIwt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715863557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7dG6Z+45v2q5x1q/1fMWlQrJ5gyYce9+KheVF6sIr+g=;
	b=JbWIxIwtALlmRlpOpfSpqBdOndvWs4vzsCnUIEA8daNwFNPi+IjLHYLzUnS/518C/aVRG1
	xsRt+1SnSSNdrW7A+Cwqj0/KDsl1EpivQVeJsLivH4VNpM75RcQ/GzEtvvcW/Dh63t4guz
	n5dcCMjyVZvHZ6D9qlGHpTPOt5iqJlU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-pnl1F1f5P3yXkUW7PfD7rQ-1; Thu, 16 May 2024 08:45:55 -0400
X-MC-Unique: pnl1F1f5P3yXkUW7PfD7rQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-35044e65060so4096581f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 05:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715863554; x=1716468354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dG6Z+45v2q5x1q/1fMWlQrJ5gyYce9+KheVF6sIr+g=;
        b=osDDcEwFj8ikcM8RwwfD9b8qkkstvgmL7o51V88dS738T823d8YRwG8u2Bpu1wBbx9
         t0UC9DwCjquq4Kb2OxmmnCV/3pDaHL5sFufMoC2uf3D9169KiZYMi3oraJ70tH7kTomF
         iBKvWDRjEmVipTbv9NtozuF0SC6VgFmBP2bkzQHKXPEQR9gAltgvJY5IgI7lEdN1nUH0
         Kc2wa9pSwEvd0DmL3zRSe968AdmeAIavxqaZSiZ0A7kM8MTO2WJal90Ydli/mYlhdYSg
         nhmWsDfT0XofO5VVs6BK/vtZVvnZkRJjuc0mft5L7imrdp9Cvuy58Q9La0Hw3MmJJflf
         oBDA==
X-Forwarded-Encrypted: i=1; AJvYcCU4RQ2EfoyUgdXqpbUjARIpff25qNZ+dXoyQDRWlrejrbzQkRdWqcbPcW1T0XHZzar4wXl5X+hVEVEzbBAhtt0Pqs7MEZTDkx2GiXz1
X-Gm-Message-State: AOJu0Yw4Fj7pwTbjG3tZhdBG475HZHdbxKVVQXt9SILuJaTr7a30UAiD
	cv8FXsMiTsEch3lXa3EFI8fUgTArGX2ysGu15U3Eq1XRLy7a2XAbSbjNveUSuPRvP14AKGZ0593
	svejyA4AA1s4r2IHcVwrFJlVbKPLWWzQF7u3oz3OwANXohCs9NgMaTOdqln2MVM0YmJiyisKgRg
	eCEY08Zu9MS6mtDrR3KQzrnsUVwX2muh3HSdJj
X-Received: by 2002:a5d:550b:0:b0:34a:9afe:76f with SMTP id ffacd0b85a97d-3504a73749cmr14015563f8f.30.1715863554124;
        Thu, 16 May 2024 05:45:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ2EdeulUpFW4L96VwQkufH/EGbNBZaA8+A6kpKigJT6nq88J8jsTsHca1puBuLIbcAMkH5jX3IOPWEwU8ztQ=
X-Received: by 2002:a5d:550b:0:b0:34a:9afe:76f with SMTP id
 ffacd0b85a97d-3504a73749cmr14015549f8f.30.1715863553739; Thu, 16 May 2024
 05:45:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510211024.556136-1-michael.roth@amd.com> <20240510211024.556136-14-michael.roth@amd.com>
 <ZkU3_y0UoPk5yAeK@google.com>
In-Reply-To: <ZkU3_y0UoPk5yAeK@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 May 2024 14:45:41 +0200
Message-ID: <CABgObfZXvq8_j+tm8zJ_F=5XAD22rky1JtdUSzV+VgpOXqOn-g@mail.gmail.com>
Subject: Re: [PULL 13/19] KVM: SEV: Implement gmem hook for invalidating
 private pages
To: Sean Christopherson <seanjc@google.com>
Cc: Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 12:32=E2=80=AFAM Sean Christopherson <seanjc@google=
com> wrote:
> > +void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
> > +{
> > +     kvm_pfn_t pfn;
> > +
> > +     pr_debug("%s: PFN start 0x%llx PFN end 0x%llx\n", __func__, start=
, end);
> > +
> > +     for (pfn =3D start; pfn < end;) {
> > +             bool use_2m_update =3D false;
> > +             int rc, rmp_level;
> > +             bool assigned;
> > +
> > +             rc =3D snp_lookup_rmpentry(pfn, &assigned, &rmp_level);
> > +             if (WARN_ONCE(rc, "SEV: Failed to retrieve RMP entry for =
PFN 0x%llx error %d\n",
> > +                           pfn, rc))
> > +                     goto next_pfn;
>
> This is comically trivial to hit, as it fires when running guest_memfd_te=
st on a
> !SNP host.  Presumably the correct fix is to simply do nothing for !sev_s=
np_guest(),
> but that's easier said than done due to the lack of a @kvm in .gmem_inval=
idate().
>
> That too is not a big fix, but that's beside the point.  IMO, the fact th=
at I'm
> the first person to (completely inadvertantly) hit this rather basic bug =
is a
> good hint that we should wait until 6.11 to merge SNP support.

Of course there is an explanation - I usually run all the tests before
pushing anything to kvm/next, here I did not do it because 1) I was
busy with the merge window and 2) I wanted to give exposure to the
code in linux-next, which was the right call indeed but it's beside
the point. Between the clang issue and this one, it's clear that even
though the implementation is 99.99% okay (especially considering the
size), there are a few kinks to fix.

I'll fix everything up and re-push to kvm/next, but I agree that we
shouldn't rush it any further. What really matters is that development
on userspace can proceed.

This also confirms that it's important to replace kvm/next with
kvm/queue in linux-next, since linux-next doesn't care that much about
branches that rebase.

Paolo


