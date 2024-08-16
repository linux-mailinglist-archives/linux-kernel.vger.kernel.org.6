Return-Path: <linux-kernel+bounces-289415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FB4954600
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092081C2193D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99CB15B135;
	Fri, 16 Aug 2024 09:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QW6i46El"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CC915B10F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801461; cv=none; b=PFTzdugdRKU5S8S5p0CKqfcipUOeF6sUfEMFCLNHeF4Zaaclu/pRuRu51+FI/ERWng0Urpjrodq/D0t9/k3Mer1m1cFTT7mT5oyicOSDDFJIaOt4IEinqiRCnVfrBNzo+L1WTIk6/VaZA7AZnYVRUDgQSWBQ1T4ZBRMQmn3ErS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801461; c=relaxed/simple;
	bh=bpdHZItT7kGsB/quPsKp5bXGCQUkA0wJAjq1q935bz0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RsUHpgyvhay+4qjfwiPWGR1KmQTUVLjiitcHgLd7iRs/zaY2bRbjpPhwEQrgmuavPntOaNn3Wslu9l2FvduL0YQ9TPo6KL7DyIGb24/eicCbDzh+ks/bEGjYScz2APZ8N39U+QGByZkpwbI0vTygEvZOfEJG5RlSPc1PaOLAQ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QW6i46El; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d3b785d8b1so1223283a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723801459; x=1724406259; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RhwimweyctqEw0Y2ri8PJ/wCwW9otgIBcTxBsW+Tuqs=;
        b=QW6i46ElTld5zcOCKsb+qqWIpD//Xgtuhf9i5Trn7UxV/OH40xcUav1iXj2Zhmhts6
         al0rgDtHLPM+J3UcejS69Zo6/S1w/w5ayeSnVzWEZF2QmbKgWcdGLhnouINbmJ+PCBMk
         Y5g7Zpuy1F2wDBml0uMAgJilEA7pnllFHNoj7+7GB/Zcq5z0o/hBp702fmD8n0nFOSp0
         BPBRcy8TtgELnI8/LkGBckiMaaTT9YgeH5YYhI22Ji/andiPwCXZQRH2edzp31vdVMQI
         WjcH32Y3NFmYSbT8ks4rXnAcV4wJJmrZywaxEa9rOMdqSKHDEnHNQlmP1lZBobDgUVGQ
         RAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723801459; x=1724406259;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RhwimweyctqEw0Y2ri8PJ/wCwW9otgIBcTxBsW+Tuqs=;
        b=vrVD3UCQp/ca9uOk+rZ0Bhtn00u4oni0MybWaQ9XPTb9zMnB9C8OfarRvWV4uGrtxc
         LleLCpWpykr2kmEHTDpJeu8uWoWFmWr2QnVlUayOJtJOx+GBKmAllAGs7IqpJ+vAM3lw
         wotJ2C1hDIIAxF8b6gChey19pp9e0DK3c3Mo0en5KcddryJqt9oM0iXwhAnkrYuL82Ny
         0ceqpH90ZF6SVvv379VgKhk/kreQbAZyY9UScuUqP01hEmj6awWPPPfVOFtk8SZdZOWY
         TDpDEbahdfOaiKTnn/WipVzJHYpktHHrB05g0cq6M+L4jHCRJOBXE4n6e9M097LPPfic
         a62g==
X-Forwarded-Encrypted: i=1; AJvYcCW22PzR1XiL6xp/Rbjoj57tFdpiVJNLr28+jn52ChD4SpASCN8Ps+UK7xeC7toosIpeNRDtP3yzrGbuSMw4VCFGC48h85ZRho3Zz4w8
X-Gm-Message-State: AOJu0YyEZWiP86l3LLGpV5PGbcUdbdJfQ0hJs+AHt01/NbsSuo4DKCR0
	9kEt+LU/oGWd3dzW+8Q2s1SKQDfuSFNfa3+dt1ui1aGTvOKSri4OIK9NlcEWJJUirWLx5X2eFZM
	pkW7yDFoLlC9o1csCgWfFpXrQXI0=
X-Google-Smtp-Source: AGHT+IEQohNPw/DmoD1HUpf44RoZQyg4HU7O7LTFf43+lfOqkLb9JiL6rGkvfvNABWXszM/1EHT0cczscdNURNTXWXE=
X-Received: by 2002:a17:90a:2f42:b0:2c9:90fa:b9f8 with SMTP id
 98e67ed59e1d1-2d3e4552325mr3078746a91.10.1723801458856; Fri, 16 Aug 2024
 02:44:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: lee bruce <xrivendell7@gmail.com>
Date: Fri, 16 Aug 2024 17:44:07 +0800
Message-ID: <CABOYnLx_dnqzpCW99G81DmOr+2UzdmZMk=T3uxwNxwz+R1RAwg@mail.gmail.com>
Subject: WARNING in get_pat_info
To: dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org, luto@kernel.org, 
	peterz@infradead.org
Cc: bp@alien8.de, hpa@zytor.com, mingo@redhat.com, 
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, wang1315768607@163.com, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello, I found a bug titled "WARNING in get_pat_info" with modified
syzkaller in the lasted upstream and lasted mm branches.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yuxin wang <wang1315768607@163.com>

TITLE: WARNING in get_pat_info
------------[ cut here ]------------
WARNING: CPU: 2 PID: 12458 at arch/x86/mm/pat/memtype.c:1002
get_pat_info+0x4b6/0x5c0 arch/x86/mm/pat/memtype.c:1002
arch/x86/mm/pat/memtype.c:1002
Modules linked in:
CPU: 2 PID: 12458 Comm: syz-executor.0 Not tainted 6.10.0 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:get_pat_info+0x4b6/0x5c0 arch/x86/mm/pat/memtype.c:1002
arch/x86/mm/pat/memtype.c:1002
Code: 00 00 00 48 89 de e8 79 28 54 00 48 83 fb 20 75 11 48 83 7c 24
18 00 74 6e 31 ff e8 74 23 54 00 eb 0b 31 ff e8 6b 23 54 00 90 <0f> 0b
90 bb ea ff ff ff 48 c7 44 24 40 0e 36 e0 45 4b c7 44 25 00
RSP: 0018:ffffc9000f3ff2a0 EFLAGS: 00010246
RAX: ffffffff81453f35 RBX: 0000000000000000 RCX: ffffc90013051000
RDX: ffffffff81453f35 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000f3ff3b0 R08: 000000000001fcbe R09: 000000000001fcbf
R10: dffffc0000000000 R11: fffffbfff1fdc6f6 R12: 1ffff92001e7fe5c
R13: dffffc0000000000 R14: 1ffff92001e7fe64 R15: 1ffff92001e7fe68
FS: 00007fb3403356c0(0000) GS:ffff888063500000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f74b7104000 CR3: 000000001c1ce000 CR4: 0000000000752ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
<TASK>
untrack_pfn+0x338/0x660 arch/x86/mm/pat/memtype.c:1104
arch/x86/mm/pat/memtype.c:1104
unmap_single_vma+0x20c/0x2c0 mm/memory.c:1819 mm/memory.c:1819
unmap_vmas+0x3d7/0x600 mm/memory.c:1885 mm/memory.c:1885
exit_mmap+0x279/0xce0 mm/mmap.c:3341 mm/mmap.c:3341
__mmput+0x120/0x3a0 kernel/fork.c:1343 kernel/fork.c:1343
mmput kernel/fork.c:1365 [inline]
dup_mm kernel/fork.c:1687 [inline]
mmput kernel/fork.c:1365 [inline] kernel/fork.c:1720
dup_mm kernel/fork.c:1687 [inline] kernel/fork.c:1720
copy_mm+0x1a5b/0x1fe0 kernel/fork.c:1720 kernel/fork.c:1720
copy_process+0x1cc7/0x3f70 kernel/fork.c:2373 kernel/fork.c:2373
kernel_clone+0x236/0x910 kernel/fork.c:2780 kernel/fork.c:2780
__do_sys_clone kernel/fork.c:2923 [inline]
__se_sys_clone kernel/fork.c:2907 [inline]
__do_sys_clone kernel/fork.c:2923 [inline] kernel/fork.c:2907
__se_sys_clone kernel/fork.c:2907 [inline] kernel/fork.c:2907
__x64_sys_clone+0x25d/0x2b0 kernel/fork.c:2907 kernel/fork.c:2907
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_x64 arch/x86/entry/common.c:52 [inline] arch/x86/entry/common.c:83
do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb33f67dde9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb340335078 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007fb33f7abf80 RCX: 00007fb33f67dde9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fb340335120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 000000000000000b R14: 00007fb33f7abf80 R15: 00007ffd35a9fb48
</TASK>


I use the same kernel as syzbot instance
git tree: upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122bfdb8980000
kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=8e5f5ae13ab96e5e
compiler: clang version 15.0.6

=* repro.c =*
#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/capability.h>
#include <sched.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mount.h>
#include <sys/prctl.h>
#include <sys/resource.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

static void sleep_ms(uint64_t ms) { usleep(ms * 1000); }

static uint64_t current_time_ms(void) {
struct timespec ts;
if (clock_gettime(CLOCK_MONOTONIC, &ts)) exit(1);
return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static bool write_file(const char* file, const char* what, ...) {
char buf[1024];
va_list args;
va_start(args, what);
vsnprintf(buf, sizeof(buf), what, args);
va_end(args);
buf[sizeof(buf) - 1] = 0;
int len = strlen(buf);
int fd = open(file, O_WRONLY | O_CLOEXEC);
if (fd == -1) return false;
if (write(fd, buf, len) != len) {
int err = errno;
close(fd);
errno = err;
return false;
}
close(fd);
return true;
}

#define MAX_FDS 30

static void setup_common() {
if (mount(0, "/sys/fs/fuse/connections", "fusectl", 0, 0)) {
}
}

static void setup_binderfs() {
if (mkdir("/dev/binderfs", 0777)) {
}
if (mount("binder", "/dev/binderfs", "binder", 0, NULL)) {
}
if (symlink("/dev/binderfs", "./binderfs")) {
}
}

static void loop();

static void sandbox_common() {
prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
setsid();
struct rlimit rlim;
rlim.rlim_cur = rlim.rlim_max = (200 << 20);
setrlimit(RLIMIT_AS, &rlim);
rlim.rlim_cur = rlim.rlim_max = 32 << 20;
setrlimit(RLIMIT_MEMLOCK, &rlim);
rlim.rlim_cur = rlim.rlim_max = 136 << 20;
setrlimit(RLIMIT_FSIZE, &rlim);
rlim.rlim_cur = rlim.rlim_max = 1 << 20;
setrlimit(RLIMIT_STACK, &rlim);
rlim.rlim_cur = rlim.rlim_max = 128 << 20;
setrlimit(RLIMIT_CORE, &rlim);
rlim.rlim_cur = rlim.rlim_max = 256;
setrlimit(RLIMIT_NOFILE, &rlim);
if (unshare(CLONE_NEWNS)) {
}
if (mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL)) {
}
if (unshare(CLONE_NEWIPC)) {
}
if (unshare(0x02000000)) {
}
if (unshare(CLONE_NEWUTS)) {
}
if (unshare(CLONE_SYSVSEM)) {
}
typedef struct {
const char* name;
const char* value;
} sysctl_t;
static const sysctl_t sysctls[] = {
{"/proc/sys/kernel/shmmax", "16777216"},
{"/proc/sys/kernel/shmall", "536870912"},
{"/proc/sys/kernel/shmmni", "1024"},
{"/proc/sys/kernel/msgmax", "8192"},
{"/proc/sys/kernel/msgmni", "1024"},
{"/proc/sys/kernel/msgmnb", "1024"},
{"/proc/sys/kernel/sem", "1024 1048576 500 1024"},
};
unsigned i;
for (i = 0; i < sizeof(sysctls) / sizeof(sysctls[0]); i++)
write_file(sysctls[i].name, sysctls[i].value);
}

static int wait_for_loop(int pid) {
if (pid < 0) exit(1);
int status = 0;
while (waitpid(-1, &status, __WALL) != pid) {
}
return WEXITSTATUS(status);
}

static void drop_caps(void) {
struct __user_cap_header_struct cap_hdr = {};
struct __user_cap_data_struct cap_data[2] = {};
cap_hdr.version = _LINUX_CAPABILITY_VERSION_3;
cap_hdr.pid = getpid();
if (syscall(SYS_capget, &cap_hdr, &cap_data)) exit(1);
const int drop = (1 << CAP_SYS_PTRACE) | (1 << CAP_SYS_NICE);
cap_data[0].effective &= ~drop;
cap_data[0].permitted &= ~drop;
cap_data[0].inheritable &= ~drop;
if (syscall(SYS_capset, &cap_hdr, &cap_data)) exit(1);
}

static int do_sandbox_none(void) {
if (unshare(CLONE_NEWPID)) {
}
int pid = fork();
if (pid != 0) return wait_for_loop(pid);
setup_common();
sandbox_common();
drop_caps();
if (unshare(CLONE_NEWNET)) {
}
write_file("/proc/sys/net/ipv4/ping_group_range", "0 65535");
setup_binderfs();
loop();
exit(1);
}

static int inject_fault(int nth) {
int fd;
fd = open("/proc/thread-self/fail-nth", O_RDWR);
if (fd == -1) exit(1);
char buf[16];
sprintf(buf, "%d", nth);
if (write(fd, buf, strlen(buf)) != (ssize_t)strlen(buf)) exit(1);
return fd;
}

static void kill_and_wait(int pid, int* status) {
kill(-pid, SIGKILL);
kill(pid, SIGKILL);
for (int i = 0; i < 100; i++) {
if (waitpid(-1, status, WNOHANG | __WALL) == pid) return;
usleep(1000);
}
DIR* dir = opendir("/sys/fs/fuse/connections");
if (dir) {
for (;;) {
struct dirent* ent = readdir(dir);
if (!ent) break;
if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
continue;
char abort[300];
snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
ent->d_name);
int fd = open(abort, O_WRONLY);
if (fd == -1) {
continue;
}
if (write(fd, abort, 1) < 0) {
}
close(fd);
}
closedir(dir);
} else {
}
while (waitpid(-1, status, __WALL) != pid) {
}
}

static void setup_test() {
prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
setpgrp();
write_file("/proc/self/oom_score_adj", "1000");
}

static void close_fds() {
for (int fd = 3; fd < MAX_FDS; fd++) close(fd);
}

static void setup_fault() {
static struct {
const char* file;
const char* val;
bool fatal;
} files[] = {
{"/sys/kernel/debug/failslab/ignore-gfp-wait", "N", true},
{"/sys/kernel/debug/fail_futex/ignore-private", "N", false},
{"/sys/kernel/debug/fail_page_alloc/ignore-gfp-highmem", "N", false},
{"/sys/kernel/debug/fail_page_alloc/ignore-gfp-wait", "N", false},
{"/sys/kernel/debug/fail_page_alloc/min-order", "0", false},
};
unsigned i;
for (i = 0; i < sizeof(files) / sizeof(files[0]); i++) {
if (!write_file(files[i].file, files[i].val)) {
if (files[i].fatal) exit(1);
}
}
}

#define USLEEP_FORKED_CHILD (3 * 50 * 1000)

static long handle_clone_ret(long ret) {
if (ret != 0) {
return ret;
}
usleep(USLEEP_FORKED_CHILD);
syscall(__NR_exit, 0);
while (1) {
}
}

static long syz_clone(volatile long flags, volatile long stack,
volatile long stack_len, volatile long ptid,
volatile long ctid, volatile long tls) {
long sp = (stack + stack_len) & ~15;
long ret = (long)syscall(__NR_clone, flags & ~CLONE_VM, sp, ptid, ctid, tls);
return handle_clone_ret(ret);
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void) {
int iter = 0;
for (;; iter++) {
int pid = fork();
if (pid < 0) exit(1);
if (pid == 0) {
setup_test();
execute_one();
close_fds();
exit(0);
}
int status = 0;
uint64_t start = current_time_ms();
for (;;) {
if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid) break;
sleep_ms(1);
if (current_time_ms() - start < 5000) continue;
kill_and_wait(pid, &status);
break;
}
}
}

uint64_t r[1] = {0xffffffffffffffff};

void execute_one(void) {
intptr_t res = 0;
memcpy((void*)0x20000080, "/dev/hpet\000", 10);
res = syscall(__NR_openat, /*fd=*/0xffffffffffffff9cul, /*file=*/0x20000080ul,
/*flags=*/0ul, /*mode=*/0ul);
if (res != -1) r[0] = res;
syscall(__NR_mmap, /*addr=*/0x20ffa000ul, /*len=*/0x1000ul, /*prot=*/4ul,
/*flags=*/0x2a051ul, /*fd=*/r[0], /*offset=*/0ul);
inject_fault(32);
syz_clone(/*flags=*/0, /*stack=*/0, /*stack_len=*/0, /*parentid=*/0,
/*childtid=*/0, /*tls=*/0);
}
int main(void) {
syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
/*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul,
/*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
/*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
setup_fault();
do_sandbox_none();
return 0;
}


=* repro.txt =*
r0 = openat$hpet(0xffffffffffffff9c, &(0x7f0000000080), 0x0, 0x0)
mmap$IORING_OFF_SQ_RING(&(0x7f0000ffa000/0x1000)=nil, 0x1000, 0x4,
0x2a051, r0, 0x0)
syz_clone(0x0, 0x0, 0x0, 0x0, 0x0, 0x0) (fail_nth: 32)

and see also  https://gist.github.com/xrivendell7/37a37163f25eaee5133174f2a3d507b4.

I hope it helps.
Best regards
xingwei lee

