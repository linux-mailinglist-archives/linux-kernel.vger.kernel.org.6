Return-Path: <linux-kernel+bounces-515361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 455D7A363BE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D37947A1734
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216CF267AE8;
	Fri, 14 Feb 2025 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePcM9Vi9"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B94267700
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552349; cv=none; b=K2OP4d5Zg2eeF0hkTLSFUpCqJ2x1fbneTblGpZy0QWkiV9VyxW4xVwmJW0ijMbqt8gFg96KJkOCMEXp19K0POU8JzzVtSSqLCQRqeDyl6f89PYu3hP+sKfQNAKJgrr97srYY7NghubeLroR4leKnyMlSkWQ5y3T3k1i4RGb77UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552349; c=relaxed/simple;
	bh=qREZrHqn/Jc+jXWXK03ANb5RmNaxAlu64M7IFnBw8IE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDoCvLMnzw1AYCMybCTcmv1O4CUnTdGkijH60HzpP1SkbOs+zcog8WbqauQzzxTKpZrmoMr3pM8cZ9RXzdpYDpPQL4sNdt7njgf6tq3J9kPokcrww1ZCnUrRngsI0y1OYS3eijX5sXD8nUNIXewA/wUxoiRwDE7lczkIIopsvJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePcM9Vi9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43956fcd608so14669065e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739552346; x=1740157146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YF5gaUPEoUnrxEkiedLtaiGQiptCOlWF/WdC+IxCwYY=;
        b=ePcM9Vi9icVI2pAU03Qm2uk59lqf+c58pxHsA7T8Qiafnzi8oX9NZDSG066gElj1yZ
         OFjiU+JzXHb0M3ZkRAzwQ3AJf/RJqfQty4H8sm48cro/Q7G0tbB8N9xvKUMeRwI9g+r7
         jFA/M8anPGoaoUvCszqOuV/6ylm/2a4HEqaTi/QmoUyXAN8+dno3B0thAgR/hwuDsQNX
         0XjDs6UNLZEDuaAuYXdcjKVnc3zxwbQeYSkQ4UmQS1Tsh12C8PyTamTcH4kV9RdwpWJx
         lK6u9TN9FUg79xuLSvNGWVwB+nncqzd8GahmLT3lF9MiEWXVKlD1OxZhE+C1wuVsPyCi
         wIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739552346; x=1740157146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YF5gaUPEoUnrxEkiedLtaiGQiptCOlWF/WdC+IxCwYY=;
        b=WF7pew96/2tk+l2fxXAuVE16YlEU7m2WFFiKQL0POFIQYDwDTuD9oTxF1IxAM8MSnC
         rvGlCqqDS6lMdfISlOawca5fRXssWsMdUb63xkwkwnWjBLDkZIiiKAqNG+Rg2V/rQWgQ
         L7dgvfd63E7HUFTCYd5kBS35BhtVY3axza96cX8FyGU0Hu5feN7eTxII+LKEzHNf01Wu
         o2sMgdgBHy/kOLQTvb9EwkT4LaOVupsV0b+neZrF3NM5z0ZCjCyIGJdloqvPdA0pYKV6
         vt/AN/iok1yTXnbHb4seJcARLI0bz7hXN5O/y8gFGW/giFlJNb/kVaOyVjcp6YI3M4ZF
         c3Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWAbogmj1gV6spuYdaGHEh5pCfa99N0INS7TLe32jL0fgKo3DWHLyXdSpfuYhzTnvXsUffOjugk3cVqYPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa0V3DiqM3P2rKQ/k022sz6asMXjjmOAsfpF4zen/Z7wy6m0hg
	ve+YRMBuOqTvn13FwY2w2S2ej6crIkA1hl8n1rXu0b7LKoQstcAU
X-Gm-Gg: ASbGncvW8EmrScpCeJa+moL1Pg/anfwUemDCQ+CzvQqkAEN4purieMVwSiX88aTSuFG
	7rOppmziH3Om+m17IGrNxNogPPshWdX+fkf9Mh06rco7nLnhRqA+zl/eE2q2BUHjVQrxifTC9Zp
	7T+VCMsJQYrH41hITKzwcgaHL/7QFkzl3KsFwBHwNuNOE6gEQpQgYUV4zj/SdG/kjfmcpNyoy9H
	G1q5kcDuk4RE9AY8m8nt68hRtmYMrOWBjSzdgUWTZmty2Vas2f6rISpgqTMACVYhLj4lNpjwNrO
	bdcyL1GrbJO15U45B/qJfuqYxDXMo6aIeVLtODE3hF9YDawLgPtTFw==
X-Google-Smtp-Source: AGHT+IEahaVF69dSAxzjE7C+nQyFygzTIMWs6mIjK+KQLWzBO8gXDBmC5r8m+YyqGwVxhKj53GwhJA==
X-Received: by 2002:a05:6000:1541:b0:38f:2a32:abc3 with SMTP id ffacd0b85a97d-38f2a32b612mr8215074f8f.42.1739552345848;
        Fri, 14 Feb 2025 08:59:05 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258f5fabsm5029928f8f.45.2025.02.14.08.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:59:05 -0800 (PST)
Date: Fri, 14 Feb 2025 16:59:04 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel
 <linux-kernel@vger.kernel.org>, Benjamin Segall <bsegall@google.com>, Eric
 Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH 2/2] posix-timers: Use RCU in posix_timer_add()
Message-ID: <20250214165904.33b73dc8@pumpkin>
In-Reply-To: <20250214135911.2037402-3-edumazet@google.com>
References: <20250214135911.2037402-1-edumazet@google.com>
	<20250214135911.2037402-3-edumazet@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 13:59:11 +0000
Eric Dumazet <edumazet@google.com> wrote:

> If many posix timers are hashed in posix_timers_hashtable,
> hash_lock can be held for long durations.
> 
> This can be really bad in some cases as Thomas
> explained in https://lore.kernel.org/all/87ednpyyeo.ffs@tglx/
> 
> We can perform all searches under RCU, then acquire
> the lock only when there is a good chance to need it,
> and after cpu caches were populated.
> 
> I also added a cond_resched() in the possible long loop.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  kernel/time/posix-timers.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> index 204a351a2fd3..dd2f9016d3dc 100644
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -112,7 +112,19 @@ static int posix_timer_add(struct k_itimer *timer)
>  
>  		head = &posix_timers_hashtable[hash(sig, id)];
>  
> +		rcu_read_lock();
> +		if (__posix_timers_find(head, sig, id)) {
> +			rcu_read_unlock();
> +			cond_resched();
> +			continue;
> +		}
> +		rcu_read_unlock();
>  		spin_lock(&hash_lock);
> +		/*
> +		 * We must perform the lookup under hash_lock protection
> +		 * because another thread could have used the same id.
> +		 * This is very unlikely, but possible.
> +		 */

If next_posix_timer_id is 64bit (so can't wrap) I think you can compare the
(unmasked by MAX_INT) value being used with the current value.
If the difference is small (well less than MAX_INT) I don't think you need
the rescan.
(Not going to help 32bit - but who cares :-)

	David

>  		if (!__posix_timers_find(head, sig, id)) {
>  			hlist_add_head_rcu(&timer->t_hash, head);
>  			spin_unlock(&hash_lock);


