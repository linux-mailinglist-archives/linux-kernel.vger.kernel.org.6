Return-Path: <linux-kernel+bounces-274582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D5D947A51
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1062DB21F5E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E88915666C;
	Mon,  5 Aug 2024 11:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPlW1UD+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278BA14F9F7
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722856612; cv=none; b=km/nM3tpZMaqGd+pjnhzHZHoP3cgVFHQXdM9armrHbGwsi9DNhH8E6ZOAiPfXE92GDnzpw1RYNb5bBlwG3a7xAkAeKywhM/YiNRvIn5giKvwDJ/LcnmLLlcYGF6X9ORRk+D73my+P5QvyZBGydHhobLSuvBSBMVH7BjENqOSliY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722856612; c=relaxed/simple;
	bh=oTr2SjdGsujyoWN7R4XglVpcySYwa/ZBQP+kX/X7ddw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YdHIW5mXh1ydgmQF9pbuPp95ZuMyXJ9i0+oDhN+3VteaSRR4Y6a0s3yTn0wKON3PwKHWWMl2gnd+NnoQd8zZDXcT7iHB6Oi4lw2rcNbEW31TVO1SlOFnP/Hyb886UXHM9aTRNtz6sXOlle0c/T+85dGIbtudSB7yhpctLDMe7rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPlW1UD+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722856609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+x9m6YrOjrozlbNzpN4lv2HeQ5ydPGv5W1u14KLn3Oc=;
	b=LPlW1UD+WujI5aG/FMgyI+5CxACt6eFmEB9qSI5U4Xy0iXVi0MyVs3aF+Fj50fkh7QU7ep
	f74sWcdQHwv/yMinxKTN+NZHFDWpDxYfokudoLVsQegQHaHWGHIyz4Kel9NmlEnlVYLZk4
	DxzwP2uqnqCU3JgAP/6n3Mrm4/V5f4o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-yOxoEKwIMWKt1jr2h5tDew-1; Mon, 05 Aug 2024 07:16:47 -0400
X-MC-Unique: yOxoEKwIMWKt1jr2h5tDew-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-427b7a2052bso102639565e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 04:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722856607; x=1723461407;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+x9m6YrOjrozlbNzpN4lv2HeQ5ydPGv5W1u14KLn3Oc=;
        b=Z3gkOK4wm99Msp8wvcyPv1O/phHVTN0nocPvZqgH4flhpu46dFdylSTyrJmBoijnWh
         BsE7+cGuKWpvnfSjdbWVIQjcyXbWC4xFfw+64ghGfH03zEVuZTYSuMyQFf9mTNJmrRDN
         Gy2b91FQApuX4lYpM6gF6d8+3PPRfpzenOWCrRGOqWP9INKBYtyxfaOsNgDF5yf4Vh2Q
         Yq4hsn8XLuZ4EmuJSndftPjdyf5fZ2W5yKkQteKOpWBLEobTBmMg5b8xfkhYAglem017
         KAYop+2XYwBe9uJ6P58SGun/SvUsVYUTIaqpsrShNck9dEp0S1y9Sqo/0k9EMIBvCjYT
         qnjw==
X-Forwarded-Encrypted: i=1; AJvYcCVMnk3/deAScwkq//JJv7qz2EJIZlLRa9loHP//GhSFz4xNrNMhbz0iMz7tIk12G3n7b1+/h1CFLsf4fH8IKW1kah9t0uP/E1oXDu2Q
X-Gm-Message-State: AOJu0YzqeGekPVKES+zBaJ/mdT1LkWSclXOg6dIKTAEliiipqyX+LKNr
	uXxHn/ma/zlXAovzlr72T8ENXNH3aptbXUvfvo2hxkIHQ+THd8xUqlDz0uoW4VvuQieQju9vrKs
	D+QXCt2NPdpv++G8YNwYf4La+iAoUFQrzdjhUOvjX5dSmJhxYenOttJ7IT252Ng==
X-Received: by 2002:a05:600c:35ca:b0:426:545b:ec00 with SMTP id 5b1f17b1804b1-428e6b2f0c5mr103368305e9.19.1722856606647;
        Mon, 05 Aug 2024 04:16:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRKiPjgHhD5wvF3Kx6rwG0AB9MiZixpH2Ek6z6clwUbTcyIXrs1+dITYkfWb4UHnSx5S2h3g==
X-Received: by 2002:a05:600c:35ca:b0:426:545b:ec00 with SMTP id 5b1f17b1804b1-428e6b2f0c5mr103368055e9.19.1722856606239;
        Mon, 05 Aug 2024 04:16:46 -0700 (PDT)
Received: from intellaptop.lan ([2a06:c701:778d:5201:3e8a:4c9c:25dd:6ccc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6d643a4sm135473615e9.2.2024.08.05.04.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 04:16:45 -0700 (PDT)
Message-ID: <f358c9b92095e628dbccd7af2f084d7c07206962.camel@redhat.com>
Subject: Re: [PATCH v2 40/49] KVM: x86: Initialize guest cpu_caps based on
 KVM support
From: mlevitsk@redhat.com
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>,  kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>,
 Oliver Upton <oliver.upton@linux.dev>, Binbin Wu
 <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>,
 Robert Hoo <robert.hoo.linux@gmail.com>
Date: Mon, 05 Aug 2024 14:16:44 +0300
In-Reply-To: <Zqe2n4e4HtdgUWgm@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-41-seanjc@google.com>
	 <030c973172dcf3a24256ddc8ddc5e9ef57ecabcb.camel@redhat.com>
	 <Zox_4OoDmGDHOaSA@google.com>
	 <f9b2f9e949a982e07c9ea5ead316ab3809e40543.camel@redhat.com>
	 <Zqe2n4e4HtdgUWgm@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

=D0=A3 =D0=BF=D0=BD, 2024-07-29 =D1=83 08:34 -0700, Sean Christopherson =D0=
=BF=D0=B8=D1=88=D0=B5:
> > On Wed, Jul 24, 2024, Maxim Levitsky wrote:
> > > > On Mon, 2024-07-08 at 17:10 -0700, Sean Christopherson wrote:
> > > > > > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > > > > > index 0e64a6332052..dbc3f6ce9203 100644
> > > > > > --- a/arch/x86/kvm/cpuid.c
> > > > > > +++ b/arch/x86/kvm/cpuid.c
> > > > > > @@ -448,7 +448,7 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vc=
pu *vcpu)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!entry)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 continue;
> > > > > > =C2=A0
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 cpuid_func_emulated(&emulated, cpuid.function);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 cpuid_func_emulated(&emulated, cpuid.function, fal=
se);
> > > > > > =C2=A0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * A vCPU has a feature if it's supported =
by KVM and is enabled
> > > > > > @@ -1034,7 +1034,8 @@ static struct kvm_cpuid_entry2 *do_host_c=
puid(struct kvm_cpuid_array *array,
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return entry;
> > > > > > =C2=A0}
> > > > > > =C2=A0
> > > > > > -static int cpuid_func_emulated(struct kvm_cpuid_entry2 *entry,=
 u32 func)
> > > > > > +static int cpuid_func_emulated(struct kvm_cpuid_entry2 *entry,=
 u32 func,
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool only_advertised)
> > > >=20
> > > > I'll say, lets call this boolean, 'include_partially_emulated',=20
> > > > (basically features that kvm emulates but only partially,
> > > > and thus doesn't advertise, aka mwait)
> > > >=20
> > > > and then it doesn't look that bad, assuming that comes with a comme=
nt.
> >=20
> > Works for me.=C2=A0 I was trying to figure out a way to say "emulated_o=
n_ud", but I
> > can't get the polarity right, at least not without ridiculous verbosity=
.=C2=A0 E.g.
> > include_not_emulated_on_ud is awful.
> >=20

Thanks,
Best regards,
	Maxim Levitsky


