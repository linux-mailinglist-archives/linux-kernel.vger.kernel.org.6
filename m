Return-Path: <linux-kernel+bounces-566637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D54CA67AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 897FD4217AC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032A1213E6B;
	Tue, 18 Mar 2025 17:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PIqd+iJV"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF97220F094
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318296; cv=none; b=TyZgZLXjin+CTDrCh6s20QCRsYgCLZp4z8F7W4PJ/ykvE7zvC3mmjbWwET37JZmveJMQS4rKz61H8JomLmL3D6k0eBf4ojVNflj9L7ZTwT1QDYIuAKT1Qw06cRsj8ErmLkSp11k9Z8D8bFhCW0EQbOtEV/9dh+h60SLYlkww/eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318296; c=relaxed/simple;
	bh=QEWLM3try8BFOfb0hCqCyn4r6xpFo/2iqPmnsc43e1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEO6Wg/6EmsBZC9f2p6UZSWOIUsW/f6LekyFy3SoLOwA/gKyjZONLbVjCsGNzZxDL0qCqTyFamYpyRV+MFB9dTGjnX+sbrt+kOEpxjYa7OircYeOy0mM0Q9b+qOnufm7HXCAh01tl8jgNtFBgHWAC/HveYsugoZbE2L/KRNLfNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PIqd+iJV; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8f254b875so53879576d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742318292; x=1742923092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xV86r/eZWjKW7XqjYV07ukmPGBQZRx/NYw7V51LYBuk=;
        b=PIqd+iJVrwdQaS0PoXCnlJkF6sIGRXZPoGeYdR7Dt5SMnYnfrMvMXYk6CZ5mWXhRBl
         1YSz1DBp3WwROu+HLQNBDLvrKx5myiMYRkAy+AmPi2kKb4r3E6q5/lKZRsuc0bVgAt1s
         9PIDeV3bA5bdUJs/3xkH32AYJ0+TjcvRY+FA0pl+6KC7adWikPXtqJyX3DYyO7bQksSc
         HEiY63fcbhm9UBJ4+06uc89alPQOT6qTqpSbu2FbSdriGsPmvgWSF4LTBOak/n0ImLkO
         +ksNw8mqVe+mqgrW1//0A4Y6mCdAOVP8dVLDmamq3E69bDUgKJbsfIXDU5GcmQy9xy6D
         Houg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742318292; x=1742923092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xV86r/eZWjKW7XqjYV07ukmPGBQZRx/NYw7V51LYBuk=;
        b=ptn7rNPr0Iehhx9CRnRzjcI7o8pNeewl3cTYpocOR+zfFa1GVzzFgxsSvIGwM0adis
         1FuW9P/jHSPkLHxOKRsIwuALa+m8PbztJ/vA/yk3L2l73ZzCV4gZX/Dksq7NwO33CSjO
         frQKxtsOfotpxc0GeWVE2Vy6AM7Ri/GOX1secxbGFmOhvvYVZA91aZF6unkzI7fzQGyQ
         ZF6H8GGximu2qYaZPlqgl7jm+fPX4QGypgM1KGCB2F/7FCQ+E0NbJxlDi7LMDsTSq7wg
         qrNfuwEEL8ulyoB4JhMzcCZ1LhZjxlyR+dZS8PZo26j1B3j3pPk0sUZpFg0WyLJIiQTm
         uUpw==
X-Forwarded-Encrypted: i=1; AJvYcCV8JmhLnh379KhmqTU32lVtrtAUgByneUVobXPtWOWivLpeDA+0DVFiTpUW6yzh7zR/FgrJGLbCb9ZJH2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YziEfK2VOh1iuHqCEN9ImtQXHZz0D7Ve5/WrCA/kMhk26WgryW6
	N5rxwffXl6fucfE4Re/z40X8s258m1MuP+/uGJj31edpQSr1L5q1NfYI3g5g3FASBmLhrXbDPFH
	g
X-Gm-Gg: ASbGncv5USp6V7Q7RegSlNqrKLhOFfHVfecQGK9U0QwI8v6sh1nU1WttsvjCw43UmXS
	BshQliubsLvVSaKO6OqV6N/YYA7MlSFefU2TLkvfNraw94pfStaI6LG1Fmk4PW6EvKIrzwVC+cJ
	bf7vwo8XMKjbNQW/nFRPFsAr90oShohAbuhV1NQf0iSEeQDJi7FLYHE/j0nbCW6gWYA7NaYMQAR
	CFMdrayWxuuNtAtIhTWyBQuzFXVn+9leI+cGN0/O1A+TdHxKFwn1SxAq3IRvZ5LFlQSvMQVpHi4
	BdYn3elcveSKRFEYfDdSyDl5aiWiBVtMPuvfa8W5MrReTtunZJXAkgqr0FaufX5l5XJU3tXCicn
	8lMYKKj+2+shMXYG45w==
X-Google-Smtp-Source: AGHT+IFU/ddYVAuMMenO7VlAxPQQ9dcNFAQmMEDqLtugFL1HEP8Vt/lqWihixaJ7+pL+zIsYy+bfcw==
X-Received: by 2002:a05:6214:623:b0:6ea:d046:bcc9 with SMTP id 6a1803df08f44-6eb1b93f807mr49795816d6.40.1742318292591;
        Tue, 18 Mar 2025 10:18:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade209beesm69900566d6.10.2025.03.18.10.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 10:18:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tuaZv-00000000O4o-1xAe;
	Tue, 18 Mar 2025 14:18:11 -0300
Date: Tue, 18 Mar 2025 14:18:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: [PATCH] iommufd: Fix vEVENTQ kdoc
Message-ID: <20250318171811.GB10600@ziepe.ca>
References: <20250318163022.709490-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318163022.709490-1-nicolinc@nvidia.com>

On Tue, Mar 18, 2025 at 09:30:22AM -0700, Nicolin Chen wrote:
> Fix the following warnings in veventq kdoc:
> 
> include/uapi/linux/iommufd.h:1024: warning: Enum value 'IOMMU_VEVENTQ_FLAG_LOST_EVENTS' not described in enum 'iommu_veventq_flag'
> include/uapi/linux/iommufd.h:1024: warning: Excess enum value 'IOMMU_VEVENTQ_FLAG_OVERFLOW' description in 'iommu_veventq_flag'
> include/uapi/linux/iommufd.h:1120: warning: Function parameter or struct member 'viommu_id' not described in 'iommu_veventq_alloc'
> include/uapi/linux/iommufd.h:1120: warning: Excess struct member 'viommu' description in 'iommu_veventq_alloc'
> 
> Fixes: 50c842dd6cd3 ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-next/20250318214534.5476f9ed@canb.auug.org.au/
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/uapi/linux/iommufd.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, I just squashed it in

Jason

