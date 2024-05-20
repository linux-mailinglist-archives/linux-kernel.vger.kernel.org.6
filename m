Return-Path: <linux-kernel+bounces-184145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 155F08CA323
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F070B20C52
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 20:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CA01384BF;
	Mon, 20 May 2024 20:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="udIWcXwT"
Received: from sonic308-18.consmr.mail.ir2.yahoo.com (sonic308-18.consmr.mail.ir2.yahoo.com [77.238.178.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF954138486
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.178.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716235841; cv=none; b=RciarqpW6UwuaaEXnfD+cSVBCs3nxacqSs3P7+ncsIKW0bUMlZmGkYRgQ4nWf+ugww2UAfA8jlpTKeHChAr5yHEYe1wkF1smWrNqVYYJaPOoSplfuZIl+GeNGbAkYYi3jnW8Hy4DGcmJ2Y1wu1RvdIMDIryfo7AtcetVX7LvWew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716235841; c=relaxed/simple;
	bh=cgLirzOaKjDN+jbH2BrsMKex+VJDHizIeminEnVMS3M=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:
	 References; b=MuckJQaKcORSJ4jbhLzTZPsXFVKxlR5L663/pFntjF1y9R6xZbM9kZVcy3M4DijELvZ/AH0fKkqs5xk3QEt7IhaC6mPxERFt2rI844it20GrKAgUp3WrhWL1N/DSI5Y6eWvKNamuz6uEeUv1HLmYohyoA5+2EsXnJw1eCs3Z5pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=udIWcXwT; arc=none smtp.client-ip=77.238.178.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1716235837; bh=EwMRMpt0428baDnnvu0yrfoOo9k7D6Z5AFfRYXgij0M=; h=Date:To:From:Subject:References:From:Subject:Reply-To; b=udIWcXwTCd7Za4wlq4blHeSPHPziY2kt+fy2t4oqjj4DmKLevUb2gSCMJ9eo6MFDBjngsSGZiFAFnJHn+yf9qSy6aaLilSEzSSdb/jOUBbom0k9iOetknqotQHl+F8qdwEJZaTpGJF+LjnFVHjzAzeayyQfMaqvqN7rgrvhl83oG7uPzc9YaGDK1F2e2T2kYuv5UH5MVGTw3qF97x1XZcBtiosd3Af/9DfCa2qmznUnwgmQGB0HI8WJkTl2z4yv2SaVZCKBYsICiHKibvw0rWvlLg10QCIa1z02eze3j+a/Ztguhrt9d1oglichkzimOeUkM/pjiLS9YB0LDVtPbxw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1716235837; bh=XkgPNMf4myyK60h75/Qp5KV+daIQ5I2eF1QRWbKS4VE=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=XXY0FMxo0PVJ0LV8y6YlYPQILJVfeQz6wCD44xcYZfOjFBgldkG3kp2oG8y+5VgIDRzAz2Q1q27MPfe7EIP9w0riHObAGmybyUOzD8AGgoiCcd9LLGNB1Usqhi/QHuuF34HkWlRr9OLhnm6c1HsXXT0CeL/zX9wRgW6Dz8W1rkPf0DVyWNNw5+OTlLXj6e/VvDW9wFsO5oRD/g/f0Lb89xOSvO1OLAXnzCJxws5U5WaNEQilnkNgQdwWv0AaFN35Aa9UiunM75lR/Cei67IRjjUHsn95cU8UI7GIksVMtQlPtS+dWoD+OPeXN47rJG0UDxqcdUYs+STzRj61VRlZvw==
X-YMail-OSG: T7hETUkVM1ke9LI8ZcVtRWH3mz2vzv9xjo_GIEpcyJN9oPVocZ4Y8ACDaDwFikU
 VSt.kjvyNQYbVkMOmGfZx8LverhE.pE7vrWw23v_a.b9JvNGRvKu_jf_7qAso4j91IDngCxr4_hC
 azrEavQ7MFsiUIfEzcBHNO7mD1x01Ljz9qWTMOP8s4J_9iwMErX2E2Qns_jvGw.fiV6Zr2atPqMM
 AV4Sf36rBI1bp.faSgbDXlfLC2V9GPDY3s88bGpbrk0cTEr1Cag3x9Y_venYsYfzOeq12oiP.Rrk
 yGpU50eBPkr5drfYrETPgG1Sn9xiIQfpJIOBtJM4hhlB6wuTaHnZeL1jYOzsyKO3aqzhzvaHYTXQ
 AoAzlYsqp37WxZbnqPmGO03G0hKbx9PQ62YafQZpDR8ELp9j3CyYbQPjcb7Hdq5NTDNvsvvCzSN_
 1uuDoN3pDUVGUbYaH.3nK7TcJYdVgG3h1msvqcAV1H.Pa5neYRsSP6TNkQVHPCTV1t8wO6v1dtHi
 uZpfH_YnF7F8nJbNq.5Ya7LzkotLWYEtkAifmimlRznnNSjh2i413a6isAGeegsyERrpMFAyTNYC
 ta.BnmjsvUj3gWzGeSNjQyaN3UjtwlskkV1JcsrWMTNPoYQ8ETAAL05g4vWJi0qeI75_aTsVFYZ8
 C715uMT21PSJmToysSfHWj4MYVD2GLniYFKN7oCJ8fao35v9ziS0BHkr6uSzojFMgiJBKypPsDi7
 74oCxiRvp3dblDffLKG7JrMb1p_Is.ovvoF4pR4bquAos6II5BCUhiGhgUQgIuWoEyqHzBPDAt0q
 rjE1BhVq6vKhCoSCPGzaX7m0bxBUhpGUulZK3E.17e2mDiYi0zSFjAaMx4cg0uoXYfyZYQtNO7iI
 U.7K2PHkchOTPCYhX_DrSaCdbYv.F1H42ijj89eFR4goinzyvOoMP8iEoIUsZi7.w0PP08xYSjb_
 Iai7ZFMKj8brNegv.mJ8HveO.chFghWho_rHC2HavMW4l0xDJMrvTuH8w3Zk5x4e4hnZ6aLwXESf
 ufarTYbstONhBszvp9dglNcLq0Z4U6keEwjWNxNsu2i_74OpZKjFIbrdcLORaRb9AYdz9H.E9Al5
 NkcW2RwU1xepDnuCBbQgYBH1NadlSVaAroCtFbtScyD6adj1hTMHv_Wnus5kUFFs44G19gqwikFL
 meRu0DkzQPucDX_0kLDs0WQsXfL8Oezkoz5LdrDTlelPQVBuLnCqZSmdpAVXLNhrzh0tTizIeVgz
 rkPR2uEe0WSIGrF2jQ5TYUDOGjtjsefSrXnPvD9K311yTr_snnhWSbfDLflTctlCnWRhzXJDD3bN
 XdC48SZQRQcG3VGXvusMt76qT618JhrQSn6aGsU4BpVcyghWmJ.hEZKilTHBn1m2tYkAt4JM5jIL
 wi8NTbjxHqsEJp5EJ2Ksg2XXyTbI1_3JyhVbDremm.8FlaeotEa4trIGRkrDjOxJTTaTbb24Z5_U
 .j8Zs2zHX4ohwNQsA9m3p3HSYCQGQsWlNLGWpX4RCOvlhAHzjDziRksDAcSBAREzToHW7VX6_H41
 M6yiW3VAIfRbuBekewpoTJDExywyhv..PXK64DXw0vXOnREMBbM4I2DDhhsf0WG7u8BvQAhagLL7
 .HHzdH_hAW30AbiB9MpHMBbNnx6Dq8XMMvJrzjc5npLdqg0wYXhGswzLbXR7UyanlQhM2AzGGuVy
 C.9fkYDBruohoIiZCRkfxHUeew6WOyDTqsgsBmGb_9MRgFd6HIEsU6dxFp7gfazt8S2KQA0ZLgLK
 dDG2.i4AkaHfJhdIBcEy.k.US_Ac.2LnkkpMrPP1nJNKTU3kYfHUu2JmJtd935WetdHQ6sxVXCh5
 kon4JsO2WzgespY5v5tccy6p9MsSg_JtRQW8YAIti4ZgsLHwXGpnx_GzPMb.H7Qi22nkH2R4AyTe
 CYLKRdkfy7v7T2EJGs0STfWk4dRnyFJkW50FqY9DBe8U.WvSroZ1e55Pq8inbsdZtsH4EgYYBXP5
 0GR_pRXtnYEv8.RoOgyebqKKqYape3HEiQWSF0GOK0LepBUdf0NCPVBPtwZoQd1bO7EPUKgHLsz8
 tE2FJDBCGuDPsMALsKh4bO7buuiW1EP6enLbKIinyRwIxKaDd0Y7wNLnadDiLvYtqtqi85085bZe
 I8jGZt7WOG_R4U7CRm3mfuOafw_aUxuq2TPq8r_MICm6V81JZAb28RCB7.oLaGkD7k1jF9IhMLXv
 cpZ6dv7.OOQ--
X-Sonic-MF: <asgsb19@yahoo.com>
X-Sonic-ID: 6eba9713-2b59-4a13-bf36-c0d7800faf67
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Mon, 20 May 2024 20:10:37 +0000
Received: by hermes--production-ir2-7b99fc9bb6-6hqsm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a40f7653ed81a12636770f423b6e2aab;
          Mon, 20 May 2024 19:40:11 +0000 (UTC)
Message-ID: <d503cf13-56b9-4122-b03c-1d24e0d52c47@yahoo.com>
Date: Mon, 20 May 2024 21:40:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org
From: Alberto Segura <asgsb19@yahoo.com>
Subject: Kernel 6.9.1 bug trace...
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
References: <d503cf13-56b9-4122-b03c-1d24e0d52c47.ref@yahoo.com>
X-Mailer: WebService/1.1.22356 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

cat kernel-6.9.1_bug.txt
may 11 22:00:27 x99 kernel: ------------[ cut here ]------------
may 11 22:00:27 x99 kernel: simple-framebuffer simple-framebuffer.0: 
drm_WARN_ON(map->is_iomem)
may 11 22:00:27 x99 kernel: WARNING: CPU: 15 PID: 1767 at 
drivers/gpu/drm/drm_gem_shmem_helper.c:319 drm_gem_shmem_vmap+0x1a5/0x1e0
may 11 22:00:27 x99 kernel: Modules linked in: rfcomm snd_seq_dummy 
snd_hrtimer overlay nvidia_uvm(PO) qrtr cmac algif_hash algif_skcipher 
af_alg bnep nvidia_drm(PO) intel_rapl_msr intel_rap>
may 11 22:00:27 x99 kernel:  input_leds mac_hid msr parport_pc ppdev lp 
parport efi_pstore nfnetlink dmi_sysfs ip_tables x_tables autofs4 
hid_generic usbhid uas hid usb_storage nvme crc32_pc>
may 11 22:00:27 x99 kernel: CPU: 15 PID: 1767 Comm: Xorg Tainted: 
P           O       6.8.0-31-generic #31-Ubuntu
may 11 22:00:27 x99 kernel: Hardware name: HUANAN Default string/X99-F8, 
BIOS 5.11 10/28/2019
may 11 22:00:27 x99 kernel: RIP: 0010:drm_gem_shmem_vmap+0x1a5/0x1e0
may 11 22:00:27 x99 kernel: Code: 4c 8b 6f 50 4d 85 ed 75 03 4c 8b 2f e8 
44 a4 ec ff 48 c7 c1 ed 58 02 92 4c 89 ea 48 c7 c7 2c 34 02 92 48 89 c6 
e8 1b 14 44 ff <0f> 0b 48 8b 83 f0 00 00 00 4>
may 11 22:00:27 x99 kernel: RSP: 0018:ffffa94149fb7a68 EFLAGS: 00010246
may 11 22:00:27 x99 kernel: RAX: 0000000000000000 RBX: ffff9b5fcdf1b600 
RCX: 0000000000000000
may 11 22:00:27 x99 kernel: RDX: 0000000000000000 RSI: 0000000000000000 
RDI: 0000000000000000
may 11 22:00:27 x99 kernel: RBP: ffffa94149fb7a88 R08: 0000000000000000 
R09: 0000000000000000
may 11 22:00:27 x99 kernel: R10: 0000000000000000 R11: 0000000000000000 
R12: ffff9b5fd2dc98c8
may 11 22:00:27 x99 kernel: R13: ffff9b5fcb3fbde0 R14: ffff9b5fd2dc98c8 
R15: ffff9b5fd2dc98c8
may 11 22:00:27 x99 kernel: FS:  00007bd8e2e52ac0(0000) 
GS:ffff9b6b0f980000(0000) knlGS:0000000000000000
may 11 22:00:27 x99 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
may 11 22:00:27 x99 kernel: CR2: 000055c710ae7f20 CR3: 000000010cec8006 
CR4: 00000000003706f0
may 11 22:00:27 x99 kernel: DR0: 0000000000000000 DR1: 0000000000000000 
DR2: 0000000000000000
may 11 22:00:27 x99 kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 
DR7: 0000000000000400
may 11 22:00:27 x99 kernel: Call Trace:
may 11 22:00:27 x99 kernel:  <TASK>
may 11 22:00:27 x99 kernel:  ? show_regs+0x6d/0x80
may 11 22:00:27 x99 kernel:  ? __warn+0x89/0x160
may 11 22:00:27 x99 kernel:  ? drm_gem_shmem_vmap+0x1a5/0x1e0
may 11 22:00:27 x99 kernel:  ? report_bug+0x17e/0x1b0
may 11 22:00:27 x99 kernel:  ? handle_bug+0x51/0xa0
may 11 22:00:27 x99 kernel:  ? exc_invalid_op+0x18/0x80
may 11 22:00:27 x99 kernel:  ? asm_exc_invalid_op+0x1b/0x20
may 11 22:00:27 x99 kernel:  ? drm_gem_shmem_vmap+0x1a5/0x1e0
may 11 22:00:27 x99 kernel:  ? drm_gem_shmem_vmap+0x1a5/0x1e0
may 11 22:00:27 x99 kernel:  drm_gem_shmem_object_vmap+0x9/0x20
may 11 22:00:27 x99 kernel:  drm_gem_vmap+0x26/0x80
may 11 22:00:27 x99 kernel:  drm_gem_vmap_unlocked+0x2b/0x50
may 11 22:00:27 x99 kernel:  drm_gem_fb_vmap+0x40/0x150
may 11 22:00:27 x99 kernel: drm_gem_begin_shadow_fb_access+0x25/0x40
may 11 22:00:27 x99 kernel: 
drm_atomic_helper_prepare_planes.part.0+0x142/0x1e0
may 11 22:00:27 x99 kernel: drm_atomic_helper_prepare_planes+0x5d/0x70
may 11 22:00:27 x99 kernel:  drm_atomic_helper_commit+0x84/0x160
may 11 22:00:27 x99 kernel:  drm_atomic_commit+0x99/0xd0
may 11 22:00:27 x99 kernel:  ? __pfx___drm_printfn_info+0x10/0x10
may 11 22:00:27 x99 kernel: drm_atomic_helper_set_config+0x82/0xd0
may 11 22:00:27 x99 kernel:  drm_mode_setcrtc+0x535/0x8b0
may 11 22:00:27 x99 kernel:  ? __pfx_drm_mode_setcrtc+0x10/0x10
may 11 22:00:27 x99 kernel:  drm_ioctl_kernel+0xbc/0x120
may 11 22:00:27 x99 kernel:  drm_ioctl+0x2d4/0x550
may 11 22:00:27 x99 kernel:  ? __pfx_drm_mode_setcrtc+0x10/0x10
may 11 22:00:27 x99 kernel:  __x64_sys_ioctl+0xa3/0xf0
may 11 22:00:27 x99 kernel:  x64_sys_call+0x143b/0x25c0
may 11 22:00:27 x99 kernel:  do_syscall_64+0x7f/0x180
may 11 22:00:27 x99 kernel:  ? syscall_exit_to_user_mode+0x86/0x260
may 11 22:00:27 x99 kernel:  ? do_syscall_64+0x8c/0x180
may 11 22:00:27 x99 kernel:  ? do_syscall_64+0x8c/0x180
may 11 22:00:27 x99 kernel:  ? exc_page_fault+0x94/0x1b0
may 11 22:00:27 x99 kernel: entry_SYSCALL_64_after_hwframe+0x73/0x7b
may 11 22:00:27 x99 kernel: RIP: 0033:0x7bd8e3124ded
may 11 22:00:27 x99 kernel: Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 
8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 
00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 4>
may 11 22:00:27 x99 kernel: RSP: 002b:00007fffb54558d0 EFLAGS: 00000246 
ORIG_RAX: 0000000000000010
may 11 22:00:27 x99 kernel: RAX: ffffffffffffffda RBX: 000055c710aed9a0 
RCX: 00007bd8e3124ded
may 11 22:00:27 x99 kernel: RDX: 00007fffb5455960 RSI: 00000000c06864a2 
RDI: 0000000000000013
may 11 22:00:27 x99 kernel: RBP: 00007fffb5455920 R08: 0000000000000000 
R09: 000055c711005380
may 11 22:00:27 x99 kernel: R10: 0000000000000000 R11: 0000000000000246 
R12: 00007fffb5455960
may 11 22:00:27 x99 kernel: R13: 00000000c06864a2 R14: 0000000000000013 
R15: 000055c7108eb8d8
may 11 22:00:27 x99 kernel:  </TASK>
may 11 22:00:27 x99 kernel: ---[ end trace 0000000000000000 ]---


