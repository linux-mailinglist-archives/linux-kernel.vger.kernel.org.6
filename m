Return-Path: <linux-kernel+bounces-185430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FAF8CB4D5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95D91F22D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371951494D8;
	Tue, 21 May 2024 20:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJ7PGXSE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AA41494B9
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324303; cv=none; b=e4NKqgY7AAQLoay0tKBUkC705gd2myPsU+r6zI8YCmAHlIF/jpo0cdcGupHa/W20B3IGuihx7EwbTAgn4yn8CHhDrb8ArBr/ALQqEQuUrV05X8dd7eKmGagiydoVLArxuRn7A6Vco7K2CjpHtIJvn3sapGnCdXwn2XclwlR6qwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324303; c=relaxed/simple;
	bh=TlKVCaoYqRvYNK3pgRpJ9fAW5uxl8oMMpoPVJEwAYqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjabNqbrQYN0Jy9rXb1d27n5HjIAYQNQ75DBg+AdvnRsa8jInDFa9zhfue+eKxh0LNCpuyfGZNAAhpmLz2H6bwMYI+DpDp75KRVc0/5x0lTWKBAG/B0NS6mvWcRgSehZCake4oW52DsHDkSftAdO8Vi//gAk0gjl9mc5vIhkP+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SJ7PGXSE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716324300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N0TR9kM7X3WlmPK2GrezdTol6v80HI4XlreEoiOrbJM=;
	b=SJ7PGXSEY5IzDW2Gkxeea/ZuUxb8LjbVrx9fdfrkjHiXu592DbIGo6WFjMoFLzIGEN0hwK
	H6VNrnwh2ob9QX1IovZiN24PCEqS09zxFMeKPEW94fpUwsXOiUGSUatVU8VK3tMXT7I7dx
	bYy4JBiIOp/w/kpytdb7A0Yw2rmdVC4=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-dbu0RH4qOf2MdATu7Re5mw-1; Tue, 21 May 2024 16:44:59 -0400
X-MC-Unique: dbu0RH4qOf2MdATu7Re5mw-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5b2b793a26aso3322657eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 13:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716324298; x=1716929098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0TR9kM7X3WlmPK2GrezdTol6v80HI4XlreEoiOrbJM=;
        b=ojZPM5yin50eK+y5e3Xq81VV3CdfvpLtfzpZ0npejAL9zjcEGX74z1If0b+oJN9QxM
         5LrejKzAbYjaf0e7maTpbbNBcDRE61ZKFI/YoHief+E4hS+GXkjiOxkjszDFu0XfFN+Z
         NenRUDA1ZGfQ+PoC2evYGpRxr8fUt4JRcniQ4uSytb1ahEuKlw3JVRl0pcSPNI73qXdZ
         j9PZMDmuZdQeTdn6rwZAI6Wo2sV/CtQYATQMJKE6ZJhv/c0ceRkTfKwRvPm1sla87WVs
         fFq/UrnVeW6oP3l3hueupTlVnHYTf/T+aGY7FD+qXNuII8dzEQfE/Xr+KDoUw6OTwqYS
         M1GA==
X-Forwarded-Encrypted: i=1; AJvYcCWIUCPEzRvjFSDtI6QDFHNOIbBP6mnguYqtSyW+sT59p1RPV/BvoDpIA9cv89zWPUzW+FPKZo2YHUhlTE0WetvnFVAaVunFalW0csB3
X-Gm-Message-State: AOJu0Yzcfd68T9h1GF+KDnkAVU47PPRGGrxFuwSutdWP6vAIKnFXyxlz
	FKEmIj4/BZVCGrlEjlaSO+zRcQRTMBGTLqel/GfpON3zXZNo9L5f8gkAEs1mHpJu5FUHli+Ag8g
	sE4ZObmzy8JWMFfagY5sn6yGhziq3NcxYGUJ/g2AnL8/lE7FWx/kTTb6/GKdWqkW8EW4P0g==
X-Received: by 2002:a05:6830:7203:b0:6f0:52fb:c693 with SMTP id 46e09a7af769-6f666f78dd4mr150097a34.1.1716324297873;
        Tue, 21 May 2024 13:44:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAl3W1EYaiiKZhrcoPIjVfq5uhLIrOvZE99H/jBbHteoo4w+oTXp4PNu54t8HyT9oBCbrbFg==
X-Received: by 2002:a05:6830:7203:b0:6f0:52fb:c693 with SMTP id 46e09a7af769-6f666f78dd4mr150029a34.1.1716324295821;
        Tue, 21 May 2024 13:44:55 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792e564e4dbsm915264585a.82.2024.05.21.13.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 13:44:55 -0700 (PDT)
Date: Tue, 21 May 2024 16:44:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>, axelrasmussen@google.com,
	David Hildenbrand <david@redhat.com>, nadav.amit@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: 6.10/bisected/regression - commit 8430557fc584 cause warning at
 mm/page_table_check.c:198 __page_table_check_ptes_set+0x306
Message-ID: <Zk0HxVODITGKqYCw@x1n>
References: <CABXGCsMB9A8-X+Np_Q+fWLURYL_0t3Y-MdoNabDM-Lzk58-DGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABXGCsMB9A8-X+Np_Q+fWLURYL_0t3Y-MdoNabDM-Lzk58-DGA@mail.gmail.com>

On Wed, May 22, 2024 at 01:17:19AM +0500, Mikhail Gavrilov wrote:
> Hi,

Hi,

> I also attach below a full kernel log and build config.
> 
> My hardware specs: https://linux-hardware.org/?probe=b34f0353df
> 
> Peter, can you look please.

Did you forget to attach the kernel config?  If so, please attach it, I'll
try that, as my local config won't reproduce with CONFIG_DEBUG_VM_PGTABLE=y.

Thanks,

-- 
Peter Xu


