Return-Path: <linux-kernel+bounces-395913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE469BC4EE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEEA7282E21
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392651D2B2C;
	Tue,  5 Nov 2024 05:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WxQJwWW0"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A259286A1
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 05:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786026; cv=none; b=eTuHGtrd5UVHitTw4ANsEBxpzsgdwNLyEW+5Z47jCtr6+5fKvDdwEdI2z6d1DtzFeiPCjkmDHvJ9u16SsCEUPG1+PCci2DK0L8J5/+awFk1by3S46li33BOIjIbxxxvFAM+fcKaG2qcdKEwd4p7UxvKgCitAM0PSB4zGNt1J9vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786026; c=relaxed/simple;
	bh=eFIgYsyVXpLfwNZ0WDZ01Ek7Ywd6Wo8hby6mzO9UQ28=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FnFSyXjKEszifD+JaKCsBEWyjFjMsHc2xoPso2UWOMDcjMQXZq4VZrvQtTgi3oeoT6EUyF/aA/K0fALSersMzILieV8glQ8mZnuEQWsojqUlZxZqHy2G/P6oaY4YLrcdyofa01is7d2Dwt8cniMOQGeqPiLwoDvrec1Od8Xvvjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WxQJwWW0; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7ee4e642954so3939527a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 21:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730786024; x=1731390824; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CATQgkxqet+kiiFl27IyAPicUnMOKGQVJB4zHUMIsJU=;
        b=WxQJwWW0bBorU/RgtNaMe/adMlP+7npWNLuq4eubpBdbJE0XBldq+PudesMj1/17MM
         FFU9uKodsG4EPHCPn5NjZackp2T2ltuinh40BUYacp0sQuU2yzD2gYR4n59TDucxGnWV
         0xMB9XYH7mDY9Ee7f2jUIC/wz7jBNqzWnK5HmfCzaiLF+FPwWjV2OiG3hKPZR6z39JX+
         i2YehwmsULwsfbyN6ehX5pyLx6Gcm3aagbCl2L9PgWFgIs8Vo2F1nUcJeFwnycf8We63
         ImPEadZ5hG99y6KtG94zt941YT+/awVjM3uK7rEuVBb7gpMGSy09KxUAFqYJvuk96B/S
         vPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786024; x=1731390824;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CATQgkxqet+kiiFl27IyAPicUnMOKGQVJB4zHUMIsJU=;
        b=wmgHcaTyARY0RX/tLeAbiS1i9dcdzVr8Csn067fxtPhF5JkvKKE5Otgnxu2ekVmBIB
         Gh6VVNeLUIGPCJHqEShzYAdbfC8ig+Ef/rrlHId2QeBwlEOFTmgodxyB6vhWqPnPGL2+
         qU32gFF7yV8lM+Yxc4ygZm9RSPKTo8J08UjsJgmyESroFVLmnm0MosYEpXokmDzA9fV5
         j+xQH255n94l/xXGBDQpE5cC9gNG1U7K6AdEDuG7xLd9leAxRH4y+FnnimKXToGKcFXS
         drf6FCJkihx7T/bsH9B8Y7+B+4sKhoDNkRqLXXP4IZcpsKpZjkXrB+SDyRMPaIxvVq5Y
         HCbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV97MDxH7WXiSDCDu059VxaOEWqDSSvwKVJd0BcJtmaNer9CTSU8t+FWPrY7au3ZDrzMxI9yl3FBwsFFUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymVtuUcroqWEeDmwmvIzaYdZWgFGX8bn/Hu7TKTzLmAeuOIYNO
	Kb0EUmaUBX65NzyITEP1i3GDe5dpkk6EiWqJ89PMcPnQ96MQNtOAUtebxcXKlAKf4QQBJH5dCqP
	1/g==
X-Google-Smtp-Source: AGHT+IE6j+o01T6Bqwps+9UMPoL+PueNwC77slv8kXJ3ii1dNkE6QY41DyYsvleelHQM84FbAugxCqQ87JE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a65:4389:0:b0:7ea:618:32b8 with SMTP id
 41be03b00d2f7-7edd7c9109bmr51755a12.10.1730786023765; Mon, 04 Nov 2024
 21:53:43 -0800 (PST)
Date: Mon, 4 Nov 2024 21:53:42 -0800
In-Reply-To: <173039504313.1508539.4634909288183844362.b4-ty@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241024095956.3668818-1-roypat@amazon.co.uk> <173039504313.1508539.4634909288183844362.b4-ty@google.com>
Message-ID: <Zymy5hjgMSMT64uI@google.com>
Subject: Re: [PATCH] kvm: selftest: fix noop test in guest_memfd_test.c
From: Sean Christopherson <seanjc@google.com>
To: pbonzini@redhat.com, shuah@kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Patrick Roy <roypat@amazon.co.uk>
Cc: chao.p.peng@linux.intel.com, ackerleytng@google.com, graf@amazon.com, 
	jgowans@amazon.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 31, 2024, Sean Christopherson wrote:
> On Thu, 24 Oct 2024 10:59:53 +0100, Patrick Roy wrote:
> > The loop in test_create_guest_memfd_invalid that is supposed to test
> > that nothing is accepted as a valid flag to KVM_CREATE_GUEST_MEMFD was
> > initializing `flag` as 0 instead of BIT(0). This caused the loop to
> > immediately exit instead of iterating over BIT(0), BIT(1), ... .
> 
> Applied to kvm-x86 fixes, thanks!
> 
> [1/1] kvm: selftest: fix noop test in guest_memfd_test.c
>       https://github.com/kvm-x86/linux/commit/fd5b88cc7fbf

FYI, I rebased "fixes" onto 6.12-rc5 to avoid several pointless conflicts in
other patches.  New hash:

[1/1] KVM: selftests: fix unintentional noop test in guest_memfd_test.c
      https://github.com/kvm-x86/linux/commit/945bdae20be5

