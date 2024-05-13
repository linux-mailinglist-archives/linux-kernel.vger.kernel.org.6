Return-Path: <linux-kernel+bounces-177983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D456C8C471E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 20:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8486A1F22D73
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580743BB23;
	Mon, 13 May 2024 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="GZha+N5Y"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868294207A
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715626023; cv=none; b=DB1SfcPkk9vYZJCKANlzHnOmICKIJbfxAgZdsdG76ROYM1nRFVnN3/zYluRxstLWQYKDZv2PfaqxxrflnBe5uTuoqA1Z6rdqEz1b5sAedCS+9Ke2jeZB782voyW0pvPgufgSu7HQkEX6ESwnRSWEEZcGgS+CsuSMQw6v+5wy6/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715626023; c=relaxed/simple;
	bh=1u9/b9gk/Tl5ozsdOKNx/td/R95i1KBWjQylrJWvc1k=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2JzBlSf2k6Kvrl8Q8qbxGKShtogXKTfLuecymRGYZO8fTo975sFubL+qurSLzfVGJN/TFSYQqow7ilVZlJwMwa5k4vDxmduxjWnhLXckakUjtMMtA1BzoMF4oUK6cl4wHODSTrGpLQBqliaHZJ+HgpazjVD1UP7h8JJmsFBvzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=GZha+N5Y; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1eeabda8590so33661105ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 11:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715626021; x=1716230821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4/YpgsmxEh7NnZ1zRADZ2HbHM07VTZzuSca8drjzUhU=;
        b=GZha+N5Yez+iTz/TJMB89wFfdlYKZVoMOL6XtCKFwXwvnC9bK+icU4rmf7z0o5xRtI
         YJhwmdcng42I136HEmlU6AhQpa5HJHx/uJTPh20EewuS+/5YCurgrqQ8/2rGf53Blzup
         15FMB9VxAHNF0PugoirJhF4ti2jn+lJP92tcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715626021; x=1716230821;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4/YpgsmxEh7NnZ1zRADZ2HbHM07VTZzuSca8drjzUhU=;
        b=Tph4P03MXM3AMtT5N9vCOZBJiQrirKUCXWrN0THzzL+oGY8hqfxc+KmOvBJwA8lRwH
         m0JQ5TZW9DXXUI5NsXlBF44536Qna8Hvqzy7B+G/a5REyjMofjOo/Ssv0kWmEBdVGTNv
         4U6Cxjg5WA28pDskQ7cnhiKryTvfJGxpb0wx4S8yhUXBiuE53GCPX6rTefPK7v+jwXC8
         kDp/wJXPM9p41RN9UF1Y1dIogPFVA/oGiqZo0Nr0VnuDdZNGGIxaGz3rc+tpLrPQPsfF
         rKzuXAxo2E58u7//0CQbhlEQ2gTDqiNCvk4OIkAZgS60hDmYw/JURdPGdRDTznJme8DR
         dEvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWbAVA+akgAp0XujdRh16bxteftWQ1yg2g+MizjggQqUvL5E7NE6F9b0gx/tXQR/PQuoMmF9hTe0x8EeeJEt9gvYFYwN2jw/PvoNJk
X-Gm-Message-State: AOJu0Yx70KC5USDoB9pFbJkPv+xHaqsN7gzCExZHGeVNJ+YnbCicHitK
	AtvUHVEatNA7FfpYSbpsta+43+zxojzpiLA1oRg97UaAS9aF2PSCwrqAoWUPiiI0DqX9s/q3XOy
	kZac=
X-Google-Smtp-Source: AGHT+IHbSrhUBqN1/ZWPPfyWlFBVdHyHLIR+khL/KKrN4dLXG5CPpLVAkZ3pgSvHmoFsy/dhzVKAsA==
X-Received: by 2002:a17:902:f552:b0:1ed:1d37:267e with SMTP id d9443c01a7336-1ef43e281b0mr137384885ad.16.1715626020880;
        Mon, 13 May 2024 11:47:00 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d168esm82664875ad.32.2024.05.13.11.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 11:47:00 -0700 (PDT)
Date: Mon, 13 May 2024 11:46:57 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	zyjzyj2000@gmail.com, nalramli@fastly.com,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/1] net/mlx5e: Add per queue netdev-genl
 stats
Message-ID: <ZkJgIe71mz12qCe1@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	zyjzyj2000@gmail.com, nalramli@fastly.com,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
References: <20240510041705.96453-1-jdamato@fastly.com>
 <20240510041705.96453-2-jdamato@fastly.com>
 <20240513075827.66d42cc1@kernel.org>
 <ZkJO6BIhor3VEJA2@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkJO6BIhor3VEJA2@LQ3V64L9R2>

On Mon, May 13, 2024 at 10:33:28AM -0700, Joe Damato wrote:
> On Mon, May 13, 2024 at 07:58:27AM -0700, Jakub Kicinski wrote:
> > On Fri, 10 May 2024 04:17:04 +0000 Joe Damato wrote:
> > > Add functions to support the netdev-genl per queue stats API.
> > > 
> > > ./cli.py --spec netlink/specs/netdev.yaml \
> > > --dump qstats-get --json '{"scope": "queue"}'
> > > 
> > > ...snip
> > > 
> > >  {'ifindex': 7,
> > >   'queue-id': 62,
> > >   'queue-type': 'rx',
> > >   'rx-alloc-fail': 0,
> > >   'rx-bytes': 105965251,
> > >   'rx-packets': 179790},
> > >  {'ifindex': 7,
> > >   'queue-id': 0,
> > >   'queue-type': 'tx',
> > >   'tx-bytes': 9402665,
> > >   'tx-packets': 17551},
> > > 
> > > ...snip
> > > 
> > > Also tested with the script tools/testing/selftests/drivers/net/stats.py
> > > in several scenarios to ensure stats tallying was correct:
> > > 
> > > - on boot (default queue counts)
> > > - adjusting queue count up or down (ethtool -L eth0 combined ...)
> > > - adding mqprio TCs
> > > 
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > 
> > Tariq, could you take a look? Is it good enough to make 6.10? 
> > Would be great to have it..
> 
> Thanks Jakub.
> 
> FYI: I've also sent a v5 of the mlx4 patches which is only a very minor
> change from the v4 as suggested by Tariq (see the changelog in that cover
> letter).
> 
> I am not trying to "rush" either in, to to speak, but if they both made it
> to 6.10 it would be great to have the same support on both drivers in the
> same kernel release :)

Err, sorry, just going through emails now and saw that net-next was closed
just before I sent the v5.

My apologies for missing that announcement.

Do I need to re-send after net-next re-opens or will it automatically be in
the queue for net-next?

