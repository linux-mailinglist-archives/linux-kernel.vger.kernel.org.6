Return-Path: <linux-kernel+bounces-356976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 058099969C7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23221F25884
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF88192D89;
	Wed,  9 Oct 2024 12:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLjexEuM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FA9192D60
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476284; cv=none; b=a4VZJHjRKlvDVITVQVu39xGo/oSvhJA3gKsX5ZOFkmAk3lDNrUS+2w4/2pIBJzMtcuB7kBzebzgqb3tQ3yimMe8GjFmVhsXSxlHlxYM2SujjJ0VWdgKhcoFSd9DzpiME0tFy6hizFBKEIioqQgvhz6xRvsXiLCAsx36+kRQVpE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476284; c=relaxed/simple;
	bh=xO8PVvEiGlQrBvLFulZKQ8G4KC8mUhuysrsSdmLti9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0NDDFwi2GoBOWdCwFnoix+l8loKIAcrPzJJW0kwFr0cTweVgsZ/qSa1tbZYqlDw8ock9XaAU1GN5cwgsnqJhXcJDoykhS8ntcILWJjQ8b0gjPWNG42tAaCtxR5CRjon9qEKI9ihn3o7B/XyBfIr60NiF9lF8Ap8ocu6D6bRykc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLjexEuM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728476281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i/JCA0HtI9ooTOOvo/GvEfwZsTSm16VZN5tQXZObxsA=;
	b=gLjexEuMvMnll4BQDO5N7G4FNz2ck4bStUtQnl05ZpcGiwvmH7VnykvPYIQc3uD5nNXeek
	/7pt9A9cijEXZ1GXtdD3f1A5DyMx5LWWPQgSG+nlIif8iMlr9pRYYksTCeAMxTeidkQiyW
	jeqbvI5kop1MdD9iR6VQTuenLfAWUXA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-fjTYyo0xMBKnAKECaMKWNw-1; Wed, 09 Oct 2024 08:18:00 -0400
X-MC-Unique: fjTYyo0xMBKnAKECaMKWNw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37cd19d0e83so3138269f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 05:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728476279; x=1729081079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/JCA0HtI9ooTOOvo/GvEfwZsTSm16VZN5tQXZObxsA=;
        b=P3JtRRSsw31zobncVfM4j5RYPi7moNz8dLDN69cV2KbVKE0NIOIFznn6H/yBStWy8d
         Y+RITPZ4hGXyI7uhOrKKAj3/yRozTKn8Q5v6SL3suIuggDUiyzo9wgOWmWUVEDWjGvuV
         yRmaHXMo4EnEo0QFrjc+ezvQMlzDGrJs8lHTMT1EhMnVldA9VBCaGOxo+qiZP0zHsqPW
         I6BB3BboWaDvqELZaCBNqAg9+Mya0ldk025xEDxeDCqAoLbhsJprtlVL1SczfC3XInI0
         7OCX1jwkf5e7P89j/DSEuM/BGn+C3AmXgt2fmF6f7LpF2PQ9CzyeOSNQemcUwHOJLD8U
         YHHw==
X-Forwarded-Encrypted: i=1; AJvYcCXvbH2VIsEc+uM1PG9pCgKURJNkXwQ0bjC4UR8wJMpfLjyS7MFrMbskwcCtF+PLLhxQZ4cEe4KjW5mq758=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Wsr/EO1S3tEhHR79+nm6eqPtxL7wg1CvxHryVE0mmLkCfcSL
	VkWKfRhOExiZv9K6fdvF/b3nA9hb7DNwvWPB9HMHKB2AsdeMcOEt42pyREibzuKs0lsY7YPMzrR
	10irpuu32wWCahCaghcqqp1LnIMSgY61CatL8caZFyUDHkkY0Srr/smC0jQIKgZNbijsnLMcKtp
	x0rFpZ6I31c9mTLM5eTyrTXI59zY+qMa0xDDmsopcIKTa8aXyzRQ==
X-Received: by 2002:adf:f04a:0:b0:37c:cc01:f7e with SMTP id ffacd0b85a97d-37d3aabccefmr1225539f8f.58.1728476278579;
        Wed, 09 Oct 2024 05:17:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMtuZgRTBRKHy4TJ6+iqV6ZczH3/cPSGjClk8IPhbXhcnPHARjws9/sXc6usMMhIy/CyG7Pf4yqSXmWSz83kg=
X-Received: by 2002:adf:f04a:0:b0:37c:cc01:f7e with SMTP id
 ffacd0b85a97d-37d3aabccefmr1225526f8f.58.1728476278182; Wed, 09 Oct 2024
 05:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SA1PR10MB7815C826ABBCA3AC3B3F3B12E97D2@SA1PR10MB7815.namprd10.prod.outlook.com>
 <ZwQjUSOle6sWARsr@google.com>
In-Reply-To: <ZwQjUSOle6sWARsr@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 9 Oct 2024 14:17:47 +0200
Message-ID: <CABgObfYWZQc_gnzUAmFQ=McbN4VQxbrd+4vss=pGRdrOAcOcfg@mail.gmail.com>
Subject: Re: KVM default behavior change on module loading in kernel 6.12
To: Sean Christopherson <seanjc@google.com>
Cc: Vadim Galitsin <vadim.galitsyn@oracle.com>, Klaus Espenlaub <klaus.espenlaub@oracle.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 8:07=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
> On Mon, Oct 07, 2024, Vadim Galitsin wrote:
> > Would you consider to change the default behavior by having
> > "kvm.enable_virt_at_load=3D0", so people who really need it, could expl=
icitly
> > enable it in kernel command line?
>
> I'm not dead set against it, but my preference would be to force out-of-t=
ree
> hypervisor modules to adjust.  Leaving enable_virt_at_load off by default=
 risks
> performance regressions due to the CPU hotplug framework serially operati=
ng on
> CPUs[1].  And, no offence to VirtualBox or VMware, I care much more about=
 not
> regressing KVM users than I care about inconveniencing out-of-tree hyperv=
isors.
>
> Long term, the right answer to this problem is to move virtualization ena=
bling
> to a separate module (*very* roughly sketeched out here[2]), which would =
allow
> out-of-tree hypervisor modules to co-exist with KVM.  They would obviousl=
y need
> to give up control of CR4.VMXE/VMXON/EFER.SVME, but I don't think that's =
an
> unreasonable ask.

I agree, VMXE/VMXON/SVME are mostly a one-shot thing.

I thought about adding a Kconfig for kvm.enable_virt_at_load, but it
is not really a good solution.  Distros would either leave it to the
default of y and inconvenience VirtualBox/VMware users, or set it to n
and have bad performance on machines with a large number of CPUs. The
problem is that "all distros set it to y" is an unstable equilibrium,
because it may take only one bug report to convince distros to flip
the value.

> Short term, one idea would be to have VirtualBox's module (and others) pr=
epare
> for that future by pinning kvm-{amd,intel}.ko, and then playing nice if V=
MX/SVM
> is already enabled.

Yes, this is a good plan for allowing to work with both old and new KVM.

Alternatively if VirtualBox or VMware have an installer or rpm they
can write a file to /etc/modprobe.d to change the default, which
doesn't require code changes but is not a good idea.

Paolo


