Return-Path: <linux-kernel+bounces-271890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 349E2945484
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 00:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57C641C2315D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 22:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7EC14D290;
	Thu,  1 Aug 2024 22:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="LFIKMjtP"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1016614B949
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 22:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722551324; cv=none; b=WHU/q7e6KrJ3PRUFGDZ3UjqIrNWUZT4QEN29kuNt674dX0qQSQrsQcX7/MPZfGwWolaPOEuHjeI02nqHirVtWwmPEKxCyYJ1NUX7XkIhaWMUM63GqmPkKTxMx9xh+zO+YFazIib2eqHYkbC/jdDo0eFXj5i+thAikUmGLwBZ2Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722551324; c=relaxed/simple;
	bh=cD+DdAn/DPHyEPshk6ipvfRDDw+LFLhg5xkAt5HpHs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbyBdiCtVSSiFm4GOUywwUPCVl25/DkX72EaCY799iqInhsD+glMn+R3xzUv9ZsWXlpuX2btYBANvlG5b6vGgIIt0oOEfvwUursdY+57WCZumzBeeue1mk5ap4/+3dCEnjnlhpXfc/LbKi7BcyLypPa1uuVsTPqK8rZszTYjHl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=LFIKMjtP; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7b594936e9bso1513648a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 15:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1722551322; x=1723156122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SRYsGq2oNdjeIvoc5FsVQQM4eH9uksp2HnfPLkPQWTM=;
        b=LFIKMjtPHzC8qUAuVDrdF4JPihti2inuKp8MtfcIZ89rMiH9drby4WLlbWqMLInTfI
         G7HkKvXKUS0j9ZznksoSmm29LJcysMu8ojfbF9ecWR80LOf7fBzS0gY0qRRdtc99t6YX
         z0f0neij1C6HeZLZ7yZaspHxuC2NJXXNsFirEXbwvAR/Elorxoer/zGVjVBXiEBcAI4e
         dA2rrQZPTMeh8z1xg842jghlPzhNgCP1VkFQpveLjKvrcbTnWhoWejlpMspFeSSm49eF
         FA/8HbUleoTZQyHNNRYYDVgniSb8uHlmfF5FY47sz4ek4dDd5sMci1x9wHe6yEQrSrmC
         5hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722551322; x=1723156122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRYsGq2oNdjeIvoc5FsVQQM4eH9uksp2HnfPLkPQWTM=;
        b=nTZwJsOcHiB4cV1Y3P9uH+4WzLjYZDMDIwXlpyUDiCi+m9UzsvAvZx1ZuYt+fcfvXf
         T85WbYzSmEfXqZkaMpL2zLQxg5eXjgWdX6QuQHw6QDDVczwmwa+FdCMgr+r2p2HO9hvG
         ljao7FRKSsVYht6YzHdj83wSTneE8jYtshssGpnJ+oxuIlrWcMhl5Qn+GUBDowEyufbP
         RBvtPhatkVPEU21BF4whSGBGmRhT3jMvvkPPCUiBpqbBiUvB/hyBcGGByta6Ni5A/zqO
         3bjiuKmW6UhyK9CPUbdkBWQiCSQyg46CDOdYtSnIfDECjFz9DJdCGSjo0lu4m/6ED+54
         rSFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBlWhNqoRfjBgW3S+YS/fyPsYSzgMzKIEIx+h0b1gNT9EQdozzVUXUWzz9+f3iSk1dDLJpju8mwopFn2iULmBtuTcqTBhrUMU6qfwF
X-Gm-Message-State: AOJu0Yx2YLWA6boHzcPcYiQdExU4DmkB9ITQQfVWwnXYu7lweHA1RLa8
	2xOpsRiKKMeuYq3qxJqTF3ycRBxsKQC06ro8Gc0rQBRakuwnaVE1DUQEgrsEjZM=
X-Google-Smtp-Source: AGHT+IG1VyhF7PulV5hUfA0sl/95gL1I+laFS95TuUeXZwqOhTGd3EUHP2S1u9L3VUz7PeMN4aTczg==
X-Received: by 2002:a17:903:41c3:b0:1f8:44f8:a364 with SMTP id d9443c01a7336-1ff5743b598mr19821295ad.48.1722551322289;
        Thu, 01 Aug 2024 15:28:42 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f29f52sm4084735ad.32.2024.08.01.15.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 15:28:41 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sZeHm-001yL8-31;
	Fri, 02 Aug 2024 08:28:38 +1000
Date: Fri, 2 Aug 2024 08:28:38 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	syzbot <syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com>,
	Oleg Nesterov <oleg@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>,
	paulmck@kernel.org, Hillf Danton <hdanton@sina.com>,
	rcu@vger.kernel.org, frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
	Ted Tso <tytso@mit.edu>
Subject: Re: [syzbot] [f2fs?] WARNING in rcu_sync_dtor
Message-ID: <ZqwMFjz7TYgV+hbo@dread.disaster.area>
References: <0000000000004ff2dc061e281637@google.com>
 <20240729-himbeeren-funknetz-96e62f9c7aee@brauner>
 <20240729132721.hxih6ehigadqf7wx@quack3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729132721.hxih6ehigadqf7wx@quack3>

On Mon, Jul 29, 2024 at 03:27:21PM +0200, Jan Kara wrote:
> Also as the "filesystem shutdown" is spreading across multiple filesystems,
> I'm playing with the idea that maybe we could lift a flag like this to VFS
> so that we can check it in VFS paths and abort some operations early. 

I've been thinking the same thing since I saw what CIFS was doing a
couple of days ago with shutdowns. It's basically just stopping all
new incoming modification operations if the flag is set. i.e. it's
just a check in each filesystem method, and I suspect that many
other filesystems that support shutdown do the same thing.

It looks like exactly the same implementation as CIFS is about to be
added to exfat - stop all the incoming methods and check in the
writeback method - so having a generic superblock flag and generic
checks before calling into filesystem methods would make it real
easy for all filesystems to have basic ->shutdown support for when
block devices go away suddenly.

I also think that we should be lifting *IOC_SHUTDOWN to the VFS -
the same ioctl is now implemented in 4-5 filesystems and they
largely do the same thing - just set a bit in the internal
filesystem superblock flags. Yes, filesystems like XFS and ext4 do
special stuff with journals, but the generic VFS implemenation could
call the filesystem ->shutdown method to do that....

> But
> so far I'm not convinced the gain is worth the need to iron out various
> subtle semantical differences of "shutdown" among filesystems.

I don't think we need to change how any filesystem behaves when it
is shut down. As long as filesystems follow at least the "no new
modifications when shutdown" behaviour, filesystems can implement
internal shutdown however they want...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

