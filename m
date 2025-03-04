Return-Path: <linux-kernel+bounces-544495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19609A4E200
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E6C1794C7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B187B204879;
	Tue,  4 Mar 2025 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHAyhl/A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B54206F1F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099644; cv=none; b=TyM15LgUDGJSwpnOXrSvE6Q3YhSA8qYDTVR919zxCVWeDWhrxg3BZL+ckqUx/y0ZRh2WeieYbvQU2tOaScdzCjt3GN5xkGgmVVRdaYskEZTEoMXhlqYU4fN1nuhXbGlsMiPTUH3D87Y8EO/rqFV9nVr1sZUHXBLRFFYj+9DGnY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099644; c=relaxed/simple;
	bh=whg8HCG6UdI1zul2/4LLXqTnV2vRgYauL8+q1OhMI8E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NAV41oSdc3Gz9C+ctmz46y4S1WN3mzYUlJVOBiAVqYgLO2mujItkyRIOaFUmSA87TGEH+ZEi0JnAnlMEp5y1TT9W/+8pKh915oAgVRWKticuI6Int0GQFc+tQa2QI4zLBjK485CrGPdVNNJUwTB8di12VaPRfitBMn29+C/vZho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hHAyhl/A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741099639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xKaITwIjY8bRG3Gkr5ECFSqk2O5WBX0rcvQdhZB+9fQ=;
	b=hHAyhl/A+2uVs5sO9dXJ/87phTlIGBFl/cEbiSg/rakO7IQAHkgDg2jcdfuzVfkEz6JICf
	QJWVNjhR5oHs6+crlW43ammUziwfuoGZZD57zWz5L8C/s3iX3akoo1j93Svh0LykFM3cLi
	U6/rN8UZ2hLBqchNB7E643ePE464LKw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-zB2N0qzNNheCItRoZw3z9Q-1; Tue, 04 Mar 2025 09:47:15 -0500
X-MC-Unique: zB2N0qzNNheCItRoZw3z9Q-1
X-Mimecast-MFC-AGG-ID: zB2N0qzNNheCItRoZw3z9Q_1741099634
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43bcde3f887so4242565e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 06:47:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741099615; x=1741704415;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xKaITwIjY8bRG3Gkr5ECFSqk2O5WBX0rcvQdhZB+9fQ=;
        b=rafjvgqpCunYmN2jMaD6iGSyNwXyitxblhDJ4qC39ojHBsRvRlJlFgMOBw/KbjvtaQ
         RM3uczGPLMYYNYS+AcXbhMXSvxPhsMAI0YvDO5mlIaP6QQDvq48SWo+mPpvc7B0LLEru
         iKk4p176p2dYezP9s6SMc2v5yv2udE4EC1oYQ9BEv34p/cdRpmlfyAoRoHC/uOCsTDq7
         llQRJ0J2F9s+EzQ0bn7iGghjZjXWlIMEj3BUDqZBFjfSOWnlVYO5oXZ/KNuhmD3HVs17
         grba5XiismJ+C++Sz8Tb6rKMrlhFuhOKmQ/iJ3Pn3HQJBR8urbbIDIAS9eTrCx8SEKGU
         E2pw==
X-Forwarded-Encrypted: i=1; AJvYcCVhzGLYvqvHRXXwiYKkmXJh0iJG8PQgeXkyeiaiI185ScDuJt0PG6FxupgW+PwD4U2Vb5xJ9JJv8P6je0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz92FRUtumV0A8ATaqnz3jqBrHXzBEez2Ki+rJqyJ2i/3U6CPWQ
	K2tuXjwTnLCYx1X/lrZ4aRFHldITzl5yc6KW6rAhKwr+TcUBLbKaGUx0kLc15s/vCJnd8BcbjfM
	8eB9Ix0Nw+hP7Z6M7PxGGMweoCnfye/pzEAoa3qI2b1iH0CzoY4CLqTjFcTnTtw==
X-Gm-Gg: ASbGncs7Ile04pwZZlPH4qC6fFWkNMIDgTButnLtyKFuuFdr15PbtOvYtLctanKtr5q
	+TvTjfqpY3oOCDM+3N8auSaNO1sCvC4AWf637kaF8KDfrGJPLg7LuK3qXOCsznz7ctOkjN9RauU
	UgQfuNr7IcnigreaMz+0I3dpKZW0wwLNljo2r6hLomyO1wi8602nafToE8tB8G91gBNClTLtUCW
	LtZ4iEcAVRJ/jvKZ26a/JQtEiu7Bg4HidVtN66MlSl/nlLCp/452B4x/cMc1ayoV7UTyZoDeEZn
	6BjND/d2V64=
X-Received: by 2002:a05:600c:3ca3:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-43ba66537dcmr169093005e9.0.1741099614769;
        Tue, 04 Mar 2025 06:46:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGC0IBp+JOO2z1qAvR0ujuwVStYbT364MrRRSDeDJqeJ7/iO/DEV3l7jSL725tKC8VXgvMZ7Q==
X-Received: by 2002:a05:600c:3ca3:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-43ba66537dcmr169092845e9.0.1741099614393;
        Tue, 04 Mar 2025 06:46:54 -0800 (PST)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b736f74e8sm207928825e9.7.2025.03.04.06.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 06:46:53 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, "Maciej S. Szmigiero"
 <maciej.szmigiero@oracle.com>
Subject: Re: QEMU's Hyper-V HV_X64_MSR_EOM is broken with split IRQCHIP
In-Reply-To: <Z8cNBTgz3YBDga3c@google.com>
References: <Z8ZBzEJ7--VWKdWd@google.com> <87ikoposs6.fsf@redhat.com>
 <Z8cNBTgz3YBDga3c@google.com>
Date: Tue, 04 Mar 2025 15:46:53 +0100
Message-ID: <87cyewq2ea.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Mar 04, 2025, Vitaly Kuznetsov wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> 
>> > FYI, QEMU's Hyper-V emulation of HV_X64_MSR_EOM has been broken since QEMU commit
>> > c82d9d43ed ("KVM: Kick resamplefd for split kernel irqchip"), as nothing in KVM
>> > will forward the EOM notification to userspace.  I have no idea if anything in
>> > QEMU besides hyperv_testdev.c cares.
>> 
>> The only VMBus device in QEMU besides the testdev seems to be Hyper-V
>> ballooning driver, Cc: Maciej to check whether it's a real problem for
>> it or not.
>> 
>> >
>> > The bug is reproducible by running the hyperv_connections KVM-Unit-Test with a
>> > split IRQCHIP.
>> 
>> Thanks, I can reproduce the problem too.
>> 
>> >
>> > Hacking QEMU and KVM (see KVM commit 654f1f13ea56 ("kvm: Check irqchip mode before
>> > assign irqfd") as below gets the test to pass.  Assuming that's not a palatable
>> > solution, the other options I can think of would be for QEMU to intercept
>> > HV_X64_MSR_EOM when using a split IRQCHIP, or to modify KVM to do KVM_EXIT_HYPERV_SYNIC
>> > on writes to HV_X64_MSR_EOM with a split IRQCHIP.
>> 
>> AFAIR, Hyper-V message interface is a fairly generic communication
>> mechanism which in theory can be used without interrupts at all: the
>> corresponding SINT can be masked and the guest can be polling for
>> messages, proccessing them and then writing to HV_X64_MSR_EOM to trigger
>> delivery on the next queued message. To support this scenario on the
>> backend, we need to receive HV_X64_MSR_EOM writes regardless of whether
>> irqchip is split or not. (In theory, we can get away without this by
>> just checking if pending messages can be delivered upon each vCPU entry
>> but this can take an undefined amount of time in some scenarios so I
>> guess we're better off with notifications).
>
> Before c82d9d43ed ("KVM: Kick resamplefd for split kernel irqchip"), and without
> a split IRCHIP, QEMU gets notified via eventfd.  On writes to HV_X64_MSR_EOM, KVM
> invokes irq_acked(), i.e. irqfd_resampler_ack(), for all SINT routes.  The eventfd
> signal gets back to sint_ack_handler(), which invokes msg_retry() to re-post the
> message.
>
> I.e. trapping HV_X64_MSR_EOM on would be a slow path relative to what's there for
> in-kernel IRQCHIP.

My understanding is that the only type of message which requires fast
processing is STIMER messages but we don't do stimers in userspace. I
guess it is possible to have a competing 'noisy neighbough' in userspace
draining message slots but then we are slow anyway.

-- 
Vitaly


