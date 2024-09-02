Return-Path: <linux-kernel+bounces-310986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A41D2968399
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560D2284B47
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5CC1D3188;
	Mon,  2 Sep 2024 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gD2DI/t2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FEC185B4D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270590; cv=none; b=fjyVhU3ylhFrLFUFHl4MnfZuzlpViUUdMJb4Ffqzm1OWu+XTGBlEhdIWg2clAl0TO3XgquuDYaRWmMbmDM+RWcs9Duv/C2oZT2qxtRkKXOHKDMI+rMAuI/4gYrDD77cdtbocsbD60HSBNkuTVET8LVxvmJzHRPjZQxIVCD3ZxFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270590; c=relaxed/simple;
	bh=KZv12tXQ7Ae+zRYsrJ68sOXS+Y6FjYoLo/QTKqzXC7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h2PKRPCUpPI82WPKD+VbWJTh/nsEM3KvML8uDw3IuaEQB0UdotI/HH0cpvjMts0zbLxlrQMiPSLZYMtEFomtiVkuz5BkpA8vD5Nk95v3c/BVeGli41AjNj+6FGQeLAHnZ/+J71Ub9v/vRmmxYf137Mg3QdLQhhNWsodqt5mZIyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gD2DI/t2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725270587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xwvb2AWA7eVmy/sHZX0Bb9r5Lm4OndnUkdzBfReb458=;
	b=gD2DI/t2n68SGne8gbyscaZ/iihhgamujY5x7bDVmDa4RmxWUh41EPQn0V5dzIDqZmUSad
	nwz2ABGf/8m1DKr5uopsh3birz4YzpwuuhWJOsKkiMvTI5PCh9rOBqsVZ1IMgTquI5Qkvj
	NJ8V3XIC07P6zEe2szeMHTq+Z3DBZNY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-Rv6rWzhdOTCyZ5YqZQ8UXA-1; Mon, 02 Sep 2024 05:49:46 -0400
X-MC-Unique: Rv6rWzhdOTCyZ5YqZQ8UXA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42bbff6a0aeso22701255e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 02:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725270585; x=1725875385;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xwvb2AWA7eVmy/sHZX0Bb9r5Lm4OndnUkdzBfReb458=;
        b=lrC6hD1IimSsNA4/CWnNr6WNR/4nEUPYMQlwRYuxyyiX4jE+pCLKguM6oAKioezk2R
         7bR7OyCuu8fCFyh4LVohOsqRauSuFbh+HznvFWUTwm15WDRabs2g4IXaw9T79hJlMwkI
         OMDlSkMC3tNeq1/gOVMBARX2MfAsgDMrs0MAkrYfcxj9u5h0W8YrV+MuL5h7ubG4Rm9H
         xZCSbUvXOAfO0ONCwc0M+GhWFE89zMp3NVnfBvY4VqcMNpZXg1/1OQrEcdtF+R09EW65
         l5jQj8bxNyshLCLka7tWrml6UJO30oXAxRjMskxSHCy/x2IQw+OYfeeH4uWZ8kAmrMuN
         Z8PA==
X-Forwarded-Encrypted: i=1; AJvYcCXi8dhamzwRRJgC/V8J8UgyKmmtUvAWIk5U8uFw8ixQ2CbUtOAH0XdQwedRTmtE5m075G4c5a+6mvnpDC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ2d6zSdlIulti70d52oKUenvKzUBkZnlYjRjS4etlo3Mch80h
	qyqWpyoBgmGoUL8DIYPMn+QWW4x0mT6OYGs9dBsg0ySsXPb8koIOjHaUDzXr1z026u9Eb52OT9z
	Nk1ubeEuRAZVKp19eMAPplCqwQ4lvRrm7724aQUojrzROrc4aWyAlVIdpyg5Nfw==
X-Received: by 2002:a05:600c:3b10:b0:427:d8f2:5dee with SMTP id 5b1f17b1804b1-42bb01bb04dmr111112165e9.15.1725270585148;
        Mon, 02 Sep 2024 02:49:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoisozxrjMiMstc04ii3IHXZ5avpiUSmtW6ilZT9rJxbJYQH/vbEz5NOB2xaZIwZYx1LEn0g==
X-Received: by 2002:a05:600c:3b10:b0:427:d8f2:5dee with SMTP id 5b1f17b1804b1-42bb01bb04dmr111112025e9.15.1725270584587;
        Mon, 02 Sep 2024 02:49:44 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bacaac810sm151114855e9.33.2024.09.02.02.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 02:49:44 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kevin Tian <kevin.tian@intel.com>, Yiwei Zhang <zzyiwei@google.com>, Lai
 Jiangshan <jiangshanlai@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 5/5] KVM: VMX: Always honor guest PAT on CPUs that
 support self-snoop
In-Reply-To: <ZtUYZE6t3COCwvg0@yzhao56-desk.sh.intel.com>
References: <20240309010929.1403984-1-seanjc@google.com>
 <20240309010929.1403984-6-seanjc@google.com> <877cbyuzdn.fsf@redhat.com>
 <vuwlkftomgsnzsywjyxw6rcnycg3bve3o53svvxg3vd6xpok7o@k4ktmx5tqtmz>
 <871q26unq8.fsf@redhat.com> <ZtUYZE6t3COCwvg0@yzhao56-desk.sh.intel.com>
Date: Mon, 02 Sep 2024 11:49:43 +0200
Message-ID: <87jzfutmfc.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yan Zhao <yan.y.zhao@intel.com> writes:

> On Fri, Aug 30, 2024 at 03:47:11PM +0200, Vitaly Kuznetsov wrote:
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
> Could you please share steps launch the broken guest desktop?
> (better also with guest kernel version, name of desktop processes,
>  name of X server)

I think the easiest would be to download the latest Centos Stream 10
iso, e.g:

https://composes.stream.centos.org/stream-10/development/CentOS-Stream-10-20240902.d.0/compose/BaseOS/x86_64/iso/CentOS-Stream-10-20240902.d.0-x86_64-dvd1.iso
(the link is probably not eternal but should work for a couple weeks,
check https://composes.stream.centos.org/stream-10/development/ it it
doesn't work anymore).

Then, just run it:
$ /usr/libexec/qemu-kvm -machine q35,accel=kvm,kernel-irqchip=split -name guest=c10s -cpu host -smp 1 -m 16384 -cdrom CentOS-Stream-10-20240902.d.0-x86_64-dvd1.iso -vnc :0 -device VGA -monitor stdio --no-reboot

and connect to VNC console. To speed things up, pick 'Install Centos
Stream 10' in the boot menu to avoid ISO integrity check.

With "KVM: VMX: Always honor guest PAT on CPUs that support self-snoop"
commit included, you will see the following on the VNC console:
installer tries starting Wayland, crashes and drops back into text
console. If you revert the commit and start over, Wayland will normally
start and you will see the installer.

If the installer environment is inconvenient for debugging, then you can
install in text mode (or with the commit reverted :-) and then the same
problem will be observed when gdm starts.

FWIW, I use QEMU-9.0 from the same C10S (qemu-kvm-9.0.0-7.el10.x86_64)
but I don't think it matters in this case. My CPU is "Intel(R) Xeon(R)
Silver 4410Y".

-- 
Vitaly


