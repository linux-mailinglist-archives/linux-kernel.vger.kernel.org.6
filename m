Return-Path: <linux-kernel+bounces-557354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7376A5D7B2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF6777A38AB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF2822DFBE;
	Wed, 12 Mar 2025 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbEj16I8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120EF1E9B3F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766349; cv=none; b=JesXudW6ayoj3Q5XkOw1JpvKxk1wpyIiGpTRW3sx55ovfzbe79145PPuLREE8MeWRcILHsbERyojIxtYQoGsPIvVToKwKNZmb1LHt5TUMmECBkPLS59ytEdxVx0RY/NfZQW1a4oXTyHl9T1n0swzA4OSqxC2KfizlKRMHYGKO7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766349; c=relaxed/simple;
	bh=IrisppIwVRnGlJVZTg810G73qFO6PhKZXpjuQkMTNDY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s8LCWw2eYFMdqAxaqhKczpXe65cmxXgkN1nLRshRyVr2RoQ87P8MUVu7GA3kh9SovEBafkahbqPnhnjl/5n4V2I8OagsjAhxstARktJgcFHuKF+W4VO3GGaOvpsdgRCV1pxirmToXlLnJcY3JrUTkt7FkLq20UlX1SQ9B+QAJeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AbEj16I8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741766344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1YTb5atTpDH4Sw5lOFzwaFCjTjpSJD+CwGAkxUWoJK0=;
	b=AbEj16I84H0MCwH2ZLm7j2IPTBemC0lJa6wNObfhzwJ7rjQu4GXuAlPJrO7/489Kelofb/
	//K7PsNN0gHsaJZPgFomm/YzrPTaIpdS0CJqK90huhFnvsZIeWi6BgD/HQjGhyK1Q3jBcP
	G2ORg0VPRzAWj19dvh12B18SfSLlr7I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-y0WLHrpUNFySla9_j5krkQ-1; Wed, 12 Mar 2025 03:59:00 -0400
X-MC-Unique: y0WLHrpUNFySla9_j5krkQ-1
X-Mimecast-MFC-AGG-ID: y0WLHrpUNFySla9_j5krkQ_1741766339
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43947a0919aso52843295e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 00:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741766339; x=1742371139;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YTb5atTpDH4Sw5lOFzwaFCjTjpSJD+CwGAkxUWoJK0=;
        b=uP+gZTPzBkvhYoawgoDCXtaeIi0tTmehIAoRsDDs0vhsNNSAEr4SHMFiDUBqW8nkWF
         XrFx6icfF1W5ffMsjh0BEVstV/bdH/C0m04iRyuNZpIX7uZjt3W+CZgLW0YVnx0P5nWq
         Cf45KoFY7MIqGzEWKs6EzHeW0rKehdtIrs3BSgH42ymCI/JxY7CpHoRyWnIGDio3u2b1
         2j/U7SZDVR//DbMt5f2KJhAIVOkSES4w4iT+f+oIdiOIFj/7L1JaS4XXoHGFSbrMg1T/
         vikQpeMFbKqy38IWFmX3ZHFiG+40v1JIn+DnF2OwBqtuhyiT4nMsMBRWMZHQRzL/WkYg
         ikWA==
X-Forwarded-Encrypted: i=1; AJvYcCURs3wOPejZUtTkh/dyl4Swv0530EbITvowsApAmWkNImrfVwdDHrQkfdN0V14+FXtGtyDb4P+EBtf3Ymc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV6tunsdOQngn5ugU0pldPazlrSYbCSLYmYEjwLcdqFcSpwMXP
	lxjuLeFMbPKBpQsCz4fru7+8kKO3XHGnZPIMH1jHYP/6DBkhNkt1kIiPXvPDxCh8p9hxZie3uHn
	rPMc9WR+y/x1MqALRG9lwu/cOve8y6kjHTWeaxH6uK4LfmQgWkz/VsBPzYHLTMQ==
X-Gm-Gg: ASbGncuFXSB08N8OAzv7+8RyNa1rHSN52wWgtK0ZNwfQ0OKIZQ6SpZKaug+5P17goyt
	ti9YOGF0iJZlAFe8mLOLtMihwhCukNC9I0DBi+wwx+lowqvBOI98PMzjviqaZo9tqEnF5Mz1urW
	RADRk9Xc3tKLnzjiPporv8Rnl5O4YH1tk0Ds3S5U1KmTzsnZFbPfakie/TgVK4NvADZlkaoSbf6
	DVKT1UUL/fzGNW72MoICMhl4eUTKtKX6tdvIpcDSW2gYDMDJx2qwz80yLuozCF8MYWrkXZ+Tekd
	5/geKW24aBOSOtIyTNRfCkPYeWIsprxXgR5COEKmnw==
X-Received: by 2002:a5d:47cc:0:b0:391:3049:d58d with SMTP id ffacd0b85a97d-39132b58ad8mr19705100f8f.0.1741766339495;
        Wed, 12 Mar 2025 00:58:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgH8YlIN8M80SafZ2e0Ts0SxDtQRxsit6/g0y2H7GtX97JmQP5wLdfdz+N4CV9QEDBE5bw2w==
X-Received: by 2002:a5d:47cc:0:b0:391:3049:d58d with SMTP id ffacd0b85a97d-39132b58ad8mr19705080f8f.0.1741766339076;
        Wed, 12 Mar 2025 00:58:59 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfbaa94sm20390707f8f.14.2025.03.12.00.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 00:58:58 -0700 (PDT)
Message-ID: <e3f6e9a2e859e2c65ab960942543b8660f86edbc.camel@redhat.com>
Subject: Re: [PATCH 02/10] rv: Let the reactors take care of buffers
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	john.ogness@linutronix.de, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
	 <senozhatsky@chromium.org>
Date: Wed, 12 Mar 2025 08:58:56 +0100
In-Reply-To: <90868f1dd49680ec63c961ec8c72ceb64f1af091.1741708239.git.namcao@linutronix.de>
References: <cover.1741708239.git.namcao@linutronix.de>
	 <90868f1dd49680ec63c961ec8c72ceb64f1af091.1741708239.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



On Tue, 2025-03-11 at 18:05 +0100, Nam Cao wrote:
> Each RV monitor has one static buffer to send to the reactors. If
> multiple
> errors are detected at the same time, the one buffer could be
> overwritten.
>=20
> Instead, leave it to the reactors to handle buffering.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
> =C2=A0include/linux/printk.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0include/linux/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 11 +++---
> =C2=A0include/rv/da_monitor.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 61 ++++++------------------------
> --
> =C2=A0kernel/printk/internal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 1 -
> =C2=A0kernel/trace/rv/reactor_panic.c=C2=A0 |=C2=A0 7 +---
> =C2=A0kernel/trace/rv/reactor_printk.c |=C2=A0 8 +++--
> =C2=A0kernel/trace/rv/rv_reactors.c=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A07 files changed, 26 insertions(+), 65 deletions(-)
>=20
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index 510c88bfabd4..c55d45544a16 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -16,58 +16,11 @@
> =C2=A0#include <linux/bug.h>
> =C2=A0#include <linux/sched.h>
> =C2=A0
> -#ifdef CONFIG_RV_REACTORS
> -
> -#define DECLARE_RV_REACTING_HELPERS(name,
> type)							\
> -static char
> REACT_MSG_##name[1024];								\
> -
> 												\
> -static inline char *format_react_msg_##name(type curr_state, type
> event)			\
> -
> {												\
> -	snprintf(REACT_MSG_##name,
> 1024,							\
> -		 "rv: monitor %s does not allow event %s on state
> %s\n",			\
> -	=09
> #name,										\
> -	=09
> model_get_event_name_##name(event),						\
> -	=09
> model_get_state_name_##name(curr_state));					\
> -	return
> REACT_MSG_##name;								\
> -
> }												\
> -
> 												\
> -static void cond_react_##name(char
> *msg)							\
> -
> {												\
> -	if
> (rv_##name.react)									\
> -
> 		rv_##name.react(msg);								\
> -
> }												\
> -
> 												\
> -static bool
> rv_reacting_on_##name(void)								\
> -
> {												\
> -	return
> rv_reacting_on();								\
> -}
> -
> -#else /* CONFIG_RV_REACTOR */
> -
> -#define DECLARE_RV_REACTING_HELPERS(name,
> type)							\
> -static inline char *format_react_msg_##name(type curr_state, type
> event)			\
> -
> {												\
> -	return
> NULL;										\
> -
> }												\
> -
> 												\
> -static void cond_react_##name(char
> *msg)							\
> -
> {												\
> -
> 	return;											\
> -
> }												\
> -
> 												\
> -static bool
> rv_reacting_on_##name(void)								\
> -
> {												\
> -	return
> 0;										\
> -}
> -#endif
> -

I don't think you need to remove those helper functions, why not just
having format_react_msg_ prepare the arguments for react?

cond_react might be mildly useful also for ltl, we may think about
putting it somewhere else and/or refactoring it a bit to include
reacting_on (which is indeed global and doesn't require a per-monitor
wrapper).

> =C2=A0/*
> =C2=A0 * Generic helpers for all types of deterministic automata monitors=
.
> =C2=A0 */
> =C2=A0#define DECLARE_DA_MON_GENERIC_HELPERS(name,
> type)						\
> =C2=A0							=09
> 				\
> -DECLARE_RV_REACTING_HELPERS(name,
> type)								\
> -
> 												\
> =C2=A0/*							=09
> 				\
> =C2=A0 * da_monitor_reset_##name - reset a monitor and setting it to init
> state			\
> =C2=A0
> */												\
> @@ -170,8 +123,11 @@ da_event_##name(struct da_monitor *da_mon, enum
> events_##name event)				\
> =C2=A0		return
> true;									\
> =C2=A0	}						=09
> 				\
> =C2=A0							=09
> 				\
> -	if
> (rv_reacting_on_##name())								\
> -
> 		cond_react_##name(format_react_msg_##name(curr_state, event));			\
> +	if (rv_reacting_on() &&
> rv_##name.react)						\
> +		rv_##name.react("rv: monitor %s does not allow event
> %s on state %s\n",		\
> +				#name,			=09
> 				\
> +				model_get_event_name_##name(event),
> 				\
> +				model_get_state_name_##name(curr_sta
> te));			\
> =C2=A0							=09
> 				\
> =C2=A0	trace_error_##name(model_get_state_name_##name(curr_state),
> 				\
> =C2=A0			=C2=A0=C2=A0
> model_get_event_name_##name(event));					\
> @@ -202,8 +158,11 @@ static inline bool da_event_##name(struct
> da_monitor *da_mon, struct task_struct
> =C2=A0		return
> true;									\
> =C2=A0	}						=09
> 				\
> =C2=A0							=09
> 				\
> -	if
> (rv_reacting_on_##name())								\
> -
> 		cond_react_##name(format_react_msg_##name(curr_state, event));			\
> +	if (rv_reacting_on() &&
> rv_##name.react)						\
> +		rv_##name.react("rv: monitor %s does not allow event
> %s on state %s\n",		\
> +				#name,			=09
> 				\
> +				model_get_event_name_##name(event),
> 				\
> +				model_get_state_name_##name(curr_sta
> te));			\
> =C2=A0							=09
> 				\
> =C2=A0	trace_error_##name(tsk-
> >pid,								\
> =C2=A0			=C2=A0=C2=A0
> model_get_state_name_##name(curr_state),				\
> diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
> index a91bdf802967..28afdeb58412 100644
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -71,7 +71,6 @@ int vprintk_store(int facility, int level,
> =C2=A0		=C2=A0 const char *fmt, va_list args);
> =C2=A0
> =C2=A0__printf(1, 0) int vprintk_default(const char *fmt, va_list args);
> -__printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
> =C2=A0
> =C2=A0void __printk_safe_enter(void);
> =C2=A0void __printk_safe_exit(void);
> diff --git a/kernel/trace/rv/reactor_panic.c
> b/kernel/trace/rv/reactor_panic.c
> index 0186ff4cbd0b..4addabc9bcf1 100644
> --- a/kernel/trace/rv/reactor_panic.c
> +++ b/kernel/trace/rv/reactor_panic.c
> @@ -13,15 +13,10 @@
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/rv.h>
> =C2=A0
> -static void rv_panic_reaction(char *msg)
> -{
> -	panic(msg);
> -}
> -
> =C2=A0static struct rv_reactor rv_panic =3D {
> =C2=A0	.name =3D "panic",
> =C2=A0	.description =3D "panic the system if an exception is found.",
> -	.react =3D rv_panic_reaction
> +	.react =3D panic
> =C2=A0};

For the sake of verbosity, I would still keep a wrapper function around
panic, just to show directly from this file how should a react()
function look like, as well as allowing future modifications, if
needed. Not that the additional function call would be much of a
problem during panic, I believe.

Good improvement overall, thanks.

Gabriele

> =C2=A0
> =C2=A0static int __init register_react_panic(void)
> diff --git a/kernel/trace/rv/reactor_printk.c
> b/kernel/trace/rv/reactor_printk.c
> index 178759dbf89f..a15db3fc8b82 100644
> --- a/kernel/trace/rv/reactor_printk.c
> +++ b/kernel/trace/rv/reactor_printk.c
> @@ -12,9 +12,13 @@
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/rv.h>
> =C2=A0
> -static void rv_printk_reaction(char *msg)
> +static void rv_printk_reaction(const char *msg, ...)
> =C2=A0{
> -	printk_deferred(msg);
> +	va_list args;
> +
> +	va_start(args, msg);
> +	vprintk_deferred(msg, args);
> +	va_end(args);
> =C2=A0}
> =C2=A0
> =C2=A0static struct rv_reactor rv_printk =3D {
> diff --git a/kernel/trace/rv/rv_reactors.c
> b/kernel/trace/rv/rv_reactors.c
> index 7b49cbe388d4..885661fe2b6e 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -468,7 +468,7 @@ void reactor_cleanup_monitor(struct
> rv_monitor_def *mdef)
> =C2=A0/*
> =C2=A0 * Nop reactor register
> =C2=A0 */
> -static void rv_nop_reaction(char *msg)
> +static void rv_nop_reaction(const char *msg, ...)
> =C2=A0{
> =C2=A0}
> =C2=A0


