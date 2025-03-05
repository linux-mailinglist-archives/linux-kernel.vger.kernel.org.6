Return-Path: <linux-kernel+bounces-546486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795EDA4FB31
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA850164F3B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6330B205E2E;
	Wed,  5 Mar 2025 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpoRO1+Y"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AE186340
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169213; cv=none; b=YduXyVfzoJRe0x9FSRS3+ZPaeh8+su4J/lSDpDcmGSYu4LVV+Kbd9FMASPv7G50eh0u885ryYFggjll/47Q2w0C9KEwEaKUqd4GgQQWxMyUfd4wB6cTKo8AO8ta6ERoBBAPN4TkNfv0/OWU+iPCMlAM4C89ejDSSngY348v++Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169213; c=relaxed/simple;
	bh=DfA3zBuxNA+dq5Oyhc3DMrV3+lTOF6LiJ8VaD61ecCo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3DpsXOEoD9wSaqSBXOho0vcll7KhMQwy2zoT4d1zZ7Ou7s4Te/qBnsCla6bpefuCaJh7QibiT7CFGc0eBcE6tPcFEpcnUdeW70Xsq75Wr2MH5+CHHbf021FVpn7b9Rc2hcv1JzAK9p8clEoItqrlFLmvaRSu/KOGqQBMEysaA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpoRO1+Y; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30b9f7c4165so39688021fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 02:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741169210; x=1741774010; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nz0m9XjljqPblAse0sZQMRClnBy6VQjPdVLGpt3wUIM=;
        b=GpoRO1+YmpCZoXeDNOjucvh24qALqcxTLRL+Zo/KKoFiWNjfQ0k4EXsVdjE8rdv1mv
         kDYW2DDai26AvzinTK95c1KNwsCzZ8vPI9/FDRLZGp7TNRkqXtEp7YktCfFP5eWw+raU
         JOUzUb/GyYKS+MHosnEmnmtdr955o3YTS5vIgobWm0jIOePBwd+25N/Wan18OMr2AA6z
         z/X5pwmyIH4NAnIdyN1qMTkKxD3mHM1cfF9DOXJrkDeRY/3kyV/9OwXmOJTRoWycB/aH
         KJdLdwUN8+JIDBgi9Kn4+4Z2Ac3Vcb7mTp4cmcrVlqJbL5YyFA+SOP8hPQM3+nG+MGII
         5FIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741169210; x=1741774010;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nz0m9XjljqPblAse0sZQMRClnBy6VQjPdVLGpt3wUIM=;
        b=NzS7m6fBvEpxQuMeeuEgtLLe9aJlKk1boDqs0ORqG8hbe2dqvPPBXiSUu3SNVuJgc7
         2lF8nuDaQrHkZgEN/AIWJ8ZIyymmayiQt/YJ0j+RJn8ve09pn5zUq5RwVyRggKFGj806
         XolgEfB8/els5WrzBTckKdYtV6Y+gXzatsbF6mDjecvaVNZ7lmg5BjvzfxdliPC+ZF5C
         6gpNa34eHYgfNokwJV1vQNBP7hd1b1KjfyF31geEdmLU7ec7qQzHz+mXPJK+diCAU7ZU
         zinY0vcir+CKHVG3FMyvm9jfXSo28SIdq0azypdpIPkws61TlhsM2uPQbxpFepWU2HWA
         uVvw==
X-Forwarded-Encrypted: i=1; AJvYcCVCaLN6HhLbnT8GI3H1sC1jfdLN2DJd9aVHqcrlNjjQjdT1d2QKuHqlTzcN3HpEpGPoQQv9heHFloN8+cA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNRfX5dHuf3FAWw+RFw8ctf+0ikPo1BN/9vnEOihPLe2JY8Vyp
	poc+ywIv+PJ3pXbfqOzJ/7OtbKV5H7wTO2ldojdk0F7Pi6jo2gEY
X-Gm-Gg: ASbGncsKL0XpZUjyyi7ZTlECKMsOj0TNvAXGTEnp8SJ5CTGjeS9/QqwDhDk4Av7Ce7G
	sNOfv1hi//GVtSEqQ7f4KrQRlOLTb/KXHLVQmRv16cq/UbNEt6NBG2gCx5WisA3f7Kbq4OXPO76
	wTKql67R+T1Nz/6QKM716XCysEU36SxUb2OvDGAMyLoxK/+i5tBAskpRBpBc5zUqF16Zk2FR3mQ
	kgiFqP76qkey3kv+wB9sb4Bpt76MJRljvzPYPw7tn1LxGq8V/2P5vZOyNiezh/atY3ZJZrEBeSa
	Z457slxN4TGz/F72KYd0KTfOS8Ec49yL4i50x5vrh8CZLBT7D45iUaUlbfSoTbENPxI=
X-Google-Smtp-Source: AGHT+IG9+VyiFJ8Bg58dftnhDOV3AWLXhGy/UlIQSuO5xKlJiv2sStd/Ls9bdEQrSRkUxRJdhxXgzA==
X-Received: by 2002:a05:651c:9:b0:300:3307:389d with SMTP id 38308e7fff4ca-30bd7a583ebmr8662591fa.19.1741169209563;
        Wed, 05 Mar 2025 02:06:49 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30bb1098ef6sm10975301fa.42.2025.03.05.02.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:06:49 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 5 Mar 2025 11:06:46 +0100
To: Baoquan He <bhe@redhat.com>, liuye <liuye@kylinos.cn>
Cc: liuye <liuye@kylinos.cn>, Uladzislau Rezki <urezki@gmail.com>,
	akpm@linux-foundation.org, hch@infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm/vmalloc: Remove unnecessary size ALIGN in
 __vmalloc_node_range_noprof
Message-ID: <Z8giNq5CMtbYnlo-@pc636>
References: <20250303094410.437985-1-liuye@kylinos.cn>
 <20250303094410.437985-2-liuye@kylinos.cn>
 <Z8X1U-3f35-JZTUr@pc636>
 <6701d375-8d7c-4e13-b0db-486a48088446@kylinos.cn>
 <Z8ghK22l7USzuBWY@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8ghK22l7USzuBWY@MiWiFi-R3L-srv>

On Wed, Mar 05, 2025 at 06:02:19PM +0800, Baoquan He wrote:
> On 03/05/25 at 09:46am, liuye wrote:
> > 
> > 在 2025/3/4 02:30, Uladzislau Rezki 写道:
> > > On Mon, Mar 03, 2025 at 05:44:07PM +0800, Liu Ye wrote:
> > >> The same operation already exists in the function __get_vm_area_node,
> > >> so delete the duplicate operation to simplify the code.
> > >>
> > >> Signed-off-by: Liu Ye <liuye@kylinos.cn>
> > >> ---
> > >>  mm/vmalloc.c | 1 -
> > >>  1 file changed, 1 deletion(-)
> > >>
> > >> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > >> index dc658d4af181..20d9b9de84b1 100644
> > >> --- a/mm/vmalloc.c
> > >> +++ b/mm/vmalloc.c
> > >> @@ -3798,7 +3798,6 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
> > >>  			shift = arch_vmap_pte_supported_shift(size);
> > >>  
> > >>  		align = max(real_align, 1UL << shift);
> > >> -		size = ALIGN(real_size, 1UL << shift);
> > >>  	}
> > >>  
> > >>  again:
> > >> -- 
> > >> 2.25.1
> > >>
> > > There is a mess with:
> > >
> > >  unsigned long real_size = size;
> > >  unsigned long real_align = align;
> > >
> > > "real_size" and "real_align". Those are useless. What is about:
> > 
> > Sorry, the order of the patches may be misleading.
> > 
> > The correct order is as follows：
> > 
> > PATCH1.  mm/vmalloc: Size should be used instead of real_size "
> > PATCH2.  mm/vmalloc: Remove unnecessary size ALIGN in __vmalloc_node_range_noprof                 
> > PATCH3.  mm/vmalloc: Remove the real_size variable to simplify the code "
> > PATCH4.  mm/vmalloc: Rename the variable real_align to original_align to prevent misunderstanding
> > 
> > If PATCH1 is the correct fix, then consider PATCH2, PATCH3, and PATCH4.
> 
> Well, seems the patch split is done too subtly. It's only about the
> size/align inside one function, maybe one patch is enough in this case.
> My personal opinion.
> 
I agree. One patch would be enough.

--
Uladzislau Rezki

