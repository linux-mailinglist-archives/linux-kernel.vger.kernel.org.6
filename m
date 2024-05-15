Return-Path: <linux-kernel+bounces-179375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B0C8C5F6B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 05:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A601F21A83
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 03:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0CB3839C;
	Wed, 15 May 2024 03:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IQFb+fnc"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B874B38385
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 03:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715743965; cv=none; b=GxuAm09lltvPzGBiDuks2yz30CYhazzuKmSNkh5AID+Ye3QOgcJfQXfGXhb6v7j52Im3Qs7hLRK8anHAQX99pLBl8xJu4I6MEHIPPbzdLcS6VdXGHJ7LfqUrXSM39Jqak59dUCquVr69zdRzr8gww14NtzaV8KVj3yoQ6l8TQRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715743965; c=relaxed/simple;
	bh=IwjxX6lGjtRR4HsC+Tx98ybpDz/8CNenXrNP0R7dQk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqrLoo2bz0xI2+Bwf3HZf9U4XNiLlgV2LACz+/zV+As3EGx/mOSLjG+Tm8rKVPEN7QJzVcFtxD4+FDkztMuXDUOkKdqp9vci2Il3l12xUr3MG8zrUp/ZoE/wQAamffl+QSaA2ClbcOHd3c/cVaRHQPNaRJZIOJbw+J0vXuzNOkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IQFb+fnc; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59ce1e8609so124764166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 20:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715743962; x=1716348762; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n78oaAZRyO+VAfWO7SduK6Bbx6aSAbla91zbFFaUVww=;
        b=IQFb+fnchIRC7GqVva+r8lW7Xi4SHJiGntne8eKqzYa3ARlBxbtWGrrJyALoWIuw7c
         mz4PZmkXItCiBUybEh9TtE4Aj3DdzPeckGDAqDQ5H3XgFWnDYuCEyyGUDFCA6WxmPQ/K
         Gw2poZGgOlhCEx+0YxVFQs+IydHtdsQ4/5x1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715743962; x=1716348762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n78oaAZRyO+VAfWO7SduK6Bbx6aSAbla91zbFFaUVww=;
        b=kR5KpM8+8poMyY58fjFUB60MiWN9cu3WLbSa26NAIrKanIP73L0PVEO8TW0gNQawMi
         4TYxC8rRnCK54A9F3CW2E6OCEseWkAemCRVvPc5dL8TPnhaZsqdsnrkeBQ+rSLskHCaF
         H5mQNX4FemEq4+PPxMFmAHrbe6CdKN5LgCQODJvkRHT9umMA4wBR+CchsDxqqMsBLnSd
         Ko9v68WdcRMc0LFK+4MUfFbAGtb2qGJCRBhVXvq9LdK8y6g/JmoEHFbLJ2XVJkXOcY7+
         md1rJOIem36L2kGSAVVl+/VUv6DcLdhuWjrVVpTF1esdrfkJAwm0jw753jSk/s6kvMub
         jdyw==
X-Forwarded-Encrypted: i=1; AJvYcCVwZTrus/jeWpkn5y+hmUlhNS6YtE06AH3kGNsFPxQ90BFLDUQDYVcgfxJjLfuBjKgEXk0wR1OATFL7qm/9neYYKHjoL8NXY+Cbopaq
X-Gm-Message-State: AOJu0YxD837cfm9NamJfSvn0fMOad+XIl29g7sfc75hT39xi/zCN+MI0
	mu/CgE4vmNuY2b38gGZny86TaH1hEg+G0SS+cjPif8vG7GhsaKlcT5+BN44m6MZhuZvLQ3SKF0d
	9udsxcw==
X-Google-Smtp-Source: AGHT+IHwlLSmTjK3g7Dy1mw/GSN8WaXLl8CodErmB7lzDUwKnfMds4X1L0VTwf+myPZLxtJhE61V0w==
X-Received: by 2002:a17:907:7dac:b0:a59:adb9:6c2a with SMTP id a640c23a62f3a-a5a115ef957mr1883983666b.11.1715743961697;
        Tue, 14 May 2024 20:32:41 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17d02sm798722266b.218.2024.05.14.20.32.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 20:32:41 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59a609dd3fso135423966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 20:32:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUysFbKoQ+Ci2m30YHJONv616gTmTgykuN9q+UO/Lq2Tk3hLHZNeNRFL13APRXBsd5Dk99I6DSpqvdrjWi8EOlmG3GREt3ByqSlMDge
X-Received: by 2002:a17:906:70f:b0:a5a:7493:5b68 with SMTP id
 a640c23a62f3a-a5a74935c7emr527515666b.24.1715743960872; Tue, 14 May 2024
 20:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514231155.1004295-1-kuba@kernel.org>
In-Reply-To: <20240514231155.1004295-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 May 2024 20:32:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiSiGppp-J25Ww-gN6qgpc7gZRb_cP+dn3Q8_zdntzgYQ@mail.gmail.com>
Message-ID: <CAHk-=wiSiGppp-J25Ww-gN6qgpc7gZRb_cP+dn3Q8_zdntzgYQ@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.10
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 16:12, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Full disclosure I hit a KASAN OOB read warning in BPF when testing
> on Meta's production servers (which load a lot of BPF).
> BPF folks aren't super alarmed by it, and also they are partying at
> LSFMM so I don't think it's worth waiting for the fix.
> But you may feel differently...  https://pastebin.com/0fzqy3cW

Hmm. As long as people are aware of it, I don't think a known issue
needs to hold up any pull request.

Even if that whole 'struct bpf_map can be embedded in many different
structures", combined with "users just magically know which structure
it is and use container_of()" looks like a horrid pattern.

Why does it do that disgusting

        struct bpf_array *array = container_of(map, struct bpf_array, map);
        ...
                *insn++ = BPF_ALU32_IMM(BPF_AND, BPF_REG_0, array->index_mask);

thing? As far as I can tell, a bpf map can be embedded in many
different structures, not just that 'bpf_array' thing.

That spectre-v1 code generation is disgusting. But worse, it's stupid.
The way to turn the index into a data dependency isn't to just 'and'
it with some fixed mask (that is wrong anyway and requires that whole
"round up to the next power-of-two), it's to just teach the JIT to
generate the proper Spectre-v1 sequence.

So that code should be able to rely purely on map->max_entries, and
not do that disgusting "look up struct 'bpf_array'"

Anyway, I've pulled it - the bpf code looks broken, but it looks
fairly straightforward to do it right if I understood that code
correctly.

              Linus

