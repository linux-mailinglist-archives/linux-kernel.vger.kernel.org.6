Return-Path: <linux-kernel+bounces-363008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E97799BCAA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 00:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E37F1B21173
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 22:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FEC14D6ED;
	Sun, 13 Oct 2024 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="kA5y8k3R"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA93C149C57
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 22:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728859828; cv=none; b=GWit9X6TE0ZfyZwnbL3k9XlMS1KYvd+Ar6MaxW/XGZ9jjCEmdwSpqbNTd95pyIqR3qR1R4ksc5k/uFfTWwxQZb8nL5XN8A608R7e6iurhTxZxm51gP7C66ktEwD3ALvPH+nGT8aVDRaZsXSPuZ2TIYQLFCpovZ3ta+3YBjpFUVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728859828; c=relaxed/simple;
	bh=uK2bGqq2ZoyiB4N6oR+TwlQNMug08PNtolCetpfX2YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwceWWAsTt/TPO1exWCyVKJa1/izUpGJyD9Pw7rgCLep1gkANIeFgxSrmkqrqWwR0InKME9n/k7PqiKaOnWPDPHH8DA5zNMSrQExRxvPOwyIgqL2pyeVCIA7QdI+CL/H7MJRJgzRaZMymrNQfT+aOunmNT8H/CTdqKE5em6Bc6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=kA5y8k3R; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c803787abso23965175ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 15:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1728859826; x=1729464626; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b0+lmUyHCI6kEhaZF5ZEyy9HziAvatjtgIBFzvidxv4=;
        b=kA5y8k3RaR0uXJCt+zhJtK8+1L/a1OwI48vXnQTZZH1WNu0dlPVg18D0PiIEKsZeff
         DyOWrDcuPnYCJ26j22H9ix0/LCTcgujo2nFLkKSceK30z59Mb7V0n+0g2VVGDR1X0v5y
         GFSHlTCk4tITAKHANiudFDrAuDmmtldRL5AxwF1UKK7rjPmbtqqOB1rKmQrRHl0r2VB3
         qVY6zQAcLog+Ch9Iv9JdrtNciULe17DBr58Dpu34Wd477H0Yelb4aPiIrm588DG0DztN
         n/Vsxtnj5WSTsMMv9t/oPw1cuU0+wPAH5CyNvh938zKPpar+YxYLGJcbCPQdnadJL8fW
         qPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728859826; x=1729464626;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0+lmUyHCI6kEhaZF5ZEyy9HziAvatjtgIBFzvidxv4=;
        b=E4Hmh07JkhR/U3+TdKLRqQRNBzZkgfKLe4Eee4KYsDwpcCAHMnScE8+bQdzpNN5LsL
         0+ULM2/DHBRGoCb8r4dou67ecO1OgOLaCJa29tjdtacxPgeazmXhWqdULUe5JJPC1sA4
         9dYehiiBI+eVropUWcpGl8/8ERZyg4q79U7ps0MjOxTImV/nKTx8rBYD0QuicR77yRoB
         eZfadi8948OZpP1ERf5hlMdrIMwMohY3jOuyGVRZMRs5DipL9e9LKZLL/1jS0c7cVQG7
         18VO9+fAizy+lIh053VNZWPs+2Ww/NUxmOVDMZKZKSS14NWONpJ/Kb3d8S8EY2u8Mp76
         K8Dw==
X-Forwarded-Encrypted: i=1; AJvYcCW3ZS+QJIioPcElyEe2eM6d+qyY4tLmWZZ3lgQINmiw9picAKF4qpUlQWkAsG5FInB3DsnJ09Wj5n8VegY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIN5vyNveu1whXu4Z5uGr5R/1hC89m17lpvpEJ9WZUikADGfWS
	wOWFYKKKjvTZ8DfU9tGJR5CkZegBqMUdJpJUY8++hy/ppNRKxzchzOB8AWVmQvs=
X-Google-Smtp-Source: AGHT+IEUFVR/Ok4sTNqJW2BL8VzDGb807GfXVKHVOwc05thRlrRgPIHm9zdaG/KUIZk2lH9rUSBwyg==
X-Received: by 2002:a17:902:d2cf:b0:20a:fd4e:fef6 with SMTP id d9443c01a7336-20c8045d5ecmr197916145ad.8.1728859825849;
        Sun, 13 Oct 2024 15:50:25 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-209-182.pa.vic.optusnet.com.au. [49.186.209.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0e747fsm54625215ad.143.2024.10.13.15.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 15:50:25 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1t07Pp-000OWw-0l;
	Mon, 14 Oct 2024 09:50:21 +1100
Date: Mon, 14 Oct 2024 09:50:21 +1100
From: Dave Chinner <david@fromorbit.com>
To: Chi Zhiling <chizhiling@163.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	chizhiling <chizhiling@kylinos.cn>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] xfs_logprint: Fix super block buffer interpretation issue
Message-ID: <ZwxOrVCJ/+2GoGjg@dread.disaster.area>
References: <20241011030810.1083636-1-chizhiling@163.com>
 <20241011032415.GC21877@frogsfrogsfrogs>
 <97501a36-d001-b3fa-5b57-8672bc7d71da@163.com>
 <ZwrzxggtS96n72Bm@dread.disaster.area>
 <e0ae8eb7-360a-40c4-8c84-dd439d7161fd@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0ae8eb7-360a-40c4-8c84-dd439d7161fd@163.com>

On Sun, Oct 13, 2024 at 12:00:22PM +0800, Chi Zhiling wrote:
> On 2024/10/13 06:10, Dave Chinner wrote:
> > On Fri, Oct 11, 2024 at 11:54:08AM +0800, Chi Zhiling wrote:
> > > On 2024/10/11 11:24, Darrick J. Wong wrote:
> > > > On Fri, Oct 11, 2024 at 11:08:10AM +0800, Chi Zhiling wrote:
> > > > > From: chizhiling<chizhiling@kylinos.cn>
> > > > > 
> > > > > When using xfs_logprint to interpret the buffer of the super block, the
> > > > > icount will always be 6360863066640355328 (0x5846534200001000). This is
> > > > > because the offset of icount is incorrect, causing xfs_logprint to
> > > > > misinterpret the MAGIC number as icount.
> > > > > This patch fixes the offset value of the SB counters in xfs_logprint.
> > > > > 
> > > > > Before this patch:
> > > > > icount: 6360863066640355328  ifree: 5242880  fdblks: 0  frext: 0
> > > > > 
> > > > > After this patch:
> > > > > icount: 10240  ifree: 4906  fdblks: 37  frext: 0
> > > > > 
> > > > > Signed-off-by: chizhiling<chizhiling@kylinos.cn>
> > > > > ---
> > > > >    logprint/log_misc.c | 8 ++++----
> > > > >    1 file changed, 4 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/logprint/log_misc.c b/logprint/log_misc.c
> > > > > index 8e86ac34..21da5b8b 100644
> > > > > --- a/logprint/log_misc.c
> > > > > +++ b/logprint/log_misc.c
> > > > > @@ -288,13 +288,13 @@ xlog_print_trans_buffer(char **ptr, int len, int *i, int num_ops)
> > > > >    			/*
> > > > >    			 * memmove because *ptr may not be 8-byte aligned
> >                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> > This is important. I'll come back to it.
> > 
> > > > >    			 */
> > > > > -			memmove(&a, *ptr, sizeof(__be64));
> > > > > -			memmove(&b, *ptr+8, sizeof(__be64));
> > > > How did this ever work??  This even looks wrong in "Release_1.0.0".
> > > > 
> > > Yes, I was surprised when I find this issue
> > I"ve never cared about these values when doing diagnosis because
> > lazy-count means they aren't guaranteed to be correct except at
> > unmount. At which point, the correct values are generally found
> > in the superblock. IOWs, the values are largely meaningless whether
> > they are correct or not, so nobody has really cared enough about
> > this to bother fixing it...
> 
> Because I got a log which shows that the fdblocks was (-8),   it caused
> the filesystem to fail mounting again. 'SB summary counter sanity check failed'

What kernel? Because AFAIK, that was fixed in commit 58f880711f2b
("xfs: make sure sb_fdblocks is non-negative") in 6.10...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

