Return-Path: <linux-kernel+bounces-403482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012AA9C3652
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 03:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6525281785
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 02:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6013242A87;
	Mon, 11 Nov 2024 02:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="2mPhRuqZ"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7AD3C3C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 02:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731290689; cv=none; b=E+UjnlQ2rpZ0y60E9Z5Iwwj7h5srgSwencvg2eK3ufgAykOaelTeJAN3C0Mn4rqE/bRTRa3BoczM4zAmpDh8uwhVznfA84zTdI3FDD0dtx+YlYA1S7waVIbj4wZG+/UPZpyzqIYothm3bVSFWufdzGsIfGaot6AxMs8l6gseHck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731290689; c=relaxed/simple;
	bh=Jb3OHC346rH3d7EBpYgOqmAuek/eWPJY9BU4l6/XHW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avdaHuZajTI96QD7Vtd4T4HnfYLH1k6inCOb9O4+/rheFrkNsOuFX4oh/2/s9c+9eg7wTO7WUPx/6GNTwgRwDduHEEtnW/KvFFmaeXV5c9fjul/WdzXk4PGxkexHoc6u8HwVgzxdD6/Q6CRrtptCEAVIfXHBct97WTDCs9na55o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=2mPhRuqZ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea7e2ff5ceso2757848a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 18:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1731290687; x=1731895487; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bBmwH7OKzbpHlkPpiA8Z1NL2wLrsRzA8Hd93fxN9JCU=;
        b=2mPhRuqZjxJrsTE2TylqR0KpNqNQQ5urGjdycAajD4kfngVYQXsDG4WHoPgaS2w+Kf
         ACd+ye6+vrNP20hGMkkCuSplGbemr3F0EsURkX2vdlphIfN3GnGgAGlO0VdmpA7TYrNf
         tt7+i8Y5MBOyPh4caoIbSJZhlYaIY3YP9mIDStk5sxxUs2669qOWM9DynGSD1aOGNhQh
         2wzvZdJxHaEC0UpEY49IUGS0uNUhGyOLpvcJdD3enxp0CBMfxyoGsw94r0/W5SRZjCiT
         WccFu5119+HCNYGAVWpfT+tr/evkQGWPoQVOG057xlUfQI6IvgX5btmD3YP0y2Maflzt
         J9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731290687; x=1731895487;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBmwH7OKzbpHlkPpiA8Z1NL2wLrsRzA8Hd93fxN9JCU=;
        b=bFIbRyxpY58QOU1r0t+PoCAVBHy/SX1X0/3DGGU7SOim9GuQwMiRQNTeJyfc0/J00b
         zNSHPe7F6sIar5qb3OM+PqkC52nimeyOE5rSMTUxzfMDJPc89okdPSBWsvWX8lxqKIp6
         oP5gcJB18/5FDJXydLFE0WyXaKmroGFDXrQkQqa8y2hIv7KxZZMc1uOYh9KQsNtOe/Uv
         uzDT4/m6541+7RGcTFCSM+JpNLGAQBgo5xVa8HvNM6lKKBX4/L/fiGOtk15B5HLBmiDg
         nMD2ZQPYccfMNcqQvk82y1fH6FXHywxLWUyg/cNawOLCoHoe3ZgsAozk4vwu2WsM/ku3
         VQkg==
X-Forwarded-Encrypted: i=1; AJvYcCUz64inAcQpFPvZU014S+AIIQee74WnnkzQg+cAAknkucG3BYDYn/ik5Dm8YaSM8MIktTMw3dSwcOoC+qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDktq3IMBsDPAOoINg6AJOPXHZttteveB66y6FqLsLpNStver9
	QAbq7AVDMkPyFI+YciWR6+YN8Cv97ke+r4lghehAMWkM+njAS0FFzzMbOjVxH5Y=
X-Google-Smtp-Source: AGHT+IHMqG1jSg9i7/WvMFncpUCAP5fTwypEt/VZkEeBBPQjMdwuXS7Om2tEUS7oafdPJ3oWLDXr9A==
X-Received: by 2002:a17:90a:e7cb:b0:2e0:853a:af47 with SMTP id 98e67ed59e1d1-2e9b1748068mr15826910a91.33.1731290687269;
        Sun, 10 Nov 2024 18:04:47 -0800 (PST)
Received: from dread.disaster.area (pa49-186-86-168.pa.vic.optusnet.com.au. [49.186.86.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177ddd646sm65829975ad.62.2024.11.10.18.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 18:04:46 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1tAJnH-00CzKY-2n;
	Mon, 11 Nov 2024 13:04:43 +1100
Date: Mon, 11 Nov 2024 13:04:43 +1100
From: Dave Chinner <david@fromorbit.com>
To: Stephen Zhang <starzhangzsd@gmail.com>
Cc: djwong@kernel.org, dchinner@redhat.com, leo.lilong@huawei.com,
	wozizhi@huawei.com, osandov@fb.com, xiang@kernel.org,
	zhangjiachen.jaycee@bytedance.com, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
Subject: Re: [PATCH 0/5] *** Introduce new space allocation algorithm ***
Message-ID: <ZzFmOzld1P9ReIiA@dread.disaster.area>
References: <20241104014439.3786609-1-zhangshida@kylinos.cn>
 <ZyhAOEkrjZzOQ4kJ@dread.disaster.area>
 <CANubcdVbimowVMdoH+Tzk6AZuU7miwf4PrvTv2Dh0R+eSuJ1CQ@mail.gmail.com>
 <Zyi683yYTcnKz+Y7@dread.disaster.area>
 <CANubcdX3zJ_uVk3rJM5t0ivzCgWacSj6ZHX+pDvzf3XOeonFQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANubcdX3zJ_uVk3rJM5t0ivzCgWacSj6ZHX+pDvzf3XOeonFQw@mail.gmail.com>

On Fri, Nov 08, 2024 at 09:34:17AM +0800, Stephen Zhang wrote:
> Dave Chinner <david@fromorbit.com> 于2024年11月4日周一 20:15写道：
> > On Mon, Nov 04, 2024 at 05:25:38PM +0800, Stephen Zhang wrote:
> > > Dave Chinner <david@fromorbit.com> 于2024年11月4日周一 11:32写道：
> > > > On Mon, Nov 04, 2024 at 09:44:34AM +0800, zhangshida wrote:

[snip unnecessary stereotyping, accusations and repeated information]

> > AFAICT, this "reserve AG space for inodes" behaviour that you are
> > trying to acheive is effectively what the inode32 allocator already
> > implements. By forcing inode allocation into the AGs below 1TB and
> > preventing data from being allocated in those AGs until allocation
> > in all the AGs above start failing, it effectively provides the same
> > functionality but without the constraints of a global first fit
> > allocation policy.
> >
> > We can do this with any AG by setting it up to prefer metadata,
> > but given we already have the inode32 allocator we can run some
> > tests to see if setting the metadata-preferred flag makes the
> > existing allocation policies do what is needed.
> >
> > That is, mkfs a new 2TB filesystem with the same 344AG geometry as
> > above, mount it with -o inode32 and run the workload that fragments
> > all the free space. What we should see is that AGs in the upper TB
> > of the filesystem should fill almost to full before any significant
> > amount of allocation occurs in the AGs in the first TB of space.

Have you performed this experiment yet?

I did not ask it idly, and I certainly did not ask it with the intent
that we might implement inode32 with AFs. It is fundamentally
impossible to implement inode32 with the proposed AF feature.

The inode32 policy -requires- top down data fill so that AG 0 is the
*last to fill* with user data. The AF first-fit proposal guarantees
bottom up fill where AG 0 is the *first to fill* with user data.

For example:

> So for the inode32 logarithm:
> 1. I need to specify a preferred ag, like ag 0:
> |----------------------------
> | ag 0 | ag 1 | ag 2 | ag 3 |
> +----------------------------
> 2. Someday space will be used up to 100%, Then we have to growfs to ag 7:
> +------+------+------+------+------+------+------+------+
> | full | full | full | full | ag 4 | ag 5 | ag 6 | ag 7 |
> +------+------+------+------+------+------+------+------+
> 3. specify another ag for inodes again.
> 4. repeat 1-3.

Lets's assume that AGs are 512GB each and so AGs 0 and 1 fill the
entire lower 1TB of the filesystem. Hence if we get to all AGs full
the entire inode32 inode allocation space is full.

Even if we grow the filesystem at this point, we still *cannot*
allocate more inodes in the inode32 space. That space (AGs 0-1) is
full even after the growfs.  Hence we will still give ENOSPC, and
that is -correct behaviour- because the inode32 policy requires this
behaviour.

IOWs, growfs and changing the AF bounds cannot fix ENOSPC on inode32
when the inode space is exhausted. Only physically moving data out
of the lower AGs can fix that problem...

> for the AF logarithm:
>     mount -o af1=1 $dev $mnt
> and we are done.
> |<-----+ af 0 +----->|<af 1>|
> |----------------------------
> | ag 0 | ag 1 | ag 2 | ag 3 |
> +----------------------------
> because the af is a relative number to ag_count, so when growfs, it will
> become:
> |<-----+ af 0 +--------------------------------->|<af 1>|
> +------+------+------+------+------+------+------+------+
> | full | full | full | full | ag 4 | ag 5 | ag 6 | ag 7 |
> +------+------+------+------+------+------+------+------+
> So just set it once, and run forever.

That is actually the general solution to the original problem being
reported. I realised this about half way through reading your
original proposal. This is why I pointed out inode32 and the
preferred metadata mechanism in the AG allocator policies.

That is, a general solution should only require the highest AG
to be marked as metadata preferred. Then -all- data allocation will
then skip over the highest AG until there is no space left in any of
the lower AGs. This behaviour will be enforced by the existing AG
iteration allocation algorithms without any change being needed.

Then when we grow the fs, we set the new highest AG to be metadata
preferred, and that space will now be reserved for inodes until all
other space is consumed.

Do you now understand why I asked you to test whether the inode32
mount option kept the data out of the lower AGs until the higher AGs
were completely filled? It's because I wanted confirmation that the
metadata preferred flag would do what we need to implement a
general solution for the problematic workload.

Remeber: free space fragmentation can happen for many reasons - this
mysql thing is just the latest one discovered.  The best solution is
having general mechanisms in the filesystem that automatically
mitigate the effects of free space fragmentation on inode
allocation. The worst solution is requiring users to tweak knobs...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

