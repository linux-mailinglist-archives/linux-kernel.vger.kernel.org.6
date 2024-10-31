Return-Path: <linux-kernel+bounces-391196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 854F19B83B7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 129F4B21CCC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709921CBEA1;
	Thu, 31 Oct 2024 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lGrOt4cO"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CDB1CB9F9
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730404435; cv=none; b=STMZg86+pgYmtK7sc3BrhsincgdS1J8NY/V/UhM4KLTHql/2JkXFwpVybZB8i8kaeVbcjEKSxHstCVaPxIfTbKzeq/CWlYqqE5s8TKdNYfRRCrCklJHgoidSi/zodEQsoMaNvf8RBqpp5/jLP1AT4KQBzPc30AFpwN8tSxYwcHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730404435; c=relaxed/simple;
	bh=PdWqS76TntBj1o5y/ERo5t4OfLQCPNhFCHC/bosJaZU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PuBUNZYsFpphJEKEcAhnSYoOv5Mk3l66C4pUUpPmbxUPvAWh/vY7IwYDAOBaelQ5BhXYi+jz0G4N6QaKInPpHWfndFbyxB3dO+5oUaKpwzyvLKCDam7hBrPvVSIWrvdD9cmJS+R77pOWKYjRh2qjYEi//Tb0ODcD0Qv4BmVXzBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lGrOt4cO; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e36cfed818so20638857b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730404433; x=1731009233; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gjbSgVjCkY0HoMuRTmWdgWHPQ8ANMkSeaY47F/g0Jas=;
        b=lGrOt4cOtD1WX6ItktkFQaCxJcQt1n0zpWE4TxS7GzpCd7VnYeNuMFy0s1BWyYIQCG
         D3sc0nluaCHdlnxrkNxaorHc5Hy6MAvXdN8WlnN71HphbX6vPIZlGxjtJCT2adDCteBZ
         ALJLzsAirXHFWnMW279eBU/jMLrnHc6mPbUegau9z4iSreMomFkOFMifxaXr04d1Y7FF
         owvzM5qPgj0AA2gqE6AG73Xidi2ffGgmDoCKYMzFBuD7nI2SEYIjuvpDEAW7yHnAAOn4
         HuuFY0kOq5E//DLSUthzSg+0IyuaJOsUx80MZrXbw9jw6wt8ZuP5CQDX6lrTrwvhphFD
         UYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730404433; x=1731009233;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjbSgVjCkY0HoMuRTmWdgWHPQ8ANMkSeaY47F/g0Jas=;
        b=uGYiYmGhMjMNX1TDNzghTcRFSveCjDie6ag2AlZJwTWLorn5+ld8f0L/79d9MTM1dS
         IR/b39mo0W5bXdmfSpaMEpokcZdc9ckNynRqRICgjNqxEGei0o+cW1YV5ZUY+Hs+YgHw
         IBNOegRXke0FHP8nOaYeic9yjDmU57FGmfM1vswZsdwi8cb+VGB+oBLsp9+UT9seUjK/
         PLGGp1ZuP8AdYoznYBPhJQ+hox9u9ikIxYIuS0mzlylGDQi7oj1iEN7ZqkAHMLU/hjki
         W87FaMfckMTIU9LtNPjr0uq2uzWtPNxgfjKNYUvLtTUxtGu405D3OGQb70nzFfk9nAKI
         E0eg==
X-Forwarded-Encrypted: i=1; AJvYcCVOxy0gQUZx2p3Hn3CNkROUJ2WO5cTnPU3Huq0By72Hqjd0+deTa6ZPi/Ne4ZjL6/ctQnv3Hin3aSDmC5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeoYRobLx9B8TuX+WWlZ2gNXjBorKOOrtkKnpmgbzOa91c1zps
	epNNX5X9dIO+lgwiBYtfHLdu+WW48SzftNgWzupCkRp2EoCxJHwa3U1T/PMhTJvVn/PkDOopK7C
	3uA==
X-Google-Smtp-Source: AGHT+IE7o4sC1NJhy0BlEpH5scKVHImtCn1rOQ+RAwKY6xUxYUqqBj6/HkcqkBw17+DYOQTnbgDPsbRkiz4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:6811:b0:6e3:14c3:379a with SMTP id
 00721157ae682-6ea6479f2f6mr161017b3.0.1730404432792; Thu, 31 Oct 2024
 12:53:52 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:51:31 -0700
In-Reply-To: <20240802202121.341348-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802202121.341348-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <173039526970.1510316.4428336973275011540.b4-ty@google.com>
Subject: Re: [PATCH] KVM: Rework core loop of kvm_vcpu_on_spin() to use a
 single for-loop
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 02 Aug 2024 13:21:21 -0700, Sean Christopherson wrote:
> Rework kvm_vcpu_on_spin() to use a single for-loop instead of making "two"
> passes over all vCPUs.  Given N=kvm->last_boosted_vcpu, the logic is to
> iterate from vCPU[N+1]..vcpu[N-1], i.e. using two loops is just a kludgy
> way of handling the wrap from the last vCPU to vCPU0 when a boostable vCPU
> isn't found in vcpu[N+1]..vcpu[MAX].
> 
> Open code the xa_load() instead of using kvm_get_vcpu() to avoid reading
> online_vcpus in every loop, as well as the accompanying smp_rmb(), i.e.
> make it a custom kvm_for_each_vcpu(), for all intents and purposes.
> 
> [...]

Applied to kvm-x86 generic, thanks!

[1/1] KVM: Rework core loop of kvm_vcpu_on_spin() to use a single for-loop
      https://github.com/kvm-x86/linux/commit/7e513617da71

--
https://github.com/kvm-x86/linux/tree/next

