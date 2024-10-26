Return-Path: <linux-kernel+bounces-382937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E87E9B1536
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 07:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12614282E1F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 05:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9405516C695;
	Sat, 26 Oct 2024 05:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2cV0PeGM"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E9B2E40B
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 05:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729921576; cv=none; b=p/HwrkV0se/iewz3BB2GPyJX6LRPLzh40ug6vqGb/LBVy43z/uy08GZ84tj0qgT3z6Fd7r9qAqAPlw1QBqlALQqu7JYCgUidzh9UDT57rrWkdiv9a7QLWXtoowT8P5tGfDPhSZLVEOfrXpHEipK9ZJ7X3xIIkZmvzIyuzoSDRH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729921576; c=relaxed/simple;
	bh=SRjwgqCN32DqjDXP1zoKrUZDPYz/yulcotM5Ou+dbgQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=i5g8rYSYYWwzRtSvTTfPbcItWfaEop3OqYMj7/swT7+OY3zbhcZSiajTgj10IJBP2rmezk6LZB9kicbBOrXkiaHbgCtGeuBj2AD94IthSxpR6fcAIatw2doF3H9gyzYdGKrXBQnj0dbZYviqFKha1EcA630Y0KPPi+mUzae2hlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2cV0PeGM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c8ac50b79so45955ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 22:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729921573; x=1730526373; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eY8ZkEywyfjVgvKb0PE6wkcMqGE2Q4geJi7aoCgEDmQ=;
        b=2cV0PeGM+50GMNWZNWeDtObecES1iiYyihgbLe1OuxASFlgvlkm90vD9peIKijnrwq
         a2D1rChCTMyNdJLJkHyYQFkYpufjmMfVxLi6xQReJ07NrxI0pnr8pIFTJ+XEUkqGwoaP
         PKbn5LkXkwdBjzUwW9C2PlKwpAUTumMotjd/tsiFwam0qaWiXEf6karjuZ4Aveo4caRL
         46C1of0AsmQ2yq9bA4p6gvkKEwqheNvNluKc8zfFdS/VwZMCx/cpSQzSNMLHxUrP6f45
         YFYaqO+XuLpIf0GSinNJ8eN0McKextoMytku0nBHkmctgwx/385T2kaecqqKYM1ZuKdT
         V+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729921573; x=1730526373;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eY8ZkEywyfjVgvKb0PE6wkcMqGE2Q4geJi7aoCgEDmQ=;
        b=D9bvAoyVmPgsQJ4pUdUySgaLOZPDmettp85HbbcOnVVMB0wjuVKevbrLlHoiTskdLU
         8envlPHtY/HCk8CTfTa3samSl83elsisfwYfKvhl9hKSFV6CJHWqtLl0gbUtRhNRrLSe
         En9baoSSOXYfY2GQWka68RgteUfH2OAoMBs7NKOE8lVJTUbcQKHu7XAwkBp6aZSDVC8V
         OmPsQpfCoJjfpRb6nHqepS6GlgiszUHk78YiTVks6jyBgZ3MntBi/w5FdjJH+u3RIndx
         ilVJy0ESA1a6T0N7U8pATEEFMVw3UhS8dlcf792BTaIXtsLPQbloBUGLLGghrr3UTj/i
         E+rA==
X-Forwarded-Encrypted: i=1; AJvYcCXO2DAqtu5QTMTEUefxUgMwfwjn2vKXynTBES+v2WiaAqM/PdyvTb18Ff8MaG0FD2cbNT+vap/xPXgEU9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnqBpPyDopjjGaDPGGeTOdNyWcs5VEIppxW6cA8FKOo7rpnyMe
	hoZSAVIqiLsyvD3zogA2JbOom11fYjwu+aCvu1zIg/ZmpuP9j62/+ljuBQNODw==
X-Google-Smtp-Source: AGHT+IHQJgLq26FeZB3qU743EYM2bPcmmi3fesK4osKTr3JrdwHB+K8I+X1vHhJIGYtKvNJXamqCdQ==
X-Received: by 2002:a17:902:fb84:b0:200:97b5:dc2b with SMTP id d9443c01a7336-210c7b885b5mr803385ad.15.1729921573136;
        Fri, 25 Oct 2024 22:46:13 -0700 (PDT)
Received: from [2620:0:1008:15:a73a:2b46:3ef7:2150] ([2620:0:1008:15:a73a:2b46:3ef7:2150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc02ea63sm18221395ad.220.2024.10.25.22.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 22:46:09 -0700 (PDT)
Date: Fri, 25 Oct 2024 22:46:09 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Qun-Wei Lin <qun-wei.lin@mediatek.com>
cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
    Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Vlastimil Babka <vbabka@suse.cz>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
    Matthias Brugger <matthias.bgg@gmail.com>, 
    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
    Danilo Krummrich <dakr@kernel.org>, catalin.marinas@arm.com, 
    surenb@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
    bpf@vger.kernel.org, Casper Li <casper.li@mediatek.com>, 
    Chinwen Chang <chinwen.chang@mediatek.com>, 
    Andrew Yang <andrew.yang@mediatek.com>, John Hsu <john.hsu@mediatek.com>, 
    wsd_upstream@mediatek.com
Subject: Re: [PATCH] mm: krealloc: Fix MTE false alarm in __do_krealloc
In-Reply-To: <20241025085811.31310-1-qun-wei.lin@mediatek.com>
Message-ID: <3740cf07-594a-d484-29de-5d76e2e97be3@google.com>
References: <20241025085811.31310-1-qun-wei.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 25 Oct 2024, Qun-Wei Lin wrote:

> This patch addresses an issue introduced by commit 1a83a716ec233 ("mm:
> krealloc: consider spare memory for __GFP_ZERO") which causes MTE
> (Memory Tagging Extension) to falsely report a slab-out-of-bounds error.
> 
> The problem occurs when zeroing out spare memory in __do_krealloc. The
> original code only considered software-based KASAN and did not account
> for MTE. It does not reset the KASAN tag before calling memset, leading
> to a mismatch between the pointer tag and the memory tag, resulting
> in a false positive.
> 
> Example of the error:
> ==================================================================
> swapper/0: BUG: KASAN: slab-out-of-bounds in __memset+0x84/0x188
> swapper/0: Write at addr f4ffff8005f0fdf0 by task swapper/0/1
> swapper/0: Pointer tag: [f4], memory tag: [fe]
> swapper/0:
> swapper/0: CPU: 4 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.
> swapper/0: Hardware name: MT6991(ENG) (DT)
> swapper/0: Call trace:
> swapper/0:  dump_backtrace+0xfc/0x17c
> swapper/0:  show_stack+0x18/0x28
> swapper/0:  dump_stack_lvl+0x40/0xa0
> swapper/0:  print_report+0x1b8/0x71c
> swapper/0:  kasan_report+0xec/0x14c
> swapper/0:  __do_kernel_fault+0x60/0x29c
> swapper/0:  do_bad_area+0x30/0xdc
> swapper/0:  do_tag_check_fault+0x20/0x34
> swapper/0:  do_mem_abort+0x58/0x104
> swapper/0:  el1_abort+0x3c/0x5c
> swapper/0:  el1h_64_sync_handler+0x80/0xcc
> swapper/0:  el1h_64_sync+0x68/0x6c
> swapper/0:  __memset+0x84/0x188
> swapper/0:  btf_populate_kfunc_set+0x280/0x3d8
> swapper/0:  __register_btf_kfunc_id_set+0x43c/0x468
> swapper/0:  register_btf_kfunc_id_set+0x48/0x60
> swapper/0:  register_nf_nat_bpf+0x1c/0x40
> swapper/0:  nf_nat_init+0xc0/0x128
> swapper/0:  do_one_initcall+0x184/0x464
> swapper/0:  do_initcall_level+0xdc/0x1b0
> swapper/0:  do_initcalls+0x70/0xc0
> swapper/0:  do_basic_setup+0x1c/0x28
> swapper/0:  kernel_init_freeable+0x144/0x1b8
> swapper/0:  kernel_init+0x20/0x1a8
> swapper/0:  ret_from_fork+0x10/0x20
> ==================================================================
> 
> Fixes: 1a83a716ec233 ("mm: krealloc: consider spare memory for
> __GFP_ZERO")
> Signed-off-by: Qun-Wei Lin <qun-wei.lin@mediatek.com>

Acked-by: David Rientjes <rientjes@google.com>

