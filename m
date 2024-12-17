Return-Path: <linux-kernel+bounces-449977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 703019F58D0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 22:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C1F163718
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C3D1F9F7E;
	Tue, 17 Dec 2024 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BILBghsH"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F461F8AE6
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734471464; cv=none; b=OnbwgJmlPIIu5OOMGF1bJb8Eb0/AYu2Oa6EGsC4qnOhEhdyIMDNgeKezf/kb5xYcqYfJuw2lkhsDB3+rC28PiGVok2R836cMFCpl9usXEqN721Mnvo7XV6hN2En7A5kLlpZRqxp8zwY8rP0UFCWXjgdC8uuikH5nTBDN32Aw1t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734471464; c=relaxed/simple;
	bh=FR0P8x7/9ngEgKiXbPcjZ9SkDVlLITONVwCAUmfHs9I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AFSB5d8//sbOBmsV9zI0eGaJGZDix6YqSgEw9X7rY96OqlxPfrzvdNwWAAdg7V1D8l8WXtaqVvAw43/f+NCvl6QeXL2lIBu6DOTepchXi0MO5xmFKUrEyEdNLbcsKOKEQ2+QtTxMgDAG0wMqyiWAAcin6+FRnEi6wcHsopAUKOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BILBghsH; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7fcd2430636so3875871a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734471462; x=1735076262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rw3V5l3zgEdyqeowifhhV2t/72Ab4n6g+8l5OuuzZOM=;
        b=BILBghsHVK5s1gsbkhi8u1FS2+AP5vCtWCg5wg3FDrFbHCoeVfR9BTnSy/J4di64Iz
         YABBGQxPspvWx4jdXUH62oPeCynQxXW6K5fdMV12ZzzBqq+z6pwT8+yPV1ASA5C7C5Nq
         y8wbGT0bf3hRxDBIowG45mknIiIkk0rN05jZH6S5NvjwUjMrte0UMZ7RbsX9yWiemtDo
         Q7vOMZ1YYn2m7dlSOrYHJPf1Yec8sVc5u9RiBVCpe4ECCoCekf/zwrUlKfmOKQ5jpzC7
         yjAFHmUaW7u3yJE11jONM3JNOpgCPTRkcbQVFBUcaWoLg1BxmrJj+DVwmVRYoQbNsAu3
         r3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734471462; x=1735076262;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rw3V5l3zgEdyqeowifhhV2t/72Ab4n6g+8l5OuuzZOM=;
        b=uyGdKecSvtxcVbzg10iwHcw7xTra1upWQdGoA4nKvSAM10QUjN0+exavVLubkmOv1D
         yizHOUlysMQBTtGVFz1udrsN2y+N5l+wlxvI6FuDP/y1voylFVKyJcwCXLRnxRa5zr/0
         tFI8yfCosJ8kq6MqVuEC8D3quu1xfiNrC4oln3NvbcfZUHsHKgKlXJ/aeNPTr1nD39Yy
         BN8jxGWayrEww0WIzYYpj2DUN/ZUg+pq1bJZ2UMi8wNyg2mdGn4DbKl9zdZWSlK3V6aQ
         V9xzJUC465mhZ20bFJdZkYsGfI6W5FpkmgTglUMH6BsUbvnj3AxHPhQCL56gQgIGqPJ7
         Agsg==
X-Forwarded-Encrypted: i=1; AJvYcCUARGvbzH1/gmXETUKrxGSvd3t6ZWCx+XQEfrfYyWlE6FqY3ncOLZz46jnKuEbmigB/XzEhLkqvo0VAdVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YztttJqjSqp2uz9dNwciVBfn/6RrYQ3SQTCpa/AhelLtjb81I4s
	+zC5CsTMRst/KLeK2oXmHxuNS66+huJ+4UwxzVFo4Q+9u7FH9PbFuhMWRGNZ84avmIeZlfcNms3
	4lw==
X-Google-Smtp-Source: AGHT+IHkBuqTQ7UlVlQLJaGwJ+fr7nw0ge3h4GeiLflYNngZHZg+PnIluUNLdsY9fVUJdSpCtTapg9gTOXQ=
X-Received: from pjbpd5.prod.google.com ([2002:a17:90b:1dc5:b0:2ef:6d06:31e4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d88c:b0:2ee:b6c5:1def
 with SMTP id 98e67ed59e1d1-2f2e91a9f37mr670257a91.8.1734471462252; Tue, 17
 Dec 2024 13:37:42 -0800 (PST)
Date: Tue, 17 Dec 2024 13:37:40 -0800
In-Reply-To: <cc27bfe2-de7c-4038-86e3-58da65f84e50@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1734392473.git.ashish.kalra@amd.com> <CAAH4kHa2msL_gvk12h_qv9h2M43hVKQQaaYeEXV14=R3VtqsPg@mail.gmail.com>
 <cc27bfe2-de7c-4038-86e3-58da65f84e50@amd.com>
Message-ID: <Z2HvJESqpc7Gd-dG@google.com>
Subject: Re: [PATCH v2 0/9] Move initializing SEV/SNP functionality to KVM
From: Sean Christopherson <seanjc@google.com>
To: Ashish Kalra <ashish.kalra@amd.com>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, thomas.lendacky@amd.com, john.allen@amd.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, michael.roth@amd.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024, Ashish Kalra wrote:
>=20
>=20
> On 12/17/2024 10:00 AM, Dionna Amalie Glaze wrote:
> > On Mon, Dec 16, 2024 at 3:57=E2=80=AFPM Ashish Kalra <Ashish.Kalra@amd.=
com> wrote:
> >>
> >> From: Ashish Kalra <ashish.kalra@amd.com>
> >=20
> >> The on-demand SEV initialization support requires a fix in QEMU to
> >> remove check for SEV initialization to be done prior to launching
> >> SEV/SEV-ES VMs.
> >> NOTE: With the above fix for QEMU, older QEMU versions will be broken
> >> with respect to launching SEV/SEV-ES VMs with the newer kernel/KVM as
> >> older QEMU versions require SEV initialization to be done before
> >> launching SEV/SEV-ES VMs.
> >>
> >=20
> > I don't think this is okay. I think you need to introduce a KVM
> > capability to switch over to the new way of initializing SEV VMs and
> > deprecate the old way so it doesn't need to be supported for any new
> > additions to the interface.
> >=20
>=20
> But that means KVM will need to support both mechanisms of doing SEV
> initialization - during KVM module load time and the deferred/lazy
> (on-demand) SEV INIT during VM launch.

What's the QEMU change?  Dionna is right, we can't break userspace, but may=
be
there's an alternative to supporting both models.

