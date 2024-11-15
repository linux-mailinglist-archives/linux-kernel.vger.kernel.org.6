Return-Path: <linux-kernel+bounces-410589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE859CDD9F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ED92B23F66
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADB71B6D16;
	Fri, 15 Nov 2024 11:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CSu2Km9X"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D221B218E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731670886; cv=none; b=rd3dZ3lUiE+GfRVKku9UaGzYm0BmntnbWx4yhzH8djqdBq7yFY5Xklfje0U2b8ti37FaHscNwLmEyVpQAQdYB3vKmQy611eYvOOluDuBzhoTKQDEulAVvFldR1Z/CFuwx87apWanrfrsECX7r45n0Jiap5BWUb+lphaieA/ZRso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731670886; c=relaxed/simple;
	bh=zOyo5COq+8myjBE0eOo62YLhO2AXFGHDP+G+EWr+RTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4YTSo5OY71wHQTu8xQJPSUPdmvUf0Z2bNEZS07FJx7xhBnlni+MgY67EJ3GFz0l6SIHtxBCCcSTRjrJoiRCdHJa5RuLYm76JjvRKnVUX5utoonzTNWNIePWqfBm3xmnQtpYl/xoQD6gtjvMmG1RZcJz4kf6gAFcMYiiZ+jKnf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CSu2Km9X; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d3e8d923fso1198303f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 03:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731670883; x=1732275683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xF053wpgtdzr8IcutMD9B2cfG2Nm2K0eZSa9yjvefU4=;
        b=CSu2Km9XPhASLswTyxhNLc8KuwU9IrFz2sJ0rBl3WlcrpgkCBT3RC/Tcd1rsvXUi+/
         KbQvEbnbHxeQ2gFM5T5hg2QcxrhH0pOfqFepm3fp49jTbz83tUxEARY5yvwgG8UTJ1CH
         SYyg2tN/chWE3f9IEu6WlsZGQ86pGhvyEYzrqAfu8SFPVV18lpBCoJLz/QtuOZOzxuUy
         CHaYsFfkff1oINppE/zCQKtKx33fVIoUM6d6sXK/dyNjC8vm2/zFyU9WoynQ+hsei3QJ
         ms9SdH787yCqLV+DULC1DdOvz1+uoter/W1ox9Pew0OGonnPApFbtlsQSivEdJyER/w0
         2RtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731670883; x=1732275683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xF053wpgtdzr8IcutMD9B2cfG2Nm2K0eZSa9yjvefU4=;
        b=WqOTbuy7Xt3awG/0YAVgD57chBYkRWBNCw4VolkJrzSNlz0M/yGr6s1J7y7tFKn9xo
         FqftCSJpe/n/J5ljae3w7fSyBRQyn35N5z4uWexNhbVtmoTjiPebufhWtuTIk/XpKNiG
         2XSQ/zVHZu2JMHAPfG3D9zzhfnpJEhLKDWjCidvjXPXiy2b3UtkHWmbdPpZaYRXK4oG/
         XnDv2wdYBKJG4YAcXfN2qxinhyK8mRZtS8FjlguaRMH6xg74enP5kL7zeQC9D8nlEkUK
         oq99h9UGtelEDpCb+Hr+RgeN+ge9PKjTXCUS44RtstnOkgR9kbQKp2csc0Pmell9F5qa
         tY5Q==
X-Gm-Message-State: AOJu0YxWUDdtSj0UUz3J5bVfR+Pul6fuujsyxJNsLaAnev9Po6SXMcvr
	HStCYpjUgq2IutT7+91DTf/97jbE4sBhIVasE0xIqlgsPW7uHFo1GsPGhuUcUes=
X-Google-Smtp-Source: AGHT+IGbyKqIEk1xK44OLQSqjB0z5tzBl+LgtQnO+9w0M0pvjwyYpLAS6wVhLG18oxscMEUsMoqBaw==
X-Received: by 2002:a5d:6d05:0:b0:374:c8e5:d56a with SMTP id ffacd0b85a97d-38225ab7bf0mr1521623f8f.48.1731670882950;
        Fri, 15 Nov 2024 03:41:22 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada2f25sm4238395f8f.9.2024.11.15.03.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 03:41:22 -0800 (PST)
Date: Fri, 15 Nov 2024 12:41:20 +0100
From: Petr Mladek <pmladek@suse.com>
To: Chris Down <chris@chrisdown.name>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: Conflict with FORCE_CON: Re: [PATCH v6 04/11] printk: Support
 toggling per-console loglevel via syslog() and cmdline
Message-ID: <ZzczYMMePV3oWFON@pathway.suse.cz>
References: <cover.1730133890.git.chris@chrisdown.name>
 <07141a533c4071c364c4f2eda6d97a9a89797e67.1730133890.git.chris@chrisdown.name>
 <ZzM0T5b4uKIN0PM7@pathway.suse.cz>
 <ZzZPVp8_ZHbGgn5z@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzZPVp8_ZHbGgn5z@chrisdown.name>

On Thu 2024-11-14 14:28:22, Chris Down wrote:
> Petr Mladek writes:
> > On Mon 2024-10-28 16:45:40, Chris Down wrote:
> > > A new module parameter (ignore_per_console_loglevel) is added, which can
> > > be set via the kernel command line or at runtime through
> > > /sys/module/printk/parameters/ignore_per_console_loglevel. When set, the
> > > per-console loglevels are ignored, and the global console loglevel
> > > (console_loglevel) is used for all consoles.
> > > 
> > > During sysrq, we temporarily disable per-console loglevels to ensure all
> > > requisite messages are printed to the console. This is necessary because
> > > sysrq is often used in dire circumstances where access to
> > > /sys/class/console may not be trivially possible.
> > 
> > I have just pushed a patchset which removed the console_loglevel
> > manipulation from sysrq, see
> > https://lore.kernel.org/r/20241105-printk-loud-con-v2-0-bd3ecdf7b0e4@suse.com
>   Noted, so would you like me to change this to be based on current
> printk/for-next, or is another branch preferred?

Please, make v7 based on linux-next. It seems that the merge window
for 6.13 opens the following week. So that the other patchset should
reach the mainline in 6.13. The per-console loglevels would need to
wait for 6.14.

Best Regards,
Petr

