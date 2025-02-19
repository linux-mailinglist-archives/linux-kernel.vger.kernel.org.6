Return-Path: <linux-kernel+bounces-520813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC9AA3AF92
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 03:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2BC16D4CB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA506170826;
	Wed, 19 Feb 2025 02:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUfMoZ5y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602CB75809
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 02:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739932046; cv=none; b=tpN86yQNhTKaiRciRvECmWFmSPprCy+9E/+atMF0Yu+jHP1IIwwwgmuycbsQH4Be68lycML0NYcrLT1Lebfp0ZnJ0oBx+u7PKQ9lU/ei9FCqAV/xUDsaIf7qWKkMs4Y3VwZQaaIUTC26zprnl5JrNUcnUbnk/Ddn/8ijBz2Iqio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739932046; c=relaxed/simple;
	bh=ieyIPZfHdfnLQdd0VbwNEj0Lso1VZYyfeX4L9fAduVE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=KoUOUYYUqqD4jLYtfwLtcrZrJZWy92qzIBkto2/DbnYlEh2tH3YWL4Sn/adoATGxVkIiBdaOzdMXtUzsmHjHTa9S77JakWTDxFOXXRsunlSe2WZJzeoDVKpsVGL09rBxAcjWcghCfjvcp4d1C5FT0OU7OyQfr4HIw+6N/o80vjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GUfMoZ5y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739932043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lBx9B3W6i5muniIrh41HU5nQwB2ePjX2KbBombQj5CU=;
	b=GUfMoZ5ybkOWDUO2hqQtPgfbUyBjg5ds+KFDNgWS9xJv4cPTc74KtWKdE22LBe7qGiuM4x
	ZRpV1H94Ltv4LxDjETDum0ZWDTzs/zeV3bXMHjsRC1eBO5ONEhGiemt70CKDtmEzhxdK/w
	PSDYi9cKhswQhR2dIdd0qTeicnuZ9uA=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-O0NgPRQZPbO4q4A1GVXGkg-1; Tue, 18 Feb 2025 21:27:21 -0500
X-MC-Unique: O0NgPRQZPbO4q4A1GVXGkg-1
X-Mimecast-MFC-AGG-ID: O0NgPRQZPbO4q4A1GVXGkg_1739932041
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5f6e2ef3190so386780eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739932041; x=1740536841;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lBx9B3W6i5muniIrh41HU5nQwB2ePjX2KbBombQj5CU=;
        b=f1Rej31ULdLH0wX6dGFsMFhcNza/Yjl1VH/gMa+Zr24fJulGjt9ZpKPAN3d4SYi9t8
         0zhE/ow+tRLSzM25KzBfDrW5PWgp+WsSYdJPuvIGtcLU3xapO+hz5PYfiKnEqA971cp6
         f8rqzB7QMz+RsCBxkP349/ix1v7I0sqMIwKX1dW2cnTHnOmjVebQIkxeP1L1wYIY80Gx
         XurHNxPKkfBLo2r6aJZ2wP2XpDiF71FgCVQNoVlU04Oj6PEyP3TlM90gftROELgSRO5l
         08ePwNNHaY1VHlqmoJSTUdySiG2bGmfqlrgcU/XaeFtKMJunDMQan63VzNvtc3jmCil+
         Ho7w==
X-Gm-Message-State: AOJu0YyKlHGfuh+rYX33pW0g8ELzV0IiXKj+lUjGxAJxjua5DEdB9JC9
	S9kXwPIfYiKqC54K8wVNTOqYOOIrfG/paPddctEw2tTwChiSotrB6/6RXuyK2qGUErZPIIQGfX1
	jLJkfrO2mujkOQ7yNXjveGoCdGzuwGz9TRB/8U1gF1f/BWKS6DB5hfrR/nwBf7yttlgEsgIX7mw
	bZ6gNG+K0G4LeeOWgLHz1wkzU9MUYipzlyF2RvEol2qYjl
X-Gm-Gg: ASbGncvuRwz6mB1halDjNeYsLTP3oGEZBBnR2esoTMWQ75saRF8rRDIgCsL1nZ/5ztt
	gE45zb0k1zwjH63xeKW8PRjkxGmtd1CbUzSuixjO+r8rCqvtZijkXqbxGzsjxJGsY9Fu0f5Z9vm
	P7lmll0UQdjmrk8TcZYy9v/VM/5gcGcGuZWHb2YblRRzeL1kFxyTg2poU7HbDpYubNTmbvLl7Ld
	Cyd+oIU8iPB5DMsm6W8J8tlLjjvH/UsJKpgCfsbKCql7T5f8Qi6cyT83Zbs3obzm8gC5IMfPIAo
	nhkL9V+wnERnzPGDkebmXd/pltoLB//xpqEA/XsQhhF/PTqFmrs7tIpS9CExs22y/w==
X-Received: by 2002:a05:6820:a00c:b0:5fc:f2b7:9853 with SMTP id 006d021491bc7-5fcfd3acf10mr1777993eaf.0.1739932041054;
        Tue, 18 Feb 2025 18:27:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYUd2wR8mUdLCrcjMSXqRjGAzaR1VKXFv96LAGRl5ugl7gR+QdvrQfCJIAn9h1J4ob/ncA+g==
X-Received: by 2002:a05:6820:a00c:b0:5fc:f2b7:9853 with SMTP id 006d021491bc7-5fcfd3acf10mr1777980eaf.0.1739932040722;
        Tue, 18 Feb 2025 18:27:20 -0800 (PST)
Received: from [192.168.2.110] (bras-base-aylmpq0104w-grc-14-70-52-22-87.dsl.bell.ca. [70.52.22.87])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fd01ec0ebbsm100634eaf.20.2025.02.18.18.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 18:27:20 -0800 (PST)
Message-ID: <a3d9acbe-07c2-43b6-9ba9-a7585f770e83@redhat.com>
Date: Tue, 18 Feb 2025 21:27:18 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
Subject: kernel BUG at arch/arm64/mm/mmu.c:185!
To: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc: ardb@kernel.org, ryan.roberts@arm.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm getting the crash below with Linus tree commit
2408a807bfc3f738850ef5ad5e3fd59d66168996 on a Ampere Mt. Jade with two sockets
(backtrace below).

It happens very early during boot. Passing 'nokaslr' in the command-line works
around the issue (ie. I can boot and use the system normally). Doesn't seem to
happen with 6.13. I tried bisecting it but got nowhere...

[    0.000000] ------------[ cut here ]------------
[    0.000000] kernel BUG at arch/arm64/mm/mmu.c:185!
[    0.000000] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.14.0-rc3+ #8
[    0.000000] pstate: 400000c9 (nZcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.000000] pc : alloc_init_cont_pte+0x20c/0x3d0
[    0.000000] lr : alloc_init_cont_pte+0x204/0x3d0
[    0.000000] sp : ffffb45836ec78b0
[    0.000000] x29: ffffb45836ec7940 x28: ffff6fea00000000 x27: 0068000000000f07
[    0.000000] x26: ffff6fea00200000 x25: 0000400000000000 x24: ffffffffff433000
[    0.000000] x23: dfff800000000000 x22: 0000d01600000000 x21: 0068000000000f07
[    0.000000] x20: ffff6fea00000000 x19: ffff6fea00010000 x18: 00000000ae5a3fb1
[    0.000000] x17: 0000000000001114 x16: 00000000bfc60000 x15: 0000000000000200
[    0.000000] x14: 0000000000000000 x13: 1ffff68b06dd8f1c x12: 00000000f1f1f1f1
[    0.000000] x11: ffff768b06dd8f1c x10: ffffb45835a1ca38 x9 : 0000000000000000
[    0.000000] x8 : 0000000041b58ab3 x7 : 0000000000000000 x6 : 0000000000000000
[    0.000000] x5 : 006840000a861f07 x4 : 000000000000a861 x3 : 000000000000a861
[    0.000000] x2 : 006840000a861f03 x1 : 0068400000000f07 x0 : 0000000000000000
[    0.000000] Call trace:
[    0.000000]  alloc_init_cont_pte+0x20c/0x3d0 (P)
[    0.000000]  alloc_init_cont_pmd+0x20c/0x4d0
[    0.000000]  alloc_init_pud+0x244/0x400
[    0.000000]  create_kpti_ng_temp_pgd+0xf8/0x1c8
[    0.000000]  map_mem.constprop.0+0x1d8/0x3b8
[    0.000000]  paging_init+0x98/0x330
[    0.000000]  setup_arch+0xac/0x170
[    0.000000]  start_kernel+0x74/0x3c8
[    0.000000]  __primary_switched+0x8c/0xa0
[    0.000000] Code: f9400301 97ffff64 72001c1f 54fffe21 (d4210000)
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Oops - BUG: Fatal exception
[    0.000000] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]---


