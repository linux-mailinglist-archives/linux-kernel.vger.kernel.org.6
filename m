Return-Path: <linux-kernel+bounces-203109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14D58FD692
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7D12897E5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183971514C5;
	Wed,  5 Jun 2024 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0Y+6V8d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC96C523A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717616066; cv=none; b=pY8k0VaHTmLbAjMXa8n/VRwTT5ed8Po5Lsrj8GEXhlbhcLm6pjkn8F0C6Nz305g9/+EosUUWywVMEVb0ByFYJSAROtw25wRM4EzIMoffxvqTRpYWMpY8cpvlb+mcyYKn96TQhYuoaZFoEGQK1yrBB2TrUEcQ7sFoWYovv70A9uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717616066; c=relaxed/simple;
	bh=F6uGhyXxFRGXwvwitWPk6r8o7SgW5av//5iXJYuMwIw=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l0DetpdJPxfiMoAaWdNl4ntZFmdRB6mTb5qZsllpORYlar1yriJJnc8gOWavwWibghCwFEKoPMCz3e5dvNoU8ThUBjySFcPaSG0gwaJSEv250GZsE8CRGp1pvDoNiVv1rUvPeynEShvHT39315VzcC1fVuxGWBiRqkqMGyvvXT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0Y+6V8d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717616064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jH6Sf/5uQSKSb+Ny2G5B2sTCcG7O89rYUp8bSy5I1tY=;
	b=F0Y+6V8d+OYIaPBE/Dyo26g1RKzn31xbfoIK/CTA23/MbVsawOs9ZV1BncHk1uVqiFuCbj
	9Q/XaHnzekr0a+Ex8AyvW5r0XW9v60pDNJp1TBdX1CWWahuegVdWBV9V6wWqPdApsUHr5d
	evzJeY/gZCnQ8B2Qs4/Jgdfx5wbdRnI=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-OG-Jqgq5OZGAWhAsrEKqEw-1; Wed, 05 Jun 2024 15:34:22 -0400
X-MC-Unique: OG-Jqgq5OZGAWhAsrEKqEw-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3d201325932so105318b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 12:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717616062; x=1718220862;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jH6Sf/5uQSKSb+Ny2G5B2sTCcG7O89rYUp8bSy5I1tY=;
        b=kBjTI5+qdUj11RDgTv2fUUPRBZ7nsT/RhAOKu3/qYsy6uF3KV+mG4VpKYAR5MODwcA
         Ci5yiBzr97ZjO/ExeI/vsLkANEtAq0XerpzKFxRQYTIdG+3fPx95maaUF1Xem957FqS8
         VsnTscKGnX48QaRrUulLZzXZ05xI9U2TxfufxgNiwzxoHwJp0hU3+mp6Kxuo8fMM5bD7
         c1DJ52kQhwQHGDGOH8IV/WScUSyhb8gxbSSbt7SZybBhBKO7sLDIT1ixe1yKe9j2vnRR
         A+n/jW/n2yUPY3DtfdHYDNMWkgxmex8pEC+tSFPweuAToCZJupUX5uC2RKqgvtDiHPDW
         z8zg==
X-Forwarded-Encrypted: i=1; AJvYcCV4jIkVSus2p7aXkqFpPLW+gwYfh3t2ZrMnJqZ0Et3yshGaRnKiU7+h2F98WhmzFAJdTVrCQys8GmuSNs7B5NIAtb9aXtrbreHYaaXV
X-Gm-Message-State: AOJu0YzAiPrvj4+6M+wR50hD6ud/9POAh3E0xUOpWwbxz1Ah5IBPW4as
	13z4Im+rtdNoGNp2TdjO+T210HlLT7WG0vlgNPFkX7P8WKohPX0F4SFxJOS8EBYWCtOv7W/3iPq
	44WweQoaHeKkjlkAhueJ7CG4k4tjJZj+qgqSa453woNcrpUB4HdYJHQIQp9VxisjoR3e3WQJZBz
	r+gUMiSrmX04OtD1AgfvDGfHJVZl06roi16Zcg
X-Received: by 2002:a05:6808:de6:b0:3d1:b4d5:88fe with SMTP id 5614622812f47-3d2043dbe5bmr3873300b6e.54.1717616062040;
        Wed, 05 Jun 2024 12:34:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgkFGoqjTxQfTUgtST68W0+4pEtir9khOtAK5Fhc6jUhofrXE7C0NKaHykTGdJIOM2zLahI1Ss4Ni/zH+fXrw=
X-Received: by 2002:a05:6808:de6:b0:3d1:b4d5:88fe with SMTP id
 5614622812f47-3d2043dbe5bmr3873276b6e.54.1717616061672; Wed, 05 Jun 2024
 12:34:21 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Jun 2024 19:34:21 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603185647.2310748-7-amorenoz@redhat.com> <202406041623.ycwsuP85-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202406041623.ycwsuP85-lkp@intel.com>
Date: Wed, 5 Jun 2024 19:34:21 +0000
Message-ID: <CAG=2xmMUuS=VesSk1SQ2Pk0xHj_-Hfj6c5Wk7iV=7Ed0VdHiaw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 6/9] net: openvswitch: store sampling
 probability in cb.
To: kernel test robot <lkp@intel.com>
Cc: netdev@vger.kernel.org, oe-kbuild-all@lists.linux.dev, aconole@redhat.com, 
	echaudro@redhat.com, horms@kernel.org, i.maximets@ovn.org, 
	dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Jun 04, 2024 at 04:49:39PM GMT, kernel test robot wrote:
> Hi Adrian,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Adrian-Moreno/net-psample-add-user-cookie/20240604-030055
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20240603185647.2310748-7-amorenoz%40redhat.com
> patch subject: [PATCH net-next v2 6/9] net: openvswitch: store sampling probability in cb.
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20240604/202406041623.ycwsuP85-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240604/202406041623.ycwsuP85-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406041623.ycwsuP85-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    m68k-linux-ld: net/openvswitch/actions.o: in function `do_execute_actions':
> >> actions.c:(.text+0x214e): undefined reference to `__udivdi3'
>

I forgot about architectures that don't have native u64 division. I will
use "do_div" in the next version of the series.

> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>


