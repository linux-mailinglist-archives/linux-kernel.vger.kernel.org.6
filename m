Return-Path: <linux-kernel+bounces-325064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4165697546E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFCAA288935
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236383D984;
	Wed, 11 Sep 2024 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OAtrQOgb"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52726189F2D
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726062424; cv=none; b=pQfUxF3ufXN/iSb3hlQw8JC6YmAFirVZrONN4wVvJsALrOLuS2xvOL2Xq0noU1P2FPOghdXmKnEV/vqAxhT+z4t2cniHzwCLSLVS1HPzOWkzrg9yACpLDum9uBvEF/gEqEmt9XHu9bhEOLO30kmiGXD79kgDSHMI9glFecfJkg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726062424; c=relaxed/simple;
	bh=ho9oQn7t4oDhLOOdVuXLRab2tfDu9eCXOaLc0WoTS9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6lIhMWH9jCJgxVEAOedN9j9gVXnBlgxEep9WWZmL/wMvHNDjMHzYcCrfbEHCKDufLjL0HgUUt/ZB5q9NUCusmdsojMuTpr11/3HPPr8Mu2KOgSq/h5n/5akvUcTtb+Bbfl2HF8hylyxjoQpfjq+fu+NZFTpEYYn1nW2adfryIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OAtrQOgb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-205722ba00cso57911955ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726062421; x=1726667221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bt/M1JptLmddoUeUh/7A4/FrbLaTniu1lQms6Pg4KcU=;
        b=OAtrQOgbpiwpYoflpb8QKcjpt8DBd8qNPCLoihIgl8vPgjZjP0kxnXLQiRXTfr1slp
         tkNoOZVQBj8alecx4T8ye3x+1Cm+RkT6whwyaVAYy+QlCPidiJVnefGJTUeR2UxOMnsp
         nnpIu9LaJ97Wn1oC9VfbosaGVt5/GbxA+BUek+JQX7I5EWhuS062KiDYeHL8hThhkP/N
         tfBSWGNq9+EE6QWL5O7CMUxxVR5AkRcKQ+61sfL7Itm3vXvDhOnCisMQfLy8PlxdjuY0
         7h0AUksPDGzAngg8AxUW57hmAu44foXXHM7JKc2mqc5EUVKUC2FtsVfwCil9qz8sjyH7
         Rn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726062421; x=1726667221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bt/M1JptLmddoUeUh/7A4/FrbLaTniu1lQms6Pg4KcU=;
        b=QpjAO6hhC+JapqstD2IkNBqDoBEDE1OpxmoVqDekG3Nkw834zrRsQ6Al1ifWJ0jciV
         tvrA8GMRJ368BOr1nhzESHHT1hv5o76VyZkIuO2gSB1M6AnTeajp1dwP3qVUvwMkmRnA
         t9xPvFIkiLVi12YR0bbGvjtHB+Xji5pcf+55irGJC+pzbm1FhsHzsL2l6bpxECZ+UyIN
         5H3F6CdX0KVqWn2Uo4ZDRya3YMcWlCwIMi1S5MKV5/dvmd6Ak5tZyGoX9inwgNxxxfmH
         a+cxiUrAy3yO4wJZHwFLFv4hx2IqpMa69rXsew9f4N00wl6zfB2zIX6luUjF6QRyZ05v
         YLqA==
X-Forwarded-Encrypted: i=1; AJvYcCWfoeqMEFCf2ucr9vIpEwqDtM1jR6Tr/d8PriY5Zlrxn2PHOfERZQhXP/KOl/oLHIjLUVes7vRoqpiqPv0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1CSIG1sA5wwYR5GmgBlo8kijYrjrQW/KSi5/yZB9fBTShFO3u
	h1Ygzx/14YngTu5M4sPhgGvCDBCTz6H6CMVJGIBeJkFWm2Vpo5T8M6nIsGn3ZxWUJH+9AiWKwYY
	3lKcZ70d23d2NGk/OtZftmIzaytl9lu0XeRaE
X-Google-Smtp-Source: AGHT+IHWZafcxSnUn22lziE17wSn2AOoweP+lq5JT/3sniDrzP5zAwgMF2Mygr61bRdUtWNqOrxru23oQ9kP2brBLFQ=
X-Received: by 2002:a17:902:d502:b0:207:13a3:a896 with SMTP id
 d9443c01a7336-2074c63033emr71588075ad.23.1726062420932; Wed, 11 Sep 2024
 06:47:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
 <20240910170959.GA213064@myrica> <f6b0a1d2-c730-4b20-a8f3-afd9a7cf822a@intel.com>
 <14fc2ce22d224f05f4d382cd22f5242297e9fb86.camel@HansenPartnership.com>
In-Reply-To: <14fc2ce22d224f05f4d382cd22f5242297e9fb86.camel@HansenPartnership.com>
From: Qinkun Bao <qinkun@google.com>
Date: Wed, 11 Sep 2024 21:46:48 +0800
Message-ID: <CAOjUGWfgYoXBzUB8wFvO5LDq+=t7hAEksu0EA4Dc7FwbmUJp7A@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] tsm: Unified Measurement Register ABI for TVMs
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: "Xing, Cedric" <cedric.xing@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Dan Williams <dan.j.williams@intel.com>, Samuel Ortiz <sameo@rivosinc.com>, 
	Lukas Wunner <lukas@wunner.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Mikko Ylinen <mikko.ylinen@linux.intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, suzuki.poulose@arm.com, sami.mujawar@arm.com, 
	Chong Cai <chongc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 8:06=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2024-09-10 at 23:01 -0500, Xing, Cedric wrote:
> > On 9/10/2024 12:09 PM, Jean-Philippe Brucker wrote:
> > > Hi Cedric,
> > >
> > > On Sat, Sep 07, 2024 at 11:56:18PM -0500, Cedric Xing wrote:
> > > > Patch 2 introduces event log support for RTMRs, addressing the
> > > > fact that the standalone values of RTMRs, which represent the
> > > > cumulative digests of sequential events, are not fully
> > > > informative on their own.
> > >
> > > Would each event_log include the events that firmware wrote before
> > > Linux?
> >
> > No. The log format proposed here is textual and incompatible with
> > TCG2 log format.
> >
> > The proposed log format is based on the CoCo event log -
> > https://github.com/confidential-containers/guest-components/issues/495
> > .
>
> Given that AMD is planning to use the SVSM-vTPM for post launch
> measurements, not supporting TPMs in any form would make this Intel
> only on x86 and thus not very "unified".  Microsoft also tends to do
> attestations partly via the vTPM in its L1 openHCL component (even for
> TDX) and thus would also have difficulty adopting this proposal.
>

Hi James,

I don't think the patch should be blocked for not supporting the
SVSM-vTPM and it is not an Intel only patch.

1. Not everyone prefers the SVSM-vTPM as it lacks the persistent
storage and does not comply with TCG's TPM specifications. TPM is not
just about the measurement.
Sealing and unsealing data is also a critical functionality for TPM.
Treating thenSVSM-vTPM as a TPM misleads users and disrupts existing
software based on TPMs.
The SVSM-vTPM is not TPM. Just like Javascript is not Java.

2. If our goal is to measure the boot chain and post-launch, the RTMR
is an effective and straightforward method.
We already support RTMR for TDX. For SNP, simulating the RTMRs in SVSM
is very simple while implementing the SVSM-vTPM needs a lot of changes.
The SVSM-vTPM significantly expands the TCB while offering limited
security value enhancements
compared to the RTMR.

3. RTMR as a technology has been adopted widely. It is not an Intel
only technology. The TDX CVMs on Google Cloud already support RTMRs.
The TDX CVMs [1] on
Alibaba Cloud supports RTMR as well. In terms of the attestation verifiers,
the token from Intel ITA [2] and Microsoft Attestation Service [3]
indicate they support RTMRs. The Ubuntu image [4] from Canonical
enables RTMR by default.

Link:
[1] https://www.alibabacloud.com/help/en/ecs/user-guide/build-a-tdx-confide=
ntial-computing-environment
[2] https://docs.trustauthority.intel.com/main/restapi/attestation-v2.html
[3] https://learn.microsoft.com/en-us/azure/attestation/attestation-token-e=
xamples
[4] https://ubuntu.com/blog/deploy-confidential-computing-intel-tdx-ubuntu-=
2404

Thanks,
Qinkun

