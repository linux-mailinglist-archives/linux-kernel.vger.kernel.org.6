Return-Path: <linux-kernel+bounces-392924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7B29B99B0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991CF1C21EDA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554881E32A4;
	Fri,  1 Nov 2024 20:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s1+gWCx7"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50511E2604
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 20:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730494422; cv=none; b=Ant3ZyLdv6W8/R1b2u5Av4Q9oIJC2TG5jSWnG/3M9oPwgqgN2SciRfYEXw2dTvesy5+86UySmJvxpwUhFPT6TbhWpBUv1JaHOx94T6Txj2CECa453aTCCjn5Px4/ZgDY5AR+6vzEZs8ekhMT9nVUt5iGtaUH3OPZoU5qswHbeT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730494422; c=relaxed/simple;
	bh=YhxBh8Iax95XN2vr+xnyoQlastBvm7la0Lczo0OzpQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TaRaUjiJ9HdBAHr4xOMJ/MASkJkOkGSFnjfAbIE1Wx6DTkcr5CiN+FpE5IGm7EAVF0Ucpo6AeMzCHSu2Oizl+7P5Kx85tti4igWQ86ioK/3i32YxNu4g5K0/MRM7bkWSG6+DhrwBqRGXFbeFQ0pxp27fXmNPQKbLqjMpqDc8k8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s1+gWCx7; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c96b2a10e1so3382034a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 13:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730494419; x=1731099219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58tht0yElv8TtI+sAULnDvoOIpdA327LXw1TPAfTplE=;
        b=s1+gWCx7vatBiN++vFbDvqLiCeEinZHUNu1iV1j1hQSwastn77qvwQgs0gGeW8vlYz
         xBL9p1eD4K9AjRZsZd2tJEey0DRFgfTOBZRyhv/hOFjO3DbYgHRNjABqlHuJVzWT6Owb
         IQwHC50qJAEU9dkvUMYR4iK64Xf3MqSh4EEeJ8aKXyg4N7ysCbSZ5Xfs6Daod+t68hBo
         RrezWrou8E1k4mFzfPUag550ZG4Y1qAd+t3Uc2OPhVfLW77aOrAuLo3UjzpawXEt/fa8
         FhZvAHcIkS8M+DEVTnFvURSgdNWlPNdns+YZ4fViEeGgHRIwerb8JYCnO5YEXuQV15hE
         DAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730494419; x=1731099219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58tht0yElv8TtI+sAULnDvoOIpdA327LXw1TPAfTplE=;
        b=coGYZ1WUfZBD8mp+rSUfKfN9p4M7UBpFMnwVen8lGNnJ0oUWeUZN9r0tDzsHcTMNnb
         f7uqtPHNpJQcKB/ze3YVgcds3/KUjxoMJWuOm7/7ycNgn47b7N8z4ujxzzqm+KYlS/gQ
         QZ6BmD0WTIgVTCRoZCN+KUBAz6+/XZ+jvFRYROKxwLiuNybt6+B7p5psipuH2Xm8nwhz
         O7flWpdZoL4aFf48TqCguwtMZAM+uJUWVWdWmrPAqq3enexvBmXoP1DWnqbFGP9y/q0w
         XtvSnXmPS1D9NsX3/bzppCHQdP2oCxwC05Bs2J7irl4uVccnNd945ws7GBR4zbIu+BsN
         t3aw==
X-Forwarded-Encrypted: i=1; AJvYcCUnbNNozP1C6oFNfwNzhS9oU5XacW22s1oVnPRHRyprWJnU+iqBT5V5c6iXUHX1hrz6Qmbb7ySiIuCjdN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL0EcPEQyUFn9O/Q/HISG3ILW4RKnDYgMN+Myp5JaVsyvu20zo
	HH458LrNKkrLlbW7J6AeeXR/XSvknLK/sr808ht2MLc4obY3z5IZTig99AiYQ5btaStHQPil6k2
	XIlbf7JMe71Lt7IQ7YxNGcvEfdPGVoNoVduLb
X-Google-Smtp-Source: AGHT+IE4TWdxH1MLmqqXHDxQAw+ZDcpavLufUykLmmX4/YLQSUoEUsRYxXg3C+icr7ZlE2NhvH0m2iLVncVh8fgUUXo=
X-Received: by 2002:a17:907:7211:b0:a9a:ad8:fc56 with SMTP id
 a640c23a62f3a-a9de6167c81mr2142334766b.44.1730494419041; Fri, 01 Nov 2024
 13:53:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621134041.3170480-1-michael.roth@amd.com>
 <20240621134041.3170480-5-michael.roth@amd.com> <ZnwkMyy1kgu0dFdv@google.com>
 <r3tffokfww4yaytdfunj5kfy2aqqcsxp7sm3ga7wdytgyb3vnz@pfmstnvtuyg2>
 <Zn8YM-s0TRUk-6T-@google.com> <r7wqzejwpcvmys6jx7qcio2r6wvxfiideniqmwv5tohbohnvzu@6stwuvmnrkpo>
 <f8dfeab2-e5f2-4df6-9406-0aff36afc08a@linux.intel.com> <CAAH4kHZ-9ajaLH8C1N2MKzFuBKjx+BVk9-t24xhyEL3AKEeMQQ@mail.gmail.com>
 <Zx_V5SHwzDAl8ZQR@google.com>
In-Reply-To: <Zx_V5SHwzDAl8ZQR@google.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Fri, 1 Nov 2024 13:53:26 -0700
Message-ID: <CAAH4kHaOy0s93vp96-ZeX3PykCv_XsGM3z36=Fr1dEADsctMrg@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] KVM: Introduce KVM_EXIT_COCO exit type
To: Sean Christopherson <seanjc@google.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org, 
	pbonzini@redhat.com, jroedel@suse.de, thomas.lendacky@amd.com, 
	pgonda@google.com, ashish.kalra@amd.com, bp@alien8.de, pankaj.gupta@amd.com, 
	liam.merwick@oracle.com, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Chao P Peng <chao.p.peng@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 11:20=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Fri, Sep 13, 2024, Dionna Amalie Glaze wrote:
> > We can extend the ccp driver to, on extended guest request, lock the
> > command buffer, get the REPORTED_TCB, complete the request, unlock the
> > command buffer, and return both the response and the REPORTED_TCB at
> > the time of the request.
>
> Holding a lock across an exit to userspace seems wildly unsafe.

I wasn't suggesting this. I was suggesting adding a special ccp symbol
that would perform two sev commands under the same lock to ensure we
know the REPORTED_TCB that was used to derive the VCEK that signs an
attestation report in the MSG_REPORT_REQ guest request. We use that
atomicity to be sure that when we exit to user space to request
certificates that we're getting the right version certificates.

>
> Can you explain the race that you are trying to close, with the exact "ba=
d" sequence
> of events laid out in chronological order, and an explanation of why the =
race can't
> be sovled in userspace?  I read through your previous comment[*] (which I=
 assume
> is the race you want to close?), but I couldn't quite piece together exac=
tly what's
> broken.

1. the control plane delivers a firmware update. Current TCB version
goes up. The machine signals that it needs new certificates before it
can commit.
2. VM performs an extended guest request.
3. KVM exits to user space to get certificates before getting the
report from firmware.
4. [what I understand Michael Roth was suggesting] User space grabs a
file lock to see if it can read the cached certificates. It reads the
certificates and releases the lock before returning to KVM.
5. the control plane delivers the certificates to the machine and
tells it to commit. The machine grabs the certificate file lock, runs
SNP_COMMIT, and releases the file lock. This command updates both
COMMITTED_TCB and REPORTED_TCB.
6. KVM asks firmware to complete the MSG_REPORT_REQ request, but it's
a different REPORTED_TCB.
7. Guest receives the wrong certificates for certifying the report it
just received.

The fact that 4 has to release the lock before getting the attestation
report is the problem.
If we instead get the report and know what the REPORTED_TCB was when
serving that request, then we can exit to user space requesting the
certificates for the report in hand.
A concurrent update can update the reported_tcb like in the above
scenario, but it won't interfere with certificates since the machine
should have certificates for both TCB_VERSIONs to provide until the
commit is complete.

I don't think it's workable to have 1 grab the file lock and for 5 to
release it. Waiting for a service to update stale certificates should
not block user attestation requests. It would make 4's failure to get
the lock return VMM_BUSY and eventually cause attestations to time out
in sev-guest.

>
> [*] https://lore.kernel.org/all/CAAH4kHb03Una2kcvyC3W=3D1ZfANBWF_7a7zsSmW=
hr_r9g3rCDZw@mail.gmail.com



--=20
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

