Return-Path: <linux-kernel+bounces-207366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DF990162D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 15:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ADD61F21512
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 13:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52D942071;
	Sun,  9 Jun 2024 13:04:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E346B41C69
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 13:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717938262; cv=none; b=Ogde/QS2VC7kj/5UzoGU2f+0vKmPfPZ1KTxKf52784BiFCYQG4YUxvmq/mKBEmjj/kJTdKJ/5HefEYECeyeUW5QNSGdYKfEcpJIAarjUNTMxLzSud5NAI1ydv/pTJvbv89zOODJmYa72N4RI/4P4u5pv4wbdZGAlqSO3LtvARC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717938262; c=relaxed/simple;
	bh=cTzPRK28mCvcTaIEVS++C7iU+PLf/emLOVnGX+nxC/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zo17SqyhZ1u7ADbTXBifrGaRopN3IYsVAY7GxEvO0q7IvSmpY2HoYZBcwRs4307zH+atXKUnC1shXhn+LLI+4wDDbnXk0N8i7qJ52PIgOyPt8e+Hpr8IuJb0VCgiSZ/ldbi+bG8ROHhzeiwsYLn9SaP7endKDqgJN30L0m7xnyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A96C2BD10;
	Sun,  9 Jun 2024 13:04:20 +0000 (UTC)
Date: Sun, 9 Jun 2024 09:04:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 syzkaller-bugs@googlegroups.com, peterz@infradead.org, jpoimboe@kernel.org,
 jbaron@akamai.com, ardb@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com, hpa@zytor.com,
 xrivendell7@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tejun Heo <tj@kernel.org>
Subject: Re: [Linux kernel bug] WARNING in static_key_slow_inc_cpuslocked
Message-ID: <20240609090431.3af238bc@gandalf.local.home>
In-Reply-To: <CAEkJfYNzfW1vG=ZTMdz_Weoo=RXY1NDunbxnDaLyj8R4kEoE_w@mail.gmail.com>
References: <CAEkJfYNzfW1vG=ZTMdz_Weoo=RXY1NDunbxnDaLyj8R4kEoE_w@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Jun 2024 14:33:01 +0800
Sam Sun <samsun1006219@gmail.com> wrote:

> Dear developers and maintainers,
> 
> We encountered a kernel bug while using our modified
> syzkaller. It was tested against the latest upstream kernel.
> Kernel crash log is listed below.
> 
> ```
> [   82.310798][ T8020] ------------[ cut here ]------------
> [   82.311236][ T8020] kernel BUG at arch/x86/kernel/jump_label.c:73!

This is not a bug with jump labels. It's a bug with whatever is using jump
labels. Looks like something tried to modify a jump label that no longer
exists.

> [   82.311761][ T8020] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> [   82.312331][ T8020] CPU: 0 PID: 8020 Comm: static_key_slow Not
> tainted 6.10.0-rc2-00366-g771ed66105de 3
> [   82.313044][ T8020] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.13.0-1ubuntu1.1 04/04
> [   82.313778][ T8020] RIP: 0010:__jump_label_patch+0x456/0x480
> [   82.314223][ T8020] Code: e8 af a1 5d 00 48 c7 c7 40 01 86 8b 48 8b
> 0c 24 48 89 ce 48 89 ca 4d 89 e8 4f
> [   82.315745][ T8020] RSP: 0018:ffffc9000f9cf980 EFLAGS: 00010292
> [   82.316204][ T8020] RAX: 000000000000008b RBX: 0000000000000085
> RCX: 218564eba7c06800
> [   82.316813][ T8020] RDX: 0000000000000000 RSI: 0000000080000000
> RDI: 0000000000000000
> [   82.317396][ T8020] RBP: ffffc9000f9cfac0 R08: ffffffff817176dc
> R09: 1ffff92001f39ed0
> [   82.317987][ T8020] R10: dffffc0000000000 R11: fffff52001f39ed1
> R12: 0000000000000001
> [   82.318548][ T8020] R13: ffffffff8b862901 R14: ffffffff90fbe8c0
> R15: ffffffff8b862901
> [   82.319116][ T8020] FS:  00007f04610bc540(0000)
> GS:ffff88802c800000(0000) knlGS:0000000000000000
> [   82.319808][ T8020] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   82.320308][ T8020] CR2: 00007f0460fd9650 CR3: 000000004a16a000
> CR4: 0000000000750ef0
> [   82.320883][ T8020] DR0: 0000000000000000 DR1: 0000000000000000
> DR2: 0000000000000000
> [   82.321460][ T8020] DR3: 0000000000000000 DR6: 00000000fffe0ff0
> DR7: 0000000000000400
> [   82.322004][ T8020] PKRU: 55555554
> [   82.322269][ T8020] Call Trace:
> [   82.322515][ T8020]  <TASK>
> [   82.322729][ T8020]  ? __die_body+0x88/0xe0
> [   82.323043][ T8020]  ? die+0xcf/0x110
> [   82.323322][ T8020]  ? do_trap+0x155/0x3a0
> [   82.323625][ T8020]  ? __jump_label_patch+0x456/0x480
> [   82.324009][ T8020]  ? do_error_trap+0x1dc/0x2a0
> [   82.324371][ T8020]  ? __jump_label_patch+0x456/0x480
> [   82.324774][ T8020]  ? do_int3+0x50/0x50
> [   82.325088][ T8020]  ? handle_invalid_op+0x34/0x40
> [   82.325445][ T8020]  ? __jump_label_patch+0x456/0x480
> [   82.325815][ T8020]  ? exc_invalid_op+0x34/0x50
> [   82.326156][ T8020]  ? asm_exc_invalid_op+0x1a/0x20
> [   82.326533][ T8020]  ? __wake_up_klogd+0xcc/0x100
> [   82.326879][ T8020]  ? __jump_label_patch+0x456/0x480
> [   82.327249][ T8020]  ? cr4_update_pce+0xf/0x80
> [   82.327601][ T8020]  ? arch_jump_label_transform_queue+0xf0/0xf0
> [   82.328047][ T8020]  ? cr4_update_pce+0xf/0x80
> [   82.328380][ T8020]  ? cr4_update_pce+0x1e/0x80
> [   82.328717][ T8020]  ? cr4_update_pce+0x11/0x80
> [   82.329052][ T8020]  ? read_lock_is_recursive+0x20/0x20
> [   82.329466][ T8020]  ? __static_key_slow_dec_cpuslocked+0xb0/0x140
> [   82.329966][ T8020]  ? text_poke_queue+0x46/0x180
> [   82.330329][ T8020]  arch_jump_label_transform_queue+0x63/0xf0
> [   82.330742][ T8020]  __jump_label_update+0x18b/0x3b0
> [   82.331101][ T8020]  __static_key_slow_dec_cpuslocked+0xe9/0x140
> [   82.331519][ T8020]  static_key_slow_dec+0x50/0xa0
> [   82.331873][ T8020]  set_attr_rdpmc+0x193/0x270
> [   82.332179][ T8020]  ? get_attr_rdpmc+0x30/0x30
> [   82.332511][ T8020]  ? sysfs_kf_write+0x18d/0x2b0
> [   82.332832][ T8020]  ? sysfs_kf_read+0x370/0x370
> [   82.333159][ T8020]  kernfs_fop_write_iter+0x3ab/0x500

So, something in kernfs modified a jump label location that was freed?

-- Steve


> [   82.333531][ T8020]  vfs_write+0xa8b/0xd00
> [   82.333812][ T8020]  ? kernfs_fop_read_iter+0x640/0x640
> [   82.334234][ T8020]  ? kernel_write+0x330/0x330
> [   82.334598][ T8020]  ? do_sys_openat2+0x16b/0x1c0
> [   82.334949][ T8020]  ? do_sys_open+0x230/0x230
> [   82.335310][ T8020]  ? __up_read+0x2bb/0x6a0
> [   82.335633][ T8020]  ksys_write+0x17b/0x2a0
> [   82.335966][ T8020]  ? __ia32_sys_read+0x90/0x90
> [   82.336333][ T8020]  ? do_syscall_64+0xa5/0x230
> [   82.336656][ T8020]  do_syscall_64+0xe2/0x230
> [   82.336983][ T8020]  ? clear_bhb_loop+0x25/0x80
> [   82.337289][ T8020]  entry_SYSCALL_64_after_hwframe+0x67/0x6f
> [   82.337692][ T8020] RIP: 0033:0x7f0460fd2473
> [   82.337987][ T8020] Code: 8b 15 21 2a 0e 00 f7 d8 64 89 02 48 c7 c0
> ff ff ff ff eb b7 0f 1f 00 64 8b 08
> [   82.339230][ T8020] RSP: 002b:00007ffc46fb3058 EFLAGS: 00000246
> ORIG_RAX: 0000000000000001
> [   82.339804][ T8020] RAX: ffffffffffffffda RBX: 0000000000000000
> RCX: 00007f0460fd2473
> [   82.340331][ T8020] RDX: 0000000000000002 RSI: 00007ffc46fb3090
> RDI: 0000000000000004
> [   82.340852][ T8020] RBP: 00007ffc46fb3cb0 R08: 000000000000000f
> R09: 0072736d2f232f75
> [   82.341353][ T8020] R10: 0000000000000000 R11: 0000000000000246
> R12: 00005615dc1dd1c0
> [   82.341853][ T8020] R13: 0000000000000000 R14: 0000000000000000
> R15: 0000000000000000
> [   82.342364][ T8020]  </TASK>
> [   82.342554][ T8020] Modules linked in:
> [   82.342875][ T8020] ---[ end trace 0000000000000000 ]---
> [   82.343230][ T8020] RIP: 0010:__jump_label_patch+0x456/0x480
> [   82.343668][ T8020] Code: e8 af a1 5d 00 48 c7 c7 40 01 86 8b 48 8b
> 0c 24 48 89 ce 48 89 ca 4d 89 e8 4f
> [   82.345750][ T8020] RSP: 0018:ffffc9000f9cf980 EFLAGS: 00010292
> [   82.346161][ T8020] RAX: 000000000000008b RBX: 0000000000000085
> RCX: 218564eba7c06800
> [   82.346657][ T8020] RDX: 0000000000000000 RSI: 0000000080000000
> RDI: 0000000000000000
> [   82.347391][ T8020] RBP: ffffc9000f9cfac0 R08: ffffffff817176dc
> R09: 1ffff92001f39ed0
> [   82.347901][ T8020] R10: dffffc0000000000 R11: fffff52001f39ed1
> R12: 0000000000000001
> [   82.348652][ T8020] R13: ffffffff8b862901 R14: ffffffff90fbe8c0
> R15: ffffffff8b862901
> [   82.349173][ T8020] FS:  00007f04610bc540(0000)
> GS:ffff88802c800000(0000) knlGS:0000000000000000
> [   82.349784][ T8020] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   82.350196][ T8020] CR2: 00007f96d80450b8 CR3: 000000004a16a000
> CR4: 0000000000750ef0
> [   82.350717][ T8020] DR0: 0000000000000000 DR1: 0000000000000000
> DR2: 0000000000000000
> [   82.351243][ T8020] DR3: 0000000000000000 DR6: 00000000fffe0ff0
> DR7: 0000000000000400
> [   82.351769][ T8020] PKRU: 55555554
> [   82.352011][ T8020] Kernel panic - not syncing: Fatal exception
> [   82.352665][ T8020] Kernel Offset: disabled
> [   82.352988][ T8020] Rebooting in 86400 seconds..
> ```
> 
> We have a C repro which can trigger this bug in latest upstream kernel
> commit, listed below:
> 
> ```
> #define _GNU_SOURCE
> 
> #include <dirent.h>
> #include <endian.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <signal.h>
> #include <stdarg.h>
> #include <stdbool.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/prctl.h>
> #include <sys/stat.h>
> #include <sys/syscall.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <time.h>
> #include <unistd.h>
> 
> static unsigned long long procid;
> 
> static void sleep_ms(uint64_t ms)
> {
>   usleep(ms * 1000);
> }
> 
> static uint64_t current_time_ms(void)
> {
>   struct timespec ts;
>   if (clock_gettime(CLOCK_MONOTONIC, &ts))
>     exit(1);
>   return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
> }
> 
> static bool write_file(const char* file, const char* what, ...)
> {
>   char buf[1024];
>   va_list args;
>   va_start(args, what);
>   vsnprintf(buf, sizeof(buf), what, args);
>   va_end(args);
>   buf[sizeof(buf) - 1] = 0;
>   int len = strlen(buf);
>   int fd = open(file, O_WRONLY | O_CLOEXEC);
>   if (fd == -1)
>     return false;
>   if (write(fd, buf, len) != len) {
>     int err = errno;
>     close(fd);
>     errno = err;
>     return false;
>   }
>   close(fd);
>   return true;
> }
> 
> static long syz_mod_dev(volatile long a0, volatile long a1, volatile long a2,
>                         volatile long a3, volatile long a4)
> {
>   int fd, sysfd;
>   char buf[1024], sysbuf[1024], input[1024];
>   char* hash;
>   char dev_num;
>   dev_num = 0;
>   strncpy(buf, (char*)a0, sizeof(buf) - 1);
>   buf[sizeof(buf) - 1] = 0;
>   while ((hash = strchr(buf, '#'))) {
>     *hash = '0' + (char)(a1 % 10);
>     a1 /= 10;
>     if (dev_num == 0)
>       dev_num = *hash;
>   }
>   fd = open(buf, a2, 0);
>   strncpy(sysbuf, (char*)a3, sizeof(sysbuf) - 1);
>   sysbuf[sizeof(sysbuf) - 1] = 0;
>   if ((hash = strchr(sysbuf, '#'))) {
>     *hash = dev_num;
>     while ((hash = strchr(sysbuf, '#'))) {
>       *hash = '0' + (char)(a1 % 10);
>       a1 /= 10;
>     }
>   }
>   sysfd = open(sysbuf, O_RDWR, 0);
>   strncpy(input, (char*)a4, sizeof(input) - 1);
>   input[sizeof(input) - 1] = 0;
>   hash = strchr(input, '\0');
>   sysfd = write(sysfd, input, hash - input + 1);
>   return fd;
> }
> 
> static void kill_and_wait(int pid, int* status)
> {
>   kill(-pid, SIGKILL);
>   kill(pid, SIGKILL);
>   for (int i = 0; i < 100; i++) {
>     if (waitpid(-1, status, WNOHANG | __WALL) == pid)
>       return;
>     usleep(1000);
>   }
>   DIR* dir = opendir("/sys/fs/fuse/connections");
>   if (dir) {
>     for (;;) {
>       struct dirent* ent = readdir(dir);
>       if (!ent)
>         break;
>       if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
>         continue;
>       char abort[300];
>       snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
>                ent->d_name);
>       int fd = open(abort, O_WRONLY);
>       if (fd == -1) {
>         continue;
>       }
>       if (write(fd, abort, 1) < 0) {
>       }
>       close(fd);
>     }
>     closedir(dir);
>   } else {
>   }
>   while (waitpid(-1, status, __WALL) != pid) {
>   }
> }
> 
> static void setup_test()
> {
>   prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
>   setpgrp();
>   write_file("/proc/self/oom_score_adj", "1000");
> }
> 
> static void execute_one(void);
> 
> #define WAIT_FLAGS __WALL
> 
> static void loop(void)
> {
>   int iter = 0;
>   for (;; iter++) {
>     int pid = fork();
>     if (pid < 0)
>       exit(1);
>     if (pid == 0) {
>       setup_test();
>       execute_one();
>       exit(0);
>     }
>     int status = 0;
>     uint64_t start = current_time_ms();
>     for (;;) {
>       if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
>         break;
>       sleep_ms(1);
>       if (current_time_ms() - start < 5000)
>         continue;
>       kill_and_wait(pid, &status);
>       break;
>     }
>   }
> }
> 
> void execute_one(void)
> {
>   memcpy((void*)0x20000000, "/dev/cpu/#/msr\000", 15);
>   memcpy((void*)0x200000c0, "/sys/devices/cpu/rdpmc\000", 23);
>   memcpy((void*)0x20000100, "0\000", 2);
>   syz_mod_dev(
>       /*dev=*/0x20000000, /*id=*/0x8001,
>       /*flags=O_TRUNC|O_PATH|O_NONBLOCK|O_NOATIME|O_EXCL|O_DIRECTORY|0x442*/
>       0x250ec2, /*file=*/0x200000c0, /*buf=*/0x20000100);
>   memcpy((void*)0x20000080, "/dev/cpu/#/msr\000", 15);
>   memcpy((void*)0x20000140, "/sys/devices/cpu/rdpmc\000", 23);
>   memcpy((void*)0x20000180, "1\000", 2);
>   syz_mod_dev(/*dev=*/0x20000080, /*id=*/0,
>               /*flags=__O_TMPFILE|O_APPEND*/ 0x400400, /*file=*/0x20000140,
>               /*buf=*/0x20000180);
> }
> int main(void)
> {
>   syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
>           /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
>           /*offset=*/0ul);
>   syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul,
>           /*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
>           /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
>           /*offset=*/0ul);
>   syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
>           /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
>           /*offset=*/0ul);
>   for (procid = 0; procid < 4; procid++) {
>     if (fork() == 0) {
>       loop();
>     }
>   }
>   sleep(1000000);
>   return 0;
> }
> ```
> 
> If you have any questions, please contact us.
> 
> Reported by Yue Sun <samsun1006219@gmail.com>
> Reported by xingwei lee <xrivendell7@gmail.com>
> 
> Best Regards,
> Yue


