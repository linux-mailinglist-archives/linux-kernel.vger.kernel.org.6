Return-Path: <linux-kernel+bounces-357528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E0A997239
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48A2286C1A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6611E0E1A;
	Wed,  9 Oct 2024 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="Np1l6gb6"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FC1126C17
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492303; cv=none; b=ULlW69yB6knAkAoe/nj21ZhoI9nJbVgylze4l6nbyc1XDCwCKU3Ms1tFY/ksSRlJl1n8zzcrWroE+g1liNKUvxem7WqSdyuisxl80UGj26S/9kcHN0t/iu3d1VjIJCjiebqktCyg1begOxQd37kAWL/ZrFE3qsxAkdc62V4We6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492303; c=relaxed/simple;
	bh=2n088AfNnnOY99Y2Y98ICmSmIidQFrIENvFSbgzfxZg=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=Nl73d3DpJNUZrKS3gI4RMsNAo+7VMh5EEv8nQhqHI1kW+j7eVi3gdtdA1vhNaiJWnN0oP7JW4d4Whgp9AQ+oU0IxvsGR+ESQduzAA6wo5NOIAU8/QgqsrAMPs/olXkXPRWAI+QgLtRAXcZTRUI9zrtSlIukZVgM7rfgOzdyfD5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=Np1l6gb6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c7edf2872so1339225ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 09:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1728492301; x=1729097101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nYDkPIyO5e7pPYqNdXupJmuYO9zC4Hxiz8OIhsrkQ5k=;
        b=Np1l6gb6hqwpgGTNaCzaoqkHdEIrdn67vIqu4NDPqDcQTZAoEPmvahOi6oEL/ZHlHi
         F4ndULlUaBsz5Cz8fvU1twaH2mv8HjTU/vSJ0IPB4mSsTR8ZItVfX+8eHG50uu9AvDhL
         cwciDelGrCMTKrVcgEO79FmOuMdsr0+PFAorJ/fEo+gI5DjYjpz17yU2ing+PcxhhCxb
         HN1KiJ3Xipy9rztjFLUbaBNiBwDvU9mUNAjuWPbThuhYAVnmunsycuVZui06zHl3cp+O
         8tEFi2zuhelaWaBZdfYq44woJi8KEp05jjo/tuO+fHU4tvw6x655m5FN1YfXcEXBv0vj
         xoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728492301; x=1729097101;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYDkPIyO5e7pPYqNdXupJmuYO9zC4Hxiz8OIhsrkQ5k=;
        b=FI78S5kfm+vu7b1LA0OlR1oQK8mTMjfxg8X8y++5SXMfJlhXTp2Et8M+X30hUeU+Vt
         ONtUIUNzNQDqYwb+tcwgOxxYT/0S7kmAsI1aQLHNa50W4h4KodRJ45KSGuiBUWny5yD3
         lWFd4g4G+sh2NSwDD3lqci2RaeQK6lElWBh58TRmKx6P/d6ugVQlyUKKn8dLJJZnBO/w
         mWR2SH4F37YQlDvxuIwg3PQNjrMrVo/PMikU/b7ofwBp74SkGKH5Xpo67TKexiuq5nl5
         vzYleFTKtSarHJSr6cAMBHf/XPnjRMnTqyvzsPXDNp5+uMyxeHbWchSAJF2WS1kpQ3pK
         u4HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjMsm66FReIgvD+A9wNF77W3OPK9Gczmkb2aODHOPxGcIeqqJKaSMHyMYv2gYY4NZpxmFH18FIEWXEJ1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJXbli0Xf6IsBBFDVar9auyy7Rki4lhScHU6dpq/ynbq2hPQks
	H6Vmlf1EwKGJhy2s8LbAI8cA3mAKwtmt09MqnrCyBU5EJOH0skcEXrg8rSimzkY=
X-Google-Smtp-Source: AGHT+IEem2fBzcCqAqcfXJrDn5xc82NZIBAdjPT/4BAATxAitaIQIj2ulJn/HqNtN9vHeV0FBTgZzw==
X-Received: by 2002:a17:902:f686:b0:20c:5ffe:3ef1 with SMTP id d9443c01a7336-20c804faeccmr4291235ad.17.1728492300683;
        Wed, 09 Oct 2024 09:45:00 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c78e2b33csm5549785ad.285.2024.10.09.09.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 09:44:59 -0700 (PDT)
Date: Wed, 09 Oct 2024 09:44:59 -0700 (PDT)
X-Google-Original-Date: Wed, 09 Oct 2024 09:44:57 PDT (-0700)
Subject:     Re: [PATCH 3/3] riscv: Allow to enable PREEMPT_RT.
In-Reply-To: <mhng-64eec780-df98-4e8d-bf6c-0aa07a8d85da@palmer-ri-x1c9>
CC: bigeasy@linutronix.de, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, x86@kernel.org, hpa@zytor.com,
  aou@eecs.berkeley.edu, bp@alien8.de, Catalin Marinas <catalin.marinas@arm.com>, williams@redhat.com,
  dave.hansen@linux.intel.com, mingo@redhat.com, john.ogness@linutronix.de,
  Paul Walmsley <paul.walmsley@sifive.com>, pmladek@suse.com, senozhatsky@chromium.org, rostedt@goodmis.org,
  Will Deacon <will@kernel.org>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: namcao@linutronix.de
Message-ID: <mhng-f0f516a0-6774-4c87-b8da-313601bad133@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Fri, 06 Sep 2024 11:48:03 PDT (-0700), Palmer Dabbelt wrote:
> On Fri, 06 Sep 2024 08:13:24 PDT (-0700), namcao@linutronix.de wrote:
>> On Fri, Sep 06, 2024 at 12:59:06PM +0200, Sebastian Andrzej Siewior wrote:
>>> It is really time.
>>>
>>> riscv has all the required architecture related changes, that have been
>>> identified over time, in order to enable PREEMPT_RT. With the recent
>>> printk changes, the last known road block has been addressed.
>>>
>>> Allow to enable PREEMPT_RT on riscv.
>>>
>>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>
>> With the printk patches applied:
>>
>> Tested-by: Nam Cao <namcao@linutronix.de> # Visionfive 2
>
>
> Thanks.  LMK if you guys want me to take this through the RISC-V tree,
> but no big deal if you want it somewhere else -- and if there's some
> dependencies already going in through some sort of RT tree maybe that's
> just easier.  So
>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> I don't have a test setup yet, but I figure it's a new feature so I'll
> just flip it on as a config post-rc1.  Presumably this just works in the
> QEMU virt board, or is there some wizardry I'll need to copy?

and it breaks my boot test script.  Looks like it's actually working 
mostly fine, I'm just not getting the "reboot: System halted" message 
that I'm checking for to make sure the system actually went down 
cleanly.

I'm not sure if this is expected behavior in RT land, or if we've got 
some sort of bug.  It sort of smells like we're losing the last printk() 
line...

>
>> Best regards,
>> Nam

