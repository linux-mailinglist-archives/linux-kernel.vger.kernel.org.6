Return-Path: <linux-kernel+bounces-520844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E49A3B001
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 04:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130211749F2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 03:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CC419B5B8;
	Wed, 19 Feb 2025 03:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xmETNANS"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CEA13CA8A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 03:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739935298; cv=none; b=AQL25FXkh9SWZUb8Y1ekfWEtREwqhxFN19EhOuIIUFQf/DX9Rgj88Db2odDhMk6VgoVsWDuHrEeipYtqe62lDZRy21n9DKI6gJnjE7byd/nZXKxy6y0XDoFsq5Q3yNz38m/fzxRtamG/4uHq3T90akKKynykUM2sXKru3YvYY90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739935298; c=relaxed/simple;
	bh=zQZ72noBMjWgnUpzvtmi4E18hq/KrvTADHps9Ta+qv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ColKSaDwlwnQKxiNiQkGpHHoMFKns6/cizOVd+gwQfCzv5L4U90+K4nJxZZNZKUgz0pNyH8L/ERwVQaHzbWeNewlJEyu9rQVyj0SlSjf4wlqTpC36s98kw+OdVj4H9K7zEmAoT9fgDLgU9sSgqN5ls1xWfaDiqynb+OBOi+c1sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xmETNANS; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5ded6c31344so7693389a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 19:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739935295; x=1740540095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQZ72noBMjWgnUpzvtmi4E18hq/KrvTADHps9Ta+qv0=;
        b=xmETNANSkuNDsxcLroPQqmRUkxlMD8bLtJp72WroSTVmdMaI4VJVG+zVICLTl/c5EE
         G/enS7jNdMtLZagoow49w6Zxs4rydYqU0MRRZJrLazKlIid3muxb+AvR1KS9xGA5KYWu
         buYOpZ+9UTbhXC6d1yYTlQhkaOtgo1Aqc3DmpEk9jh6ZSViGm7c0Xivvt9nOlLCUaQs0
         wsOBazxwmwkwnGPv9+O8KGNMEDKMfXpMjdPvjUxtV+dNlOUOaKHN0+0MEP9b2RGWUbPG
         ujWHo5by84WZNckscxMlsRyYiXOYepMA2Mv0I8cjKiccTZVi5EHGWTJ4ZmH1VyoGeke7
         Up5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739935295; x=1740540095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQZ72noBMjWgnUpzvtmi4E18hq/KrvTADHps9Ta+qv0=;
        b=NWog3g7oBko+N6et/aqms5Qnltvop7tNN5Unoc4kecYFo2a6XMZdxScV3rsteyROxS
         RUsMpePXu1VLh4GJ3oP+jrmup82wjI07puzbiatI0KQLAzFIXCFqsGTURTjOL2KIWfJR
         gOO+lD6uYCqsOfcEjA8pesY4EkMyCapGzt2QUwNKysmlc1EXmTwT2AgrKn+ufOrdtN3F
         +0kdXIqLuAsgmTL4EcTV8np8Lsh26bwDFkW/t8d4ogIfDoNBAIOhN3Z/Xm1SsLLPvC3D
         O34IVxrR2Kqb5Ze/XfeZv+SiHppKoZLgbr9c+PSSezxA93iXjZSYkDUbVbjCeNLTaOc1
         F6bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbMc4gW2EkHtW8i/tJNR1QZwimpr1ot21pyjs9XZWlpNaF4oFQCNp8TkJFVpMspuk2SCNpC9Go+hhquag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC8jGFQGdTBByGTMTUG4RxCmQZDIYXR2T+2zwTDpYYrPHTx9f8
	/n/E+bIVmsAtNJI9upvrjGB0bvLd4utmyH3OxH6MUuylalb63EmJBK5RAWKHSbDvXka7QCFOv6K
	IUZQgNbYbKz22MoJwqGsSUFO8oSCAikma8LWo
X-Gm-Gg: ASbGncvrt9fnlhE/dw3Idu/7KANkLAoZqJC5otP/qqZcTzyKavMFTTogCn0jglXYJig
	4wnV3Xtbpvxj4nE/8KJnYBzdWKRX36mZ85lDTnd8f3z7qQ9n9jtHVC02+VlA0/2vF/etIDnyY
X-Google-Smtp-Source: AGHT+IEnGbryBeBhChWrRvIMKHLS/nYVH9GuCmrhXCKrLhI46whs35vEsS7hGUKNaTHSWl6ye+CZMmasW6Vxzw7o0U4=
X-Received: by 2002:a05:6402:35cb:b0:5dc:caab:9447 with SMTP id
 4fb4d7f45d1cf-5e036063e6amr41083363a12.18.1739935295010; Tue, 18 Feb 2025
 19:21:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
 <15c69d57-4ffb-4ea1-8cbc-0ba6d3d7b14f@intel.com> <be7e3c9d-208a-4bda-b8cf-9119f3e0c4ce@intel.com>
 <015cdddb-7f74-4205-af8a-b15cad7ddc22@intel.com> <d8f3eb33-d902-4391-adc7-005e4895b471@intel.com>
 <c7894df2-2b27-4f67-b428-3eca312503f9@intel.com> <c2cf2184-7753-454e-ac99-8c4f3c9c3d16@intel.com>
 <01fc0997-a0e7-4086-b0aa-67b4a51b328a@intel.com> <12ed2ab1-e97d-4a20-8370-8c60cabffc77@intel.com>
 <ab2036d5-5b6f-4fa9-995a-fba63c0a5209@linux.intel.com> <f4d344de-70c2-4fd4-bb18-2912cf0f3f98@intel.com>
 <CAAH4kHYq7_3vLXQaCA7iKF+mC5Pg0cn-1FsB-iCbN7Jim9a-OQ@mail.gmail.com> <650b6236-50d3-4932-b5bc-056fd29c93a7@intel.com>
In-Reply-To: <650b6236-50d3-4932-b5bc-056fd29c93a7@intel.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Tue, 18 Feb 2025 19:21:23 -0800
X-Gm-Features: AWEUYZkxt4Uz_DEgnqnT-wIOC0NHjgfy5WtvAXnbdvc8enIGlu1IN6n1oU029Q4
Message-ID: <CAAH4kHYye2ApqYb3GmHSt2Ge4B1m55mA54Ch-f1RCzh3GZuHOw@mail.gmail.com>
Subject: Re: [PATCH 0/4] tsm: Unified Measurement Register ABI for TVMs
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dan Middleton <dan.middleton@linux.intel.com>, "Xing, Cedric" <cedric.xing@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 4:41=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 2/18/25 15:57, Dionna Amalie Glaze wrote:
> >> If there are actual end users who care about this, it would be great t=
o
> >> see their acks on it as well.
> >>
> > We would like to have this for Google Confidential Space and Kubernetes=
 Engine.
> >
> > Acked-by: Dionna Glaze <dionnaglaze@google.com>
>
> Great! Thanks for chiming in. Can you talk for a second, though, about
> why this is useful and how you plan to use it? Is it for debugging?

Confidential space on SEV depends on the hypervisor-provided vTPM to
provide remotely attestable quotes of its PCRs, and the corresponding
event logs.
https://github.com/google/go-tpm-tools/blob/main/launcher/agent/agent.go#L9=
7

On TDX and ARM CCA (maybe RISC-V CoVE someday), we don't want to have
to depend on the vTPM.
There are runtime measurement registers and the CCEL.
When we have a sysfs interface to extend these registers, it makes the
user space evidence manager's life easier.
When Dan Williams forced the issue about configfs-tsm, we were told
that it is bad for the kernel to have many platform-specific
interfaces for attestation operations.
This patch series is a way to unify behind the tsm.

As for the ability to read the registers through sysfs instead of just
extend-on-write, that's not something Confidential Space depends on
specifically.
Our attestation policies are evaluated in a verification service
rather than on-node.

For on-node policy evaluation, for instance in kubectl, there is a
benefit to being able to generically read measurement registers that
have been extended generically to execute policy that a certain action
if a measurement register isn't an exact expected value.
This is not far-fetched, since it is used for confidential containers,
and is being discussed for kubernetes engine as a way to poison an
instance when an ssh session is terminated for a human operator.

To have that same capability without a generic read interface, we need
to stuff kubectl with quote parsers of every attestation technology.

Hope that helps.
--=20
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

