Return-Path: <linux-kernel+bounces-257092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B6993751A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20FBE1C21A2A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337CB762EF;
	Fri, 19 Jul 2024 08:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bbkqANMJ"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DB939ACC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 08:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721378058; cv=none; b=n6EQNYnkZjPU5uVBO9+DaV0VmjxSSFBhSgSCvZjMipS12mYYyPbpUpc0Yee1+/ni58ZL/RcLN7gSONQPYAvFF0juWgettguj8vs/fF3arMkeJ61t2GwRurp9HpNwfXSN6G25+gRXUhlDz5FMMfyx/YKXs7PJAwGz0PWsSt9mhHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721378058; c=relaxed/simple;
	bh=zpWlSVAt0K8O1SpWkY1jUSHcmbP8ufm9kD4/5oS6YSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3ABofxMY99oI4cO7YXR8HX9aN2ijoMdYdECZgATOxWDP8Il8CX12II3LOuLBg+gF+5EChXetJ2QS8IrgwzT98A4SstoXVr7VxsCu9zCZAX7nC0wiDeb/Q6OsfBjBGKHkvuL6c6prQ2/DWSnUpVZYAepHpCMb3qQ7m9FbsTkiWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bbkqANMJ; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-260a81b5d02so173455fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 01:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721378055; x=1721982855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uj8DPqacGp8Z6VQ5rbqUkDNKZNPVfZO2R9kXSBhDfC8=;
        b=bbkqANMJJ+pZxrQFUTrUCqJMI2M/R8xrtTNpfbPB/gDwsTRs6ItFlzq2LScdbsgW8w
         Gg4YGr6IqDZFnknU6ziN9wG9TEY8h2AMz3mnKpKxZTPINnsUgKFMp+rA6WUaTjHNnrbZ
         nt+9r/Ipq73kXgK9bSi+7+6i/XiiV9u5bxWcJ/kskNHaSd4wgiZGEQu5VNSmXIyQixcE
         hXXLGKzUWUAkr6Ph4wYNbVXDmT1GdXc6KP6VQMZTGo/TZn46gt+sAjg/DgnDXiZFhZvd
         yD3C2uMqPdeyYLlm/VcXnZJtJSDktI8sVjIPEwQxnLy1xcKfW1E5t2fE72o5DsStZJHF
         IBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721378055; x=1721982855;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uj8DPqacGp8Z6VQ5rbqUkDNKZNPVfZO2R9kXSBhDfC8=;
        b=r5hJ+Y2HqbVpMsEsHlMkwI4dSP+zBtCjwQrs6ZE8xruyoiIG08bjGkmCFKkd1+xZlT
         3CDhdQo26J/7otSTJI/C9DGJCWKAvAPLvcdQpgXyxdeGUMxm9F+nqWd5biBMu5z89fjR
         EX8aKsG+gra4ah55gygAtYOwAw11XIap7R2IVZkXd18WE6gUzlWY5xbSVy1otxz8kJBa
         bv2X99POn329PTAKrtbC5ahEy/shPK0/Adp37rEXe5YaHacysomLNa68AnTEwvw2+LKu
         ZXid8mEYzmhCJf5Zpra1UUq3Ilfd1dbtG5oLzRTtlGIc86bYtMvUAUAKIs30yzK/O/9X
         GAyw==
X-Forwarded-Encrypted: i=1; AJvYcCURW/IGMQE+5DbUtWcYboIkfUChb8t/vBKtw+XSLQH0xUtCi6rCDkbhYrlVlHHndX+iJMQkbl6wIG8Je+sne3A8LMNExdsg1IDnIuat
X-Gm-Message-State: AOJu0YyWRGa2zC+lLU8N8NcfyUt6mtWSLjEsvwmdI90Pki5YZnmG9W58
	ziRNvSOi19Cm5gkEpKKPgW0qvAv8boopUeMA6cjOTJzb1+uQ1TnbVBvW8VPfMiI=
X-Google-Smtp-Source: AGHT+IHgs5SdgJKYH+XZOn5uo/Fn1KOkFeiRW2axi78s+XuzXemiQ1sOMQsLxA12M+vHlJi5t/4dQQ==
X-Received: by 2002:a05:6358:2781:b0:1ac:a26c:a5e8 with SMTP id e5c5f4694b2df-1acb9e782e0mr117203555d.4.1721378055351;
        Fri, 19 Jul 2024 01:34:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-79db9fc40f7sm633678a12.85.2024.07.19.01.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 01:34:14 -0700 (PDT)
Message-ID: <5923b26c-d73e-4b20-8431-fbc091bdb58a@rivosinc.com>
Date: Fri, 19 Jul 2024 10:34:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes] riscv: cpufeature: Do not drop Linux-internal
 extensions
To: Conor Dooley <conor@kernel.org>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Albert Ou <aou@eecs.berkeley.edu>, Andy Chiu <andy.chiu@sifive.com>,
 Charlie Jenkins <charlie@rivosinc.com>, Evan Green <evan@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org
References: <20240718213011.2600150-1-samuel.holland@sifive.com>
 <20240718-a5097a4070f457529d2fff91@orel>
 <a36e07a1-f4da-4d6f-9e68-929b77b70836@rivosinc.com>
 <20240719-deity-squander-e17b4dfed649@spud>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20240719-deity-squander-e17b4dfed649@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 19/07/2024 10:25, Conor Dooley wrote:
> On Fri, Jul 19, 2024 at 09:11:20AM +0200, Clément Léger wrote:
>>
>>
>> On 18/07/2024 23:57, Andrew Jones wrote:
>>> On Thu, Jul 18, 2024 at 02:29:59PM GMT, Samuel Holland wrote:
>>>> The Linux-internal Xlinuxenvcfg ISA extension is omitted from the
>>>> riscv_isa_ext array because it has no DT binding and should not appear
>>>> in /proc/cpuinfo. The logic added in commit 625034abd52a ("riscv: add
>>>> ISA extensions validation callback") assumes all extensions are included
>>>> in riscv_isa_ext, and so riscv_resolve_isa() wrongly drops Xlinuxenvcfg
>>>> from the final ISA string. Instead, accept such Linux-internal ISA
>>>> extensions as if they have no validation callback.
>>>
>>> This assumes we'll never need a validation callback for a Linux-internal
>>> ISA extension. We can make that assumption now and change our mind
>>> later, but we could also add Xlinuxenvcfg to riscv_isa_ext now and
>>> modify the places where it matters (just print_isa?). If we add
>>> Xlinuxenvcfg to the array with a NULL name then we could do something
>>> like
>>>
>>>  print_isa()
>>>  {
>>>     for (...) {
>>>         ...
>>>         if (!riscv_isa_ext[i].name)
>>> 	   continue;
>>>     }
>>>  }
>>
>> I would rather add it to the riscv_isa_ext[] array and avoid handling it
>> differently. There is already the xandespmu extension in this array so
>> xlinuxenvcfg can be added as well.
> 
> xandespmu and xlinuxenvcfg are fundamentally different, the former is
> parsed from devicetree and is a real extension. xlinuxengcfg is an
> internal flag. I don't think we should be printing it.

Sorry, I did not meant it was to be displayed. Only added to
riscv_isa_ext[] as pointed out by Andrew.


