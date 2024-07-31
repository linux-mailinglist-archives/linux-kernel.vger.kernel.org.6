Return-Path: <linux-kernel+bounces-268334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE3694234A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 01:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFA69B24A71
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1578A191F72;
	Tue, 30 Jul 2024 23:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cmKg1I5m"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A47191F88
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 23:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722380958; cv=none; b=oM6FdAJ5dEDz0JtUJnLVsi22aGWWSALD14sj/OvpOjWm7RNJik3FNqHwo9DpLI5oRQEOvPBkoisTWVr7QCIqizYov6qDaLOQb0uFtpNHliup1Sj/k287HKjVld1Y2evsti8vErDjmlW43cHf6n1CYj7Ec19tdWUXhqYaoafRTTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722380958; c=relaxed/simple;
	bh=CWVd7zM9rhEDHEgTLc2FZInKf8KJxygX6mGY0ypXKWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jaW/7kaqSPjg6zhP1Aa22iQXZKKVY6hDivAvqTrRDQXRu5dvkPlwICFqXJiMe+yXNTYqkwg19SN3X4wInFtYFprLihl5YOG3ytyQrEUJMXISTvgRadSiK+gzcqLGhmLV9QqP3bey8j7ufr+VlDKJRS6O6QgKF3M2SaisdXNQ27k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cmKg1I5m; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so5603a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722380954; x=1722985754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjNkuxlo0ObgZ1OMPHSYwFfZSih4s+xQbxCeuhHEjJ8=;
        b=cmKg1I5mX37YPfk7J45ktgYwzynJb+rhhe2lT/qprMfu+0pcFepEhRg/JU7V+SMre/
         Dj2CFCe+tWRUi/IphtxoU587VqrjoMDRU7Zru2PpXWYCH/RdKF+diI5ulV3zulZOGYXf
         zNzLWTw9gUyKkxwW4wtvw5DQxBlDomWb2SBk3gbsXHxebYe7XkB/5b1Euf3VLL8DBS6n
         k3cQ1f5Pq8swSSULg3BAom7lqx+kX8dcdGR6LsOsRKp/NGfa4PwimotFJFvPbwGxgXrc
         YNbyrfZd68KFRGL9WR31B55HuMOV7RW2cVxCcG29oz1TYTKQ2l19HiKsMWPuJf/HDry2
         0VNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722380954; x=1722985754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjNkuxlo0ObgZ1OMPHSYwFfZSih4s+xQbxCeuhHEjJ8=;
        b=Kfy2God6tFhYZretcGWCwnJwKDav13qSHDJoHJnGr9UCoi6OZz7QbiFRhSwnmYOlMB
         XspLWkuwzX3cqngXLYyRaRVkPbSSJCzP9ABgkvTIt0UwkZJynZGzGv3YSuhPWNG/rM1K
         CQcdtuQgAi5g6wawd7xVC1kAx9K9OamD0iEQCNOrUdBPLIzoUjHRN546z/05CGTiTfni
         0fTy0SuR2aVKixgo9ALa27e9hAYZtBChfIHcrBo7V9G/xM6bz0xUgU5gjIParSi92NhU
         gYlNw/2KLXa68hVkogqhpGJ753J/5ZkkyrcPGF8+M9gTGC3Fle9c/Pct4x7w47ME6Z4P
         4ptA==
X-Forwarded-Encrypted: i=1; AJvYcCWxzOZnB/WmUiQLrE53E4zR4hbqVHDEzB3uwEZMp672tKkApz2SMqQ9e1hA/S65nsTFkMt+V4KW7tx8ZDBAR95KqFN/M9Dlg2+egT1x
X-Gm-Message-State: AOJu0Ywdz1Fvj/8XGA4qDQcfwSxPd23/YbStsy1k+FNt/qJHTtfawnbj
	dRIGw6cycBFEFYw9joZy7+xXVjIUlhHfs+x0VDGygOFyWxAVdUUMJyJ80MluAMuO1OvZTxKHWEU
	/txG/5HUQdrbZklfCjMedMP7ZPls9KinuTaJjhKn2KOeAUqmBu0Py
X-Google-Smtp-Source: AGHT+IH+kXuAL1vOqrJzmA/QRhTgNKgTz0m4/UBL6ewOha80SzsUMO+qu6d5uTxBn8caVXZ7VkevjmeYWxFQcqWsWcs=
X-Received: by 2002:a05:6402:11cd:b0:5ac:4ce3:8f6a with SMTP id
 4fb4d7f45d1cf-5b58ea443d5mr73654a12.6.1722380953925; Tue, 30 Jul 2024
 16:09:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730132528.1143520-1-adrian.ratiu@collabora.com>
In-Reply-To: <20240730132528.1143520-1-adrian.ratiu@collabora.com>
From: Jeff Xu <jeffxu@google.com>
Date: Tue, 30 Jul 2024 16:08:35 -0700
Message-ID: <CALmYWFumfPxoEE-jJEadnep=38edT7KZaY7KO9HLod=tdsOG=w@mail.gmail.com>
Subject: Re: [PATCH v4] proc: add config & param to block forcing mem writes
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	kernel@collabora.com, gbiv@google.com, inglorion@google.com, 
	ajordanr@google.com, Doug Anderson <dianders@chromium.org>, Jann Horn <jannh@google.com>, 
	Kees Cook <kees@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 6:25=E2=80=AFAM Adrian Ratiu <adrian.ratiu@collabor=
a.com> wrote:
>
> This adds a Kconfig option and boot param to allow removing
> the FOLL_FORCE flag from /proc/pid/mem write calls because
> it can be abused.
>
> The traditional forcing behavior is kept as default because
> it can break GDB and some other use cases.
>
> Previously we tried a more sophisticated approach allowing
> distributions to fine-tune /proc/pid/mem behavior, however
> that got NAK-ed by Linus [1], who prefers this simpler
> approach with semantics also easier to understand for users.
>
> Link: https://lore.kernel.org/lkml/CAHk-=3DwiGWLChxYmUA5HrT5aopZrB7_2VTa0=
NLZcxORgkUe5tEQ@mail.gmail.com/ [1]
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Jeff Xu <jeffxu@google.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
> Changes in v4:
> * Fixed doc punctuation, used passive tense, improved
>   wording consistency, fixed default value wording
> * Made struct constant_table a static const __initconst
> * Reworked proc_mem_foll_force() indentation and var
>   declarations to make code clearer
> * Reworked enum + struct definition so lookup_constant()
>   defaults to 'always'.
>
> Changes in v3:
> * Simplified code to use shorthand ifs and a
>   lookup_constant() table
>
> Changes in v2:
> * Added bootparam on top of Linus' patch
> * Slightly reworded commit msg
> ---
>  .../admin-guide/kernel-parameters.txt         | 10 ++++
>  fs/proc/base.c                                | 54 ++++++++++++++++++-
>  security/Kconfig                              | 32 +++++++++++
>  3 files changed, 95 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index f1384c7b59c9..8396e015aab3 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4788,6 +4788,16 @@
>         printk.time=3D    Show timing data prefixed to each printk messag=
e line
>                         Format: <bool>  (1/Y/y=3Denable, 0/N/n=3Ddisable)
>
> +       proc_mem.force_override=3D [KNL]
> +                       Format: {always | ptrace | never}
> +                       Traditionally /proc/pid/mem allows memory permiss=
ions to be
> +                       overridden without restrictions. This option may =
be set to
> +                       restrict that. Can be one of:
> +                       - 'always': traditional behavior always allows me=
m overrides.
> +                       - 'ptrace': only allow mem overrides for active p=
tracers.
> +                       - 'never':  never allow mem overrides.
> +                       If not specified, default is the CONFIG_PROC_MEM_=
* choice.
> +
>         processor.max_cstate=3D   [HW,ACPI]
>                         Limit processor to maximum C-state
>                         max_cstate=3D9 overrides any DMI blacklist limit.
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 72a1acd03675..daacb8070042 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -85,6 +85,7 @@
>  #include <linux/elf.h>
>  #include <linux/pid_namespace.h>
>  #include <linux/user_namespace.h>
> +#include <linux/fs_parser.h>
>  #include <linux/fs_struct.h>
>  #include <linux/slab.h>
>  #include <linux/sched/autogroup.h>
> @@ -117,6 +118,35 @@
>  static u8 nlink_tid __ro_after_init;
>  static u8 nlink_tgid __ro_after_init;
>
> +enum proc_mem_force {
> +       PROC_MEM_FORCE_ALWAYS,
> +       PROC_MEM_FORCE_PTRACE,
> +       PROC_MEM_FORCE_NEVER
> +};
> +
> +static enum proc_mem_force proc_mem_force_override __ro_after_init =3D
> +       IS_ENABLED(CONFIG_PROC_MEM_NO_FORCE) ? PROC_MEM_FORCE_NEVER :
> +       IS_ENABLED(CONFIG_PROC_MEM_FORCE_PTRACE) ? PROC_MEM_FORCE_PTRACE =
:
> +       PROC_MEM_FORCE_ALWAYS;
> +
> +static const struct constant_table proc_mem_force_table[] __initconst =
=3D {
> +       { "never", PROC_MEM_FORCE_NEVER },
> +       { "ptrace", PROC_MEM_FORCE_PTRACE },
> +       { }
> +};
> +
> +static int __init early_proc_mem_force_override(char *buf)
> +{
> +       if (!buf)
> +               return -EINVAL;
> +
> +       proc_mem_force_override =3D lookup_constant(proc_mem_force_table,
> +                                                 buf, PROC_MEM_FORCE_ALW=
AYS);
proc_mem_force_table has two entries, this means:
if kernel cmdline has proc_mem.force_override=3D"invalid",
    PROC_MEM_FORCE_ALWAYS will be used.

Another option is to have 3 entries in proc_mem_force_table: adding
{"aways", PROC_MEM_FORCE_ALWAYS}

and let lookup_constant return -1 when not found, and not override
proc_mem_force_override.

This enforces the kernel cmd line must be set to one of three choices
"always|ptrace|never" to be effective.

If you choose this path: please modify kernel-parameters.txt to
"If not specified or invalid, default is the CONFIG_PROC_MEM_* choice."

or else please clarify in the kernel-parameters.text:
If not specified, default is the CONFIG_PROC_MEM_* choice
If invalid str or empty string, PROC_MEM_FORCE_ALWAYS will be used
regardless CONFIG_PROC_MEM_* choice

> +
> +       return 0;
> +}
> +early_param("proc_mem.force_override", early_proc_mem_force_override);
> +
>  struct pid_entry {
>         const char *name;
>         unsigned int len;
> @@ -835,6 +865,26 @@ static int mem_open(struct inode *inode, struct file=
 *file)
>         return ret;
>  }
>
> +static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
> +{
> +       struct task_struct *task;
> +       bool ptrace_active =3D false;
> +
> +       switch (proc_mem_force_override) {
> +       case PROC_MEM_FORCE_NEVER:
> +               return false;
> +       case PROC_MEM_FORCE_PTRACE:
> +               task =3D get_proc_task(file_inode(file));
> +               if (task) {
> +                       ptrace_active =3D task->ptrace && task->mm =3D=3D=
 mm && task->parent =3D=3D current;
Do we need to call "read_lock(&tasklist_lock);" ?
see comments in ptrace_check_attach() of  kernel/ptrace.c



> +                       put_task_struct(task);
> +               }
> +               return ptrace_active;
> +       default:
> +               return true;
> +       }
> +}
> +
>  static ssize_t mem_rw(struct file *file, char __user *buf,
>                         size_t count, loff_t *ppos, int write)
>  {
> @@ -855,7 +905,9 @@ static ssize_t mem_rw(struct file *file, char __user =
*buf,
>         if (!mmget_not_zero(mm))
>                 goto free;
>
> -       flags =3D FOLL_FORCE | (write ? FOLL_WRITE : 0);
> +       flags =3D write ? FOLL_WRITE : 0;
> +       if (proc_mem_foll_force(file, mm))
> +               flags |=3D FOLL_FORCE;
>
>         while (count > 0) {
>                 size_t this_len =3D min_t(size_t, count, PAGE_SIZE);
> diff --git a/security/Kconfig b/security/Kconfig
> index 412e76f1575d..a93c1a9b7c28 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -19,6 +19,38 @@ config SECURITY_DMESG_RESTRICT
>
>           If you are unsure how to answer this question, answer N.
>
> +choice
> +       prompt "Allow /proc/pid/mem access override"
> +       default PROC_MEM_ALWAYS_FORCE
> +       help
> +         Traditionally /proc/pid/mem allows users to override memory
> +         permissions for users like ptrace, assuming they have ptrace
> +         capability.
> +
> +         This allows people to limit that - either never override, or
> +         require actual active ptrace attachment.
> +
> +         Defaults to the traditional behavior (for now)
> +
> +config PROC_MEM_ALWAYS_FORCE
> +       bool "Traditional /proc/pid/mem behavior"
> +       help
> +         This allows /proc/pid/mem accesses to override memory mapping
> +         permissions if you have ptrace access rights.
> +
> +config PROC_MEM_FORCE_PTRACE
> +       bool "Require active ptrace() use for access override"
> +       help
> +         This allows /proc/pid/mem accesses to override memory mapping
> +         permissions for active ptracers like gdb.
> +
> +config PROC_MEM_NO_FORCE
> +       bool "Never"
> +       help
> +         Never override memory mapping permissions
> +
> +endchoice
> +
>  config SECURITY
>         bool "Enable different security models"
>         depends on SYSFS
> --
> 2.44.2
>

