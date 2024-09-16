Return-Path: <linux-kernel+bounces-330784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A5497A439
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4011F2747A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78050156F39;
	Mon, 16 Sep 2024 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UGVcvnW6"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D535415687D
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726497240; cv=none; b=gHbXuQFC7OJoOuGPoXRYhdoPVJs656xYXIyJDAXnUdT1u4UQfHOc4N/4kql8jiGUUSfvGPL7EocJ8/PmBCQvtltWrRaAgR8uUBesiThZaRXPkRE/1nSV7wV7/wTFaVHOpjYtbq/Lxfu40iYD3qoar2xXhMp4Y6BeMBKTCOsmlNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726497240; c=relaxed/simple;
	bh=2O9dKB4M9hPrzdEfalRnI9e3/lZkTd8mT9vuyC01V4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5qapCJmwUmGSBkGwAGc59GVt8GfBW1gD6BIIo9iZnkEWPuu9vfH7IcCn0QNjAxNy12fy8+tOTwdyblYUi5ty7bOIUNFSYPR+RbxzFHRXZwSATj0n8bJzU5bHIl7p1FFc/gN/z0wER6YHuP+V6jzPlL1BwfFRC8zhYauNiY+2/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UGVcvnW6; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f760f7e25bso43932931fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 07:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726497237; x=1727102037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rT7fkfgKvdnxFcCjnHIHT63TtCsP/eoL84gnJAKgmpM=;
        b=UGVcvnW6XvdNJQ/XPMZGDzhzoy6Uq/LQ/hjNp5htk5Kr/kAh/J5NCgX5HUa7PsaWgH
         PmL3mRz8eWUeDvdpLlCNg38iOU/QP0YxqDvDAjhd2Sl2av612/0DbN6X47rkYkkVgJGe
         HIoJRq4lhR1mUYiSCeUNLMPSdt9MFz+d7Uk/ewawv0iyQ5lZud+/OluCNuPhCUYYH7kq
         lWuG/ZJCYCfEaaoVdiX3q2uqDaQB7boRLayflpDzgoA3NGInGHv+SOKhPNytZZfQ/hvl
         v1MJhD0vLF3upJpHEbzRkhgFCrsuARThamOS2SdOLpNlMn91bXcvPm7eb8To5KJA1cXk
         7J0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726497237; x=1727102037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rT7fkfgKvdnxFcCjnHIHT63TtCsP/eoL84gnJAKgmpM=;
        b=dkDfPWjtBEzWNCw92F0TsdoEnTNBEU73ZUd+YUf4k3IZEKp/VkWs6oF2sCOFUb8S20
         5oOazyOo1FdEt+GLiAJuc/pR3fWUvTKmGDWgly/GJyFlw5vLf5SjAgmDstE0pDZ0/0wT
         5Wg5JkWNln+apxNHdGL8xmeqOy7zsFA5ayOFaUqtnRhyUn+1OhFHbFzVx5fkw83r/qEH
         NJW2NQsm0AknHkjeXlODibrOBDVYQpc7gQGK0vprGDEiaTpylPV1RAHMd8kBvFFWlS6R
         Hz8rNHk3xI7MVrAF2cH3cb1zWQADVVTI1qi4Isly28vH2G9JytJqOLseozg7TCWeOtl9
         eQWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVlJLhkBsYcd4uR4VtcdQjS0jON65IiR1osBZ7hDSEOD0FWes3u6NKBSs2zzgB0iB8wgX2B7QYl1sTe6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+FgAL/qUhwS4yBnoPrK/4hqEBZqkEsj/VjzzFKPw1ez6rhxyo
	dgJDYlyHEKb35Lz2Xow86g/3BkgDH8f31v1/Tapwd5V+lf9sTaE71lvm28u+bj0=
X-Google-Smtp-Source: AGHT+IHuJLmHDPZa+OPYL0UN8zzw5+L/Um9tpqARkqF7h1gNDPLFk2SH4KGpi8v0RdJu9yZmVO/kwA==
X-Received: by 2002:a2e:4e11:0:b0:2f7:4fac:f695 with SMTP id 38308e7fff4ca-2f787dbf6e6mr64543501fa.14.1726497236713;
        Mon, 16 Sep 2024 07:33:56 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfd25d21sm5247470a91.33.2024.09.16.07.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 07:33:56 -0700 (PDT)
Date: Mon, 16 Sep 2024 16:33:46 +0200
From: Petr Mladek <pmladek@suse.com>
To: Rik van Riel <riel@surriel.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Omar Sandoval <osandov@meta.com>, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	kernel-team <kernel-team@meta.com>
Subject: Re: [RFC PATCH] nmi,printk: fix ABBA deadlock between nmi_backtrace
 and dump_stack_lvl
Message-ID: <ZuhBymvNiB_8sWMu@pathway.suse.cz>
References: <20240715232052.73eb7fb1@imladris.surriel.com>
 <87plrcqyii.fsf@jogness.linutronix.de>
 <93155b2ccafa43ed4845ae450451c6b8e27509cc.camel@surriel.com>
 <87r0brkvqd.fsf@jogness.linutronix.de>
 <d18ff73a0ef7536f654b63854dc891984319093f.camel@surriel.com>
 <877cdilrko.fsf@jogness.linutronix.de>
 <ZqD54dcZUAirxTYg@pathway.suse.cz>
 <871q3ix2zp.fsf@jogness.linutronix.de>
 <ZqEY6ZIB7XThgKW3@pathway.suse.cz>
 <dbed42dc3bc05fa772e11b54e93526a66698401f.camel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbed42dc3bc05fa772e11b54e93526a66698401f.camel@surriel.com>

On Fri 2024-09-13 13:25:33, Rik van Riel wrote:
> On Wed, 2024-07-24 at 17:08 +0200, Petr Mladek wrote:
> > On Wed 2024-07-24 16:51:46, John Ogness wrote:
> > 
> > 
> > I see. I agree that deferring printk on that CPU [0] is the right
> > solution.
> > 
> > > [0]
> > > https://lore.kernel.org/lkml/87plrcqyii.fsf@jogness.linutronix.de
> > 
> Hi Petr,
> 
> we have been running with John Ogness's fix (from the mail linked
> above) for about a month now, and it has reduced the number of
> deadlocks in the Linux kernel in our fleet by maybe 90%, comparing
> a kernel with the fix, to a kernel without the fix.
> 
> Would it be possible to get John Ogness's fix queued up for merging
> in the printk tree, and then later to Linus?

Sure. Thanks for reminder.

John, could you please send the fix as a proper patch with some
reasonable commit message?

Best Regards,
Petr

