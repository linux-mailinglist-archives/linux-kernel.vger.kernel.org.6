Return-Path: <linux-kernel+bounces-387136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2794B9B4C74
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28B51F23C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD91A18FDA3;
	Tue, 29 Oct 2024 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXEpIrDu"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6141865E3
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213190; cv=none; b=Ov5HMQvJSdDzdy/NEKnroTCSDlky3Onisg6F7DB4z0NCp3Ue6LuuDxspKJ0AaJ/ykCXw/9MNV1K5ONy5uPZRv574odecUhxfGM3L7TGk3hGGDpVBB27+vF6UAJdlol7n1HdG44R2hD0HL77OtW8aNnYoEQnVEIBxj12W7Q7LhG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213190; c=relaxed/simple;
	bh=ZwWNFYnTFlO9Tk22xWF1so2in62+vycGkpb+/YHNnXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zf85kfwdS5kzkR1aBK9TDdqry86IiSzhD1KEFK46I3+sxyKZcxSGgM2VPAm1YcgmzNQmcwxonHBkMn4YUXqZxdDRtBz+kgC2ZGDF/yXFaJO3MAAzfxDeiaKEujScXwA+E8rjt+TwXSHuJ6XfuSc/rqKBUVrO3nCIx0A0tRqci5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXEpIrDu; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-29066daf9e2so1483138fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 07:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730213185; x=1730817985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=viF9DWPGP0x+avfXcbm09pdd+ClEJSj7G9turC6IKW8=;
        b=UXEpIrDu9mPoCaoADmbIdXo9pguAkW4qRCcNQUjPJXjQo80uQV854MVKeTH9Be+IFv
         Do5jOVXs28Oi0rjtrTHAEWhUzcR2KHiRod01afZkEkxOebO6CI8fTDj46YVAOdcmlBeZ
         MFN9k0gKnCTGuRmD/GsjZLH02KXKVEArUbwRSYZWceuN6t3kkTHjxSl085ftNxwJCjix
         uXm0hvPNUmqjL9iFdc2/A6oVkll+c1IxRSilHcMbGqhVKbRXG5LJPpp59pZ2GI6N6nrE
         Vwij9RPzKArwWfFcb9+gMH/LGFi1HoImguIKl8Nxmsg3wvzkh9y4Lw3e2mcPuaXW4oM1
         Mq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730213185; x=1730817985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=viF9DWPGP0x+avfXcbm09pdd+ClEJSj7G9turC6IKW8=;
        b=BGLFbkRwrZFTTvQ+F4WTH9skuy714KlD7i2bejghLS9szsMRql8KvAONe/WTnm7jWB
         NqQBsJnBddUqg8m7Nj/BCVPzgwpdlNzSicXzUy+nkOQDQxzn52Cgy/iRidX8liuP7ji6
         5Ucv1YPl4X7IP5YZ4hqVaKbiW42xtYlfczarESie/KordAeaOo75cBmiX59OEMsUyGRN
         SbJp+Z5HGT2iTYUDsboVfJ/WvqHTTbiwFjcJQkFn64RyGkmRCu7UcF3w/3rEDXqB3nJp
         Kj/zhY2LZ2ZRJmcWZ4SCpZaYtqh6B2r8Ii8EdoO/P4PKiDHRX4KOfmWBZplt/XQKIiC6
         RiTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnoWCW5oh6/hUhcrTVlp6ARpITs3LJw9Hzp6gSL9/Mo1uKQgMXB5ubNmF3pLqmVtZrTHVhmOEmp3suFtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB/xZ2AEAIlQower5PcWKlckjG7spNQVY9au1BUZII5PdWPDAQ
	Jh/Ebclsyt2dUAjuMJ9MkxsLqpzA4fw60WtiZXp4hfZq4FE8Kcp1EqJ+POv100IkKploAR4qRyD
	Su9ovQxUERpppqJsZIIY3aHPvgnk=
X-Google-Smtp-Source: AGHT+IE1g/sg5zM58Sn60mdYZ37eljIg2WGxD4k7uRrYCo5ArBFN9rkVIkohMQZgP2W9lLEJTbpmdHQSHCxmjV1ImV4=
X-Received: by 2002:a05:6870:9625:b0:288:6cea:ba8c with SMTP id
 586e51a60fabf-29051de7981mr11265267fac.44.1730213185385; Tue, 29 Oct 2024
 07:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <mvm5xq44bqh.fsf@suse.de>
In-Reply-To: <mvm5xq44bqh.fsf@suse.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 29 Oct 2024 20:16:08 +0530
Message-ID: <CANAwSgRWGemK_Q3FeeXt7sZYYpi+87jKGs4m8O7VDS-FJ=XM_g@mail.gmail.com>
Subject: Re: [PATCH] tools: add forwarding header for arch/riscv/include/asm/fence.h
To: Andreas Schwab <schwab@suse.de>
Cc: linux-riscv@lists.infradead.org, Charlie Jenkins <charlie@rivosinc.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Andrea Parri <parri.andrea@gmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andreas,

On Tue, 8 Oct 2024 at 05:29, Andreas Schwab <schwab@suse.de> wrote:
>
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
> --
Thanks for this Fix.

Reviewed-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand

> 2.46.2
>
>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
> "And now for something completely different."
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

