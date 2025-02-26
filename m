Return-Path: <linux-kernel+bounces-532970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAABA45448
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 05:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0B5189A34D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D00625A65A;
	Wed, 26 Feb 2025 04:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EWu3VBoP"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF4321519D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 04:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740542784; cv=none; b=oTHOnX9FFDobk6x5d+3bduTNUTHDPi0r5uoTo/WLW8C6FgdQI2czbi9SQWUUZ5Zhx2tJ76daC9w3oJb7DfmiRWsPZkR63cjii+exOV6IlgNcwdPsfVoGfvLnXmJJbWvqXMcbr5jOb0+xUdyU23dla+EecgTeD6GHG1GIXtLJt78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740542784; c=relaxed/simple;
	bh=AuW50vH3VSY/Xf8J37DQxfTy+N6QXSGr4cXcli5U37I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p31MnFEN/DlfaPnN0DUOEfPDvSOMfClYedQcXSw4nQK1tYfjbiFBB3fOWxxokhfTJmC/uFwngeN2p8SCtTWNAtlo6pBA9bhmsfAwFrcMJuoP5pYJ79Tk4BMmdc7QVHK6gWZMXpC075GiN50wrjY2H6R/MkHjZl/UUYDgM9qazIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EWu3VBoP; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab771575040so82248566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740542781; x=1741147581; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=40VvcXlH8rEZKpE1INxpbYUwpWWo+F2leARtkRuHi+c=;
        b=EWu3VBoPeC+lM/0iimQzipsR91hbnRhtAMO83B19JK/zHZFpEKJhB5kxVWxTrTqTdM
         bI6V/bJHVf6EfFqZ0F3JgRqsSg+iL4K6lD5FdB5gUZWvlkD2FEeK6LgGNTr8XCBtKKXO
         ksS2BPy87yj3IJJB8LryH36UJVj3OTDuGo/vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740542781; x=1741147581;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40VvcXlH8rEZKpE1INxpbYUwpWWo+F2leARtkRuHi+c=;
        b=IvqOJnvlDjjOZ0IUdtHGi2mN7LGGAe8gWkVSjzZI/8uKQ/1H6wMC4RFhQQiGjAsj1j
         sS50p0//XTod2Z2eeQq7+F7FHMaEm76nnf/tSesfz3I9+Ll+kRnI3kuwRKmuPkJngiZQ
         bVbGJgbRtPGiAqciARt4c0mHyLMGHtTe24iiGlPH5zf44+5SnK+7o6h+F7vxBdYFGzzC
         9V+GB6zI/ZzvnHtYHzRsIplvXuwMgquahpD1QmN6OLFfT6bvjLvD+n0clY5SDTThe5Fq
         dh4qzRJVShQ0/euAVQtqR9vD20QOMhDQoAeN2U9fhTBnXTX5sehfxDCURgA9NCWLFP3A
         Co/A==
X-Gm-Message-State: AOJu0YyXLFrY7tVRmo1ujzTAw+AhUctrRhyazRkrTCmlt2swtrPsUV01
	VYSx795kounckBKNmcbaWcvDY445DRDilahFEFGUcG8j+b2tPvc3HurWlM0gUvBcPaASYkvjsGH
	GNJc=
X-Gm-Gg: ASbGncu+xNL4P8UnX4VNL55tlo9LZVouUPRKO2YE3hnaNW1VqFtgco2IMGHQKteTAtM
	rhHeoeKExtVJBkAsC7Vgq68vtTmpFHvdBhnqWuLeezYkKz+OSF5+HrrHEHCPwMt7CLNByffS1rM
	+N3nxU/9BdeXUk84VRdnbXS0rq+Ven4nIh1qgXxvgvlESSVFW4XriL6ASvOArByTH+3ks36BHum
	kknMtvfBUAkcG5B+EJVZ7mBqCXK3BB/8t/KFnYQrIPfqk/PiiIFMIuqIQ9sHX2Xu1R0btZv9u0f
	j1eNLZZE5meK6d1CYeLEnNo55QIplO9frZMtbO2LodujY8KBNZLULawAofWqH6aMwvp8ooDEHs/
	Z
X-Google-Smtp-Source: AGHT+IErGX0YoPDc7pYzB1dOg+I+ous5yGGcXqKo28/ZwwY7As12yzWArWua8h3VUJpe1YUjfrBagA==
X-Received: by 2002:a17:906:380d:b0:abc:2aca:e5e1 with SMTP id a640c23a62f3a-abc2acae668mr1329127866b.8.1740542781104;
        Tue, 25 Feb 2025 20:06:21 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cdc52esm256640666b.13.2025.02.25.20.06.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 20:06:19 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abbdf897503so88980866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:06:18 -0800 (PST)
X-Received: by 2002:a17:907:cf91:b0:abb:bb82:385b with SMTP id
 a640c23a62f3a-abbeddc5eb9mr2218246466b.13.1740542778393; Tue, 25 Feb 2025
 20:06:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174051422675.10177.13226545170101706336.tip-bot2@tip-bot2>
 <CAHk-=whfkWMkQOVMCxqcJ6+GWdSZTLcyDUmSRCVHV4BtbwDrHA@mail.gmail.com>
 <Z76APkysrjgHjgR2@casper.infradead.org> <CAHk-=wj+VBV5kBMfXYNOb+aLt3WJqMKFT0wU=KaV3R12NvN5TA@mail.gmail.com>
 <Z76R6ESSwiYipQVn@casper.infradead.org>
In-Reply-To: <Z76R6ESSwiYipQVn@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Feb 2025 20:06:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=whS1uq_4hEgkZJogv_HMhe_PJ-RyMs6E303_Pa+W0zx0A@mail.gmail.com>
X-Gm-Features: AQ5f1JoCnqtK6fTnLK3CaWRyz3BVTY7M9pK4Iq32FOaHAgO4MK-3ssz-_tr_HuM
Message-ID: <CAHk-=whS1uq_4hEgkZJogv_HMhe_PJ-RyMs6E303_Pa+W0zx0A@mail.gmail.com>
Subject: Re: [tip: x86/mm] x86/mm: Clear _PAGE_DIRTY when we clear _PAGE_RW
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 20:00, Matthew Wilcox <willy@infradead.org> wrote:
>
> I think the entire point of this file is to manipulate kernel mappings.

Very likely. But just looking at the patch, it was very non-obvious.

           Linus

