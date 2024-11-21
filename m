Return-Path: <linux-kernel+bounces-416994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5399D4D6B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E173228112F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075A91D5CCF;
	Thu, 21 Nov 2024 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="U7z2Eg56"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2561D358D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732194246; cv=none; b=oIYKtOD0sbv2W0QJ9RjozWuP7RjRz0vYZqn9NEGnMnguuF1TYDNvP+XYB2+xRy+EFeIBecIMV6xWXaIrX5U88pyw314Oqx5nHwb1ZAx1fYC/HZN19vx0gXh7RJEl1UVhAK6pLkTvuchDU9NyaCphRrBaxroy2btnfKFtSf4iezY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732194246; c=relaxed/simple;
	bh=NGrZcFdcWSOdG64B42aeCuurKwAqveVQiGFal6pomAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmeTSQVuOoL/EoOjvkmi5j8b7cXXi8Ps8pWROVKixjaTO3aXlJW0H/VqRbL4gQeO+duvichrZEidv0i/5SfheQVuuUWQJXhEbiIOk9xOSyDpEnmlgGwz1lyRWFt1BHShvjcRJHGZJZoXa9oRb6mOZMANtD7kELGF9WaNT17WLdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=U7z2Eg56; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2E2E63F848
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 12:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1732193882;
	bh=NkMGboeB4JllcdtLoKopzE3i3ZmHlvAh51JdixnLmTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=U7z2Eg56vt55EYasFbCUKsjufz45oT6Pypt4GLZMaOoNmIsq0dcSkMSx11ffSO8VP
	 4GcQMDyYzk9IgWS71LkNTTfmGP9HQaCjDAHhtCC5hREA8VjRjh9C3Z2iyhWlxNVwnB
	 v0FBh9dJ8BtxuRgR2T5Kva68DtL9GF71pjea55mSi+Gqd6eUaKyCKfB0eR3+cAvPSH
	 vrYqeYoehYcIBQGKnPqVlJrNRISqe4JkUGyqp6vIKJiQcrC575IW4msMtkC/1PKn9t
	 JZ1YjwRQnxuqLyeG8xL/hF0q1G8YKWwMZI/l9eTP2HQ3u8B+6cDklsBL/Gyzhw2eWX
	 jzM16tdpWMUpw==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a99ea3e1448so57585566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 04:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732193881; x=1732798681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkMGboeB4JllcdtLoKopzE3i3ZmHlvAh51JdixnLmTg=;
        b=bQoG8njbUkC/BhNsCoG6rbY/QbdG7AI7COG9Ygn7NJ0im9dD8HNC2q9rg8oYEfhv/L
         kuc3BejUAokul12ZjAi4PzT481v+Ux8/t8QZCN/qLLKhN4h0RtD1TJq4SkI9OlcY4w06
         rXff1AklN9yLOrOSrJQd4A+H7QLeAonUHVWFNzsQJmlzT5HdroEGE3PWmxkIa66yWdoK
         ZkjsCB9EvIZGwdXhYu0/l9jIpG2DlvJNQgx/K64YB7/AvxvhESr2/utaNtUC8UNY+ug2
         mhX4WKhOC3gsr7CguXhQRjtkwmva8FGPJmvkBdGExPPKQpIHnpKkFdCrgwd6+qm/emEd
         pOKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnGheKZXLZSCiAWypue2kgpsINbDLz2R1f4nxjy7xYUgR/DFOhNvo9CLav8AH/iiDuzBHlWVCHI8H5O4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5m7cnIE7guH9BUDHzO+2F7ADT6jFi+YarPlBsqO7nzNShLDDb
	mS8YzQGlLopY/VzCIJ8syAkectkyUShgfIPBNuiu2SOS+3SLhOCXWMdEOoCqlUIY5RcRL974mpx
	jR4nCtN7WRrB1B5GODHXrEm8t/w6I7yQqpQI6yiQ7DxbX6KauXglS0qSfJBxwaLbnpEPVC3C7Ax
	8JWw==
X-Gm-Gg: ASbGnctWYs0NNAWkqBYsTkEHEvn+ldLvU134tzIyOhVwDB8wl7v34FdShAg26SERv9D
	Ju6V/gLeBZJu0dYFutPzwi0HHa4ThBFU7vOV2ZFPhcSox9BX8b+XB+TD3QTGp0qUZMZEaKI1/y8
	Hy5ockvMA0d18pDyGtyh6gSw/2TraSIgkbEkJU2T8HmEN3d8lkcKv55cuT7Zmb+cuqJ/TzjiTz/
	x7AHy9tEPKIk5qkvK9d6phru9g4kzz7JCS5FuBXvZpXLb35UrSnb6KB9xnnnrJECWhtzCsOx0sr
	tQ==
X-Received: by 2002:a17:907:9720:b0:a9a:55dd:bc23 with SMTP id a640c23a62f3a-aa4dd50a642mr542205366b.8.1732193880853;
        Thu, 21 Nov 2024 04:58:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFG6g7C3BDAlHohQX+vhiU+W2yyBeHXfdlriO8FaVjmCQHY0iBTKt6Ed0Pjpw0u8D6j+3lBRA==
X-Received: by 2002:a17:907:9720:b0:a9a:55dd:bc23 with SMTP id a640c23a62f3a-aa4dd50a642mr542204066b.8.1732193880498;
        Thu, 21 Nov 2024 04:58:00 -0800 (PST)
Received: from amikhalitsyn.lan ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f42d3109sm78221766b.132.2024.11.21.04.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 04:57:59 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: stsp2@yandex.ru
Cc: almasrymina@google.com,
	asml.silence@gmail.com,
	axboe@kernel.dk,
	brauner@kernel.org,
	cyphar@cyphar.com,
	davem@davemloft.net,
	edumazet@google.com,
	gouhao@uniontech.com,
	horms@kernel.org,
	kees@kernel.org,
	krisman@suse.de,
	kuba@kernel.org,
	kuniyu@amazon.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mhal@rbox.co,
	netdev@vger.kernel.org,
	oleg@redhat.com,
	pabeni@redhat.com,
	quic_abchauha@quicinc.com,
	shuah@kernel.org,
	tandersen@netflix.com,
	viro@zeniv.linux.org.uk,
	willemb@google.com,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: Re: [PATCH net-next v3] af_unix: pass pidfd flags via SCM_PIDFD cmsg
Date: Thu, 21 Nov 2024 13:57:32 +0100
Message-ID: <20241121125732.88044-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241116101120.323174-1-stsp2@yandex.ru>
References: <20241116101120.323174-1-stsp2@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>Currently SCM_PIDFD cmsg cannot be sent via unix socket
>(returns -EINVAL) and SO_PASSPIDFD doesn't support flags.
>The created pidfd always has flags set to 0.
>
>This patch implements SCM_PIDFD cmsg in AF_UNIX socket, which
>can be used to send flags to SO_PASSPIDFD-enabled recipient.
>
>Self-test is added for the propagation of PIDFD_NONBLOCK flag.

>This is mainly needed for the future extensions, like eg this one:
>https://lore.kernel.org/lkml/8288a08e-448b-43c2-82dc-59f87d0d9072@yandex.ru/T/#me1237e46deba8574b77834b7704e63559ffef9cb
>where it was suggested to try solving the supplementary groups
>problem with pidfd.
>
>Changes in v3: specify target tree in patch subject
>Changes in v2: remove flags validation in scm_pidfd_recv(), as
>  suggested by Kuniyuki Iwashima <kuniyu@amazon.com>
>
>Signed-off-by: Stas Sergeev <stsp2@yandex.ru>

...

>diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
>index 75bdf9807802..c4c5c1a0c2ad 100644
>--- a/include/linux/pidfs.h
>+++ b/include/linux/pidfs.h
>@@ -2,7 +2,16 @@
> #ifndef _LINUX_PID_FS_H
> #define _LINUX_PID_FS_H
> 
>+#include <uapi/linux/pidfd.h>
>+
> struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags);
> void __init pidfs_init(void);
> 
>+static inline int pidfd_validate_flags(unsigned int flags)
>+{
>+	if (flags & ~(PIDFD_NONBLOCK | PIDFD_THREAD))
>+		return -EINVAL;
>+	return 0;
>+}
>+
> #endif /* _LINUX_PID_FS_H */
>diff --git a/include/linux/socket.h b/include/linux/socket.h
>index d18cc47e89bd..ee27d391e5aa 100644
>--- a/include/linux/socket.h
>+++ b/include/linux/socket.h
>@@ -178,7 +178,7 @@ static inline size_t msg_data_left(struct msghdr *msg)
> #define	SCM_RIGHTS	0x01		/* rw: access rights (array of int) */
> #define SCM_CREDENTIALS 0x02		/* rw: struct ucred		*/
> #define SCM_SECURITY	0x03		/* rw: security label		*/
>-#define SCM_PIDFD	0x04		/* ro: pidfd (int)		*/
>+#define SCM_PIDFD	0x04		/* r: pidfd, w: pidfd_flags (int) */
> 
> struct ucred {
> 	__u32	pid;
>diff --git a/include/net/af_unix.h b/include/net/af_unix.h
>index 63129c79b8cb..4bc197548c2f 100644
>--- a/include/net/af_unix.h
>+++ b/include/net/af_unix.h
>@@ -62,6 +62,7 @@ struct unix_skb_parms {
> #ifdef CONFIG_SECURITY_NETWORK
> 	u32			secid;		/* Security ID		*/
> #endif
>+	u32			pidfd_flags;
> 	u32			consumed;
> } __randomize_layout;
> 
>diff --git a/include/net/scm.h b/include/net/scm.h
>index 0d35c7c77a74..1326edcacacb 100644
>--- a/include/net/scm.h
>+++ b/include/net/scm.h
>@@ -48,6 +48,7 @@ struct scm_cookie {
> #ifdef CONFIG_SECURITY_NETWORK
> 	u32			secid;		/* Passed security ID 	*/
> #endif
>+	u32			pidfd_flags;
> };
> 
> void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm);
>@@ -154,7 +155,7 @@ static __inline__ void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm
> 	if (!scm->pid)
> 		return;
> 
>-	pidfd = pidfd_prepare(scm->pid, 0, &pidfd_file);
>+	pidfd = pidfd_prepare(scm->pid, scm->pidfd_flags, &pidfd_file);
> 
> 	if (put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd)) {
> 		if (pidfd_file) {
>diff --git a/kernel/pid.c b/kernel/pid.c
>index 2715afb77eab..b1100ae8ea63 100644
>--- a/kernel/pid.c
>+++ b/kernel/pid.c
>@@ -629,10 +629,12 @@ static int pidfd_create(struct pid *pid, unsigned int flags)
> SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
> {
> 	int fd;
>+	int err;
> 	struct pid *p;
> 
>-	if (flags & ~(PIDFD_NONBLOCK | PIDFD_THREAD))
>-		return -EINVAL;
>+	err = pidfd_validate_flags(flags);
>+	if (err)
>+		return err;
> 
> 	if (pid <= 0)
> 		return -EINVAL;
>diff --git a/net/core/scm.c b/net/core/scm.c
>index 4f6a14babe5a..3bcdecdacd7e 100644
>--- a/net/core/scm.c
>+++ b/net/core/scm.c
>@@ -23,6 +23,7 @@
> #include <linux/security.h>
> #include <linux/pid_namespace.h>
> #include <linux/pid.h>
>+#include <linux/pidfs.h>
> #include <linux/nsproxy.h>
> #include <linux/slab.h>
> #include <linux/errqueue.h>
>@@ -210,6 +211,19 @@ int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *p)
> 			p->creds.gid = gid;
> 			break;
> 		}
>+		case SCM_PIDFD:
>+		{
>+			unsigned int flags;
>+
>+			if (cmsg->cmsg_len != CMSG_LEN(sizeof(flags)))
>

Hi Stas!

Hmm, it is a bit unusual that SCM_PIDFD message format is different in case
when you send it and when you read it.

I mean that when you read it (on the receiver side) you get pidfd file descriptor number,
while when you write it (on the sender side) you are only allowed to send one integer and this time it's
a pidfd file descriptor flags. I personally have nothing strictly against that but just found this
a bit unusual and probably confusing for userspace programmers.

Compare it with SCM_CREDENTIALS, for instance, where we read/write the same structure struct ucred.

>+				goto error;
>+			memcpy(&flags, CMSG_DATA(cmsg), sizeof(flags));
>+			err = pidfd_validate_flags(flags);

pidfd_validate_flags allows PIDFD_THREAD, but what's the idea behind this if
scm->pid is always a thread-group leader? (see maybe_add_creds() function).

Sorry if I misunderstand something just want to ensure that we are on the same page.

Kind regards,
Alex


