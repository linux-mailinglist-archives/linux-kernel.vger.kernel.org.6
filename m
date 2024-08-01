Return-Path: <linux-kernel+bounces-271046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7DB9448D4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949191F21E48
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575F1170A2A;
	Thu,  1 Aug 2024 09:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Gc5MfOCx"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFDE16FF48
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505963; cv=none; b=c0oHw7JdeH8vYVtmMn6bRLL+wJw1nS/Y5ajLRUPudKaMFmGQinHWV012uZKxWZkWl8zhjZPjL0xO8hW8WwLcPkT5lgl8Ai3zeYrDsda3tYJIR/UC38X6hJl1/i6pDT7Od6207Oh20mYFnl/PtloEA5oKA8SjCzqJTzMSKQCLXoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505963; c=relaxed/simple;
	bh=hwTy4MU6QlcGgLtBRPaBgC4qgLOIbU5Lg6ZeBO89wIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRz5uhu70Xtm8chUd/AfpHMeaxTQJ4ZDVMJA8yTXkpiEZ7Sij7hMn7RFrt2RMGFdfWAkpVafOcPdn9H12otKxU4XXe22WQ92xE+St2H3HlTV9QRT6wMt1AtcUOC8NpHoLvz0HtrXizHIBGJc0lfWCymXDXpqTxyk9gzCYLL7xUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Gc5MfOCx; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7ab63a388bso504198066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 02:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722505960; x=1723110760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kh6sjPS+V0tIECDRib90bGTU3Oz0K/fWSvdCCP93lIU=;
        b=Gc5MfOCxBDC6oSUSywa/GAKcNOWZXrl08pekUX0SWP1jinU767wrlW4oR7a9Obkf5A
         DvnfqVCj5ZDYCi69fr9bh9xkaqJ3su0CJtKCrjOUEJFDC6k/IG4s9SBM/LZr2t1Fu3y2
         kba4aQoIgCkjIbAIRtyaXV/IMydBKQ7NH7fMeX6onTDBhDhjELs2MYQG0hT1MI8PrRmz
         WR40gZv2wuzy5GiZebnkAi3jsCCV9VHOoX5CH5gZz6jxD9VsG2Zubo5FoxxaxQWx2r57
         EozlNL4PU4s+uIQVYq0nuBFpVk7GJZWuoTvk6AZCsMKFZP1f3iTkcYRb5I1X9Hfx9OJa
         /Qgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722505960; x=1723110760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kh6sjPS+V0tIECDRib90bGTU3Oz0K/fWSvdCCP93lIU=;
        b=Be1fOYYPbVvPf+I+KnuUbRNuhpeeph1N1aWL/iuBylAGrYdH/t+E1y/kEcSaWDidSW
         4+tOU070+P4IdCSA1YBVCYni6I6YWGTs+fllb5mQVaHIksHQQIuUhSiG7dq1UiVailsw
         iJMfYmwjdGlgoQfeILw2dSBFFSQXhPvekCRL/SL3e9UBuscUVFr/CaLfISv4yX3k2XVa
         XhtKpo9YlUkRE2/lFKPQriROmqBYxxKtGf2iEZJk4ySo9wKHKRcthZvqBxAJ9jscApzY
         3vZkS7noo2wWy4t3NgSMVyEqxl9j1EMnNDIxP5CeOI0o/LngQ+YNm3E+ksF6qbCThTMy
         bJkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJteMW1YqBDGb0X9XBs57vTxf2dK+Xv0p2gPiPOIVBEFziv+qqXtIwYzx43y7acQILV0b+6iX/KvXq92shz3nfu37O8ZGL1uvmOXLg
X-Gm-Message-State: AOJu0YzUN5bsOXkqENCb1ZO6dGrPlJv852RSxW7/mkC4KeTGqvD/BS9+
	0UsfkZd2v4Sfya9I7D4ZeUCyXiTep7ZXS5QPijvzxR4uWFNo9DVPElt6H4iDfpE=
X-Google-Smtp-Source: AGHT+IGdGiqVgGR5Lwala5FU7Q3pxrjw+/0AZsNlxyp+JwEb43AgBkBH+lje2o14d/PpDYHYhK7l0A==
X-Received: by 2002:a05:6402:5147:b0:57a:3046:1cd8 with SMTP id 4fb4d7f45d1cf-5b6fe925193mr1522444a12.7.1722505959649;
        Thu, 01 Aug 2024 02:52:39 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac64eb7c0fsm9878804a12.62.2024.08.01.02.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 02:52:39 -0700 (PDT)
Date: Thu, 1 Aug 2024 11:52:37 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 11/19] printk: nbcon: Rely on kthreads for
 normal operation
Message-ID: <Zqta5T-ydHcSaCvR@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-12-john.ogness@linutronix.de>
 <ZqpE9urpKZxv4Ks3@pathway.suse.cz>
 <87plqtlh2p.fsf@jogness.linutronix.de>
 <ZqtXMiv0ES5r91ua@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqtXMiv0ES5r91ua@pathway.suse.cz>

On Thu 2024-08-01 11:36:53, Petr Mladek wrote:
> On Wed 2024-07-31 17:31:02, John Ogness wrote:
> > On 2024-07-31, Petr Mladek <pmladek@suse.com> wrote:
> > >> @@ -4102,8 +4139,10 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
> > >>  			 * that they make forward progress, so only increment
> > >>  			 * @diff for usable consoles.
> > >>  			 */
> > >> -			if (!console_is_usable(c, flags, true))
> > >> +			if (!console_is_usable(c, flags, true) &&
> > >> +			    !console_is_usable(c, flags, false)) {
> > >
> > > This looks weird. nbcon console can't make progress when
> > > "write_atomic" is not implemented and the kthreads are not
> > > running.
> > >
> > > I should be:
> > >
> > > 			if (!((console_is_usable(c, flags, true)) ||
> > > 			      (console_is_usable(c, flags, false) && printk_kthreads_running))) {
> > 
> > I would prefer to have the printk_kthreads_running check within
> > console_is_usable() for the !use_atomic case.
> 
> Makes sense.

I have realized right after sending the reply that it actually did
not make sense.

We try to use con->write_thread also in

 + console_flush_all()
   + nbcon_legacy_emit_next_record()
     + nbcon_emit_one()
       + nbcon_emit_next_record()

when (@do_cond_resched == true)   =>   (@use_atomic == false)

=> __pr_flush() actually should be able to flush the messages using
   con->write_thread() even when the kthreads are not running.


Result:

IMHO, we should not check @printk_kthreads_running at all after all.

Sigh, it might make sense to document the design from a top level
view somewhere. We should do it at the end before we forget
the details.

Best Regards,
Petr

