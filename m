Return-Path: <linux-kernel+bounces-353420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BAE992D89
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5F41C21BCC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8456C1D432C;
	Mon,  7 Oct 2024 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hdK03pHB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E0D1D1F75
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728308301; cv=none; b=CXwvHC24iZHbyvHdhxt1wFdxAG3Dd5ceOTnRRv1GEvjmMvqZzqv2v3DiOgGKkQ/y/dxEElKfJtMiMwRzSJ/8TNKaVXB47HNwzc14BrX23wHCL/XSIjw+09ckIAOUDOdg7nlJScqmE0cLTuBjZsBpt2Q+bY8WGruQeaEqlJwA+fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728308301; c=relaxed/simple;
	bh=yVdeGgNTfeFuIEVPc7u0AK0zINUin07XGVxlqUetaSQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t1X8BZ8uVCQ99Vn56cSIpcSznhZUkhBRQAttdKvkjaKvt729ggVSjip0xqELDrGsRtKExA+6DN/2d9tfzhnwsl05RFR4DRLO2hvYKHeu3C3wFchTfxkVQuDCIpB6an7RigIZeClvFGVMCk+1JASdIoz+JXXSZeKF3PL4zhUKQso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hdK03pHB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728308299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5DPNZskkiUAq4LS5OFpU8MIweVBZO51RYIR24GV8o8=;
	b=hdK03pHBgUv71YXK4AYHt02n1CH+DiY9M9HdpLFOzKlb+wZvnhhg6++u3cj9KC85sjAX3+
	UfzDri+Vpc/zwnTB8fIVDicEhYBshtXViFgYqOoiSIXcLVunIOvbUDqHnnQKjzJQReyhj9
	TIteoPvxBl0F9wJYNFMT3CecSaiQ9GY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-48L0MW23NT2wGUQLoWHCRw-1; Mon, 07 Oct 2024 09:38:18 -0400
X-MC-Unique: 48L0MW23NT2wGUQLoWHCRw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb0b0514bso39841115e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728308297; x=1728913097;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5DPNZskkiUAq4LS5OFpU8MIweVBZO51RYIR24GV8o8=;
        b=FwpQpbplvIh36Re6LwXF5hCxK+CYEeY8wDweZLhyvKjBmlmgRcoUGmNUpiUT96Mt14
         9a/kizhhkd3D0bH4DZqr6wtzx0YszxYffKyxvOp4hBE/YtPteUyLF9z3cTHln5Lt6woz
         B296jcp9HsIbpT5y0BBqFIwWeuWOtB9sDbgVei3KCZZKP+9DWZfPoVXgaGsaDudPiNit
         Mflh69Fw80qo/QQXx+Ql3/BOld/rdAgEbwg2482YDftsW6RnNfsvJaIMvd8e62MS/Ugl
         bAQUFbT4drZyhwYB7m1xsBfm7eaxmvrnhv4md8VZ5BJMuQkI/+1pwJdoSZbdq9pn4CNH
         NibA==
X-Forwarded-Encrypted: i=1; AJvYcCVNdX7JVg5+YxXbKJ7ssdMUhHSqedStjfBMkG3/TtPi6Np+OvgIYiFrmX6sbBNHWWi040hy4zYUdoFQBYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWwxNuQ6/DIVAprbYuWlC8JzjqMFAMik2o01cFNvdFEgbE3k+i
	8/v8ulD4w+ssxkgMleQU9DU0kmuEbInWjRtiwKVmPLvS7HjTcgKoU/wEykTg9PWEWd6oJuVmsF2
	zhmm7MdiqSuHeToUZ/PWW4aDp5zTG23yNvHO2NMLpWRrP5p+DWzshhL4g8WDn8Q==
X-Received: by 2002:adf:ea8c:0:b0:374:c287:929b with SMTP id ffacd0b85a97d-37d0e6bb291mr6937299f8f.4.1728308296952;
        Mon, 07 Oct 2024 06:38:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0TwOIoXGhtncVqqSCdfhnggtMr8A9YmeYV2RL1PX3MgPcnG86Oq8dGEM8Qg3X1MoztO3Yqw==
X-Received: by 2002:adf:ea8c:0:b0:374:c287:929b with SMTP id ffacd0b85a97d-37d0e6bb291mr6937277f8f.4.1728308296459;
        Mon, 07 Oct 2024 06:38:16 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f75bsm5766858f8f.23.2024.10.07.06.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:38:16 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kevin Tian <kevin.tian@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, Yiwei
 Zhang <zzyiwei@google.com>, Lai Jiangshan <jiangshanlai@gmail.com>, "Paul
 E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Linux kernel regressions list
 <regressions@lists.linux.dev>
Subject: Re: [PATCH 5/5] KVM: VMX: Always honor guest PAT on CPUs that
 support self-snoop
In-Reply-To: <df3c6560-dd37-4ec2-9b7e-1ad4c3ceba07@leemhuis.info>
References: <20240309010929.1403984-1-seanjc@google.com>
 <20240309010929.1403984-6-seanjc@google.com> <877cbyuzdn.fsf@redhat.com>
 <df3c6560-dd37-4ec2-9b7e-1ad4c3ceba07@leemhuis.info>
Date: Mon, 07 Oct 2024 15:38:15 +0200
Message-ID: <87iku4ghiw.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Linux regression tracking (Thorsten Leemhuis)"
<regressions@leemhuis.info> writes:

> On 30.08.24 11:35, Vitaly Kuznetsov wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> 
>>> Unconditionally honor guest PAT on CPUs that support self-snoop, as
>>> Intel has confirmed that CPUs that support self-snoop always snoop caches
>>> and store buffers.  I.e. CPUs with self-snoop maintain cache coherency
>>> even in the presence of aliased memtypes, thus there is no need to trust
>>> the guest behaves and only honor PAT as a last resort, as KVM does today.
>>>
>>> Honoring guest PAT is desirable for use cases where the guest has access
>>> to non-coherent DMA _without_ bouncing through VFIO, e.g. when a virtual
>>> (mediated, for all intents and purposes) GPU is exposed to the guest, along
>>> with buffers that are consumed directly by the physical GPU, i.e. which
>>> can't be proxied by the host to ensure writes from the guest are performed
>>> with the correct memory type for the GPU.
>> 
>> Necroposting!
>> 
>> Turns out that this change broke "bochs-display" driver in QEMU even
>> when the guest is modern (don't ask me 'who the hell uses bochs for
>> modern guests', it was basically a configuration error :-). E.g:
>> [...]
>
> This regression made it to the list of tracked regressions. It seems
> this thread stalled a while ago. Was this ever fixed? Does not look like
> it, but I might have missed something. Or is this a regression I should
> just ignore for one reason or another?
>

The regression was addressed in by reverting 377b2f359d1f in 6.11

commit 9d70f3fec14421e793ffbc0ec2f739b24e534900
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Sun Sep 15 02:49:33 2024 -0400

    Revert "KVM: VMX: Always honor guest PAT on CPUs that support self-snoop"

Also, there's a (pending) DRM patch fixing it from the guest's side:
https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/9388ccf69925223223c87355a417ba39b13a5e8e

-- 
Vitaly


