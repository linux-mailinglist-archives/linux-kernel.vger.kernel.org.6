Return-Path: <linux-kernel+bounces-441501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA5F9ECF48
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220BF188B0E4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE201ABEA8;
	Wed, 11 Dec 2024 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DjS0cVMu"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5A01AB526
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929428; cv=none; b=p1PAIheYVpzB7AQoUnbRUW6k0TGFN0StVEbKIO2lSHtRKkesvbB+4HLFzh6GGK+997waYoZdRZXW++exAhYXfi2f3oDu8cv+T6hEGVJrYcXCTLUnguEzfN8Wy/xBas8CXIw8X6jQdxN+fMkufXkfN6TnAW+s4KadF4lpPTyWI40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929428; c=relaxed/simple;
	bh=ScD4TvFrBQz8lH8v/kZwUPmPh/cLyEH9rHHQyEMQnn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjT+keQwD4FMV41vqAaqu+MWgo/tSOZ8tsshpXofIJ5apU9LU8idMTvW8fMINWUizm3d+PrGnHZHb3KvTq2a4WLyPTzow+vo9uaRHl87yu4DFZ5LYxL8ytgwZfVFFerEWP+6xVSMxuk9PFj5EvGhOvcWjL9ZtIqwbBVw3E99TYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DjS0cVMu; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3862f32a33eso2328636f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733929423; x=1734534223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FoKpgB7KnsHA/omQnPm6YOo3pnlbrYVu1blyxszx7c8=;
        b=DjS0cVMu4PJ5WPSSRA+JiERZJhirPxjZ6AANjD4CZy1B12oOqRZpy7+Xi830MCXzKb
         VXhHbZDekrD2fGYD/0OhLLg1NHF3N1tTA8YJEbVM0tbIGHuzkST/twhYrv2vo45LSAYa
         1HhZ9VGZM9wtwsPpTioeXQOAQoeJ/YZusuUueLPmbm090av1wAgDM1yjkwnSUorFKtq0
         kAhQhoBYLX8fjSucgYGLrpOVRT4HsXu64JccRdh4tDkLOv3hmawB9F0qwQ59SpKIf/kv
         ES5ZozV/Zg9Cbm/dRG1LDJzjDxq7HGuakYfYIHynYi/7Xio/GV0m/nLwAqEoUriSnslv
         RPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733929423; x=1734534223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoKpgB7KnsHA/omQnPm6YOo3pnlbrYVu1blyxszx7c8=;
        b=FwlE3O/i+7jVMz/S7xFQ6SRoA1VMkXtE8R3YbrIajAveJkEoNlflYWl3E9oXzM3H3X
         M1/fvX2urvWXt0lEQteahBmccGGKtl4vOHp1rR6urfEL9cpMFKKF6xdoACfq47p5f5qH
         wG5iSGBY2fsG8a1c/6JzmLgUVTXlyrwWAe5K296K9Eh6QLaUtQ6E3RrO67nOReDKPpKT
         m0KXVL173nh8f6iFZkLYO6Bfp5SWFHcH7lSfHFPip+Rte9hLSp6wiAW8Zw3AzyjI3qkU
         51U/ZLdUVu61YJ4D+Vl3rrT6bF0nmjvoUWtmGF1EEGd7808/mjkwZrmJMCUrC/hFrMXs
         SbPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfi1FnxTGBmbqUg+WTXO/ldg7SxNyfVSRTT99siuc1RhirncJPX7AIpi1zNU/aKH6FRJMKhCdBsEyz5A4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygs4X4nN/hbK33UW9b/EyNcsrI2V657o9KJAqU9nd9Ta3boKdd
	jXXEPNqtlH8W3obevgAhFO0cA4goDBy8kR9TfFKaVYcbOCC+eC6UEWLc0Bf0aDLsbo1AWzLGLAq
	Z
X-Gm-Gg: ASbGncuWsTOSmcCv9CpFOwwlzJZdkYsDVUGmsBzP5H6h9jIZIGFNZ2ZZ4Ha2c/JgZB1
	ZGPUqcOkwUbNUcS0VX9rUXF0O3W1tiInxEbJI8jE0Azi3oUOksIbDzF56UoNcg9TBl+Xr1kBcAI
	Ck0T7iVApO74Ra6BIPspw7lNbV3vwdFsF9no7OG2kzEWT73VqCWv1j8qdUsRnhxU4UG0DPyjKUx
	wIEbBxachJjUOT5CO5Uq7X0ViWv79GnHaOf+3nlODpHt1Cb/b1itYQ=
X-Google-Smtp-Source: AGHT+IFxTHkB4kSgAODH1yneZUJNg836Tox5rgbXpsTuYoAuMKEh0BHc9LHK/dh1/3/Lt5hWLSOX2A==
X-Received: by 2002:a05:6000:18ae:b0:385:e961:6589 with SMTP id ffacd0b85a97d-3864ce96d45mr2665801f8f.20.1733929422652;
        Wed, 11 Dec 2024 07:03:42 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef951bd734sm6957248a91.4.2024.12.11.07.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 07:03:42 -0800 (PST)
Date: Wed, 11 Dec 2024 16:03:34 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	Rik van Riel <riel@surriel.com>, Omar Sandoval <osandov@meta.com>
Subject: Re: [PATCH printk v1 2/2] printk: Defer legacy printing when holding
 printk_cpu_sync
Message-ID: <Z1mpxhCU-WpaKJIt@pathway.suse.cz>
References: <20241209111746.192559-1-john.ogness@linutronix.de>
 <20241209111746.192559-3-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209111746.192559-3-john.ogness@linutronix.de>

On Mon 2024-12-09 12:23:46, John Ogness wrote:
> The documentation of printk_cpu_sync_get() clearly states
> that the owner must never perform any activities where it waits
> for a CPU. For legacy printing there can be spinning on the
> console_lock and on the port lock. Therefore legacy printing
> must be deferred when holding the printk_cpu_sync.
> 
> Note that in the case of emergency states, atomic consoles
> are not prevented from printing when printk is deferred. This
> is appropriate because they do not spin-wait indefinitely for
> other CPUs.
> 

It might be worth adding a reference to the original report
to show that the problem is real.

Reported-by: Rik van Riel <riel@surriel.com>
Closes: https://lore.kernel.org/r/20240715232052.73eb7fb1@imladris.surriel.com

> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Fixes: 55d6af1d6688 ("lib/nmi_backtrace: explicitly serialize banner and regs")

Anyway, it looks good.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

PS: I am going to wait few more days for eventual feedback. I'll push
    it when nobody complains.

    I could add the above mentioned references when pushing.

