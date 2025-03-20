Return-Path: <linux-kernel+bounces-570009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AC0A6AAB7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8643AE0FD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFB01E9B29;
	Thu, 20 Mar 2025 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hu8NO9Ax"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509931DED6F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486926; cv=none; b=fWNn3buKgSjduCbjCYR+RcrURnlxyVDZA9XEuUVLCcWWgxT/Cxb8XdjQenPgOKx+F+PYKAGSSz/Q9F4ksUg8bvoBpG+SeDxKEkqEl6ZDzyW78ZyeTEcGL9E2+s546dJXGOx+qelxk06xi3DqDfwra0bgyXvf5Oi1gBe4z586Gjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486926; c=relaxed/simple;
	bh=vgTVWZExgzh2bDuvAIpu+5f+q3zFr/HZLt45hek77bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMUhq3WfHh5r7C1BSnAf06CxWO0y/zwFXZmqcBKakoQbz8SFGSIvNSFo/EcAFpJ4HF/h46c/8f3QInziN6NOqHNBr6J6OooiLT7/efSyOB2iltCe7HgIF2//Kz87HxuAPtt1vpY9HKlX/qaGJ0/a6pmQRxK4SLQRniCdsMZBvtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hu8NO9Ax; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so12607a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742486922; x=1743091722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRVFPk38Y5kn7eWiVNM8nEIsgCgvVcbpOFN7/4VSFsU=;
        b=Hu8NO9AxsnTpysHEZJ+BstYXvxfcMq6QExTO7zCa3enjXwVAh0dhcMp+GlT1tkD0ED
         7Qq64sRiI7oXajksQU7pKemR1uq3f9x3nuD7tqPthSvcq9nNPUSIweh4yQttHYQfXnMI
         PqhA3RTWpwRM1TCNTvaW1AFRNOfSNY2pqu/NVng2VHSEIbR2GUSphcZseFJ1DRKUu9l7
         pvk8dCesJCwdR852GvUh4k/0EeOiFwKHRILkV4LC1CPBcK6CIdTOMgm6SuYmegRzQZ1r
         Bw5JIZZCWe3Zkg6D3d1sCFuTcWcPLaOzDK2SULorLWsQCqSEzL7ZpEoeSrOv5WATiIDT
         iHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742486922; x=1743091722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRVFPk38Y5kn7eWiVNM8nEIsgCgvVcbpOFN7/4VSFsU=;
        b=qRnwMmohhrFuTLm++1iqBXNKg+N13FX0s9kvUn215VHq+GzqhQuM1mM7DwRJDbW+Oi
         /qegwObM5Lboy96XbH5xXIOhTWpALlInz1od/vMG4zfPBiN6I9TIth85WhMxCEcwllTn
         XzclnUcFtGPQB3AuPsX9EdaelkEImoRQLEPpVQZ8t7Ja+MSAyZlyzj/e6Lcm4GOFj5Db
         pRZ7KXo4ZcJBXtpNhlNsiAQdmJooFOlkAFDg8DxJZs4L6Uu5HHUpZPGocTVCmNLQvpuG
         NDcANmiwDtqUWrY3YQZntBax9E+UsgjL7ULeBIVqtEhQrXXneQy3j0vN4xpVcV2CaJFk
         iwxw==
X-Forwarded-Encrypted: i=1; AJvYcCWw+IjCsgVKzslcvoUf6TeD7iwe1lYELdKbMFqLXEO7FsMRyancnXBEG8BbhVrPSJZWo1OehOLpYM8yTN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCAls/hV27eG+ddxoIhxOz2ezp94JMp6zdjJYUalwbzVfVx+/+
	Lp0BjeIkaVFmtPe30U4x1/3anqV+Q3Dbd8QmmtuPtqpXE1AZZPQDmc4hhnF8anNRqQ5PPTFDMiN
	0/Df6SrDYSTVE/mEgY1AG8ml+GlJnP5ErSqT2
X-Gm-Gg: ASbGncvkMFhd+bpth+TXIMdWXoBYVr2jdhOGCR7NcFtCa6JLhGhIISrwhGAWWljmJrL
	NF/cmTgIquDWJWuyYzkHXm2jvUzsF+ZjgDi2mHqN5ti+eFnfirf2U7FiOZ3yAdOdZzeH5TCsoCt
	y64GeNfDlwj0Cp1NyQ9ZPWgn3a4A==
X-Google-Smtp-Source: AGHT+IE2aF5ixYpsQmX8/liYervWjAj9+pCyKD1dnGB+hzETkfkk5YMebmJT6OByqdUKnt9rJeWGSoBC9gxDw952qN8=
X-Received: by 2002:aa7:de95:0:b0:5eb:5d50:4fec with SMTP id
 4fb4d7f45d1cf-5eba06cb25cmr128016a12.0.1742486922293; Thu, 20 Mar 2025
 09:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320142022.766201-1-seanjc@google.com> <20250320142022.766201-3-seanjc@google.com>
In-Reply-To: <20250320142022.766201-3-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 20 Mar 2025 09:08:30 -0700
X-Gm-Features: AQ5f1JraSCplyBobxoJA5D_xbOTr5CidJpGQNxGU8uqxS7nrp3COJ0vxcJBnlLg
Message-ID: <CALMp9eTQovt83qgB1pM3NTYaNNRU+wrRhNA9NfsRO4RDnbVU3Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] KVM: SVM: Don't update IRTEs if APICv/AVIC is disable
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 7:31=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Skip IRTE updates if AVIC is disabled/unsupported, as forcing the IRTE
> into remapped mode (kvm_vcpu_apicv_active() will never be true) is
> unnecessary and wasteful.  The IOMMU driver is responsible for putting
> IRTEs into remapped mode when an IRQ is allocated by a device, long befor=
e
> that device is assigned to a VM.  I.e. the kernel as a whole has major
> issues if the IRTE isn't already in remapped mode.
>
> Opportunsitically kvm_arch_has_irq_bypass() to query for APICv/AVIC, so
> so that all checks in KVM x86 incorporate the same information.
>
> Cc: Yosry Ahmed <yosry.ahmed@linux.dev>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Nit: "disable" -> "disabled" in the shortlog.

