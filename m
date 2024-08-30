Return-Path: <linux-kernel+bounces-308714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F159660C3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559DA281AE5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5063A1922F4;
	Fri, 30 Aug 2024 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O5z0C1H7"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F99170A2C
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725017487; cv=none; b=aF5pz+lRKhzpGdT08Mo8Zoxny6itd1ZLJYJukCNp4cW6itufN3B/WfA9Y1GuQbj3ZizbtGZcnxMPYi8/uaY7gRcR7vkQX6stKsYZ40G2Cy5HFQgOxhKTNMwc4NftyXUzD057n98Yjs3cuNuBW+uNGNYWP6HSZ0Yrdy5p83oELkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725017487; c=relaxed/simple;
	bh=lNItZKI/zeGregKkCBlucA4/+L3ax7NRii/HfaRRwX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUreLCuAcZGNCUqKecDEmU4xbxipFAreicZ1t2kRcXvdqNIH4q3OM/2w4VPpGTVLhW9aWim2eh1Lj2jNLLtXKTZ+3d2HD38bhGzANi5cPhsVf7iszjdsGzCBhOcVhHRvTD/HPmCoZgxRVIjAG2We8zWO2nxmLawCuwC3V6+x3BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O5z0C1H7; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374b5f27cf2so207581f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725017483; x=1725622283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2GvO8k4+n+cL0s8zcxKvXKY7jMfYBe3D7bGlijy6H5Q=;
        b=O5z0C1H7/i0MQ2mc40x8AQYYZMrHlH413SjB/qawMRD02M8S+pJUYUtDqJAjwUGVQV
         zpWnOQaInHm8EJ3kTVDdIkTX4+Tz6G8xu3Lj6D9rqlwD4ybyvh5+65B9Dsoc2RmCSmk/
         /p5rWCJvb2g41Z4RF4e1y10gWCS0WJe9RJOIof8YiWoUTbjJi9CWpn95ESBZihiqCNOg
         3iPBCR4ht4vHJXLlQBldhJOeohdMdNq2Vu50NqlAhirom83y141yBQX/HB7F768drTXQ
         b8AzlOt79H/toTktA1w9w0oR3Ot2lbyjRfG8+SjItNf8alz83lCMK1Pv2ug182SMmaBs
         6sJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725017483; x=1725622283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GvO8k4+n+cL0s8zcxKvXKY7jMfYBe3D7bGlijy6H5Q=;
        b=w6yVyJUJRgyv6tcDMfv5ZVnAagfh00H3Ur8IHAi3VEEVl2O7uFv/tFVbCNpdy1Cy7t
         KQrO/KfXtuBovsNWatxcvl5DWhd8cuIrUaEJKceSr+13b9x+qnLop/5JmNaXI184i83D
         XQ5wxMZyB6WQchbiYddlr3SEzPzv9pxwR5c5jwtm67mG8qWtK5VKIR7jfTJ8uWRPnht4
         NK2fUvg8T5tUX0m6lVm2HhWzIBcL4a2xXxuU3QvJ29VmuEmtrFMdmq1ULEXcX1viakxm
         pkNr7LMPN8v8tH+Qutxs+4ZFxHKqI1P7Y1z9rtLi8RD6+9xODi81Ge71mp+dGh2k+0ok
         +Q0g==
X-Forwarded-Encrypted: i=1; AJvYcCW4q0D/8LW7is9w8Rkgk0ehhJ6n6p/02Kaqai2BFCj0iWDfkMRLJzN0udRcfAa8IRPQbcpGNMnFvErLGTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmSyYej3tLv8l5VC86HJ6if7TjGMq9RcYRD+TxJUV68h4qIAmH
	p5rkGtTEvaxFJXFMVO8ClW6o2SsHXEK33y+3tFzYsfr58XI+s5jQPWNMt8Tdm/s=
X-Google-Smtp-Source: AGHT+IEHcTx6s6ZCYzaUr324OCbDcX6kfN1Z1CjdW/1CU42SuDvxvPzn6Bbu8/rlY+qzkqdTtoW9PA==
X-Received: by 2002:a05:6000:4388:b0:374:b9d0:f2c3 with SMTP id ffacd0b85a97d-374b9d0f45dmr219127f8f.17.1725017483248;
        Fri, 30 Aug 2024 04:31:23 -0700 (PDT)
Received: from localhost (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee4981asm3768156f8f.24.2024.08.30.04.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 04:31:22 -0700 (PDT)
Date: Fri, 30 Aug 2024 13:31:21 +0200
From: Michal Hocko <mhocko@suse.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: drop GFP_NOFAIL mode from alloc_page_buffers
Message-ID: <ZtGtiZF4p340nrDf@tiehlicka>
References: <20240829130640.1397970-1-mhocko@kernel.org>
 <20240829191746.tsrojxj3kntt4jhp@quack3>
 <4dfed593-5b0c-4565-a6dd-108f1b1fe961@suse.de>
 <ZtGTEOEgf4XuUu7F@tiehlicka>
 <20240830-formel-abklopfen-fa1249f5904d@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-formel-abklopfen-fa1249f5904d@brauner>

On Fri 30-08-24 13:01:29, Christian Brauner wrote:
> On Fri, Aug 30, 2024 at 11:38:24AM GMT, Michal Hocko wrote:
> > On Fri 30-08-24 08:11:00, Hannes Reinecke wrote:
> > > On 8/29/24 21:17, Jan Kara wrote:
> > > > On Thu 29-08-24 15:06:40, Michal Hocko wrote:
> > > > > From: Michal Hocko <mhocko@suse.com>
> > > > > 
> > > > > There is only one called of alloc_page_buffers and it doesn't require
> > > > > __GFP_NOFAIL so drop this allocation mode.
> > > > > 
> > > > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > > > 
> > > > Looks good. Feel free to add:
> > > > 
> > > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > > 
> > > > Although even better fix would be to convert the last remaining caller of
> > > > alloc_page_buffers() to folio_alloc_buffers()... But that may be more
> > > > difficult.
> > > > 
> > > Already done by Pankajs large-block patchset, currently staged in vfs.git.
> > 
> > Which branch should I be looking at?
> 
> Hi Michal, Hannes should be referring to:
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs.blocksize

OK, but that branch seems to still have alloc_page_buffers user.
Maybe I am just misunderstanding what am I supposed to do here.
Anyway, I won't have much time to spend refactoring this so if there are
more changes required then I will likely not get to that. Sorry.
-- 
Michal Hocko
SUSE Labs

