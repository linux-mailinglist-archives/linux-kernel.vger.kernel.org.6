Return-Path: <linux-kernel+bounces-251970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D1D930C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 03:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CB3D1F2153C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 01:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C964C66;
	Mon, 15 Jul 2024 01:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Btrzv+BQ"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5731EC0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 01:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721007134; cv=none; b=VL7fBsn9ROlfao3ggU8tpsoi+HYgOdunlhHAMZSMl18CJwn2kWYvosNoxyIb8XTp1EEgVCGDVqxwgs7CjhZQPp48j/T6jp/22iakv7ivA7RRezYLkJjQhj7hFGMUKfkv3LdYeZrgEZfS/oXOJiKJBYLgy6ZBVOrRaK7pmxg4n3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721007134; c=relaxed/simple;
	bh=KPsoHSHeKeYzJKNDyOqjdfkbnSW9QQejUnCndA46E5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2oFTT3p4A/JC7px3rndkje0vYmKHEBB0pH1lCj/EaNXXvs0JysxQL7RFDubbWq6qAO1y1kGeI33wPVPW1EFhz6nkhoOb+1/mwWXuAuagWCLMhwvxfb+ZR4RQZ6DfJ1KNWm7vNoYgFQAvlLWi23ryRcoZwnHu5w9RlzE0F3lJpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Btrzv+BQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70af8128081so2522384b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 18:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721007133; x=1721611933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XQFu/JioUy1vLxTny6GvuQk3q0xq5+xwim4zUR0K5aU=;
        b=Btrzv+BQySae0lBFHkMO4MU8p2RFm+vBqKHhCWPBWAciZAcC8p+lmy1GboUZAvniij
         M5uzL3rhLtv09rL+oAktT+iavGUK3vN1UwgDLQ5qeD/13tvjFCEu3t+G851iBXKYILA8
         33O5r6PIIQdFX0kPeMuwkvzqxOpJ4FpnG6kSL/asm6TwHDl4JipIVkM8nblv+E7Q++Qr
         kGl5xGDXBJ1kuxCGCPUVjckk9yYKC0MZ/XvTN9D/Y2Vrdk9Ks8596OLJ1PqXunMAEjPw
         uBwehyZufcyyluZ3j1g0TwwIn85uQEm9wdC5rYILC27EgCX/Jla0Wwru3G9h/9Ch7xP6
         ENfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721007133; x=1721611933;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQFu/JioUy1vLxTny6GvuQk3q0xq5+xwim4zUR0K5aU=;
        b=QavfEESOx8TSEfPA4j0pcxAfdIQmKjv/pdUZpUCLhyrhCnRyq4leRNSPKNuLN+84dH
         HUIMlTtcXwxzQdvLoqWgSpDoxTfKqzzyShv1gpTcOtYqTQ6yiRdzN/ZSOoMYk6/jlgPk
         Io1b2Z9zCtTFeH8QCOQ3jF4Yjkorq31zaIKVgJTvIluMlFER8EXQ3bh5M7mDcjBZt0GZ
         cLxlH59wnBArJVXX7lLoYJqkouy7tZYFKZfW0BrRxfT3TCfzbT4GcKwGjVa96u1ilJEv
         aZQKMyxJazi3+xGyLHICVU8giZbsWJKRrapxMZYC7QehtbV7NKDhzeJvgZIgCJDSgWTt
         LFXg==
X-Forwarded-Encrypted: i=1; AJvYcCUMPWUOo6HMDzPP9wYj8gH2vQbpFljbNND/0Aoa1dPcpIWQUhDU3Rxb9Ez3R8ATdNRn6GGaqcN8lZLkr2qdKDv92SJnqvgYr9ox6jgt
X-Gm-Message-State: AOJu0YxUAFR0pzRpdGzxdDrh6igeVfBmrTxX+IVNJ+bYfgi8v8VkpdMu
	ZqsTmyTaqacQYv7x0iOC5ngJx+sWdymaBoXZ0u9lVdl4cyPi2P7BO5Bt+UAKOxc=
X-Google-Smtp-Source: AGHT+IHdZxU/4v+wxPvF0uIKm0wsc9+MDUI+igtgyKKvJ+n1+8P2B6vYm6C/y9d8CI+rgJNu6MUrxQ==
X-Received: by 2002:a05:6a00:1da2:b0:70b:1525:9acc with SMTP id d2e1a72fcca58-70b54ea2255mr11236665b3a.32.1721007132607;
        Sun, 14 Jul 2024 18:32:12 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-78e34f14f53sm2469627a12.51.2024.07.14.18.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 18:32:11 -0700 (PDT)
Message-ID: <e6f0927e-6c0b-4983-b539-61527882098d@gmail.com>
Date: Mon, 15 Jul 2024 09:32:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REF PATCH v3 2/2] mm/slab: decouple the SLAB_OBJ_EXT from MEMCG
To: Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 roman.gushchin@linux.dev
Cc: alexs@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Yoann Congal <yoann.congal@smile.fr>, Masahiro Yamada
 <masahiroy@kernel.org>, Petr Mladek <pmladek@suse.com>
References: <20240710054336.190410-1-alexs@kernel.org>
 <20240710054336.190410-2-alexs@kernel.org>
 <d6bfed41-4c2b-4855-bcb4-522079f19bf4@suse.cz>
 <9b1384e7-e75d-4d71-8798-0d47c33cece6@gmail.com>
 <CAJuCfpEJKLi2kzwWxdDCfSHu0gtRtLAkUrovtUpBwQhftbF+1w@mail.gmail.com>
 <059634b2-7346-4072-b5c2-5b1180bae694@gmail.com>
 <659f204e-de5c-441a-90de-4a7cbfcabe69@suse.cz>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <659f204e-de5c-441a-90de-4a7cbfcabe69@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/12/24 3:27 PM, Vlastimil Babka wrote:
>> I checked the history of slab for this part. It introduced
>> from commit 10befea91b61c ("mm: memcg/slab: use a single set of kmem_caches for all allocations")
>> But still don't know why !page_has_obj_cgroups followed by memcg_alloc_page_obj_cgroups. Anyone like
>> to give a hints?
>>
>>                         page = virt_to_head_page(p[i]);
>> +
>> +                       if (!page_has_obj_cgroups(page) &&
>> +                           memcg_alloc_page_obj_cgroups(page, s, flags)) {
>> +                               obj_cgroup_uncharge(objcg, obj_full_size(s));
>> +                               continue;
>> +                       }
> I'm not sure I understand your question. The code is trying to charge the
> allocation to a memcg and use the objext.memcg to associate that memcg to
> the object so it can be properly uncharged when freeing.
> When it's the first object in the particular slab page to be charged, the
> objext may not be yet allocated, so it has has to be allocated at that point.

I see. Thanks for explanation!

