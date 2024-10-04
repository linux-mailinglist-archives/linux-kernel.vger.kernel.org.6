Return-Path: <linux-kernel+bounces-351523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 256C299127C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 00:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA6A1F23ECF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CA9145B1B;
	Fri,  4 Oct 2024 22:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="iNcLVTFV"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3AD13A416
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728081996; cv=none; b=GAa0vG5m9jTqN7i7tdDy6iawU8peJXb+VS80OtIbuNGzMIdoHyz8u1e1RnjQpygeEawhubAOOFqZfFdfNLQEJHe0dWfA4VVsUe2AEqbrJDzc1W5VOy11aERdW059JTnwxBqTd5FdSG6p0+n4XhfRh9UtXR/ppDXlsEZZMm435PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728081996; c=relaxed/simple;
	bh=KGDBW+VzICTuok5HmgYwSc6Q3qKxP7NeiQvuKpfuJj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBzvbxb4F0IUymrlhlbnxVBU6EyDyhYoG2oKhrFjgEm7De7Xh3OE1nqsKmQJgXzx7yhJrzmMgR58KYWaXDfOrH06Ag3u/xDFXDEKATAtItU+bkkbRLrwfBoGDPLTue1XtarzrC6M+OfJ7U3ecT1YF1j9WwKKxkJp1MlgJqbF1yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=iNcLVTFV; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-718d704704aso2370398b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 15:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1728081994; x=1728686794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mfPYWu0zoQuwrp1D6VKi5ike7t96l9DXCZP1d6TBs20=;
        b=iNcLVTFVEhfPpmJZiXGLhSTr6HJNAURf1G6aOa5qkkUggoVAu42F5VeraclLkx2sBg
         oA8T/zD7Gp2PcY/p84c2darNZGHnCFo5KXMA7YkLdVot4SNYl3fpkJowKl84piJAUFga
         NJTfVB3Tz94sSGh3EN2J1sxvjdzqjKQVBYVWjk5+h1mq9HHWpaf384ZrOujuD1X0+oOQ
         xx88+wtYtElrZ/UzuCy7N7j4EFVtmlLp2ZrQ9DDMXt1mcijzMAf3uqDQ0PMMpI60yzt4
         awXGt2+DRMuPZlkeS8pE44Tk5D/IXVaTcsXfF2lK1seORExX5N65iK6xyaesurDnYQH1
         etYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728081994; x=1728686794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfPYWu0zoQuwrp1D6VKi5ike7t96l9DXCZP1d6TBs20=;
        b=nlmlN1ZugvAX/4vCIXV31Zivf3Seuwj0xnlDihwgromRL8mDPvkVTqicsDoz7AbxQD
         YrxCSECUImqVBFriV9hr13ZeDOZAL5v25ELkhxvonY4chd44gMOH4lKY9+VM6Tg8uBxm
         lmEhHxEIc9mJdd4KZH+LPsUiWwibmrBymqdfumHmLwPFRM8EOq5YGrEP3qS38qT6bbee
         2TUnRbpcCG2gXfpbFUw2ELwQ5CQKQwpUaqxRKZUeFGpDXsQaVtGzimeGDVvr1sbMcIRp
         K35j6U9gHe3yZNCMLrkbzIea0LgEWpfNB6xmUnisqsQaUhFgZ3O8McSt/C6s2mCDToqO
         hVfA==
X-Gm-Message-State: AOJu0YzJhMLBzbG7aqz9Y03QS8Xkr3prUXhXrbJRstEk/02qE+H3bFxX
	G3G8drTYs3GvdeNRsYW8n12nyL1Zm+T9EplZ/wRTXNzOCxIpwi+/NLRai7uD5kg=
X-Google-Smtp-Source: AGHT+IHH6D+mR+kPDuhUqfvHx3wFJkWq0SHSNLLQousrnyeEieGnCefv4dnbkilmvTDOj0X5j+GnTQ==
X-Received: by 2002:a05:6a00:23d5:b0:718:dc55:728a with SMTP id d2e1a72fcca58-71de23b5e95mr6803811b3a.8.1728081994552;
        Fri, 04 Oct 2024 15:46:34 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d47863sm384166b3a.119.2024.10.04.15.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 15:46:34 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1swr4A-00E116-26;
	Sat, 05 Oct 2024 08:46:30 +1000
Date: Sat, 5 Oct 2024 08:46:30 +1000
From: Dave Chinner <david@fromorbit.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Hannes Reinecke <hare@suse.de>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.11 14/76] iomap: fix iomap_dio_zero() for fs bs
 > system page size
Message-ID: <ZwBwRqGRwoDd2eT4@dread.disaster.area>
References: <20241004181828.3669209-1-sashal@kernel.org>
 <20241004181828.3669209-14-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004181828.3669209-14-sashal@kernel.org>

On Fri, Oct 04, 2024 at 02:16:31PM -0400, Sasha Levin wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> [ Upstream commit 10553a91652d995274da63fc317470f703765081 ]
> 
> iomap_dio_zero() will pad a fs block with zeroes if the direct IO size
> < fs block size. iomap_dio_zero() has an implicit assumption that fs block
> size < page_size. This is true for most filesystems at the moment.
> 
> If the block size > page size, this will send the contents of the page
> next to zero page(as len > PAGE_SIZE) to the underlying block device,
> causing FS corruption.
> 
> iomap is a generic infrastructure and it should not make any assumptions
> about the fs block size and the page size of the system.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Link: https://lore.kernel.org/r/20240822135018.1931258-7-kernel@pankajraghav.com
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/iomap/buffered-io.c |  4 ++--
>  fs/iomap/direct-io.c   | 45 ++++++++++++++++++++++++++++++++++++------
>  2 files changed, 41 insertions(+), 8 deletions(-)

For the second time: NACK to this patch for -all- LTS kernels.

It is a support patch for a new feature introduced in 6.12-rc1 - it
is *not* a bug fix, it is not in any way relevant to LTS kernels,
and it will *break some architectures* as it stands.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

