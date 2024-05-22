Return-Path: <linux-kernel+bounces-185900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B64E28CBCAE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31CE5B216CB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9591F7F476;
	Wed, 22 May 2024 08:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgseVKqi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73852182DB
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716365404; cv=none; b=contpOQtuiPZjc6CFQJcZ00PyrivMOxXBWCZwzdsB+tSrWDZ0SRX0IMzUVGHdvmZz2cQTM2ZHtrtDr4plePokMc+lOZkmwopxIXuDgcvey91Y76n0Nik3o96RqaDuweOEVdVR1O8hWqu8IswgTfLjPyeJs7e+jY1mAC6VK5SnYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716365404; c=relaxed/simple;
	bh=zoBhkj0M1tl/VH3w++vytNO/kHH6JAySc7ds3DgwG/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0HyOpod2LHw8NfsEfsmY5JqK8rQVII3QLg8r6hN4MHjaL2h2/b4r7w9Yg72EZLkbtKtg0TZg0lybtLN0t2rQgTTKfisIq9eMuhpP2AHqnnjcviWKfszy94QMauZVnTfNvBDwUQ90l6fPSyj4g6pnNeXraCic5xPr30jiHbUU5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XgseVKqi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716365402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=otRYgCVJq92Yfm4kUIiopkxd1yl6k4G597cBFQJGQUs=;
	b=XgseVKqi8B4k70+JYaWZc7ROZ4guQ4iSFPcWiYhrec32af4q9nS0HQPgePfKvsYA9/WWt6
	KXybRQLB7mkW6VbPJhQ8OZSBKHs5TSOtvuXS89kwmzlP+mTDN7Fh7FmlJN4BPVNYhTkdUI
	sQZevA+aTeY2XH9zoqGZ/0xizeynHco=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-XKb2_tPVObWdF52ztpGjzQ-1; Wed, 22 May 2024 04:10:00 -0400
X-MC-Unique: XKb2_tPVObWdF52ztpGjzQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34da03e19beso9381550f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716365399; x=1716970199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otRYgCVJq92Yfm4kUIiopkxd1yl6k4G597cBFQJGQUs=;
        b=o8dG0KLVf3mO5QNePu3wMLQiSOo3jLnLkHefHtJUl5McTxKq6BCc0daLOb3u5Y/Ivh
         XsrqDDq0XQzgEn6OsCAnxzlyEFfjVhqxyDDnHyVKPi+l88sn/GhW4qf2O5A86rrD/ZwS
         p+bjJ8+eSXohiiVzMnlENOa9CZ/g/zn8K9L+bLKJIcrV+or+WBqVU3uiZl+2Ew/mAauq
         yCcs7DArDzLKcaJk37NYybyPQv0oH/QWxE6kHWbkHZPH1X7K6OAw9MzUgm1IOuf2gnu8
         0L/LZ+Sx+83jljS1n6CPitKu1L9l9SWJhzsrPoybfkgjq3LfXbfgqcCe/MyyRco/o0HF
         KfIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2sOFhBcUSfY51+DSNv2KfdqOxyuWuFxt2du4JLWvYFk/QtheoRCc8oksks4qiFKY3TRNVwEC26Id8LUx6PoxAmf0BrcrgcBqmaiBR
X-Gm-Message-State: AOJu0YyRm5amep87LveGskVsMbEjH7FTAG6zf036kqz2hHnU8owWOp76
	GWdxrgWxQ9+r7FBo4Y6neJGzPJDeSRydcnGJ7TzSeiCH+vKVfcSbUnydJ6/odmLVo4XZs9GVdEL
	xD7nwsd6O7qC5XVK3exO9MbhHEGsAWsWxZN7+rkG1vTqpU731/rBJ7hq4rB4GLUXXG7mEpQkaM6
	18NUVdJ7aC53iQDxroKpScQSr8pHlYVfBRPoem
X-Received: by 2002:adf:f2c6:0:b0:354:cc58:7af9 with SMTP id ffacd0b85a97d-354d8d957a6mr867156f8f.50.1716365399670;
        Wed, 22 May 2024 01:09:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYZBYweqSpzhVIi5/ML5GYyo4XnBFBMEWZWo5UVwE6v2E2Gk1I/ozaiDWRy6Q2pBOBbwPfOn4UcSnQaZ2DjDI=
X-Received: by 2002:adf:f2c6:0:b0:354:cc58:7af9 with SMTP id
 ffacd0b85a97d-354d8d957a6mr867137f8f.50.1716365399303; Wed, 22 May 2024
 01:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416050338.517-1-ravi.bangoria@amd.com> <ZjQnFO9Pf4OLZdLU@google.com>
 <9252b68e-2b6a-6173-2e13-20154903097d@amd.com> <Zjp8AIorXJ-TEZP0@google.com>
 <305b84aa-3897-40f4-873b-dc512a2da61f@amd.com> <ZkdqW8JGCrUUO3RA@google.com>
 <b66ea07a-f57e-014c-68b4-729f893c2fbd@amd.com> <Zk0ErRQt3XH7xK6O@google.com>
 <CABgObfaXAERePMQrrpWg8PqM1TOq8TJT65i3WgU0n0-vePDGNg@mail.gmail.com> <d543ac68-346a-4439-8f29-ceb7aa1b3b50@amd.com>
In-Reply-To: <d543ac68-346a-4439-8f29-ceb7aa1b3b50@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 22 May 2024 10:09:46 +0200
Message-ID: <CABgObfZL7dfczyeY=7Xh1YGqEZEzVsdMnM+D6yumFSNfLO7cfA@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: SEV-ES: Don't intercept MSR_IA32_DEBUGCTLMSR for
 SEV-ES guests
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, thomas.lendacky@amd.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, michael.roth@amd.com, nikunj.dadhania@amd.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 8:11=E2=80=AFAM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
> >>> LBR Virtualization overhead for guest entry + exit roundtrip is ~450 =
cycles* on
> >>
> >> Ouch.  Just to clearify, that's for LBR Stack Virtualization, correct?
> >
> > And they are all in the VMSA, triggered by LBR_CTL_ENABLE_MASK, for
> > non SEV-ES guests?
>
> Not sure I follow. LBR_CTL_ENABLE_MASK works same for all types of guests=
.
> Just that, it's mandatory for SEV-ES guests and optional for SVM and SEV
> guests.

I think you confirmed I mean: when you set LBR_CTL_ENABLE_MASK, you
get the 450 cycle penalty because the whole set of LBR Stack MSRs is
in the VMSA for both SVM/SEV guests (optional) and SEV-ES guests
(mandatory).

Paolo


