Return-Path: <linux-kernel+bounces-529539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A74CA42791
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1CAC7A72BE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5401A262D0E;
	Mon, 24 Feb 2025 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="SiF8ZM+b"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624EC262801
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740413673; cv=none; b=rizYQXhfObYFcB5c0Gw5s1kZZmIO+mwHHbSAqiWcDU10SoVeXoZ7isuBIUd1iucGeEdMG1ChIylqXJ4XTWNU3LL1TreExzPNuXiNjVkJqLfPNQz7/RerwSGEHlKoPta4raDkmqSgw6PYf4fkvCwoi5R6zrP+SPinQwhi9GFNaV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740413673; c=relaxed/simple;
	bh=8pHf58/IJmHEFkLOVx6pISR20TTm7mPx7wAFV99o5XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuGqvRa31ZPlIVxei0XP0hLE22e0tr5U97gGNk7LztwkDRq/CdJOl+IvvnBrcMcz+x9BZsiU4HQPrE3JDBq1SSrabWBaLVN67i3x1af0QgD3WOm94sWJbVWyWfLP5zLTLZ5qkOdLlODFaovvCWcNDpFYUh2MMku/KrJ/ijkMIj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=SiF8ZM+b; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-439a4fc2d65so43815885e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1740413669; x=1741018469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h/sh9tYzriu7P8K3a6NXodWLaeByYc2pcpFzG1MBuzY=;
        b=SiF8ZM+bgRv6N5FEgAtKGGI83JPmc7a0tot5OE2UZDTlypJo/qzTkt/hlAVZPRq1t9
         vDOd1huRAAu6WdZyb9TbLo033gw5gkrmRUjEnXqLolukC53uLxV11JwBi6bxg3QsIYSw
         T+BTuN+h0x0pTwRp3iXYCecdHYFtaZbEAiKpB1wvxDsVL73z6A+NQOMPq7J0DpHqyIfb
         d1MjC0qlbY/JYu9Xa4HQTakCAfieOkK0jJvjQZ4wvEWHgHm7qq0TDDjaLcX+dRlA1Jm+
         A+wZnYqWK1LLZkc1Twdcl4JMNovcWtM5gZhtxsGKpBFzuYa/olnJZelEN1mC9q6wfog5
         0aUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740413669; x=1741018469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/sh9tYzriu7P8K3a6NXodWLaeByYc2pcpFzG1MBuzY=;
        b=ferBs8wC0CCTrTN1I+INS+GFJ7nWlB9LtLX5QVQ2ExfPrPpdD5i4EdFOQnxT7ix89r
         B9aim2rBTY6942rvgoDptsl0dHSuuMOI3e5faHLNTe8D7EmhMU1jYff7XSbDp68xHgJU
         9ooLuOGHlEC0doe9Q61ftdPtcUs0VG2D8SQsOoKr8T0GtFWn/9mD9O9xF4a7pgJkWXT3
         jn+uBj+coi5+MHXoE+MTLCNFZLU8a7bcbKkwTqgyJxjH6+lIPo+3aPwYWvWBx5c1xzro
         H6LZLSvHvmAZjNnWXP+dht2CdnCijRRv2YKbWpyKOyGcRs5FxPLw7cJsfLiXYCgGlimj
         3MDA==
X-Forwarded-Encrypted: i=1; AJvYcCVhMd8hXIw6qXPpH+utbdEEhYB2/Wj0op7U/T09SOffIzugrmdL6DAGEz8B9EyTSU767nnJ1nFALsGvt3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJcVEfgqlPQ+4dv+6q7qjV4r8rlKR6vrMzUWsC9MTkLevWlBYb
	znfyk6WDw+Fb5Rt3o/eJzBa87lIEg49rto280Q3nUdsYmW5QkezWH0m2EsMvux0=
X-Gm-Gg: ASbGnctrXLkHwr0Ah8aB2m8YfItEMuzsATl7FWa1GKfEwSCleHNHg4zoCMSklW3vex2
	2YGe7YN+tHR7eO0cZ2tfzgKRm/caa3HfVpzH8jeKEQFpbwYp9XLNyM/1dZ4MivxmVyOd5QYjQEX
	Axf6VTKBzTvvbVLRCdLVB+o1urYdU6zK3D8IfPy143wkRn6dX0DXyCg3CGvuLgKKS0UI+Kod5lZ
	ZY81+u5fC59tQ4CioVSaO4fY2VillrC9DFOg2lcpa3TVdgOIkvLF4OGalRseKWqdgqWt3tNr5E5
	PJP7ku7i4K/lojTdu90H1aan1adjB2Dmt8ClBTLMXDTl/RzvV+hi
X-Google-Smtp-Source: AGHT+IGFMuJoexgwJBIAntd1ZqfRe+XRYaboGXOhhAu2dMaG6XTtLfFba5EQSN/nC4WE3rqTZIalwA==
X-Received: by 2002:a05:600c:4f41:b0:439:8b05:66a6 with SMTP id 5b1f17b1804b1-439ae214327mr109222005e9.22.1740413668842;
        Mon, 24 Feb 2025 08:14:28 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([208.127.45.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b43c9sm32321129f8f.10.2025.02.24.08.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 08:14:28 -0800 (PST)
Date: Mon, 24 Feb 2025 17:14:24 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>, 
	Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, netdev@vger.kernel.org, 
	Konrad Knitter <konrad.knitter@intel.com>, Jacob Keller <jacob.e.keller@intel.com>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	linux-kernel@vger.kernel.org, ITP Upstream <nxne.cnse.osdt.itp.upstreaming@intel.com>, 
	Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [RFC net-next v2 1/2] devlink: add whole device devlink instance
Message-ID: <ybrtz77i3hbxdwau4k55xn5brsnrtyomg6u65eyqm4fh7nsnob@arqyloer2l5z>
References: <20250219164410.35665-1-przemyslaw.kitszel@intel.com>
 <20250219164410.35665-2-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219164410.35665-2-przemyslaw.kitszel@intel.com>

Wed, Feb 19, 2025 at 05:32:54PM +0100, przemyslaw.kitszel@intel.com wrote:
>Add a support for whole device devlink instance. Intented as a entity
>over all PF devices on given physical device.
>
>In case of ice driver we have multiple PF devices (with their devlink
>dev representation), that have separate drivers loaded. However those
>still do share lots of resources due to being the on same HW. Examples
>include PTP clock and RSS LUT. Historically such stuff was assigned to
>PF0, but that was both not clear and not working well. Now such stuff
>is moved to be covered into struct ice_adapter, there is just one instance
>of such per HW.
>
>This patch adds a devlink instance that corresponds to that ice_adapter,
>to allow arbitrage over resources (as RSS LUT) via it (further in the
>series (RFC NOTE: stripped out so far)).
>
>Thanks to Wojciech Drewek for very nice naming of the devlink instance:
>PF0:		pci/0000:00:18.0
>whole-dev:	pci/0000:00:18
>But I made this a param for now (driver is free to pass just "whole-dev").
>
>$ devlink dev # (Interesting part of output only)
>pci/0000:af:00:
>  nested_devlink:
>    pci/0000:af:00.0
>    pci/0000:af:00.1
>    pci/0000:af:00.2
>    pci/0000:af:00.3
>    pci/0000:af:00.4
>    pci/0000:af:00.5
>    pci/0000:af:00.6
>    pci/0000:af:00.7


In general, I like this approach. In fact, I have quite similar
patch/set in my sandbox git.

The problem I didn't figure out how to handle, was a backing entity
for the parent devlink.

You use part of PCI BDF, which is obviously wrong:
1) bus_name/dev_name the user expects to be the backing device bus and
   address on it (pci/usb/i2c). With using part of BDF, you break this
   assumption.
2) 2 PFs can have totally different BDF (in VM for example). Then your
   approach is broken.

I was thinking about having an auxiliary device created for the parent,
but auxiliary assumes it is child. The is upside-down.

I was thinking about having some sort of made-up per-driver bus, like
"ice" of "mlx5" with some thing like DSN that would act as a "dev_name".
I have a patch that introduces:

struct devlink_shared_inst;

struct devlink *devlink_shared_alloc(const struct devlink_ops *ops,
                                     size_t priv_size, struct net *net,
                                     struct module *module, u64 per_module_id,
                                     void *inst_priv,
                                     struct devlink_shared_inst **p_inst);
void devlink_shared_free(struct devlink *devlink,
                        struct devlink_shared_inst *inst);

I took a stab at it here:
https://github.com/jpirko/linux_mlxsw/commits/wip_dl_pfs_parent/
The work is not finished.


Also, I was thinking about having some made-up bus, like "pci_ids",
where instead of BDFs as addresses, there would be DSN for example.

None of these 3 is nice. 

The shared parent entity for PFs (and other Fs) is always reference
counted, first creates, last removes. I feel like this is something
missing in PCI spec. If such beast would exist, very easy to implement
this in devlink. We have all we need in place already.



