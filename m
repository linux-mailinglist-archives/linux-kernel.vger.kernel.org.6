Return-Path: <linux-kernel+bounces-232666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE8C91AC85
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52CD287FB8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3181993B9;
	Thu, 27 Jun 2024 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nm8ReZVM"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF4815278F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505407; cv=none; b=F54/ZSq9AkylPmprTr57e8HPu0N8Ga7TFCX1vk5qS0IuMOqmbCqsY1hdg7dTucyhtcka/2Zg9LJoNKjtFDUrOIUShlNM8XIv+YGf4/6tkpIhfQ+7DaUeaC+9obGO5JfXc3Too0OJcL3EhsgWGDkakxH1GIpN3llnTjIaSyM8iek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505407; c=relaxed/simple;
	bh=aY2PaVLVAy4wf9fthQf4/bjN+kKjwYAjEWn7CBsi+Ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ak7ONrMEEMIiU+/s4JpI20F/pgAPsRzfI56Vm1cNKkyQ6F6CZ40IKQYjAIfm8D5U/ztvDtYUj+zAxbbH+w0y1LwdWUq/WePrOstIvK6177qFddjY8faLUobLqRSyPq4p80w1w85ErPpzi/qlhsf4Kx5fAz2zuYwXXmCy8JobFDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nm8ReZVM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-424a30255d3so65455e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 09:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719505404; x=1720110204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2k1lfarqt/tldAQI4sIeBi43+DAejgtVN0jX6gZpQ8M=;
        b=Nm8ReZVMectuyh3y1z2muHLZXLU65oHMJqCPt7PfNP4wW7xjfUH1WR6h+VBkmjKXV5
         D72KDmvJrEo3NMmCbZq6odZho7B29xAlVKOnT0W0dXginiUXw9SHfsfk3AZOSrslHI4k
         WiLuWX05j0Sc8OxLgVJj3IJgAS139bdQFzJGRVIJFccmU74/Airumrv2tSQ6GmLPsGqH
         X7iHM05zOjT3Dx9yEsJzdfnJRCzl3r11Kmk5KmkgBA+RtXZusq+Pjz/Ey6n2dc1y/1JV
         /8VBM2gM2hKUmkq40v7F47d5Orp3rbtgmNDY60WfgXV1Ju+Vrd5yVgIplvj4hpr5DQcn
         3XUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719505404; x=1720110204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2k1lfarqt/tldAQI4sIeBi43+DAejgtVN0jX6gZpQ8M=;
        b=lgp+/8DEiaGJ8egCQdZPTtfzCBmzWEpZcUbZpHCJ7RfQH2y1gxfFgt7DMKarY2MZPD
         KbWIZav4oJhEcVdIZYN8uZiFTjOreEEgzDXgSYAeM91Na0N+WKg7dW5aKmrEaaiOmd2U
         ZvwAVE8/zwXpVJwYhNyKpuKosDDadT15Bt0mJ1r5uhO2pMtKUuTmRHTCGUhBTtceQ0M8
         LiiZamsoxkuYwsFPer/Z2QpYRFVOsA1mMudoqT8QAPih/zS10beMaAkTrh7h66MMrm+W
         SzorEcOOduWBZUcTN61Aab8prxcPCBT49EHbGi0MNQXzu5dxrDsURLpaVrkZzVlgkmwa
         TgHg==
X-Forwarded-Encrypted: i=1; AJvYcCXAWF4/uyYZvwZBxm7rszhGmu3hM6+DFlye2QmbDDym93MToWYtQebFipX6k30V/8MXcTxGWvZKA7nlCJxw3HU2uGe5B0ZAK58E8oIb
X-Gm-Message-State: AOJu0YyKMVuBD7RUCn4y4rN3asa4DY5WDDi8qYChWefr/7YJelz8+rq9
	L/5uWAZ7fC26mKNuvrMw789YdHQpOHJlaehBjbDHCVhX/s4YFY+NPb8uBVL0LqGnNYM8h9BvRQ8
	BiyGkWWSZ498J3YqatrmzrOB5FktuCm2Omjam
X-Google-Smtp-Source: AGHT+IEsR7hWdnLYCcHuX2KdrH9UT2/vT8sYfMsLAaF2r+ttgkzQJ4oIzIQvUcsXUenQtr1IzbX9gj8YsYzTxP06zIA=
X-Received: by 2002:a05:600c:4f42:b0:424:a58e:31ff with SMTP id
 5b1f17b1804b1-42563ae477amr2177105e9.0.1719505404347; Thu, 27 Jun 2024
 09:23:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621134041.3170480-1-michael.roth@amd.com>
 <20240621134041.3170480-2-michael.roth@amd.com> <ZnwecZ5SZ8MrTRRT@google.com>
 <6sczq2nmoefcociyffssdtoav2zjtuenzmhybgdtqyyvk5zps6@nnkw2u74j7pu>
 <ZnxMSEVR_2NRKMRy@google.com> <fbzi5bals5rmva3efgdpnljsfzdbehg4akwli7b5io7kqs3ikw@qfpdpxfec7ks>
 <ZnxyAWmKIu680R_5@google.com> <87320ee5-8a66-6437-8c91-c6de1b7d80c1@amd.com> <Zn2GpHFZkXciuJOw@google.com>
In-Reply-To: <Zn2GpHFZkXciuJOw@google.com>
From: Peter Gonda <pgonda@google.com>
Date: Thu, 27 Jun 2024 10:23:12 -0600
Message-ID: <CAMkAt6pDVEk1rBKdpgif3geied3tc67GquJrqtBA+RsK+aaNoA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] KVM: SEV: Provide support for SNP_GUEST_REQUEST
 NAE event
To: Sean Christopherson <seanjc@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org, 
	pbonzini@redhat.com, jroedel@suse.de, ashish.kalra@amd.com, bp@alien8.de, 
	pankaj.gupta@amd.com, liam.merwick@oracle.com, 
	Brijesh Singh <brijesh.singh@amd.com>, Alexey Kardashevskiy <aik@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 9:35=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Jun 27, 2024, Tom Lendacky wrote:
> > On 6/26/24 14:54, Sean Christopherson wrote:
> > > On Wed, Jun 26, 2024, Michael Roth wrote:
> > >>> What about the host kernel though?  I don't see anything here that =
ensures resp_pfn
> > >>> isn't "regular" memory, i.e. that ensure the page isn't being concu=
rrently accessed
> > >>> by the host kernel (or some other userspace process).
> > >>>
> > >>> Or is the "private" memory still accessible by the host?
> > >>
> > >> It's accessible, but it is immutable according to RMP table, so so i=
t would
> > >> require KVM to be elsewhere doing a write to the page,
> > >
> > > I take it "immutable" means "read-only"?  If so, it would be super he=
lpful to
> > > document that in the APM.  I assumed "immutable" only meant that the =
RMP entry
> > > itself is immutable, and that Assigned=3DAMD-SP is what prevented hos=
t accesses.
> >
> > Not quite. It depends on the page state associated with the page. For
> > example, Hypervisor-Fixed pages have the immutable bit set, but can be
> > read and written.
> >
> > The page states are documented in the SNP API (Chapter 5, Page
> > Management):
>
> Heh, but then that section says:
>
>   Pages in the Firmware state are owned by the firmware. Because the RMP.=
Immutable
>                                                          ^^^^^^^^^^^^^^^^=
^^^^^^^^^
>   bit is set, the hypervisor cannot write to Firmware pages nor alter the=
 RMP entry
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   with the RMPUPDATE instruction.
>
> which to me very clearly suggests that the RMP.Immutable bit is what make=
s the
> page read-only.
>
> Can you ask^Wbribe someone to add a "Table 11. Page State Properties" or =
something?
> E.g. to explicitly list out the read vs. write protections and the state =
of the
> page's data (encrypted, integrity-protected, zeroed?, etc).  I've read th=
rough
> all of "5.2 Page States" and genuinely have no clue as to what protection=
s most
> of the states have.
>
> Ah, never mind, I found "Table 15-39. RMP Memory Access Checks" in the AP=
M.  FWIW,
> that somewhat contradicts this blurb from the SNP ABI spec:
>
>   The content of a Context page is encrypted and integrity protected so t=
hat the
>   hypervisor cannot read or write to it.
>
> I also find that statement confusing.  IIUC, the fact that the Context pa=
ge is
> encrypted and integrity protected doesn't actually have anything to do wi=
th the
> host's ability to access the data.  The host _can_ read the data, but it =
will get
> ciphertext.  But the host can't write the data because the page isn't HV-=
owned.
>
> Actually, isn't the intregrity protected part wrong?  I thought one of th=
e benefits
> of SNP vs. ES is that the RMP means the VMSA doesn't have to be integrity=
 protected,
> and so VMRUN and #VMEXIT transitions are faster because the CPU doesn't n=
eed to do
> as much work.

The statement is fairly vague so its a bit confusing that the
encryption scheme on the Context page doesn't include integrity. In
reality the encryption is AES-XTS with a physical address tweak so no
integrity. The integrity comes purely from the RMP with SNP, but it's
still integrity protected right? So I don't think that part is wrong.

