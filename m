Return-Path: <linux-kernel+bounces-298559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 978F995C8D0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3D81F2264D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CDA149E01;
	Fri, 23 Aug 2024 09:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WP1oNPIH"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587091442F4
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724404058; cv=none; b=HmUGFe7OzuUcjtPqlpYXKA5iXIdtQNE2R3rSvMKOsVEnieEtZ+0TfXe4iLMNfDYGqSxXGxtcB7N/KfhV++H8lZSSAbpFDrfRhXQl7bWgvgEm7XfHwO5jwqWEIu15P+yX3nei/lnjaMSLq6kCdkDZLs14kcvDTkdmYnlX2bT0ZDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724404058; c=relaxed/simple;
	bh=6TDhbMBxh8ER8c2wAp9Bn7Pr5nLB0LrrZiZoMLgAwM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UI9r+m9CxCB8PrJ9g/iSeXMkgkB14Xz/6Phusilv1iDJ+TRAXais3FQ6oTy4/8d3Z2WwBs8++dqVJa4lVhTo0dulnyRYlX/iccNQdYUs8hN2lZMMoBjQ/zPeZ3p6zeJdJFU0GFa9K73NFW3KOlBXrD2OifPkRgbv3QteSLCCOwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WP1oNPIH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20203988f37so16865955ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 02:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724404055; x=1725008855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BujlrYm35vFB+ocFShx+NdrnZX8baVGGGUnFlESMDdw=;
        b=WP1oNPIH2sifqh4G3R7D5p4UMENK/6+6BhFwVNRPrdQkohgYpZWPigrWgmw2ORTIFc
         QRk9OBPf2+E5gyAkTGSw+AC1uDM7z4TxPZKVHWRoyoD3bcVF0tq1r+iYw3l5hOkpbBru
         j3Ao1VTf87ajPMbKjckZIHuqcHfwjIyQmmU4EjhCepeTqcrIcrf0cDvPPSm/fo4dlwL8
         HwwAoaxa9yAry9nR9SeaA38pdrvM1O+uawci1RyXX+rrTecPU1jvq+CocFDJPSLBWJxC
         l+fgEke7vcA9+jyXE1y4QSURrNwHdIoli1QChU6BTm9AeGfp2t/i7lEfPf2X0OEfP2gB
         KrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724404055; x=1725008855;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BujlrYm35vFB+ocFShx+NdrnZX8baVGGGUnFlESMDdw=;
        b=pjwRMNtLzoZ0Z9TAZMS4JSYk2x7/BGjUIRIzz/Pkla9UOMGpVjU8zH8mXxKnP9qgeL
         bDJ2ubsIPpCzK/kSakEWBQu89GpZJGNS8te4iHhARpxi7lb7jYw7J7aYZ/y6p9Mhb1Ha
         /+Vq5YfZ6+9v1RcvEjiKtNbxaTMhU8DNqV7ESlHkM67v8op9+2fR3xZHazoqv3pmSm2l
         N5WxEiNZTGaxwJvKTNaw2oR7sAceCPZhu9jH9uVoittsP8cJnFKRFrAZCmM2MQqGAeRC
         GWtLuGfwxDke0mrDBacStZHyjP83sj8j4MBPby/ZKRjXCEJu3nIBGbLdZvvCbH9kTpSE
         /SjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG0838b0Q01yAarq8lVYr0mWf+ZYeuM1SUIHlR9+1EfJOrbPMDDnffX/75UJYaCOtaAd2CrPuirfw+xEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxBocl6kfq4ms3FyrK2IyxhVeynnoPtPSGsfyNoLg/dcPU4Qat
	3w0Zg822XnVVyVLDRYP1vBoConr5ZhjVyv/jFj0CMKo3Nc4swHV9pn63mdPzk5Y=
X-Google-Smtp-Source: AGHT+IF+yjppQ8Rvs4xK22oJaNMlOg2f+WI0R0G4POwuHjBEUSD01luW4nbMfGr/qWeNmYF+2b5B1A==
X-Received: by 2002:a17:903:244e:b0:203:a046:c665 with SMTP id d9443c01a7336-203a046c8e1mr14609965ad.15.1724404055508;
        Fri, 23 Aug 2024 02:07:35 -0700 (PDT)
Received: from [10.84.154.91] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203859ef177sm24452195ad.243.2024.08.23.02.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 02:07:35 -0700 (PDT)
Message-ID: <8f98e3e8-b6c4-4888-bfc7-204bea32004b@bytedance.com>
Date: Fri, 23 Aug 2024 17:07:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] maple_tree: simplify mas_wr_node_walk for improved
 readability
To: Hao Li <haoli.tcs@gmail.com>
Cc: akpm@linux-foundation.org, maple-tree@lists.infradead.org,
 linux-kernel@vger.kernel.org, Liam.Howlett@oracle.com
References: <20240823081729.GA23434@systemsresearch.io>
From: Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20240823081729.GA23434@systemsresearch.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/8/23 16:17, Hao Li 写道:
> Refactor mas_wr_node_walk to make the code more clear and easier to
> understand. The main changes are:
> 
> 1. Replace the forward-iterating loop with a backward-iterating loop.
>   This simplifies the logic for determining the correct range
>   containing mas->index.
I don't think iterating in reverse is a good idea, it makes the code
different from everywhere else.
> 
> 2. Eliminate the ternary operator.
> 
> The new implementation maintains the same functionality as before, but
> with improved readability. The performance characteristics remain
> essentially the same, as we cannot predict which interval mas->index
> will fall into.
> 
> Signed-off-by: Hao Li <haoli.tcs@gmail.com>
> ---
>   lib/maple_tree.c | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index fe1b01b29..0b3eb55d8 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -2203,7 +2203,7 @@ static inline void mas_node_or_none(struct ma_state *mas,
>   static inline void mas_wr_node_walk(struct ma_wr_state *wr_mas)
>   {
>   	struct ma_state *mas = wr_mas->mas;
> -	unsigned char count, offset;
> +	int idx;
>   
>   	if (unlikely(ma_is_dense(wr_mas->type))) {
>   		wr_mas->r_max = wr_mas->r_min = mas->index;
> @@ -2213,16 +2213,14 @@ static inline void mas_wr_node_walk(struct ma_wr_state *wr_mas)
>   
>   	wr_mas->node = mas_mn(wr_mas->mas);
>   	wr_mas->pivots = ma_pivots(wr_mas->node, wr_mas->type);
> -	count = mas->end = ma_data_end(wr_mas->node, wr_mas->type,
> +	mas->end = ma_data_end(wr_mas->node, wr_mas->type,
>   				       wr_mas->pivots, mas->max);
> -	offset = mas->offset;
> -
> -	while (offset < count && mas->index > wr_mas->pivots[offset])
> -		offset++;
> -
> -	wr_mas->r_max = offset < count ? wr_mas->pivots[offset] : mas->max;
> -	wr_mas->r_min = mas_safe_min(mas, wr_mas->pivots, offset);
> -	wr_mas->offset_end = mas->offset = offset;
> +	wr_mas->r_max = mas->max;
> +	idx = mas->end - 1;
> +	while (idx >= mas->offset && wr_mas->pivots[idx] >= mas->index)
> +		wr_mas->r_max = wr_mas->pivots[idx--];
> +	wr_mas->offset_end = mas->offset = idx + 1;
> +	wr_mas->r_min = mas_safe_min(mas, wr_mas->pivots, mas->offset);
>   }
>   
>   /*

