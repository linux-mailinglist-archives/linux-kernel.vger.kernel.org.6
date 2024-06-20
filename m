Return-Path: <linux-kernel+bounces-223270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7244691107E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC182825F7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F33F1B5805;
	Thu, 20 Jun 2024 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="0PJ9bHf0"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6351B4C4B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 18:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906576; cv=none; b=PiLMWKG4w1LKpa6N7Yg/AiC4M1Olmq1cEfhBE4c8Wh88F83kg+Pp2fY/Jmcs5zCw1iK7jHn9tIj7JKOtlh7VdYQu4zK5YYw3yVsaqFMQQpzONTAsn6ufD9oejnntfOKLdx+bVffjw8IhwDjX8shCOsnD46mb70rZG5A1MgJlMxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906576; c=relaxed/simple;
	bh=Po3QlY7negO5UCla1ZS7JLYvAfUuS5/ro263AlASoqc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Mcb21Dj2iQ9cX8o3FRZR4krdi+KBRcdRre36w4MG+100VY6Wo4YHij00Y1kPNTTDijICx/gcas6ppxZbuh7qYtl4AKCQlYpoCiySb1PRSHukmh/SavD7cDG2Rq0Fg6hRc522o3gVhC+YX8muJk/XQMb5FLcRlnPzV+pXnHIVD38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=0PJ9bHf0; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-375af3538f2so4820055ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 11:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1718906574; x=1719511374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Qz9jlWmDkZmtbdUlVdk29k4QOcWOt4wWsvvxN5FWug=;
        b=0PJ9bHf0qxQtv0tkmxbtTokC6Xxm5LCMSLnk/SrJP7AyMYP8idyhoo+rcRqNh7Pl9U
         w1MLFQIlTmSs9e1mGdr16MKZVc1pgsMQVun7nQu14TgR4tNS42zH1f17+x4m+fJx7nXq
         ulICD/L4KODyqzL/IbcPJ8NpYXl0u+2jsORgf2QmK/ld5ucS4vyMlaPqtZi1p/oFVel8
         5BPbfK62trjwuCOT3CdlqeqW0XjnW8/FvsB86fmPkVfSF6K4Yz5JonqI4lX+5DcnrH3x
         AmX7q851gcBcxhaCdiSlrrDrKgZzc59mU35X+zEcmL/QLJMY7HOQK8fW52YS69Eq+Ji2
         NSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906574; x=1719511374;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Qz9jlWmDkZmtbdUlVdk29k4QOcWOt4wWsvvxN5FWug=;
        b=UNZHJ24cQig6xlEXn/flYMuhVX4cXvpTUPWedzk2jIgZhXG4a+fzKsLduDdWV0DVVX
         /LlPNE6QapXN5JBUlo/vHG3k+XmTFw3NAkXY2CDU3LYDSuKMgrNZ5xcBqNWvOD3PI1Uc
         BjMaKkQlQ5DX+BaxPTfWRrXpquy3KT6NG89uveKt/DWP2HIpikNTYXU+G91rklVBoZ8O
         ILuNaNxelGfOgoO4Gpykuj6Dqq3PB+APhvVvMzSnq0v+9lEB3yb5BhacsA/vMubFtv7y
         tEAwZ84ascxsShdomMUYOU3xAwEt5aw1Brsdffb8m86jAbvVdegXqa5WWl2QRoXjbp9U
         81JQ==
X-Gm-Message-State: AOJu0YzjEBx5VY5OW02VGZ37M9nxfmw4152o8OCEG3S7qgkS1lHpU5jM
	7R+NoGvQ/fbZfw0nuEGWlS87SaQod2yNgMvhxbFtnwBcMc1U33icmwBikH2VYd06KJQsm+hT52a
	BT8Q=
X-Google-Smtp-Source: AGHT+IFfEEgDs4n2+MF/0tHKPsSrZUMKCSuyV8ocM4F5arwnroC2vy4H2Ws/7SUtA9bHKoG4bq/m/g==
X-Received: by 2002:a05:6e02:148c:b0:375:b19d:deb4 with SMTP id e9e14a558f8ab-3761d657299mr74849545ab.7.1718906573851;
        Thu, 20 Jun 2024 11:02:53 -0700 (PDT)
Received: from [192.168.0.50] (dhcp-24-53-241-2.cable.user.start.ca. [24.53.241.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b956934522sm4442432173.58.2024.06.20.11.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 11:02:53 -0700 (PDT)
Message-ID: <00d74f24-c49c-460e-871c-d5af64701306@draconx.ca>
Date: Thu, 20 Jun 2024 14:02:51 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Content-Language: en-US
From: Nick Bowler <nbowler@draconx.ca>
To: linux-kernel@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-mm@kvack.org, sparclinux@vger.kernel.org,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <75e17b57-1178-4288-b792-4ae68b19915e@draconx.ca>
In-Reply-To: <75e17b57-1178-4288-b792-4ae68b19915e@draconx.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-06-20 02:19, Nick Bowler wrote:
> After upgrading my sparc to 6.9.5 I noticed that attempting to run
> xfsdump instantly (within a couple seconds) and reliably crashes the
> kernel.  The same problem is also observed on 6.10-rc4.
[...]
>   062eacf57ad91b5c272f89dc964fd6dd9715ea7d is the first bad commit
>   commit 062eacf57ad91b5c272f89dc964fd6dd9715ea7d
>   Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
>   Date:   Thu Mar 30 21:06:38 2023 +0200
>   
>       mm: vmalloc: remove a global vmap_blocks xarray

I think I might see what is happening here.

On this machine, there are two CPUs numbered 0 and 2 (there is no CPU1).

The per-cpu variables in mm/vmalloc.c are initialized like this, in
vmalloc_init

  for_each_possible_cpu(i) {
    /* ... */
    vbq = &per_cpu(vmap_block_queue, i);
    /* initialize stuff in vbq */
  }

This loops over the set bits of cpu_possible_mask, bits 0 and 2 are set,
so it initializes stuff with i=0 and i=2, skipping i=1 (I added prints to
confirm this).

Then, in vm_map_ram, with the problematic change it calls the new
function addr_to_vb_xa, which does this:

  int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
  return &per_cpu(vmap_block_queue, index).vmap_blocks;

The num_possible_cpus() function counts the number of set bits in
cpu_possible_mask, so it returns 2.  Thus, index is either 0 or 1, which
does not correspond to what was initialized (0 or 2).  The crash occurs
when the computed index is 1 in this function.  In this case, the
returned value appears to be garbage (I added prints to confirm this).

If I change addr_to_vb_xa function to this:

  int index = ((addr / VMAP_BLOCK_SIZE) & 1) << 1; /* 0 or 2 */
  return &per_cpu(vmap_block_queue, index).vmap_blocks;

xfsdump is working again.

Cheers,
  Nick


