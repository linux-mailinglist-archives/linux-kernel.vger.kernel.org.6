Return-Path: <linux-kernel+bounces-252793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9F493182C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70ED91F2207F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102A84317C;
	Mon, 15 Jul 2024 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WwpMhYzZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CC71CAB9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059749; cv=none; b=cfD8SzVXKPoyHLgJv9j3QS5O+8InzMJNPSVnI+JcAAwzi3INMvqHxhWYT2CRDznVgcnhFYtJ+xBL3d3JcL9VZWbYpSf9oeccY7/VC/f3KJgDY4afBlXTkme8gY2rSHIydMp/ZL1DRWiNewCM16ixid4dL9Zv6TMwW5gn9zSV1PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059749; c=relaxed/simple;
	bh=pns6oBjdeKTxUi/oyky+qxEK+jXJ62xk1tKqw+8NpnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNjxRWb5NVQeA3zc2zVs6PtmHtLO9oYSHBqGlwsixaesmRxTMxN6Qhm5yRyvIoBvEFgYjN74c5qBpDpno93Bh09MPF7KGVwVOoowFMiDDFywbo0y5maMkh/gPVQ2UMjLzpPrAJHoR+NeofkjOUetBESfoAImNStim4nOxb08e8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WwpMhYzZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721059746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Abk3xY8p1XoS3Otzd65O+1Rdw5yUxySHu+Mh0abIVgI=;
	b=WwpMhYzZUh0IIxU0/L1gyTNBxDb77SDV7HHVRf7CZxtL8aifIZULLgKYA/hnETV3HS+F4T
	UhgZJwX9PublxmBoI9UrWj89xwoNPlkkgJeaarMgyNRDZHhSseAcSUPSh7DDgpE/uDDd0K
	5LvnkYhjJEFqGQeAvbtDvQc+LXL3QME=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-KQseAc8gOHmW4VodxyuRvg-1; Mon, 15 Jul 2024 12:09:05 -0400
X-MC-Unique: KQseAc8gOHmW4VodxyuRvg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-367990a5796so2745615f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721059744; x=1721664544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Abk3xY8p1XoS3Otzd65O+1Rdw5yUxySHu+Mh0abIVgI=;
        b=bPF9eb8jBN1xBxvUH1YETNVGuo7fPnJJQ/Ysn+iluV7nn55jbqYmBxPm1BFgmAA3OI
         oCQZt3CqnmN8SPn/ynbGemql+co+s8lL4Bxn3fyUzAIHVBC1ZGNJhlJbadX+1IqpJ1KL
         2srZfSjZ2DW+oBcWHAX1fcOOXl/eYgb35aPssytRDHSXkpvXyqxSPxCTYUnypwVhnCFl
         AhRNqhxManQNyYuOmwFUzQfpNL6YCvEq8FYJQ7KdG5accXvTEXTMP4Vbe3UhedDC3iRW
         LrhxhWxhNckqqhqhw/jhk4d7cNQEg+QqaGzG4qvr+1K6QskEHJi7/a+VqNinuu7rRldc
         lQFw==
X-Forwarded-Encrypted: i=1; AJvYcCXc+9eoRnw7ZLb8zidU6ccpZhOxWgpXpaFF3RSrG+5a2BsgayCpqVYxxy8iF7URJdDix+VFQ4exEjkhzGeJY9BFOeBb9NxqgmmiWwPD
X-Gm-Message-State: AOJu0YyFHjtxAZp7e1Ipf4A9s3bBrPOQLi0wD40rCEy3VLFj/8oPCgFY
	oEy9EmBTYnj7FxTvY3GwsKTvqJ1CxwAh5YJiMtQ2PxbcSIVxqRoDBPonWQhd3nGXBNmAx5RCKOu
	LZwi7zzp3EBIYthWIb6ubFuQ2hzYrFIZ9hSMciypxnIi2CKF6NxjzcWg1O+xB0HIN63lkAUa6rf
	TkKSt/vm5GRjSoStZSDx89jUtmST1wjxDjje20
X-Received: by 2002:adf:fd05:0:b0:35f:122e:bd8c with SMTP id ffacd0b85a97d-36824088d3dmr156185f8f.17.1721059743876;
        Mon, 15 Jul 2024 09:09:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEog5YOTIjhOUFctCGyLRn+0RvpSTee0pbP4aam/coKAqEKJDiarFwJ23vF333z/XezLnfn1KfwXp0w7OUlVPw=
X-Received: by 2002:adf:fd05:0:b0:35f:122e:bd8c with SMTP id
 ffacd0b85a97d-36824088d3dmr156168f8f.17.1721059743518; Mon, 15 Jul 2024
 09:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711222755.57476-1-pbonzini@redhat.com> <20240711222755.57476-10-pbonzini@redhat.com>
 <73c62e76d83fe4e5990b640582da933ff3862cb1.camel@intel.com>
 <CABgObfbhTYDcVWwB5G=aYpFhAW1FZ5i665VFbbGC0UC=4GgEqQ@mail.gmail.com>
 <97796c0b86db5d98e03c119032f5b173f0f5de14.camel@intel.com> <n2nmszmuok75wzylgcqy2dz4lbrvfavewuxas56angjrkp3sl3@k4pj5k7uosfe>
In-Reply-To: <n2nmszmuok75wzylgcqy2dz4lbrvfavewuxas56angjrkp3sl3@k4pj5k7uosfe>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 15 Jul 2024 18:08:51 +0200
Message-ID: <CABgObfa=a3cKcKJHQRrCs-3Ty8ppSRou=dhi6Q+KdZnom0Zegw@mail.gmail.com>
Subject: Re: [PATCH 09/12] KVM: guest_memfd: move check for already-populated
 page to common code
To: Michael Roth <michael.roth@amd.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 14, 2024 at 7:33=E2=80=AFAM Michael Roth <michael.roth@amd.com>=
 wrote:
> > I guess this series is trying to help userspace not mess up the order o=
f things
> > for SEV, where as TDX's design was to let userspace hold the pieces fro=
m the
> > beginning. As in, needing to match up the KVM_PRE_FAULT_MEMORY and
> > KVM_TDX_INIT_MEM_REGION calls, mysteriously return errors in later IOCT=
Ls if
> > something was missed, etc.
>
> If SNP were to try to call KVM_PRE_FAULT_MEMORY before SNP_LAUNCH_UPDATE
> (rough equivalent to KVM_TDX_INIT_MEM_REGION), I think the same issue
> would arise, and in that case the uptodate flag you prototyped would
> wouldn't be enough to address it because SNP_LAUNCH_UPDATE would end up
> failing because the gmem_prepare hook previously triggered by
> KVM_PRE_FAULT_MEMORY would have put the corresponding RMP entries into
> an unexpected state (guest-owned/private).

Indeed, and I'd love for that to be the case for both TDX and SNP.

> So for SNP, KVM_PRE_FAULT_MEMORY/SNP_LAUNCH_UPDATE are mutually
> exclusive on what GPA ranges they can prep before finalizing launch state=
.

Not a problem; is KVM_PRE_FAULT_MEMORY before finalization the same as
zeroing memory?

> I realize that is awkward for TDX, where the KVM_PRE_FAULT_MEMORY is
> required to create the sEPT mapping before encrypting, but maybe it
> would be possible for TDX to just do that implicitly within
> KVM_TDX_INIT_MEM_REGION?

Yes, and it's what the TDX API used to be like a while ago.
Locking-wise, Rick confirmed offlist that there's no problem in
calling kvm_arch_vcpu_pre_fault_memory() from tdx_gmem_post_populate()
(my fault that it went offlist - email from the phone is hard...).

To be clear, I have no problem at all reusing the prefaulting code,
that's better than TDX having to do its own thing.  But forcing
userspace to do two passes is not great (it's already not great that
it has to be TDX_INIT_MEM_REGION has to be a VCPU operation, but
that's unfortunately unavoidable ).

Paolo


