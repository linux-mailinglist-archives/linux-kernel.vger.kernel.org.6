Return-Path: <linux-kernel+bounces-231988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBA391A12A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82D31F22B19
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB60A7347E;
	Thu, 27 Jun 2024 08:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="N0YArAc/"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DA423BE
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719475918; cv=none; b=cR4Iz1SlKrVE93+XtDDo7SxUXmJPx+0NB+qP/oSzBmYafXT/GT1C8UbGEyTbmp5hRGCaYoAg5M/n/v97vSAEX0Cv6e0Xkqi9/E4oYkO0or2dSd08X4OTEvSdhpgN6vCbXMZ3fSXiK7oc/TWi03Y9rkKRVVO68mp7bRjxIe1Dt9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719475918; c=relaxed/simple;
	bh=H4sf75wa+u9MafsJdYli4CEuqRcSVkKoC4HHQCaaP+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rlf0hB9UmwB/+guXglSPQ2uCfWX9nNYMcz2Bwi+StEhqBFBspIboNzkQ947QD1zEIHa1wKxRtY9O1ARQgZqs1/qry0LGg642aP2eATHWV6SGMlBB2Nm1PqW5FA7J5NeAcrPG8o0M+3sfmsCyF374Idi57JG259QY4qXysWkQ4kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=N0YArAc/; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52d259dbe3cso2476887e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 01:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719475915; x=1720080715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msK5wFfGDF/WutTur9LQCLii2ycv1OFon1M4QxMP/sI=;
        b=N0YArAc/R5ECuFuXx25EGjh2KVi4gr72sb7GdaE1dIYLcBPJfj54fyH5oXL038M/4W
         +GcIeniwNH7DJXEG0ihVWAkWXTdr4pqHsyxMv50TOW+N7/qqAAXyNt0zspE3/thkSt+n
         79XyxRXuqJy6Pz4t/Lw2U6cMKj+A2+Lf+BMF7RpcbmEKi3gj28hcEBTI0uAWsl1RSXy2
         Jw/hgiQS0FpL9e+553SUVEw9OrIk5DeL6XWr1EJRhCUYft0c7nT5dMXFLprfEhrTsRF4
         LbE/9mxNYIUPmjlIn0qhXMp9EJiMyTjmsWpqnGbO70iQyPpaifSATRehskM4MpiOr8Ei
         T8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719475915; x=1720080715;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=msK5wFfGDF/WutTur9LQCLii2ycv1OFon1M4QxMP/sI=;
        b=Re+07xrGPJCFOIp4ObjaSs8QjY+faAt9FT5Yyz2gLW/12GIy0BvHPg48T/5yx/k+eE
         7hmkEhp8a058cfgH79WkuTPwm28EW01hiNbZXcuCZVbafWEFubfrriPEhu1oyp8Uh8n1
         Focu3b9878Q3TUuYBn9+Y/gnC/nnXqBhhHFcHbujWi5/VRoZvJP0AXR3f2osdnVVNWHH
         /hSGd1VNsK5AKNLi74BZ7p4b/Kg4d3eQHsyM0u84VAvQHfra6pyoGSk+Xpn3O/V4bvAG
         kQ8739sqHgst3nNZy7j7C/OqrzQlqlqwis03JTrYmhY5MWKV5lflm89V0FjsCSCM6yKh
         giQA==
X-Forwarded-Encrypted: i=1; AJvYcCWBoB7sRED7rEeSg98Zdjbqu1E0H2GkRQn1aYQi2LIJ6jIhCbqxbCPQLs33e1PK+4hhcOv/bBlN3KE/5g1nbdzZnEV9BfA68qGtXRTE
X-Gm-Message-State: AOJu0YwUmFK1t64KjRAL/eQHquTOtzEkUletA/hibRp4Dn16EOHP6T7o
	A7ogk6+eRJ1Ybq/z0TtaA1+yGuxs3D0pem3FTnvw6oU4L8TjAmAORkXIbZ+B714=
X-Google-Smtp-Source: AGHT+IEDopEuSNAPoRqMq46CO/kVJCKi+X7E3kF8387qXA6YgPT43ltjyIFnDOjv4772zX4xLAWpIA==
X-Received: by 2002:a05:6512:348c:b0:52c:86d7:fa62 with SMTP id 2adb3069b0e04-52ce061b1femr9639838e87.23.1719475914653;
        Thu, 27 Jun 2024 01:11:54 -0700 (PDT)
Received: from localhost ([149.71.16.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-425649d7055sm14715715e9.0.2024.06.27.01.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 01:11:54 -0700 (PDT)
From: Punit Agrawal <punit.agrawal@bytedance.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: jesse@rivosinc.com,  jrtc27@jrtc27.com,  corbet@lwn.net,
  paul.walmsley@sifive.com,  palmer@dabbelt.com,  aou@eecs.berkeley.edu,
  cleger@rivosinc.com,  evan@rivosinc.com,  conor.dooley@microchip.com,
  costa.shul@redhat.com,  andy.chiu@sifive.com,  samitolvanen@google.com,
  linux-doc@vger.kernel.org,  linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org,  punit.agrawal@bytedance.com,  Sunil V L
 <sunilvl@ventanamicro.com>,  Palmer Dabbelt <palmer@rivosinc.com>,  Anup
 Patel <anup@brainfault.org>
Subject: Re: [PATCH v3] RISC-V: Provide the frequency of time CSR via hwprobe
In-Reply-To: <CAEEQ3wmV56GUNmOMV3ydkKjRu3Jt4Vw9Nb5r-0KYiF9d5tF6fw@mail.gmail.com>
	(yunhui cui's message of "Tue, 25 Jun 2024 10:08:59 +0800")
References: <20240622025514.66537-1-cuiyunhui@bytedance.com>
	<CAEEQ3wmV56GUNmOMV3ydkKjRu3Jt4Vw9Nb5r-0KYiF9d5tF6fw@mail.gmail.com>
Date: Thu, 27 Jun 2024 09:11:53 +0100
Message-ID: <8734oyoldi.fsf@bytedance.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

yunhui cui <cuiyunhui@bytedance.com> writes:

> Add punit and sunil in the loop.

Thanks for looping us in.

> On Sat, Jun 22, 2024 at 10:55=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.=
com> wrote:
>>
>> From: Palmer Dabbelt <palmer@rivosinc.com>
>>
>> A handful of user-visible behavior is based on the frequency of the
>> time CSR.

It will be helpful to add more context to the commit log - especially
for something that is being exposed in a user visible
interface. Something like below -

    The RISC-V architecture makes a real time counter CSR (via RDTIME
    instruction) available for applications in U-mode but there is no
    architected mechanism for an application to discover the frequency
    the counter is running at. Some applications (e.g., DPDK) use the
    time counter for basic performance analysis as well as fine grained
    time-keeping.

    Add support to the hwprobe system call to export the timer counter
    frequency to code running in U-mode.

With the commit log updated,

Acked-by: Punit Agrawal <punit.agrawal@bytedance.com>

Thanks

>>
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>> Reviewed-by: Evan Green <evan@rivosinc.com>
>> Reviewed-by: Anup Patel <anup@brainfault.org>
>> ---
>>  Documentation/arch/riscv/hwprobe.rst  | 2 ++
>>  arch/riscv/include/asm/hwprobe.h      | 2 +-
>>  arch/riscv/include/uapi/asm/hwprobe.h | 1 +
>>  arch/riscv/kernel/sys_hwprobe.c       | 5 +++++
>>  4 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/r=
iscv/hwprobe.rst
>> index df5045103e73..ec3c99474ed7 100644
>> --- a/Documentation/arch/riscv/hwprobe.rst
>> +++ b/Documentation/arch/riscv/hwprobe.rst
>> @@ -233,3 +233,5 @@ The following keys are defined:
>>
>>  * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
>>    represents the size of the Zicboz block in bytes.
>> +
>> +* :c:macro:`RISCV_HWPROBE_KEY_TIME_CSR_FREQ`: Frequency (in Hz) of `tim=
e CSR`.
>> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/h=
wprobe.h
>> index 150a9877b0af..ef01c182af2b 100644
>> --- a/arch/riscv/include/asm/hwprobe.h
>> +++ b/arch/riscv/include/asm/hwprobe.h
>> @@ -8,7 +8,7 @@
>>
>>  #include <uapi/asm/hwprobe.h>
>>
>> -#define RISCV_HWPROBE_MAX_KEY 7
>> +#define RISCV_HWPROBE_MAX_KEY 8
>>
>>  static inline bool riscv_hwprobe_key_is_valid(__s64 key)
>>  {
>> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/=
uapi/asm/hwprobe.h
>> index 2fb8a8185e7a..5053a9b18710 100644
>> --- a/arch/riscv/include/uapi/asm/hwprobe.h
>> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
>> @@ -74,6 +74,7 @@ struct riscv_hwprobe {
>>  #define                RISCV_HWPROBE_MISALIGNED_MASK           (7 << 0)
>>  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE    6
>>  #define RISCV_HWPROBE_KEY_MISALIGNED_PERF      7
>> +#define RISCV_HWPROBE_KEY_TIME_CSR_FREQ        8
>>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>>
>>  /* Flags */
>> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwp=
robe.c
>> index e4ec9166339f..3d47edc04a3f 100644
>> --- a/arch/riscv/kernel/sys_hwprobe.c
>> +++ b/arch/riscv/kernel/sys_hwprobe.c
>> @@ -8,6 +8,7 @@
>>  #include <asm/cacheflush.h>
>>  #include <asm/cpufeature.h>
>>  #include <asm/hwprobe.h>
>> +#include <asm/delay.h>
>>  #include <asm/sbi.h>
>>  #include <asm/switch_to.h>
>>  #include <asm/uaccess.h>
>> @@ -227,6 +228,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *=
pair,
>>                         pair->value =3D riscv_cboz_block_size;
>>                 break;
>>
>> +       case RISCV_HWPROBE_KEY_TIME_CSR_FREQ:
>> +               pair->value =3D riscv_timebase;
>> +               break;
>> +
>>         /*
>>          * For forward compatibility, unknown keys don't fail the whole
>>          * call, but get their element key set to -1 and value set to 0
>> --
>> 2.20.1
>>

