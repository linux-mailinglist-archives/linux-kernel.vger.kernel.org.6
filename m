Return-Path: <linux-kernel+bounces-407987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC3E9C7992
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48614B34290
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D1715CD60;
	Wed, 13 Nov 2024 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dqx1aO+n"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515DF249EB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731514302; cv=none; b=aprw3a58DKNUWHtP/YOKU8Dldcv1O2MAs2k5b6sFCxjZOLftHRtvOJf/h47b+PwN5tmaHXEVKr68oDr9SqivO/D0QjRhmyc5EYVlvpU0ckJKZ053NmxBAYJkCssHjVvJhVtWXzRcQYATBk+bHndsjkTwMFhkXSOIvP5+NMSkv6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731514302; c=relaxed/simple;
	bh=h1jftPJHQSBu/+lukUOa4OZCsHjT2nb6TTeZwFv3ohc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msNMbUCEJWfRyWw3Ho/XDB4fJ2ArCXlADJ/Bi1cNqcqI2FVjp0p5meUDkNvpbq9raZRruH88ztlCCzfx1hGR4+1uaCq1bg0e0LEyhoYsNJfCdWp5WCj3IzEG7tXHTtKjpOOP5k+BAUQu5+NrGy5G+1fieEbaSNDoMVvrRB1LDtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dqx1aO+n; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d3e8d923fso5039211f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731514298; x=1732119098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ocP0DQ4ei3XXA6qNw//0ZH6NKzMbKW+5mc510jIzRcc=;
        b=dqx1aO+n2xtkVS2jLWwNjkmkajofWFNy+FerRh4zXFrDvoKBWCWIo1/0pK11L1Fyf+
         R5u8W7mgdXHGnyL36vB9n+Q45xq5mg+9bZS30XtNq57duROj60u8SJN0AZVPh+HuAkYc
         N5OqVlfDs3bKH66FFgF1mtzBe9A5g4wKug3+ma137y/PYg1afOZtdRJqdUHU9ipPri5+
         pRdbGHCX2kmVFlH9LyqXUtMG46DljRA62s/nFvb/aWHny24Q8QfVEMK0w9EimwoLoy71
         OLAxHMMyw0QagRIrRtvMBJX9YnZaWiSStFfjjAeHCkWq/D50M6IDrXX/HnN9ObhTPUaJ
         iWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731514298; x=1732119098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocP0DQ4ei3XXA6qNw//0ZH6NKzMbKW+5mc510jIzRcc=;
        b=vmAX1eKC5ena+Sjw/0F99h8ADk9L6oQfnUGyy0V59gpGqqqCrXD7V1fBdJMOiodWuL
         rDkPQMiyhRykZnhMOAlrKPerIUDQiRV1sD03dNX/7dMCiLJqxGlaBogSxb1Di+yIDhqF
         ijpqmZS5Pn7vCoecdkFSWfX1P3rXdX06gKLI+vfj7/xySB0z5wVgFVzzqVbMKVhLWYFa
         26f5vMlM8gfAbb/NZBcN5o1U5xt/7ibSEUBjwxmOErTlMEAxGdnSKfe5PKHiyG3hIzIp
         Qe8iuiaWAhHMdiYEkcrbd1LARYumfoUpSoycCpP/W+y+JqQIfpSL3qdZaPK/XmyFai4S
         5QMw==
X-Gm-Message-State: AOJu0YyjwIFeqnTTbepocPuUo7hFjy1rChR6sc46jKrdZ9o4DkyzFDuO
	9umH/iLqfmI+QQFFfsDrDs78+MAtplpZSSTTBK4zun/p3YSr3VYB5XgdewCFh74=
X-Google-Smtp-Source: AGHT+IGKjPvMCwwBGdLFU8KuAMwgGxq0Gf7k1MVuXstd0u3APOvvuvUGarCuk+3TPiNJzl5CVs7Jzg==
X-Received: by 2002:a05:6000:1569:b0:37c:d162:8297 with SMTP id ffacd0b85a97d-381f188589cmr17258067f8f.47.1731514298607;
        Wed, 13 Nov 2024 08:11:38 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed970e23sm18662618f8f.18.2024.11.13.08.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 08:11:38 -0800 (PST)
Date: Wed, 13 Nov 2024 17:11:35 +0100
From: Petr Mladek <pmladek@suse.com>
To: Chris Down <chris@chrisdown.name>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: [PATCH v6 07/11] printk: Constrain hardware-addressed console
 checks to name position
Message-ID: <ZzTPt6mEhiBNncH-@pathway.suse.cz>
References: <cover.1730133890.git.chris@chrisdown.name>
 <507dee05e622cc37418b23e5de96b6b449410414.1730133890.git.chris@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <507dee05e622cc37418b23e5de96b6b449410414.1730133890.git.chris@chrisdown.name>

On Mon 2024-10-28 16:45:48, Chris Down wrote:
> Commit 7640f1a44eba ("printk: Add
> match_devname_and_update_preferred_console()") adds support for
> DEVNAME:n:n style console= registration. It determines whether or not
> this is a hardware-addressed console by looking at whether the console=
> string has a colon in it. However, this interferes with loglevel:n and
> potentially other future named options, which also make use of the
> character.
> 
> In order to avoid this, only search positions before options.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>

Nice trick!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

