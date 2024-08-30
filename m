Return-Path: <linux-kernel+bounces-308916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D73249663AE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C361F2368B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0921B1D40;
	Fri, 30 Aug 2024 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cg4XlUkn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B354E1509BF
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725026789; cv=none; b=YGCpr0gRa8YCzvoEvYRzU73RxoK87iylMAW5aHYRKYwXEY4UBKOPTk07yYKuGgTeeV5SKRHAMCkypia0m9qEpIEXJm5xXeZCfv83bncy04B5VjGJckq0ftOCw2U1Y93iHMDH52uWX6j0H4+b7mqYOVMHkfyPgnNsqMjgUEGd/zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725026789; c=relaxed/simple;
	bh=DST8MfcDGblwIS1eTzURHIFjAr3HHDFnR86/z9ofTp8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jakrhYCd3/XxsyZFb4+GhEKhpMYoFeI0gpX9SVmzp3gNypcOzVw87jhNd5Qlq/y+BWivxPgaFLXtFzkmFmNZtGamD41iIwbbXfhsZ7CaMEL9kAZagWA9ixZt4nWn0PpX8vwT1c3gXjW1u7nbQAu7wIJxNL0jByq2A2MQAqZHe4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cg4XlUkn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725026786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zJ1umHWELLbD6rD5bt9p2nc0aqxMrB9ZCzjKVdabZQs=;
	b=cg4XlUknoRnmZjyV7TEALlaG4bpoVsg0WTH+nBFVLqmFf8qoKEZ1E30BZAjYBfb2huutXT
	HEuMKFwKm5iZcWV8SWA0TaV1brGBGrhYzt9GUG4S8YjV4uVr669DK/Bz8WNVW3cz95KXu1
	j7b5MApHxU/6wYAsN+uH2lA1Yg2SdOo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-a6_akneTN9WgqLB-pVb7_g-1; Fri, 30 Aug 2024 10:06:24 -0400
X-MC-Unique: a6_akneTN9WgqLB-pVb7_g-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42bbd062ac1so5578645e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 07:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725026783; x=1725631583;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zJ1umHWELLbD6rD5bt9p2nc0aqxMrB9ZCzjKVdabZQs=;
        b=M4IX+V6ob7GHKwIsaCIqAX8h/RczkjRlZiHg/oBgPBilmGfv4ATiXz31zfQocXGeKa
         PrQ5o4imFkzO8Y6QM75kvLTzgoEZIp3b+4/Pd08zurYKitY1rRXm9HvoiOYf09WRez1i
         hAyAmLOkrXgxetUOjezrRiqF4IqyPPwvUVrwvkAnCGisnEsBAYvWVEBEpLHI7OZ7jV6+
         a2g4+eJoOryNPEsCrNnllhpJWUI9dvwFKfPi9tuzu4svve68CSD57Mr9zWqGIRvMgM8X
         r2h9j3BfP/HGdocOiI7g9rp3odbiYF2RCdnAN/QQ9I2IIvq9yCROic6hBcKW0hjseG4D
         kX6g==
X-Forwarded-Encrypted: i=1; AJvYcCXQatAkQ5lsQbxEaDFjmAWAnrWVPZOUZTfQ11STXZer72HPfbX4UfLNWNrnJTsf1WPlWmMO8K0xRVar1fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZhZbP6R3jwVGxxVULQMHayqe3nJmzf7Vl2gp1fpZZar3qaQb0
	RAph1RlKYUiFGrW/iQBAl1AMQgQQtE7OTjEDhS+JiUTD4NErebVt5yOcj9eYqgcyD+eRi4JEziB
	92P95P9qYX9XdMVVTlX98AOloK+4ZWakM49smPSgJD8hRFQUugYwjM2xoRnnXHw==
X-Received: by 2002:a05:600c:354b:b0:427:d8fd:42a9 with SMTP id 5b1f17b1804b1-42bb025d668mr49865365e9.22.1725026783575;
        Fri, 30 Aug 2024 07:06:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb7KISbfKwruBPGUn6q1h6/yXfRqmt0s850/4C3zu4HLhm5I+Hjs02kPeQGF3sg0PYgIXh3g==
X-Received: by 2002:a05:600c:354b:b0:427:d8fd:42a9 with SMTP id 5b1f17b1804b1-42bb025d668mr49864715e9.22.1725026782845;
        Fri, 30 Aug 2024 07:06:22 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba639671dsm81832555e9.5.2024.08.30.07.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 07:06:22 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kevin Tian <kevin.tian@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, Yiwei
 Zhang <zzyiwei@google.com>, Lai Jiangshan <jiangshanlai@gmail.com>, "Paul
 E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 5/5] KVM: VMX: Always honor guest PAT on CPUs that
 support self-snoop
In-Reply-To: <ZtHOr-kCqvCdUc_A@google.com>
References: <20240309010929.1403984-1-seanjc@google.com>
 <20240309010929.1403984-6-seanjc@google.com> <877cbyuzdn.fsf@redhat.com>
 <vuwlkftomgsnzsywjyxw6rcnycg3bve3o53svvxg3vd6xpok7o@k4ktmx5tqtmz>
 <871q26unq8.fsf@redhat.com> <ZtHOr-kCqvCdUc_A@google.com>
Date: Fri, 30 Aug 2024 16:06:21 +0200
Message-ID: <87seumt89u.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Aug 30, 2024, Vitaly Kuznetsov wrote:
>> Gerd Hoffmann <kraxel@redhat.com> writes:
>> 
>> >> Necroposting!
>> >> 
>> >> Turns out that this change broke "bochs-display" driver in QEMU even
>> >> when the guest is modern (don't ask me 'who the hell uses bochs for
>> >> modern guests', it was basically a configuration error :-). E.g:
>> >
>> > qemu stdvga (the default display device) is affected too.
>> >
>> 
>> So far, I was only able to verify that the issue has nothing to do with
>> OVMF and multi-vcpu, it reproduces very well with
>> 
>> $ qemu-kvm -machine q35,accel=kvm,kernel-irqchip=split -name guest=c10s
>> -cpu host -smp 1 -m 16384 -drive file=/var/lib/libvirt/images/c10s-bios.qcow2,if=none,id=drive-ide0-0-0
>> -device ide-hd,bus=ide.0,unit=0,drive=drive-ide0-0-0,id=ide0-0-0,bootindex=1
>> -vnc :0 -device VGA -monitor stdio --no-reboot
>> 
>> Comparing traces of working and broken cases, I couldn't find anything
>> suspicious but I may had missed something of course. For now, it seems
>> like a userspace misbehavior resulting in a segfault.
>
> Guest userspace?
>

Yes? :-) As Gerd described, video memory is "mapped into userspace so
the wayland / X11 display server can software-render into the buffer"
and it seems that wayland gets something unexpected in this memory and
crashes. 

-- 
Vitaly


