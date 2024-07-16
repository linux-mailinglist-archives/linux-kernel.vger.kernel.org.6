Return-Path: <linux-kernel+bounces-253868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B38F5932815
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6AA11C20A18
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAC119B58A;
	Tue, 16 Jul 2024 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8j4qOiR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CAB19ADBB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139398; cv=none; b=qm+41KlyZ4UbOxPX3RwZxpsVvWqqY7CXH09qcjRGlb6T0BCVKpUFvmnX7wKfXICaDf+ixn4yksG9fei27uzyjupVhUE3JiDvCwhMGWw/CGRPWgbVnHkFn+VaiidKa2DLMgAK2xIxdY+9YNcPPoRDdh8RmCRQojJOVYsF4Z7VqcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139398; c=relaxed/simple;
	bh=cmTfg6ksyvNPOnaQ70QjLDepYi4dEeeeX3xvqiB/9Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLeYuVyG1QCJDMbdjcJJghh+cWqmkg17KA8ss5Jxz+j7ki2dQBuvyddHAvzsIXUphY0TZmE5FsWvIveq9W+EsiYmwhHvHHt/AEb6q0VFVsvR2XpMEFS095Zrr8/JDDGqGSDr+pVU2Gy3MyWQYGKQ8TYISQLaqKA7sBb9wff/w1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8j4qOiR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721139395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dXwwITkzicgsGwK2r+pc5x61PP9sLBVDiPRyCoyIbNY=;
	b=U8j4qOiR6sv/BA9ZCTJKZa8Is1PP2Gic2D92NkIQpEm1OM/uh1P99qcxQowInrdy2RS6yN
	qQiun4qfoIvBFJCiwxWvuoy7rlTQJu8sNfMea8E4Rf8rSdEvmHoKzX/mVlh7jFlJzQnBys
	NaTydtcNdKNRbIiRtErSBGK919nxm78=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-1vYyDiZpNZq9WjsbCILXGQ-1; Tue, 16 Jul 2024 10:16:33 -0400
X-MC-Unique: 1vYyDiZpNZq9WjsbCILXGQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-367988464ceso4914378f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 07:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721139392; x=1721744192;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dXwwITkzicgsGwK2r+pc5x61PP9sLBVDiPRyCoyIbNY=;
        b=jAcqUP13lGW2FoJhnDOC9PGyG8RbuqJleDIJKjbbB3NOTAQ9Rm+/s1k2xsD3sNtZ/U
         DVqNWpgkSeg2NGOoX5MK/9fZZWUHNzbj8sQ9g9lV2jPKgzv7d8RxVvtROTJezZDPFUvh
         E2svvOwiJBxxvT97MdkdadhCMAkTSsv45fPDhCK/DrH1kpkltwuLm4yXcfXtm6kwANvP
         Rb+0wN9psIBHm28sX7OFHVUw+V3+Yu5FWhioUtrk8M2xz6hOcXbTVe+fgJfPKOOskkCH
         iBMiSh/Ahvrvxc4h06WwpJW/KYRGqjvF30K2mXz7220E/27/q1j4B7vIQbLU3d5JPYAt
         ozaw==
X-Forwarded-Encrypted: i=1; AJvYcCXLG/zwGpd70xpeMPYGegArpkYMjh5EKjJGEKlMs1N2KPkdTNK5I1ubSGtALfXN7i+GUZ0NWAZBxkpPdPicjG9XkI/cjWbl3Lw322Ug
X-Gm-Message-State: AOJu0YwZxoqeAQZEIJujhhVEzRZcPd2Al8rCgoAc8leJ3dL+YAa046B9
	nvut9AGgtpoSNwWo0gNkjyonthOs0zxfWDYDzw73MT5C/5pT98Zw4+6GsSIgES07HtFpX6cmtZF
	MhOikeQEjD/gZDVZPnKFVRes/q5pQqVm+sbtk0rVRd/Qq3zSE2YSTluiWtp0T4uQunDBfBg==
X-Received: by 2002:a5d:6188:0:b0:367:4d9d:56a1 with SMTP id ffacd0b85a97d-368261e8d6amr1786319f8f.45.1721139392017;
        Tue, 16 Jul 2024 07:16:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGIRKGqkJxKWPcZZYkOx7oRNt0byjqQV8u0ZmiSaNwLu8DaiwZXmUIgnSb6jDCz+16oURfxw==
X-Received: by 2002:a5d:6188:0:b0:367:4d9d:56a1 with SMTP id ffacd0b85a97d-368261e8d6amr1786300f8f.45.1721139391686;
        Tue, 16 Jul 2024 07:16:31 -0700 (PDT)
Received: from [192.168.10.47] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3680db0ee46sm9147071f8f.114.2024.07.16.07.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 07:16:31 -0700 (PDT)
Message-ID: <0f60918d-bc46-4332-ad28-c155a1990e3d@redhat.com>
Date: Tue, 16 Jul 2024 16:16:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL (sort of)] KVM: x86: Static call changes for 6.11
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240712235701.1458888-1-seanjc@google.com>
 <20240712235701.1458888-9-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240712235701.1458888-9-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/13/24 01:56, Sean Christopherson wrote:
> Here's a massage pull request for the static_call() changes, just in case you
> want to go this route instead of applying patches directly after merging
> everything else for 6.11 (it was easy to generate this).  If you want to go the
> patches route, I'll post 'em next week.
> 
> The following changes since commit c1c8a908a5f4c372f8a8dca0501b56ffc8d260fe:
> 
>    Merge branch 'vmx' (2024-06-28 22:22:53 +0000)
> 
> are available in the Git repository at:
> 
>    https://github.com/kvm-x86/linux.git  tags/kvm-x86-static_calls-6.11
> 
> for you to fetch changes up to b528de209c858f61953023b405a4abbf9a9933da:
> 
>    KVM: x86/pmu: Add kvm_pmu_call() to simplify static calls of kvm_pmu_ops (2024-06-28 15:23:49 -0700)

Thanks, indeed there was no straggler static_call() after applying
this.  However, there might be a problem: static_call_cond() is equal
to static_call() only if CONFIG_HAVE_STATIC_CALL_INLINE, and arch/x86
has this:

         select HAVE_STATIC_CALL_INLINE          if HAVE_OBJTOOL
         select HAVE_OBJTOOL                     if X86_64

And indeed if I apply

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 80e5afde69f4..d20159d4a37a 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -21,6 +21,8 @@ config KVM
  	tristate "Kernel-based Virtual Machine (KVM) support"
  	depends on HIGH_RES_TIMERS
  	depends on X86_LOCAL_APIC
+	# KVM relies on static_call_cond() being the same as static_call()
+	depends on HAVE_STATIC_CALL_INLINE
  	select KVM_COMMON
  	select KVM_GENERIC_MMU_NOTIFIER
  	select HAVE_KVM_IRQCHIP

KVM disappears from 32-bit kernels. :)  So I haven't checked but I
suspect this breaks 32-bit?

Paolo


