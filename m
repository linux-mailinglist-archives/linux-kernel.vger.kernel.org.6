Return-Path: <linux-kernel+bounces-307178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6C0964988
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D111F220B9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDDB1B1515;
	Thu, 29 Aug 2024 15:10:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1871D1B1514
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944237; cv=none; b=t4u/ZwdMtf73aP5y1LddyoOhzoTwcogJla6IxLNb0Kv6JqAIR1Q0ZgY8NFsS02w+RkpduwkKxFu91KO81HycRWORn50ZW1z9k0JGfax0f+hhRcZ129fd32hLxgi/G1isTY+YmCSureTvaopefg9twK/6l02V/i7+rEaVSpCCInA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944237; c=relaxed/simple;
	bh=3wueJtwqZPDY8uUIPY+rtKEAp2/GgrA6iAsAi6G04ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctM3BlETn9iOPTL8nh0P3uR5nbxkGk8AqSAovhWfFA2F4ri3rrab1EH0iQT2nZdKIh7WT6swZ5cSHjQ9OkYmlucfx6IEVzXcd4eZepn56zSl2EAk6kmMs9jY9oFljgDVAn9LnYbKSB2tfeLKFcbs6vhSEA3jptbSIT4irSYtqZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-izm29LL3Pfy9xwnlXf_VjA-1; Thu, 29 Aug 2024 11:10:32 -0400
X-MC-Unique: izm29LL3Pfy9xwnlXf_VjA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5bec23ba156so629868a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724944232; x=1725549032;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=412DWhH/oriLI6hvWD5rHCU4OUHfqjU0rcZX3wNeFQE=;
        b=ciz7zCMbytTI5uGN37GsEp252JphOnUYvbqmHoHuOoiCnUKVbl5TcbowjGSd8XiX1g
         j7UJI8UH2Q40uWjdac3EYGLnM4Gy8PTV2GbfH6UI2o6uLV9XdQz3esRQlepk7nVERykv
         rPQNHPyPpC1cnwd96S+6pXu7tzboafYbKxdwVRKebKim4Nn2eUzlWPpp6JTg0ARKaswr
         8+f9UxKnp7azs8wvdX/NAarjjLYBe7viI+0WMVvS979mIfdcqsD3k4uyETOZ6wErj87u
         4SpNJ776X6ZQlAJHAYM+Sg4hDx0BT6Q+TJuhSxRrQoa/G+sBhFQvB/S61gHnOyCVpXBl
         B0lg==
X-Forwarded-Encrypted: i=1; AJvYcCWBEDEyXtaL7ZfdrTAU4vCCHXWq0BHvYBYA1dCllGYZtpd4SRR6ZRJQFyyM/SwMcq4I7ED3dltQGVn2qb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ySWOtzsD06HEK5Dnc8zRWb1G7RStv3LKUws01L9qK151m8CV
	yIwd9EtAEL898YWd75wACYk+CqPOQAA5UX4kHlF7T4CYhGgpZcEngm3+pCvPu+L1/IfJ1CNZlhh
	yNhWhPoefwAiCtu44WtQhLfS3Ask/JMbxxc6CEr3rZylLWaEAaVqqsqZN3s/86g==
X-Received: by 2002:a05:6402:3506:b0:5c2:17f7:a3cc with SMTP id 4fb4d7f45d1cf-5c21ed311dfmr3269563a12.7.1724944231549;
        Thu, 29 Aug 2024 08:10:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsjAXjjJGNgtKMvoMzJYd+NwWHB3eXVAslR4/vzHPWb7ReUjNyaxjfmmOTF5ScXOWLN7Kriw==
X-Received: by 2002:a05:6402:3506:b0:5c2:17f7:a3cc with SMTP id 4fb4d7f45d1cf-5c21ed311dfmr3269546a12.7.1724944230707;
        Thu, 29 Aug 2024 08:10:30 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17c:f3dd:4b1c:bb80:a038:2df3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d80fcsm89031566b.181.2024.08.29.08.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 08:10:30 -0700 (PDT)
Date: Thu, 29 Aug 2024 11:10:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>, Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, virtualization@lists.linux.dev,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v5 6/7] vdpa: solidrun: Fix UB bug with devres
Message-ID: <20240829110902-mutt-send-email-mst@kernel.org>
References: <20240829141844.39064-1-pstanner@redhat.com>
 <20240829141844.39064-7-pstanner@redhat.com>
 <20240829102320-mutt-send-email-mst@kernel.org>
 <CAHp75Ve7O6eAiNx0+v_SNR2vuYgnkeWrPD1Umb1afS3pf7m8MQ@mail.gmail.com>
 <20240829104124-mutt-send-email-mst@kernel.org>
 <2cc5984b65beb6805f8d60ffd9627897b65b7700.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cc5984b65beb6805f8d60ffd9627897b65b7700.camel@redhat.com>

On Thu, Aug 29, 2024 at 04:49:50PM +0200, Philipp Stanner wrote:
> On Thu, 2024-08-29 at 10:41 -0400, Michael S. Tsirkin wrote:
> > On Thu, Aug 29, 2024 at 05:26:39PM +0300, Andy Shevchenko wrote:
> > > On Thu, Aug 29, 2024 at 5:23 PM Michael S. Tsirkin <mst@redhat.com>
> > > wrote:
> > > > 
> > > > On Thu, Aug 29, 2024 at 04:16:25PM +0200, Philipp Stanner wrote:
> > > > > In psnet_open_pf_bar() and snet_open_vf_bar() a string later
> > > > > passed to
> > > > > pcim_iomap_regions() is placed on the stack. Neither
> > > > > pcim_iomap_regions() nor the functions it calls copy that
> > > > > string.
> > > > > 
> > > > > Should the string later ever be used, this, consequently,
> > > > > causes
> > > > > undefined behavior since the stack frame will by then have
> > > > > disappeared.
> > > > > 
> > > > > Fix the bug by allocating the strings on the heap through
> > > > > devm_kasprintf().
> > > > > 
> > > > > Cc: stable@vger.kernel.org    # v6.3
> > > > > Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
> > > > > Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > > > Closes:
> > > > > https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr/
> > > > > Suggested-by: Andy Shevchenko <andy@kernel.org>
> > > > > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > > > 
> > > > Post this separately, so I can apply?
> > > 
> > > Don't you use `b4`? With it it as simple as
> > > 
> > >   b4 am -P 6 $MSG_ID_OF_THIS_SERIES
> > > 
> > > -- 
> > > With Best Regards,
> > > Andy Shevchenko
> > 
> > I can do all kind of things, but if it's posted as part of a
> > patchset,
> > it is not clear to me this has been tested outside of the patchset.
> > 
> 
> Separating it from the series would lead to merge conflicts, because
> patch 7 depends on it.
> 
> If you're responsible for vdpa in general I could send patches 6 and 7
> separately to you.
> 
> But number 7 depends on number 1, because pcim_iounmap_region() needs
> to be public. So if patches 1-5 enter through a different tree than
> yours, that could be a problem.
> 
> 
> P.

Defer 1/7 until after the merge window, this is what is normally done.
Adding new warnings is not nice, anyway.

-- 
MST


