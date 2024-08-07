Return-Path: <linux-kernel+bounces-277914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E062094A816
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD4C1C22E66
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350191E673C;
	Wed,  7 Aug 2024 12:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T/WYc4Ks"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9C01C7B84
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723035154; cv=none; b=ahUA3EboX3I9ZUzq9gldhLUoTjZrS5rsn23gmqPrj3ZCb6reggzIa3Et62zzG3W33C/W7rsplmp47heYPRWGRbTc8c3Hj4FwQKWqIjdM42qlZByvEXFR/YjEaHLE9n6rDYOaSh8ynFpQWlB+fAGQjpb+ObmFlHG19gpKq/k+VeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723035154; c=relaxed/simple;
	bh=LcvzdZGqvLUxPLQy/Emc/rVY2KjEO+lXOYpXerzIsJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HymQ/A1YKHpd1TUfslIZqPJvsVVKKGEBWfEj2YKAc5qg+UxvzZkjkRBKjNajxBDImCXBBQ9fpQDZckNv++G8f5hUHxh/IBmZbK8VGvi52GYq6z9iBK1FxrJPW4iX/Y7cpvh8lkK/RwjesnlS+U0Pt0M4vKhwBJvlElfueW+/SNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T/WYc4Ks; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5ba43b433beso2022626a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 05:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723035151; x=1723639951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iwXz6OLsOsYCk8qCnBsBaDWnPwQwa6ssBiygLxwZuhc=;
        b=T/WYc4KsoG+9XSXq9Rksnk8IvtDAsffH8OZDpy6/ijXm0UEUZ8aTFwb4xWwUtxKtwR
         8xx7bPResjSJmJXIaUN15rVkTRtlS0pXgh8AZnByqh53wnFG8956Tsl9UZUMcSge/9Vk
         syib6IpYC+eYIgJCX4IoFb/PGqi0jzTvy6SaV/cY/966kfSlL+COdx0DEPFGAbZaOvXB
         wyyT08PkhOUin4QzZvTQLGRaT/JTSWGP5bYHMBMs1ohQR+JJ4qoOTmYxvRvgfUOhMTl/
         +jOwmgOeGZ5E5uRrGWmj9oZu26N76xKLkoiuDKpI35dNdNxpYiH2pTSA+BDfKm49MYlR
         hihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723035151; x=1723639951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwXz6OLsOsYCk8qCnBsBaDWnPwQwa6ssBiygLxwZuhc=;
        b=jARyS81cEwTg/egwWc2bm22+2bdTGs3ECSmAvB4TBV1aZO7JwFhGuIqN6FM69mahgJ
         Zkcp7gmYSw5ZvAkfjK35HAOgyGWwEWvmeE8yfWAMhMmgq5cKNvCQ/+RPt/duXJaQzC4f
         HfW6acAe8pQmuyRrVxJc1g67qwMkF4bwOcRa9MblhaTOXiheeXYDRQNW0aTOQvjjwlna
         1/iOdTjpy8urKWIQcy90K54TgvELrY7uyUwxRLss2ETQ62K5juQQ9ajFyVshtiSG0FUh
         rxuj7mp8jsHdBJrLQW8/D5GTi2isguT3/5R+TK1vytt3LiHYA/t5WZvYUaw9wVPuFcwQ
         2n+w==
X-Forwarded-Encrypted: i=1; AJvYcCWswvsfL8Pzm/87rb8LxgnmfdEUx3kUgN1yOvZx9k25VABWzZWSImlilNo7OnOUBANc9U7nQK37T5wHBYIi/Ah25/Bs/s4zaSenXLOX
X-Gm-Message-State: AOJu0YwMnfeWKFH6jDgGtY4LySWW2BmZYcOnKGqg7tivxsL1zDy3v7mo
	xz7fVFOR1WYaJYU387Fu4e0Wdk9vN/IiMavn27tDubacrc1dnO4eEYAYZEXuq2M=
X-Google-Smtp-Source: AGHT+IHxGBKcxT2pFij5aIQagRjSqrhABO8Q4KwkwxnQZ3ngWMjKf3ZZvnAQu6W6xkWHxtP1QeDZpQ==
X-Received: by 2002:a17:907:6ea3:b0:a7a:a4be:2f95 with SMTP id a640c23a62f3a-a7dc4fdf818mr1325468966b.5.1723035150607;
        Wed, 07 Aug 2024 05:52:30 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d437c6sm636111866b.129.2024.08.07.05.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 05:52:30 -0700 (PDT)
Date: Wed, 7 Aug 2024 14:52:28 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v7 31/35] printk: nbcon: Implement emergency
 sections
Message-ID: <ZrNuDAqRZsjvnjsT@pathway.suse.cz>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
 <20240804005138.3722656-32-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804005138.3722656-32-john.ogness@linutronix.de>

On Sun 2024-08-04 02:57:34, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> In emergency situations (something has gone wrong but the
> system continues to operate), usually important information
> (such as a backtrace) is generated via printk(). This
> information should be pushed out to the consoles ASAP.
> 
> Add per-CPU emergency nesting tracking because an emergency
> can arise while in an emergency situation.
> 
> Add functions to mark the beginning and end of emergency
> sections where the urgent messages are generated.
> 
> Perform direct console flushing at the emergency priority if
> the current CPU is in an emergency state and it is safe to do
> so.
> 
> Note that the emergency state is not system-wide. While one CPU
> is in an emergency state, another CPU may attempt to print
> console messages at normal priority.
> 
> Also note that printk() already attempts to flush consoles in
> the caller context for normal priority. However, follow-up
> changes will introduce printing kthreads, in which case the
> normal priority printk() calls will offload to the kthreads.
> 
> Co-developed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

