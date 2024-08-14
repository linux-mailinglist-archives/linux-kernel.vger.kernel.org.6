Return-Path: <linux-kernel+bounces-287040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D7C952204
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 20:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CBBE1F24763
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125DF1BD4FC;
	Wed, 14 Aug 2024 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vceOGFuy"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931991BD03A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 18:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723659876; cv=none; b=Na2s44TOMZGnFHULF6u11Irc8ghedY6yjnyATtPy3IXrVkSXEP96uQid/P6pAe4n/4uAu86dvlKhMRBb1BaUcIcpNuCf5U9jed+8UzkzztowAweY/C7rZlSH+Bf5aDtZVBdpg8jWpxs7tFaIlBc/JKuOh8in6iYfZiWF4GPknK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723659876; c=relaxed/simple;
	bh=fUPdp1FJP9o6RPzeUXh0crfnPnpeOC6DOpOpQNM1eGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyGHJL3+BNMyTpkQqE2DiiIumAoR/wOrOnhAopcp38mscr9kA899MRmz+JdUj5x998HzMnsiGtHYfNqBIMSQF/zX4cfe76gUv82JnHOAv1WPeG4TlAbn29c3sUW+5eMhqBcSD4mgf28W5y9SJ7s6Iq64oz88oQTnWqfO2r0LNkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vceOGFuy; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so27067166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723659873; x=1724264673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgcHiPfghS6i54uArWpbh4/aE1GPzyWbEj0Bz9CZ81s=;
        b=vceOGFuyc5GXRn9jO3qeyt3GlIrkJC7KDr2u/F/TzUNUNln3eqy/RtQzf11qj6ID/h
         dDkbGCPzsCU/PD4XB8LiZLx93kXnkwv0IwcsecwtFAUmOz5YW5DeTBqM3PixkXziJK3K
         idVoq4cpT7yVFJvM2A8yBaq0ipnREVtDuQtLX0y9Cv2R1Ewq/XdkUH0l7nntCFBlVGDD
         rzfJ79gyRMuSUEwsWt6yc2NNCTnXvu6UbWNu74iAjfiXJRBQGdKQI4bNnFqdXfhTPOVs
         hgLBwH/msBDf1ZVK9iP7YpX25uweLd7C1x3/597QLYP2GOptu4ruuF/1qN9NRl7e+6nu
         qbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723659873; x=1724264673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgcHiPfghS6i54uArWpbh4/aE1GPzyWbEj0Bz9CZ81s=;
        b=arRkWWEt+dElgx9bZFqU9ws1OgtrDTrSsLFkKVDE19BI/tLJ9UTe9+C72PcZyifrfZ
         FmJ2FnxoIxk107BNvCy3/347ZpTYOc7dnl3IfuB7yrl9hUXCsGaszRcl5M9WvMu6DM68
         hwwey6u3HGz3ICLxvUhKbSs8Rw9TnOXwkSBUeS9hw0qGajEdmRMdIFROhoC4B1TNEqt8
         viOzmom2a/MMYhEeFS4LO8SqmJwsklW5W5+FMg+wtq2okRTChf51JGuaBU9sIWnYLOAH
         suFRJojsRpDEPKCPkbGs3k/J2wHJuW3BFObBeyKyQ6Pc7VN1CkoKcZZIEAGpicvi2FdU
         7QcA==
X-Forwarded-Encrypted: i=1; AJvYcCV7kadksuGAH3JjikwPIwRn8WhfSzb/2Je9Qg8tFmbR5pkrzk3zYMkO/ltzXK8qWW5YcpyqHP2Mtsr8G8QVTx0UxCFWdd9VEZGSkXrD
X-Gm-Message-State: AOJu0Yy/u4dKGO6jp0IeTFdIhnGdPZEdCD13Cx37m/YKe7WtoweVJiPj
	rXZvErbcBPnguAa+aKD6X7WBEywS4fxBUPt8yTJRMK9JG3mEPR8E/yB8otJC1SWGDyVybZofnhC
	AwN8s37kRS8FMzSpLQHR08I/LcRzIZI/u0A6f
X-Google-Smtp-Source: AGHT+IEuVeVZJ3rSBIB5OeRdUr94JEf8OV3NfVjLFDKBu9xzaqHB1bnQJOXdTCu5jNStYLiHlAVBEgjlFrDB6wDlfTE=
X-Received: by 2002:a17:907:2cc6:b0:a7c:d284:4f1d with SMTP id
 a640c23a62f3a-a837cd582d8mr39310866b.28.1723659872437; Wed, 14 Aug 2024
 11:24:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812171341.1763297-3-vipinsh@google.com> <202408141753.ZY1CSmGo-lkp@intel.com>
In-Reply-To: <202408141753.ZY1CSmGo-lkp@intel.com>
From: Vipin Sharma <vipinsh@google.com>
Date: Wed, 14 Aug 2024 11:23:55 -0700
Message-ID: <CAHVum0ddyzHs+7Zv1SaL9Ox5qY7V4bjciPsnj21HekAavz_x4Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: x86/mmu: Recover NX Huge pages belonging to TDP
 MMU under MMU read lock
To: kernel test robot <lkp@intel.com>
Cc: seanjc@google.com, pbonzini@redhat.com, oe-kbuild-all@lists.linux.dev, 
	dmatlack@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 2:33=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Vipin,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on 332d2c1d713e232e163386c35a3ba0c1b90df83f]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Vipin-Sharma/KVM-x=
86-mmu-Split-NX-hugepage-recovery-flow-into-TDP-and-non-TDP-flow/20240814-0=
91542
> base:   332d2c1d713e232e163386c35a3ba0c1b90df83f
> patch link:    https://lore.kernel.org/r/20240812171341.1763297-3-vipinsh=
%40google.com
> patch subject: [PATCH 2/2] KVM: x86/mmu: Recover NX Huge pages belonging =
to TDP MMU under MMU read lock
> config: i386-buildonly-randconfig-005-20240814 (https://download.01.org/0=
day-ci/archive/20240814/202408141753.ZY1CSmGo-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240814/202408141753.ZY1CSmGo-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408141753.ZY1CSmGo-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    arch/x86/kvm/mmu/mmu.c: In function 'kvm_mmu_possible_nx_huge_page':
> >> arch/x86/kvm/mmu/mmu.c:7324:29: error: 'struct kvm_arch' has no member=
 named 'tdp_mmu_pages_lock'
>     7324 |         spin_lock(&kvm->arch.tdp_mmu_pages_lock);
>          |                             ^
>    arch/x86/kvm/mmu/mmu.c:7335:47: error: 'struct kvm_arch' has no member=
 named 'tdp_mmu_pages_lock'
>     7335 |                         spin_unlock(&kvm->arch.tdp_mmu_pages_l=
ock);
>          |                                               ^
>    arch/x86/kvm/mmu/mmu.c:7340:31: error: 'struct kvm_arch' has no member=
 named 'tdp_mmu_pages_lock'
>     7340 |         spin_unlock(&kvm->arch.tdp_mmu_pages_lock);
>          |                               ^
My bad, didn't check for 32 bit build. In next version, I will take
the lock in tdp_mmu.c.

