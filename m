Return-Path: <linux-kernel+bounces-549569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF16EA55408
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1AB3B737B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559E725D8F4;
	Thu,  6 Mar 2025 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="zqNUp79V"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD8425D534
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284090; cv=none; b=ke+n6PYAkVit1J40CtqAFdidEPWM2DOIpUEs5Hmtm9Uo5wqQ1gh23qrt0Tueb6D9xruGE40cjQfO1XUil0+Q5mUYu5NBvFomq1vj8l89d/NHoKxPebQnXj/I3ZnLb/T4Bwd9cK9AgR9xXz2ehmS1ZjuexoXTq+UCDUN8PZXkCho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284090; c=relaxed/simple;
	bh=MlHWpuSPnBnNnarX4860OY7cQRU3tIoDpwNBc16ZlGo=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=asmNr4Pzo0+rhL/Srb440x2VNqFSGIJKR3lqWAeeFazvf6FHOH9+kEOQ8I7mG6a8iyrQzjn0dJP4LilX8gz1FiDSKpY5SV53bDGY1xqip/l4Uc0/IUVUPlxiiVkm4Eo505nrMLQm2r/PaflUjVWxAUotrs6ynTDiaR8rpY88oNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=zqNUp79V; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fa8ada6662so2178163a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 10:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1741284088; x=1741888888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZqJTh0YCvVr8icSs09kza3W0ABw7bZnL85iQtnzYZ4=;
        b=zqNUp79VpIhIJuj1DjBE9YTemkwt+z0KoNE++XqSqekw07Einshg0p4wfGGJlQQmGn
         SXPH23NOcdDc3bCs8jCfTvzXwfN9DJdYLpj114KNu6BUvRFAeSLsz3QLXuixCG0dLIls
         PnQYHFy3E03m3WamDNugYwrhkFVcJI/Nt3Lpb9m7WnBDfCR3gAJ8GVmN+C1BbAQhIH9M
         IusT0OUEMtazyjlhYFM5A4CKUYXPfuWSKQjQXaTUH0RZZkJXx+G7pvOsyZ4dppQVck45
         i2x8BWnEjRyQCB18lDaLj4zKNhkJgIJCslxq3eprvbZX3U5G3Nw4Q0sIkjIIURTZbPZI
         /h3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741284088; x=1741888888;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZqJTh0YCvVr8icSs09kza3W0ABw7bZnL85iQtnzYZ4=;
        b=FNHKLW+iDOr5UhrqwYppaF+1fbFrLjnMySn+b/SPR93rPDJrdpKFKTYH5+RlbNMyGl
         tW20tZIGxQwcJwK2KsYnpiBcJEWAXnSs3MDCfVo3KYojHq8s/YQMoferIkpoIf55uUvC
         ZKpcRW80MviTpgpkPuPdgzjwvBHTPPSmcEorvMxDFT+f5mg/DW0luK/vw9XfgJNK9iiz
         qNGy180jsXCLDdW8wCnY0ACVmRWYXC/a1Lqe9WbplL9cN7sSFSvS0oWtFWAl365hz5Yw
         6htrl87gx5gaNc4lpZBuQAJJvgzpnLwzSIc0Onvm/A8m2cRQpOEMR0PBAP6tLlUQNRjG
         dpFw==
X-Forwarded-Encrypted: i=1; AJvYcCWwk97d5nFggJ+QdGgYMmUG0Y/L8XF6vtSDlHo4tjTjvkOEMerCUCIDeMn7rJxVcL1QvXJSMrwMgQVLdus=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ4Zqh3YkzYTNaTrrlsEbV4PWY4HWJ4w4toRScweXva4Rpr08R
	TD3C5avd7R1icOPfMkpuwaeiT+kFKePDdxy/RoDCqDj1FWp7dlBb1WoGvvhmdMw=
X-Gm-Gg: ASbGncvTD0/sqpUGJAY3mUh0VXtOHIHiUubgU9Y8vNq8zt/z1C4AZsSaHWFSGpzcPmn
	uO7m4mguip2jCtdsey+8dbRvWowqbQ6lX2nckX/vqHyNhgHhS7SsP2xIEW2Ceo6bLnq2U88Ytx5
	Fd2j8yAcx356RNlcw97X9PvmgwT1q2ibhGxFAxv4g94Re5Tixf8OZdn+wXb8CPXAp3/dzCppelA
	zdpibow80yauWpIyLZz6XMczIJTlNQPtn6AHUiKLbjDnyKGGogzVfGz2Z9Kc7ozXt60jOxCcprJ
	JHYaJqHX+egrcx0PGKh8tOh6NRSDuCunRfXNOrj5Dw==
X-Google-Smtp-Source: AGHT+IHbtFJc0sZMysZ3vYXJuVTW6NBS2O3AVJRjOnc6c6T0oJ1FFGCKVknIrhqtI5fTinhi9uFXQQ==
X-Received: by 2002:a17:90b:164f:b0:2fe:8fc4:6f4b with SMTP id 98e67ed59e1d1-2ff7ce904f9mr294169a91.8.1741284087517;
        Thu, 06 Mar 2025 10:01:27 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e8345sm15463375ad.57.2025.03.06.10.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 10:01:26 -0800 (PST)
Date: Thu, 06 Mar 2025 10:01:26 -0800 (PST)
X-Google-Original-Date: Thu, 06 Mar 2025 10:01:19 PST (-0800)
Subject:     Re: [resend PATCH] riscv: fix memory leakage in process_accumulated_relocations
In-Reply-To: <a9058ac757636e4f5160a0bd11abeb3c111fc9a5.camel@iscas.ac.cn>
CC: Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: zhangkai@iscas.ac.cn
Message-ID: <mhng-a1315877-d100-437d-923e-ebbae4745074@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Sat, 16 Nov 2024 04:07:18 PST (-0800), zhangkai@iscas.ac.cn wrote:
> Sorry for last weird email.
> ---
>
> When module relocation is done, process_accumulated_relocations()
> frees all dynamic allocated memory. rel_head_iter->rel_entry is
> missed to free that kmemleak might report:
>
> unreferenced object 0xffffffd880c5fc40 (size 16):
>   comm "insmod", pid 1101, jiffies 4295045138
>   hex dump (first 16 bytes):
>     e0 c0 f5 87 d8 ff ff ff 60 c5 f5 87 d8 ff ff ff  ........`.......
>   backtrace (crc d2ecb20c):
>     [<00000000b01655f6>] kmalloc_trace_noprof+0x268/0x2f6
>     [<000000006dc0067a>]
> add_relocation_to_accumulate.constprop.0+0xf2/0x1aa
>     [<00000000e1b29a36>] apply_relocate_add+0x13c/0x36e
>     [<000000007543f1fb>] load_module+0x5c6/0x83e
>     [<00000000abce12e8>] init_module_from_file+0x74/0xaa
>     [<0000000049413e3d>] idempotent_init_module+0x116/0x22e
>     [<00000000f9b98b85>] __riscv_sys_finit_module+0x62/0xae
>
> Signed-off-by: Kai Zhang <zhangkai@iscas.ac.cn>
> ---
>  arch/riscv/kernel/module.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> index 1cd461f3d87..f8c3c4b47dc 100644
> --- a/arch/riscv/kernel/module.c
> +++ b/arch/riscv/kernel/module.c
> @@ -643,6 +643,7 @@ process_accumulated_relocations(struct module *me,
>                         }
>                         reloc_handlers[curr_type].accumulate_handler(
>                                 me, location, buffer);
> +                       kfree(rel_head_iter->rel_entry);
>                         kfree(rel_head_iter);
>                 }
>                 kfree(bucket_iter);

I just found this one.  The patch is also a bit mangled, so it doesn't 
apply (and probably got missed by some tools).

I had this buffer up to say something else, but I don't remember what it 
was.

