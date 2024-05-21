Return-Path: <linux-kernel+bounces-185415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E03C8CB4AD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C771F227DA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B872149C55;
	Tue, 21 May 2024 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHLE3FVL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE967763F1
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716323139; cv=none; b=oKCPWyWTsEFndhbOb8s9VLOpKI+wU43cTo9HZ9gRZMbyczfxoT/VzObg6Uo3lzCo3LfAUF6rl4Xgf0qSUp7a0X08xZ0KVS5wTiLKEeDevP940PKLFwf9zAfDXawWsNeCQSZrYMOyuK8QlZbIjWHTrN/H8CI032RETomJz4zfCXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716323139; c=relaxed/simple;
	bh=TNbVzSZ4k9mDMCWPwnEnUO8KrwqMSnosmMil9nH2X8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3CRcnrYUygGxjNvKDVmf9cizdp/5p/7P755KdNt/ngRqDOY7rPYKIJNgvCa8TM+vLnHbQnv1DSz5/MntBQRE3R9a3IEQWeRVOMQ650un8q1+hG5MxMCyyMkPtzri7TP8hScxSepd5ZO+X09dPi82wVCJkve6N6rP1/fpOe/ASU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PHLE3FVL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716323136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLQerxE5R+lMZTgLtYljE+62W5PtbMN9LPsnxzlTokY=;
	b=PHLE3FVLxKxA0pBWfK5Bq1skq5iwtlKRiPnQeuqSaQd/cHZvXYMdQDmyU0IwWTjLqgaETm
	jyvoCCbheEydbeOLUld2wAJue1tWVonsUE8FaV6k2JsItwDKv07OmAHUKAtjoIkOhEN1SN
	RSrSg9ZZQcwzqqUBCn7begGcM6bc8Zo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-Y_-iOLBFOQevA3L3NheJ6A-1; Tue, 21 May 2024 16:25:35 -0400
X-MC-Unique: Y_-iOLBFOQevA3L3NheJ6A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-34db1830d7cso116649f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 13:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716323133; x=1716927933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLQerxE5R+lMZTgLtYljE+62W5PtbMN9LPsnxzlTokY=;
        b=XT3wti7yjU+SdvyM55b5bIMEPGvRz3rKMN7u1GC7ooFsNaJsO6P2ReVAdUND20Opjx
         mFyCFQrnmQNoOVg0PqPQMZ4ERHe0kP6JK8h74ep21IujtrTUJN6THv33RnoC8pZtTgXT
         98iS3VcUdd4wlfcAe2l79yaeZTabYHUgElalyEuDdzqB8RqC9szmeZ7kwhJrQcdSCgKe
         f9TLV26qq24jyVv8tHXLBCnGxZUrXfBC1Q/7KmkEqhUZUEdeOaUl0cbK7q5oEm4XRQIQ
         6r5uUM9f9BMw9rbfX6ElhWyVHuGMMRCWU1iCeEVp0IWbluLlhsrJoO4oImrA5izANwDE
         3hfA==
X-Forwarded-Encrypted: i=1; AJvYcCVtNVVlh+hlELYPIJOD66ok5EGhq4Nc42d5jdS1MA5qkOLzl7rXKYwyU2UhN+kleSASsZuEMvsC36Rw2ql8QbtY/MghUYhQUH8w/sV6
X-Gm-Message-State: AOJu0YyQxiAjyNXZjbh077ybey9QOy5sPifR4Qzpu7+7eYYOu9LuZImB
	/oEJlnh/OsYpnebjJXyRbX+CQzSOaB1zKcA9YgBYxieBZ0Atr01BdyB3EfqWjapVBhdvFprDlng
	6z88pa3TBFxwPv3aw8AKUB1fPDJjG9rvXu/pg7wXfpnBUTPpggirIEP976CeVPzwPAAq9IHUVv2
	Kx7TK/QCZvqsX7iF/xqepGXkEp0uQV3IAHKK5cnRuOYfoY
X-Received: by 2002:a5d:5510:0:b0:34d:ab1a:6384 with SMTP id ffacd0b85a97d-354d804f46emr119876f8f.13.1716323133081;
        Tue, 21 May 2024 13:25:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB55ZmrkK7joPCTYgDCxER7qka48DTWgOfjPLcKVDrzhqdCM29sdaEnBuS0/mwQSDsQgyxkw4J2nGXaX3dtf8=
X-Received: by 2002:a5d:5510:0:b0:34d:ab1a:6384 with SMTP id
 ffacd0b85a97d-354d804f46emr119864f8f.13.1716323132726; Tue, 21 May 2024
 13:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240518000430.1118488-1-seanjc@google.com> <20240518000430.1118488-10-seanjc@google.com>
 <CABgObfYo3jR7b4ZkkuwKWbon-xAAn+Lvfux7ifQUXpDWJds1hg@mail.gmail.com> <ZkzldN0SwEhstwEB@google.com>
In-Reply-To: <ZkzldN0SwEhstwEB@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 May 2024 22:25:20 +0200
Message-ID: <CABgObfaE+M5QuTfAZ01OjeB87vGmjRgDUH=rnNX8FHzc7t1Oag@mail.gmail.com>
Subject: Re: [PATCH 9/9] KVM: x86: Disable KVM_INTEL_PROVE_VE by default
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 8:18=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> > -          This should never be enabled in a production environment.
> > +          Note that #VE trapping appears to be buggy on some CPUs.
>
> I see where you're coming from, but I don't think "trapping" is much bett=
er,
> e.g. it suggests there's something broken with the interception of #VEs. =
 Ah,
> the entire help text is weird.

Yeah, I didn't want to say #VE is broken altogether - interception is
where we saw issues, and #VE is used in production as far as I know
(not just by TDX; at least Xen and maybe Hyper-V use it for
anti-malware purposes?).

Maybe "Note: there appear to be bugs in some CPUs that will trigger
the WARN, in particular with eptad=3D0 and/or nested virtualization"
covers all bases.

Paolo

>
> This?
>
> config KVM_INTEL_PROVE_VE
>         bool "Verify guests do not receive unexpected EPT Violation #VEs"
>         depends on KVM_INTEL && EXPERT
>         help
>           Enable EPT Violation #VEs (when supported) for all VMs, to veri=
fy
>           that KVM's EPT management code will not incorrectly result in a=
 #VE
>           (KVM is supposed to supress #VEs by default).  Unexpected #VEs =
will
>           be intercepted by KVM and will trigger a WARN, but are otherwis=
e
>           transparent to the guest.
>
>           Note, EPT Violation #VE support appears to be buggy on some CPU=
s.
>
>           This should never be enabled in a production environment!
>
>           If unsure, say N.
>


