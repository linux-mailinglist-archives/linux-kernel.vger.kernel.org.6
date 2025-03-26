Return-Path: <linux-kernel+bounces-577583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 376BDA71F21
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B6F189462C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678A22561AD;
	Wed, 26 Mar 2025 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U78CtHDd"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CAB253F1F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017233; cv=none; b=SWOjEM2IJZyQNCs0xeTfNWH4eMqvW/otjfCLV1z9+W8OdS1Yh5EkKztLSDweqvwsRybcoJs/+tBgvinRIJkBieU7m125Vbe7an1ocgb+mWvAe0OvisOb+xCDRUf7Ii+VjhzOMjT9EUx55uRL6rO/1KQmra2TDUZGxJ+gJSEtWqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017233; c=relaxed/simple;
	bh=+U1O+GCFM+kfSFm0eIkLWeuXl8Ro1RJubQKh9PZzrw4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Uh6ToQeqyKTWzWDUVRVaWUKIeBD2fDc7Yn984vR1bhiVh8DErGywsW92KSFLWxKW/W5S8RK2OgM1Vdz/wlf1dniVVSQn39gTEchth//8vUJ5rZ5XEBtNyuaaWpOm05+Hc6KifRM9+8/Aylq0Spz+Kpu2Zy/JB3ivcR3ja4e+weo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U78CtHDd; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff69646218so376829a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743017231; x=1743622031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IohNF223XL3lH0XqoriWRvDMNHxugR0378pliy8M2k8=;
        b=U78CtHDdwIdCTpa2wHy/8e4yaF4RxhQhQb7qa7IBsJhwt+QqBhXDMZ/l77HOHFGwJM
         WVwURBQ0UD9LR4a82f7/kJcagYlIOrTsEgvrTHGumTMk/KPD56FVJAkUpu/NRaHNn+GX
         qH3q+2yCBX5bkQj1NhmJ80Pox2MiKyEyWC1LdQE3jjnAEwOUmzusDRq8rfVRANgAUPPb
         zfaZi2rL4EvelavbDTSqcDnt4CA6natUdMKVkQUxOJOmtdUpZns+5Gr40G631VnXwRXB
         ttpA4bRNOVM98raGI32DvBIGEAWxcTEmF70v8mdE0P0pBzrajFl4EbRTMbUCuglCKWWN
         AvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743017231; x=1743622031;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IohNF223XL3lH0XqoriWRvDMNHxugR0378pliy8M2k8=;
        b=Ea8Dd0z9h5kklUj+bTsfi7lX6ctPl5Gm0ydyoTdNRYgtSbr3U/W5Uh+N3HpZqDMAWP
         pXk8YGTKvkQp/dio+6pfcKgxs9uzBl/oI4YIKOep0VYKDlsPyGCK9VSPgyrJ7j9e2UMm
         PqjP/vxjRuyfOHOPPIr0yvHZuEkTYSVCBmtgvONhwMgkqBSICgLVNdS8UDdfwbXEuaAg
         pUj0G9nGsh80pDE7KWT5Hu9Lh+xoYWTSFYryv2B/XI8tyRDz2K1APfo59f/mCeOR7cQR
         Tk3H0abuxtM7pdkm59I6wlfFVQN66TXhs9gKb5AlGGrmzLbsU7bB2+xx8q3JmWCiBd0j
         RsVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQUqw0Heariw8eLabP9UQyZn0Utx+2gBefMqdCzMHOI/2xI8yKN6WIYM3SwkMkdm7mblqDy1OL7Mhrpr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzivQ1FLm7bEnkL1FYCGxkEW2Yhbkqy6Gyr871NGXF2eivCXIiQ
	7h4pZvPbNviY9AduuI4KNz1UWLMyO/Xl34YTO6KYk9tC12eoVWWExsWucg7jcjDJ8/hLrc+0DY1
	rvA==
X-Google-Smtp-Source: AGHT+IF5Vq2DzJpQNzldBZKP+C7bbGIGWzkK3jj6QX/Dtg84AwGkvpnqQi8XzN9QF/JkIytLyWzgiVzVlO4=
X-Received: from pjl13.prod.google.com ([2002:a17:90b:2f8d:b0:2fc:2e92:6cf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c85:b0:2ea:a25d:3baa
 with SMTP id 98e67ed59e1d1-303a7c5d2e8mr953814a91.5.1743017231491; Wed, 26
 Mar 2025 12:27:11 -0700 (PDT)
Date: Wed, 26 Mar 2025 12:27:09 -0700
In-Reply-To: <CADrL8HV=ERo3dB7u-24VhjVQ6muBHEXeAfZYY7cuE7cxALRRRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250325015741.2478906-1-mlevitsk@redhat.com> <20250325015741.2478906-3-mlevitsk@redhat.com>
 <CADrL8HWrgbV+coEod_EUnvG27HX3WtJDMua3FPiReCRCtXaNhw@mail.gmail.com>
 <Z-RKZsQngjEgcfVU@google.com> <CADrL8HV=ERo3dB7u-24VhjVQ6muBHEXeAfZYY7cuE7cxALRRRA@mail.gmail.com>
Message-ID: <Z-RVDQC4HNxrD-pI@google.com>
Subject: Re: [PATCH v2 2/2] KVM: selftests: access_tracking_perf_test: add
 option to skip the sanity check
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-kselftest@vger.kernel.org, Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025, James Houghton wrote:
> On Wed, Mar 26, 2025 at 11:41=E2=80=AFAM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > Then the auto resolving works as below, and as James pointed out, the a=
ssert
> > becomes
> >
> >                 TEST_ASSERT(!warn_only, ....);
>=20
> I think the auto-resolving below needs to be flipped, and the
> TEST_ASSERT should be for `warn_only`, not `!warn_only`.
>=20
> If warn_only =3D=3D 1, the assert should pass.

/facepalm, yep

> > > > +                       break;
> > > >                 case 'h':
> > > >                 default:
> > > >                         help(argv[0]);
> > > > @@ -386,6 +394,23 @@ int main(int argc, char *argv[])
> > > >         page_idle_fd =3D open("/sys/kernel/mm/page_idle/bitmap", O_=
RDWR);
> > > >         __TEST_REQUIRE(page_idle_fd >=3D 0,
> > > >                        "CONFIG_IDLE_PAGE_TRACKING is not enabled");
> > > > +       if (warn_on_too_many_idle_pages =3D=3D -1) {
> > > > +#ifdef __x86_64__
> > > > +               if (this_cpu_has(X86_FEATURE_HYPERVISOR)) {
> > > > +                       printf("Skipping idle page count sanity che=
ck, because the test is run nested\n");
> > > > +                       warn_on_too_many_idle_pages =3D 0;
> > > > +               } else
> > > > +#endif
> > > > +               if (is_numa_balancing_enabled()) {
> > > > +                       printf("Skipping idle page count sanity che=
ck, because NUMA balance is enabled\n");
> > > > +                       warn_on_too_many_idle_pages =3D 0;
> > > > +               } else {
> > > > +                       warn_on_too_many_idle_pages =3D 1;
> > > > +               }
> > > > +       } else if (!warn_on_too_many_idle_pages) {
> > > > +               printf("Skipping idle page count sanity check, beca=
use this was requested by the user\n");
> >
> > Eh, I vote to omit this.  The sanity check is still there, it's just de=
graded to
> > a warn.  I'm not totally against it, just seems superfluous and potenti=
ally confusing.
>=20
> I agree, it's not adding much.
>=20
> Separately: I've finished the MGLRU version of this test. It uses
> MGLRU if it is available, and marking pages as idle is much faster
> when using it. If MGLRU is enabled but otherwise not usable, the test
> fails, as the idle page bitmap is no longer usable for this test.
>=20
> I'm happy to post a new version of Maxim's patch with the MGLRU
> patches too, Maxim, if you're okay with that.

