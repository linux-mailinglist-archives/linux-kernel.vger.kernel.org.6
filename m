Return-Path: <linux-kernel+bounces-210244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD9890413F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E1A1F23B91
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A3C3D0AD;
	Tue, 11 Jun 2024 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ztgaOMwM"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537A83B2A2
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718123275; cv=none; b=pKKCVXUuiATeqTTnhqnNR9nrUNvIcCc/czB9p1n1mM9EYgywCU5MH1wFcj4sQJAalm2Z0gU/QQ6c1aJRtWufhU5IXlIXFDoYQ6O5xJPFJZGaV29iXO9O52qYomgP6xdg4Da6EL01GAXG1THaJ3cCpCjWWmTJDdNOMOlXXJK6pM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718123275; c=relaxed/simple;
	bh=MGp0DQZa5WkAK57TrA5QegfsQz0WdtsMvA+SLqt36t8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PsAdwAD003zzjaxypc2iorGKYrfxXcS2y4AYCnEdAnC68RmwaY6/RyG/hNB0MEV1ue07k9VsdyHOdhBnpd5UPl/RLk6wvw5J1dei5Ir5DpWi/vHVaYQ23T+tPbV0mEuhoymWJojIQNYEnaLt2oKiFOFfgv1uOzDKNY9Pg3ZiaKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ztgaOMwM; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62a0841402aso95725937b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718123273; x=1718728073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gBtW/SN1QDzI5d7VyA1ik4cNSwUHhHulrBvovSa6A18=;
        b=ztgaOMwMbt0o4QBqLWkG4JkS3Qd9nNuhatvB/h9aC1ShHFelaWEA7iNTBKgcg6zgKz
         mUyawT0kRhuhUuecAdpeHR0Y+z0hi5pFZvAu9BiTj/NOZ99g89BQRdneQf5kIbqA6SYZ
         UTdEMyyO8HIDfb0/me94gLDsTsP92ZVAyQRR6sEjhmo0/XqAiK9PEmO0LN98mtgqQuo8
         QRWWboP8LFE+i1lfA5YfNiCPhIvKsmh6H7imktgEmbSjvRMyyVOM+fQg0U9dPTh62XsL
         EKyLYAYo+oFQNmeD0CibwiRCxnT2hE82heRar6njbCLsLP4iigNC9MwG+3v1Iy8uaC4N
         TKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718123273; x=1718728073;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gBtW/SN1QDzI5d7VyA1ik4cNSwUHhHulrBvovSa6A18=;
        b=Z/MJdcqKz7k0FzJlO4dcJDavhnFyDazZNpfb7M/yMZbJtUzshamUoBP86LdFDbL5Yj
         0rsht2SMBiEN/6wlegOApHCMnl98G1ktTr6BEeoNg5KfyFcQVeq8Ckl8vyJp78ivnHBw
         dIjiKYMo7dTmsNgrArUvUvb5EvBambHC1JRCSB9V01vrlrB7aIFpGOXV+FqWDxmf0B4P
         FFMMaVVmdpzsEwJ8p77D3bZVPQKHoECnzrCF4FPA/pz8tP/Pm4XQjQtuQQg1OODDV9OG
         38pE4oxdnzLo5a/jQjNJNHJP0Ki0zqg8jjHEi2EoyL0IsZ6wdQP4wMfIRnPLMaXvkplf
         mM5w==
X-Gm-Message-State: AOJu0YxyctAdXpp4ilN3VWR9GJj0ddUwrqmwwQjX2IOE7hXIbaIGyU67
	TVcwE6evW6+f9+LvWVn94CKhGSIudAmlinNUU/7fgZqVlC5gqI4ClFLIm8CDtLLxNIOMb24TBt6
	vMEQo8fL6A5S+3G8a6xVIHPTHxbpkYFxxgSh8qSUdoGMSJY3zJzGmGkPUl37zRH38Eu0YhAQXEm
	pEeQS0EG0F3nMLLQw71Yw6zE7GW3bkCbki2dm+iRsh
X-Google-Smtp-Source: AGHT+IFuhSWhkkj9LM8bxMHFkgYcBA/KjivjCRMjaZYzuBPm7Zi4XO4A5opP2YbmYnoSgdSpD3lgFd2vIpk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:6681:b0:62d:48f:30e8 with SMTP id
 00721157ae682-62d048f3220mr19313147b3.1.1718123273373; Tue, 11 Jun 2024
 09:27:53 -0700 (PDT)
Date: Tue, 11 Jun 2024 09:27:51 -0700
In-Reply-To: <171754327022.2778929.14475719898493728460.b4-ty@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231116133628.5976-1-clopez@suse.de> <20240424105616.29596-1-clopez@suse.de>
 <171754327022.2778929.14475719898493728460.b4-ty@google.com>
Message-ID: <Zmh7B4QImxUxMb6F@google.com>
Subject: Re: [PATCH v3] KVM: X86: improve documentation for KVM_CAP_X86_BUS_LOCK_EXIT
From: Sean Christopherson <seanjc@google.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, "Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024, Sean Christopherson wrote:
> On Wed, 24 Apr 2024 12:56:18 +0200, Carlos L=C3=B3pez wrote:
> > Improve the description for the KVM_CAP_X86_BUS_LOCK_EXIT capability,
> > fixing a few typos, grammarm and clarifying the purpose of the ioctl.
> >=20
> >=20
>=20
> Applied to kvm-x86 generic, thanks!
>=20
> [1/1] KVM: X86: improve documentation for KVM_CAP_X86_BUS_LOCK_EXIT
>       https://github.com/kvm-x86/linux/commit/d3f673c86c5b

FYI, I moved this to `kvm-x86 misc` to avoid a merge conflict down the road=
.

[1/1] KVM: x86: Improve documentation for KVM_CAP_X86_BUS_LOCK_EXIT
      https://github.com/kvm-x86/linux/commit/508f0c7bf6d5

