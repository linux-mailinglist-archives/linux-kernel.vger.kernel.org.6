Return-Path: <linux-kernel+bounces-272553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF771945DD3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B7D1C215B2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A681DE85B;
	Fri,  2 Aug 2024 12:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K+t41Kha"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8201E505
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722602068; cv=none; b=Mv1rSQH755ymQfqzAC9cbCk2q4mHhWt1BxBxAeH3gi1GhcZWvdnjxG0oaATrtZcgC5cCCO/lk9VsxgMEnexp5tEA6+/kKSYLmi5s/p7YOGFTC2tUNer5YoQsA7seVyMkpRCxNgRK6RMqZfuKVw3XNqwR/9f4HjfaiqRV6I/80i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722602068; c=relaxed/simple;
	bh=wep4Ew9P8tOMLyW8aBT3i/sDjpDB6b1K0/du6R89PZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jy1ImzrMC8NjaLhOsoHOcmIUj5gLAt1yE5RFa2nhfgjROYYySSer7oGehMol5Jy5IOZfU2OHy/otRTT0wmyCKBF5EM+JApxqH05ti1dbDRt3/+Wf0JDY6F1BJFutywg+244fWgbUdp8aceAJcTJqpLnWDN6BroNmESAhs2nins8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K+t41Kha; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52efdf02d13so13473841e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 05:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722602064; x=1723206864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EpQ32yxaR6G41EvCjwLaGrxfkOQL+lJX1w8a1HXU06c=;
        b=K+t41KhaucyRgbCqMRFcxaQ5R1OFnyXXfpe9I5TCtf+P8+qmXPX9/pAlHdG2Gjhior
         2sHEinPt5j7ZyELeWuq7xVk+i1c7fErXv+pc7cXoFvGJi4uVNthHh8ohEJ0NMIyZtPMF
         cSKclFzzS9x3gSHuub0JPXIAfBCzT4NnhRrQMYCJHFAk8mKPgtJFdGSQdCs9z+yO73/+
         qLbApGoMk8s/6L8XFXxp5nxid1uMkhk6W7GIMoEtZb+xpVqwfM5W3ZvwIzKLN7XVCC0I
         zTDuAt9EWFH2LucRyLRPnGr8q5brsyBT3N5gO6f1bsZxsIr50XtobA9YV0wzNbc4ui1T
         l9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722602064; x=1723206864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpQ32yxaR6G41EvCjwLaGrxfkOQL+lJX1w8a1HXU06c=;
        b=RZt5W+W0x7KUWBFYwlQ4mOpTvAWYBg0yHgL3YprT2XLd4IFuI1NFxVdUbpl0Ro/arn
         xTSXogcB+Cxug+7a1XW+VktFU4glPCYJHoIUyTy5hv2QRMWuSzB7i6jufOahxUQJpdeP
         tcspXSG9yb+O6tuHx6bTpn0y+IYFKkbUvbrmThuq0/4kQLmS/Iu2/9ZoGRh4uWoGRyIN
         iSPbrOkkaajQ7ufC7C+XfxUVakxmuVtjSsjMblorBk73sbsbcrrMYwdcbF3GBPX6ofA3
         n5lFdEBKXLlEt0MDU+Cbl4ejibrx5sHv4CZDmrzI6EsKHHYCV25gW/7ZMayU6qBHi1ET
         ratg==
X-Forwarded-Encrypted: i=1; AJvYcCVOvqYg+vmtj/I31WI9naD0takSrsrdn6UNsiF20SNFQ6odqa4Lzs+BWchlo4w/rQu1ngt3rW/TLUZiRaDanie8XI5N98MncJL/Rxm7
X-Gm-Message-State: AOJu0YzE9wjgJxEusF7E/7c0sQ5R+m4HEyhpOePUFqJcXfdgqnWWXOfn
	kVU7aL+gI/Qx6FjUFWPew9CJ6OyZsL7xPsm4mDuEOVlvXF7tKFkC3PUWAKuq38A=
X-Google-Smtp-Source: AGHT+IEhqRxrqYg7HyfO+00nKTCN+aEnPofxgBXKlnPK/2HYCDlLMwP+rVUVHG+pRBC6DiElyItghA==
X-Received: by 2002:a05:6512:2305:b0:52e:a03f:ef53 with SMTP id 2adb3069b0e04-530bb38c982mr2933841e87.24.1722602064193;
        Fri, 02 Aug 2024 05:34:24 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d437bbsm94683366b.121.2024.08.02.05.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 05:34:23 -0700 (PDT)
Date: Fri, 2 Aug 2024 14:34:22 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 19/19] printk: Avoid false positive lockdep
 report for legacy printing
Message-ID: <ZqzSTocPmBpEOk37@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-20-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722171939.3349410-20-john.ogness@linutronix.de>

On Mon 2024-07-22 19:25:39, John Ogness wrote:
> Legacy console printing from printk() caller context may invoke
> the console driver from atomic context. This leads to a lockdep
> splat because the console driver will acquire a sleeping lock
> and the caller may already hold a spinning lock. This is noticed
> by lockdep on !PREEMPT_RT configurations because it will lead to
> a problem on PREEMPT_RT.
> 
> However, on PREEMPT_RT the printing path from atomic context is
> always avoided and the console driver is always invoked from a
> dedicated thread. Thus the lockdep splat on !PREEMPT_RT is a
> false positive.
> 
> For !PREEMPT_RT override the lock-context before invoking the
> console driver to avoid the false positive.
> 
> Do not override the lock-context for PREEMPT_RT in order to
> allow lockdep to catch any real locking context issues related
> to the write callback usage.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Makes sense:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

