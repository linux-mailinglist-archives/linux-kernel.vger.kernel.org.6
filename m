Return-Path: <linux-kernel+bounces-325279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDF3975756
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E64289A26
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287811ABEA0;
	Wed, 11 Sep 2024 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KIJII9lN"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7135F1AB53B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069129; cv=none; b=UuVQAS3hlGBs56WbYuxgTqj+2+Cvzc7XQaoGD+Go4KbM65I7TDZ9hDf5DO1uAj5tn8cYEqp5LZ+xmN4le4yjpCsXE75d+F/lRC26HELgr5zsewW6oU74Yh2Vy9vaRFozgmrCjgsgFV4s6xVGzCzXl+QWjT8DIucm7VEeyG3JFdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069129; c=relaxed/simple;
	bh=JTQaSpGoN7KKCzIIacOFgMn7XHRnqEvToqs1DWWIG7M=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=YxIojE4r94+m63ZtHYD0FTAazunzXMiMPLSLDCac/1Tep4P9LjXetbwm1pHG6ey9YpKPuQGMm99ZxGpcrIfEIagacqRVHtwZGGiOW2RevG4oWmK2DvCnYZoBcZnZHU/4OZ/CzBNkXw3atX5Il3zKGufjn1KKyqc6/D7VHej9Zwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KIJII9lN; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-718e6299191so2522456b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726069127; x=1726673927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cy9rXS7F3MWBG42PuD8MXgNVZRn+jWhK5VWH+Xap2gM=;
        b=KIJII9lNZe2p9wAuupOgmQKUofSaL8BB7PelcHqfapQHyff8TSqvMIy7FDab0xQD2d
         qqeJ+3ZD2g4LxlsYZB6eESLugRx0D/dVGIySp+IrkzADlLhVcpCHnBhGzZ6iRlS23zYW
         uYJh8+5lWWFMWw26ogwY6y/y72GXKSGYrBhvRTNpGzwWFNUSOlH9F0RTFuiQOONx45Fw
         vFybx6qp9RMbHKxWl4TScBjT7LEPT2gSSq3zQ+svmirgr+wezXi9QxJgvYegQvIB63TJ
         tdeCWg2H37rFIfXxuYNo4FPMCErrFKGB8WX4TFE+z5UGGQNByQT0GuedTmLsog83jGoC
         YIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726069127; x=1726673927;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cy9rXS7F3MWBG42PuD8MXgNVZRn+jWhK5VWH+Xap2gM=;
        b=AK5JdjcK/Yrr9Tu8cjQmTk0ZIJCAsav8CY0mkNfE+6lmrRCM2Mbda7wi3i1p6kMD25
         s7YXQBqBQN2FtKEY7uJ15Mo7Y36RWb/i0tpa4npS7gc7a2Kp0lT9y8KlHdRhMbHQ+qL8
         NoMLt749CMukm26SERnTFi4N3g0/WB52UkMfvJwSKdqXiI1AcJoYwEC9FKG/tbOvb2fQ
         oJbBUvOPRnxI74zyx8XmnIhBb7yEjrXA9LLnQ7DsU+UbhqRmwT3r/SrIDF5C8y7fUP6P
         3xmITRQS78U87mkVdH08/XXq/RgRU3m077AfiAo7+gD0yPfYG0ZHD0HkpRU/6C+U/1SJ
         +gOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhQnFptAXGoWgaBskmI7Pe8OM4eryspQfwdmtxuEITcVx+hpmIDZgzfQ+df8G1qf3VBBnnmpAOHFP6gcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwVcdsJb/Fcq2AEMLGGuoW9bl1c/k5zHAHPDn00VFttm5PIKWQ
	9QNvmLaAf0DAWgIuzqGke+/YFkbkyjYH7zxiYF7/yqlMkyRTD/TLbFkyEe+OA7I=
X-Google-Smtp-Source: AGHT+IH3YGpgUFpEBW6C5xGtli3mKPV+hUGYXvcbI1qVyLA3K8dnS2if2xzoBac50osXtDbGP4qDYA==
X-Received: by 2002:a05:6a00:1911:b0:718:d8dc:308a with SMTP id d2e1a72fcca58-718d8dc340dmr23321510b3a.12.1726069126476;
        Wed, 11 Sep 2024 08:38:46 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908fc8205sm3138457b3a.21.2024.09.11.08.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 08:38:45 -0700 (PDT)
Date: Wed, 11 Sep 2024 08:38:45 -0700 (PDT)
X-Google-Original-Date: Wed, 11 Sep 2024 08:38:43 PDT (-0700)
Subject:     Re: [PATCH 0/2] riscv: Fix race conditions in PR_RISCV_SET_ICACHE_FLUSH_CTX
In-Reply-To: <172606863202.959689.8576514936896750298.git-patchwork-notify@kernel.org>
CC: Charlie Jenkins <charlie@rivosinc.com>, linux-riscv@lists.infradead.org,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, alexghiti@rivosinc.com,
  Atish Patra <atishp@rivosinc.com>, samuel.holland@sifive.com, parri.andrea@gmail.com,
  linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: patchwork-bot+linux-riscv@kernel.org
Message-ID: <mhng-a59299d0-889f-4b11-b765-cc8460da7427@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 11 Sep 2024 08:30:32 PDT (-0700), patchwork-bot+linux-riscv@kernel.org wrote:
> Hello:
>
> This series was applied to riscv/linux.git (fixes)
> by Palmer Dabbelt <palmer@rivosinc.com>:
>
> On Tue, 13 Aug 2024 16:02:16 -0700 you wrote:
>> There are two race conditions possible with
>> PR_RISCV_SET_ICACHE_FLUSH_CTX. The first one can be seen by enabling
>> DEBUG_PREEMPT and using this prctl which will warn with BUG: using
>> smp_processor_id() in preemptible. This can be fixed by disabling
>> preemption during this prctl handling. Another race condition is present
>> when the mm->context.icache_stale_mask is changed by a thread while a
>> different thread in the same mm context is between switch_mm() and
>> switch_to() during a context switch.
>>
>> [...]
>
> Here is the summary with links:
>   - [1/2] riscv: Disable preemption while handling PR_RISCV_CTX_SW_FENCEI_OFF
>     https://git.kernel.org/riscv/c/7c1e5b9690b0
>   - [2/2] riscv: Eagerly flush in flush_icache_deferred()
>     (no matching commit)
>
> You are awesome, thank you!

I think the bot just got a little lost here, I applied the v2 from over 
here: https://lore.kernel.org/r/20240903-fix_fencei_optimization-v2-1-8025f20171fc@rivosinc.com

