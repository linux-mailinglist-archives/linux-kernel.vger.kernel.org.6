Return-Path: <linux-kernel+bounces-243788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ED2929A94
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 03:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F452281013
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 01:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67694C99;
	Mon,  8 Jul 2024 01:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="USP4+hE0"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A07D1C20
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 01:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720403105; cv=none; b=bCqoHZv82qlMrTg6R8Y6j9V6v1FLtfxOM5wU/pDUWxmgMSguC6AN3Ye2S5zTGmPtC0wM9DyitGsKMetrKoy9ceI0bwuNxuPuvZqgas0nh9OmfFu0EKst78gj0nz1ySb0Yc19CBcuYgGvRHK+KD2ZBQ90WYnoNAfGogBFY5/EkYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720403105; c=relaxed/simple;
	bh=UZQgAHNKa5GKT089OyX7WY3WhNFI3/kEqVrXrQKK1w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+nJ1VxLQkjzxXsjxDb1IgVJvnMRIfF/n/9STaKKAhTg87YvpCqFegXGeBoBFBvNeAD8dm5ZMqAKfMywIBHKaNxIfDcrqlFsSIGD+4+f7+Z+sTTw56sHaJvqsTcrvBqPHEDnH6MOsUlt5kJWfFIoQ3MbA4/OhcJKpjPDRW0ddAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=USP4+hE0; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70b1207bc22so1779921b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 18:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1720403103; x=1721007903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3i57RgqA9t2UmnGb1JGqu1JIFkgw1UoLxrFHvff2GJo=;
        b=USP4+hE08Qp3Uf/W4iAaR5K8XPr9wQjO4rIbQ0s1n8hgcEP290pnT8zM2/XGeFfMbr
         AvpaLVkB0/saLQ5c/QkJteCilzglkeEwTgK/MzoleYtakkRL5xaNdRfoh3cgaU1WGMus
         +6LroUsKCvbfgK63yczlKOVql469F+T10VMj+a60nWj+hEchMrNkPmt1vjoWmVscQuK4
         Y100N0rFmbheKCt3P4ISn3EKdVAIU9ZAkaBYPSm5uPrTlUQ3TqrwGctmkj3TJ3kqfq6W
         Z0P8vr1xHiHuCgFMeTg06bEStcqZ+1QEkAcmZXTzWuYz5gvHsLNaDQQ0+/ZstGhQB1Sj
         9ong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720403103; x=1721007903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3i57RgqA9t2UmnGb1JGqu1JIFkgw1UoLxrFHvff2GJo=;
        b=ZWO5aLpXz4iqpJOSbYA+7NO2uW8jKvUpPVeCw7UzH4LKentk5bL6+Lo/a/xjKTRi7Z
         SUe2WYBqalmqIa5DFIKPL6Hh0Vlzhi4Jqcks81E3BzSgAXQeFDC16MQ1cHlUl/YcFlOf
         ogEiQuTDTwVMNVKmEmy9CSnuAD+z16nXuTOXKFIlPUfxbiAsa/3IVJuoW2kx/oOkonMX
         DTjpvaMRCpD6mTF56GRBhsPi9CzgYdnu/CX+sO+SR1ATNQ24xxPJziTH3hlr+p8/yp2e
         L7YDErmLY57IEOvI6nPKlcB55V5v5Y1C5JQHZ6oTdP+iO8bDH/y2DFuI8lwOB3QMYo1R
         LIgA==
X-Forwarded-Encrypted: i=1; AJvYcCXCkfUbb+sOJDu5ZuxCS74i8JQHGKjIDoJTWgd5ywiP5z9Ls8veguznVdkvTM2VtXkWCBTvhvl7zC5ikbf5XF5/PXYEEaTyABDIk16d
X-Gm-Message-State: AOJu0Yz4Hw+m3qdfY3EBsPnLqIR7yqpGu7HONC08huilre2Vwc8mlAKI
	5J6Ma/sBlsqRYMB9fwgeKFZkaQ6Ytp7DF/R5dx3a2+X1g+e+JNI2xAidQ2E40b4=
X-Google-Smtp-Source: AGHT+IEJv9kHCkggoetZzgqGnqwTpewdJ29BzG0vnJ0e+zmY5ha/OAO47RZlGgsKOL9LkTiYT/X9yA==
X-Received: by 2002:a05:6a00:3c8c:b0:706:7943:b9aa with SMTP id d2e1a72fcca58-70b00a66a84mr15823169b3a.5.1720403102809;
        Sun, 07 Jul 2024 18:45:02 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70aee2bbf17sm8568418b3a.29.2024.07.07.18.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 18:45:02 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sQdR5-007zUz-2H;
	Mon, 08 Jul 2024 11:44:59 +1000
Date: Mon, 8 Jul 2024 11:44:59 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>, chandan.babu@oracle.com,
	djwong@kernel.org, dchinner@redhat.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	catherine.hoang@oracle.com, martin.petersen@oracle.com
Subject: Re: [PATCH v2 08/13] xfs: Do not free EOF blocks for forcealign
Message-ID: <ZotEmyoivd1CEAIS@dread.disaster.area>
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
 <20240705162450.3481169-9-john.g.garry@oracle.com>
 <20240706075609.GB15212@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706075609.GB15212@lst.de>

On Sat, Jul 06, 2024 at 09:56:09AM +0200, Christoph Hellwig wrote:
> On Fri, Jul 05, 2024 at 04:24:45PM +0000, John Garry wrote:
> > -	if (xfs_inode_has_bigrtalloc(ip))
> > +
> > +	/* Only try to free beyond the allocation unit that crosses EOF */
> > +	if (xfs_inode_has_forcealign(ip))
> > +		end_fsb = roundup_64(end_fsb, ip->i_extsize);
> > +	else if (xfs_inode_has_bigrtalloc(ip))
> >  		end_fsb = xfs_rtb_roundup_rtx(mp, end_fsb);
> 
> Shouldn't we have a common helper to align things the right way?

Yes, that's what I keep saying. The common way to do this is:

	align = xfs_inode_alloc_unitsize(ip);
	if (align > mp->m_blocksize)
		end_fsb = roundup_64(end_fsb, align);

Wrapping that into a helper might be appropriate, though we'd need
wrappers for aligning both the start (down) and end (up).

To make this work, the xfs_inode_alloc_unitsize() code needs to grow
a forcealign check. That overrides the RT rextsize value (force
align on RT should work the same as it does on data devs) and needs
to look like this:

	unsigned int		blocks = 1;

+	if (xfs_inode_has_forcealign(ip)
+		blocks = ip->i_extsize;
-	if (XFS_IS_REALTIME_INODE(ip))
+	else if (XFS_IS_REALTIME_INODE(ip))
                blocks = ip->i_mount->m_sb.sb_rextsize;

        return XFS_FSB_TO_B(ip->i_mount, blocks);

> But more importantly shouldn't this also cover hole punching if we
> really want force aligned boundaries?

Yes, that's what I keep saying. There is no difference in the
alignment behaviour needed for "xfs_inode_has_bigrtalloc" and
"xfs_inode_has_forcealign" except for the source of the allocation
alignment value.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

