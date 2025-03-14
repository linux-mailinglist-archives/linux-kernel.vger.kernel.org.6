Return-Path: <linux-kernel+bounces-561528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA09A61310
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0509463751
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A0D1FFC45;
	Fri, 14 Mar 2025 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="UiAKAJ/r"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A1C2E336A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741960349; cv=none; b=n0nO1numgfKG4PGuImO0T1vl4RTfBhFIiaX0j8cIos+odmassBoDAJ6zp7mJGfnWHWYhRccqbCA9NsrmU4bR8hNzucDeIQdnBwlynh3r4PinLW35OW0Pk6H5muUk2thYgW9gM/WoOtqTP8FfnEK/qrzWf6FvT2jlkv8IOERjb+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741960349; c=relaxed/simple;
	bh=l6eRw8y1OmUmjOlCM4cZJphcNpxH4Gsq7pdQ03d5ry0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQVGbuOvsnQWBozWCPB/6d/F2b4RVS2b/vI/Vxt7JFeDxwPpA9nqoNtudkS59EQcfewpMbsy7GuFlDwiBWLrhEpQYlmFvoVRQuMc61BIGb58P2RVlZb3KYJiXUFv2NE6YxPJ2YxGtpbXAZkQRwIkP5fFzLNpNlkitk6AX/7hDdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=UiAKAJ/r; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5499da759e8so3515020e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1741960346; x=1742565146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zycopCDnnU2i+AkSw46WgSJrqCJCcusa0YK3FYhw6i4=;
        b=UiAKAJ/rNUakfpPKB5pgexS7OOXHIuUxYQTOuBgfaQp8cIhLvXptPPI2VI+HEZAsDo
         h50wbuOP8HYLAxAvN93rSMMsVSjU1XC7H7u51HmwdiOpU3wtGlq0di4k62P3EAo70ndG
         yhu4q/Y42gKD9noUiTMAufsV5KC44kNhJ46Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741960346; x=1742565146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zycopCDnnU2i+AkSw46WgSJrqCJCcusa0YK3FYhw6i4=;
        b=u8ZJvAj7wMLN+1BdFNlS2V989ttYm6SLle94YMPJ03lwqIOnSFbGiuVyxoJDOqbi5m
         TZp5sY57Y4QQUulCS9hNVSGuryPY0v93bF3ckhZs8Oa46cP8S9NI8pwoWkcWoAFN3PD3
         3OrzmYpJ98LAIRPijvi4hOAe/V/iClYLclxVCtDGxT21E1KHSpe54Z1G6eYODpbLFxf7
         EC60gkq5S3JamG5Td1HucDi277dgJCWiPdSYThpLp/2VyAU9WN4KgZtlcO6eIgF9QeRm
         Y+fw9pgNpGV3owiUNmz5wvlJah0cMeMbpP4SgEoiUIKXOdYG3w9XH8EKGlHupSDNflLP
         95BA==
X-Forwarded-Encrypted: i=1; AJvYcCWCcsnMX5WyWop9Zs7MeFPlBkERy2A/mmNeyd9sRZ71xsNP1C0e2dVy0oLRPFXBcYRJ1IUE8FD6f/2r1PY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVaEiBdu0ZHNO7NfFP5B8hKkVFb12UlVsEg0+ODI9B4hYKuZst
	SnWwNyWgHMR48+fhhvNHnTr9W2nPIY+uxYv6/1Cfraujfs/nO9Wd3s5JDwkTfnKCe5GRGjFEzRw
	YImdrAIeZcVKspAB9Qks1V7XqztsR96INsyaPig==
X-Gm-Gg: ASbGncs4DmuDhyC1tBU/0IA36GPvuVQIvMpbvAVE8hZXjm6SJsqNN2E0Ch68YuvDrh/
	WMDRwbwHdMTkC10LyiMl7LJRiHBBhZwoWGIVdljw4utbdsL94vj3UkLKdJQQf/70hg+DuYVhxCt
	vmXVbCUxKM4y93g/s0WGzOI+sjvR0=
X-Google-Smtp-Source: AGHT+IF9qRrJkTrrIobfvLSECzIZRaki1TnB6To26QFfRp9f28bu0YABV4vbDlhxwlNTG2VFpOb8agSVt6i2bJhSG7I=
X-Received: by 2002:a05:6512:1596:b0:549:965f:5960 with SMTP id
 2adb3069b0e04-549ba440077mr2663642e87.16.1741960345389; Fri, 14 Mar 2025
 06:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309121526.86670-1-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20250309121526.86670-1-aleksandr.mikhalitsyn@canonical.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 14 Mar 2025 14:52:14 +0100
X-Gm-Features: AQ5f1Jr2EEuusWFl1maY2c4eLIhTIDuLUbvGq7tTSg2w7PXhTO9cHpspBBibHY0
Message-ID: <CAJqdLrp+_nHnBCLoE8uUHCSOQsKhc+WFsN8kUVY08sR9aW5uiQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tools headers: Sync uapi/asm-generic/socket.h
 with the kernel sources
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: edumazet@google.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Willem de Bruijn <willemb@google.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Anna Emese Nyiri <annaemesenyiri@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am So., 9. M=C3=A4rz 2025 um 13:15 Uhr schrieb Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com>:
>
> This also fixes a wrong definitions for SCM_TS_OPT_ID & SO_RCVPRIORITY.
>
> Accidentally found while working on another patchset.
>
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Jason Xing <kerneljasonxing@gmail.com>
> Cc: Anna Emese Nyiri <annaemesenyiri@gmail.com>

+cc Paolo Abeni <pabeni@redhat.com>
+cc Kuniyuki Iwashima <kuniyu@amazon.com>

> Fixes: a89568e9be75 ("selftests: txtimestamp: add SCM_TS_OPT_ID test")
> Fixes: e45469e594b2 ("sock: Introduce SO_RCVPRIORITY socket option")
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>
> ---
>  tools/include/uapi/asm-generic/socket.h | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/tools/include/uapi/asm-generic/socket.h b/tools/include/uapi=
/asm-generic/socket.h
> index ffff554a5230..aa5016ff3d91 100644
> --- a/tools/include/uapi/asm-generic/socket.h
> +++ b/tools/include/uapi/asm-generic/socket.h
> @@ -119,14 +119,31 @@
>
>  #define SO_DETACH_REUSEPORT_BPF 68
>
> +#define SO_PREFER_BUSY_POLL    69
> +#define SO_BUSY_POLL_BUDGET    70
> +
> +#define SO_NETNS_COOKIE                71
> +
> +#define SO_BUF_LOCK            72
> +
> +#define SO_RESERVE_MEM         73
> +
> +#define SO_TXREHASH            74
> +
>  #define SO_RCVMARK             75
>
>  #define SO_PASSPIDFD           76
>  #define SO_PEERPIDFD           77
>
> -#define SCM_TS_OPT_ID          78
> +#define SO_DEVMEM_LINEAR       78
> +#define SCM_DEVMEM_LINEAR      SO_DEVMEM_LINEAR
> +#define SO_DEVMEM_DMABUF       79
> +#define SCM_DEVMEM_DMABUF      SO_DEVMEM_DMABUF
> +#define SO_DEVMEM_DONTNEED     80
> +
> +#define SCM_TS_OPT_ID          81
>
> -#define SO_RCVPRIORITY         79
> +#define SO_RCVPRIORITY         82
>
>  #if !defined(__KERNEL__)
>
> --
> 2.43.0
>

