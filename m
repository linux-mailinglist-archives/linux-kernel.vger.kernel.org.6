Return-Path: <linux-kernel+bounces-415712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1A39D3A45
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2260B22B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6822819F41C;
	Wed, 20 Nov 2024 12:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Yqm9cKWN"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A5919E833
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 12:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732104235; cv=none; b=MyXAHBljvgc3afOXMLI/mS0db730iuImezzZkXMi3Ff7OLsU5mz/n9MIQGo57Kyk2Ig7N6YToAyNcp4IgvHdo9kMQQgh3RlymuPWWoEsfysGbkpnce73XjQetfAGEBeKxB3wP9Lh2dzI4t0TuA/g8h+GyRWKJtA6CUFMYMkfPu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732104235; c=relaxed/simple;
	bh=ebiOEPWDASTmqe1MSxfIOuNrlTqoc/XH5CV5Uf86rmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJtEj0P+ONwu1rhX+FdOBj+5oQG45G3CHnrqFwNJKzFIrxpjYRs5o6+Nkg90N6P5vH+4uj2kcSkF9XrVrXAsL2Lf9A4FtheYt+okh/LVTa4uw9uOVx2hwDljUloRWJZEqZcjUmcC9tRr687BuXuMINc+RQjBA2QgEQ3Xj1E9qa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Yqm9cKWN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43169902057so56024055e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 04:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732104231; x=1732709031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BAxdRzhOYrouT/5MhvDembquc5UFQi3vigSKJDBImCU=;
        b=Yqm9cKWN2jKbQ9ZOWgR7Pe3YwFF6IS1J5ZLz/cicn2+lyWtGPW1GS0nm6a0LRLD1y6
         aeQ1f88R5GbIyQlasCmaH7O+Mlq8tLJYlGfQXuTcCm5EnxdTnWVg3MTdODQFHOqdThDK
         LhcvMZwZeAOaPtLunuDTrkAsCg2DkS+d41kGC/TVrwgpx1jfDFOMdPW1RDWPwsRJI/cQ
         uZKBJaYybRc7NQ5itSAqClWgEoDK6Yjf/AveqWQe4OZIHe0Oa1Z396FcSndvJ2Q28ceM
         ZKUU+9ZcrFcu23JI/Y6X2hNlNzoehnFQMyMLeVaqZdm/xaLeeDfQnJ3ErC/Q+nbEocXI
         hLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732104231; x=1732709031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAxdRzhOYrouT/5MhvDembquc5UFQi3vigSKJDBImCU=;
        b=uzdoa/CZTj/e9CBnhjzLFZyrSOYdvtmoeFa/NB+r1IdjvO1Yb+CZi383ZeqPG/j/Vu
         omwLfw+Bp/XfERw6/2lvCsh+pe6y0myCcwFiAR0pABFwgW4UxEqJvS3GtDY/yh5pcnMX
         Nj9g60Feqyw2DQQX3vq2PO97g9p2K8Xr+MScuGxVVGOEV54/HlAOaQ+TBDE+p855J2Q9
         fPXEo2n8CDs8CjEJhLeMsRIMYYs3nKWGzO1aYW0YqwhuQIDJrzPQ+GSsectnI8N2h6AP
         Zas3G9F03ZiactXoEY3ca8JmgyMTHi2J+N+SF1NA5SU/3Mz50FeB96ZpF2rG2M0QPXsR
         m/aw==
X-Gm-Message-State: AOJu0Yytx6ceIgwJ6izUzL1y3p73qQ4T/Hc7QW1mn2Y/KDNeGfR50jyJ
	fPZFtvEKOtfxCspFDKPxbZZDHB8v50VFRbxKJv8TtbT826VspA/QICF5FDLYV/E=
X-Google-Smtp-Source: AGHT+IGjopcSt0mlRYRqL80tr2QaHyUpHiLzEE5R54Myqo3Nu8PqZxlrk2NYs2xuExxiYi66Ab/D8w==
X-Received: by 2002:a05:6000:1565:b0:382:3754:38ed with SMTP id ffacd0b85a97d-38254af5110mr2057295f8f.21.1732104231380;
        Wed, 20 Nov 2024 04:03:51 -0800 (PST)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825493f3ebsm1870395f8f.105.2024.11.20.04.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 04:03:50 -0800 (PST)
Date: Wed, 20 Nov 2024 13:03:48 +0100
From: Petr Mladek <pmladek@suse.com>
To: Chris Down <chris@chrisdown.name>
Cc: linux-kernel@vger.kernel.org, John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: [PATCH v6 02/11] printk: Use struct console for suppression and
 extended console state
Message-ID: <Zz3P_vDLiNNCLCQR@pathway.suse.cz>
References: <cover.1730133890.git.chris@chrisdown.name>
 <ba47efbe432cf33cb358a027a2266296e2cfe89e.1730133890.git.chris@chrisdown.name>
 <84plmw527r.fsf@jogness.linutronix.de>
 <Zz1i78qGL02oF8Zl@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz1i78qGL02oF8Zl@chrisdown.name>

On Wed 2024-11-20 04:17:51, Chris Down wrote:
> John Ogness writes:
> > On 2024-10-28, Chris Down <chris@chrisdown.name> wrote:
> > > In preparation for supporting per-console loglevels, modify
> > > printk_get_next_message() to accept the console itself instead of
> > > individual arguments that mimic its fields.
> > 
> > Sorry, this is not allowed. printk_get_next_message() was created
> > specifically to locklessly retrieve and format arbitrary records. It
> > must never be tied to a console because it has nothing to do with
> > consoles (as can bee seen with the devkmsg_read() hack you added in the
> > function).
> > 
> > I recommend adding an extra argument specifying the level.
> > 
> > The extra argument would be redundant if may_suppress=false. So perhaps
> > as an alternative change "bool may_suppress" to "u32 supress_level". The
> > loglevels are only 3 bits. So you could easily define a special value
> > NO_SUPPRESS to represent the may_suppress=false case.
> > 
> > #define NO_SUPPRESS BIT(31)
> > 
> > bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
> >                             bool is_extended, u32 suppress_level);
> > 
> > Then in devkmsg_read():
> > 
> > printk_get_next_message(&pmsg, atomic64_read(&user->seq), true, NO_SUPRRESS)
> 
> Petr, what do you think about this? I remember when we discussed this before
> we talked about either determining state via `struct console` (which seems
> to turn out not to be feasible) or passing another argument.
> 
> Do you prefer to have another argument or do the bit dance?
> 
> Personally I prefer the simpler solution with more arguments instead of bit
> stuffing if we have to go this way, but I'm up for whichever sounds good to
> you.

Ah, I though that John's proposal was reasonable. But it is true that
the meaning of @supress_level is not clear.

I see two possibilities:

  1. printk_get_next_message() and console_emit_next_record()
     could pass con->level.

     But then we would need to create the extra value for devkmsg_read().


 2. printk_get_next_message() and console_emit_next_record()
    could pass console_effective_loglevel().

    devkmsg_read() could pass CONSOLE_LOGLEVEL_MOTORMOUTH.


Sigh, it seems that any solution is hairy, including the one which
passed @con.

I personally think that the 2nd variant, passing the effective
loglevel, is least ugly. I am just not sure about a good name
for the parameter. What about?

    bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
				 bool is_extended, int con_eff_level);

Note that this would require passing the effective loglevel also
to suppress_message_printing() so that we would get:

static bool suppress_message_printing(int level, int con_eff_level)
{
	return level >= con_eff_level;
}

Best Regards,
Petr

