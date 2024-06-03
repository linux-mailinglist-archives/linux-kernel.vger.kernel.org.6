Return-Path: <linux-kernel+bounces-199546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 642A38D8867
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 20:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB7D1C2208A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED16137C36;
	Mon,  3 Jun 2024 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="gKk3BG8Z"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574FA136E1D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717437953; cv=none; b=KlyO5sb7ehkqFCa5YhMknEd/UTZMrZjRa6yBwsJY4ZvCne+u0AFFfEJsuTppmwqxMMNgY1E52L8JrMRvfc+PfsmKml+icUlMesMGZY+602zQZf66gtrFTZHeJ2RsqQuClB/G2YjClPy0Bec5M71yrkwKCWrPjyi7K189L2p1eNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717437953; c=relaxed/simple;
	bh=UYSnHjuXzxeSHt5cSAE1g0Y2V5QexSEt9S9IHF3Ofys=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID; b=Av9kZfg5PE1WkHFSP5qp9sCF5L5SORqaAarNijzv8JgMpws1epIR0UTZ+XQvOyzw0ZbJk2AIJB9vZS1I7XtEfUVbzy/Atu6KlXpE24Ccayn0E0aRo5E967CTtuMONrjXnNqVcAa+wzyl7cfnaSr+baalcnl8wl1lq0szVLnxbIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=gKk3BG8Z; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f44b45d6abso2208645ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 11:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1717437950; x=1718042750; darn=vger.kernel.org;
        h=message-id:to:from:cc:in-reply-to:subject:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3jcvQIjFY4g0Y2/xyHIexxJ5t7wWhmDVa3Fa+B/xds4=;
        b=gKk3BG8ZVMVE/Qpkzjg2LUpp1yBLrBQnOSDQXoOWtxmhpIJV5V7zJdOsj325fXaXcm
         QSgXvgIKAv+iScx4NKxuQLBczBcUFpbZ32WzC3d8tW918vpjEfCzXg9gtyu+rBGua+/G
         +ZGEOEo5pcabCwQZWE7iPp5VpVxgLXh5KGuOFcqQ5WRvMdffL/Q2mHv8EYbu3f4j7flc
         d1Ea5aUkvNHyyijyTWKIsGGEMj+qWi6BPbtlxKSfyRhIUYIHjsy2oMbWRgUQRgdkhTHz
         YZh2dEi/T6ciJbB7JzKq5i/Cn6+jFTIGseWT0hotQRqKBCEn0cyzG3LNyrPLmj3Zobt9
         3Jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717437950; x=1718042750;
        h=message-id:to:from:cc:in-reply-to:subject:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3jcvQIjFY4g0Y2/xyHIexxJ5t7wWhmDVa3Fa+B/xds4=;
        b=hySAbtZZ5Q8syMRHNraLEjcVSjxwZHXUwBpWTZWmf9VrSG+DtbiKjnMd/lGOI7BlZP
         xEFdge7FKtEh2czkzv3IUzfScx4YNqZS/Pe+Darf6UVeEQHw622+b77hMVKT4PPWIAgb
         X1dOTnrN31xZ86kccpBzCll95stlILD8u1g23YCoRQWceEP0FiBqN94L0pMJ7Y2wRcb5
         t/zURniW2cgnuGVMOJo0L0RSImJFULUTntQUmJ8hPNkD6FCOqifFc1T7VkseIB0cZYDM
         rF8eZttqW0SEm6P8RF331IZyBNOBAa1zBz+KxXhyghs6jjmPtb5REOvVp5NEYio9/Rc2
         I6sw==
X-Forwarded-Encrypted: i=1; AJvYcCVxmtYarrgX1s3ND04FQ2pFJwgT/pki3/UsVgDiGUtG+88sE+l0W9UvO/CrhXuUkWoc9c+W/vw/5BBw7Ce3yW+zx36970XwrDXD0HCA
X-Gm-Message-State: AOJu0YybSMTWmiEIWBUb6ouHRIsp/EzTsK7i0h5kKszcj6m7mRRB75iW
	gibGCtlzQcuvmx8IEOcSB0paOySvVWo7sr3ZwFKBH+jPkofhvOluSB/t7zijyzw=
X-Google-Smtp-Source: AGHT+IHwQFobE9n13KkLj2Qbao87xXsCVoxnr+pQNLpQazxLn18PWQTeqJ84RfHijPQlzzGG5ZTI7g==
X-Received: by 2002:a17:903:22cf:b0:1f6:7cc9:fb2c with SMTP id d9443c01a7336-1f67cc9fd61mr37287145ad.49.1717437949140;
        Mon, 03 Jun 2024 11:05:49 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323e3c33sm67722815ad.176.2024.06.03.11.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 11:05:47 -0700 (PDT)
Date: Mon, 03 Jun 2024 11:05:47 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Jun 2024 11:05:41 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: hwprobe: Add MISALIGNED_PERF key
In-Reply-To: <mhng-d3cf0bb4-4881-4f71-b1d1-6bb756d5c4ef@palmer-ri-x1c9>
CC: cyy@cyyself.name, Evan Green <evan@rivosinc.com>, aou@eecs.berkeley.edu,
  ajones@ventanamicro.com, andy.chiu@sifive.com, cleger@rivosinc.com,
  Conor Dooley <conor.dooley@microchip.com>, costa.shul@redhat.com, corbet@lwn.net,
  Paul Walmsley <paul.walmsley@sifive.com>, samitolvanen@google.com, linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: jesse@rivosinc.com
Message-ID: <mhng-16df84df-80ef-44a9-8f04-18d81b914b24@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Mon, 03 Jun 2024 10:57:21 PDT (-0700), Palmer Dabbelt wrote:
> On Wed, 29 May 2024 20:36:45 PDT (-0700), cyy@cyyself.name wrote:
>> On 2024/5/30 02:26, Evan Green wrote:
>>> RISCV_HWPROBE_KEY_CPUPERF_0 was mistakenly flagged as a bitmask in
>>> hwprobe_key_is_bitmask(), when in reality it was an enum value. This
>>> causes problems when used in conjunction with RISCV_HWPROBE_WHICH_CPUS,
>>> since SLOW, FAST, and EMULATED have values whose bits overlap with
>>> each other. If the caller asked for the set of CPUs that was SLOW or
>>> EMULATED, the returned set would also include CPUs that were FAST.
>>>
>>> Introduce a new hwprobe key, RISCV_HWPROBE_KEY_MISALIGNED_PERF, which
>>> returns the same values in response to a direct query (with no flags),
>>> but is properly handled as an enumerated value. As a result, SLOW,
>>> FAST, and EMULATED are all correctly treated as distinct values under
>>> the new key when queried with the WHICH_CPUS flag.
>>>
>>> Leave the old key in place to avoid disturbing applications which may
>>> have already come to rely on the broken behavior.
>>>
>>> Fixes: e178bf146e4b ("RISC-V: hwprobe: Introduce which-cpus flag")
>>> Signed-off-by: Evan Green <evan@rivosinc.com>
>>>
>>> ---
>>>
>>>
>>> Note: Yangyu also has a fix out for this issue at [1]. That fix is much
>>> tidier, but comes with the slight risk that some very broken userspace
>>> application may break now that FAST cpus are not included for the query
>>> of which cpus are SLOW or EMULATED.
>>
>> Indeed. Since the value of FAST is 0b11, the SLOW and EMULATED are 0b10 and
>> 0b01 respectively.
>>
>> When this key is treated as a bitmask and query with
>> RISCV_HWPROBE_WHICH_CPUS if a CPU has a superset bitmask of the requested
>> value on the requested key, it will remain in the CPU mask. Otherwise, the
>> CPU will be clear in the CPU mask. But when a key is treated as a value, we
>> will just do a comparison. if it is not equal, then the CPU will be clear
>> in the CPU. That's why FAST cpus are included when querying with SLOW or
>> EMULATED with RISCV_HWPROBE_KEY_CPUPERF_0 key now.
>>
>> For me, deprecating the original hwprobe key and introducing a new key
>> would be a better solution than changing the behavior as my patch did.
>
> OK.  I don't have a strong feeling either way: if someone has code that
> tries to read this as a btimask then it'd be broken, but it would
> technically be following the docs.
>
> That said, we're relying on this as a pretty core userspace portability
> construct.  So maybe the right answer here is to just be really strict
> about compatibility and eat the pain when we make a mistake, just to
> make sure we set the right example about not breaking stuff.
>
> So unless anyone's opposed, I'll pick this up for 6.11.

Though a few of us were talking and it looks like it's probably best to 
just make this extensible and put the vector stuff in here too.  So 
something like

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index df5045103e73..e74727e1b7c0 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -211,25 +211,30 @@ The following keys are defined:
      :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_PERF`, but the key was mistakenly
      classified as a bitmask rather than a value.

-* :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_PERF`: An enum value describing the
-  performance of misaligned scalar accesses on the selected set of processors.
+* :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_PERF`: An set of enum values describing the
+  performance of misaligned accesses on the selected set of processors.

-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of misaligned
+  * :c:macro: `RISCV_HWPROBE_SCALAR_MISALIGNED_MASK`: Describes the performance
+    of scalar misaligned accesses.
+
+  * :c:macro:`RISCV_HWPROBE_SCALAR_MISALIGNED_UNKNOWN`: The performance of misaligned
     accesses is unknown.

-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned accesses are
+  * :c:macro:`RISCV_HWPROBE_SCALAR_MISALIGNED_EMULATED`: Misaligned accesses are
     emulated via software, either in or below the kernel.  These accesses are
     always extremely slow.

-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned accesses are slower
+  * :c:macro:`RISCV_HWPROBE_SCALAR_MISALIGNED_SLOW`: Misaligned accesses are slower
     than equivalent byte accesses.  Misaligned accesses may be supported
     directly in hardware, or trapped and emulated by software.

-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned accesses are faster
+  * :c:macro:`RISCV_HWPROBE_SCALAR_MISALIGNED_FAST`: Misaligned accesses are faster
     than equivalent byte accesses.

-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned accesses are
+  * :c:macro:`RISCV_HWPROBE_SCALAR_MISALIGNED_UNSUPPORTED`: Misaligned accesses are
     not supported at all and will generate a misaligned address fault.

+  * :c:macro: `RISCV_HWPROBE_VECTOR_MISALIGNED_MASK`: ... vector ...
+
 * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
   represents the size of the Zicboz block in bytes.

Jesse is looking at the vector misaligned stuff that's showing up on the 
hardware, so I'll just hold off on this for a bit -- that way we can get 
the vector stuff sorted out at the same time.

>
>>> I wanted to get this fix out so that
>>> we have both as options, and can discuss. These fixes are mutually
>>> exclusive, don't take both.
>>
>> It's better to note this strange behavior on
>> Documentation/arch/riscv/hwprobe.rst so users can quickly understand the
>> differences on the behavior of these two keys.
>>
>> The C code part looks good to me.
>>
>>>
>>> [1] https://lore.kernel.org/linux-riscv/tencent_01F8E0050FB4B11CC170C3639E43F41A1709@qq.com/
>>>
>>> ---
>>> Documentation/arch/riscv/hwprobe.rst | 8 ++++++--
>>> arch/riscv/include/asm/hwprobe.h | 2 +-
>>> arch/riscv/include/uapi/asm/hwprobe.h | 1 +
>>> arch/riscv/kernel/sys_hwprobe.c | 1 +
>>> 4 files changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
>>> index 204cd4433af5..616ee372adaf 100644
>>> --- a/Documentation/arch/riscv/hwprobe.rst
>>> +++ b/Documentation/arch/riscv/hwprobe.rst
>>> @@ -192,8 +192,12 @@ The following keys are defined:
>>> supported as defined in the RISC-V ISA manual starting from commit
>>> d8ab5c78c207 ("Zihintpause is ratified").
>>>
>>> -* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
>>> - information about the selected set of processors.
>>> +* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated. Returns similar values to
>>> + :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_PERF`, but the key was mistakenly
>>> + classified as a bitmask rather than a value.
>>> +
>>> +* :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_PERF`: An enum value describing the
>>> + performance of misaligned scalar accesses on the selected set of processors.
>>>
>>> * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of misaligned
>>> accesses is unknown.
>>> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
>>> index 630507dff5ea..150a9877b0af 100644
>>> --- a/arch/riscv/include/asm/hwprobe.h
>>> +++ b/arch/riscv/include/asm/hwprobe.h
>>> @@ -8,7 +8,7 @@
>>>
>>> #include <uapi/asm/hwprobe.h>
>>>
>>> -#define RISCV_HWPROBE_MAX_KEY 6
>>> +#define RISCV_HWPROBE_MAX_KEY 7
>>>
>>> static inline bool riscv_hwprobe_key_is_valid(__s64 key)
>>> {
>>> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
>>> index dda76a05420b..bc34e33fef23 100644
>>> --- a/arch/riscv/include/uapi/asm/hwprobe.h
>>> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
>>> @@ -68,6 +68,7 @@ struct riscv_hwprobe {
>>> #define RISCV_HWPROBE_MISALIGNED_UNSUPPORTED (4 << 0)
>>> #define RISCV_HWPROBE_MISALIGNED_MASK (7 << 0)
>>> #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE 6
>>> +#define RISCV_HWPROBE_KEY_MISALIGNED_PERF 7
>>> /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>>>
>>> /* Flags */
>>> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
>>> index 969ef3d59dbe..c8b7d57eb55e 100644
>>> --- a/arch/riscv/kernel/sys_hwprobe.c
>>> +++ b/arch/riscv/kernel/sys_hwprobe.c
>>> @@ -208,6 +208,7 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>>> break;
>>>
>>> case RISCV_HWPROBE_KEY_CPUPERF_0:
>>> + case RISCV_HWPROBE_KEY_MISALIGNED_PERF:
>>> pair->value = hwprobe_misaligned(cpus);
>>> break;
>>>

