Return-Path: <linux-kernel+bounces-218579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA9D90C233
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8C71F21BCE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C6F19B588;
	Tue, 18 Jun 2024 03:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Zhh96E9P"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE1F19B3FD
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718679722; cv=none; b=keUbfHV/gzwWcB5nZuM3MeDY1SLsf8BXnG6HPEwuGMe5uZ80uHL97p3QZZkj79XT4yh9HpgI/UO0EFbygYlqocYtTLN6xEYo8XytQbSB2criKjNERcdo+BCUR9SPS/FUVN022N05JgTwiERnDUT5LkmSUA118HeTFo+SghoIJUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718679722; c=relaxed/simple;
	bh=voa0fe3SjpggwiHBh/MwhciBY6+FADQBkwBOF/PUA44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWJMeFI0SJ4bK6JiV2EkmXcxVG1cy+xnSXPECdQE1YfmQOGhv02UF/W75i7vz1MiOJ2D33fVKBCm8ugaq2OcEB9K9e1mpL+0JfeNx7tLg3hE1gmTzyKlD+6juKVTKEW7u3cVp0Os7gEeBG1IcThmQ9wCKc4bIyQlOtfA8V4VeYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Zhh96E9P; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7eb7bf1357cso198080539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 20:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718679720; x=1719284520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voa0fe3SjpggwiHBh/MwhciBY6+FADQBkwBOF/PUA44=;
        b=Zhh96E9PTA67D1wwQXJfT4CimKejWrJePj98o801nq41/glod4XZfqcEWMrRch2ny8
         hUXjtRrVDbsTTVpjlAruH0JUCmspGkMGXgqDuAWTW2kwfb7uecZ1UxJQPCEd/0yg35gt
         UO9xX0e5CyfYW5Netd2cY9buChCpTZV54QX/81I1DgoCWwTakiLFtCakP+Wk7Bv1bhZk
         hm4MedXqTJXmf/XANtNrvL9H450dXCK9jkBjIjbyMQX3Tzp0tfRfPcWb/YxeGi0EybmA
         1p4TtZaMurflB8kTw8Zg3xnTl0l7Mm5DWxlJurjzcocesmjkLHwFgb3tYvkCR0cNPG3/
         nkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718679720; x=1719284520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voa0fe3SjpggwiHBh/MwhciBY6+FADQBkwBOF/PUA44=;
        b=g1ZRDlMplqr2JZoTorChvgcrVFyqR1kVAwpDOFbcnrdKQe84u/M6paEGX4NxPa/my3
         LUTxlLm5i56BP640sGJTsWhqmYRMk+1YhZf3c2jgqdVUiDEXY0QPftiYOkfPIcxJYNNB
         jefkQ/dwIoG7lUg5NF7uqTT9Zp4IBju17/9pFLEmAn0dzInl65t4m7urNCmNf/QAkeyN
         L1JFWzYhzJj6w2XzgooQhGRLMsrr1glAgUneyOTVkDXm6t3AFg9jvUA0RMNrjBf1AdNn
         T2iEseWsJE2MLDcIZoQlg2M1snyqKdRx4VR2ueg7zXz5Zkwx2aXgCMPowL0Q3L46FkE3
         nfRA==
X-Forwarded-Encrypted: i=1; AJvYcCV3Fajcy0gPzS+MMwkw6Xhb59wwUONnX8Ioni/7iQRmhKmSGzoIhZ/AdugcEbIQ1qhgfmxeBTpTJ8QwEh81nh9cmGYQWbIRLKmXjA6F
X-Gm-Message-State: AOJu0YwcnGyIKMyNSo7aTqR8NQrEly+JbkPn2yPqcoCAtTrcvZnA5OYR
	qaOd7qG1vlmAqX2yZ2kMLBlxCaqnAFKcfgBGRjq1Wc/poCARWdqKKA4odYDsJ7q71H5umC0vC6P
	qa/J64pQNL53sWPV+PoW4eiXs3SfyYwg05FIuRQ==
X-Google-Smtp-Source: AGHT+IHWhSE+k8nI3ATV790kVcdaJx+X2XhzCDCnnNK4GDf4nHYtKrtEPv0N7J1xr51nXArplHNL9b+pWM9XSl88A3Y=
X-Received: by 2002:a05:6602:3f8a:b0:7eb:b93d:4101 with SMTP id
 ca18e2360f4ac-7ebeb4c0558mr1289632439f.9.1718679719882; Mon, 17 Jun 2024
 20:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614142156.29420-1-zong.li@sifive.com> <20240614142156.29420-5-zong.li@sifive.com>
 <a1a99374-dc40-4d57-9773-e660dc33beb2@linux.intel.com> <CANXhq0pQuoriKfHF51fXUtrZLkJBNOCe6M8Z6JbDjoRvbe1nWg@mail.gmail.com>
 <20240617143920.GD791043@ziepe.ca>
In-Reply-To: <20240617143920.GD791043@ziepe.ca>
From: Zong Li <zong.li@sifive.com>
Date: Tue, 18 Jun 2024 11:01:48 +0800
Message-ID: <CANXhq0pXYoeiVMFSGAijo-QHTVoZyM8M_uU4HWsbCwDg2oFPYg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/10] iommu/riscv: add iotlb_sync_map operation support
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, tjeznach@rivosinc.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 10:39=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Mon, Jun 17, 2024 at 09:43:35PM +0800, Zong Li wrote:
>
> > I added it for updating the MSI mapping when we change the irq
> > affinity of a pass-through device to another vCPU. The RISC-V IOMMU
> > spec allows MSI translation to go through the MSI flat table, MRIF, or
> > the normal page table. In the case of the normal page table, the MSI
> > mapping is created in the second-stage page table, mapping the GPA of
> > the guest's supervisor interrupt file to the HPA of host's guest
> > interrupt file. This MSI mapping needs to be updated when the HPA of
> > host's guest interrupt file is changed.
>
> It sounds like more thought is needed for the MSI architecture, having
> the host read the guest page table to mirror weird MSI stuff seems
> kind of wrong..
>

Perhaps I should rephrase it. Host doesn't read the guest page table.
In a RISC-V system, MSIs are directed to a specific privilege level of
a specific hart, including a specific virtual hart. In a hart's IMSIC
(Incoming MSI Controller), it contains some 'interrupt files' for
these specific privilege level harts. For instance, if the target
address of MSI is the address of the interrupt file which is for a
specific supervisor level hart, then that hart's supervisor mode will
receive this MSI. Furthermore, when a hart implements the hypervisor
extension, its IMSIC will have interrupt files for virtual harts,
called 'guest interrupt files'.
We will create the MSI mapping in S2 page table at boot time firstly,
the mapping would be GPA of the interrupt file for supervisor level
(in guest view, it thinks it use a supervisor level interrupt file) to
HPA of the 'guest interrupt file' (in host view, the device should
actually use a guest interrupt file). When the vCPU is migrated to
another physical hart, the 'guest interrupt files' should be switched
to another physical hart's IMSIC's 'guest interrupt file', it means
that the HPA of this MSI mapping in S2 page table needs to be updated.

> The S2 really needs to have the correct physical MSI pages statically
> at boot time.
>
> Jason

