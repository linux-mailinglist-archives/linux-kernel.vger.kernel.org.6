Return-Path: <linux-kernel+bounces-282055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D556094DF37
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 01:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F97CB21538
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 23:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952F2143733;
	Sat, 10 Aug 2024 23:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="nU8eYyww"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F7A3D393
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 23:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723331509; cv=none; b=eYN1gt7Mq7dew7t/nFe2/7jq0uKllFSj4zW32tUYUAH7N7NFKa4lIUpTdDgc2XlbkeKOd8REc2qUgPxxYEyqzxEyusvUyg2uowEt0BwfGYfAGFgowOo367XWB8ZhIYyQ4exAby/OxRDRR8h/peU3uJZ/4PtzyMIChR4bROXaWlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723331509; c=relaxed/simple;
	bh=9xfUGmBjc3QKtzh4ArP+RVIJld4OxL/M0eYg7QNNx9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjMNPhzv0ZPZ1XOp7LchgSQcfar0qxBJpvCy5EEHMkLnOwIXTGP4oqlIT/AUcLjY85a5JqFhUr0HFDZn8kSa0ZZ8mF8QIigtCdXBBdldl55aF0MgkyIyffyORNsGqfASRQT1jBzJiqVzHWNNDXeoXssh9cyXdZWEIuOH8SXI3ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=nU8eYyww; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7c1f480593bso2198311a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 16:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1723331507; x=1723936307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d4MxCNexYOCVjRbJ40YJ9wUSBr5udCAoAHHxr9zl7Vs=;
        b=nU8eYywwLB7nrGpU0124gVCQmycfg1RoKg09Pfu+QoIg3Jv8Zbtyzww0dB7RSjH86Y
         0e19oaak7jv0xf7fNb0tGAFbzWIlhkFSt7FdNqRU+yF3De1Xox8K4Bwv58WZJ2bOQvgj
         JnkMWt+eYGgc/4F6mxsVX03jWzz/dOog6ASNJ/ZQmTCP49Dbq9rdrHfSwRh4ySSkg+fK
         q7EWNgcSA8DPkJVm9jO+6zBHDYnsO6QuB3oFF7nmKrSbLdzY3JJDRmCNh8Wwef4yDCFr
         wdEr2BSxJzI9vDaDD53f3zoOvwLzMNkwwG1Zfr5ZKOrri6S/qCdeyMoSK7Rmce+RT4sx
         iRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723331507; x=1723936307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4MxCNexYOCVjRbJ40YJ9wUSBr5udCAoAHHxr9zl7Vs=;
        b=smmheaCuvUCVj3GJj/Hnh6ujM0UGuPpr4mVd9tUnkfS+9OPPJVXS7M4+2Bum31sW+S
         s5VuXSsAVdTi+KggQduv2NcsbY4i+zK+OE2cNcqxtECf9mJ/minet/fvi8dG5VHoTUIT
         rsUvLdifMJDsVTv974pQa2x3Zh+YIKlR1l4WPybR7beKEFuGXh8cwjhk+jexuwB5MiCh
         hm03MEW6zQwVw7d38/1JlpNgR/Bs5VnqSiCk8VyLMTWtvPMFpYya4wYrPKs/FdsFWuT4
         7zpe0jUVgJ8PCzb5tHLmmqFyXNpHew+HL7DQCqVfWR+tbL9b66990GuoDja6CXFtasuo
         67JA==
X-Forwarded-Encrypted: i=1; AJvYcCUqHO2EwAixp3UQfR5giIBniL7RPNFT+LgbJNFUSN/cs7ZU5/m/vKuW2An6u+7EHPWhjlACzjkXGEjBZOShoRgQyPnI7+ME3oGnneCP
X-Gm-Message-State: AOJu0YyeD51RcsXIM/6MLKn6rqkXKjOPgittxUGeKYbg2x8hOAPgbg6p
	LMbRc7n1YzPOb7ylvX0cn/nsGAoDfBmnJmQOuP1l+zUgRwMx5XfLjRw+4hDdZYo=
X-Google-Smtp-Source: AGHT+IEm4kqOqagv2Hy2hD1EngadT0t7iBCu58H6z3WdRH+FS0/7KwHKaWiBooqhX6ZKGCBcTf0Vcw==
X-Received: by 2002:a17:902:db12:b0:1fb:dedd:aa65 with SMTP id d9443c01a7336-200ae5f5430mr52717555ad.42.1723331507445;
        Sat, 10 Aug 2024 16:11:47 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb8f7589sm16027015ad.68.2024.08.10.16.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 16:11:46 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1scvFQ-00Cbcc-0T;
	Sun, 11 Aug 2024 09:11:44 +1000
Date: Sun, 11 Aug 2024 09:11:44 +1000
From: Dave Chinner <david@fromorbit.com>
To: Anders Blomdell <anders.blomdell@gmail.com>
Cc: linux-xfs@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: XFS mount timeout in linux-6.9.11
Message-ID: <ZrfzsIcTX1Qi+IUi@dread.disaster.area>
References: <71864473-f0f7-41c3-95f2-c78f6edcfab9@gmail.com>
 <ZraeRdPmGXpbRM7V@dread.disaster.area>
 <252d91e2-282e-4af4-b99b-3b8147d98bc3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <252d91e2-282e-4af4-b99b-3b8147d98bc3@gmail.com>

On Sat, Aug 10, 2024 at 10:29:38AM +0200, Anders Blomdell wrote:
> 
> 
> On 2024-08-10 00:55, Dave Chinner wrote:
> > On Fri, Aug 09, 2024 at 07:08:41PM +0200, Anders Blomdell wrote:
> > > With a filesystem that contains a very large amount of hardlinks
> > > the time to mount the filesystem skyrockets to around 15 minutes
> > > on 6.9.11-200.fc40.x86_64 as compared to around 1 second on
> > > 6.8.10-300.fc40.x86_64,
> > 
> > That sounds like the filesystem is not being cleanly unmounted on
> > 6.9.11-200.fc40.x86_64 and so is having to run log recovery on the
> > next mount and so is recovering lots of hardlink operations that
> > weren't written back at unmount.
> > 
> > Hence this smells like an unmount or OS shutdown process issue, not
> > a mount issue. e.g. if something in the shutdown scripts hangs,
> > systemd may time out the shutdown and power off/reboot the machine
> > wihtout completing the full shutdown process. The result of this is
> > the filesystem has to perform recovery on the next mount and so you
> > see a long mount time because of some other unrelated issue.
> > 
> > What is the dmesg output for the mount operations? That will tell us
> > if journal recovery is the difference for certain.  Have you also
> > checked to see what is happening in the shutdown/unmount process
> > before the long mount times occur?
> echo $(uname -r) $(date +%H:%M:%S) > /dev/kmsg
> mount /dev/vg1/test /test
> echo $(uname -r) $(date +%H:%M:%S) > /dev/kmsg
> umount /test
> echo $(uname -r) $(date +%H:%M:%S) > /dev/kmsg
> mount /dev/vg1/test /test
> echo $(uname -r) $(date +%H:%M:%S) > /dev/kmsg
> 
> [55581.470484] 6.8.0-rc4-00129-g14dd46cf31f4 09:17:20
> [55581.492733] XFS (dm-7): Mounting V5 Filesystem e2159bbc-18fb-4d4b-a6c5-14c97b8e5380
> [56048.292804] XFS (dm-7): Ending clean mount
> [56516.433008] 6.8.0-rc4-00129-g14dd46cf31f4 09:32:55

So it took ~450s to determine that the mount was clean, then another
450s to return to userspace?

> [56516.434695] XFS (dm-7): Unmounting Filesystem e2159bbc-18fb-4d4b-a6c5-14c97b8e5380
> [56516.925145] 6.8.0-rc4-00129-g14dd46cf31f4 09:32:56
> [56517.039873] XFS (dm-7): Mounting V5 Filesystem e2159bbc-18fb-4d4b-a6c5-14c97b8e5380
> [56986.017144] XFS (dm-7): Ending clean mount
> [57454.876371] 6.8.0-rc4-00129-g14dd46cf31f4 09:48:34

Same again.

Can you post the 'xfs_info /mnt/pt' for that filesystem?

> And rebooting to the kernel before the offending commit:
> 
> [   60.177951] 6.8.0-rc4-00128-g8541a7d9da2d 10:23:00
> [   61.009283] SGI XFS with ACLs, security attributes, realtime, scrub, quota, no debug enabled
> [   61.017422] XFS (dm-7): Mounting V5 Filesystem e2159bbc-18fb-4d4b-a6c5-14c97b8e5380
> [   61.351100] XFS (dm-7): Ending clean mount
> [   61.366359] 6.8.0-rc4-00128-g8541a7d9da2d 10:23:01
> [   61.367673] XFS (dm-7): Unmounting Filesystem e2159bbc-18fb-4d4b-a6c5-14c97b8e5380
> [   61.444552] 6.8.0-rc4-00128-g8541a7d9da2d 10:23:01
> [   61.459358] XFS (dm-7): Mounting V5 Filesystem e2159bbc-18fb-4d4b-a6c5-14c97b8e5380
> [   61.513938] XFS (dm-7): Ending clean mount
> [   61.524056] 6.8.0-rc4-00128-g8541a7d9da2d 10:23:01

Yeah, that's what I'd expect to see.

But, hold on, the kernel version you are testing is apparently is in
the middle of 6.8-rc4. This commit wasn't merged until 6.9-rc1 and
there were no XFS changes merged in the between 6.8-rc3 and 6.8-rc6.
So as the bisect is walking back in time through the XFS commits,
the base kernel is also changing. Hence there's a lot more change
in the kernel being tested by each bisect step than just the XFS
commits, right?

This smells like a bisect jumping randomly backwards in time as it
lands inside merges rather than bisecting the order in which commits
were merged into the main tree. Can you post the full bisect log?

-Dave.

-- 
Dave Chinner
david@fromorbit.com

