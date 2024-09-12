Return-Path: <linux-kernel+bounces-325766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3616E975DEC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ABEA1C2260F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880C063CB;
	Thu, 12 Sep 2024 00:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YuLrVO0d"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459EE53AC
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726100403; cv=none; b=ivYbAQkI/+ZigRS57u8YSVXl+afbg3ji6g2CGMj9Aah0RmT0sXa2jgVMBqDcHLDzCR6aSF1CvJ9qYzbd1JetX0w+vXR77+Q7wXdG77hzXY/HngfWPgFGf0PjtOgsOXMzGvj51OkRsZPvhU3IA+oJY9Kp1FGN+FNQtWmsxYSkQmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726100403; c=relaxed/simple;
	bh=7ZHE6rnn9Pm63u68EhYfwOZZSNVSjSnrzypykdDVVhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQzYDPOYYQMabWhD7wFE1v4j73vYMztEfpaeqV04TRlim/ENvsT0+M0IHL0R2rRR0jcN79tAbTiqMSDOFcwmSNzXakjZpffj68EENcKxRgmtHtmtIAfD3Sb4Yzu7x1WVhYHjV4GG4dk9iZY0EMLU/CSlGMf6/U72GthRAkMgt7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YuLrVO0d; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6b747f2e2b7so3064327b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 17:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726100401; x=1726705201; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6gfaXOaocGV5N/sXdVJlpTgJOtMKxsPAOrOzp4Kg5Zo=;
        b=YuLrVO0dH2khkHl6aJ1TD1RsyaER2PgGB9TQe0qCLCa/osrq53Gk0ZZ0KwUIii955y
         rAnM4mv8eCEPESyCGx8n/o+BdqAKt9DspdZ3GuVOd/6Grlk9w7Yt9KnTFgYrK8LKYYpv
         NuAU3E+hR7O2KIsHckaAWqEEc5sW8u2huu2/2VQNtOgq93QhpG6rEO5XHajrryUAmEx9
         5x6RUCwHX4DTS4OlvJxp9asMzx7KZZxqtPS4LN8LcvXT6GI3R+lLcSjtwKB41jjKnUnk
         vKtc0souqsm5CQCGmbyMx2od6nsbl9VUUrumVfmyDX2wod7bo8M1TqQDowoNF2/ZT4Ri
         nMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726100401; x=1726705201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6gfaXOaocGV5N/sXdVJlpTgJOtMKxsPAOrOzp4Kg5Zo=;
        b=bGJyoqMp3tjW8Qv8rwS97GBxP4K08pggTPnBk+uMR9SktN1DIQtlsFuLDDp0VwVl7+
         IAjU1zDBz6McN59Yfc43kWv271uMShvJPMpFBP/c5tWsZ6JlzN6eLA1gI+9xfs6MLLOm
         u92d95DdTdkvVuPf9/8ZUD+D+2w7gcfxtpgCfrzp5vmZbd0f2Cekb0AWc79aMga4mPqM
         FUYfL7a6euvqy9YvXIpCrvCbsPEx/Bb80epc+qWDYV6SUgDe5WForSrrNhlyRa0/2j4E
         kl4z3xoKDu31JyJn4KLRjOXX1oloFbzfMKJGoTqBLbPAP5/H+0Cfk66sOQ/aWG4Ym0Po
         FTdA==
X-Forwarded-Encrypted: i=1; AJvYcCXKFrWdRfh6CooV8UjcuNGnQhPj3/h9RTHL4G4PLcqERU3KzGRo+OkE/i/ZmeLC9HVaA6CGSdZYoJsCifQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwykjSHCkgZ50zduswcNvFZ1P7HW/EHP6oIukhLMHru5hjykWLG
	XkQbAxFatHPoJ0EX1nJZ/YpNVZ93pO8nQzo16+WdnmVwJa8ayLqoMubtsLzKOXrX28SyK2ntRFU
	VxVS3bRVtkisNZiVBy4wjMW5+m+DAolJwwgxa
X-Google-Smtp-Source: AGHT+IFCSQW9OkhxWu5GixWfZA3Akz697w6Am0RhcKLgULCV/kD0mPJsOAT48WevjQEwyJGw4vOMbwN8aQtB8tw8odU=
X-Received: by 2002:a05:690c:ec8:b0:6db:b1d5:5116 with SMTP id
 00721157ae682-6dbb6add2fdmr14504987b3.9.1726100400935; Wed, 11 Sep 2024
 17:20:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911204158.2034295-1-seanjc@google.com> <20240911204158.2034295-14-seanjc@google.com>
In-Reply-To: <20240911204158.2034295-14-seanjc@google.com>
From: James Houghton <jthoughton@google.com>
Date: Wed, 11 Sep 2024 17:19:24 -0700
Message-ID: <CADrL8HW+hUNKPbaL7xYb0FEesB2t-AwAw07iOCDj8KHp0RwVpQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] KVM: selftests: Verify KVM correctly handles mprotect(PROT_READ)
To: Sean Christopherson <seanjc@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000003f3d950621e1110c"

--0000000000003f3d950621e1110c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 1:42=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Add two phases to mmu_stress_test to verify that KVM correctly handles
> guest memory that was writable, and then made read-only in the primary MM=
U,
> and then made writable again.
>
> Add bonus coverage for x86 and arm64 to verify that all of guest memory w=
as
> marked read-only.  Making forward progress (without making memory writabl=
e)
> requires arch specific code to skip over the faulting instruction, but th=
e
> test can at least verify each vCPU's starting page was made read-only for
> other architectures.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/mmu_stress_test.c | 104 +++++++++++++++++-
>  1 file changed, 101 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/mmu_stress_test.c b/tools/testin=
g/selftests/kvm/mmu_stress_test.c
> index 50c3a17418c4..c07c15d7cc9a 100644
> --- a/tools/testing/selftests/kvm/mmu_stress_test.c
> +++ b/tools/testing/selftests/kvm/mmu_stress_test.c
> @@ -16,6 +16,8 @@
>  #include "guest_modes.h"
>  #include "processor.h"
>
> +static bool mprotect_ro_done;
> +
>  static void guest_code(uint64_t start_gpa, uint64_t end_gpa, uint64_t st=
ride)
>  {
>         uint64_t gpa;
> @@ -31,6 +33,42 @@ static void guest_code(uint64_t start_gpa, uint64_t en=
d_gpa, uint64_t stride)
>                 *((volatile uint64_t *)gpa);
>         GUEST_SYNC(2);
>
> +       /*
> +        * Write to the region while mprotect(PROT_READ) is underway.  Ke=
ep
> +        * looping until the memory is guaranteed to be read-only, otherw=
ise
> +        * vCPUs may complete their writes and advance to the next stage
> +        * prematurely.
> +        *
> +        * For architectures that support skipping the faulting instructi=
on,
> +        * generate the store via inline assembly to ensure the exact len=
gth
> +        * of the instruction is known and stable (vcpu_arch_put_guest() =
on
> +        * fixed-length architectures should work, but the cost of parano=
ia
> +        * is low in this case).  For x86, hand-code the exact opcode so =
that
> +        * there is no room for variability in the generated instruction.
> +        */
> +       do {
> +               for (gpa =3D start_gpa; gpa < end_gpa; gpa +=3D stride)
> +#ifdef __x86_64__
> +                       asm volatile(".byte 0x48,0x89,0x00" :: "a"(gpa) :=
 "memory"); /* mov %rax, (%rax) */

I'm curious what you think about using labels (in asm, but perhaps
also in C) and *setting* the PC instead of incrementing the PC. Diff
attached (tested on x86). It might even be safe/okay to always use
vcpu_arch_put_guest(), just set the PC to a label immediately
following it.

I don't feel strongly, so feel free to ignore.



> +#elif defined(__aarch64__)
> +                       asm volatile("str %0, [%0]" :: "r" (gpa) : "memor=
y");
> +#else
> +                       vcpu_arch_put_guest(*((volatile uint64_t *)gpa), =
gpa);
> +#endif
> +       } while (!READ_ONCE(mprotect_ro_done));
> +
> +       /*
> +        * Only architectures that write the entire range can explicitly =
sync,
> +        * as other architectures will be stuck on the write fault.
> +        */
> +#if defined(__x86_64__) || defined(__aarch64__)
> +       GUEST_SYNC(3);
> +#endif

--0000000000003f3d950621e1110c
Content-Type: application/x-patch; name="labels.diff"
Content-Disposition: attachment; filename="labels.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_m0yjcx7b0>
X-Attachment-Id: f_m0yjcx7b0

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9tbXVfc3RyZXNzX3Rlc3Qu
YyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9tbXVfc3RyZXNzX3Rlc3QuYwppbmRleCBj
MDdjMTVkN2NjOWEuLmE3Y2NlZDVjM2U2NyAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMva3ZtL21tdV9zdHJlc3NfdGVzdC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2t2bS9tbXVfc3RyZXNzX3Rlc3QuYwpAQCAtMTYsOCArMTYsMTMgQEAKICNpbmNsdWRlICJndWVz
dF9tb2Rlcy5oIgogI2luY2x1ZGUgInByb2Nlc3Nvci5oIgogCisjaWYgZGVmaW5lZChfX3g4Nl82
NF9fKSB8fCBkZWZpbmVkKF9fYWFyY2g2NF9fKQorZXh0ZXJuIHZvaWQgKnNraXBfcGFnZTsKKyNl
bmRpZgorCiBzdGF0aWMgYm9vbCBtcHJvdGVjdF9yb19kb25lOwogCisKIHN0YXRpYyB2b2lkIGd1
ZXN0X2NvZGUodWludDY0X3Qgc3RhcnRfZ3BhLCB1aW50NjRfdCBlbmRfZ3BhLCB1aW50NjRfdCBz
dHJpZGUpCiB7CiAJdWludDY0X3QgZ3BhOwpAQCAtNDAsMTggKzQ1LDIxIEBAIHN0YXRpYyB2b2lk
IGd1ZXN0X2NvZGUodWludDY0X3Qgc3RhcnRfZ3BhLCB1aW50NjRfdCBlbmRfZ3BhLCB1aW50NjRf
dCBzdHJpZGUpCiAJICogcHJlbWF0dXJlbHkuCiAJICoKIAkgKiBGb3IgYXJjaGl0ZWN0dXJlcyB0
aGF0IHN1cHBvcnQgc2tpcHBpbmcgdGhlIGZhdWx0aW5nIGluc3RydWN0aW9uLAotCSAqIGdlbmVy
YXRlIHRoZSBzdG9yZSB2aWEgaW5saW5lIGFzc2VtYmx5IHRvIGVuc3VyZSB0aGUgZXhhY3QgbGVu
Z3RoCi0JICogb2YgdGhlIGluc3RydWN0aW9uIGlzIGtub3duIGFuZCBzdGFibGUgKHZjcHVfYXJj
aF9wdXRfZ3Vlc3QoKSBvbgotCSAqIGZpeGVkLWxlbmd0aCBhcmNoaXRlY3R1cmVzIHNob3VsZCB3
b3JrLCBidXQgdGhlIGNvc3Qgb2YgcGFyYW5vaWEKLQkgKiBpcyBsb3cgaW4gdGhpcyBjYXNlKS4g
IEZvciB4ODYsIGhhbmQtY29kZSB0aGUgZXhhY3Qgb3Bjb2RlIHNvIHRoYXQKLQkgKiB0aGVyZSBp
cyBubyByb29tIGZvciB2YXJpYWJpbGl0eSBpbiB0aGUgZ2VuZXJhdGVkIGluc3RydWN0aW9uLgor
CSAqIGdlbmVyYXRlIHRoZSBzdG9yZSB2aWEgaW5saW5lIGFzc2VtYmx5IHRvIGVuc3VyZSB3ZSBj
YW4gY29ycmVjdGx5CisJICogYWRqdXN0IHRoZSBQQyB1cG9uIGZhdWx0aW5nLgogCSAqLwogCWRv
IHsKIAkJZm9yIChncGEgPSBzdGFydF9ncGE7IGdwYSA8IGVuZF9ncGE7IGdwYSArPSBzdHJpZGUp
CiAjaWZkZWYgX194ODZfNjRfXwotCQkJYXNtIHZvbGF0aWxlKCIuYnl0ZSAweDQ4LDB4ODksMHgw
MCIgOjogImEiKGdwYSkgOiAibWVtb3J5Iik7IC8qIG1vdiAlcmF4LCAoJXJheCkgKi8KKwkJCWFz
bSB2b2xhdGlsZSgiLmdsb2JhbCBza2lwX3BhZ2U7IgorCQkJCSAgICAgIm1vdiAlMCwgKCUwKTsi
CisJCQkJICAgICAic2tpcF9wYWdlOjsiCisJCQkJICAgICA6OiAiciIgKGdwYSkgOiAibWVtb3J5
Iik7CiAjZWxpZiBkZWZpbmVkKF9fYWFyY2g2NF9fKQotCQkJYXNtIHZvbGF0aWxlKCJzdHIgJTAs
IFslMF0iIDo6ICJyIiAoZ3BhKSA6ICJtZW1vcnkiKTsKKwkJCWFzbSB2b2xhdGlsZSgiLmdsb2Jh
bCBza2lwX3BhZ2U7IgorCQkJCSAgICAgInN0ciAlMCwgWyUwXTsiCisJCQkJICAgICAic2tpcF9w
YWdlOjsiCisJCQkJICAgICA6OiAiciIgKGdwYSkgOiAibWVtb3J5Iik7CiAjZWxzZQogCQkJdmNw
dV9hcmNoX3B1dF9ndWVzdCgqKCh2b2xhdGlsZSB1aW50NjRfdCAqKWdwYSksIGdwYSk7CiAjZW5k
aWYKQEAgLTE3MCwxMCArMTc4LDEwIEBAIHN0YXRpYyB2b2lkICp2Y3B1X3dvcmtlcih2b2lkICpk
YXRhKQogCQlURVNUX0FTU0VSVF9FUShlcnJubywgRUZBVUxUKTsKICNpZiBkZWZpbmVkKF9feDg2
XzY0X18pCiAJCVdSSVRFX09OQ0UodmNwdS0+cnVuLT5rdm1fZGlydHlfcmVncywgS1ZNX1NZTkNf
WDg2X1JFR1MpOwotCQl2Y3B1LT5ydW4tPnMucmVncy5yZWdzLnJpcCArPSAzOworCQl2Y3B1LT5y
dW4tPnMucmVncy5yZWdzLnJpcCA9ICh2bV92YWRkcl90KSZza2lwX3BhZ2U7CiAjZWxpZiBkZWZp
bmVkKF9fYWFyY2g2NF9fKQogCQl2Y3B1X3NldF9yZWcodmNwdSwgQVJNNjRfQ09SRV9SRUcocmVn
cy5wYyksCi0JCQkgICAgIHZjcHVfZ2V0X3JlZyh2Y3B1LCBBUk02NF9DT1JFX1JFRyhyZWdzLnBj
KSkgKyA0KTsKKwkJCSAgICAgKHZtX3ZhZGRyX3QpJnNraXBfcGFnZSk7CiAjZW5kaWYKIAogCX0K
--0000000000003f3d950621e1110c--

