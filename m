Return-Path: <linux-kernel+bounces-308899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D1196636E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00692286723
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8B01AF4F8;
	Fri, 30 Aug 2024 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fXWT7AS+"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2657192D6A
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725025971; cv=none; b=V+1UPHhUkZKJEPiUzqGOQ4Tx0LGCXw0RePT46Fn3U+YB0fsmzoh2zGt3/FfnP8fSn8ftcN7J7xbfdyZ8JfRvdW3dbPp0H/Z4LjlxYWPpsXs6yQAOomf5fHXzsVbNxUfEOm4UrhiRnIiY7QPfC3H7YPoA6FWcMhOmw8w8l0+hN3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725025971; c=relaxed/simple;
	bh=7VO2YEoc2qaBwPc/ZWWxQx/gNcW0P3fJFQwweSWfe3I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PsIJyLeMJeWFiKTWIl/vdE2iDXjKnViYNJPIOYZbONauLwauxWLmBfrU9u6UNVs489x5hRpnVPSTqOr9xzH6H7DjZPCzbM5MK0dOsnoDTS1Hn7w/koMCrG27HMyRN9/61CnBXK1lOSSSm73DSPAzVlmR0OlYDMnzhGBiCSHUZw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fXWT7AS+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-201e24bd4d9so17553055ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725025969; x=1725630769; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VGytXQEPwtv9Mq3qz2G1a6/C8wxSI6csvHwukiIv4rk=;
        b=fXWT7AS+8dBFndBbDHUOhIUkKLkMrS0ygtvNyCtbN/6zOuFHDyiTxq7jNFKbpKWWF8
         T85HDP2P3KA4hA9PS+ySgKvGbKWNaJwhJQcyyDKe3nwOJpDhgsUeVP94UbTGe1NceY7C
         1hd1lYOKv9m8kYz0K1OJWyKyHLWpPw9hBj+4hIf+DwVagl0uAq7I3OexOeXVpDJssAnr
         T08DMMjFcTCry2i6aAj/DHhxnGHeE0cYxQrpP3STNwbkAgQv0tIkJQQAjKVoXMiEgOGO
         +l5wHbmVhTEW4qj5v2WkqSQenK1sa8/0mia1wFCaImguMOGmK3PUbV/sBSNOVadNF4bf
         dGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725025969; x=1725630769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VGytXQEPwtv9Mq3qz2G1a6/C8wxSI6csvHwukiIv4rk=;
        b=eL1iPTYenTXpA8Ib0lBLPFbfgFKK89IddYfpO3XkxQeXbDfPDj+jQCIjweRN0JusaD
         Gyxl+MfbS0POqqnnP67m4csjt6dQqgYt88YLMphRpquba9qEthtvmW5i/U8tMl2c6b0H
         7whITdV0sp+h+Cj3Z5tF3djA1E4sVtOQpx8a3/ju7cCXdQmtb5arlVDg5AANxP0g+TgZ
         tcX30gLbOrH5VN9lWKMe60cAPz65hjnIHRaCEIUanUE9oJZddGQdg9ZnIuSbpIcep1Lb
         AbSdc2D1ya+llGZ+dJRJizn+IjtTKgLbYmv3g85uOvkpliQC7MLSX1u7XjjwDTFiVKae
         Au2A==
X-Forwarded-Encrypted: i=1; AJvYcCXn8hXeli7vhvfn6PSbRcXGEt76aka90EpfsXvjrAjRKCy7qX/Ga5cg4L1L+YRaLUGTykgUx5oC2jkgPLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjxDoCEGa7lvhr0IRoFlUWP3w/Y2mDHPSpwJc7dE2GCuRwNc+q
	Sn9P9cFpqkBZXzZ66iSKZifCw/ZOwRU5Dll22ogBCYPzkyJMEReR8luV6E3DoR6Nd+aZ9wrO6rM
	FoQ==
X-Google-Smtp-Source: AGHT+IGO22ARAD+XDst+l4CutMgZbM838KqS/tPsC9q5mz4asSk4MODrN2e+vIDiQs1MFNh7WOArc932vYQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:c412:b0:202:101a:b78e with SMTP id
 d9443c01a7336-20527a58c87mr431875ad.6.1725025968924; Fri, 30 Aug 2024
 06:52:48 -0700 (PDT)
Date: Fri, 30 Aug 2024 06:52:47 -0700
In-Reply-To: <871q26unq8.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309010929.1403984-1-seanjc@google.com> <20240309010929.1403984-6-seanjc@google.com>
 <877cbyuzdn.fsf@redhat.com> <vuwlkftomgsnzsywjyxw6rcnycg3bve3o53svvxg3vd6xpok7o@k4ktmx5tqtmz>
 <871q26unq8.fsf@redhat.com>
Message-ID: <ZtHOr-kCqvCdUc_A@google.com>
Subject: Re: [PATCH 5/5] KVM: VMX: Always honor guest PAT on CPUs that support self-snoop
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Tian <kevin.tian@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Yiwei Zhang <zzyiwei@google.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 30, 2024, Vitaly Kuznetsov wrote:
> Gerd Hoffmann <kraxel@redhat.com> writes:
> 
> >> Necroposting!
> >> 
> >> Turns out that this change broke "bochs-display" driver in QEMU even
> >> when the guest is modern (don't ask me 'who the hell uses bochs for
> >> modern guests', it was basically a configuration error :-). E.g:
> >
> > qemu stdvga (the default display device) is affected too.
> >
> 
> So far, I was only able to verify that the issue has nothing to do with
> OVMF and multi-vcpu, it reproduces very well with
> 
> $ qemu-kvm -machine q35,accel=kvm,kernel-irqchip=split -name guest=c10s
> -cpu host -smp 1 -m 16384 -drive file=/var/lib/libvirt/images/c10s-bios.qcow2,if=none,id=drive-ide0-0-0
> -device ide-hd,bus=ide.0,unit=0,drive=drive-ide0-0-0,id=ide0-0-0,bootindex=1
> -vnc :0 -device VGA -monitor stdio --no-reboot
> 
> Comparing traces of working and broken cases, I couldn't find anything
> suspicious but I may had missed something of course. For now, it seems
> like a userspace misbehavior resulting in a segfault.

Guest userspace?

