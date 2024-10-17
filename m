Return-Path: <linux-kernel+bounces-368974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F218D9A172A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0271285826
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE4C3FC7;
	Thu, 17 Oct 2024 00:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="xcq5NkuB"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1883C30
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 00:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124995; cv=none; b=ZTpRCB0Iw0i9G8EJdN6uF7Ol31z0PuMx7+zMj1B5FgihaF2ckiSIAQCdMpeklQ/0jhJFR1a8spUiUnwTvOYf4+00lZUovn58UqpmNNpWVq2cjxpF0Zq/04kTcMGrxPtu9q4sQwx3q1iEGRHdW85U17OIeXbPqqaftcz43KkolFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124995; c=relaxed/simple;
	bh=CDT0XC42KA5kDFs8w7hrAge7hVDbt3kWQB9W64z5KD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2Z+FUJvAocW3OnSYOqOR813SpNb49l8HRjsrYFrruMAPJB0LRPn+pmFotSRj3xzXAGMqHdJpL9rI87UTVHrAdy036+Cu3d9GPutgHMbj9urhXsy1FxBh+s0csKzf7LD6B8AnfR60hdV0082kwJiYTKN6eerpQUFIHjVb33z8gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=xcq5NkuB; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea6a4f287bso259620a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1729124994; x=1729729794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f1wptyjhT3IFmslFEr7REugt6yoC6NkBMTWfaUPoWYo=;
        b=xcq5NkuBaKv5OiWVApSSXaBz7DbpkbJUE/66Mk3Flaw4TRjQ7fsjHTwWPyPoj32dHM
         HeTNrMqjxD+sXbJ8YEJGsYVzYHta4En4LhaVxYZsOoKl2cyw67r1kDOkdBT1lSmQ2oT0
         mSDpBLYcMTWX33g6lpA4ANHOTwya+1Tc+FdoaOK+PwW5GCd3FBAw3/Au5kXNrRAbzWUF
         pHBCIUIi/1qqhD+hjKIWYtcHrAt1Sosfpu3dwBojJ2ZMuVDdeHbRWYfAJoHTyuF6JNlX
         kjLCxkQHw91ukNrJN0gzZCVbPvbEWppZ9b9d1Wn3rPiQh8yVRPWOlb/NkDrSuoI/cWs7
         aB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124994; x=1729729794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1wptyjhT3IFmslFEr7REugt6yoC6NkBMTWfaUPoWYo=;
        b=Xdtl4ALGGsTgAfXT7KXt5BDfNsgLSZgn7P/iyKzkqzDJDVh5XZkWczeYzOcVR9qaE+
         Wyp/r4rJPpHFuxyRDXK9fW0S29D2RRYG9Ks455oT3ySSOMhrfA3v2cdMvV09Rhgq9xdR
         0vXVdiDarB+aWXzv8qDzoF91vD74W9hzM8cyiIAECB7K/Waa9p+BBsPCAVCTi03CusYy
         fA5JXXWzJdj5jOAnTbZwPBokSw3AVH6ZGnMpMdtfYzj75heLjeJZFR1RtQ07kHmh9rwm
         EfHicHZz96l4yj/hIZa4x+SG6ZSYUtVOv5K7RejoAOV8Qpa6u/Kl0dJtCF1dVqH2aeRu
         llkw==
X-Forwarded-Encrypted: i=1; AJvYcCVvLluGylJJaGxL0ivMDdigHaXpr3gmr/d6rtm8buX89xWpvyznXiPUC1FRlRPL7NqC6CoaiXllcIzBqJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmqVpru1fDnmQSUmsDrdX0tl6MSBS/Oit1BfNg7CS4t0DXroP5
	sc5xjFcDk091SNVneKgICZki6HTIWIWwauL+/frVRUL/Ih+CiIheohfQssFGRec=
X-Google-Smtp-Source: AGHT+IGUGyt85bsnX8/5grRTTn+LbgbFmLULv4/fW2j0FdiTvsodajpT5FkWWCl6tVIuG8LUNy65tQ==
X-Received: by 2002:a05:6a21:164e:b0:1d9:f5d:b502 with SMTP id adf61e73a8af0-1d90f5db650mr4313437637.15.1729124993709;
        Wed, 16 Oct 2024 17:29:53 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-209-182.pa.vic.optusnet.com.au. [49.186.209.182])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c715dbfsm3361295a12.87.2024.10.16.17.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 17:29:52 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1t1EOj-001nfB-33;
	Thu, 17 Oct 2024 11:29:49 +1100
Date: Thu, 17 Oct 2024 11:29:49 +1100
From: Dave Chinner <david@fromorbit.com>
To: Xiongwei Song <sxwbruce@gmail.com>
Cc: cem@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: XFS performance degradation during running cp command with big
 test file
Message-ID: <ZxBafdsU6ioeTBmQ@dread.disaster.area>
References: <CALy5rjUMnocsh80gPB+4UgaFS-Gsz5KAFnAN8Nj7m_oyohFfvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALy5rjUMnocsh80gPB+4UgaFS-Gsz5KAFnAN8Nj7m_oyohFfvg@mail.gmail.com>

On Wed, Oct 16, 2024 at 07:09:29PM +0800, Xiongwei Song wrote:
> Dear Experts,
> 
> We are facing a performance degradation on the XFS partition. We
> was trying to copy a big file(200GB ~ 250GB) from a path to /dev/null,
> when performing cp command to 60s ~ 90s, the reading speed was
> suddenly down. At the beginning, the reading speed was around
> 1080MB/s, 60s later the speed was down to around 350MB/s. This
> problem  is only found with XFS + Thick LUN.

There are so many potential things that this could be caused by.

> The test environment:
> Storage Model: Dell unity XT 380 Think/Thin LUN

How many CPUS, RAM, etc does this have?  What disks and what is the
configuration of the fully provisioned LUN you are testing on?

> Linux Version: 4.12.14

You're running an ancient kernel, so the first thing to do is move
to a much more recent kernel (e.g. 6.11) and see if the same
behaviour occurs. If it does, then please answer all the other
questions I've asked and provide the information from running the
tests on the 6.11 kernel...

> The steps to run test:
> 1) Create a xfs partition with following commands
>    parted -a opt /dev/sdb mklabel gpt mkpart sdb xfs 0% 100%
>    mkfs.xfs /dev/sdbx
>    mount /dev/sdbx /xfs

What is the output of mkfs.xfs?

Did you drop the page cache between the initial file create and
the measured copy?

what is the layout of the file you are copying from (ie. xfs_bmap
-vvp <file> output)?

> It seems the issue only can be triggered with XFS + Thick LUN,
> no matter dd or cp to read the test file. We would like to learn
> if there is something special with XFS in this test situation?
> Is it known?

It smells like the difference in bandwidth between the outside edge
and the inside edge of a spinning disk, and XFS is switching
allocation location of the very big file from the outside to the
inside part way through the file (e.g. because the initial AG the
file is located in is full)...

> Do you have any thoughts or suggestions? Also, do you need vmstat
> or iostat logs or blktrace or any other logs to address this issue?

iostat and vmstat output in 1s increments would be useful.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

