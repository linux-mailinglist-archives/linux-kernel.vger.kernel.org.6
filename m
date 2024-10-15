Return-Path: <linux-kernel+bounces-365815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5065499EA40
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1581E288CF6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C701C1C07ED;
	Tue, 15 Oct 2024 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hsm3NG10"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EF71C07DB
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996484; cv=none; b=Loivaj8a7WapI6dj18XZ+DIEtd2cqP8WGIQHplgwAYbQ4TGSHaQnmX9t7PtBy4Kv5sF8/mUVe7fg2TdE8tQ9YiRKonguI52iksX6wsH80TyaedDdgQSMPPh5jHmjsf05zaqPXIuXXFiC0RSabKx/UeWewvERGnR1HIQGBR06Po8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996484; c=relaxed/simple;
	bh=MXwOT/Gxjf2vtMms2dsAi8Z/Fj4zpS4VIKY74FY56JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeG4v4YUfCx7mQUpQsQvo7cjnLuomM/WtPQqEl0VY+eKC+21qNuUL7/t7/ZOn23LAu2DOBfe3qFPdYdTHu0PlJ7xc4C4zOxoRihFN6cDDcaT3PKyE+PnLjuymNGITJQ/qBzuW0TH3nd4Bat6hAh8vpdWCACJL9dD7P9qVW6GF4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hsm3NG10; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20ca03687fdso500985ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 05:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728996482; x=1729601282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zh70s/tnpfJIglb9vFOny1RqgoHiMkopPjXkdlRpFwY=;
        b=Hsm3NG10NcvlFL+DlsrnjlWi+7DBpri2Ci7gbhi0uaQZloxROSXC8azGEu3t8PIGOc
         9wKim+P+KPwec2RGgnQY78ojSDxPlgdwhp+l0eOmpcwY/dyRbDYfyJfunjWG2aXOvRzI
         3zCsheJYplL3nx/1P3x9Wg7sSYSR697bIz77Ckb6TnGloUO9RjBi03h1lLO7aAmqQyQH
         hDloPZZ9c36fprELDB6rMVlrDDXxVQAx1SbeyVo1kqY0PXttIgqzAYqfqMLMz4KTiknO
         mg0wqKJDKZYTbFdhvsXOHtqoUh2pZC2wQLzcTXfUJelQayY/zbRBBtwHWGQtcP4rv2LQ
         WOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728996482; x=1729601282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zh70s/tnpfJIglb9vFOny1RqgoHiMkopPjXkdlRpFwY=;
        b=MzBrshaz6c9/htqoxcEGfG6QljG9IE3MirUfbbUzwDtkQ9kFW6NZD2rO7nfsmd48qo
         5FasRSKQ+QAC/UIQGO0Fqmz/1enerzypt0fGzw7/uk94+AooYeICmm0hs2Q10efqrfPC
         GhP9S8NiHxuE0k0+HbxGnt/NCM5uqOvsEjDsbxjtGCJdMEuKP15l+UQGbewQSm8ye4aY
         Se8lacxXBxdcVaTk9VceF1AnAoW5jZaLkTez1T+Ie9DuEhnp+uLsuZ8zVholuR4R7od7
         6VHXSDpD7M3MnATVMj70KaJJqtqjNnlySUe/rbCYz6Pone6hQtxladl8arsKNKMZUu3C
         lhsg==
X-Forwarded-Encrypted: i=1; AJvYcCWh2GPm42BNJ40wDb4qh1eKwpcs5eq/6fPQElZRzaRBjTTUYqEV01aJ408WbBeWM2XswhLe/jlXkuJwO3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh0iXF/oRtOBThvFSW2ltcTYjXrdZp/kN4EJwAeoC9mWKzvu/9
	B4njiGLBAi7/Je22jyjF19fbykEkEpbUMhwIRzxeXkxgiE1J/UcvPDVMqNddtg==
X-Google-Smtp-Source: AGHT+IFeRrLfkjo1S2u8GVkKeQ6yRvPNTcW1qAulEVhgqeprQHJ0oJSq9InntUTwSIMqwQuSd2mkeg==
X-Received: by 2002:a17:903:2292:b0:20c:568f:37c7 with SMTP id d9443c01a7336-20cc02a791cmr6254135ad.17.1728996481621;
        Tue, 15 Oct 2024 05:48:01 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:d68a:981f:f8a0:778d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1806c8b0sm11176085ad.295.2024.10.15.05.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 05:48:01 -0700 (PDT)
Date: Tue, 15 Oct 2024 05:47:55 -0700
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>, surenb@google.com,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk: Improve memory usage logging during boot
Message-ID: <Zw5ke11y4TkRQJQ2@google.com>
References: <20240930184826.3595221-1-isaacmanjarres@google.com>
 <ZvwZV5MDlQYGJv9N@pathway.suse.cz>
 <Zv2LQLsIC1y0bCDL@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv2LQLsIC1y0bCDL@google.com>

On Wed, Oct 02, 2024 at 11:04:48AM -0700, Isaac Manjarres wrote:
> On Tue, Oct 01, 2024 at 05:46:31PM +0200, Petr Mladek wrote:
> > On Mon 2024-09-30 11:48:24, Isaac J. Manjarres wrote:
> > > With the new logs, it is much easier to see exactly why the memory
> > > increased by 2304 KB:
> > > 
> > > log_buf_len=512K:
> > > 
> > > printk: log_buf_len: 524288 bytes
> > > printk: prb_descs size: 393216 bytes
> > > printk: printk_infos size: 1441792 bytes
> > 
> > This should get updated to the new format.
> > If I count correctly then it should be:
> > 
> > printk: log buffer data + meta data: 524288 + 1835008 = 2359296 bytes
> Sorry, I forgot to do that; thanks for catching it. Yes, the
> calculation is correct.
> 
> > > Memory: ... (... 733252K reserved ...)
> > > 
> > > log_buf_len=1M:
> > > 
> > > printk: log_buf_len: 1048576 bytes
> > > printk: prb_descs size: 786432 bytes
> > > printk: printk_infos size: 2883584 bytes
> > 
> > and here:
> > 
> > printk: log buffer data + meta data: 1048576 + 3670016 = 4718592 bytes
> This is also correct.
> 
> > > Memory: ... (... 735556K reserved ...)
> > >
> > > Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> > 
> > Otherwise, it looks good. With the updated commit message:
> > 
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > Tested-by: Petr Mladek <pmladek@suse.com>
> > 
> > 
> > Note need to send v3. I could update the commit message when committing
> > the patch.
> > 
> > I am going to wait few days for a potential another review
> > before pushing.
> Thank you Petr for your review and for picking this up! I really
> appreciate it.
> 
> Thanks,
> Isaac

Hi Petr,

I just wanted to follow up to see if there was anything else left
for this patch? Otherwise, would it be possible to please merge this?

Thank you,
Isaac

