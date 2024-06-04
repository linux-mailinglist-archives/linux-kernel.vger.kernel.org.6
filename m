Return-Path: <linux-kernel+bounces-201564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 022C38FC00B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D3B1F23F15
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8401314E2D5;
	Tue,  4 Jun 2024 23:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mrcKQ3iW"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D1A14D715
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717544388; cv=none; b=eiDaIlIv1/Vi9PsszZ2gA2yisTsSrmPcM1tHo3jvIhgwjaU2Z74GAp03wurbayoRK2UnJwlsxurMf+3vtHoUPOXdoN/PcquzDl2ohZ8Ny1KPUlanWJ0Y+MPZhQctRiaux0tCeBMYJRRvGJRk4KF29zQelwR1y5U4VwO8RRyi1rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717544388; c=relaxed/simple;
	bh=YYcLqi87Tu6nRUSwa++q+twAQIkfUW4IHMiYr59b/pI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sFDy5rFdHLr+DbGmwwke+LOmnItdBi3u5SU3BCagNTNh5nQHjKnIbutM5ZIdYz8qZ5O185vgMNKiPJW0KU7qUdQMrVWVcDDz0leGcklbv7fgYRv08MeNeS/KuNw1imufaXTsHdKORwzaWJqEESbW00wYAKKka+eh0FkYiEywDgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mrcKQ3iW; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2c1b176f795so5410562a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 16:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717544387; x=1718149187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RZ7CpJRXjWVYWPvMtf8v2EmhCGnEDtuJdxARKZJGbA0=;
        b=mrcKQ3iWmiegJHSXwP13Bl0XSRsD6Nb1w+mZrXTa39n5QatAdANh3HdEhJmqv9QPyx
         wjw7cT8kkqboNkuGP/k89HnhbG9f3Na9QZhk63FYnL0QOz6ikqWn64k+3ifc6CvNRpfa
         23fM6PFBDExjtTb/CPCijsDo+b4Ka01MgoHE3kLoM9kFo/l1hbcwYEWhxSVHs3oaOmxz
         vgG0Hpn3brsdg6ei/qQGxaBSMtrew4LYE9d6bf62JZ42TZWcj5TzJgCbdqOJpr9Td4V+
         sJieoIpaSUFtWsW2RqZxrvxLzbbAyj2Uglz5fUCzNAYxuBsDl2gsmpI4frbFfZnME8no
         MfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717544387; x=1718149187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZ7CpJRXjWVYWPvMtf8v2EmhCGnEDtuJdxARKZJGbA0=;
        b=U4ucjHWJyg0YHFjgnOazCmqRkqOqSleaHGUsaT3IR1LCK2i7thKni/H1d3ypRP+pme
         lGTg1F2NGTNx+IuuVSHc33oVmj3IkIpbAn632mPPQjzifRds2GT20fZFfDJ5mBa3hX2h
         D17OxGIyerAr8VceLuNfNa3sdTZzplLNC6LIMuEJkmf5+LJgZ66RRLC1iw3+TY5+ahBW
         lsV5AaIxc2M5n9PvAy23GkLZDknKKF+85zUFIudZYcPS2cm0pQMh+WhkQFJs1/aFwGS1
         9+AXSKrLRdapXtkq0fpBPB/9mseZqq3QRO/qZ9fl7hvTEQFmB+Bn4wQu3vHAsuv4EE8n
         2thg==
X-Forwarded-Encrypted: i=1; AJvYcCWCjxdvf9hHtanM3JRPU6sH7S9PYaaZqsk6ooBGzAXt9IP2b7UpjBvrOkrXnxBxuNU9tWkjdqpskyML5g2Nl1lZ+uggAh1ZMRBYjELL
X-Gm-Message-State: AOJu0Yxy4XM0aY0wcy9ck/VSABRKjZaVONEbRMVu8LiyTszfmaZYtaB3
	nDsDjteUlOZ0Chfr9M3Su8gBKgymOWM2IQgVIc4JnT77sOyPQG5xj44P+lo0d0BGRmhETLOLoli
	uwA==
X-Google-Smtp-Source: AGHT+IHR7Nw7yMe8oDKpztMj+13qaYkqZPfJOgL1BiDjmlyXJe+u2yn+W6jv+JrzzTzEQ5o4idZBP5UvXuE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:6382:b0:2c1:aa8e:2ec0 with SMTP id
 98e67ed59e1d1-2c27db611ffmr27997a91.6.1717544386839; Tue, 04 Jun 2024
 16:39:46 -0700 (PDT)
Date: Tue,  4 Jun 2024 16:29:51 -0700
In-Reply-To: <20240520224620.9480-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240520224620.9480-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <171754355148.2779945.14775698565550979300.b4-ty@google.com>
Subject: Re: [PATCH v6 00/49] New Intel CPUID families
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Tony Luck <tony.luck@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Arnd Bergmann <arnd@arndb.de>, 
	Mateusz Guzik <mjguzik@gmail.com>, Thomas Renninger <trenn@suse.de>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="utf-8"

On Mon, 20 May 2024 15:45:31 -0700, Tony Luck wrote:
> tl;dr
> - Please consider patches 0001 & 0002 as urgent to fix a regression.
> 
> - Middle set (0003..0047) are independent of each other (I think)
>   and can be applied in ant order at a more lesisurely pace.
> 
> - Patches 0048 & 0049 cleanup unused macros *after* all the others
>   have been applied.
> 
> [...]

Applied the KVM changes (08 and 09) to kvm-x86 pmu, thanks!

[08/49] KVM: x86/pmu: Switch to new Intel CPU model defines
        https://github.com/kvm-x86/linux/commit/8387435bebac
[09/49] KVM: VMX: Switch to new Intel CPU model defines
        https://github.com/kvm-x86/linux/commit/0c468a6a020c

--
https://github.com/kvm-x86/linux/tree/next

