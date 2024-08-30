Return-Path: <linux-kernel+bounces-308893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EF2966357
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6348284882
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238711758F;
	Fri, 30 Aug 2024 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+54MZ/s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEA1288DB
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725025639; cv=none; b=eV9JvU2BLPsCLt1bPtNxSJzUE4n5R2LZHhZ3qBz2C+pKKKpoSfkQDjDVSZ5kO6gvWL7kn2dkwYxE8JTFi9KkTW1uCMkvgmlqsjqzhOszlhTsmzHoTwQhtobhpHnDMJyVA5xwch/o5f9z0nXaTli8DUat8TuN8YAxJkDQ2uba624=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725025639; c=relaxed/simple;
	bh=OTpeEh2C+pBjQpLMmSeYbGjDRsZ/FIDacZjxriqKcCU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HcbJjKHPJv9XPms7haI5J1BdtMlMU53tArGryw/uFpgGrWO5kvpdgvwWQmG45KJ0Z51QbSSNWovP5NS+x/ZlcD9QMw6tu/6ppIEOGC3TxBUw31cqzt/0NHfvYF9He5hoYdgmtynQ2Ro9K6FkHqmNtHfOTxbmHDNdfgyr6IF+zMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L+54MZ/s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725025636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VGA3KUuJjgRSpXeQ3xka2KCdJ1cKZa0/v3QiIokE+Z4=;
	b=L+54MZ/sbsdzRTBx8iVlW2UUaAHpjto8nr53ma2p7j/thyFR7Usv50mZa5sVpRjJa1nJsw
	hyTMJCqbpB3p5V3D9BZ5w5w0pyo6n998TY6DWX4rGdgaabh8i68qAPF3HA7y2B8FSEMk9S
	h2Es8f810SqzGV8IPtCcwaRXSI7ZjRc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-_rKuUFmOMqu7bX3bTNuoSw-1; Fri, 30 Aug 2024 09:47:14 -0400
X-MC-Unique: _rKuUFmOMqu7bX3bTNuoSw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374bacd5cccso53975f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725025633; x=1725630433;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VGA3KUuJjgRSpXeQ3xka2KCdJ1cKZa0/v3QiIokE+Z4=;
        b=RA3ZHu6ceBYO7G7Ae1hb81gTHTZnirlV69FtqvLJQbOLXa9LZQFN5naUhlxg1j+NMk
         TwVtnazhTvsPb+eJhuPWJcSu+4qyLBDQTEDMTas9W3RsWeZ9hnCwbund44iXh5zbwMmj
         tX3UwwwnANkDwcVYGZU3fiAb/L7UIBaubh8OveAH5ln7PJg0u1SBeE6hgzLoxSvHZ4dE
         g0Ncl+uF14JMwENYagwsa3t67syPiXOec8fjK4B6JWH2sCGy8k8aPv6bXukmZ8+mI0Zz
         AAt+dH5NaY7J3s7Q/sZmwXS6nmcLhVrj91V1NUNE1bJDtQQ4G0QAuGUvyS4F9DbbQIgh
         5CCA==
X-Forwarded-Encrypted: i=1; AJvYcCVj+aCHToJpUTCfhnM9rIihwX/awwnqezF1CUBJDlQUj6+LSWL2lCNWFfoY/FH2XIxy7QkMoKwnO8aZHSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFKpbIK51UnShCDkzMr920d2qUDvAOaxST8X+hOJI6WNefnrq3
	enOSaPw+9r//3pP6mQvcfRPPZjzNlj5HXFu7r7HhfJu2XqdRHZmQeflGwEaPtSaC9fIxCDuW0SN
	1wR+SL8N3ca9O3wLOrtWeaoaU7CV9pun5MrbPP4B/e9BH2xHu89S4vMB4FHhVcw==
X-Received: by 2002:adf:b356:0:b0:368:6561:daba with SMTP id ffacd0b85a97d-374a95a0047mr1711071f8f.31.1725025633507;
        Fri, 30 Aug 2024 06:47:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXFfCyeKQTszCb1/6emJitppLXl0Ycds2dYm+zjh0Z/QfOM72vXtp88r7gHPjkSfi/i5eFdw==
X-Received: by 2002:adf:b356:0:b0:368:6561:daba with SMTP id ffacd0b85a97d-374a95a0047mr1711044f8f.31.1725025632994;
        Fri, 30 Aug 2024 06:47:12 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374b9859486sm703874f8f.111.2024.08.30.06.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 06:47:12 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Tian
 <kevin.tian@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, Yiwei Zhang
 <zzyiwei@google.com>, Lai Jiangshan <jiangshanlai@gmail.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 5/5] KVM: VMX: Always honor guest PAT on CPUs that
 support self-snoop
In-Reply-To: <vuwlkftomgsnzsywjyxw6rcnycg3bve3o53svvxg3vd6xpok7o@k4ktmx5tqtmz>
References: <20240309010929.1403984-1-seanjc@google.com>
 <20240309010929.1403984-6-seanjc@google.com> <877cbyuzdn.fsf@redhat.com>
 <vuwlkftomgsnzsywjyxw6rcnycg3bve3o53svvxg3vd6xpok7o@k4ktmx5tqtmz>
Date: Fri, 30 Aug 2024 15:47:11 +0200
Message-ID: <871q26unq8.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gerd Hoffmann <kraxel@redhat.com> writes:

>> Necroposting!
>> 
>> Turns out that this change broke "bochs-display" driver in QEMU even
>> when the guest is modern (don't ask me 'who the hell uses bochs for
>> modern guests', it was basically a configuration error :-). E.g:
>
> qemu stdvga (the default display device) is affected too.
>

So far, I was only able to verify that the issue has nothing to do with
OVMF and multi-vcpu, it reproduces very well with

$ qemu-kvm -machine q35,accel=kvm,kernel-irqchip=split -name guest=c10s
-cpu host -smp 1 -m 16384 -drive file=/var/lib/libvirt/images/c10s-bios.qcow2,if=none,id=drive-ide0-0-0
-device ide-hd,bus=ide.0,unit=0,drive=drive-ide0-0-0,id=ide0-0-0,bootindex=1
-vnc :0 -device VGA -monitor stdio --no-reboot

Comparing traces of working and broken cases, I couldn't find anything
suspicious but I may had missed something of course. For now, it seems
like a userspace misbehavior resulting in a segfault.

-- 
Vitaly


