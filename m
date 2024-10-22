Return-Path: <linux-kernel+bounces-376907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACD09AB74A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A1321C23551
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3087E1CBEAB;
	Tue, 22 Oct 2024 19:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="jp/XSFjP"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D681C9DD7
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729627169; cv=none; b=iI6wECBCVox+/G+Dz4kzp/1i2W3VbE8ef0qPLTXWwmxo3YZot4vYZExEyxqF/D0h4844zjwz1I05p/ZrgSFbkb2ckjkQifODxd5xFoyaHUV2j90dn8QYwMg790QQKpS/LMCmNt/+azM6mtSO4Wy6HcXyD2/hnD+2Q5trpAFxt+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729627169; c=relaxed/simple;
	bh=r6otyKA3WLyak03vklmEbpRTCqjFb4oYyFuxi1qJRDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKtAsWjz7MmPCkK9mDkQsqDEES/1qmGd1kT/7nj3P1YiDXoC9FEsdQAVrf+gnXp8MOFmYf5bc0YniTRQP+4ezFsB43sEeoTTlaZsfc13LEfwUquWr1bqqXpI0uM3uEiNohDX1YBhg/vTbegyqXJqKm624NTKSW4CWPNuYCiKl1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=jp/XSFjP; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2c2a17aa4so1165081a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1729627167; x=1730231967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CjczLJzU846pgk/Nf+gEz1IGPCfQMK9BEKbQgAkTrs8=;
        b=jp/XSFjP9WLmJBFfYEF1nsnMxiwUse7qfMSpUMRTHQKkP0839i6JsEhe7ULlm99PV+
         o2+ZG4Hc1uYBHBWQZShzP+qjz7mBNww9MBVIrXb/Gl748CtfMT5hZWUKaRXY51oIX8m5
         ADFGdPhW5J3E4V8EBrf781aRFczWmugl4HITXt/Q+yo6kfqGJ4J7W1k0rOHwJLid/ub7
         ZyT4GFws3h0QVMDzUfXTRtqpdbAULmoG9Bjy9vCdGAJoc9rwYMatVGscpxYlSKVREJsI
         TxHBeJy1OQncF9jgL4LSC+aZotvm9ZiS5XXYAXF22xrAz6+16jfydDVIXbpxFsG5Rd8O
         7UVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729627167; x=1730231967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjczLJzU846pgk/Nf+gEz1IGPCfQMK9BEKbQgAkTrs8=;
        b=MTCJNQPmIyf8PGDKHKeLo+F1mtiINVoU0Ll8apt9oqZZ17xUTEmi0gfxHPGoZzZhhM
         hMJxj7p9M01GVJAflvbS3b0mrGzl8UoTsXu8h9ES3qj7yJfanmEfxkTH6/uEL0WLpbEx
         w3jUtn3lWo6ULFlbE19lzQ5o6ATb59MmRZAkZGYFmzr5g+AOfnc4re21gn+yRGWlukDt
         tYotSgeT1D8dq1WGJopBDR9IJPRzH+1BvI5rXg9LBo6vhTvO5tUYnTGoq/AkytmSgm4g
         DD/OM+xLwOK88pAtmhVQ4VVJxUBtrVNoPxrxLIX/8Pncff+7KEBbcQ000I2Jds1OE0oD
         RGNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwK2HhEq0xCYO8HoFow1rytU/YpVOy1DZPg1svIMycZBViWZgbHofXP47lOPOiUSt98CfHR0KzRIZy/Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHkagr+smCYY9HwHMUh0zuYLtceFPRE2HyuIcOBnFdIgqYBFL1
	EEAI4Ik0/Cf9t35iv/8cICvvCpmykzjOqTvQqcpS0b0ETlWncIEOALUibMW/0ko=
X-Google-Smtp-Source: AGHT+IG0PhGSKJ1IxiGqheB7b0O4ycpWVH5TGjBsj3+UTjIsqfm7JYVK9+WbQbe3Sw1ZlC5jd7OckQ==
X-Received: by 2002:a17:90b:1081:b0:2e2:abab:c458 with SMTP id 98e67ed59e1d1-2e76b72f825mr36709a91.8.1729627167317;
        Tue, 22 Oct 2024 12:59:27 -0700 (PDT)
Received: from telecaster.dhcp.thefacebook.com ([2620:10d:c090:400::5:9251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad3892bdsm6653800a91.31.2024.10.22.12.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 12:59:26 -0700 (PDT)
Date: Tue, 22 Oct 2024 12:59:25 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, Muchun Song <songmuchun@bytedance.com>,
	josef@toxicpanda.com, oleg@redhat.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: remove redundant explicit memory barrier from
 rq_qos waiter and waker
Message-ID: <ZxgEHW0UuuLcSY7_@telecaster.dhcp.thefacebook.com>
References: <20241021085251.73353-1-songmuchun@bytedance.com>
 <ab3720ec-b12b-4c0a-8e56-930753c709fd@kernel.dk>
 <7C429559-E91C-4732-901B-0D49C2D083F7@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7C429559-E91C-4732-901B-0D49C2D083F7@linux.dev>

On Tue, Oct 22, 2024 at 02:31:53PM +0800, Muchun Song wrote:
> 
> 
> > On Oct 21, 2024, at 21:45, Jens Axboe <axboe@kernel.dk> wrote:
> > 
> > On 10/21/24 2:52 AM, Muchun Song wrote:
> >> The memory barriers in list_del_init_careful() and list_empty_careful()
> >> in pairs already handle the proper ordering between data.got_token
> >> and data.wq.entry. So remove the redundant explicit barriers. And also
> >> change a "break" statement to "return" to avoid redundant calling of
> >> finish_wait().
> > 
> > Not sure why you didn't CC Omar on this one, as he literally just last
> > week fixed an issue related to this.
> 
> Hi Jens,
> 
> Yes. I only CC the author of patch of adding the barriers, I thought
> they should be more confident about this. Thanks for your reminder.
> I saw Omar's great fix. And thanks for you help me CC Omar. I think
> he'll be also suitable for commenting on this patch.
> 
> Muchun,
> Thanks.

Well there goes my streak of not reading memory-barriers.txt for a few
months...

This looks fine to me. wake_up_process() also implies a full memory
barrier, so I that smp_wmb() was extra redundant.

Reviewed-by: Omar Sandoval <osandov@fb.com>

