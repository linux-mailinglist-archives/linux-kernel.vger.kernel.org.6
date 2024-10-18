Return-Path: <linux-kernel+bounces-372526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE279A49CD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 01:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C32E2852BD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AE2191F60;
	Fri, 18 Oct 2024 23:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2xaGDfMV"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A78D1917E6
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 23:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729292484; cv=none; b=W3hqBrpK1U60dlGR3A1zDXOiEy+SUbVAT+2ZCiTBYO1T2vudvIw8NscXRVJuf1kAmhJn5mu0Vs+NfU9hV8NoVhB+STX6UqhvB1amiObXr+t70qmml5aQJYbU2cojnRyB0iOTu8xCgkCVJX2sYUHFFpR8Xoy+nJ4b+YHh9WMYjmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729292484; c=relaxed/simple;
	bh=4FJ0G8bpNRFSMNEyYp9cI09SUVX3zQdubCpvJC7qong=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WP5xFU3gZS6ly+rNy+VG2ysNF3wVy1pTjgAUQMDlCEyu0hrU2LHnvEWHlgyGzl05P7PUcZ5SGN08k2Ei9sVxbYMdsVrZEZcCqWOoWb7/z3sw5xg/JgSjXyXELmGvw9idSxyRLHGoZt7Lnu8ny4XNaoTWQcLuNzHaMiRWY9SdR9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2xaGDfMV; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-83aba5e162bso46617439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 16:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729292480; x=1729897280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uLjNzHb2QRcqWVsEUW+j8xr26gbx65KWLWqRdmYKeaA=;
        b=2xaGDfMVsn+IL+/yUeUN7dKLp52qJQW+/O+12Q4x2HwtJ+2OSVyLHlnAaGhyfHC6CX
         RgBlZ7EB+x4OFaFIepzvKndHnUwFfgnehNg73uq72GE6ZvNPypNEqj/4vGvtK9rbdSFo
         4grZ6VH3Jf1vo6sWXBH7YhLjXvIA4BjLPcISLfOTHHhsNmuaX5iUmuDhjwtCoPfYnH+0
         IHJMZGJqLCaXOozDb39Lzknmv2e/jQpLdBuJNHZEgomsRdcoZvSvPK0e2n4jf7brkUPA
         GGOk1Dw9Phnc6eFfNSwRvXYhQh4K0gtHhSJG+BFDreVpjezIEGmsjlwdpjBQYw894hKg
         ayyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729292480; x=1729897280;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uLjNzHb2QRcqWVsEUW+j8xr26gbx65KWLWqRdmYKeaA=;
        b=ebym5tUKtjveEUrkhE8hccFH9F44BUrXtxbjHE2k5Tb/3ZUp6lYks+WATfVcd+zNfJ
         2rLxkcUEZjnUerM7I+OKSyN8hkVfQwynS0v3apBvJl+omnNCiLRJ8FnUY0CSOjJDNoBR
         IAqp7HWLYiO6g2JLGOlZaFTHX7VKidB7PvabnWoHuI7vfImPNHGOaUtwOri0udcr2afC
         qhfryowyd2EtNVfSAvItXQ8AAUpiTaZ1UeiirAouShAr/l71NZIw/LEN+A82PsZg5Z/s
         goI5MUJhdBNq5L1zt1Ut6I/ssSOMoceFS4BHqCXlwpvC52vIOHyP2O6Y6T/6t0snyIev
         yhZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgxXidLEte0vqJ96RRhfq0gBkCiWpdxp1qGAClYnZp9aKJ44CIPeqNyU6KRZ5+e/DXDbI1lK87EHxsKyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT2SylDWoQnVDzShCPX2zv6Z/k9tKrznJi8w/SyiMvbrs05Prk
	TASG4ntsOLRXulOWh+glVS7SeKQgdm0G6r1/q6Dd4F7dUEjK7g17W143jq4cfsizt4qynlJXE9C
	6
X-Google-Smtp-Source: AGHT+IHHM5J7P9ZVJ6BdSu0wHN8+pXSWKNVXJIBku1nPP4WbmJXlHwVX5B5msCPJRXtCnuVIC+M/PA==
X-Received: by 2002:a05:6602:158f:b0:83a:9a59:f382 with SMTP id ca18e2360f4ac-83aba67f44amr450293939f.16.1729292480263;
        Fri, 18 Oct 2024 16:01:20 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83ab9da6ff5sm61636539f.26.2024.10.18.16.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 16:01:19 -0700 (PDT)
Message-ID: <1bb5dd7f-15b5-4d9d-97ef-75ebdc24e7d9@kernel.dk>
Date: Fri, 18 Oct 2024 17:01:18 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AMD zen microcode updates breaks boot
From: Jens Axboe <axboe@kernel.dk>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <3400cf0b-85ca-4ec2-a8a0-c9d75889d573@kernel.dk>
 <20241017141314.GDZxEbenNT6XF4jIaA@fat_crate.local>
 <4d4bf52a-dd91-48ad-8949-198b2ffbc9da@kernel.dk>
 <20241017142707.GEZxEeu3YHvnEMmd32@fat_crate.local>
 <a395a18b-3478-45dd-aabd-ccc9d0851318@kernel.dk>
 <20241018115857.GBZxJNgZY-NedtPrxX@fat_crate.local>
 <20241018124943.GDZxJZZxtwA9O9eqiU@fat_crate.local>
 <79296353-1fa3-458a-b055-88bc6a772180@kernel.dk>
 <20241018155143.GIZxKED9YcF0Jg1CWZ@fat_crate.local>
 <320024ab-63af-45eb-a3ae-5486cb2015c0@kernel.dk>
 <20241018175606.GJZxKhNmW9nCLwNS6Z@fat_crate.local>
 <016ecb00-2331-472c-88e4-66b1dbecfc99@kernel.dk>
Content-Language: en-US
In-Reply-To: <016ecb00-2331-472c-88e4-66b1dbecfc99@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/24 12:03 PM, Jens Axboe wrote:
> On 10/18/24 11:56 AM, Borislav Petkov wrote:
>> On Fri, Oct 18, 2024 at 10:48:19AM -0600, Jens Axboe wrote:
>>> Funky... Not sure I'll have time to get a serial console on this
>>> thing before next week.
>>
>> That would be much appreciated.
> 
> I will probably have some time to get that going on Monday. Just to set
> expectations in terms of timing, the above should've read "before the end
> of next week".

I took time out of "would otherwise have had a beer" time on a Friday
afternoon and got a serial console on it. Here's the crash at boot:

BUG: unable to handle page fault for address: 00000001000141ab
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: Oops: 0000 [#1] SMP
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc2+ #143
Hardware name: Dell Inc. PowerEdge R7625/06444F, BIOS 1.8.3 04/02/2024
RIP: 0010:load_microcode_amd.isra.0+0x334/0x450
Code: e7 06 48 81 c7 c0 97 7e 96 e8 f8 bb 4e 00 89 c7 89 c0 4c 8b 2c c5 40 20 e2 95 49 01 ed e8 44 f9 ff ff 48 85 c0 74 12 8b 40 1c <41> 39 85 28 01 00 00 0f 92 c0 0f b6 c0 09 c3 41 8d 4c 24 01 41 83
RSP: 0018:ffffa41ac00e7e08 EFLAGS: 00010282
RAX: 000000000aa00116 RBX: 0000000000000000 RCX: 0000000000a00000
RDX: 0000000000aa0f00 RSI: 0000000000000200 RDI: 000000000000000a
RBP: 0000000000014080 R08: 000000000000aa01 R09: ffff93ebc1106000
R10: ffffa41ac00e7df0 R11: 0000000000002000 R12: 0000000000000001
R13: 0000000100014083 R14: ffff93ebc103b400 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff93f127e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000001000141ab CR3: 000000ba2de28001 CR4: 0000000000370ef0
Call Trace:
 <TASK>
 ? __die_body.cold+0x19/0x2b
 ? page_fault_oops+0x90/0x210
 ? load_microcode_amd.isra.0+0x185/0x450
 ? exc_page_fault+0x6c/0x130
 ? asm_exc_page_fault+0x22/0x30
 ? load_microcode_amd.isra.0+0x334/0x450
 ? load_microcode_amd.isra.0+0x32c/0x450
 save_microcode_in_initrd+0x90/0xb0
 ? find_blobs_in_containers+0xb0/0xb0
 do_one_initcall+0x2e/0x190
 ? try_to_wake_up+0x1c0/0x4b0
 kernel_init_freeable+0xdd/0x210
 ? rest_init+0xc0/0xc0
 kernel_init+0x16/0x120
 ret_from_fork+0x2d/0x50
 ? rest_init+0xc0/0xc0
 ret_from_fork_asm+0x11/0x20
 </TASK>
Modules linked in:
CR2: 00000001000141ab
---[ end trace 0000000000000000 ]---
RIP: 0010:load_microcode_amd.isra.0+0x334/0x450
Code: e7 06 48 81 c7 c0 97 7e 96 e8 f8 bb 4e 00 89 c7 89 c0 4c 8b 2c c5 40 20 e2 95 49 01 ed e8 44 f9 ff ff 48 85 c0 74 12 8b 40 1c <41> 39 85 28 01 00 00 0f 92 c0 0f b6 c0 09 c3 41 8d 4c 24 01 41 83
RSP: 0018:ffffa41ac00e7e08 EFLAGS: 00010282
RAX: 000000000aa00116 RBX: 0000000000000000 RCX: 0000000000a00000
RDX: 0000000000aa0f00 RSI: 0000000000000200 RDI: 000000000000000a
RBP: 0000000000014080 R08: 000000000000aa01 R09: ffff93ebc1106000
R10: ffffa41ac00e7df0 R11: 0000000000002000 R12: 0000000000000001
R13: 0000000100014083 R14: ffff93ebc103b400 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff93f127e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000001000141ab CR3: 000000ba2de28001 CR4: 0000000000370ef0
note: swapper/0[1] exited with irqs disabled
Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009 ]---

which appears to be here:

(gdb) l *load_microcode_amd+0x334
0xffffffff810914a4 is in load_microcode_amd (arch/x86/kernel/cpu/microcode/amd.c:971).
966	
967			p = find_patch(cpu);
968			if (!p)
969				continue;
970	
971			if (c->microcode >= p->patch_id)
972				continue;
973	
974			ret = UCODE_NEW;
975		}

heading home, so didn't poke. As you know, there are 32 nodes in this
sytem, looks like:

axboe@r7625 /s/d/s/node> grep . node*/cpulist
node0/cpulist:0-7,256-263
node1/cpulist:8-15,264-271
node2/cpulist:16-23,272-279
node3/cpulist:24-31,280-287
node4/cpulist:32-39,288-295
node5/cpulist:40-47,296-303
node6/cpulist:48-55,304-311
node7/cpulist:56-63,312-319
node8/cpulist:64-71,320-327
node9/cpulist:72-79,328-335
node10/cpulist:80-87,336-343
node11/cpulist:88-95,344-351
node12/cpulist:96-103,352-359
node13/cpulist:104-111,360-367
node14/cpulist:112-119,368-375
node15/cpulist:120-127,376-383
node16/cpulist:128-135,384-391
node17/cpulist:136-143,392-399
node18/cpulist:144-151,400-407
node19/cpulist:152-159,408-415
node20/cpulist:160-167,416-423
node21/cpulist:168-175,424-431
node22/cpulist:176-183,432-439
node23/cpulist:184-191,440-447
node24/cpulist:192-199,448-455
node25/cpulist:200-207,456-463
node26/cpulist:208-215,464-471
node27/cpulist:216-223,472-479
node28/cpulist:224-231,480-487
node29/cpulist:232-239,488-495
node30/cpulist:240-247,496-503
node31/cpulist:248-255,504-511

and .config has:

CONFIG_NODES_SHIFT=5
CONFIG_USE_PERCPU_NUMA_NODE_ID=y

-- 
Jens Axboe

