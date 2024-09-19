Return-Path: <linux-kernel+bounces-333126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B501097C43C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907E528283A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C23817C8B;
	Thu, 19 Sep 2024 06:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F93Xeg5y"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4CE18C33D
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 06:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726726992; cv=none; b=ORSxrS89Cr5i+Vb7iDY7P07AabSglVoP5bDe3Kcd7CoL9bRQbzjK+tEywaXsOPf/KmjjaJ3VslGK7wbjG03JjAt13dv6T8d2QuhkiksmhK5egxocYo5/toifmC0rNsjPfz/FvB8D4o/f4q5pb6FsJD5npPNLtbdy9eRegsmAjGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726726992; c=relaxed/simple;
	bh=U94upb0OfDy+f5VUnpZg+sxpiZ1BDgW091njpkP5GfA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=K+y36QfZ35Jwdu5q6QrVy3L7zFIbmxC7zG0Gm0d+SY4XoDXZrlN3Uvwi2e1CYYBbwLUWs5xhgZ4+fUJpPsf/fgkA3BCrIyIKeHrutCQLkvjPrOYMpzgwS9/y/e/EMXIBUvCYrBzfM7Ud+f10KtZFZ8Dqn1uWDqd9GacPXz5vzoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F93Xeg5y; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20792913262so6610385ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 23:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726726990; x=1727331790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMB28cCoh+EtgWHGA1hGa1Xqf23n12o3JH476WnchVA=;
        b=F93Xeg5yj28QwqqWsTPMOUVEtMld38WalkGBk6oJlYDcATl+0tjjlT92+SuIonWWB9
         uCRO0b8Fh6grRpdJka9XVP7+2p7NFIAA/B/mz1qp8DWEMUpYfuSXQAUrJ8G6WfOjN5s2
         7AKYbJjzTE6PBF+qO0iwHoZMndUaHp0dFO1tivqiVRmJlzjy2Z2A6MTGwhKl4ohlHzvD
         Kvs0aI9uZdCVObOqc7hH3eZL2nlPeA5GU+yuVecjGijfSovDmUABGTA3XLfuMgejaTvs
         +Dh+ijXC5XM76FAowUWyg+8xW3IT93bWaI7UuM0a1G/KgllrLyOFWb9FE1EvqxSqKziF
         PKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726726990; x=1727331790;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMB28cCoh+EtgWHGA1hGa1Xqf23n12o3JH476WnchVA=;
        b=WGk1c4WDXlOdL0R8lIoXrRQMYdAMyakKGYyizaVEQQZZjPrALNKuVk7vD5sOI335Nk
         eY8wEjdNX3TNphLGPBGOBGJnajmL4n+lA9BGsl/lKVgbrCIbvd3EhDqEkrfTilwtaDDk
         piIcBZtLbEXRB1h2TXoZxjdiRXw96ymIYD20q/BhuVuHv0tPx36ikx8bMNjOBJuxtWL7
         jeiBR6C9FquuwOchQRW+VBofoMZXIUmsw39K/l0lOY/ppzEoOBGA8FJgkgdezQMifwVm
         S+oiBe3jhKuyraSIrJiB4TP+97tqXLZAYw44HFlIjY3eSpReFY769nQaDi6AN5mSAlC+
         R50Q==
X-Forwarded-Encrypted: i=1; AJvYcCU558bbG5ngrIY9qUfdteKwliPTxQx3DwRAdEwsr/O92cW+S7Ht7X2LJM/rRd8Ge/T4G0nATOlVPBw5rpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAGobiFo0htOT/3NUNvChLTvmTB5lZvXQGMRkcyMH/Nld2uho9
	hZtJa330DjDJoxfmfSJ3rKXS6b4Kw/P2S6MP6BQu8/px8xwGH072
X-Google-Smtp-Source: AGHT+IFU4vkqxFNSe4Eq83apMu7w+OxEO+qEiDjIV8fsRkhk1oJexJP9mvnlYzqaic6d160YK6bbqQ==
X-Received: by 2002:a17:902:e84a:b0:1fb:57e7:5bb4 with SMTP id d9443c01a7336-20782a69aa5mr302633235ad.37.1726726990257;
        Wed, 18 Sep 2024 23:23:10 -0700 (PDT)
Received: from dw-tp ([171.76.85.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946fcad2sm73406885ad.211.2024.09.18.23.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 23:23:09 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org, 
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Donet Tom <donettom@linux.vnet.ibm.com>, Pavithra Prakash <pavrampu@linux.vnet.ibm.com>, Nirjhar Roy <nirjhar@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>, kasan-dev@googlegroups.com, Disha Goel <disgoel@linux.ibm.com>, Alexander Potapenko <glider@google.com>
Subject: Re: [RFC v2 02/13] powerpc: mm: Fix kfence page fault reporting
In-Reply-To: <65664ab8-4250-47c2-be50-d56c112a17fb@csgroup.eu>
Date: Thu, 19 Sep 2024 11:17:16 +0530
Message-ID: <87ldzotct7.fsf@gmail.com>
References: <cover.1726571179.git.ritesh.list@gmail.com> <87095ffca1e3b932c495942defc598907bf955f6.1726571179.git.ritesh.list@gmail.com> <65664ab8-4250-47c2-be50-d56c112a17fb@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> Le 19/09/2024 à 04:56, Ritesh Harjani (IBM) a écrit :
>> copy_from_kernel_nofault() can be called when doing read of /proc/kcore.
>> /proc/kcore can have some unmapped kfence objects which when read via
>> copy_from_kernel_nofault() can cause page faults. Since *_nofault()
>> functions define their own fixup table for handling fault, use that
>> instead of asking kfence to handle such faults.
>> 
>> Hence we search the exception tables for the nip which generated the
>> fault. If there is an entry then we let the fixup table handler handle the
>> page fault by returning an error from within ___do_page_fault().
>
> Searching the exception table is a heavy operation and all has been done 
> in the past to minimise the number of times it is called, see for 
> instance commit cbd7e6ca0210 ("powerpc/fault: Avoid heavy 
> search_exception_tables() verification")

This should not cause latency in user page fault paths. We call
search_exception_tables() only when there is a page fault for kernel
address (which isn't that common right) which otherwise kfence will handle.

>
> Also, by trying to hide false positives you also hide real ones. For 

I believe these should be false negatives. If kernel functions provides an
exception table to handle such a fault, then shouldn't it be handled via
fixup table provided rather then via kfence?

> instance if csum_partial_copy_generic() is using a kfence protected 
> area, it will now go undetected.

I can go and look into usages of csum_partial_copy_generic(). But can
you please expand more here on what you meant? 

... so if a fault occurs for above case, this patch will just let the
fixup table handle that fault rather than kfence reporting it and
returning 0.


The issue we see here is when unmapped kfence addresses get accessed via
*_nofault() variants which causes kfence to report a false negative
(this happens when we use read /proc/kcore or tools like perf read that)

This is because as per my understanding copy_from_kernel_nofault()
should return -EFAULT from it's fixup table if a fault occurs...
whereas with kfence it will report the warning and will return 0 after
kfence handled the fault.

I see other archs too calling fixup_table() in their fault handling
routine before allowing kfence to handle the fault. 

>
> IIUC, here your problem is limited to copy_from_kernel_nofault(). You 
> should handle the root cause, not its effects. For that, you could 
> perform additional verifications in copy_from_kernel_nofault_allowed().

Sorry, why make copy_from_kernel_nofault() as a special case for powerpc?
I don't see any other arch making copy_from_kernel_nofault() as a
special case. Shouldn't Kernel faults be handled via fixup_table(), if
it is supplied, before kfence handling it?
(maybe I am missing something)


-ritesh

