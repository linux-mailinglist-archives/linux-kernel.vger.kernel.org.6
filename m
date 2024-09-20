Return-Path: <linux-kernel+bounces-334437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9BF97D745
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52890B24BB5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3D517C7BE;
	Fri, 20 Sep 2024 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpZkzm4V"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A961B3BBC1
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726844840; cv=none; b=J5fz/vG/DNAV5btc0f3JiM2Z8sxhExTcApQ3b2Z6qgHG2vU5eQpHI8h0uUGFqrOuwbBX108qiON6iULnAwsX6Cj/6LFO2eEjJ73Xmpm5d+MhYqFqGgYlcowhQY4h0318Mca3TqK+Z64mET+DSx8fSZuVNdBpsLgic5mLCAhw0W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726844840; c=relaxed/simple;
	bh=Blp8lOQ4DyQPVqx/ZxdTusO86KCVQQcG+vSWeIIr26A=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=tdpT0KA4zAegoyIbaotWe84vdBNAQ7KxH8vr7loHDJJgNaFFtLTgAUHsR2O6mdRvS646kUg1EoguXdJm51pg21ku3aUBVmDuYyMN5fsRWgoUNu6l7sZaOXP94J5hMAbd3hQwcNSQSDHg7uH/OATWB36BVgU888mS+dM6XMejScs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpZkzm4V; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718e11e4186so2003293b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 08:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726844837; x=1727449637; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Q+IMF2/yt5H2L3HnniAbyoUSeocuzaPiZHlEpHd550=;
        b=HpZkzm4VsZCW7S8qpfxEs8fzI/lXFa6nTNXJHFE+70H01+8kQ84WKaNvxk4KKF8BtD
         FzIicOfG9kIpKRCpcHAlKHKnuNM6qWn7ySGmWpDl1ILXBJoDos7fKuGF35NZqcdWhOyQ
         B6DATyZTTAd7GWqjKx6o4tXeDgUPSlNoGUjr1iWdrPu6CcP2c79ndakmO8sN8Iht7Gcp
         nP4RbfecoX9i9/oYrT3Z7IjfH2IiSbJLd8ke1fyWO5b2NoBMVir+gNuB1ltnEHIUiik+
         OdxJWSlp7RiH8A7MeacmG8JGi9vAXzzRezvRqNTT+ECeSYLBoDVd77hUGTdLLeRitlhz
         msVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726844837; x=1727449637;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Q+IMF2/yt5H2L3HnniAbyoUSeocuzaPiZHlEpHd550=;
        b=RcGjZPvQUixTGwIXU6fXTPTyp9tLmeMC0tY0FZ7vN1/9CTWGyDvBb/MJMG3dUOgw5V
         AWsd1Ble4cYFrLIYrMJN2RoKrZVN/v1bks0bboSrprsRPNXTQMN6oqAB+4O5baBRPtZ7
         lYLAudTyPh1QtqiFIMzQimrzmIIADQbnUDE3nMOzkRCrp2Y2u1DQuEt+Plsl0hFCy7xZ
         QYvIQTokd21f5wSo1jkEko8EMzPkpImAPvcYNduZXeZgndqXSWhp66EScaLM6kV/S1SK
         6nmVPHqU6gchN3vt7Q00AU2UZg2ySzKiBgcFLTvnaMVbRGBejEbkofX5KKFFt58oABQY
         Volg==
X-Forwarded-Encrypted: i=1; AJvYcCUzJkAjuiWnQpJF0PzCR742Uu151lcdF5ro9mHh8GY71oDBA2cDT4UFNw2yAnNrCuK3kK0lShN1KaPcJAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz16g1lrtY9WxqH3m2crTkuZc3lJeGHWGDdzeDmJZn0ULHAktov
	PcDH1gNhq5CtfxRehOKTYVucK5pPgZ5kQy5SJzlB/4VXraJee0yYR83GLg==
X-Google-Smtp-Source: AGHT+IHyZ22f3lxsANEFklaZ2/EZeGFSKacy8PGIMcrt1N5/JNL+ZNPALh2X2l2osKnat3cAuMybWw==
X-Received: by 2002:a05:6a00:4616:b0:714:2533:1b82 with SMTP id d2e1a72fcca58-7199ca0318amr5430553b3a.23.1726844837137;
        Fri, 20 Sep 2024 08:07:17 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944bb97fesm9923436b3a.183.2024.09.20.08.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 08:07:16 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Kajol Jain <kjain@linux.ibm.com>, mpe@ellerman.id.au, atrajeev@linux.vnet.ibm.com, maddy@linux.ibm.com, disgoel@linux.ibm.com, hbathini@linux.ibm.com, adubey@linux.ibm.com, gautam@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: kjain@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/kvm: Fix typo in the kvm functions
In-Reply-To: <20240920113801.424651-1-kjain@linux.ibm.com>
Date: Fri, 20 Sep 2024 20:21:20 +0530
Message-ID: <87h6aagyzb.fsf@gmail.com>
References: <20240920113801.424651-1-kjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Kajol Jain <kjain@linux.ibm.com> writes:

> Fix typo in the following kvm function names from:
>
> kmvhv_counters_tracepoint_regfunc -> kvmhv_counters_tracepoint_regfunc
> kmvhv_counters_tracepoint_unregfunc -> kvmhv_counters_tracepoint_unregfunc

Gr8 spotting!
It took sometime to realize k[mv] and k[vm] is the change :) 

>
> Fixes: e1f288d2f9c6 ("KVM: PPC: Book3S HV nestedv2: Add support for reading VPA counters for pseries guests")

Right. This commit added the registration and unregistration helpers
for TRACE_EVEN_FN_COND tracepoint which mainly collects the
observability stats for nested guest on pseries.


> Reported-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/kvm_book3s_64.h | 4 ++--
>  arch/powerpc/kvm/book3s_hv.c             | 4 ++--
>  arch/powerpc/kvm/trace_hv.h              | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

Not an expert in kvm area. But the change looks very straight forward to
me. Searching for "kmv" string in arch/powerpc/ after applying this
patch indeed resulted in zero hits. 

Please feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


