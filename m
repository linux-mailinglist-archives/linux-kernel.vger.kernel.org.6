Return-Path: <linux-kernel+bounces-380684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF0E9AF48B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB63E281472
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99B12178ED;
	Thu, 24 Oct 2024 21:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="0p+Ehihi"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA50216A34
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 21:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804406; cv=none; b=mOUEWE7qIi/dI9tK71BIpuWS6LqGZ8K4wRmc3n5tedu2sZr/neIUKBu5L4FbSkm1stcRFD6qaQg5xkFqrGI3uZpU8+WmvB5CaINTSdG+ikARPbF27vZ8Oz6IkytfikFGuGnBy3/ow/zBDZcPONTMwz0wtlk7c2aJLEtElCygH60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804406; c=relaxed/simple;
	bh=+4voujdCR3hr+aHqsPplZcNQHMESshBlhtCDJ+kukfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsPRW3HwtLrLc97aSa3UZ8n9HWEEQkfYV4KfkW3lIDoaa3ioUQ1K3W3lFUQzHrlqkdslGDKbDt1gooszSDsSISENKNQdEoKJplbkPe5o26qrPkouEfC1XNLhopIu3ondH5N9CW4qEC7XbqW1L42yu44XhhwAj7sojb7nDUQ/Lk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=0p+Ehihi; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cdb889222so12088255ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1729804404; x=1730409204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XK26aUi6oOdLrlZvhuXktuYwEbsoIROsGkYCLCMengk=;
        b=0p+EhihiDUF8zpQ+Pt9zGQpDYKfNUNv7ZQanx304Ax5X2w5DkaH4AB6pb0G0N1qxWQ
         NSg4PKfbUdhKn0SXo5/JiCwK3bIW6sSouqhXqI2Z8hXTJF7kvEbTy8LJyU1v95e6Jq+c
         tMTFCcIK42RLSKEuimldWtAUOPFxH7R8d+nXGu/783lDc+CQr7uBfDGHcLOKqvMQuTvi
         1qdneUBwZ1NxpUfcPBZ5BEiX7CYHaQ6MF2aMn0Ydo4p5nXYpJARyxLC+cTVT8HiBWJFh
         aGsFDd5jslV94c/dJ5MToNNmnTMNyGvyXRDg6ILPeuHejMSwe+RgUUeOjz3myeN+8Li3
         sQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729804404; x=1730409204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XK26aUi6oOdLrlZvhuXktuYwEbsoIROsGkYCLCMengk=;
        b=I6wQ4cIg/bKjxuDQcflEoy9FIhFU/JXr9I2MuUGkuM7k2XQlCPXZ8phgQB7xMSS0Dw
         Q4XrdGwKUHG+a9pih/2SnPpwHGqx/uP4m9U/8b1Ad9GprklWZC0ZmMAiYoqjeKU75G6X
         1Sj7uS8OdtBZBmmFYqpYz1N/4FA0OxrEhmyY18IanebcxMFMYwACMb4ceraCfz92kDVQ
         hYhyiSMZP+urEIn0ISdlbnVYP145z4EjQTp/7POaNGuzgEjs9fU3KLn4VcL2xKeIQPFV
         Gz82rs+JxpdA9kIVJHEaquQER5wyYM/8kQG/dmfRQBINMcvEWKdQ7HZ2vwg7JlqfXu5d
         qsAg==
X-Forwarded-Encrypted: i=1; AJvYcCXCves5S1X8d/eQsbeoj9yHB0TfuaOjACSI0UKLEA7s49HpuE8B1Ovcao4mZcqaf3k0dv0kcRorebYgw70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye4atvA3fi87VEgtgelOaGAApliAni7O5d2LIjg34uhLwMt6rM
	c7FUHC5PBquSWoy2NuJyNbDhALlcScrASl84qDxq8Iwk/2IHpT1STLmF+GPPP7M=
X-Google-Smtp-Source: AGHT+IF34KaG6GXfaaaywzM5bq3qP6x5Bi6ZvJDtJlgnWUmss4RpecpUJtyGc1S55aYfogVCTDFtqg==
X-Received: by 2002:a17:902:db12:b0:20b:5645:d860 with SMTP id d9443c01a7336-20fa9e7f26bmr87877135ad.36.1729804403697;
        Thu, 24 Oct 2024 14:13:23 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-86-168.pa.vic.optusnet.com.au. [49.186.86.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeab581e4sm9112686a12.50.2024.10.24.14.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 14:13:23 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1t458y-005IfU-0T;
	Fri, 25 Oct 2024 08:13:20 +1100
Date: Fri, 25 Oct 2024 08:13:20 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: v6.12-rc workqueue lockups
Message-ID: <Zxq4cEVjcHmluc9O@dread.disaster.area>
References: <63d6ceeb-a22f-4dee-bc9d-8687ce4c7355@oracle.com>
 <20241023203951.unvxg2claww4s2x5@quack3>
 <df9db1ce-17d9-49f1-ab6d-7ed9a4f1f9c0@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df9db1ce-17d9-49f1-ab6d-7ed9a4f1f9c0@oracle.com>

On Thu, Oct 24, 2024 at 10:35:29AM +0100, John Garry wrote:
> On 23/10/2024 21:39, Jan Kara wrote:
> > On Wed 23-10-24 11:19:24, John Garry wrote:
> > > Hi All,
> > > 
> > > I have been seeing lockups reliably occur on v6.12-rc1, 3, 4 and linus'
> > > master branch:
> > > 
> > > Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 at
> > > Oct 22 09:07:15 ...
> > >   kernel:watchdog: BUG: soft lockup - CPU#12 stuck for 26s! [khugepaged:154]
> > 
> > BTW, can you please share logs which would contain full stacktraces that
> > this softlockup reports produce? The attached dmesg is just from fresh
> > boot...  Thanks!
> > 
> 
> thanks for getting back to me.
> 
> So I think that enabling /proc/sys/kernel/softlockup_all_cpu_backtrace is
> required there. Unfortunately my VM often just locks up without any sign of
> life.

Attach a "serial" console to the vm - add "console=ttyS0,115600" to
the kernel command line and add "-serial pty" to the qemu command
line. You can then attach something like minicom to the /dev/pts/X
device that qemu creates for the console output and capture
everything from initial boot right through to the softlockup traces
that are emitted...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

