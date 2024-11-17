Return-Path: <linux-kernel+bounces-412032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A79D39D029C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 10:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BAC91F2310D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 09:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17CE4962C;
	Sun, 17 Nov 2024 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="gvhQoNPh"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392923EA76
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731836464; cv=none; b=WrM4glB8OTMXuB0k3QXtM1JekUApL2iY8ZIeK4a+xIjiGEU74iG9w8a1uruKw4IjJcXKJoeZoq53xJlqk/0O03adN1ZW7DsZ350PwdXykJhNVlHHUOuixNDIJd8YJW8KbEB5lyNDJEa5KCtUJ2qzL3cvkDg57MAej3n3fxHpHcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731836464; c=relaxed/simple;
	bh=94RR1ndMUE3EJvcQaek2Kz2Eo7xWcJ1KSiCau51SDZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tt4TtH7QmaqKtsSEfFTWRdSR2zxKJ/XJIieK5utd7aNKucCzsVNL6KjogR5gIin26KjyxdlLLjh2CllHNhzg2X4VjQ6ptjKKBNh8cT6lOFppYExTsSQyT20NUO5a83F3CiOSCz/06LiId2FHj3zv6YqU660XS3obVXxiHDlZFz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=gvhQoNPh; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso18285581fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 01:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1731836460; x=1732441260; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r0vkQnlPX7Osx1R0ihb3Xcb9qrzixFmycZmYsFz9EQ8=;
        b=gvhQoNPhig+1lj7B7x2N0vFdhyxcSOx7JsiGMgBp8CDgh/i1G9QL7uBrmG5TQhcNOR
         TmcfiPGcj+DfV6g8mv3KjKB0ZSiCmdTIBDqNZTxISwxwXCEEXL1hSWEXeWFpJZN89Zjc
         vgbCeCHgzDLcAvWtEJPHlK1wCa27Jg5Ug24L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731836460; x=1732441260;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r0vkQnlPX7Osx1R0ihb3Xcb9qrzixFmycZmYsFz9EQ8=;
        b=ju4+II9YeGoPMPp2r1bfQfUgoINCjQnTZYQbfGR103hjxyxXmxP5A96OcU1FAVwDGw
         cL0gFT3BqypBjnhFdWdSQLhd9nrCtnuZcqIZNlN078p84b63tLyVbn6ZDqjp7mnkwS+h
         HlYuUw+1rxZtxcBT49RBIyVa+43WUPm8GELXPl5L7m5BSm2CqaqO3e5RvIOr2wMato20
         igfg1xfzfP9662HhjbqPN9LXxiOUu3LLa8EC0bpgS2zKK6OraKWGZTAhB+CP2IMtl+m/
         us+co9LxEcLY5zh8o9XHJfDDYtczhz2PnK992plWKVY5LnaKrwGu2+ZWJAMz/d1cqhHA
         g5FA==
X-Gm-Message-State: AOJu0Ywgu0lydLDyszZDn2C25zZDBtc9NdWlm4jyzkCr4a2RMThhoqiu
	mX3tFDBr2pd4PAzc10lU/Y8DmpL99/XfgflAXP5w+J9nb6ExaU7XXGmsZcDksVIbT5t5oUAvLpD
	ceGY/ScL597I4EtaQlgpoMU/vsaJCQb4tzb6ePw==
X-Google-Smtp-Source: AGHT+IF1f+GnPNQ9RGdc9ox4dgArFdfUj4a+MPz9GR4EK/s7XmspgsmLno/N0uoksotd0Bz8qbxudcwDWZ1YFASgK6Y=
X-Received: by 2002:a2e:a883:0:b0:2ff:4ce0:d233 with SMTP id
 38308e7fff4ca-2ff6070d898mr41805451fa.28.1731836459796; Sun, 17 Nov 2024
 01:40:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241117091313.10251-1-stsp2@yandex.ru>
In-Reply-To: <20241117091313.10251-1-stsp2@yandex.ru>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Sun, 17 Nov 2024 10:40:48 +0100
Message-ID: <CAJqdLrp4J57k67R3OWM-_6QZSv8EV9UANzdAtBCiLGQZPTXDcQ@mail.gmail.com>
Subject: Re: [PATCH net v2] scm: fix negative fds with SO_PASSPIDFD
To: Stas Sergeev <stsp2@yandex.ru>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am So., 17. Nov. 2024 um 10:13 Uhr schrieb Stas Sergeev <stsp2@yandex.ru>:
>
> pidfd_prepare() can return negative values as an error codes.
> But scm_pidfd_recv() didn't check for that condition.
> As the result, it is possible to create the race that leads to
> the negative fds. The race happens if the peer process sends
> something to SO_PASSPIDFD-enabled recipient, and quickly exits.
> pidfd_prepare() has this code:
>
>     if (!pid || !pid_has_task(pid, thread ? PIDTYPE_PID : PIDTYPE_TGID))
>             return -EINVAL;
>
> So if you exit quickly enough, you can hit that EINVAL.
> Getting the fd=-22 is very weird, if not exploitable.
>
> This patch adds the missing check and sets MSG_CTRUNC on error.
> Recipient can now detect an error by checking this flag.
>
> Changes in v2: add Fixes tag
>
> Signed-off-by: Stas Sergeev <stsp2@yandex.ru>

Hi Stas,

Actually, it's not a forgotten check. It's intended behavior to pass
through errors from pidfd_prepare() to
the userspace. In my first version [1] of the patch I tried to return
ESRCH instead of EINVAL in your case, but
then during discussions we decided to remove that.

[1] https://lore.kernel.org/all/20230316131526.283569-2-aleksandr.mikhalitsyn@canonical.com/

Kind regards,
Alex

>
> Fixes: 5e2ff6704a2 ("scm: add SO_PASSPIDFD and SCM_PIDFD")
>
> CC: Alexander Mikhalitsyn <alexander@mihalicyn.com>
> CC: "David S. Miller" <davem@davemloft.net>
> CC: Eric Dumazet <edumazet@google.com>
> CC: Jakub Kicinski <kuba@kernel.org>
> CC: Paolo Abeni <pabeni@redhat.com>
> CC: Simon Horman <horms@kernel.org>
> CC: Christian Brauner <brauner@kernel.org>
> CC: Kees Cook <kees@kernel.org>
> CC: Kuniyuki Iwashima <kuniyu@amazon.com>
> CC: netdev@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  include/net/scm.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/net/scm.h b/include/net/scm.h
> index 0d35c7c77a74..3ccf8546c506 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -155,6 +155,10 @@ static __inline__ void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm
>                 return;
>
>         pidfd = pidfd_prepare(scm->pid, 0, &pidfd_file);
> +       if (pidfd < 0) {
> +               msg->msg_flags |= MSG_CTRUNC;
> +               return;
> +       }
>
>         if (put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd)) {
>                 if (pidfd_file) {
> --
> 2.47.0
>

