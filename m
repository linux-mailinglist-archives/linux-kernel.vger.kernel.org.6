Return-Path: <linux-kernel+bounces-431198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A279E3AD7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8A82B33BA1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260DA1CC8A7;
	Wed,  4 Dec 2024 12:48:00 +0000 (UTC)
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1961AF0AA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316475; cv=none; b=CvGuE4RDZPCZPjcGF21SC+t7OpBLfRGOkm1+Xr756PhgXuJaQXSDvs5XWUxewcqNdHEZOhXqV3iLSopspaan4rGq2UCjbIuIQiGBYHlxYpytklK2rKO06BE4KE42ARKDZI4dufh9jSmf3DhSIzkt/34DG0v+fQofXjwrqBYAaD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316475; c=relaxed/simple;
	bh=W9+WTR/rT+awySovhE1hNc3jIN6W4Jc3brNqKdicIu4=;
	h=Message-ID:Date:MIME-Version:Cc:From:Subject:To:Content-Type; b=sl6Ijzup6iFyj1CQ19JI6dw6DVUeCEJpAfOugzaLu8QtJaRo3IqsuLbLXBjIof/1OL57ohezsIYwlgUPaZldxYBx0VMpfB5JyyIsgLVB+PK5kxoOGqck0YViDA46HR1FQY6Tp+MRrrACIIAQI1+242x5tw+40AkyQ/cfrvCpK6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-aa5b0d8bd41so867979066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 04:47:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316468; x=1733921268;
        h=content-transfer-encoding:to:autocrypt:subject:from:cc
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2LpW2EjjX2h9xRzGSDs5pxd8fqcN/VYL6jvBaZC8KLY=;
        b=bZ45rMuKA8JYk0XA3kZgUBE//r9CXIyUe8dZU1brbKQdmDnjKU6E0G0JjzjJ9xcXti
         17eQuPt1EUyWaz7JhaoM5UPFIeJxHQ27gd3gkNqvy/oQDctLzGVIgshBsNrRyo93par2
         dribWx+zP8LPvr/M7q97bPWV07h9gaFZS5pGYc75oaEvnTuJfgQEm+mrBIZ8in9UB9xQ
         loBVQtQTkMzr14wEZbQHhbHxoXeTkwDZ0Sy7JeiRpjUtUJ//L7AW6Oa1pihmk5VqA0IR
         s1SToR0cPw3wLv5ZG48LEoIZmvx2QA7mxe2nPCrJcs41j/VfBZM+d8UNfMUcMkzRBx2D
         +wvg==
X-Gm-Message-State: AOJu0YzoUYuv+AB02BZbat5fnu+wXP1MWc0AeCdJRCZP3F3yLqi2DeGC
	zLcBFzoUAlrkut7ctjj9pFtkhP9IyOv2/3S1DeuaH2+a1LVpj8uKzWWBWTzF
X-Gm-Gg: ASbGnctEjObnqpvWyxIn5UoeV4UkoJPV2G+MQGmzpkj+8wCiOll6wE5k6rHAxkRD+sS
	99+cwABqBrNfdLL/cqQ+U4Y2NSDnvAKoeMvfQ5tUpiiZzv9uhisknnM6JqDtcKUhF8C4FwRYKNq
	WWJ4qP/6z4tJW6U/tqBWwLhhBgeJ0H5Nv01Vg4Zm8RESfyTl9ZrBy42HPYQJZnSyT35HI+h682w
	tMXJdq/hACPc63ekzEXkr647SER3Fum4rmaUMLSdt0kgqWD1D+hZnhLgrtFjoLHhM1bnz6jFdbV
	zr833Q==
X-Google-Smtp-Source: AGHT+IGggmBQysI04FglFiDxF9DqUX6DeoohsTjjQ5sQzsXxpZwd7Z9WCeufWa2zlrtDoU8AeVHUVQ==
X-Received: by 2002:a17:906:3d32:b0:a99:fa4e:ba97 with SMTP id a640c23a62f3a-aa5f7f0b488mr444526066b.39.1733316467172;
        Wed, 04 Dec 2024 04:47:47 -0800 (PST)
Received: from [192.168.0.13] (ip-86-49-44-151.bb.vodafone.cz. [86.49.44.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5997d55fdsm723394966b.55.2024.12.04.04.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:47:46 -0800 (PST)
Message-ID: <571b2045-320d-4ac2-95db-1423d0277613@ovn.org>
Date: Wed, 4 Dec 2024 13:47:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Cc: i.maximets@ovn.org, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
From: Ilya Maximets <i.maximets@ovn.org>
Subject: [v6.12] WARNING: at kernel/sched/deadline.c:1995 enqueue_dl_entity
 (task blocked for more than 28262 seconds)
Autocrypt: addr=i.maximets@ovn.org; keydata=
 xsFNBF77bOMBEADVZQ4iajIECGfH3hpQMQjhIQlyKX4hIB3OccKl5XvB/JqVPJWuZQRuqNQG
 /B70MP6km95KnWLZ4H1/5YOJK2l7VN7nO+tyF+I+srcKq8Ai6S3vyiP9zPCrZkYvhqChNOCF
 pNqdWBEmTvLZeVPmfdrjmzCLXVLi5De9HpIZQFg/Ztgj1AZENNQjYjtDdObMHuJQNJ6ubPIW
 cvOOn4WBr8NsP4a2OuHSTdVyAJwcDhu+WrS/Bj3KlQXIdPv3Zm5x9u/56NmCn1tSkLrEgi0i
 /nJNeH5QhPdYGtNzPixKgPmCKz54/LDxU61AmBvyRve+U80ukS+5vWk8zvnCGvL0ms7kx5sA
 tETpbKEV3d7CB3sQEym8B8gl0Ux9KzGp5lbhxxO995KWzZWWokVUcevGBKsAx4a/C0wTVOpP
 FbQsq6xEpTKBZwlCpxyJi3/PbZQJ95T8Uw6tlJkPmNx8CasiqNy2872gD1nN/WOP8m+cIQNu
 o6NOiz6VzNcowhEihE8Nkw9V+zfCxC8SzSBuYCiVX6FpgKzY/Tx+v2uO4f/8FoZj2trzXdLk
 BaIiyqnE0mtmTQE8jRa29qdh+s5DNArYAchJdeKuLQYnxy+9U1SMMzJoNUX5uRy6/3KrMoC/
 7zhn44x77gSoe7XVM6mr/mK+ViVB7v9JfqlZuiHDkJnS3yxKPwARAQABzSJJbHlhIE1heGlt
 ZXRzIDxpLm1heGltZXRzQG92bi5vcmc+wsGUBBMBCAA+AhsDBQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAFiEEh+ma1RKWrHCY821auffsd8gpv5YFAmP+Y/MFCQjFXhAACgkQuffsd8gpv5Yg
 OA//eEakvE7xTHNIMdLW5r3XnWSEY44dFDEWTLnS7FbZLLHxPNFXN0GSAA8ZsJ3fE26O5Pxe
 EEFTf7R/W6hHcSXNK4c6S8wR4CkTJC3XOFJchXCdgSc7xS040fLZwGBuO55WT2ZhQvZj1PzT
 8Fco8QKvUXr07saHUaYk2Lv2mRhEPP9zsyy7C2T9zUzG04a3SGdP55tB5Adi0r/Ea+6VJoLI
 ctN8OaF6BwXpag8s76WAyDx8uCCNBF3cnNkQrCsfKrSE2jrvrJBmvlR3/lJ0OYv6bbzfkKvo
 0W383EdxevzAO6OBaI2w+wxBK92SMKQB3R0ZI8/gqCokrAFKI7gtnyPGEKz6jtvLgS3PeOtf
 5D7PTz+76F/X6rJGTOxR3bup+w1bP/TPHEPa2s7RyJISC07XDe24n9ZUlpG5ijRvfjbCCHb6
 pOEijIj2evcIsniTKER2pL+nkYtx0bp7dZEK1trbcfglzte31ZSOsfme74u5HDxq8/rUHT01
 51k/vvUAZ1KOdkPrVEl56AYUEsFLlwF1/j9mkd7rUyY3ZV6oyqxV1NKQw4qnO83XiaiVjQus
 K96X5Ea+XoNEjV4RdxTxOXdDcXqXtDJBC6fmNPzj4QcxxyzxQUVHJv67kJOkF4E+tJza+dNs
 8SF0LHnPfHaSPBFrc7yQI9vpk1XBxQWhw6oJgy3OwU0EXvts4wEQANCXyDOic0j2QKeyj/ga
 OD1oKl44JQfOgcyLVDZGYyEnyl6b/tV1mNb57y/YQYr33fwMS1hMj9eqY6tlMTNz+ciGZZWV
 YkPNHA+aFuPTzCLrapLiz829M5LctB2448bsgxFq0TPrr5KYx6AkuWzOVq/X5wYEM6djbWLc
 VWgJ3o0QBOI4/uB89xTf7mgcIcbwEf6yb/86Cs+jaHcUtJcLsVuzW5RVMVf9F+Sf/b98Lzrr
 2/mIB7clOXZJSgtV79Alxym4H0cEZabwiXnigjjsLsp4ojhGgakgCwftLkhAnQT3oBLH/6ix
 87ahawG3qlyIB8ZZKHsvTxbWte6c6xE5dmmLIDN44SajAdmjt1i7SbAwFIFjuFJGpsnfdQv1
 OiIVzJ44kdRJG8kQWPPua/k+AtwJt/gjCxv5p8sKVXTNtIP/sd3EMs2xwbF8McebLE9JCDQ1
 RXVHceAmPWVCq3WrFuX9dSlgf3RWTqNiWZC0a8Hn6fNDp26TzLbdo9mnxbU4I/3BbcAJZI9p
 9ELaE9rw3LU8esKqRIfaZqPtrdm1C+e5gZa2gkmEzG+WEsS0MKtJyOFnuglGl1ZBxR1uFvbU
 VXhewCNoviXxkkPk/DanIgYB1nUtkPC+BHkJJYCyf9Kfl33s/bai34aaxkGXqpKv+CInARg3
 fCikcHzYYWKaXS6HABEBAAHCwXwEGAEIACYCGwwWIQSH6ZrVEpascJjzbVq59+x3yCm/lgUC
 Y/5kJAUJCMVeQQAKCRC59+x3yCm/lpF7D/9Lolx00uxqXz2vt/u9flvQvLsOWa+UBmWPGX9u
 oWhQ26GjtbVvIf6SECcnNWlu/y+MHhmYkz+h2VLhWYVGJ0q03XkktFCNwUvHp3bTXG3IcPIC
 eDJUVMMIHXFp7TcuRJhrGqnlzqKverlY6+2CqtCpGMEmPVahMDGunwqFfG65QubZySCHVYvX
 T9SNga0Ay/L71+eVwcuGChGyxEWhVkpMVK5cSWVzZe7C+gb6N1aTNrhu2dhpgcwe1Xsg4dYv
 dYzTNu19FRpfc+nVRdVnOto8won1SHGgYSVJA+QPv1x8lMYqKESOHAFE/DJJKU8MRkCeSfqs
 izFVqTxTk3VXOCMUR4t2cbZ9E7Qb/ZZigmmSgilSrOPgDO5TtT811SzheAN0PvgT+L1Gsztc
 Q3BvfofFv3OLF778JyVfpXRHsn9rFqxG/QYWMqJWi+vdPJ5RhDl1QUEFyH7ok/ZY60/85FW3
 o9OQwoMf2+pKNG3J+EMuU4g4ZHGzxI0isyww7PpEHx6sxFEvMhsOp7qnjPsQUcnGIIiqKlTj
 H7i86580VndsKrRK99zJrm4s9Tg/7OFP1SpVvNvSM4TRXSzVF25WVfLgeloN1yHC5Wsqk33X
 XNtNovqA0TLFjhfyyetBsIOgpGakgBNieC9GnY7tC3AG+BqG5jnVuGqSTO+iM/d+lsoa+w==
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi.  It seems like I'm hitting some bug in the scheduler.

I'm running some tests with Open vSwitch on v6.12 kernel and some time
5 to 8 hours down the line I'm getting task blocked splats and I also
have a WARNING triggered in the scheduler code right before that:

Dec  3 22:19:55 kernel: WARNING: CPU: 27 PID: 3391271 at kernel/sched/deadline.c:1995 enqueue_dl_entity

I have a lot of processes (kernel threads and userpsace threads) stuck
in DN, Ds, D+ and D states.  It feels like IO tasks are being scheduled,
but scheduler never picks them up or they are not being scheduled at all
for whatever reason, and threads waiting on these tasks are stuck.

Dec  3 22:22:45 kernel: INFO: task khugepaged:330 blocked for more than 122 seconds.
Dec  3 22:22:45 kernel: INFO: task ovs-monitor-ips:3479822 blocked for more than 122 seconds.
Dec  3 22:22:45 kernel: INFO: task mv:3483072 blocked for more than 122 seconds.
Dec  3 22:24:48 kernel: INFO: task khugepaged:330 blocked for more than 245 seconds.
Dec  3 22:24:48 kernel: INFO: task ovs-monitor-ips:3479822 blocked for more than 245 seconds.
Dec  3 22:24:48 kernel: INFO: task ovs-monitor-ips:3480383 blocked for more than 122 seconds.
Dec  3 22:24:48 kernel: INFO: task ovs-monitor-ips:3481787 blocked for more than 122 seconds.
Dec  3 22:24:48 kernel: INFO: task ovs-monitor-ips:3482631 blocked for more than 122 seconds.
Dec  3 22:24:48 kernel: INFO: task mv:3483072 blocked for more than 245 seconds.
Dec  3 22:26:51 kernel: INFO: task khugepaged:330 blocked for more than 368 seconds.
...
Dec  4 06:11:45 kernel: INFO: task khugepaged:330 blocked for more than 28262 seconds.

I have two separate instances where this behavior is reproduced.  One is mostly
around file systems, the other was more severe as multiple kernel threads got
stuck in netlink code.  The traces do not have much in common, except that most
of blocked tasks are in scheduling.  The system is also idle, nothing is really
running.  Some of these tasks are holding resources that make other tasks to
block on those resources as well.

I seem to be able to reproduce the issue, but it takes 5-8 hours to do so.


Best regards, Ilya Maximets.



Below are logs from two instances.  The first one is from v6.12 + one small
unrelated patch for network namespaces.  The second one is from pure v6.12,
but it's not decoded as I lost the vmlinux from that run, the system was also
completely unresponsive when the issue was hit.

=====================
THE FIST DECODED LOG:
=====================

Dec  3 22:19:55 kernel: WARNING: CPU: 27 PID: 3391271 at kernel/sched/deadline.c:1995 enqueue_dl_entity (kernel/sched/deadline.c:1995 (discriminator 1)) 
Dec  3 22:19:55 kernel: Modules linked in: vport_vxlan vxlan vport_gre ip_gre ip_tunnel gre vport_geneve geneve ip6_udp_tunnel udp_tunnel openvswitch nf_conncount nf_nat tls esp4 veth nfnetlink_cttimeout nfnetlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 intel_rapl_msr intel_rapl_common rfkill intel_uncore_frequency_common skx_edac_common nfit libnvdimm kvm_intel kvm rapl vfat fat iTCO_wdt iTCO_vendor_support virtio_gpu virtio_dma_buf i2c_i801 drm_shmem_helper lpc_ich pcspkr i2c_smbus virtio_balloon drm_kms_helper joydev drm xfs libcrc32c ahci crct10dif_pclmul libahci crc32_pclmul virtio_net crc32c_intel libata ghash_clmulni_intel net_failover virtio_blk virtio_console failover serio_raw sunrpc dm_mirror dm_region_hash dm_log dm_mod fuse [last unloaded: ip6_udp_tunnel]
Dec  3 22:19:55 kernel: CPU: 27 UID: 0 PID: 3391271 Comm: kworker/27:1 Kdump: loaded Not tainted 6.12.0+ #77
Dec  3 22:19:55 kernel: Hardware name: Red Hat KVM/RHEL, BIOS 1.16.1-1.el9 04/01/2014
Dec  3 22:19:55 kernel: Workqueue:  0x0 (mm_percpu_wq)
Dec  3 22:19:55 kernel: RIP: 0010:enqueue_dl_entity (kernel/sched/deadline.c:1995 (discriminator 1)) 
Dec  3 22:19:55 kernel: Code: d2 0f 89 14 fd ff ff e9 0d fb ff ff 45 85 ed 0f
                              84 65 fd ff ff 5b 44 89 e6 48 89 ef 5d 41 5c 41
                              5d 41 5e 41 5f e9 76 c4 ff ff <0f> 0b e9 bd f9 ff
                              ff 0f 0b e9 1f fb ff ff 8b 83 b0 0a 00 00 48 8b
All code
========
   0:   d2 0f                   rorb   %cl,(%rdi)
   2:   89 14 fd ff ff e9 0d    mov    %edx,0xde9ffff(,%rdi,8)
   9:   fb                      sti    
   a:   ff                      (bad)  
   b:   ff 45 85                incl   -0x7b(%rbp)
   e:   ed                      in     (%dx),%eax
   f:   0f 84 65 fd ff ff       je     0xfffffffffffffd7a
  15:   5b                      pop    %rbx
  16:   44 89 e6                mov    %r12d,%esi
  19:   48 89 ef                mov    %rbp,%rdi
  1c:   5d                      pop    %rbp
  1d:   41 5c                   pop    %r12
  1f:   41 5d                   pop    %r13
  21:   41 5e                   pop    %r14
  23:   41 5f                   pop    %r15
  25:   e9 76 c4 ff ff          jmpq   0xffffffffffffc4a0
  2a:*  0f 0b                   ud2             <-- trapping instruction
  2c:   e9 bd f9 ff ff          jmpq   0xfffffffffffff9ee
  31:   0f 0b                   ud2    
  33:   e9 1f fb ff ff          jmpq   0xfffffffffffffb57
  38:   8b 83 b0 0a 00 00       mov    0xab0(%rbx),%eax
  3e:   48                      rex.W
  3f:   8b                      .byte 0x8b

Code starting with the faulting instruction
===========================================
   0:   0f 0b                   ud2    
   2:   e9 bd f9 ff ff          jmpq   0xfffffffffffff9c4
   7:   0f 0b                   ud2    
   9:   e9 1f fb ff ff          jmpq   0xfffffffffffffb2d
   e:   8b 83 b0 0a 00 00       mov    0xab0(%rbx),%eax
  14:   48                      rex.W
  15:   8b                      .byte 0x8b
Dec  3 22:19:55 kernel: RSP: 0018:ffffacba8d87fbb8 EFLAGS: 00010086
Dec  3 22:19:55 kernel: RAX: 0000000000000001 RBX: ffff8f5e3f7b65e8 RCX: 0000000000000000
Dec  3 22:19:55 kernel: RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff8f5e3f7b65e8
Dec  3 22:19:55 kernel: RBP: ffff8f5e3f7b65e8 R08: 0000000000000000 R09: 0000000000000000
Dec  3 22:19:55 kernel: R10: ffff8f5e3f7b5d00 R11: ffff8f4f132ed610 R12: 0000000000000001
Dec  3 22:19:55 kernel: R13: 0000000000000001 R14: 00000000002dc6c0 R15: 0000000000000000
Dec  3 22:19:55 kernel: FS:  0000000000000000(0000) GS:ffff8f5e3f780000(0000) knlGS:0000000000000000
Dec  3 22:19:55 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Dec  3 22:19:55 kernel: CR2: 00007faf752d93e0 CR3: 000000011879a001 CR4: 0000000000772ef0
Dec  3 22:19:55 kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Dec  3 22:19:55 kernel: DR3: 0000000000000000 DR6: 00000000ffff4ff0 DR7: 0000000000000400
Dec  3 22:19:55 kernel: PKRU: 55555554
Dec  3 22:19:55 kernel: Call Trace:
Dec  3 22:19:55 kernel: <TASK>
Dec  3 22:19:55 kernel: ? __warn (kernel/panic.c:748) 
Dec  3 22:19:55 kernel: ? enqueue_dl_entity (kernel/sched/deadline.c:1995 (discriminator 1)) 
Dec  3 22:19:55 kernel: ? report_bug (lib/bug.c:201 lib/bug.c:219) 
Dec  3 22:19:55 kernel: ? handle_bug (arch/x86/kernel/traps.c:285) 
Dec  3 22:19:55 kernel: ? exc_invalid_op (arch/x86/kernel/traps.c:309 (discriminator 1)) 
Dec  3 22:19:55 kernel: ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621) 
Dec  3 22:19:55 kernel: ? enqueue_dl_entity (kernel/sched/deadline.c:1995 (discriminator 1)) 
Dec  3 22:19:55 kernel: dl_server_start (kernel/sched/deadline.c:1651) 
Dec  3 22:19:55 kernel: enqueue_task_fair (kernel/sched/sched.h:2745 kernel/sched/fair.c:7048) 
Dec  3 22:19:55 kernel: enqueue_task (kernel/sched/core.c:2020) 
Dec  3 22:19:55 kernel: activate_task (kernel/sched/core.c:2069) 
Dec  3 22:19:55 kernel: sched_balance_rq (kernel/sched/fair.c:9642 kernel/sched/fair.c:9676 kernel/sched/fair.c:11753) 
Dec  3 22:19:55 kernel: sched_balance_newidle (kernel/sched/fair.c:12799) 
Dec  3 22:19:55 kernel: pick_next_task_fair (kernel/sched/fair.c:8950) 
Dec  3 22:19:55 kernel: __pick_next_task (kernel/sched/core.c:5972) 
Dec  3 22:19:55 kernel: __schedule (kernel/sched/core.c:6647) 
Dec  3 22:19:55 kernel: schedule (./arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6771 kernel/sched/core.c:6785) 
Dec  3 22:19:55 kernel: worker_thread (kernel/workqueue.c:3344) 
Dec  3 22:19:55 kernel: ? __pfx_worker_thread (kernel/workqueue.c:3337) 
Dec  3 22:19:55 kernel: kthread (kernel/kthread.c:389) 
Dec  3 22:19:55 kernel: ? __pfx_kthread (kernel/kthread.c:342) 
Dec  3 22:19:55 kernel: ret_from_fork (arch/x86/kernel/process.c:147) 
Dec  3 22:19:55 kernel: ? __pfx_kthread (kernel/kthread.c:342) 
Dec  3 22:19:55 kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Dec  3 22:19:55 kernel: </TASK>
Dec  3 22:19:55 kernel: ---[ end trace 0000000000000000 ]---
Dec  3 22:19:55 kernel: ovs-p-13: entered promiscuous mode
Dec  3 22:22:45 kernel: INFO: task khugepaged:330 blocked for more than 122 seconds.
Dec  3 22:22:45 kernel:      Tainted: G        W          6.12.0+ #77
Dec  3 22:22:45 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  3 22:22:45 kernel: task:khugepaged      state:D stack:0     pid:330   tgid:330   ppid:2      flags:0x00004000
Dec  3 22:22:45 kernel: Call Trace:
Dec  3 22:22:45 kernel: <TASK>
Dec  3 22:22:45 kernel: __schedule (kernel/sched/core.c:5328 kernel/sched/core.c:6693) 
Dec  3 22:22:45 kernel: schedule (./arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6771 kernel/sched/core.c:6785) 
Dec  3 22:22:45 kernel: schedule_timeout (kernel/time/timer.c:2592) 
Dec  3 22:22:45 kernel: ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
Dec  3 22:22:45 kernel: ? sched_clock (./arch/x86/include/asm/preempt.h:94 arch/x86/kernel/tsc.c:285) 
Dec  3 22:22:45 kernel: ? sched_clock_cpu (kernel/sched/clock.c:394) 
Dec  3 22:22:45 kernel: ? __smp_call_single_queue (kernel/smp.c:115 kernel/smp.c:411) 
Dec  3 22:22:45 kernel: __wait_for_common (kernel/sched/completion.c:95 kernel/sched/completion.c:116) 
Dec  3 22:22:45 kernel: ? __pfx_schedule_timeout (kernel/time/timer.c:2577) 
Dec  3 22:22:45 kernel: __flush_work (kernel/workqueue.c:4222) 
Dec  3 22:22:45 kernel: ? __pfx_wq_barrier_func (kernel/workqueue.c:3718) 
Dec  3 22:22:45 kernel: __lru_add_drain_all (mm/swap.c:873 (discriminator 3)) 
Dec  3 22:22:45 kernel: khugepaged (mm/khugepaged.c:2499 mm/khugepaged.c:2571) 
Dec  3 22:22:45 kernel: ? __pfx_khugepaged (mm/khugepaged.c:2564) 
Dec  3 22:22:45 kernel: kthread (kernel/kthread.c:389) 
Dec  3 22:22:45 kernel: ? __pfx_kthread (kernel/kthread.c:342) 
Dec  3 22:22:45 kernel: ret_from_fork (arch/x86/kernel/process.c:147) 
Dec  3 22:22:45 kernel: ? __pfx_kthread (kernel/kthread.c:342) 
Dec  3 22:22:45 kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Dec  3 22:22:45 kernel: </TASK>
Dec  3 22:22:45 kernel: INFO: task ovs-monitor-ips:3479822 blocked for more than 122 seconds.
Dec  3 22:22:45 kernel:      Tainted: G        W          6.12.0+ #77
Dec  3 22:22:45 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  3 22:22:45 kernel: task:ovs-monitor-ips state:D stack:0     pid:3479822 tgid:3479822 ppid:1      flags:0x00000002
Dec  3 22:22:45 kernel: Call Trace:
Dec  3 22:22:45 kernel: <TASK>
Dec  3 22:22:45 kernel: __schedule (kernel/sched/core.c:5328 kernel/sched/core.c:6693) 
Dec  3 22:22:45 kernel: ? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/paravirt.h:589 ./arch/x86/include/asm/qspinlock.h:57 ./include/linux/spinlock.h:204 ./include/linux/spinlock_api_smp.h:150 kernel/locking/spinlock.c:194) 
Dec  3 22:22:45 kernel: schedule (./arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6771 kernel/sched/core.c:6785) 
Dec  3 22:22:45 kernel: io_schedule (kernel/sched/core.c:7552 kernel/sched/core.c:7578) 
Dec  3 22:22:45 kernel: folio_wait_bit_common (mm/filemap.c:1301) 
Dec  3 22:22:45 kernel: ? xas_load (./include/linux/xarray.h:175 ./include/linux/xarray.h:1264 lib/xarray.c:240) 
Dec  3 22:22:45 kernel: ? __pfx_wake_page_function (mm/filemap.c:1117) 
Dec  3 22:22:45 kernel: folio_wait_writeback (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/page-flags.h:555 mm/page-writeback.c:3187) 
Dec  3 22:22:45 kernel: truncate_inode_partial_folio (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/page-flags.h:822 ./include/linux/page-flags.h:843 ./include/linux/mm.h:1115 ./include/linux/mm.h:2137 mm/truncate.c:209) 
Dec  3 22:22:45 kernel: truncate_inode_pages_range (mm/truncate.c:354) 
Dec  3 22:22:45 kernel: ? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/paravirt.h:589 ./arch/x86/include/asm/qspinlock.h:57 ./include/linux/spinlock.h:204 ./include/linux/spinlock_api_smp.h:150 kernel/locking/spinlock.c:194) 
Dec  3 22:22:45 kernel: ? poll_freewait (fs/select.c:140 (discriminator 3)) 
Dec  3 22:22:45 kernel: ? do_select (fs/select.c:612) 
Dec  3 22:22:45 kernel: ? __pfx_pollwake (fs/select.c:209) 
Dec  3 22:22:45 kernel: ? __pfx_pollwake (fs/select.c:209) 
Dec  3 22:22:45 kernel: ? down_read (./arch/x86/include/asm/preempt.h:79 kernel/locking/rwsem.c:1246 kernel/locking/rwsem.c:1261 kernel/locking/rwsem.c:1526) 
Dec  3 22:22:45 kernel: ? unmap_mapping_range (mm/memory.c:3873) 
Dec  3 22:22:45 kernel: truncate_pagecache (mm/truncate.c:728) 
Dec  3 22:22:45 kernel: xfs_setattr_size+0x139/0x410 xfs
Dec  3 22:22:45 kernel: xfs_vn_setattr+0x78/0x140 xfs
Dec  3 22:22:45 kernel: notify_change (fs/attr.c:503) 
Dec  3 22:22:45 kernel: ? do_truncate (./include/linux/fs.h:820 fs/open.c:66) 
Dec  3 22:22:45 kernel: do_truncate (./include/linux/fs.h:820 fs/open.c:66) 
Dec  3 22:22:45 kernel: do_open (fs/namei.c:3395 fs/namei.c:3778) 
Dec  3 22:22:45 kernel: path_openat (fs/namei.c:3933) 
Dec  3 22:22:45 kernel: ? memcg_list_lru_alloc (mm/list_lru.c:475 mm/list_lru.c:489) 
Dec  3 22:22:45 kernel: do_filp_open (fs/namei.c:3960) 
Dec  3 22:22:45 kernel: ? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/paravirt.h:589 ./arch/x86/include/asm/qspinlock.h:57 ./include/linux/spinlock.h:204 ./include/linux/spinlock_api_smp.h:150 kernel/locking/spinlock.c:194) 
Dec  3 22:22:45 kernel: ? __skb_try_recv_datagram (net/core/datagram.c:267) 
Dec  3 22:22:45 kernel: ? kmem_cache_alloc_noprof (mm/slub.c:4115 mm/slub.c:4141) 
Dec  3 22:22:45 kernel: do_sys_openat2 (fs/open.c:1415) 
Dec  3 22:22:45 kernel: __x64_sys_openat (fs/open.c:1441) 
Dec  3 22:22:45 kernel: do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
Dec  3 22:22:45 kernel: ? unix_stream_recvmsg (net/unix/af_unix.c:2997) 
Dec  3 22:22:45 kernel: ? __pfx_unix_stream_read_actor (net/unix/af_unix.c:2957) 
Dec  3 22:22:45 kernel: ? sock_recvmsg (net/socket.c:1051 net/socket.c:1073) 
Dec  3 22:22:45 kernel: ? __sys_recvfrom (net/socket.c:2265) 
Dec  3 22:22:45 kernel: ? __pte_offset_map (./include/linux/pgtable.h:324 ./include/linux/pgtable.h:594 mm/pgtable-generic.c:289) 
Dec  3 22:22:45 kernel: ? _raw_spin_unlock (./arch/x86/include/asm/paravirt.h:589 ./arch/x86/include/asm/qspinlock.h:57 ./include/linux/spinlock.h:204 ./include/linux/spinlock_api_smp.h:142 kernel/locking/spinlock.c:186) 
Dec  3 22:22:45 kernel: ? do_wp_page (./include/linux/vmstat.h:75 mm/memory.c:3263 mm/memory.c:3731) 
Dec  3 22:22:45 kernel: ? __handle_mm_fault (mm/memory.c:5909) 
Dec  3 22:22:45 kernel: ? syscall_exit_work (./include/linux/audit.h:357 kernel/entry/common.c:166) 
Dec  3 22:22:45 kernel: ? __count_memcg_events (mm/memcontrol.c:573 mm/memcontrol.c:836) 
Dec  3 22:22:45 kernel: ? handle_mm_fault (mm/memory.c:5951 mm/memory.c:6103) 
Dec  3 22:22:45 kernel: ? do_user_addr_fault (./include/linux/mm.h:730 arch/x86/mm/fault.c:1340) 
Dec  3 22:22:45 kernel: ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
Dec  3 22:22:45 kernel: ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
Dec  3 22:22:45 kernel: ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
Dec  3 22:22:45 kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
Dec  3 22:22:45 kernel: RIP: 0033:0x7f8537cfd70b
Dec  3 22:22:45 kernel: RSP: 002b:00007fff841fec70 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
Dec  3 22:22:45 kernel: RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f8537cfd70b
Dec  3 22:22:45 kernel: RDX: 0000000000080241 RSI: 00007f853707d290 RDI: 00000000ffffff9c
Dec  3 22:22:45 kernel: RBP: 00007f853707d290 R08: 0000000000000000 R09: 0000000000000000
Dec  3 22:22:45 kernel: R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000080241
Dec  3 22:22:45 kernel: R13: 00007f85371b4ea0 R14: 0000000000080241 R15: 0000000000000000
Dec  3 22:22:45 kernel: </TASK>
Dec  3 22:22:45 kernel: INFO: task mv:3483072 blocked for more than 122 seconds.
Dec  3 22:22:45 kernel:      Tainted: G        W          6.12.0+ #77
Dec  3 22:22:45 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  3 22:22:45 kernel: task:mv              state:D stack:0     pid:3483072 tgid:3483072 ppid:3479428 flags:0x00000002
Dec  3 22:22:45 kernel: Call Trace:
Dec  3 22:22:45 kernel: <TASK>
Dec  3 22:22:45 kernel: __schedule (kernel/sched/core.c:5328 kernel/sched/core.c:6693) 
Dec  3 22:22:45 kernel: schedule (./arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6771 kernel/sched/core.c:6785) 
Dec  3 22:22:45 kernel: io_schedule (kernel/sched/core.c:7552 kernel/sched/core.c:7578) 
Dec  3 22:22:45 kernel: folio_wait_bit_common (mm/filemap.c:1301) 
Dec  3 22:22:45 kernel: ? xas_load (./include/linux/xarray.h:175 ./include/linux/xarray.h:1264 lib/xarray.c:240) 
Dec  3 22:22:45 kernel: ? __pfx_wake_page_function (mm/filemap.c:1117) 
Dec  3 22:22:45 kernel: folio_wait_writeback (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/page-flags.h:555 mm/page-writeback.c:3187) 
Dec  3 22:22:45 kernel: truncate_inode_partial_folio (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/page-flags.h:822 ./include/linux/page-flags.h:843 ./include/linux/mm.h:1115 ./include/linux/mm.h:2137 mm/truncate.c:209) 
Dec  3 22:22:45 kernel: truncate_inode_pages_range (mm/truncate.c:354) 
Dec  3 22:22:45 kernel: ? xfs_iunlock+0x108/0x200 xfs
Dec  3 22:22:45 kernel: ? xfs_rename+0x368/0x990 xfs
Dec  3 22:22:45 kernel: ? fsnotify_move (./include/linux/fsnotify.h:72 ./include/linux/fsnotify.h:64 ./include/linux/fsnotify.h:238) 
Dec  3 22:22:45 kernel: ? _raw_spin_unlock (./arch/x86/include/asm/paravirt.h:589 ./arch/x86/include/asm/qspinlock.h:57 ./include/linux/spinlock.h:204 ./include/linux/spinlock_api_smp.h:142 kernel/locking/spinlock.c:186) 
Dec  3 22:22:45 kernel: ? locked_inode_to_wb_and_lock_list (fs/fs-writeback.c:355) 
Dec  3 22:22:45 kernel: evict (fs/inode.c:728) 
Dec  3 22:22:45 kernel: ? fsnotify_destroy_marks (fs/notify/mark.c:923) 
Dec  3 22:22:45 kernel: ? _atomic_dec_and_lock (./arch/x86/include/asm/atomic.h:67 ./include/linux/atomic/atomic-arch-fallback.h:2278 ./include/linux/atomic/atomic-instrumented.h:1384 lib/dec_and_lock.c:29) 
Dec  3 22:22:45 kernel: __dentry_kill (fs/dcache.c:618) 
Dec  3 22:22:45 kernel: dput (fs/dcache.c:857 fs/dcache.c:845) 
Dec  3 22:22:45 kernel: do_renameat2 (fs/namei.c:5174) 
Dec  3 22:22:45 kernel: __x64_sys_rename (fs/namei.c:5215) 
Dec  3 22:22:45 kernel: do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
Dec  3 22:22:45 kernel: ? do_user_addr_fault (./include/linux/mm.h:730 arch/x86/mm/fault.c:1340) 
Dec  3 22:22:45 kernel: ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
Dec  3 22:22:45 kernel: ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
Dec  3 22:22:45 kernel: ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
Dec  3 22:22:45 kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
Dec  3 22:22:45 kernel: RIP: 0033:0x7f3185a5aadb
Dec  3 22:22:45 kernel: RSP: 002b:00007ffe258c4548 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
Dec  3 22:22:45 kernel: RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f3185a5aadb
Dec  3 22:22:45 kernel: RDX: 0000000000000025 RSI: 00007ffe258c5cc3 RDI: 00007ffe258c5cb7
Dec  3 22:22:45 kernel: RBP: 00007ffe258c48f0 R08: 00007ffe258c4670 R09: 00007ffe258c4ac0
Dec  3 22:22:45 kernel: R10: 0000000000000100 R11: 0000000000000246 R12: 0000000000000011
Dec  3 22:22:45 kernel: R13: 0000000000000000 R14: 00007ffe258c5cc3 R15: 00007ffe258c4ac0
Dec  3 22:22:45 kernel: </TASK>
Dec  3 22:24:48 kernel: INFO: task khugepaged:330 blocked for more than 245 seconds.
Dec  3 22:24:48 kernel:      Tainted: G        W          6.12.0+ #77
Dec  3 22:24:48 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  3 22:24:48 kernel: task:khugepaged      state:D stack:0     pid:330   tgid:330   ppid:2      flags:0x00004000
Dec  3 22:24:48 kernel: Call Trace:
Dec  3 22:24:48 kernel: <TASK>
Dec  3 22:24:48 kernel: __schedule (kernel/sched/core.c:5328 kernel/sched/core.c:6693) 
Dec  3 22:24:48 kernel: schedule (./arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6771 kernel/sched/core.c:6785) 
Dec  3 22:24:48 kernel: schedule_timeout (kernel/time/timer.c:2592) 
Dec  3 22:24:48 kernel: ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
Dec  3 22:24:48 kernel: ? sched_clock (./arch/x86/include/asm/preempt.h:94 arch/x86/kernel/tsc.c:285) 
Dec  3 22:24:48 kernel: ? sched_clock_cpu (kernel/sched/clock.c:394) 
Dec  3 22:24:48 kernel: ? __smp_call_single_queue (kernel/smp.c:115 kernel/smp.c:411) 
Dec  3 22:24:48 kernel: __wait_for_common (kernel/sched/completion.c:95 kernel/sched/completion.c:116) 
Dec  3 22:24:48 kernel: ? __pfx_schedule_timeout (kernel/time/timer.c:2577) 
Dec  3 22:24:48 kernel: __flush_work (kernel/workqueue.c:4222) 
Dec  3 22:24:48 kernel: ? __pfx_wq_barrier_func (kernel/workqueue.c:3718) 
Dec  3 22:24:48 kernel: __lru_add_drain_all (mm/swap.c:873 (discriminator 3)) 
Dec  3 22:24:48 kernel: khugepaged (mm/khugepaged.c:2499 mm/khugepaged.c:2571) 
Dec  3 22:24:48 kernel: ? __pfx_khugepaged (mm/khugepaged.c:2564) 
Dec  3 22:24:48 kernel: kthread (kernel/kthread.c:389) 
Dec  3 22:24:48 kernel: ? __pfx_kthread (kernel/kthread.c:342) 
Dec  3 22:24:48 kernel: ret_from_fork (arch/x86/kernel/process.c:147) 
Dec  3 22:24:48 kernel: ? __pfx_kthread (kernel/kthread.c:342) 
Dec  3 22:24:48 kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Dec  3 22:24:48 kernel: </TASK>
Dec  3 22:24:48 kernel: INFO: task ovs-monitor-ips:3479822 blocked for more than 245 seconds.
Dec  3 22:24:48 kernel:      Tainted: G        W          6.12.0+ #77
Dec  3 22:24:48 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  3 22:24:48 kernel: task:ovs-monitor-ips state:D stack:0     pid:3479822 tgid:3479822 ppid:1      flags:0x00000002
Dec  3 22:24:48 kernel: Call Trace:
Dec  3 22:24:48 kernel: <TASK>
Dec  3 22:24:48 kernel: __schedule (kernel/sched/core.c:5328 kernel/sched/core.c:6693) 
Dec  3 22:24:48 kernel: ? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/paravirt.h:589 ./arch/x86/include/asm/qspinlock.h:57 ./include/linux/spinlock.h:204 ./include/linux/spinlock_api_smp.h:150 kernel/locking/spinlock.c:194) 
Dec  3 22:24:48 kernel: schedule (./arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6771 kernel/sched/core.c:6785) 
Dec  3 22:24:48 kernel: io_schedule (kernel/sched/core.c:7552 kernel/sched/core.c:7578) 
Dec  3 22:24:48 kernel: folio_wait_bit_common (mm/filemap.c:1301) 
Dec  3 22:24:48 kernel: ? xas_load (./include/linux/xarray.h:175 ./include/linux/xarray.h:1264 lib/xarray.c:240) 
Dec  3 22:24:48 kernel: ? __pfx_wake_page_function (mm/filemap.c:1117) 
Dec  3 22:24:48 kernel: folio_wait_writeback (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/page-flags.h:555 mm/page-writeback.c:3187) 
Dec  3 22:24:48 kernel: truncate_inode_partial_folio (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/page-flags.h:822 ./include/linux/page-flags.h:843 ./include/linux/mm.h:1115 ./include/linux/mm.h:2137 mm/truncate.c:209) 
Dec  3 22:24:48 kernel: truncate_inode_pages_range (mm/truncate.c:354) 
Dec  3 22:24:48 kernel: ? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/paravirt.h:589 ./arch/x86/include/asm/qspinlock.h:57 ./include/linux/spinlock.h:204 ./include/linux/spinlock_api_smp.h:150 kernel/locking/spinlock.c:194) 
Dec  3 22:24:48 kernel: ? poll_freewait (fs/select.c:140 (discriminator 3)) 
Dec  3 22:24:48 kernel: ? do_select (fs/select.c:612) 
Dec  3 22:24:48 kernel: ? __pfx_pollwake (fs/select.c:209) 
Dec  3 22:24:48 kernel: ? __pfx_pollwake (fs/select.c:209) 
Dec  3 22:24:48 kernel: ? down_read (./arch/x86/include/asm/preempt.h:79 kernel/locking/rwsem.c:1246 kernel/locking/rwsem.c:1261 kernel/locking/rwsem.c:1526) 
Dec  3 22:24:48 kernel: ? unmap_mapping_range (mm/memory.c:3873) 
Dec  3 22:24:48 kernel: truncate_pagecache (mm/truncate.c:728) 
Dec  3 22:24:48 kernel: xfs_setattr_size+0x139/0x410 xfs
Dec  3 22:24:48 kernel: xfs_vn_setattr+0x78/0x140 xfs
Dec  3 22:24:48 kernel: notify_change (fs/attr.c:503) 
Dec  3 22:24:48 kernel: ? do_truncate (./include/linux/fs.h:820 fs/open.c:66) 
Dec  3 22:24:48 kernel: do_truncate (./include/linux/fs.h:820 fs/open.c:66) 
Dec  3 22:24:48 kernel: do_open (fs/namei.c:3395 fs/namei.c:3778) 
Dec  3 22:24:48 kernel: path_openat (fs/namei.c:3933) 
Dec  3 22:24:48 kernel: ? memcg_list_lru_alloc (mm/list_lru.c:475 mm/list_lru.c:489) 
Dec  3 22:24:48 kernel: do_filp_open (fs/namei.c:3960) 
Dec  3 22:24:48 kernel: ? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/paravirt.h:589 ./arch/x86/include/asm/qspinlock.h:57 ./include/linux/spinlock.h:204 ./include/linux/spinlock_api_smp.h:150 kernel/locking/spinlock.c:194) 
Dec  3 22:24:48 kernel: ? __skb_try_recv_datagram (net/core/datagram.c:267) 
Dec  3 22:24:48 kernel: ? kmem_cache_alloc_noprof (mm/slub.c:4115 mm/slub.c:4141) 
Dec  3 22:24:48 kernel: do_sys_openat2 (fs/open.c:1415) 
Dec  3 22:24:48 kernel: __x64_sys_openat (fs/open.c:1441) 
Dec  3 22:24:48 kernel: do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
Dec  3 22:24:48 kernel: ? unix_stream_recvmsg (net/unix/af_unix.c:2997) 
Dec  3 22:24:48 kernel: ? __pfx_unix_stream_read_actor (net/unix/af_unix.c:2957) 
Dec  3 22:24:48 kernel: ? sock_recvmsg (net/socket.c:1051 net/socket.c:1073) 
Dec  3 22:24:48 kernel: ? __sys_recvfrom (net/socket.c:2265) 
Dec  3 22:24:48 kernel: ? __pte_offset_map (./include/linux/pgtable.h:324 ./include/linux/pgtable.h:594 mm/pgtable-generic.c:289) 
Dec  3 22:24:48 kernel: ? _raw_spin_unlock (./arch/x86/include/asm/paravirt.h:589 ./arch/x86/include/asm/qspinlock.h:57 ./include/linux/spinlock.h:204 ./include/linux/spinlock_api_smp.h:142 kernel/locking/spinlock.c:186) 
Dec  3 22:24:48 kernel: ? do_wp_page (./include/linux/vmstat.h:75 mm/memory.c:3263 mm/memory.c:3731) 
Dec  3 22:24:48 kernel: ? __handle_mm_fault (mm/memory.c:5909) 
Dec  3 22:24:48 kernel: ? syscall_exit_work (./include/linux/audit.h:357 kernel/entry/common.c:166) 
Dec  3 22:24:48 kernel: ? __count_memcg_events (mm/memcontrol.c:573 mm/memcontrol.c:836) 
Dec  3 22:24:48 kernel: ? handle_mm_fault (mm/memory.c:5951 mm/memory.c:6103) 
Dec  3 22:24:48 kernel: ? do_user_addr_fault (./include/linux/mm.h:730 arch/x86/mm/fault.c:1340) 
Dec  3 22:24:48 kernel: ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
Dec  3 22:24:48 kernel: ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
Dec  3 22:24:48 kernel: ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
Dec  3 22:24:48 kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
Dec  3 22:24:48 kernel: RIP: 0033:0x7f8537cfd70b
Dec  3 22:24:48 kernel: RSP: 002b:00007fff841fec70 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
Dec  3 22:24:48 kernel: RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f8537cfd70b
Dec  3 22:24:48 kernel: RDX: 0000000000080241 RSI: 00007f853707d290 RDI: 00000000ffffff9c
Dec  3 22:24:48 kernel: RBP: 00007f853707d290 R08: 0000000000000000 R09: 0000000000000000
Dec  3 22:24:48 kernel: R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000080241
Dec  3 22:24:48 kernel: R13: 00007f85371b4ea0 R14: 0000000000080241 R15: 0000000000000000
Dec  3 22:24:48 kernel: </TASK>
Dec  3 22:24:48 kernel: INFO: task ovs-monitor-ips:3480383 blocked for more than 122 seconds.
Dec  3 22:24:48 kernel:      Tainted: G        W          6.12.0+ #77
Dec  3 22:24:48 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  3 22:24:48 kernel: task:ovs-monitor-ips state:D stack:0     pid:3480383 tgid:3480383 ppid:1      flags:0x00000002
Dec  3 22:24:48 kernel: Call Trace:
Dec  3 22:24:48 kernel: <TASK>
Dec  3 22:24:48 kernel: __schedule (kernel/sched/core.c:5328 kernel/sched/core.c:6693) 
Dec  3 22:24:48 kernel: schedule (./arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6771 kernel/sched/core.c:6785) 
Dec  3 22:24:48 kernel: io_schedule (kernel/sched/core.c:7552 kernel/sched/core.c:7578) 
Dec  3 22:24:48 kernel: folio_wait_bit_common (mm/filemap.c:1301) 
Dec  3 22:24:48 kernel: ? xas_load (./include/linux/xarray.h:175 ./include/linux/xarray.h:1264 lib/xarray.c:240) 
Dec  3 22:24:48 kernel: ? __pfx_wake_page_function (mm/filemap.c:1117) 
Dec  3 22:24:48 kernel: folio_wait_writeback (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/page-flags.h:555 mm/page-writeback.c:3187) 
Dec  3 22:24:48 kernel: truncate_inode_partial_folio (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/page-flags.h:822 ./include/linux/page-flags.h:843 ./include/linux/mm.h:1115 ./include/linux/mm.h:2137 mm/truncate.c:209) 
Dec  3 22:24:48 kernel: truncate_inode_pages_range (mm/truncate.c:354) 
Dec  3 22:24:48 kernel: ? __pfx_pollwake (fs/select.c:209) 
Dec  3 22:24:48 kernel: ? arch_stack_walk (arch/x86/kernel/stacktrace.c:24) 
Dec  3 22:24:48 kernel: ? __is_insn_slot_addr (kernel/kprobes.c:299) 
Dec  3 22:24:48 kernel: ? is_bpf_text_address (kernel/bpf/core.c:768) 
Dec  3 22:24:48 kernel: ? kernel_text_address (kernel/extable.c:97 kernel/extable.c:94) 
Dec  3 22:24:48 kernel: ? __kernel_text_address (kernel/extable.c:79) 
Dec  3 22:24:48 kernel: ? unwind_get_return_address (arch/x86/kernel/unwind_orc.c:369 arch/x86/kernel/unwind_orc.c:364) 
Dec  3 22:24:48 kernel: ? __pfx_stack_trace_consume_entry (kernel/stacktrace.c:83) 
Dec  3 22:24:48 kernel: ? arch_stack_walk (arch/x86/kernel/stacktrace.c:26) 
Dec  3 22:24:48 kernel: ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
Dec  3 22:24:48 kernel: ? local_clock_noinstr (kernel/sched/clock.c:301) 
Dec  3 22:24:48 kernel: ? local_clock (./arch/x86/include/asm/preempt.h:94 kernel/sched/clock.c:316) 
Dec  3 22:24:48 kernel: ? metadata_update_state (mm/kfence/core.c:313) 
Dec  3 22:24:48 kernel: ? inode_init_once (fs/inode.c:405 fs/inode.c:431) 
Dec  3 22:24:48 kernel: ? kfence_guarded_alloc (mm/kfence/core.c:502) 
Dec  3 22:24:48 kernel: ? sock_alloc_inode (net/socket.c:307) 
Dec  3 22:24:48 kernel: ? __kfence_alloc (mm/kfence/core.c:1136) 
Dec  3 22:24:48 kernel: ? __kfence_alloc (mm/kfence/core.c:209 mm/kfence/core.c:1130) 
Dec  3 22:24:48 kernel: ? kmem_cache_alloc_lru_noprof (mm/slub.c:4119 mm/slub.c:4153) 
Dec  3 22:24:48 kernel: ? sock_alloc_inode (net/socket.c:307) 
Dec  3 22:24:48 kernel: ? down_read (./arch/x86/include/asm/preempt.h:79 kernel/locking/rwsem.c:1246 kernel/locking/rwsem.c:1261 kernel/locking/rwsem.c:1526) 
Dec  3 22:24:48 kernel: ? unmap_mapping_range (mm/memory.c:3873) 
Dec  3 22:24:48 kernel: truncate_pagecache (mm/truncate.c:728) 
Dec  3 22:24:48 kernel: xfs_setattr_size+0x139/0x410 xfs
Dec  3 22:24:48 kernel: xfs_vn_setattr+0x78/0x140 xfs
Dec  3 22:24:48 kernel: notify_change (fs/attr.c:503) 
Dec  3 22:24:48 kernel: ? do_truncate (./include/linux/fs.h:820 fs/open.c:66) 
Dec  3 22:24:48 kernel: do_truncate (./include/linux/fs.h:820 fs/open.c:66) 
Dec  3 22:24:48 kernel: do_open (fs/namei.c:3395 fs/namei.c:3778) 
Dec  3 22:24:48 kernel: path_openat (fs/namei.c:3933) 
Dec  3 22:24:48 kernel: do_filp_open (fs/namei.c:3960) 
Dec  3 22:24:48 kernel: ? __pfx_unix_stream_read_actor (net/unix/af_unix.c:2957) 
Dec  3 22:24:48 kernel: ? sock_recvmsg (net/socket.c:1051 net/socket.c:1073) 
Dec  3 22:24:48 kernel: ? kmem_cache_alloc_noprof (mm/slub.c:4115 mm/slub.c:4141) 
Dec  3 22:24:48 kernel: do_sys_openat2 (fs/open.c:1415) 
Dec  3 22:24:48 kernel: __x64_sys_openat (fs/open.c:1441) 
Dec  3 22:24:48 kernel: do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
Dec  3 22:24:48 kernel: ? syscall_exit_work (./include/linux/audit.h:357 kernel/entry/common.c:166) 
Dec  3 22:24:48 kernel: ? syscall_exit_to_user_mode (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/include/asm/irqflags.h:92 ./include/linux/entry-common.h:231 kernel/entry/common.c:206 kernel/entry/common.c:218) 
Dec  3 22:24:48 kernel: ? do_syscall_64 (arch/x86/entry/common.c:102) 
Dec  3 22:24:48 kernel: ? rseq_ip_fixup (kernel/rseq.c:257 kernel/rseq.c:291) 
Dec  3 22:24:48 kernel: ? ktime_get_ts64 (kernel/time/timekeeping.c:195 (discriminator 3) kernel/time/timekeeping.c:395 (discriminator 3) kernel/time/timekeeping.c:403 (discriminator 3) kernel/time/timekeeping.c:983 (discriminator 3)) 
Dec  3 22:24:48 kernel: ? switch_fpu_return (arch/x86/kernel/fpu/context.h:49 arch/x86/kernel/fpu/context.h:76 arch/x86/kernel/fpu/core.c:787) 
Dec  3 22:24:48 kernel: ? syscall_exit_to_user_mode (./arch/x86/include/asm/entry-common.h:58 ./arch/x86/include/asm/entry-common.h:65 ./include/linux/entry-common.h:330 kernel/entry/common.c:207 kernel/entry/common.c:218) 
Dec  3 22:24:48 kernel: ? __pte_offset_map (./include/linux/pgtable.h:324 ./include/linux/pgtable.h:594 mm/pgtable-generic.c:289) 
Dec  3 22:24:48 kernel: ? _raw_spin_unlock (./arch/x86/include/asm/paravirt.h:589 ./arch/x86/include/asm/qspinlock.h:57 ./include/linux/spinlock.h:204 ./include/linux/spinlock_api_smp.h:142 kernel/locking/spinlock.c:186) 
Dec  3 22:24:48 kernel: ? do_wp_page (./include/linux/vmstat.h:75 mm/memory.c:3263 mm/memory.c:3731) 
Dec  3 22:24:48 kernel: ? __handle_mm_fault (mm/memory.c:5909) 
Dec  3 22:24:48 kernel: ? __count_memcg_events (mm/memcontrol.c:573 mm/memcontrol.c:836) 
Dec  3 22:24:48 kernel: ? handle_mm_fault (mm/memory.c:5951 mm/memory.c:6103) 
Dec  3 22:24:48 kernel: ? do_user_addr_fault (./include/linux/mm.h:730 arch/x86/mm/fault.c:1340) 
Dec  3 22:24:48 kernel: ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
Dec  3 22:24:48 kernel: ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
Dec  3 22:24:48 kernel: ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
Dec  3 22:24:48 kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
Dec  3 22:24:48 kernel: RIP: 0033:0x7f85c7afd70b
Dec  3 22:24:48 kernel: RSP: 002b:00007ffe53f6c870 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
Dec  3 22:24:48 kernel: RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f85c7afd70b
Dec  3 22:24:48 kernel: RDX: 0000000000080241 RSI: 00007f85c6d74290 RDI: 00000000ffffff9c
Dec  3 22:24:48 kernel: RBP: 00007f85c6d74290 R08: 0000000000000000 R09: 0000000000000000
Dec  3 22:24:48 kernel: R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000080241
Dec  3 22:24:48 kernel: R13: 00007f85c6e01ea0 R14: 0000000000080241 R15: 0000000000000000
Dec  3 22:24:48 kernel: </TASK>
Dec  3 22:24:48 kernel: INFO: task ovs-monitor-ips:3481787 blocked for more than 122 seconds.
Dec  3 22:24:48 kernel:      Tainted: G        W          6.12.0+ #77
Dec  3 22:24:48 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  3 22:24:48 kernel: task:ovs-monitor-ips state:D stack:0     pid:3481787 tgid:3481787 ppid:1      flags:0x00000002
Dec  3 22:24:48 kernel: Call Trace:
Dec  3 22:24:48 kernel: <TASK>
Dec  3 22:24:48 kernel: __schedule (kernel/sched/core.c:5328 kernel/sched/core.c:6693) 
Dec  3 22:24:48 kernel: schedule (./arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6771 kernel/sched/core.c:6785) 
Dec  3 22:24:48 kernel: io_schedule (kernel/sched/core.c:7552 kernel/sched/core.c:7578) 
Dec  3 22:24:48 kernel: folio_wait_bit_common (mm/filemap.c:1301) 
Dec  3 22:24:48 kernel: ? xas_load (./include/linux/xarray.h:175 ./include/linux/xarray.h:1264 lib/xarray.c:240) 
Dec  3 22:24:48 kernel: ? __pfx_wake_page_function (mm/filemap.c:1117) 
Dec  3 22:24:48 kernel: folio_wait_writeback (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/page-flags.h:555 mm/page-writeback.c:3187) 
Dec  3 22:24:48 kernel: truncate_inode_partial_folio (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/page-flags.h:822 ./include/linux/page-flags.h:843 ./include/linux/mm.h:1115 ./include/linux/mm.h:2137 mm/truncate.c:209) 
Dec  3 22:24:48 kernel: truncate_inode_pages_range (mm/truncate.c:354) 
Dec  3 22:24:48 kernel: ? sock_alloc_inode (net/socket.c:307) 
Dec  3 22:24:48 kernel: ? __kfence_alloc (mm/kfence/core.c:1136) 
Dec  3 22:24:48 kernel: ? __kfence_alloc (mm/kfence/core.c:209 mm/kfence/core.c:1130) 
Dec  3 22:24:48 kernel: ? kmem_cache_alloc_lru_noprof (mm/slub.c:4119 mm/slub.c:4153) 
Dec  3 22:24:48 kernel: ? sock_alloc_inode (net/socket.c:307) 
Dec  3 22:24:48 kernel: ? alloc_inode (fs/inode.c:265) 
Dec  3 22:24:48 kernel: ? sock_alloc (net/socket.c:634) 
Dec  3 22:24:48 kernel: ? do_accept (net/socket.c:1929) 
Dec  3 22:24:48 kernel: ? __sys_accept4 (net/socket.c:1992 net/socket.c:2022) 
Dec  3 22:24:48 kernel: ? __x64_sys_accept4 (net/socket.c:2033 net/socket.c:2030 net/socket.c:2030) 
Dec  3 22:24:48 kernel: ? do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
Dec  3 22:24:48 kernel: ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
Dec  3 22:24:48 kernel: ? __pfx_pollwake (fs/select.c:209) 
Dec  3 22:24:48 kernel: ? xas_load (./include/linux/xarray.h:175 ./include/linux/xarray.h:1264 lib/xarray.c:240) 
Dec  3 22:24:48 kernel: ? xfrm_state_mtu (net/xfrm/xfrm_state.c:2842 net/xfrm/xfrm_state.c:2824) 
Dec  3 22:24:48 kernel: ? memcg_list_lru_alloc (mm/list_lru.c:475 mm/list_lru.c:489) 
Dec  3 22:24:48 kernel: ? down_read (./arch/x86/include/asm/preempt.h:79 kernel/locking/rwsem.c:1246 kernel/locking/rwsem.c:1261 kernel/locking/rwsem.c:1526) 
Dec  3 22:24:48 kernel: ? unmap_mapping_range (mm/memory.c:3873) 
Dec  3 22:24:48 kernel: truncate_pagecache (mm/truncate.c:728) 
Dec  3 22:24:48 kernel: xfs_setattr_size+0x139/0x410 xfs
Dec  3 22:24:48 kernel: xfs_vn_setattr+0x78/0x140 xfs
Dec  3 22:24:48 kernel: notify_change (fs/attr.c:503) 
Dec  3 22:24:48 kernel: ? do_truncate (./include/linux/fs.h:820 fs/open.c:66) 
Dec  3 22:24:48 kernel: do_truncate (./include/linux/fs.h:820 fs/open.c:66) 
Dec  3 22:24:48 kernel: do_open (fs/namei.c:3395 fs/namei.c:3778) 
Dec  3 22:24:48 kernel: path_openat (fs/namei.c:3933) 
Dec  3 22:24:48 kernel: do_filp_open (fs/namei.c:3960) 
Dec  3 22:24:48 kernel: ? do_wp_page (./include/linux/vmstat.h:75 mm/memory.c:3263 mm/memory.c:3731) 
Dec  3 22:24:48 kernel: ? __handle_mm_fault (mm/memory.c:5909) 
Dec  3 22:24:48 kernel: ? kmem_cache_alloc_noprof (mm/slub.c:4115 mm/slub.c:4141) 
Dec  3 22:24:48 kernel: do_sys_openat2 (fs/open.c:1415) 
Dec  3 22:24:48 kernel: __x64_sys_openat (fs/open.c:1441) 
Dec  3 22:24:48 kernel: do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
Dec  3 22:24:48 kernel: ? do_user_addr_fault (./include/linux/mm.h:730 arch/x86/mm/fault.c:1340) 
Dec  3 22:24:48 kernel: ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
Dec  3 22:24:48 kernel: ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
Dec  3 22:24:48 kernel: ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
Dec  3 22:24:48 kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
Dec  3 22:24:48 kernel: RIP: 0033:0x7f79468fd70b
Dec  3 22:24:48 kernel: RSP: 002b:00007ffd27a6c700 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
Dec  3 22:24:48 kernel: RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f79468fd70b
Dec  3 22:24:48 kernel: RDX: 0000000000080241 RSI: 00007f7945b64290 RDI: 00000000ffffff9c
Dec  3 22:24:48 kernel: RBP: 00007f7945b64290 R08: 0000000000000000 R09: 0000000000000000
Dec  3 22:24:48 kernel: R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000080241
Dec  3 22:24:48 kernel: R13: 00007f7945bf2ea0 R14: 0000000000080241 R15: 0000000000000000
Dec  3 22:24:48 kernel: </TASK>
Dec  3 22:24:48 kernel: INFO: task ovs-monitor-ips:3482631 blocked for more than 122 seconds.
Dec  3 22:24:48 kernel:      Tainted: G        W          6.12.0+ #77
Dec  3 22:24:48 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  3 22:24:48 kernel: task:ovs-monitor-ips state:D stack:0     pid:3482631 tgid:3482631 ppid:1      flags:0x00000002
Dec  3 22:24:48 kernel: Call Trace:
Dec  3 22:24:48 kernel: <TASK>
Dec  3 22:24:48 kernel: __schedule (kernel/sched/core.c:5328 kernel/sched/core.c:6693) 
Dec  3 22:24:48 kernel: schedule (./arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6771 kernel/sched/core.c:6785) 
Dec  3 22:24:48 kernel: io_schedule (kernel/sched/core.c:7552 kernel/sched/core.c:7578) 
Dec  3 22:24:48 kernel: folio_wait_bit_common (mm/filemap.c:1301) 
Dec  3 22:24:48 kernel: ? xas_load (./include/linux/xarray.h:175 ./include/linux/xarray.h:1264 lib/xarray.c:240) 
Dec  3 22:24:48 kernel: ? __pfx_wake_page_function (mm/filemap.c:1117) 
Dec  3 22:24:48 kernel: folio_wait_writeback (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/page-flags.h:555 mm/page-writeback.c:3187) 
Dec  3 22:24:48 kernel: truncate_inode_partial_folio (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/page-flags.h:822 ./include/linux/page-flags.h:843 ./include/linux/mm.h:1115 ./include/linux/mm.h:2137 mm/truncate.c:209) 
Dec  3 22:24:48 kernel: truncate_inode_pages_range (mm/truncate.c:354) 
Dec  3 22:24:48 kernel: ? _raw_spin_unlock (./arch/x86/include/asm/paravirt.h:589 ./arch/x86/include/asm/qspinlock.h:57 ./include/linux/spinlock.h:204 ./include/linux/spinlock_api_smp.h:142 kernel/locking/spinlock.c:186) 
Dec  3 22:24:48 kernel: ? finish_task_switch.isra.0 (./arch/x86/include/asm/irqflags.h:42 ./arch/x86/include/asm/irqflags.h:97 kernel/sched/sched.h:1518 kernel/sched/core.c:5082 kernel/sched/core.c:5200) 
Dec  3 22:24:48 kernel: ? __schedule (kernel/sched/core.c:6699) 
Dec  3 22:24:48 kernel: ? xfrm_state_mtu (net/xfrm/xfrm_state.c:2842 net/xfrm/xfrm_state.c:2824) 
Dec  3 22:24:48 kernel: ? schedule_hrtimeout_range_clock (kernel/time/hrtimer.c:1332 kernel/time/hrtimer.c:1449 kernel/time/hrtimer.c:2283) 
Dec  3 22:24:48 kernel: ? remove_wait_queue (./include/linux/list.h:215 ./include/linux/list.h:229 ./include/linux/wait.h:207 kernel/sched/wait.c:55) 
Dec  3 22:24:48 kernel: ? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/paravirt.h:589 ./arch/x86/include/asm/qspinlock.h:57 ./include/linux/spinlock.h:204 ./include/linux/spinlock_api_smp.h:150 kernel/locking/spinlock.c:194) 
Dec  3 22:24:48 kernel: ? poll_freewait (fs/select.c:140 (discriminator 3)) 
Dec  3 22:24:48 kernel: ? do_select (fs/select.c:612) 
Dec  3 22:24:48 kernel: ? down_read (./arch/x86/include/asm/preempt.h:79 kernel/locking/rwsem.c:1246 kernel/locking/rwsem.c:1261 kernel/locking/rwsem.c:1526) 
Dec  3 22:24:48 kernel: ? unmap_mapping_range (mm/memory.c:3873) 
Dec  3 22:24:48 kernel: truncate_pagecache (mm/truncate.c:728) 
Dec  3 22:24:48 kernel: xfs_setattr_size+0x139/0x410 xfs
Dec  3 22:24:48 kernel: xfs_vn_setattr+0x78/0x140 xfs
Dec  3 22:24:48 kernel: notify_change (fs/attr.c:503) 
Dec  3 22:24:48 kernel: ? do_truncate (./include/linux/fs.h:820 fs/open.c:66) 
Dec  3 22:24:48 kernel: do_truncate (./include/linux/fs.h:820 fs/open.c:66) 
Dec  3 22:24:48 kernel: do_open (fs/namei.c:3395 fs/namei.c:3778) 
Dec  3 22:24:48 kernel: path_openat (fs/namei.c:3933) 
Dec  3 22:24:48 kernel: do_filp_open (fs/namei.c:3960) 
Dec  3 22:24:48 kernel: ? unix_stream_recvmsg (net/unix/af_unix.c:2997) 
Dec  3 22:24:48 kernel: ? __pfx_unix_stream_read_actor (net/unix/af_unix.c:2957) 
Dec  3 22:24:48 kernel: ? kmem_cache_alloc_noprof (mm/slub.c:4115 mm/slub.c:4141) 
Dec  3 22:24:48 kernel: do_sys_openat2 (fs/open.c:1415) 
Dec  3 22:24:48 kernel: __x64_sys_openat (fs/open.c:1441) 
Dec  3 22:24:48 kernel: do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
Dec  3 22:24:48 kernel: ? syscall_exit_work (./include/linux/audit.h:357 kernel/entry/common.c:166) 
Dec  3 22:24:48 kernel: ? syscall_exit_to_user_mode (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/include/asm/irqflags.h:92 ./include/linux/entry-common.h:231 kernel/entry/common.c:206 kernel/entry/common.c:218) 
Dec  3 22:24:48 kernel: ? do_syscall_64 (arch/x86/entry/common.c:102) 
Dec  3 22:24:48 kernel: ? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/paravirt.h:589 ./arch/x86/include/asm/qspinlock.h:57 ./include/linux/spinlock.h:204 ./include/linux/spinlock_api_smp.h:150 kernel/locking/spinlock.c:194) 
Dec  3 22:24:48 kernel: ? __skb_try_recv_datagram (net/core/datagram.c:267) 
Dec  3 22:24:48 kernel: ? __skb_recv_datagram (net/core/datagram.c:296) 
Dec  3 22:24:48 kernel: ? __memcg_slab_free_hook (mm/memcontrol.c:3004 (discriminator 2)) 
Dec  3 22:24:48 kernel: ? __pte_offset_map (./include/linux/pgtable.h:324 ./include/linux/pgtable.h:594 mm/pgtable-generic.c:289) 
Dec  3 22:24:48 kernel: ? _raw_spin_unlock (./arch/x86/include/asm/paravirt.h:589 ./arch/x86/include/asm/qspinlock.h:57 ./include/linux/spinlock.h:204 ./include/linux/spinlock_api_smp.h:142 kernel/locking/spinlock.c:186) 
Dec  3 22:24:48 kernel: ? do_wp_page (./include/linux/vmstat.h:75 mm/memory.c:3263 mm/memory.c:3731) 
Dec  3 22:24:48 kernel: ? __handle_mm_fault (mm/memory.c:5909) 
Dec  3 22:24:48 kernel: ? __count_memcg_events (mm/memcontrol.c:573 mm/memcontrol.c:836) 
Dec  3 22:24:48 kernel: ? handle_mm_fault (mm/memory.c:5951 mm/memory.c:6103) 
Dec  3 22:24:48 kernel: ? do_user_addr_fault (./include/linux/mm.h:730 arch/x86/mm/fault.c:1340) 
Dec  3 22:24:48 kernel: ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
Dec  3 22:24:48 kernel: ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
Dec  3 22:24:48 kernel: ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
Dec  3 22:24:48 kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
Dec  3 22:24:48 kernel: RIP: 0033:0x7f10818fd70b
Dec  3 22:24:48 kernel: RSP: 002b:00007fff83e83f80 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
Dec  3 22:24:48 kernel: RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f10818fd70b
Dec  3 22:24:48 kernel: RDX: 0000000000080241 RSI: 00007f1080d5a8a0 RDI: 00000000ffffff9c
Dec  3 22:24:48 kernel: RBP: 00007f1080d5a8a0 R08: 0000000000000000 R09: 0000000000000000
Dec  3 22:24:48 kernel: R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000080241
Dec  3 22:24:48 kernel: R13: 00007f1080d50bb0 R14: 0000000000080241 R15: 0000000000000000
Dec  3 22:24:48 kernel: </TASK>
Dec  3 22:24:48 kernel: INFO: task mv:3483072 blocked for more than 245 seconds.
Dec  3 22:24:48 kernel:      Tainted: G        W          6.12.0+ #77
Dec  3 22:24:48 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  3 22:24:48 kernel: task:mv              state:D stack:0     pid:3483072 tgid:3483072 ppid:3479428 flags:0x00000002
Dec  3 22:24:48 kernel: Call Trace:
Dec  3 22:24:48 kernel: <TASK>
Dec  3 22:24:48 kernel: __schedule (kernel/sched/core.c:5328 kernel/sched/core.c:6693) 
Dec  3 22:24:48 kernel: schedule (./arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6771 kernel/sched/core.c:6785) 
Dec  3 22:24:48 kernel: io_schedule (kernel/sched/core.c:7552 kernel/sched/core.c:7578) 
Dec  3 22:24:48 kernel: folio_wait_bit_common (mm/filemap.c:1301) 
Dec  3 22:24:48 kernel: ? xas_load (./include/linux/xarray.h:175 ./include/linux/xarray.h:1264 lib/xarray.c:240) 
Dec  3 22:24:48 kernel: ? __pfx_wake_page_function (mm/filemap.c:1117) 
Dec  3 22:24:48 kernel: folio_wait_writeback (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/page-flags.h:555 mm/page-writeback.c:3187) 
Dec  3 22:24:48 kernel: truncate_inode_partial_folio (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/page-flags.h:822 ./include/linux/page-flags.h:843 ./include/linux/mm.h:1115 ./include/linux/mm.h:2137 mm/truncate.c:209) 
Dec  3 22:24:48 kernel: truncate_inode_pages_range (mm/truncate.c:354) 
Dec  3 22:24:48 kernel: ? xfs_iunlock+0x108/0x200 xfs
Dec  3 22:24:48 kernel: ? xfs_rename+0x368/0x990 xfs
Dec  3 22:24:48 kernel: ? fsnotify_move (./include/linux/fsnotify.h:72 ./include/linux/fsnotify.h:64 ./include/linux/fsnotify.h:238) 
Dec  3 22:24:48 kernel: ? _raw_spin_unlock (./arch/x86/include/asm/paravirt.h:589 ./arch/x86/include/asm/qspinlock.h:57 ./include/linux/spinlock.h:204 ./include/linux/spinlock_api_smp.h:142 kernel/locking/spinlock.c:186) 
Dec  3 22:24:48 kernel: ? locked_inode_to_wb_and_lock_list (fs/fs-writeback.c:355) 
Dec  3 22:24:48 kernel: evict (fs/inode.c:728) 
Dec  3 22:24:48 kernel: ? fsnotify_destroy_marks (fs/notify/mark.c:923) 
Dec  3 22:24:48 kernel: ? _atomic_dec_and_lock (./arch/x86/include/asm/atomic.h:67 ./include/linux/atomic/atomic-arch-fallback.h:2278 ./include/linux/atomic/atomic-instrumented.h:1384 lib/dec_and_lock.c:29) 
Dec  3 22:24:48 kernel: __dentry_kill (fs/dcache.c:618) 
Dec  3 22:24:48 kernel: dput (fs/dcache.c:857 fs/dcache.c:845) 
Dec  3 22:24:48 kernel: do_renameat2 (fs/namei.c:5174) 
Dec  3 22:24:48 kernel: __x64_sys_rename (fs/namei.c:5215) 
Dec  3 22:24:48 kernel: do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
Dec  3 22:24:48 kernel: ? do_user_addr_fault (./include/linux/mm.h:730 arch/x86/mm/fault.c:1340) 
Dec  3 22:24:48 kernel: ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
Dec  3 22:24:48 kernel: ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
Dec  3 22:24:48 kernel: ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
Dec  3 22:24:48 kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
Dec  3 22:24:48 kernel: RIP: 0033:0x7f3185a5aadb
Dec  3 22:24:48 kernel: RSP: 002b:00007ffe258c4548 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
Dec  3 22:24:48 kernel: RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f3185a5aadb
Dec  3 22:24:48 kernel: RDX: 0000000000000025 RSI: 00007ffe258c5cc3 RDI: 00007ffe258c5cb7
Dec  3 22:24:48 kernel: RBP: 00007ffe258c48f0 R08: 00007ffe258c4670 R09: 00007ffe258c4ac0
Dec  3 22:24:48 kernel: R10: 0000000000000100 R11: 0000000000000246 R12: 0000000000000011
Dec  3 22:24:48 kernel: R13: 0000000000000000 R14: 00007ffe258c5cc3 R15: 00007ffe258c4ac0
Dec  3 22:24:48 kernel: </TASK>
Dec  3 22:26:51 kernel: INFO: task khugepaged:330 blocked for more than 368 seconds.
Dec  3 22:26:51 kernel:      Tainted: G        W          6.12.0+ #77
Dec  3 22:26:51 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  3 22:26:51 kernel: task:khugepaged      state:D stack:0     pid:330   tgid:330   ppid:2      flags:0x00004000
Dec  3 22:26:51 kernel: Call Trace:
Dec  3 22:26:51 kernel: <TASK>
Dec  3 22:26:51 kernel: __schedule (kernel/sched/core.c:5328 kernel/sched/core.c:6693) 
Dec  3 22:26:51 kernel: schedule (./arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6771 kernel/sched/core.c:6785) 
Dec  3 22:26:51 kernel: schedule_timeout (kernel/time/timer.c:2592) 
Dec  3 22:26:51 kernel: ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
Dec  3 22:26:51 kernel: ? sched_clock (./arch/x86/include/asm/preempt.h:94 arch/x86/kernel/tsc.c:285) 
Dec  3 22:26:51 kernel: ? sched_clock_cpu (kernel/sched/clock.c:394) 
Dec  3 22:26:51 kernel: ? __smp_call_single_queue (kernel/smp.c:115 kernel/smp.c:411) 
Dec  3 22:26:51 kernel: __wait_for_common (kernel/sched/completion.c:95 kernel/sched/completion.c:116) 
Dec  3 22:26:51 kernel: ? __pfx_schedule_timeout (kernel/time/timer.c:2577) 
Dec  3 22:26:51 kernel: __flush_work (kernel/workqueue.c:4222) 
Dec  3 22:26:51 kernel: ? __pfx_wq_barrier_func (kernel/workqueue.c:3718) 
Dec  3 22:26:51 kernel: __lru_add_drain_all (mm/swap.c:873 (discriminator 3)) 
Dec  3 22:26:51 kernel: khugepaged (mm/khugepaged.c:2499 mm/khugepaged.c:2571) 
Dec  3 22:26:51 kernel: ? __pfx_khugepaged (mm/khugepaged.c:2564) 
Dec  3 22:26:51 kernel: kthread (kernel/kthread.c:389) 
Dec  3 22:26:51 kernel: ? __pfx_kthread (kernel/kthread.c:342) 
Dec  3 22:26:51 kernel: ret_from_fork (arch/x86/kernel/process.c:147) 
Dec  3 22:26:51 kernel: ? __pfx_kthread (kernel/kthread.c:342) 
Dec  3 22:26:51 kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Dec  3 22:26:51 kernel: </TASK>
Dec  3 22:26:51 kernel: Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings


Still blocked after many hours:

Dec  4 06:11:45 kernel: INFO: task khugepaged:330 blocked for more than 28262 seconds.
Dec  4 06:11:45 kernel:      Tainted: G        W          6.12.0+ #77
Dec  4 06:11:45 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  4 06:11:45 kernel: task:khugepaged      state:D stack:0     pid:330   tgid:330   ppid:2      flags:0x00004000
Dec  4 06:11:45 kernel: Call Trace:
Dec  4 06:11:45 kernel: <TASK>
Dec  4 06:11:45 kernel: __schedule (kernel/sched/core.c:5328 kernel/sched/core.c:6693) 
Dec  4 06:11:45 kernel: schedule (./arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6771 kernel/sched/core.c:6785) 
Dec  4 06:11:45 kernel: schedule_timeout (kernel/time/timer.c:2592) 
Dec  4 06:11:45 kernel: ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
Dec  4 06:11:45 kernel: ? sched_clock (./arch/x86/include/asm/preempt.h:94 arch/x86/kernel/tsc.c:285) 
Dec  4 06:11:45 kernel: ? sched_clock_cpu (kernel/sched/clock.c:394) 
Dec  4 06:11:45 kernel: ? __smp_call_single_queue (kernel/smp.c:115 kernel/smp.c:411) 
Dec  4 06:11:45 kernel: __wait_for_common (kernel/sched/completion.c:95 kernel/sched/completion.c:116) 
Dec  4 06:11:45 kernel: ? __pfx_schedule_timeout (kernel/time/timer.c:2577) 
Dec  4 06:11:45 kernel: __flush_work (kernel/workqueue.c:4222) 
Dec  4 06:11:45 kernel: ? __pfx_wq_barrier_func (kernel/workqueue.c:3718) 
Dec  4 06:11:45 kernel: __lru_add_drain_all (mm/swap.c:873 (discriminator 3)) 
Dec  4 06:11:45 kernel: khugepaged (mm/khugepaged.c:2499 mm/khugepaged.c:2571) 
Dec  4 06:11:45 kernel: ? __pfx_khugepaged (mm/khugepaged.c:2564) 
Dec  4 06:11:45 kernel: kthread (kernel/kthread.c:389) 
Dec  4 06:11:45 kernel: ? __pfx_kthread (kernel/kthread.c:342) 
Dec  4 06:11:45 kernel: ret_from_fork (arch/x86/kernel/process.c:147) 
Dec  4 06:11:45 kernel: ? __pfx_kthread (kernel/kthread.c:342) 
Dec  4 06:11:45 kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Dec  4 06:11:45 kernel: </TASK>
Dec  4 06:11:45 kernel: Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings


The system is actually idle:

Dec  4 06:27:07 kernel: sysrq: Show backtrace of all active CPUs
Dec  4 06:27:07 kernel: NMI backtrace for cpu 30
Dec  4 06:27:07 kernel: CPU: 30 UID: 0 PID: 10810 Comm: bash Kdump: loaded Tainted: G        W          6.12.0+ #77
Dec  4 06:27:07 kernel: Tainted: [W]=WARN
Dec  4 06:27:07 kernel: Hardware name: Red Hat KVM/RHEL, BIOS 1.16.1-1.el9 04/01/2014
Dec  4 06:27:07 kernel: Call Trace:
Dec  4 06:27:07 kernel: <TASK>
Dec  4 06:27:07 kernel: dump_stack_lvl (lib/dump_stack.c:123) 
Dec  4 06:27:07 kernel: nmi_cpu_backtrace (lib/nmi_backtrace.c:113) 
Dec  4 06:27:07 kernel: ? __pfx_nmi_raise_cpu_backtrace (arch/x86/kernel/apic/hw_nmi.c:35) 
Dec  4 06:27:07 kernel: nmi_trigger_cpumask_backtrace (lib/nmi_backtrace.c:62) 
Dec  4 06:27:07 kernel: __handle_sysrq (drivers/tty/sysrq.c:613) 
Dec  4 06:27:07 kernel: write_sysrq_trigger (drivers/tty/sysrq.c:1184) 
Dec  4 06:27:07 kernel: proc_reg_write (fs/proc/inode.c:330 fs/proc/inode.c:342) 
Dec  4 06:27:07 kernel: vfs_write (fs/read_write.c:681) 
Dec  4 06:27:07 kernel: ? do_fcntl (fs/fcntl.c:463) 
Dec  4 06:27:07 kernel: ksys_write (fs/read_write.c:736) 
Dec  4 06:27:07 kernel: do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
Dec  4 06:27:07 kernel: ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
Dec  4 06:27:07 kernel: ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
Dec  4 06:27:07 kernel: ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
Dec  4 06:27:07 kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
Dec  4 06:27:07 kernel: RIP: 0033:0x7fb77cefda57
Dec  4 06:27:07 kernel: </TASK>
Dec  4 06:27:07 kernel: Sending NMI from CPU 30 to CPUs 0-29,31-39:
Dec  4 06:27:07 kernel: NMI backtrace for cpu 12 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 6 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 16 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 4 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 20 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 10 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 33 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 18 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 1 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 23 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 27 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 3 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 11 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 32 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 7 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 0 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 13 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 5 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 26 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 28 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 24 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 37 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 39 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 17 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 22 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 31 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 8 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 21 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 29 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 14 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 2 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 9 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 35 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 25 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 15 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 36 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 19 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 34 skipped: idling at default_idle 
Dec  4 06:27:07 kernel: NMI backtrace for cpu 38 skipped: idling at default_idle




=====================
SECOND UNDECODED LOG:
=====================

Dec  3 01:58:46 kernel: ------------[ cut here ]------------
Dec  3 01:58:46 kernel: watchdog: BUG: soft lockup - CPU#11 stuck for 21s! [kworker/11:1:866154]
Dec  3 01:58:46 kernel: rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
Dec  3 01:58:46 kernel: rcu: #01117-...!: (0 ticks this GP) idle=b124/1/0x4000000000000000 softirq=2109356/2109356 fqs=0
Dec  3 01:58:46 kernel: rcu: #011(detected by 18, t=60004 jiffies, g=11126601, q=393720 ncpus=40)
Dec  3 01:58:46 kernel: Sending NMI from CPU 18 to CPUs 17:
Dec  3 01:58:46 kernel: rcu: rcu_preempt kthread timer wakeup didn't happen for 70001 jiffies! g11126601 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x200
Dec  3 01:58:46 kernel: rcu: #011Possible timer handling issue on cpu=17 timer-softirq=273727
Dec  3 01:58:46 kernel: rcu: rcu_preempt kthread starved for 70004 jiffies! g11126601 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x200 ->cpu=17
Dec  3 01:58:46 kernel: rcu: #011Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
Dec  3 01:58:46 kernel: rcu: RCU grace-period kthread stack dump:
Dec  3 01:58:46 kernel: task:rcu_preempt     state:R stack:0     pid:18    tgid:18    ppid:2      flags:0x00004008
Dec  3 01:58:46 kernel: Call Trace:
Dec  3 01:58:46 kernel: <TASK>
Dec  3 01:58:46 kernel: ? __pick_next_task+0x3e/0x1a0
Dec  3 01:58:46 kernel: ? __schedule+0xfe/0x620
Dec  3 01:58:46 kernel: ? _raw_spin_unlock_irqrestore+0xa/0x30
Dec  3 01:58:46 kernel: ? __pfx_rcu_gp_kthread+0x10/0x10
Dec  3 01:58:46 kernel: ? schedule+0x23/0xa0
Dec  3 01:58:46 kernel: ? schedule_timeout+0x8b/0x160
Dec  3 01:58:46 kernel: ? __pfx_process_timeout+0x10/0x10
Dec  3 01:58:46 kernel: ? rcu_gp_fqs_loop+0x10b/0x500
Dec  3 01:58:46 kernel: ? rcu_gp_kthread+0x13f/0x1d0
Dec  3 01:58:46 kernel: ? kthread+0xcc/0x100
Dec  3 01:58:46 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 01:58:46 kernel: ? ret_from_fork+0x2d/0x50
Dec  3 01:58:46 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 01:58:46 kernel: ? ret_from_fork_asm+0x1a/0x30
Dec  3 01:58:46 kernel: </TASK>
Dec  3 02:00:48 kernel: INFO: task kworker/u165:0:746685 blocked for more than 122 seconds.
Dec  3 02:00:48 kernel:      Not tainted 6.12.0 #64
Dec  3 02:00:48 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  3 02:00:48 kernel: task:kworker/u165:0  state:D stack:0     pid:746685 tgid:746685 ppid:2      flags:0x00004000
Dec  3 02:00:48 kernel: Workqueue: events_unbound linkwatch_event
Dec  3 02:00:48 kernel: Call Trace:
Dec  3 02:00:48 kernel: <TASK>
Dec  3 02:00:48 kernel: __schedule+0x23f/0x620
Dec  3 02:00:48 kernel: schedule+0x23/0xa0
Dec  3 02:00:48 kernel: schedule_preempt_disabled+0x11/0x20
Dec  3 02:00:48 kernel: __mutex_lock.constprop.0+0x31d/0x650
Dec  3 02:00:48 kernel: ? __schedule+0x247/0x620
Dec  3 02:00:48 kernel: linkwatch_event+0xa/0x30
Dec  3 02:00:48 kernel: process_one_work+0x179/0x390
Dec  3 02:00:48 kernel: worker_thread+0x239/0x340
Dec  3 02:00:48 kernel: ? __pfx_worker_thread+0x10/0x10
Dec  3 02:00:48 kernel: kthread+0xcc/0x100
Dec  3 02:00:48 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:00:48 kernel: ret_from_fork+0x2d/0x50
Dec  3 02:00:48 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:00:48 kernel: ret_from_fork_asm+0x1a/0x30
Dec  3 02:00:48 kernel: </TASK>
Dec  3 02:00:48 kernel: INFO: task kworker/5:2:900494 blocked for more than 122 seconds.
Dec  3 02:00:48 kernel:      Not tainted 6.12.0 #64
Dec  3 02:00:48 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  3 02:00:48 kernel: task:kworker/5:2     state:D stack:0     pid:900494 tgid:900494 ppid:2      flags:0x00004000
Dec  3 02:00:48 kernel: Workqueue: events xfrm_state_gc_task
Dec  3 02:00:48 kernel: Call Trace:
Dec  3 02:00:48 kernel: <TASK>
Dec  3 02:00:48 kernel: __schedule+0x23f/0x620
Dec  3 02:00:48 kernel: schedule+0x23/0xa0
Dec  3 02:00:48 kernel: schedule_timeout+0x14a/0x160
Dec  3 02:00:48 kernel: ? __hrtimer_start_range_ns+0x20b/0x2e0
Dec  3 02:00:48 kernel: ? kvm_clock_get_cycles+0x14/0x30
Dec  3 02:00:48 kernel: ? ktime_get+0x34/0xc0
Dec  3 02:00:48 kernel: ? timerqueue_del+0x2a/0x50
Dec  3 02:00:48 kernel: __wait_for_common+0x8f/0x1d0
Dec  3 02:00:48 kernel: ? __pfx_schedule_timeout+0x10/0x10
Dec  3 02:00:48 kernel: wait_for_completion_state+0x1d/0x40
Dec  3 02:00:48 kernel: __wait_rcu_gp+0x126/0x130
Dec  3 02:00:48 kernel: synchronize_rcu_normal.part.0+0x3a/0x60
Dec  3 02:00:48 kernel: ? __pfx_call_rcu_hurry+0x10/0x10
Dec  3 02:00:48 kernel: ? __pfx_wakeme_after_rcu+0x10/0x10
Dec  3 02:00:48 kernel: xfrm_state_gc_task+0x56/0xa0
Dec  3 02:00:48 kernel: process_one_work+0x179/0x390
Dec  3 02:00:48 kernel: worker_thread+0x239/0x340
Dec  3 02:00:48 kernel: ? __pfx_worker_thread+0x10/0x10
Dec  3 02:00:48 kernel: kthread+0xcc/0x100
Dec  3 02:00:48 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:00:48 kernel: ret_from_fork+0x2d/0x50
Dec  3 02:00:48 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:00:48 kernel: ret_from_fork_asm+0x1a/0x30
Dec  3 02:00:48 kernel: </TASK>
Dec  3 02:00:48 kernel: INFO: task systemd-udevd:995278 blocked for more than 122 seconds.
Dec  3 02:00:48 kernel:      Not tainted 6.12.0 #64
Dec  3 02:00:48 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  3 02:00:48 kernel: task:systemd-udevd   state:D stack:0     pid:995278 tgid:995278 ppid:1080   flags:0x00000002
Dec  3 02:00:48 kernel: Call Trace:
Dec  3 02:00:48 kernel: <TASK>
Dec  3 02:00:48 kernel: __schedule+0x23f/0x620
Dec  3 02:00:48 kernel: schedule+0x23/0xa0
Dec  3 02:00:48 kernel: netlink_table_grab.part.0+0x82/0xe0
Dec  3 02:00:48 kernel: ? __pfx_default_wake_function+0x10/0x10
Dec  3 02:00:48 kernel: netlink_release+0x36c/0x520
Dec  3 02:00:48 kernel: ? __pfx_netlink_hash+0x10/0x10
Dec  3 02:00:48 kernel: ? __pfx_netlink_compare+0x10/0x10
Dec  3 02:00:48 kernel: __sock_release+0x3a/0xc0
Dec  3 02:00:48 kernel: sock_close+0x11/0x20
Dec  3 02:00:48 kernel: __fput+0xdb/0x2a0
Dec  3 02:00:48 kernel: task_work_run+0x55/0x90
Dec  3 02:00:48 kernel: do_exit+0x279/0x4b0
Dec  3 02:00:48 kernel: do_group_exit+0x2c/0x80
Dec  3 02:00:48 kernel: __x64_sys_exit_group+0x14/0x20
Dec  3 02:00:48 kernel: x64_sys_call+0x1836/0x1840
Dec  3 02:00:48 kernel: do_syscall_64+0x79/0x150
Dec  3 02:00:48 kernel: ? __count_memcg_events+0x4f/0xe0
Dec  3 02:00:48 kernel: ? handle_mm_fault+0x18e/0x270
Dec  3 02:00:48 kernel: ? do_user_addr_fault+0x34c/0x680
Dec  3 02:00:48 kernel: ? clear_bhb_loop+0x45/0xa0
Dec  3 02:00:48 kernel: ? clear_bhb_loop+0x45/0xa0
Dec  3 02:00:48 kernel: ? clear_bhb_loop+0x45/0xa0
Dec  3 02:00:48 kernel: entry_SYSCALL_64_after_hwframe+0x76/0x7e
Dec  3 02:00:48 kernel: RIP: 0033:0x7f6cfa8d921d
Dec  3 02:00:48 kernel: RSP: 002b:00007ffd7e081b58 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
Dec  3 02:00:48 kernel: RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6cfa8d921d
Dec  3 02:00:48 kernel: RDX: 00000000000000e7 RSI: fffffffffffffe88 RDI: 0000000000000000
Dec  3 02:00:48 kernel: RBP: 00007ffd7e081c00 R08: 00005615d9e8dbb0 R09: 0000000000000004
Dec  3 02:00:48 kernel: R10: 0000000000000018 R11: 0000000000000246 R12: 00007ffd7e081bb0
Dec  3 02:00:48 kernel: R13: 00005615d9d0e8b0 R14: 00005615d9e8dbb0 R15: 0000000000000000
Dec  3 02:00:48 kernel: </TASK>
Dec  3 02:00:48 kernel: INFO: task systemd-udevd:995279 blocked for more than 122 seconds.
Dec  3 02:00:48 kernel:      Not tainted 6.12.0 #64
Dec  3 02:00:48 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  3 02:00:48 kernel: task:systemd-udevd   state:D stack:0     pid:995279 tgid:995279 ppid:1080   flags:0x00004002
Dec  3 02:00:48 kernel: Call Trace:
Dec  3 02:00:48 kernel: <TASK>
Dec  3 02:00:48 kernel: __schedule+0x23f/0x620
Dec  3 02:00:48 kernel: schedule+0x23/0xa0
Dec  3 02:00:48 kernel: netlink_table_grab.part.0+0x82/0xe0
Dec  3 02:00:48 kernel: ? __pfx_default_wake_function+0x10/0x10
Dec  3 02:00:48 kernel: netlink_release+0x36c/0x520
Dec  3 02:00:48 kernel: ? __pfx_netlink_hash+0x10/0x10
Dec  3 02:00:48 kernel: ? __pfx_netlink_compare+0x10/0x10
Dec  3 02:00:48 kernel: __sock_release+0x3a/0xc0
Dec  3 02:00:48 kernel: sock_close+0x11/0x20
Dec  3 02:00:48 kernel: __fput+0xdb/0x2a0
Dec  3 02:00:48 kernel: task_work_run+0x55/0x90
Dec  3 02:00:48 kernel: do_exit+0x279/0x4b0
Dec  3 02:00:48 kernel: do_group_exit+0x2c/0x80
Dec  3 02:00:48 kernel: __x64_sys_exit_group+0x14/0x20
Dec  3 02:00:48 kernel: x64_sys_call+0x1836/0x1840
Dec  3 02:00:48 kernel: do_syscall_64+0x79/0x150
Dec  3 02:00:48 kernel: ? get_page_from_freelist+0x333/0x630
Dec  3 02:00:48 kernel: ? __alloc_pages_noprof+0x186/0x350
Dec  3 02:00:48 kernel: ? __mod_memcg_lruvec_state+0x95/0x150
Dec  3 02:00:48 kernel: ? __lruvec_stat_mod_folio+0x80/0xd0
Dec  3 02:00:48 kernel: ? __folio_mod_stat+0x2a/0x80
Dec  3 02:00:48 kernel: ? _raw_spin_unlock+0xa/0x30
Dec  3 02:00:48 kernel: ? wp_page_copy+0x4e0/0x710
Dec  3 02:00:48 kernel: ? __pte_offset_map+0x17/0x160
Dec  3 02:00:48 kernel: ? _raw_spin_unlock+0xa/0x30
Dec  3 02:00:48 kernel: ? do_wp_page+0x666/0x760
Dec  3 02:00:48 kernel: ? __handle_mm_fault+0x326/0x730
Dec  3 02:00:48 kernel: ? __count_memcg_events+0x4f/0xe0
Dec  3 02:00:48 kernel: ? handle_mm_fault+0x18e/0x270
Dec  3 02:00:48 kernel: ? do_user_addr_fault+0x34c/0x680
Dec  3 02:00:48 kernel: ? clear_bhb_loop+0x45/0xa0
Dec  3 02:00:48 kernel: ? clear_bhb_loop+0x45/0xa0
Dec  3 02:00:48 kernel: ? clear_bhb_loop+0x45/0xa0
Dec  3 02:00:48 kernel: entry_SYSCALL_64_after_hwframe+0x76/0x7e
Dec  3 02:00:48 kernel: RIP: 0033:0x7f6cfa8d921d
Dec  3 02:00:48 kernel: RSP: 002b:00007ffd7e081b58 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
Dec  3 02:00:48 kernel: RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6cfa8d921d
Dec  3 02:00:48 kernel: RDX: 00000000000000e7 RSI: fffffffffffffe88 RDI: 0000000000000000
Dec  3 02:00:48 kernel: RBP: 00007ffd7e081c00 R08: 00005615d9e932b0 R09: 0000000000000004
Dec  3 02:00:48 kernel: R10: 0000000000000018 R11: 0000000000000246 R12: 00007ffd7e081bb0
Dec  3 02:00:48 kernel: R13: 00005615d9d0e8b0 R14: 00005615d9e932b0 R15: 0000000000000000
Dec  3 02:00:48 kernel: </TASK>
Dec  3 02:00:48 kernel: INFO: task ip:998743 blocked for more than 122 seconds.
Dec  3 02:00:48 kernel:      Not tainted 6.12.0 #64
Dec  3 02:00:48 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  3 02:00:48 kernel: task:ip              state:D stack:0     pid:998743 tgid:998743 ppid:998736 flags:0x00000002
Dec  3 02:00:48 kernel: Call Trace:
Dec  3 02:00:48 kernel: <TASK>
Dec  3 02:00:48 kernel: __schedule+0x23f/0x620
Dec  3 02:00:48 kernel: schedule+0x23/0xa0
Dec  3 02:00:48 kernel: schedule_preempt_disabled+0x11/0x20
Dec  3 02:00:48 kernel: __mutex_lock.constprop.0+0x31d/0x650
Dec  3 02:00:48 kernel: rtnetlink_rcv_msg+0x111/0x410
Dec  3 02:00:48 kernel: ? avc_has_perm_noaudit+0x67/0xf0
Dec  3 02:00:48 kernel: ? __pfx_rtnetlink_rcv_msg+0x10/0x10
Dec  3 02:00:48 kernel: netlink_rcv_skb+0x54/0x100
Dec  3 02:00:48 kernel: netlink_unicast+0x243/0x370
Dec  3 02:00:48 kernel: netlink_sendmsg+0x1f6/0x430
Dec  3 02:00:48 kernel: __sys_sendto+0x1f3/0x200
Dec  3 02:00:48 kernel: ? do_read_fault+0x10a/0x1e0
Dec  3 02:00:48 kernel: ? do_fault+0x21f/0x380
Dec  3 02:00:48 kernel: ? pte_offset_map_nolock+0x2b/0xb0
Dec  3 02:00:48 kernel: __x64_sys_sendto+0x20/0x30
Dec  3 02:00:48 kernel: do_syscall_64+0x79/0x150
Dec  3 02:00:48 kernel: ? __count_memcg_events+0x4f/0xe0
Dec  3 02:00:48 kernel: ? handle_mm_fault+0x18e/0x270
Dec  3 02:00:48 kernel: ? do_user_addr_fault+0x34c/0x680
Dec  3 02:00:48 kernel: ? clear_bhb_loop+0x45/0xa0
Dec  3 02:00:48 kernel: ? clear_bhb_loop+0x45/0xa0
Dec  3 02:00:48 kernel: ? clear_bhb_loop+0x45/0xa0
Dec  3 02:00:48 kernel: entry_SYSCALL_64_after_hwframe+0x76/0x7e
Dec  3 02:00:48 kernel: RIP: 0033:0x7f287830f860
Dec  3 02:00:48 kernel: RSP: 002b:00007ffdd4f2c518 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
Dec  3 02:00:48 kernel: RAX: ffffffffffffffda RBX: 00007ffdd4f2cc88 RCX: 00007f287830f860
Dec  3 02:00:48 kernel: RDX: 0000000000000020 RSI: 00007ffdd4f2c520 RDI: 0000000000000003
Dec  3 02:00:48 kernel: RBP: 00007ffdd4f2d7e4 R08: 0000000000000000 R09: 0000000000000000
Dec  3 02:00:48 kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
Dec  3 02:00:48 kernel: R13: 000055969d419040 R14: 00007ffdd4f2cc78 R15: 0000000000000004
Dec  3 02:00:48 kernel: </TASK>
Dec  3 02:01:56 kernel: rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
Dec  3 02:01:56 kernel: rcu: #01117-...!: (0 ticks this GP) idle=b124/1/0x4000000000000002 softirq=2109356/2109356 fqs=0
Dec  3 02:01:56 kernel: rcu: #011(detected by 8, t=250009 jiffies, g=11126601, q=1577177 ncpus=40)
Dec  3 02:01:56 kernel: Sending NMI from CPU 8 to CPUs 17:
Dec  3 02:01:56 kernel: rcu: rcu_preempt kthread timer wakeup didn't happen for 260006 jiffies! g11126601 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x200
Dec  3 02:01:56 kernel: rcu: #011Possible timer handling issue on cpu=17 timer-softirq=273727
Dec  3 02:01:56 kernel: rcu: rcu_preempt kthread starved for 260009 jiffies! g11126601 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x200 ->cpu=17
Dec  3 02:01:56 kernel: rcu: #011Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
Dec  3 02:01:56 kernel: rcu: RCU grace-period kthread stack dump:
Dec  3 02:01:56 kernel: task:rcu_preempt     state:R stack:0     pid:18    tgid:18    ppid:2      flags:0x00004008
Dec  3 02:01:56 kernel: Call Trace:
Dec  3 02:01:56 kernel: <TASK>
Dec  3 02:01:56 kernel: ? __pick_next_task+0x3e/0x1a0
Dec  3 02:01:56 kernel: ? __schedule+0xfe/0x620
Dec  3 02:01:56 kernel: ? _raw_spin_unlock_irqrestore+0xa/0x30
Dec  3 02:01:56 kernel: ? __pfx_rcu_gp_kthread+0x10/0x10
Dec  3 02:01:56 kernel: ? schedule+0x23/0xa0
Dec  3 02:01:56 kernel: ? schedule_timeout+0x8b/0x160
Dec  3 02:01:56 kernel: ? __pfx_process_timeout+0x10/0x10
Dec  3 02:01:56 kernel: ? rcu_gp_fqs_loop+0x10b/0x500
Dec  3 02:01:56 kernel: ? rcu_gp_kthread+0x13f/0x1d0
Dec  3 02:01:56 kernel: ? kthread+0xcc/0x100
Dec  3 02:01:56 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:01:56 kernel: ? ret_from_fork+0x2d/0x50
Dec  3 02:01:56 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:01:56 kernel: ? ret_from_fork_asm+0x1a/0x30
Dec  3 02:01:56 kernel: </TASK>
Dec  3 02:02:51 kernel: INFO: task kworker/u165:0:746685 blocked for more than 245 seconds.
Dec  3 02:02:51 kernel:      Not tainted 6.12.0 #64
Dec  3 02:02:51 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  3 02:02:51 kernel: task:kworker/u165:0  state:D stack:0     pid:746685 tgid:746685 ppid:2      flags:0x00004000
Dec  3 02:02:51 kernel: Workqueue: events_unbound linkwatch_event
Dec  3 02:02:51 kernel: Call Trace:
Dec  3 02:02:51 kernel: <TASK>
Dec  3 02:02:51 kernel: __schedule+0x23f/0x620
Dec  3 02:02:51 kernel: schedule+0x23/0xa0
Dec  3 02:02:51 kernel: schedule_preempt_disabled+0x11/0x20
Dec  3 02:02:51 kernel: __mutex_lock.constprop.0+0x31d/0x650
Dec  3 02:02:51 kernel: ? __schedule+0x247/0x620
Dec  3 02:02:51 kernel: linkwatch_event+0xa/0x30
Dec  3 02:02:51 kernel: process_one_work+0x179/0x390
Dec  3 02:02:51 kernel: worker_thread+0x239/0x340
Dec  3 02:02:51 kernel: ? __pfx_worker_thread+0x10/0x10
Dec  3 02:02:51 kernel: kthread+0xcc/0x100
Dec  3 02:02:51 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:02:51 kernel: ret_from_fork+0x2d/0x50
Dec  3 02:02:51 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:02:51 kernel: ret_from_fork_asm+0x1a/0x30
Dec  3 02:02:51 kernel: </TASK>
Dec  3 02:02:51 kernel: INFO: task kworker/5:2:900494 blocked for more than 245 seconds.
Dec  3 02:02:51 kernel:      Not tainted 6.12.0 #64
Dec  3 02:02:51 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  3 02:02:51 kernel: task:kworker/5:2     state:D stack:0     pid:900494 tgid:900494 ppid:2      flags:0x00004000
Dec  3 02:02:51 kernel: Workqueue: events xfrm_state_gc_task
Dec  3 02:02:51 kernel: Call Trace:
Dec  3 02:02:51 kernel: <TASK>
Dec  3 02:02:51 kernel: __schedule+0x23f/0x620
Dec  3 02:02:51 kernel: schedule+0x23/0xa0
Dec  3 02:02:51 kernel: schedule_timeout+0x14a/0x160
Dec  3 02:02:51 kernel: ? __hrtimer_start_range_ns+0x20b/0x2e0
Dec  3 02:02:51 kernel: ? kvm_clock_get_cycles+0x14/0x30
Dec  3 02:02:51 kernel: ? ktime_get+0x34/0xc0
Dec  3 02:02:51 kernel: ? timerqueue_del+0x2a/0x50
Dec  3 02:02:51 kernel: __wait_for_common+0x8f/0x1d0
Dec  3 02:02:51 kernel: ? __pfx_schedule_timeout+0x10/0x10
Dec  3 02:02:51 kernel: wait_for_completion_state+0x1d/0x40
Dec  3 02:02:51 kernel: __wait_rcu_gp+0x126/0x130
Dec  3 02:02:51 kernel: synchronize_rcu_normal.part.0+0x3a/0x60
Dec  3 02:02:51 kernel: ? __pfx_call_rcu_hurry+0x10/0x10
Dec  3 02:02:51 kernel: ? __pfx_wakeme_after_rcu+0x10/0x10
Dec  3 02:02:51 kernel: xfrm_state_gc_task+0x56/0xa0
Dec  3 02:02:51 kernel: process_one_work+0x179/0x390
Dec  3 02:02:51 kernel: worker_thread+0x239/0x340
Dec  3 02:02:51 kernel: ? __pfx_worker_thread+0x10/0x10
Dec  3 02:02:51 kernel: kthread+0xcc/0x100
Dec  3 02:02:51 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:02:51 kernel: ret_from_fork+0x2d/0x50
Dec  3 02:02:51 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:02:51 kernel: ret_from_fork_asm+0x1a/0x30
Dec  3 02:02:51 kernel: </TASK>
Dec  3 02:02:51 kernel: INFO: task systemd-udevd:995278 blocked for more than 245 seconds.
Dec  3 02:02:51 kernel:      Not tainted 6.12.0 #64
Dec  3 02:02:51 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  3 02:02:51 kernel: task:systemd-udevd   state:D stack:0     pid:995278 tgid:995278 ppid:1080   flags:0x00000002
Dec  3 02:02:51 kernel: Call Trace:
Dec  3 02:02:51 kernel: <TASK>
Dec  3 02:02:51 kernel: __schedule+0x23f/0x620
Dec  3 02:02:51 kernel: schedule+0x23/0xa0
Dec  3 02:02:51 kernel: netlink_table_grab.part.0+0x82/0xe0
Dec  3 02:02:51 kernel: ? __pfx_default_wake_function+0x10/0x10
Dec  3 02:02:51 kernel: netlink_release+0x36c/0x520
Dec  3 02:02:51 kernel: ? __pfx_netlink_hash+0x10/0x10
Dec  3 02:02:51 kernel: ? __pfx_netlink_compare+0x10/0x10
Dec  3 02:02:51 kernel: __sock_release+0x3a/0xc0
Dec  3 02:02:51 kernel: sock_close+0x11/0x20
Dec  3 02:02:51 kernel: __fput+0xdb/0x2a0
Dec  3 02:02:51 kernel: task_work_run+0x55/0x90
Dec  3 02:02:51 kernel: do_exit+0x279/0x4b0
Dec  3 02:02:51 kernel: do_group_exit+0x2c/0x80
Dec  3 02:02:51 kernel: __x64_sys_exit_group+0x14/0x20
Dec  3 02:02:51 kernel: x64_sys_call+0x1836/0x1840
Dec  3 02:02:51 kernel: do_syscall_64+0x79/0x150
Dec  3 02:02:51 kernel: ? __count_memcg_events+0x4f/0xe0
Dec  3 02:02:51 kernel: ? handle_mm_fault+0x18e/0x270
Dec  3 02:02:51 kernel: ? do_user_addr_fault+0x34c/0x680
Dec  3 02:02:51 kernel: ? clear_bhb_loop+0x45/0xa0
Dec  3 02:02:51 kernel: ? clear_bhb_loop+0x45/0xa0
Dec  3 02:02:51 kernel: ? clear_bhb_loop+0x45/0xa0
Dec  3 02:02:51 kernel: entry_SYSCALL_64_after_hwframe+0x76/0x7e
Dec  3 02:02:51 kernel: RIP: 0033:0x7f6cfa8d921d
Dec  3 02:02:51 kernel: RSP: 002b:00007ffd7e081b58 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
Dec  3 02:02:51 kernel: RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6cfa8d921d
Dec  3 02:02:51 kernel: RDX: 00000000000000e7 RSI: fffffffffffffe88 RDI: 0000000000000000
Dec  3 02:02:51 kernel: RBP: 00007ffd7e081c00 R08: 00005615d9e8dbb0 R09: 0000000000000004
Dec  3 02:02:51 kernel: R10: 0000000000000018 R11: 0000000000000246 R12: 00007ffd7e081bb0
Dec  3 02:02:51 kernel: R13: 00005615d9d0e8b0 R14: 00005615d9e8dbb0 R15: 0000000000000000
Dec  3 02:02:51 kernel: </TASK>
Dec  3 02:02:51 kernel: INFO: task systemd-udevd:995279 blocked for more than 245 seconds.
Dec  3 02:02:51 kernel:      Not tainted 6.12.0 #64
Dec  3 02:02:51 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  3 02:02:51 kernel: task:systemd-udevd   state:D stack:0     pid:995279 tgid:995279 ppid:1080   flags:0x00004002
Dec  3 02:02:51 kernel: Call Trace:
Dec  3 02:02:51 kernel: <TASK>
Dec  3 02:02:51 kernel: __schedule+0x23f/0x620
Dec  3 02:02:51 kernel: schedule+0x23/0xa0
Dec  3 02:02:51 kernel: netlink_table_grab.part.0+0x82/0xe0
Dec  3 02:02:51 kernel: ? __pfx_default_wake_function+0x10/0x10
Dec  3 02:02:51 kernel: netlink_release+0x36c/0x520
Dec  3 02:02:51 kernel: ? __pfx_netlink_hash+0x10/0x10
Dec  3 02:02:51 kernel: ? __pfx_netlink_compare+0x10/0x10
Dec  3 02:02:51 kernel: __sock_release+0x3a/0xc0
Dec  3 02:02:51 kernel: sock_close+0x11/0x20
Dec  3 02:02:51 kernel: __fput+0xdb/0x2a0
Dec  3 02:02:51 kernel: task_work_run+0x55/0x90
Dec  3 02:02:51 kernel: do_exit+0x279/0x4b0
Dec  3 02:02:51 kernel: do_group_exit+0x2c/0x80
Dec  3 02:02:51 kernel: __x64_sys_exit_group+0x14/0x20
Dec  3 02:02:51 kernel: x64_sys_call+0x1836/0x1840
Dec  3 02:02:51 kernel: do_syscall_64+0x79/0x150
Dec  3 02:02:51 kernel: ? get_page_from_freelist+0x333/0x630
Dec  3 02:02:51 kernel: ? __alloc_pages_noprof+0x186/0x350
Dec  3 02:02:51 kernel: ? __mod_memcg_lruvec_state+0x95/0x150
Dec  3 02:02:51 kernel: ? __lruvec_stat_mod_folio+0x80/0xd0
Dec  3 02:02:51 kernel: ? __folio_mod_stat+0x2a/0x80
Dec  3 02:02:51 kernel: ? _raw_spin_unlock+0xa/0x30
Dec  3 02:02:51 kernel: ? wp_page_copy+0x4e0/0x710
Dec  3 02:02:51 kernel: ? __pte_offset_map+0x17/0x160
Dec  3 02:02:51 kernel: ? _raw_spin_unlock+0xa/0x30
Dec  3 02:02:51 kernel: ? do_wp_page+0x666/0x760
Dec  3 02:02:51 kernel: ? __handle_mm_fault+0x326/0x730
Dec  3 02:02:51 kernel: ? __count_memcg_events+0x4f/0xe0
Dec  3 02:02:51 kernel: ? handle_mm_fault+0x18e/0x270
Dec  3 02:02:51 kernel: ? do_user_addr_fault+0x34c/0x680
Dec  3 02:02:51 kernel: ? clear_bhb_loop+0x45/0xa0
Dec  3 02:02:51 kernel: ? clear_bhb_loop+0x45/0xa0
Dec  3 02:02:51 kernel: ? clear_bhb_loop+0x45/0xa0
Dec  3 02:02:51 kernel: entry_SYSCALL_64_after_hwframe+0x76/0x7e
Dec  3 02:02:51 kernel: RIP: 0033:0x7f6cfa8d921d
Dec  3 02:02:51 kernel: RSP: 002b:00007ffd7e081b58 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
Dec  3 02:02:51 kernel: RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6cfa8d921d
Dec  3 02:02:51 kernel: RDX: 00000000000000e7 RSI: fffffffffffffe88 RDI: 0000000000000000
Dec  3 02:02:51 kernel: RBP: 00007ffd7e081c00 R08: 00005615d9e932b0 R09: 0000000000000004
Dec  3 02:02:51 kernel: R10: 0000000000000018 R11: 0000000000000246 R12: 00007ffd7e081bb0
Dec  3 02:02:51 kernel: R13: 00005615d9d0e8b0 R14: 00005615d9e932b0 R15: 0000000000000000
Dec  3 02:02:51 kernel: </TASK>
Dec  3 02:02:51 kernel: INFO: task ip:998743 blocked for more than 245 seconds.
Dec  3 02:02:51 kernel:      Not tainted 6.12.0 #64
Dec  3 02:02:51 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  3 02:02:51 kernel: task:ip              state:D stack:0     pid:998743 tgid:998743 ppid:998736 flags:0x00000002
Dec  3 02:02:51 kernel: Call Trace:
Dec  3 02:02:51 kernel: <TASK>
Dec  3 02:02:51 kernel: __schedule+0x23f/0x620
Dec  3 02:02:51 kernel: schedule+0x23/0xa0
Dec  3 02:02:51 kernel: schedule_preempt_disabled+0x11/0x20
Dec  3 02:02:51 kernel: __mutex_lock.constprop.0+0x31d/0x650
Dec  3 02:02:51 kernel: rtnetlink_rcv_msg+0x111/0x410
Dec  3 02:02:51 kernel: ? avc_has_perm_noaudit+0x67/0xf0
Dec  3 02:02:51 kernel: ? __pfx_rtnetlink_rcv_msg+0x10/0x10
Dec  3 02:02:51 kernel: netlink_rcv_skb+0x54/0x100
Dec  3 02:02:51 kernel: netlink_unicast+0x243/0x370
Dec  3 02:02:51 kernel: netlink_sendmsg+0x1f6/0x430
Dec  3 02:02:51 kernel: __sys_sendto+0x1f3/0x200
Dec  3 02:02:51 kernel: ? do_read_fault+0x10a/0x1e0
Dec  3 02:02:51 kernel: ? do_fault+0x21f/0x380
Dec  3 02:02:51 kernel: ? pte_offset_map_nolock+0x2b/0xb0
Dec  3 02:02:51 kernel: __x64_sys_sendto+0x20/0x30
Dec  3 02:02:51 kernel: do_syscall_64+0x79/0x150
Dec  3 02:02:51 kernel: ? __count_memcg_events+0x4f/0xe0
Dec  3 02:02:51 kernel: ? handle_mm_fault+0x18e/0x270
Dec  3 02:02:51 kernel: ? do_user_addr_fault+0x34c/0x680
Dec  3 02:02:51 kernel: ? clear_bhb_loop+0x45/0xa0
Dec  3 02:02:51 kernel: ? clear_bhb_loop+0x45/0xa0
Dec  3 02:02:51 kernel: ? clear_bhb_loop+0x45/0xa0
Dec  3 02:02:51 kernel: entry_SYSCALL_64_after_hwframe+0x76/0x7e
Dec  3 02:02:51 kernel: RIP: 0033:0x7f287830f860
Dec  3 02:02:51 kernel: RSP: 002b:00007ffdd4f2c518 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
Dec  3 02:02:51 kernel: RAX: ffffffffffffffda RBX: 00007ffdd4f2cc88 RCX: 00007f287830f860
Dec  3 02:02:51 kernel: RDX: 0000000000000020 RSI: 00007ffdd4f2c520 RDI: 0000000000000003
Dec  3 02:02:51 kernel: RBP: 00007ffdd4f2d7e4 R08: 0000000000000000 R09: 0000000000000000
Dec  3 02:02:51 kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
Dec  3 02:02:51 kernel: R13: 000055969d419040 R14: 00007ffdd4f2cc78 R15: 0000000000000004
Dec  3 02:02:51 kernel: </TASK>
Dec  3 02:02:51 kernel: Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
Dec  3 02:05:06 kernel: rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
Dec  3 02:05:06 kernel: rcu: #01117-...!: (0 ticks this GP) idle=b124/1/0x4000000000000002 softirq=2109356/2109356 fqs=0
Dec  3 02:05:06 kernel: rcu: #011(detected by 5, t=440015 jiffies, g=11126601, q=2760447 ncpus=40)
Dec  3 02:05:06 kernel: Sending NMI from CPU 5 to CPUs 17:
Dec  3 02:05:06 kernel: rcu: rcu_preempt kthread timer wakeup didn't happen for 450012 jiffies! g11126601 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x200
Dec  3 02:05:06 kernel: rcu: #011Possible timer handling issue on cpu=17 timer-softirq=273727
Dec  3 02:05:06 kernel: rcu: rcu_preempt kthread starved for 450015 jiffies! g11126601 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x200 ->cpu=17
Dec  3 02:05:06 kernel: rcu: #011Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
Dec  3 02:05:06 kernel: rcu: RCU grace-period kthread stack dump:
Dec  3 02:05:06 kernel: task:rcu_preempt     state:R stack:0     pid:18    tgid:18    ppid:2      flags:0x00004008
Dec  3 02:05:06 kernel: Call Trace:
Dec  3 02:05:06 kernel: <TASK>
Dec  3 02:05:06 kernel: ? __pick_next_task+0x3e/0x1a0
Dec  3 02:05:06 kernel: ? __schedule+0xfe/0x620
Dec  3 02:05:06 kernel: ? _raw_spin_unlock_irqrestore+0xa/0x30
Dec  3 02:05:06 kernel: ? __pfx_rcu_gp_kthread+0x10/0x10
Dec  3 02:05:06 kernel: ? schedule+0x23/0xa0
Dec  3 02:05:06 kernel: ? schedule_timeout+0x8b/0x160
Dec  3 02:05:06 kernel: ? __pfx_process_timeout+0x10/0x10
Dec  3 02:05:06 kernel: ? rcu_gp_fqs_loop+0x10b/0x500
Dec  3 02:05:06 kernel: ? rcu_gp_kthread+0x13f/0x1d0
Dec  3 02:05:06 kernel: ? kthread+0xcc/0x100
Dec  3 02:05:06 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:05:06 kernel: ? ret_from_fork+0x2d/0x50
Dec  3 02:05:06 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:05:06 kernel: ? ret_from_fork_asm+0x1a/0x30
Dec  3 02:05:06 kernel: </TASK>
Dec  3 02:08:16 kernel: rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
Dec  3 02:08:16 kernel: rcu: #01117-...!: (0 ticks this GP) idle=b124/1/0x4000000000000002 softirq=2109356/2109356 fqs=0
Dec  3 02:08:16 kernel: rcu: #011(detected by 15, t=630022 jiffies, g=11126601, q=3942985 ncpus=40)
Dec  3 02:08:16 kernel: Sending NMI from CPU 15 to CPUs 17:
Dec  3 02:08:16 kernel: rcu: rcu_preempt kthread timer wakeup didn't happen for 640019 jiffies! g11126601 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x200
Dec  3 02:08:16 kernel: rcu: #011Possible timer handling issue on cpu=17 timer-softirq=273727
Dec  3 02:08:16 kernel: rcu: rcu_preempt kthread starved for 640022 jiffies! g11126601 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x200 ->cpu=17
Dec  3 02:08:16 kernel: rcu: #011Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
Dec  3 02:08:16 kernel: rcu: RCU grace-period kthread stack dump:
Dec  3 02:08:16 kernel: task:rcu_preempt     state:R stack:0     pid:18    tgid:18    ppid:2      flags:0x00004008
Dec  3 02:08:16 kernel: Call Trace:
Dec  3 02:08:16 kernel: <TASK>
Dec  3 02:08:16 kernel: ? __pick_next_task+0x3e/0x1a0
Dec  3 02:08:16 kernel: ? __schedule+0xfe/0x620
Dec  3 02:08:16 kernel: ? _raw_spin_unlock_irqrestore+0xa/0x30
Dec  3 02:08:16 kernel: ? __pfx_rcu_gp_kthread+0x10/0x10
Dec  3 02:08:16 kernel: ? schedule+0x23/0xa0
Dec  3 02:08:16 kernel: ? schedule_timeout+0x8b/0x160
Dec  3 02:08:16 kernel: ? __pfx_process_timeout+0x10/0x10
Dec  3 02:08:16 kernel: ? rcu_gp_fqs_loop+0x10b/0x500
Dec  3 02:08:16 kernel: ? rcu_gp_kthread+0x13f/0x1d0
Dec  3 02:08:16 kernel: ? kthread+0xcc/0x100
Dec  3 02:08:16 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:08:16 kernel: ? ret_from_fork+0x2d/0x50
Dec  3 02:08:16 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:08:16 kernel: ? ret_from_fork_asm+0x1a/0x30
Dec  3 02:08:16 kernel: </TASK>
Dec  3 02:11:26 kernel: rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
Dec  3 02:11:26 kernel: rcu: #01117-...!: (0 ticks this GP) idle=b124/1/0x4000000000000002 softirq=2109356/2109356 fqs=0
Dec  3 02:11:26 kernel: rcu: #011(detected by 13, t=820027 jiffies, g=11126601, q=5124103 ncpus=40)
Dec  3 02:11:26 kernel: Sending NMI from CPU 13 to CPUs 17:
Dec  3 02:11:26 kernel: rcu: rcu_preempt kthread timer wakeup didn't happen for 830024 jiffies! g11126601 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x200
Dec  3 02:11:26 kernel: rcu: #011Possible timer handling issue on cpu=17 timer-softirq=273727
Dec  3 02:11:26 kernel: rcu: rcu_preempt kthread starved for 830027 jiffies! g11126601 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x200 ->cpu=17
Dec  3 02:11:26 kernel: rcu: #011Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
Dec  3 02:11:26 kernel: rcu: RCU grace-period kthread stack dump:
Dec  3 02:11:26 kernel: task:rcu_preempt     state:R stack:0     pid:18    tgid:18    ppid:2      flags:0x00004008
Dec  3 02:11:26 kernel: Call Trace:
Dec  3 02:11:26 kernel: <TASK>
Dec  3 02:11:26 kernel: ? __pick_next_task+0x3e/0x1a0
Dec  3 02:11:26 kernel: ? __schedule+0xfe/0x620
Dec  3 02:11:26 kernel: ? _raw_spin_unlock_irqrestore+0xa/0x30
Dec  3 02:11:26 kernel: ? __pfx_rcu_gp_kthread+0x10/0x10
Dec  3 02:11:26 kernel: ? schedule+0x23/0xa0
Dec  3 02:11:26 kernel: ? schedule_timeout+0x8b/0x160
Dec  3 02:11:26 kernel: ? __pfx_process_timeout+0x10/0x10
Dec  3 02:11:26 kernel: ? rcu_gp_fqs_loop+0x10b/0x500
Dec  3 02:11:26 kernel: ? rcu_gp_kthread+0x13f/0x1d0
Dec  3 02:11:26 kernel: ? kthread+0xcc/0x100
Dec  3 02:11:26 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:11:26 kernel: ? ret_from_fork+0x2d/0x50
Dec  3 02:11:26 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:11:26 kernel: ? ret_from_fork_asm+0x1a/0x30
Dec  3 02:11:26 kernel: </TASK>
Dec  3 02:14:36 kernel: rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
Dec  3 02:14:36 kernel: rcu: #01117-...!: (0 ticks this GP) idle=b124/1/0x4000000000000002 softirq=2109356/2109356 fqs=0
Dec  3 02:14:36 kernel: rcu: #011(detected by 29, t=1010032 jiffies, g=11126601, q=6331978 ncpus=40)
Dec  3 02:14:36 kernel: Sending NMI from CPU 29 to CPUs 17:
Dec  3 02:14:36 kernel: rcu: rcu_preempt kthread timer wakeup didn't happen for 1020029 jiffies! g11126601 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x200
Dec  3 02:14:36 kernel: rcu: #011Possible timer handling issue on cpu=17 timer-softirq=273727
Dec  3 02:14:36 kernel: rcu: rcu_preempt kthread starved for 1020032 jiffies! g11126601 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x200 ->cpu=17
Dec  3 02:14:36 kernel: rcu: #011Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
Dec  3 02:14:36 kernel: rcu: RCU grace-period kthread stack dump:
Dec  3 02:14:36 kernel: task:rcu_preempt     state:R stack:0     pid:18    tgid:18    ppid:2      flags:0x00004008
Dec  3 02:14:36 kernel: Call Trace:
Dec  3 02:14:36 kernel: <TASK>
Dec  3 02:14:36 kernel: ? __pick_next_task+0x3e/0x1a0
Dec  3 02:14:36 kernel: ? __schedule+0xfe/0x620
Dec  3 02:14:36 kernel: ? _raw_spin_unlock_irqrestore+0xa/0x30
Dec  3 02:14:36 kernel: ? __pfx_rcu_gp_kthread+0x10/0x10
Dec  3 02:14:36 kernel: ? schedule+0x23/0xa0
Dec  3 02:14:36 kernel: ? schedule_timeout+0x8b/0x160
Dec  3 02:14:36 kernel: ? __pfx_process_timeout+0x10/0x10
Dec  3 02:14:36 kernel: ? rcu_gp_fqs_loop+0x10b/0x500
Dec  3 02:14:36 kernel: ? rcu_gp_kthread+0x13f/0x1d0
Dec  3 02:14:36 kernel: ? kthread+0xcc/0x100
Dec  3 02:14:36 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:14:36 kernel: ? ret_from_fork+0x2d/0x50
Dec  3 02:14:36 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:14:36 kernel: ? ret_from_fork_asm+0x1a/0x30
Dec  3 02:14:36 kernel: </TASK>
Dec  3 02:17:46 kernel: rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
Dec  3 02:17:46 kernel: rcu: #01117-...!: (0 ticks this GP) idle=b124/1/0x4000000000000002 softirq=2109356/2109356 fqs=0
Dec  3 02:17:46 kernel: rcu: #011(detected by 8, t=1200037 jiffies, g=11126601, q=7535150 ncpus=40)
Dec  3 02:17:46 kernel: Sending NMI from CPU 8 to CPUs 17:
Dec  3 02:17:46 kernel: rcu: rcu_preempt kthread timer wakeup didn't happen for 1210034 jiffies! g11126601 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x200
Dec  3 02:17:46 kernel: rcu: #011Possible timer handling issue on cpu=17 timer-softirq=273727
Dec  3 02:17:46 kernel: rcu: rcu_preempt kthread starved for 1210037 jiffies! g11126601 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x200 ->cpu=17
Dec  3 02:17:46 kernel: rcu: #011Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
Dec  3 02:17:46 kernel: rcu: RCU grace-period kthread stack dump:
Dec  3 02:17:46 kernel: task:rcu_preempt     state:R stack:0     pid:18    tgid:18    ppid:2      flags:0x00004008
Dec  3 02:17:46 kernel: Call Trace:
Dec  3 02:17:46 kernel: <TASK>
Dec  3 02:17:46 kernel: ? __pick_next_task+0x3e/0x1a0
Dec  3 02:17:46 kernel: ? __schedule+0xfe/0x620
Dec  3 02:17:46 kernel: ? _raw_spin_unlock_irqrestore+0xa/0x30
Dec  3 02:17:46 kernel: ? __pfx_rcu_gp_kthread+0x10/0x10
Dec  3 02:17:46 kernel: ? schedule+0x23/0xa0
Dec  3 02:17:46 kernel: ? schedule_timeout+0x8b/0x160
Dec  3 02:17:46 kernel: ? __pfx_process_timeout+0x10/0x10
Dec  3 02:17:46 kernel: ? rcu_gp_fqs_loop+0x10b/0x500
Dec  3 02:17:46 kernel: ? rcu_gp_kthread+0x13f/0x1d0
Dec  3 02:17:46 kernel: ? kthread+0xcc/0x100
Dec  3 02:17:46 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:17:46 kernel: ? ret_from_fork+0x2d/0x50
Dec  3 02:17:46 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:17:46 kernel: ? ret_from_fork_asm+0x1a/0x30
Dec  3 02:17:46 kernel: </TASK>
Dec  3 02:20:56 kernel: rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
Dec  3 02:20:56 kernel: rcu: #01117-...!: (0 ticks this GP) idle=b124/1/0x4000000000000002 softirq=2109356/2109356 fqs=0
Dec  3 02:20:56 kernel: rcu: #011(detected by 8, t=1390043 jiffies, g=11126601, q=8740806 ncpus=40)
Dec  3 02:20:56 kernel: Sending NMI from CPU 8 to CPUs 17:
Dec  3 02:20:56 kernel: rcu: rcu_preempt kthread timer wakeup didn't happen for 1400040 jiffies! g11126601 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x200
Dec  3 02:20:56 kernel: rcu: #011Possible timer handling issue on cpu=17 timer-softirq=273727
Dec  3 02:20:56 kernel: rcu: rcu_preempt kthread starved for 1400043 jiffies! g11126601 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x200 ->cpu=17
Dec  3 02:20:56 kernel: rcu: #011Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
Dec  3 02:20:56 kernel: rcu: RCU grace-period kthread stack dump:
Dec  3 02:20:56 kernel: task:rcu_preempt     state:R stack:0     pid:18    tgid:18    ppid:2      flags:0x00004008
Dec  3 02:20:56 kernel: Call Trace:
Dec  3 02:20:56 kernel: <TASK>
Dec  3 02:20:56 kernel: ? __pick_next_task+0x3e/0x1a0
Dec  3 02:20:56 kernel: ? __schedule+0xfe/0x620
Dec  3 02:20:56 kernel: ? _raw_spin_unlock_irqrestore+0xa/0x30
Dec  3 02:20:56 kernel: ? __pfx_rcu_gp_kthread+0x10/0x10
Dec  3 02:20:56 kernel: ? schedule+0x23/0xa0
Dec  3 02:20:56 kernel: ? schedule_timeout+0x8b/0x160
Dec  3 02:20:56 kernel: ? __pfx_process_timeout+0x10/0x10
Dec  3 02:20:56 kernel: ? rcu_gp_fqs_loop+0x10b/0x500
Dec  3 02:20:56 kernel: ? rcu_gp_kthread+0x13f/0x1d0
Dec  3 02:20:56 kernel: ? kthread+0xcc/0x100
Dec  3 02:20:56 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:20:56 kernel: ? ret_from_fork+0x2d/0x50
Dec  3 02:20:56 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:20:56 kernel: ? ret_from_fork_asm+0x1a/0x30
Dec  3 02:20:56 kernel: </TASK>
Dec  3 02:24:06 kernel: rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
Dec  3 02:24:06 kernel: rcu: #01117-...!: (0 ticks this GP) idle=b124/1/0x4000000000000002 softirq=2109356/2109356 fqs=0
Dec  3 02:24:06 kernel: rcu: #011(detected by 23, t=1580048 jiffies, g=11126601, q=9924647 ncpus=40)
Dec  3 02:24:06 kernel: Sending NMI from CPU 23 to CPUs 17:
Dec  3 02:24:06 kernel: rcu: rcu_preempt kthread timer wakeup didn't happen for 1590045 jiffies! g11126601 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x200
Dec  3 02:24:06 kernel: rcu: #011Possible timer handling issue on cpu=17 timer-softirq=273727
Dec  3 02:24:06 kernel: rcu: rcu_preempt kthread starved for 1590048 jiffies! g11126601 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x200 ->cpu=17
Dec  3 02:24:06 kernel: rcu: #011Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
Dec  3 02:24:06 kernel: rcu: RCU grace-period kthread stack dump:
Dec  3 02:24:06 kernel: task:rcu_preempt     state:R stack:0     pid:18    tgid:18    ppid:2      flags:0x00004008
Dec  3 02:24:06 kernel: Call Trace:
Dec  3 02:24:06 kernel: <TASK>
Dec  3 02:24:06 kernel: ? __pick_next_task+0x3e/0x1a0
Dec  3 02:24:06 kernel: ? __schedule+0xfe/0x620
Dec  3 02:24:06 kernel: ? _raw_spin_unlock_irqrestore+0xa/0x30
Dec  3 02:24:06 kernel: ? __pfx_rcu_gp_kthread+0x10/0x10
Dec  3 02:24:06 kernel: ? schedule+0x23/0xa0
Dec  3 02:24:06 kernel: ? schedule_timeout+0x8b/0x160
Dec  3 02:24:06 kernel: ? __pfx_process_timeout+0x10/0x10
Dec  3 02:24:06 kernel: ? rcu_gp_fqs_loop+0x10b/0x500
Dec  3 02:24:06 kernel: ? rcu_gp_kthread+0x13f/0x1d0
Dec  3 02:24:06 kernel: ? kthread+0xcc/0x100
Dec  3 02:24:06 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:24:06 kernel: ? ret_from_fork+0x2d/0x50
Dec  3 02:24:06 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:24:06 kernel: ? ret_from_fork_asm+0x1a/0x30
Dec  3 02:24:06 kernel: </TASK>
Dec  3 02:27:16 kernel: rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
Dec  3 02:27:16 kernel: rcu: #01117-...!: (0 ticks this GP) idle=b124/1/0x4000000000000002 softirq=2109356/2109356 fqs=0
Dec  3 02:27:16 kernel: rcu: #011(detected by 18, t=1770053 jiffies, g=11126601, q=11108597 ncpus=40)
Dec  3 02:27:16 kernel: Sending NMI from CPU 18 to CPUs 17:
Dec  3 02:27:16 kernel: rcu: rcu_preempt kthread timer wakeup didn't happen for 1780050 jiffies! g11126601 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x200
Dec  3 02:27:16 kernel: rcu: #011Possible timer handling issue on cpu=17 timer-softirq=273727
Dec  3 02:27:16 kernel: rcu: rcu_preempt kthread starved for 1780053 jiffies! g11126601 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x200 ->cpu=17
Dec  3 02:27:16 kernel: rcu: #011Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
Dec  3 02:27:16 kernel: rcu: RCU grace-period kthread stack dump:
Dec  3 02:27:16 kernel: task:rcu_preempt     state:R stack:0     pid:18    tgid:18    ppid:2      flags:0x00004008
Dec  3 02:27:16 kernel: Call Trace:
Dec  3 02:27:16 kernel: <TASK>
Dec  3 02:27:16 kernel: ? __pick_next_task+0x3e/0x1a0
Dec  3 02:27:16 kernel: ? __schedule+0xfe/0x620
Dec  3 02:27:16 kernel: ? _raw_spin_unlock_irqrestore+0xa/0x30
Dec  3 02:27:16 kernel: ? __pfx_rcu_gp_kthread+0x10/0x10
Dec  3 02:27:16 kernel: ? schedule+0x23/0xa0
Dec  3 02:27:16 kernel: ? schedule_timeout+0x8b/0x160
Dec  3 02:27:16 kernel: ? __pfx_process_timeout+0x10/0x10
Dec  3 02:27:16 kernel: ? rcu_gp_fqs_loop+0x10b/0x500
Dec  3 02:27:16 kernel: ? rcu_gp_kthread+0x13f/0x1d0
Dec  3 02:27:16 kernel: ? kthread+0xcc/0x100
Dec  3 02:27:16 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:27:16 kernel: ? ret_from_fork+0x2d/0x50
Dec  3 02:27:16 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:27:16 kernel: ? ret_from_fork_asm+0x1a/0x30
Dec  3 02:27:16 kernel: </TASK>
Dec  3 02:30:26 kernel: rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
Dec  3 02:30:26 kernel: rcu: #01117-...!: (0 ticks this GP) idle=b124/1/0x4000000000000002 softirq=2109356/2109356 fqs=0
Dec  3 02:30:26 kernel: rcu: #011(detected by 1, t=1960059 jiffies, g=11126601, q=12298028 ncpus=40)
Dec  3 02:30:26 kernel: Sending NMI from CPU 1 to CPUs 17:
Dec  3 02:30:26 kernel: rcu: rcu_preempt kthread timer wakeup didn't happen for 1970056 jiffies! g11126601 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x200
Dec  3 02:30:26 kernel: rcu: #011Possible timer handling issue on cpu=17 timer-softirq=273727
Dec  3 02:30:26 kernel: rcu: rcu_preempt kthread starved for 1970059 jiffies! g11126601 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x200 ->cpu=17
Dec  3 02:30:26 kernel: rcu: #011Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
Dec  3 02:30:26 kernel: rcu: RCU grace-period kthread stack dump:
Dec  3 02:30:26 kernel: task:rcu_preempt     state:R stack:0     pid:18    tgid:18    ppid:2      flags:0x00004008
Dec  3 02:30:26 kernel: Call Trace:
Dec  3 02:30:26 kernel: <TASK>
Dec  3 02:30:26 kernel: ? __pick_next_task+0x3e/0x1a0
Dec  3 02:30:26 kernel: ? __schedule+0xfe/0x620
Dec  3 02:30:26 kernel: ? _raw_spin_unlock_irqrestore+0xa/0x30
Dec  3 02:30:26 kernel: ? __pfx_rcu_gp_kthread+0x10/0x10
Dec  3 02:30:26 kernel: ? schedule+0x23/0xa0
Dec  3 02:30:26 kernel: ? schedule_timeout+0x8b/0x160
Dec  3 02:30:26 kernel: ? __pfx_process_timeout+0x10/0x10
Dec  3 02:30:26 kernel: ? rcu_gp_fqs_loop+0x10b/0x500
Dec  3 02:30:26 kernel: ? rcu_gp_kthread+0x13f/0x1d0
Dec  3 02:30:26 kernel: ? kthread+0xcc/0x100
Dec  3 02:30:26 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:30:26 kernel: ? ret_from_fork+0x2d/0x50
Dec  3 02:30:26 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:30:26 kernel: ? ret_from_fork_asm+0x1a/0x30
Dec  3 02:30:26 kernel: </TASK>
Dec  3 02:30:26 kernel: ? kthread+0xcc/0x100
Dec  3 02:30:26 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:30:26 kernel: ? ret_from_fork+0x2d/0x50
Dec  3 02:30:26 kernel: ? __pfx_kthread+0x10/0x10
Dec  3 02:30:26 kernel: ? ret_from_fork_asm+0x1a/0x30
Dec  3 02:30:26 kernel: </TASK>

