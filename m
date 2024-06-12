Return-Path: <linux-kernel+bounces-211359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90249905096
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6E71C210B4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0BB16EBFF;
	Wed, 12 Jun 2024 10:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9L9OakW"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC537A93B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 10:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718188972; cv=none; b=jjpL6+P3CEK2HvjdUUgLTi4TvgxsifxiurxtNvrojdyV5I+ad/Bw7cF5hQnwK6UW3WUJQN0NpE5hJBvgvd8BBAU7CEJx3tdINC5wHcs8wdZKqiHJi+00FT5kSapsYPLAy/Ed8HEyHOCKLQGYkbmyVBgSY6uWUxnh3gylrj2I57U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718188972; c=relaxed/simple;
	bh=2XwGvhbD54qUCqDh5ZqW42AThD2/LYE3fEFmsOx36Lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMNSUfQmOIIzOA2t3ZnXBSEpgnq0L0YCSM7o4JoM6ySfiW/W0H3JHSdVi2RlYCCzQCzFeRmvfRPF/xXv5Dg0r8zpZ6jvwUWpBtkO2upHD92rqRF3L13VqlQv880BZU8peKOqSJX8l/RY+90JCXikRmz73U4H4AHi9T/BJuFovoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9L9OakW; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6f177b78dcso423396166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718188969; x=1718793769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ejgIXmzvvComY08Yy5gfeDMSrRGMGtcObAMX3owmvqw=;
        b=A9L9OakWD6NFj7kyfReW9eSegWcoAPFe/9MUU8pUzchtUuh1eUFjGbPiF5T6Do8TT/
         RaXrAs970i28jk9rvgsQi9J3KWLGjLBWikHAaO+yY/e1XVHe7IO0SxM0WmqhwpkAyltg
         JVT+GbmvfEwUg4/SlXdn7zX3YHwe/hG4HFcsbqqzrJTl5gP9KJ19p7TIgkQgdnYz5BZS
         gPr5bKVsF5xOQuQHklIaXTHun86jnBweaNgYkRWvpDHFtiuK+wD3JLBh2vrcR3aLB3K5
         O7l1CgnFa2d2eL76SQYi/y/yuxvgGeCDoiEdxJkGvIMvEiNbk1eE0wNnegrWd1Gv3kcy
         yMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718188969; x=1718793769;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ejgIXmzvvComY08Yy5gfeDMSrRGMGtcObAMX3owmvqw=;
        b=w8dn+7vxEwAl0wuWDOi+dcY/WNA82nqxYDKglvPqrQ2oZOGp3Xwt8ZPkzTN8HMTUtp
         NZRecRISMCYWNYaB9wWpoMvsZeIxKDVGKT3dnaOeTqS/yhHzFiL7HaSOqIpOKrOwP0kr
         yw7etLwwhUNjDWZ16Soe2PzqWT5D8438ZEfcVaPPUZFVQFXASiHUEx60YBfRTsf6htgc
         D5ghtSaH5J/nOf7Mi0jU+PCV2f3WkW1hYl+lsMcpCOuPlCnzzhhKmwVOQFoAf4cwWqSJ
         aGtZmIqkX8z2mDL6v9OY25VSFPJQ5t6KXty2T+CqtcbNlAzhiBtJc9hz6d7sjSK8WFeh
         +NMA==
X-Forwarded-Encrypted: i=1; AJvYcCU/FPhDnrvAXE8K1vj+KhucTnxLFKcHScqtX8jVtItfb1zY3Fm14N2ouO0ldd43RcSJZOJZXWtCGQ4szXtEj97LZzOsE2rQFalqk9Cc
X-Gm-Message-State: AOJu0Ywy2a6NiuMoTrKmRhPOfmu8JiFNcrq1S2HzbW3ddqwt1pe5qUHi
	szueGPIU8nh6d413wR0AqIdARWr/HdgEqKicD1Spqy881/4f6mmU
X-Google-Smtp-Source: AGHT+IEZcovSaBqgCkdTE1FGjX91iscrvkVPJZmnAYq/r4gf/teWPLTxnzQ/LiTENoQ5H/yqTyJ1Wg==
X-Received: by 2002:a17:907:9724:b0:a6d:b66f:7b21 with SMTP id a640c23a62f3a-a6f4800b17dmr117532166b.54.1718188968801;
        Wed, 12 Jun 2024 03:42:48 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:e76f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8072ac1fsm872200666b.222.2024.06.12.03.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 03:42:48 -0700 (PDT)
Message-ID: <b7635421-e5e3-47cc-9aea-13a4a9c224fb@gmail.com>
Date: Wed, 12 Jun 2024 11:42:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm: store zero pages to be swapped out in a bitmap
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com,
 ying.huang@intel.com, hughd@google.com, willy@infradead.org,
 yosryahmed@google.com, chengming.zhou@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Shakeel Butt <shakeel.butt@linux.dev>
References: <20240610121820.328876-1-usamaarif642@gmail.com>
 <20240610121820.328876-2-usamaarif642@gmail.com>
 <CAKEwX=PnwjmZKPLX2=ubD6+-+ZAqpXnczkHe4=1QY1hizOE8WQ@mail.gmail.com>
 <d6088fb2-58d8-4ed1-8d3b-83ea34657db7@gmail.com>
 <CAKEwX=MOWFQojVgO7u=zEpQSG661j1QHjTGL9m3Gcy47CLNKAg@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAKEwX=MOWFQojVgO7u=zEpQSG661j1QHjTGL9m3Gcy47CLNKAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/06/2024 20:33, Nhat Pham wrote:
> On Tue, Jun 11, 2024 at 11:50 AM Usama Arif <usamaarif642@gmail.com> wrote:
>> In swap_writepage, with this patch you have:
>>
>>       if (is_folio_zero_filled(folio)) {
>>           swap_zeromap_folio_set(folio);
>>           folio_unlock(folio);
>>           return 0;
>>       }
>>       swap_zeromap_folio_clear(folio);
>>
> I was concerned with the swap slot being freed and reused, without
> ever being read :) But looks like it has to be properly reset before
> being reused, so all is well on that front.
>
> What about the put_swap_folio() -> swap_free_cluster() case - do we
> need to handle zeromap bit clearing here too? Looks like it's clearing
> the swap_map (i.e returning it directly to the swapfile, allowing
> those slots to be reused) here, and I notice that you clear the
> zeromap bitmap wherever the swap_map is cleared as well :)
>
> I jumped around the code a bit - in free_cluster() (called by
> swap_free_cluster()), there's this chunk:
>
> if ((si->flags & (SWP_WRITEOK | SWP_PAGE_DISCARD)) ==
>      (SWP_WRITEOK | SWP_PAGE_DISCARD)) {
>      swap_cluster_schedule_discard(si, idx);
>      return;
> }
>
> swap_cluster_schedule_discard() does clear_bit() on the zeromap on the
> entire cluster. We also clear_bit() in the work function
> swap_do_scheduled_discard() (is this redundant?).
>
> But what if this check is false, i.e the swap device does not have the
> SWP_PAGE_DISCARD flag set? Are we not clearing the bits in the zeromap
> here?

Yes, should add in swap_free_cluster as well, will do in next revision. 
Thanks!



