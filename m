Return-Path: <linux-kernel+bounces-577548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02160A71E91
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869421795FF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D397C253340;
	Wed, 26 Mar 2025 18:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xz8HToQ+"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DE124EAB0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 18:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743014507; cv=none; b=fs3M5e46wB5CflVUrKlxmRSmEKqsMooX7Fn3g716Ga1IbGMY2k8nQZ4Cn8zvxXrCZ9a5Qbl1++RzyorniwtaW0zZH5j0igDAseG3I5Wj7yfN7EGXLoQUXiy9iTRgRBhZNHad/vvIxbG2Ail3AegnTi21TYcqB9dihcuSvBP+ixk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743014507; c=relaxed/simple;
	bh=VVc2l+RicUNkNGY2b16Zifrn/ayX0O/xBaNwcPR177s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bUJ+aFQjU3E9diFjwfnBD5viKzy77DTScWZ8nf/d56TCdukTgDv5TUxW/ciAayqHVjHlV44REC4p7fp7K6K1KIMg/tn+LBaTCpKRySS+5o9lsEX1wiaPFYLAVOICW6xEunwSKt5SdcpDSQYJwCYlWxUv4JQHeU0tfH2AhArzN7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xz8HToQ+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-301bbe9e084so270444a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 11:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743014504; x=1743619304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0rQ7XUfLkQfGZ5vjukC+h9cixCqTMdpfEOutTgyqNI=;
        b=xz8HToQ+ylbG0V6i48ssIeX9WI/dVoFrhOeEvWWshavZQq5x+FsNpg67X01+6cK/QG
         gDsmKDWZqwLD+2mhpUGNTfCjwfqM3rnVq86um8iJ64gsFgPOuJcJUogCQrH+ljlTJEM4
         YY7E2PZaf/om9R1m5pKq7/TsEzJPfXdwHByj1107orAeyn63iDnAwgzZJ8o0y6fOeQQ8
         n8bvwOcZ/ElfXox5msnNrP9xliL/i0J3u/gTkTf0Bfa3y/8pDBNmb6xMyj0i2jL4ASOD
         jywiNyr7RXz8tSoeMOLa7kreTBV2vEGmU2LTfMgQTkf5DLEdrUFpirlrNtYRrdv48kQB
         bdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743014504; x=1743619304;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b0rQ7XUfLkQfGZ5vjukC+h9cixCqTMdpfEOutTgyqNI=;
        b=nYSsB3i+Tl84YrKw9brvRpiVpZS0jEWKCHSy5UWonVeCj5nsFCh61WWW+gRwhC4QZt
         njyqWUjwuYansWFKm5GucNo+5E1bqU3Efv36Up8JLCNIS2brhj5VVmuGFXgy6Yrzw00y
         iqv8I9LuwPmRGhVRWuBbLOdq5LshSpVpgOaKZXRAEPUhLD+s6pZkwXFJH1NLtkMsqE7f
         sLOHQfM+pUAFezIv3x0hA4GrM5nZGkL4ogMalUiNFKbp8+9abI5yS9rwGdx1uti44qdt
         yx6JYGTemISWOaGt41RDxHeBXCbXDaTClxxQnu73urqxRNx0MW9XrNu8CdKC4GTTG7Og
         Kcqg==
X-Forwarded-Encrypted: i=1; AJvYcCVrwsi6JDjEewMpADpMDl9wyMlpIendFwUEZChOhb40Sc89/nAewqHuoDS16QOmVH723mdAx6a4AOlIKJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz20ZEayd3PEooS+imZsmvkWrjD3FzYM2oKrc06AnRFz9RzmNu6
	bXlj4pq8fFbKvS3JBeuFLXsQ3yUpGfxMR0JYwjWAV0r0ZvcDdB2ts/ngOqYhIbORvaE8pi3ybfT
	ulg==
X-Google-Smtp-Source: AGHT+IGYOoK6Qcw78W9ZnM4jh2jTBVQGR9cWfoA9Lc2F9ro2+49zKJCs1PFrziVBd1fP1tMWosQcGl/OD1k=
X-Received: from pjl13.prod.google.com ([2002:a17:90b:2f8d:b0:2ea:46ed:5d3b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c106:b0:2ff:6aa6:47a3
 with SMTP id 98e67ed59e1d1-303a9171aa0mr1173178a91.25.1743014504284; Wed, 26
 Mar 2025 11:41:44 -0700 (PDT)
Date: Wed, 26 Mar 2025 11:41:42 -0700
In-Reply-To: <CADrL8HWrgbV+coEod_EUnvG27HX3WtJDMua3FPiReCRCtXaNhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250325015741.2478906-1-mlevitsk@redhat.com> <20250325015741.2478906-3-mlevitsk@redhat.com>
 <CADrL8HWrgbV+coEod_EUnvG27HX3WtJDMua3FPiReCRCtXaNhw@mail.gmail.com>
Message-ID: <Z-RKZsQngjEgcfVU@google.com>
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

On Tue, Mar 25, 2025, James Houghton wrote:
> On Mon, Mar 24, 2025 at 6:57=E2=80=AFPM Maxim Levitsky <mlevitsk@redhat.c=
om> wrote:
> >
> > Add an option to skip sanity check of number of still idle pages,
> > and set it by default to skip, in case hypervisor or NUMA balancing
> > is detected.
> >
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>=20
> Thanks Maxim! I'm still working on a respin of this test with MGLRU
> integration, like [1]. Sorry it's taking me so long. I'll apply my
> changes on top of yours.
>=20
> [1]: https://lore.kernel.org/kvm/20241105184333.2305744-12-jthoughton@goo=
gle.com/
>=20
> > ---
> >  .../selftests/kvm/access_tracking_perf_test.c | 33 ++++++++++++++++---
> >  .../testing/selftests/kvm/include/test_util.h |  1 +
> >  tools/testing/selftests/kvm/lib/test_util.c   |  7 ++++
> >  3 files changed, 37 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/=
tools/testing/selftests/kvm/access_tracking_perf_test.c
> > index 3c7defd34f56..6d50c829f00c 100644
> > --- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
> > +++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
> > @@ -65,6 +65,8 @@ static int vcpu_last_completed_iteration[KVM_MAX_VCPU=
S];
> >  /* Whether to overlap the regions of memory vCPUs access. */
> >  static bool overlap_memory_access;
> >
> > +static int warn_on_too_many_idle_pages =3D -1;
> > +
> >  struct test_params {
> >         /* The backing source for the region of memory. */
> >         enum vm_mem_backing_src_type backing_src;
> > @@ -184,11 +186,10 @@ static void mark_vcpu_memory_idle(struct kvm_vm *=
vm,
> >          * are cached and the guest won't see the "idle" bit cleared.
> >          */
> >         if (still_idle >=3D pages / 10) {
> > -#ifdef __x86_64__
> > -               TEST_ASSERT(this_cpu_has(X86_FEATURE_HYPERVISOR),
> > +               TEST_ASSERT(warn_on_too_many_idle_pages,
>=20
> I think this assertion is flipped (or how warn_on_too_many_idle_pages
> is being set is flipped, see below).
>=20
> >                             "vCPU%d: Too many pages still idle (%lu out=
 of %lu)",
> >                             vcpu_idx, still_idle, pages);
> > -#endif
> > +
> >                 printf("WARNING: vCPU%d: Too many pages still idle (%lu=
 out of %lu), "
> >                        "this will affect performance results.\n",
> >                        vcpu_idx, still_idle, pages);
> > @@ -342,6 +343,8 @@ static void help(char *name)
> >         printf(" -v: specify the number of vCPUs to run.\n");
> >         printf(" -o: Overlap guest memory accesses instead of partition=
ing\n"
> >                "     them into a separate region of memory for each vCP=
U.\n");
> > +       printf(" -w: Skip or force enable the check that after dirtying=
 the guest memory, most (90%%) of \n"
> > +              "it is reported as dirty again (0/1)");
> >         backing_src_help("-s");
> >         puts("");
> >         exit(0);
> > @@ -359,7 +362,7 @@ int main(int argc, char *argv[])
> >
> >         guest_modes_append_default();
> >
> > -       while ((opt =3D getopt(argc, argv, "hm:b:v:os:")) !=3D -1) {
> > +       while ((opt =3D getopt(argc, argv, "hm:b:v:os:w:")) !=3D -1) {
> >                 switch (opt) {
> >                 case 'm':
> >                         guest_modes_cmdline(optarg);
> > @@ -376,6 +379,11 @@ int main(int argc, char *argv[])
> >                 case 's':
> >                         params.backing_src =3D parse_backing_src_type(o=
ptarg);
> >                         break;
> > +               case 'w':
> > +                       warn_on_too_many_idle_pages =3D
> > +                               atoi_non_negative("1 - enable warning, =
0 - disable",
> > +                                                 optarg);
>=20
> We still get a "warning" either way, right? Maybe this should be
> called "fail_on_too_many_idle_pages" (in which case the above
> assertion is indeed flipped). Or "warn_on_too_many_idle_pages" should
> mean *only* warn, i.e., *don't* fail, in which case, below we need to
> flip how we set it below.


Agreed.  I like the "warn" terminology,  Maybe this?

	printf(" -w: Control whether the test warns or fails if more than 10%\n"
               "     of pages are still seen as idle/old after accessing gu=
est\n"
               "     memory.  >0 =3D=3D warn only, 0 =3D=3D fail, <0 =3D=3D=
 auto.  For auto\n"
               "     mode, the test fails by default, but switches to warn =
only\n"
               "     if NUMA balancing is enabled or the test detects it's =
running\n"
               "     in a VM.");

And let the user explicitly select auto:

		case 'w':
			warn_only =3D atoi_paranoid(optarg);
			break;

Then the auto resolving works as below, and as James pointed out, the asser=
t
becomes

		TEST_ASSERT(!warn_only, ....);

>=20
> > +                       break;
> >                 case 'h':
> >                 default:
> >                         help(argv[0]);
> > @@ -386,6 +394,23 @@ int main(int argc, char *argv[])
> >         page_idle_fd =3D open("/sys/kernel/mm/page_idle/bitmap", O_RDWR=
);
> >         __TEST_REQUIRE(page_idle_fd >=3D 0,
> >                        "CONFIG_IDLE_PAGE_TRACKING is not enabled");
> > +       if (warn_on_too_many_idle_pages =3D=3D -1) {
> > +#ifdef __x86_64__
> > +               if (this_cpu_has(X86_FEATURE_HYPERVISOR)) {
> > +                       printf("Skipping idle page count sanity check, =
because the test is run nested\n");
> > +                       warn_on_too_many_idle_pages =3D 0;
> > +               } else
> > +#endif
> > +               if (is_numa_balancing_enabled()) {
> > +                       printf("Skipping idle page count sanity check, =
because NUMA balance is enabled\n");
> > +                       warn_on_too_many_idle_pages =3D 0;
> > +               } else {
> > +                       warn_on_too_many_idle_pages =3D 1;
> > +               }
> > +       } else if (!warn_on_too_many_idle_pages) {
> > +               printf("Skipping idle page count sanity check, because =
this was requested by the user\n");

Eh, I vote to omit this.  The sanity check is still there, it's just degrad=
ed to
a warn.  I'm not totally against it, just seems superfluous and potentially=
 confusing.

