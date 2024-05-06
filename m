Return-Path: <linux-kernel+bounces-170276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FFA8BD45A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 20:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B6028592F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D81F158A33;
	Mon,  6 May 2024 18:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="TugZZ1HB"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44029158204
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715018667; cv=none; b=anfCSM3cDA18+XH5zF7qokBLxYH470bwRFGIBd9GujTWPeu5PxRLxcZvIoczN9HzwUrwQadh2BRdS6gXrRnQXM+5QO/Yhzf7CbSAcbkBO2d04MQ8sa8PE57h2RowJsSlTk1lXbEe6wALEYSsRw90nQk0P7fx9PSzno+UV0xEFAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715018667; c=relaxed/simple;
	bh=cAhKDATngg5XYWtp3wm/gO2bAzCF+ksynWN1+HGqIgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1pcV8mXQVNimVwZLlo1L8IbYH5vUGTs8VZ7itIJZfVbFlIr2eAlPWXpFcKBJ6BqrogyfHhHaJvE5CBxX70P/KPo98jzw5aXYUS1daI+uDC2Hhj5wbJ4Bl7BESX9zoF8pS1fPtKheYEe1ljqBhyR8cfGJRW5ZW9f3NgmiaptvT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=TugZZ1HB; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f489e64eb3so445974b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 11:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715018664; x=1715623464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=te4/Y4Ex1bU5Fl7piJ8mgbBAfhUkYcVHwGSxY1/VZ2Y=;
        b=TugZZ1HBqBbqQJ0K9saySdstreGXiIszyp88wotUwvoyvynHcYwBlsink1K5vY5+vB
         UViW3LprrUOoanxZz4WB+JNvqRb/eZNluV57t/dZMA0dSyZ3e1HgxBhnSdvDT79DOG7U
         hiW9T5mqSVcklTiUifQHdYDYKtPfLnW7lAFhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715018664; x=1715623464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=te4/Y4Ex1bU5Fl7piJ8mgbBAfhUkYcVHwGSxY1/VZ2Y=;
        b=evjDCZ00Ja8Bt0pc1VCC5E4cLGjfE3YJ8yKaTvODExMuYRZvHuh/QpwJjwBuQCaa9s
         y47erAFidJmENMEMkB8Eoou0Yh7OKFGiqK1ZbiHqWnf1gFh4V8bOYq7ZHqVe+8d5EzdN
         o+t9y84TLynVls553drSSOuOSnFMp2x5GonRNA5IVoju0iVXM+Xuh/ChD678J/h/MCCK
         +OO8bVkvw7aLI14VfbrizSQfovFjL/xBSKNaZ3aI/HckChnzol1xQhUBpG3tcaeqkaQb
         x0vHxFj3R19V71CiByy6v7H9ya009NryL8AK4vUB1QvaX48juxhVg/Sr6GqUSRcr2Dpi
         JIgA==
X-Forwarded-Encrypted: i=1; AJvYcCXFPmIYcGZofjg7xmm3tyDWLdjYu+CZwt5ox3aE2M8Z5suKEMdEf3z+KZPC5vHkZDsnrcJ/s1CJUmU6o/nk0bkoozKDcmEKB5xOP+54
X-Gm-Message-State: AOJu0Yy/77eXo4ae1bdHibHFHwDaodJRfHUp2afqUDL5VXPFh7uI61Yn
	i0lV907V2Mj1AyuWPVND7R3mPMu6PzqNjVTGoGj6+eESHHQVNr8howr5B33nCyU=
X-Google-Smtp-Source: AGHT+IGwppSbySl31uGPw1FvJc3LjfLZLPlCmVQ1KC7Gq3CDOyzgBuo4ezyM24BqAPTlNNPjdcMqUA==
X-Received: by 2002:a05:6a21:620:b0:1af:a4f7:cba1 with SMTP id ll32-20020a056a21062000b001afa4f7cba1mr4246826pzb.31.1715018664422;
        Mon, 06 May 2024 11:04:24 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id p28-20020a631e5c000000b005e438fe702dsm8248238pgm.65.2024.05.06.11.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 11:04:23 -0700 (PDT)
Date: Mon, 6 May 2024 11:04:20 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, tariqt@nvidia.com, saeedm@nvidia.com,
	gal@nvidia.com, nalramli@fastly.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 0/1] mlx5: Add netdev-genl queue stats
Message-ID: <ZjkbpLRyZ9h0U01_@LQ3V64L9R2>
References: <20240503022549.49852-1-jdamato@fastly.com>
 <c3f4f1a4-303d-4d57-ae83-ed52e5a08f69@linux.dev>
 <ZjUwT_1SA9tF952c@LQ3V64L9R2>
 <20240503145808.4872fbb2@kernel.org>
 <ZjV5BG8JFGRBoKaz@LQ3V64L9R2>
 <20240503173429.10402325@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503173429.10402325@kernel.org>

On Fri, May 03, 2024 at 05:34:29PM -0700, Jakub Kicinski wrote:
> On Fri, 3 May 2024 16:53:40 -0700 Joe Damato wrote:
> > > diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> > > index c7ac4539eafc..f5d9f3ad5b66 100644
> > > --- a/include/net/netdev_queues.h
> > > +++ b/include/net/netdev_queues.h
> > > @@ -59,6 +59,8 @@ struct netdev_queue_stats_tx {
> > >   * statistics will not generally add up to the total number of events for
> > >   * the device. The @get_base_stats callback allows filling in the delta
> > >   * between events for currently live queues and overall device history.
> > > + * @get_base_stats can also be used to report any miscellaneous packets
> > > + * transferred outside of the main set of queues used by the networking stack.
> > >   * When the statistics for the entire device are queried, first @get_base_stats
> > >   * is issued to collect the delta, and then a series of per-queue callbacks.
> > >   * Only statistics which are set in @get_base_stats will be reported
> > > 
> > > 
> > > SG?  
> > 
> > I think that sounds good and makes sense, yea. By that definition, then I
> > should leave the PTP stats as shown above. If you agree, I'll add that
> > to the v2.
> 
> Yup, agreed.
> 
> > I feel like I should probably wait before sending a v2 with PTP included in
> > get_base_stats to see if the Mellanox folks have any hints about why rtnl
> > != queue stats on mlx5?
> > 
> > What do you think?
> 
> Very odd, the code doesn't appear to be doing any magic :S Did you try
> to print what the delta in values is? Does bringing the interface up and
> down affect the size of it?

I booted the kernel which includes PTP stats in the base stats as you've
suggested (as shown in the diff in this thread) and I've brought the
interface down and back up:

$ sudo ip link set dev eth0 down
$ sudo ip link set dev eth0 up

Re ran the test script, which includes some mild debugging print out I
added to show the delta for rx-packets (but I think all stats are off):

  # Exception| Exception: Qstats are lower, fetched later

key: rx-packets rstat: 1192281902 qstat: 1186755777
key: rx-packets rstat: 1192281902 qstat: 1186755781

So qstat is lower by (1192281902 - 1186755781) = 5,526,121

Not really sure why, but I'll take another look at the code this morning to
see if I can figure out what's going on.

I'm clearly doing something wrong or misunderstanding something about the
accounting that will seem extremely obvious in retrospect.

