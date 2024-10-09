Return-Path: <linux-kernel+bounces-357576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BE19972DD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4177CB22008
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119D41A2547;
	Wed,  9 Oct 2024 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="kDDdgsYC"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE3A13F43A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728494323; cv=none; b=MFmBDJeXyD9dFxd/RdhHYkrayOlDxIXC1QqLdlpQKqjaMsJoawXJZXMStbtOx4I5dJuo7+itLVGEFvA4rvmaht0FSsJ44N/DsS0Gov6YchcdNt+3RyFY5xz99SNgYrUKkXbMlpxGRy3Z1EKrJG82hduuHG7jCL11w7xznGqIkV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728494323; c=relaxed/simple;
	bh=gfDfkb6E6BuglUSYEE7UIx2AT6P6NtLzD1hcTyfxqgY=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=p+KojloglJnBpdmV5KW5AzfDYZC3suN4ixFD9YefiUGvSiQNlSQfaAU73WZa/SvYe1tAgDKn6J+VbfW3Aere9L8ywQ9aODXSyfPTT8mTU3Y23T58jyHzyWHUo6HfykBfoDUPUSLYpF2ml/owjLi8TB9bC6r8ulTraV41AmAoxeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=kDDdgsYC; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e0b93157caso892262a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 10:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1728494321; x=1729099121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tE15ibMGDi+NxxTDjcKlwgS0dglI70fk+X+ersajG3M=;
        b=kDDdgsYCktzXRfjI6W9WOCWEy19wJdluLXSgV8qnHWsUv8q4vBN458O0E0f7IrC0Zu
         c4rSYLf3xSoM0JkhqJEXeiNQfZ/q4ELn/kQkzgHvnO1bAMqecrVSE7pXCRnc8BXPGPLm
         1IqI2TDtU2UsMxTDZfyOm2wqarLFscK1hx25QHO9zYntJJgrYukZYY0sRqzD4p8DffEz
         +G29TkM16/6d/0BF0m/Dlb2acqahN3MBPsaTlKOxnuZNWw5wb4QK0FyimQedEkQQGO2q
         M1XZwHSnmW4TUA8bGbMAGKFf19bX+HimHwcIMdy/1ZKsEWAMRusPUNz+fwhQ8W7Uy4s6
         PV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728494321; x=1729099121;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tE15ibMGDi+NxxTDjcKlwgS0dglI70fk+X+ersajG3M=;
        b=SLLjUAXCIPYyQcu7iU9AcL88GtWdo+5w//RedlyO3Fc5++RLfRai4HURRvgoYeyLc4
         XuWMp4kLTPzSshSg3kWWY92eVVofimOB1jL/cJbWjV+h9Mz6seMbpUxyUdrGiYoTsTUd
         /0152JxJ4bm6m0uc+KOIHlni9Y492PsxICXeDK8HAGPefeHBiOcvXwRxemEMrgAXREgk
         Xn0Uzdjb2I1CVTwxBDg75iM660v+wUYdI0WYDHGBIkYVx7u5r4AMqv/yivXTp0zcczYb
         8SNR26y2Q5yrfsELFJDRSnlK45uh6jpLm9zJPcRN81qSv6+vkadCpg8LGRvgjd6wcQub
         tuTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbRDfF8X0ZJiPVLy/6qH9ibQ6zMmAlGU5nS5NmWQ9gB4oxCxyU0kxd6hir4KXeo2YyZh9KES+/OBua4dY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD2hPRICuaSriri46zZX4yHFDB0PbWNI52ZeYD8kCP6PvEeRls
	qU4ceObHsMPzEd5GOTSJQNfM5OVibiRGR4ynzGokNTGCjD1jH91tgGP0+yLMlWb3winnIeU6RwM
	q
X-Google-Smtp-Source: AGHT+IH+dUdqWJdilHkcfNrwnO/4bpYGAbPTeUc897OZzGRUfL0r6Othkiqnq9rjY7iXezEC0dz7jw==
X-Received: by 2002:a17:90a:d913:b0:2e0:89f2:f60c with SMTP id 98e67ed59e1d1-2e2c805fe05mr543826a91.11.1728494320877;
        Wed, 09 Oct 2024 10:18:40 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a8dd0fa9sm1849185a91.50.2024.10.09.10.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:18:40 -0700 (PDT)
Date: Wed, 09 Oct 2024 10:18:40 -0700 (PDT)
X-Google-Original-Date: Wed, 09 Oct 2024 10:18:38 PDT (-0700)
Subject:     Re: [PATCH] tools: add forwarding header for arch/riscv/include/asm/fence.h
In-Reply-To: <mvm5xq44bqh.fsf@suse.de>
CC: linux-riscv@lists.infradead.org, Charlie Jenkins <charlie@rivosinc.com>,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, parri.andrea@gmail.com, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: schwab@suse.de
Message-ID: <mhng-adb76a44-07c8-442c-8bcf-6f29d061c031@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 07 Oct 2024 00:24:06 PDT (-0700), schwab@suse.de wrote:
> This is needed so that <asm/barrier.h> can find <asm/fence.h> on riscv.
>
> Fixes: 6d74d178fe6e ("tools: Add riscv barrier implementation")
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  tools/include/asm/fence.h | 3 +++
>  1 file changed, 3 insertions(+)
>  create mode 100644 tools/include/asm/fence.h
>
> diff --git a/tools/include/asm/fence.h b/tools/include/asm/fence.h
> new file mode 100644
> index 000000000000..917a173059a4
> --- /dev/null
> +++ b/tools/include/asm/fence.h
> @@ -0,0 +1,3 @@
> +#if defined(__riscv)
> +#include "../../arch/riscv/include/asm/fence.h"
> +#endif

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Happy to pick this up via the RISC-V tree if you want.  Thanks!

