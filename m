Return-Path: <linux-kernel+bounces-266698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0A9940588
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 04:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0646E1F22037
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 02:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDB542AA5;
	Tue, 30 Jul 2024 02:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ezwrHA+i"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FFC1CD25
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 02:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722308094; cv=none; b=UVE/SZ9SLg6VemEXbnK3+ADSKDdS9vHyPjd8t+1roecKGgI5EpAfYj/E2yebASXsry8kADwQjx4ZJEhVdCkEHEqGABrvi96S1LBgFQ6DlTht2Td6jGZIcmkGlx9qYC1W+tME+XV2GkEykgP+amWk5tjfqZhkJO+O/ki9ma44384=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722308094; c=relaxed/simple;
	bh=4DKXwTOXGRifVehksdP7ASe1iFP8aSGYh9Bi51Nd5fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSPEc+dTGp/FFlQyJ/n9hx+5jrCoMfQJ/2XREDWtYMvK9J7SEVKbEdRtNkmuSkw6K0UKIv9Ia6qOiW60CO3tuU5lFKnQsZWBsM7bC4hgX6NbWtRZ89w6lGsipysZz+MTfGzz8bEm2c0aguTV7Fknq+qKBTLI1tilcSO7uwOpA4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ezwrHA+i; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3db14339fb0so2822516b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 19:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1722308092; x=1722912892; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IXhr7QDVqMjze51cc8rGfZkRClby+uSW76McCfxaQHk=;
        b=ezwrHA+itLq5PN81glR7RtgsdJJjv5IaSEDlPNRyd2opeXIGayhmSYNl1vnQTqQaV7
         RQ/7NVdX1olGAkuKmgkyCP8gzwXSQIwmW4s203WhZRuIHQwzNw7XJqfK6aO2Fe/OvpuW
         qGW4xM+ZFzo8WfoXxZqlO2q5JSplkKjLAPzieg2FMlRl8LadEj6M4uRvsKASW39UxD+V
         /rM1YtT75xd5lamtaUDNQh2edesNjkIAlZUesprUZtM2elndYRs18KgVyWRDkZYYQCAp
         ZyjmXKI6VpSu0Sb7sih5xXqYLxpabRa55VcqiZlla8pHtWTlsk2vGNa2WTB0usSclC/+
         z6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722308092; x=1722912892;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IXhr7QDVqMjze51cc8rGfZkRClby+uSW76McCfxaQHk=;
        b=nI8QsHMRnWtE5KSuUNvCy0WYvkwZfhZ/AYFVHSt2UDpot/TZZjrBb0qRLWyJ3PWisZ
         AmR/6PIChU6bfLWYDvUNF+/CnXsZhKyJ1HeMJh6nl0INlIod1fy9noswOSpVZraSInCJ
         LSQD366hAp7a5cK0wDxoRfK3K+ONnBTrczG4epbhi4Y0iET7I8QhplMOY1C0WkgvtjXN
         NJuFvnFKptuDMldlLWCkFeM9sKOlk9yni+huVoMxRIp1Sl18aNMk0yJF+3ZaphNwmM3h
         8tNHZu85x1HqDpjstZfsfrgqIVSyXNtqJXzEMFkBe0S48qpZ+LIa+QKHdk3TaTbYugGB
         jNWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOFrQL+FgQdI9vgJIx1+AuHuZvVpoxHVPHt1ZMa5EEyUofXriAjbQOblmMbUyAegmrfamLhmZ7JwPushwuvmGmRk1TfWMgv/kQP0iR
X-Gm-Message-State: AOJu0Yxq23QsgQyel6xei4Fe1UcX/NnL05c9Vu+qf/hVdqHeKMg67rAz
	Bu3Ukbd4j03+j+3kNnpQzffD8zLM1uykE25oB3NQBunBGR8U6iHsjkxJKNAGrCc=
X-Google-Smtp-Source: AGHT+IH+M5TmiJzVtoxVVgF39Iukl8K2trADdgg+a7EhyWKfcrF7/37r10kwrM+Wv4vvT6mqNWV8AA==
X-Received: by 2002:a05:6808:1495:b0:3d9:21bb:170d with SMTP id 5614622812f47-3db238bd70bmr13582636b6e.16.1722308092301;
        Mon, 29 Jul 2024 19:54:52 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9fa49cb6csm7902244a12.77.2024.07.29.19.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 19:54:51 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sYd0i-00GFgA-2a;
	Tue, 30 Jul 2024 12:54:48 +1000
Date: Tue, 30 Jul 2024 12:54:48 +1000
From: Dave Chinner <david@fromorbit.com>
To: Steve French <smfrench@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	CIFS <linux-cifs@vger.kernel.org>
Subject: Re: Why do very few filesystems have umount helpers
Message-ID: <ZqhV+PvVKESa3UVw@dread.disaster.area>
References: <CAH2r5ms+vyNND3XPkBo+HYEj3-YMSwqZJup8BSt2B3LYOgPF+A@mail.gmail.com>
 <20240729-abwesend-absondern-e90f3209e666@brauner>
 <CAH2r5muRnhFevDR29k=DkmD_B44xQ5jOXd5RnRqkyH27pKzNDQ@mail.gmail.com>
 <CAH2r5mvTFDShaGeygoykFzB59B7SckxM7u5QHzKOwioP_W6e3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2r5mvTFDShaGeygoykFzB59B7SckxM7u5QHzKOwioP_W6e3w@mail.gmail.com>

On Mon, Jul 29, 2024 at 04:50:27PM -0500, Steve French wrote:
> On Mon, Jul 29, 2024 at 4:50 AM Christian Brauner <brauner@kernel.org> wrote:
> On Mon, Jul 29, 2024 at 12:33 PM Steve French <smfrench@gmail.com> wrote:
> > > The first step should be to identify what exactly keeps your mount busy
> > > in generic/044 and generic/043.
> >
> > That is a little tricky to debug (AFAIK no easy way to tell exactly which
> > reference is preventing the VFS from proceeding with the umount and
> > calling kill_sb).  My best guess is something related to deferred close
> > (cached network file handles) that had a brief refcount on
> > something being checked by umount, but when I experimented with
> > deferred close settings that did not seem to affect the problem so
> > looking for other possible causes.
> >
> > I just did a quick experiment by adding a 1 second wait inside umount
> > and confirmed that that does fix it for those two tests when mounted to Samba,
> > but not clear why the slight delay in umount helps as there is no pending
> > network traffic at that point.
> 
> I did some more experimentation and it looks like the umount problem
> with those two xfstests to Samba is related to IOC_SHUTDOWN.
> If I return EOPNOTSUPP on IOC_SHUTDOWN
> then the 1 second delay in umount is not necessary - so something that
> happens after IOC_SHUTDOWN races with umount (thus the 1 second delay
> that I tried as a quick experiment fixes it indirectly) in this
> testcase (although
> apparently this race between IOC_SHUTDOWN and umount is not an issue
> to some other servers but is reproducible to Samba and ksmbd (at least
> in some easy to setup configurations)

So you've likely got a race condition where something takes longer
when the shutdown flag is set then when the filesystem is operating
normally. There's not a lot in the CIFS code that pays attention to
the shutdown flag - almost all of them are aborting front end
(syscall) operations before they are started.

The only back end check appears to be in cifs_issue_write(). Perhaps
that is failing to wake the request queue when it is being failed
with -EIO on a shutdown, and so it takes some time for something
else to wake it up and empty it and complete the pending writes
before the fs can be unmounted...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

