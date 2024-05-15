Return-Path: <linux-kernel+bounces-180363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C02718C6D76
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 23:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37AE1C21ED3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB8715B10E;
	Wed, 15 May 2024 21:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VY1WByXe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FA5158DD8
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 21:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715807023; cv=none; b=TImCGtcBRIrbekK6y+s2cwzuOAXSdYh7+sov/8Ji4zrJo+1TNdRBrqUaV4a4LyntyiMDzGkiutUlUioK5xsmqGZ5NNbM3dXhveCW+bPbkGFtL1j4kUrrZkfdqEsMi/czxUyTcr1GPFACnnLIR4VTw4wjThB2D80MGp1kGyARFI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715807023; c=relaxed/simple;
	bh=v4fYS1RN+A3001h4gPdRNP37c1LHlJOy58nJtSXM+iI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SwtZSTDIycMpUM2GACy56dZPjO6+vg6ecxF05/3I22EPCnc3JVtfGqIF8pDihsMXpDa4mMxFetP8Oqmq3++xPjedaoaGc8RgnrCk4+hqoAICFicZBF3DTskGwS1cIx4ecPoDsn4oXZcz0V7iqCXLIO76ynAy0SBxxDE2hJmczIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VY1WByXe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715807020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1f1v8XJYpAEVpbxVbnSTDiAhuB4qr2c5YdAEr2f08Q=;
	b=VY1WByXeFnOWg3Dzj5Lyu3hMhbJSPx3l0DXHn9aNF4rKyuGzC3SW7NK4mZabx3PIGTssA/
	5AmIHvqWeKQX9JiETalcTr/+AyUinXWJ/lsymZQ0Z0W/7Z4V4Xo0bnYCwpXZc7j2+S2pKN
	eZ4bgbMSJFLWCSkWEiBSYPBcaPXXjCU=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-zcpsPHAvPqaWxs57q1742Q-1; Wed, 15 May 2024 17:03:39 -0400
X-MC-Unique: zcpsPHAvPqaWxs57q1742Q-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-622d157d9fbso69342967b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715807018; x=1716411818;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y1f1v8XJYpAEVpbxVbnSTDiAhuB4qr2c5YdAEr2f08Q=;
        b=PGxP8H2smkHTKz/1xXUHII7DG+SHv9SSUZ+siE41FqCGEVVs84r1eT1v0aOXnYLp1E
         VKbvFUCPxW/mVQDcWLj64TDlprY0XD7kd0cHuw3tGDuDgW6b8ajCX44EkFIUxA3rK1Xg
         bztBh94baPN7Z9t78IWPgQrawSi5ids+x4XvxT6463bb5p5XDW8t5T1ILx8JhQaPUyfL
         QhGz5HN+42frvAtFVxz9ajFGntAwL0st1c4dgyyBWzCqE8bJY/TSsMaPQaLKO11hoMIs
         pDDL5aXsPPqvTJ0ITIXEsStBnCdXZlHK4CmwvdxZiIQOuZUmBF5aVi/USZ+0deZnYKAA
         v+tw==
X-Forwarded-Encrypted: i=1; AJvYcCV2q1v/mZQmGFpctY0xOGzszKHuKc6bi2ntL7n1wOzvUtGu5xBwOQGNW6kw/9O91LKsO8QFPd8ev0cCWXuvQLnH+uKcYDHsSx7wieKk
X-Gm-Message-State: AOJu0YwxL+BGQEFvoAPjJXKkbdHhoNLcguHQB4aJKEs1FXMPE37WkufG
	lqIek2JV/qTtNNZT5iwDxBK1ls0noRBKuTB2SifGuK8e0O05dLCsrT7Gfjz78h1T9LLWpx1XlUI
	G3eEvF/jplKQQ7DcoWDUTG3sOO+R1biDjAXNjf5ZObUyvXk3rkxjcL3xf+1gzcS00nGhOiQ==
X-Received: by 2002:a81:9149:0:b0:61b:418:139 with SMTP id 00721157ae682-622afff635bmr156633907b3.27.1715807016661;
        Wed, 15 May 2024 14:03:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHry4v9XZCuzTQKM54tgzIGwvbMt/qrmc7oNguw8imoK5prI9zSyKZLvps3MKzQWTP496n6PA==
X-Received: by 2002:a81:9149:0:b0:61b:418:139 with SMTP id 00721157ae682-622afff635bmr156633557b3.27.1715807016205;
        Wed, 15 May 2024 14:03:36 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df56b1651sm86999151cf.76.2024.05.15.14.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 14:03:35 -0700 (PDT)
Message-ID: <7cb1aec718178ee9effe1017dad2ef7ab8b2a714.camel@redhat.com>
Subject: Re: RFC: NTP adjustments interfere with KVM emulation of TSC
 deadline timers
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Jim Mattson <jmattson@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Paolo Bonzini
 <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Marc
 Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Vitaly
 Kuznetsov <vkuznets@redhat.com>
Date: Wed, 15 May 2024 17:03:34 -0400
In-Reply-To: <CALMp9eQcRF_oS2rc_xF1H3=pfHB7ggts44obZgvh-K03UYJLSQ@mail.gmail.com>
References: <20c9c21619aa44363c2c7503db1581cb816a1c0f.camel@redhat.com>
	 <CALMp9eSy2r+iUzqHV+V2mbPaPWfn=Y=a1aM+9C65PGtE0=nGqA@mail.gmail.com>
	 <481be19e33915804c855a55181c310dd8071b546.camel@redhat.com>
	 <CALMp9eQcRF_oS2rc_xF1H3=pfHB7ggts44obZgvh-K03UYJLSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-01-02 at 15:49 -0800, Jim Mattson wrote:
> On Tue, Jan 2, 2024 at 2:21 PM Maxim Levitsky <mlevitsk@redhat.com> wrote:
> > On Thu, 2023-12-21 at 11:09 -0800, Jim Mattson wrote:
> > > On Thu, Dec 21, 2023 at 8:52 AM Maxim Levitsky <mlevitsk@redhat.com> wrote:
> > > > Hi!
> > > > 
> > > > Recently I was tasked with triage of the failures of 'vmx_preemption_timer'
> > > > that happen in our kernel CI pipeline.
> > > > 
> > > > 
> > > > The test usually fails because L2 observes TSC after the
> > > > preemption timer deadline, before the VM exit happens.
> > > > 
> > > > This happens because KVM emulates nested preemption timer with HR timers,
> > > > so it converts the preemption timer value to nanoseconds, taking in account
> > > > tsc scaling and host tsc frequency, and sets HR timer.
> > > > 
> > > > HR timer however as I found out the hard way is bound to CLOCK_MONOTONIC,
> > > > and thus its rate can be adjusted by NTP, which means that it can run slower or
> > > > faster than KVM expects, which can result in the interrupt arriving earlier,
> > > > or late, which is what is happening.
> > > > 
> > > > This is how you can reproduce it on an Intel machine:
> > > > 
> > > > 
> > > > 1. stop the NTP daemon:
> > > >       sudo systemctl stop chronyd.service
> > > > 2. introduce a small error in the system time:
> > > >       sudo date -s "$(date)"
> > > > 
> > > > 3. start NTP daemon:
> > > >       sudo chronyd -d -n  (for debug) or start the systemd service again
> > > > 
> > > > 4. run the vmx_preemption_timer test a few times until it fails:
> > > > 
> > > > 
> > > > I did some research and it looks like I am not the first to encounter this:
> > > > 
> > > > From the ARM side there was an attempt to support CLOCK_MONOTONIC_RAW with
> > > > timer subsystem which was even merged but then reverted due to issues:
> > > > 
> > > > https://lore.kernel.org/all/1452879670-16133-3-git-send-email-marc.zyngier@arm.com/T/#u
> > > > 
> > > > It looks like this issue was later worked around in the ARM code:
> > > > 
> > > > 
> > > > commit 1c5631c73fc2261a5df64a72c155cb53dcdc0c45
> > > > Author: Marc Zyngier <maz@kernel.org>
> > > > Date:   Wed Apr 6 09:37:22 2016 +0100
> > > > 
> > > >     KVM: arm/arm64: Handle forward time correction gracefully
> > > > 
> > > >     On a host that runs NTP, corrections can have a direct impact on
> > > >     the background timer that we program on the behalf of a vcpu.
> > > > 
> > > >     In particular, NTP performing a forward correction will result in
> > > >     a timer expiring sooner than expected from a guest point of view.
> > > >     Not a big deal, we kick the vcpu anyway.
> > > > 
> > > >     But on wake-up, the vcpu thread is going to perform a check to
> > > >     find out whether or not it should block. And at that point, the
> > > >     timer check is going to say "timer has not expired yet, go back
> > > >     to sleep". This results in the timer event being lost forever.
> > > > 
> > > >     There are multiple ways to handle this. One would be record that
> > > >     the timer has expired and let kvm_cpu_has_pending_timer return
> > > >     true in that case, but that would be fairly invasive. Another is
> > > >     to check for the "short sleep" condition in the hrtimer callback,
> > > >     and restart the timer for the remaining time when the condition
> > > >     is detected.
> > > > 
> > > >     This patch implements the latter, with a bit of refactoring in
> > > >     order to avoid too much code duplication.
> > > > 
> > > >     Cc: <stable@vger.kernel.org>
> > > >     Reported-by: Alexander Graf <agraf@suse.de>
> > > >     Reviewed-by: Alexander Graf <agraf@suse.de>
> > > >     Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > > >     Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> > > > 
> > > > 
> > > > So to solve this issue there are two options:
> > > > 
> > > > 
> > > > 1. Have another go at implementing support for CLOCK_MONOTONIC_RAW timers.
> > > >    I don't know if that is feasible and I would be very happy to hear a feedback from you.
> > > > 
> > > > 2. Also work this around in KVM. KVM does listen to changes in the timekeeping system
> > > >   (kernel calls its update_pvclock_gtod), and it even notes rates of both regular and raw clocks.
> > > > 
> > > >   When starting a HR timer I can adjust its period for the difference in rates, which will in most
> > > >   cases produce more correct result that what we have now, but will still fail if the rate
> > > >   is changed at the same time the timer is started or before it expires.
> > > > 
> > > >   Or I can also restart the timer, although that might cause more harm than
> > > >   good to the accuracy.
> > > > 
> > > > 
> > > > What do you think?
> > > 
> > > Is this what the "adaptive tuning" in the local APIC TSC_DEADLINE
> > > timer is all about (lapic_timer_advance_ns = -1)?
> > 
> > Hi,
> > 
> > I don't think that 'lapic_timer_advance' is designed for that but it does
> > mask this problem somewhat.
> > 
> > The goal of 'lapic_timer_advance' is to decrease time between deadline passing and start
> > of guest timer irq routine by making the deadline happen a bit earlier (by timer_advance_ns), and then busy-waiting
> > (hopefully only a bit) until the deadline passes, and then immediately do the VM entry.
> > 
> > This way instead of overhead of VM exit and VM entry that both happen after the deadline,
> > only the VM entry happens after the deadline.
> > 
> > 
> > In relation to NTP interference: If the deadline happens earlier than expected, then
> > KVM will busy wait and decrease the 'timer_advance_ns', and next time the deadline
> > will happen a bit later thus adopting for the NTP adjustment somewhat.
> > 
> > Note though that 'timer_advance_ns' variable is unsigned and adjust_lapic_timer_advance can underflow
> > it, which can be fixed.
> > 
> > Now if the deadline happens later than expected, then the guest will see this happen,
> > but at least adjust_lapic_timer_advance should increase the 'timer_advance_ns' so next
> > time the deadline will happen earlier which will also eventually hide the problem.
> > 
> > So overall I do think that implementing the 'lapic_timer_advance' for nested VMX preemption timer
> > is a good idea, especially since this feature is not really nested in some sense - the timer is
> > just delivered as a VM exit but it is always delivered to L1, so VMX preemption timer can
> > be seen as just an extra L1's deadline timer.
> > 
> > I do think that nested VMX preemption timer should use its own value of timer_advance_ns, thus
> > we need to extract the common code and make both timers use it. Does this make sense?
> 
> Alternatively, why not just use the hardware VMX-preemption timer to
> deliver the virtual VMX-preemption timer?
> 
> Today, I believe that we only use the hardware VMX-preemption timer to
> deliver the virtual local APIC timer. However, it shouldn't be that
> hard to pick the first deadline of {VMX-preemption timer, local APIC
> timer} at each emulated VM-entry to L2.

I assume that this is possible but it might add some complexity.

AFAIK the design choice here was that L1 uses the hardware VMX preemption timer always,
while L2 uses the software preemption timer which is relatively simple.

I do agree that this might work and if it does work it might be even worthwhile
change on its own.

If you agree that this is a good idea, I can prepare a patch series for that.

Note though that the same problem (although somewhat masked by lapic_timer_advance)
does exit on AMD as well because while AMD lacks both VMX preemption timer and even the TSC deadline timer,
KVM exposes TSC deadline to the guest, and HR timers are always used for its emulation,
and are prone to NTP interference as I discovered.

Best regards,
	Maxim Levitsky

> 
> > Best regards,
> >         Maxim Levitsky
> > 
> > 
> > >  If so, can we
> > > leverage that for the VMX-preemption timer as well?
> > > > Best regards,
> > > >         Maxim Levitsky
> > > > 
> > > > 
> > > > 
> > 
> > 
> > 





