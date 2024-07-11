Return-Path: <linux-kernel+bounces-249408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B68E792EB4F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41049B2235C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1D516B743;
	Thu, 11 Jul 2024 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PcgsWf2+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AB61EB2B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710543; cv=none; b=VWUn78uFQp7FyNjGvF/W5sb+IAbk4K9VTxWqpAoDIPUi5eDA1HSqTuaFIyuXtZMWIWvCVNqMe4DfgBXhoQPNWF7FbZEMNg6DDGu2j1g+FwGTSHlVgFUVN+YKbaTekE6p7AE8QrdtCJjtBomTKpaWR3b51Bjr8GLesXiWVb0t8VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710543; c=relaxed/simple;
	bh=nfXsuQPk3IHu6BKJKx7bXBwOyCuLcUIxVs8u0YdtZqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pj9XF+/7KbYq+2uIn5VaZZw6oheUdUWSQp33N74xf//tY8+KFSPkhuPcek91y6+jZxvuNec1FbzvpmDN/By4hna52RB5hO6VQgmQUFTjnl6gxQuJN7zliO6jeFmsYIdvXNDABiz9WHfZ3ISGaguPTRE5TdnOMhed49ndeZ7c6rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PcgsWf2+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720710541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lx31M68JcVzeqU1JzcMQtMpsLglQujw/nqZU81HCxy8=;
	b=PcgsWf2+B5ATvp2XNhEzhcGjMgiUbNa7sz/lY+cNvOfK2+sjLSBwmeNkYwZUKoEFrFffo4
	qp7WZr2+EBReY3npFHhnlQN4xkLPTJ/LsTotbNQGLA0Cw4e8OlweCMb4vKXIOKK/VRvZlE
	MRzVTlp2Z2d0Wfhal7ZQsxeUmbG0Ft0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-ZcY9F5k7MJ2NIo7kt314sA-1; Thu, 11 Jul 2024 11:08:59 -0400
X-MC-Unique: ZcY9F5k7MJ2NIo7kt314sA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-447e66bbc62so1030531cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720710539; x=1721315339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lx31M68JcVzeqU1JzcMQtMpsLglQujw/nqZU81HCxy8=;
        b=BMju0uL4AnIxmzVDyVizEoqpZtQL2hc0CIgDYOQs1Z4lp5vhiQ+IfGB2ppQw8ynEcO
         2XMSGl9W4X6AbbvkftCBFi+T/2lNa2yjTRYHs9l7wZiKJJMWCXjN2SfJN1q65cTpnkoJ
         fupdp1ujjBy8Ai8dLZrtytvGDGpcv7moCxNhjPyS0SLklMpa22al9b+EWMoUg+rhNQSt
         6oCvIVT1PUAlVEKU8G9cvtmP7Amjd9bHshWuAemLow+R3RlUh/fVVlvjnKnkUiCXd6j4
         kCW3H+k+RI0fho2VGdTsrBpze/lYN+JDiXJ1crVad1lkIku2kYWNdmSin2xYHimR4LMk
         ryOw==
X-Forwarded-Encrypted: i=1; AJvYcCXDaIWVK7YQrivudkzcuOt/N0KStEjukvLFumXNaZTRywyTPh/XmicHlOf/LICMsElg0mJs90ymnZ9TEFlOp7z8jHbj/2pDoSu6c8CI
X-Gm-Message-State: AOJu0Yw9u1KK/6a6ChMG1Iyos4L66/ZdPKAdNWd6g2ked0aBIwz2rY4t
	to+9Lz2eNmUEq5gEuCU1GeVHA81DxZanUuuGlHUyIq27ZIZJiocqpxmGWQh7XiFCV1wpKli4mgu
	6ofQnr+qvmXuVZAjJcThLUvjUT5MjZC62x723g/8rOYTZ29ed/CZDbxxZR88Klg==
X-Received: by 2002:a05:6214:20a5:b0:6aa:3158:e8c9 with SMTP id 6a1803df08f44-6b74b0a4acbmr28765856d6.0.1720710539074;
        Thu, 11 Jul 2024 08:08:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIsQcL1yIiW7RGe3LVC22DOIbQ204xDljkpkS3THeYMpVLfuV4OtwZSXZUMwvTHDEZeGJuxA==
X-Received: by 2002:a05:6214:20a5:b0:6aa:3158:e8c9 with SMTP id 6a1803df08f44-6b74b0a4acbmr28765576d6.0.1720710538544;
        Thu, 11 Jul 2024 08:08:58 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b74263a1c5sm13866906d6.78.2024.07.11.08.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 08:08:56 -0700 (PDT)
Date: Thu, 11 Jul 2024 11:08:54 -0400
From: Peter Xu <peterx@redhat.com>
To: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 3/3] mm: Add p{g/4}d_leaf() in
 asm-generic/pgtable-nop{4/u}d.h
Message-ID: <Zo_1hrOgU4dWnSUV@x1n>
References: <bcd6ab8246348f18fdc77694e321ee6458f05781.1720597744.git.christophe.leroy@csgroup.eu>
 <f69941b076bf8fec89b6bec5573fdb79483c2a75.1720597744.git.christophe.leroy@csgroup.eu>
 <Zo6e1ILgDn6nuhGC@x1n>
 <b37a0bb5-ba6f-4db3-af8f-83e06eec086d@cs-soprasteria.com>
 <Zo7Vz_LGUgaf9BGN@x1n>
 <154b60ea-9113-4093-8082-7a471beacfb1@cs-soprasteria.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <154b60ea-9113-4093-8082-7a471beacfb1@cs-soprasteria.com>

On Thu, Jul 11, 2024 at 01:40:17PM +0000, LEROY Christophe wrote:
> I will wait a bit more to see if robots report anything else then I'll 
> send an update fix.

In case helpful, I normally use this small bunch of scripts to test
cross-compiles (and I keep adding new configs that can fail any of my
trees):

https://gitlab.com/peterx/lkb-harness/

Just FYI.. I think different people use different set of tools.

-- 
Peter Xu


