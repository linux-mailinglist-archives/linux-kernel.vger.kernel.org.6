Return-Path: <linux-kernel+bounces-376903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1369AB73B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E69286931
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4101CBE98;
	Tue, 22 Oct 2024 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="IaivukWo"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BE517C98
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626904; cv=none; b=t+zVDJEyfJNm0paJQUciHhq2vnGX+ZmGz9OP/QGcqZcYHkBmCyHiCWLAseC3Btp2cKC9jd5OJkbGvZNjx/tYWYQ5kEPfGkrHG7hywkSocMPVCFMjAo3PM4bubg+cWUoF782hdGPBr0SLgh889IlrqTRGw/0np4oT6G5jE7pbuUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626904; c=relaxed/simple;
	bh=OwNBECyO8a4KyyWaokcQ5DrkDXHEf/AVG2cFGODOWbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oML1eF2MRjDF4EnPW8ToA4FvmX3c47HWQ9ttn3CO1l8H5C4r9WeOYEApFcfRecTxW+khM63pmQlO3Oe06OGpztN2jXaFccBG/95DTdbGUxrvD1JTpLUQHOkQ8auId1kDeCcA5+tYDL2zlSthmyZ87Ka67UEfzuTAFAcEylhgRxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=IaivukWo; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e5a62031aso4211765b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729626902; x=1730231702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyiwtrdDNttqs/EmE5JLMsYdKcmXilzmJKF+u4QMJ3k=;
        b=IaivukWoBQvm+COOLj8X/MyxG65oIZGqscCxUuhoxZdcVuSl+LueqG6NFnsBoLOk3k
         J84085qjbv79KatZEA0bDPQX6QataLqxWcLIks99NQ4U4wBX/oKLO8ZcoekwaJdsvHfe
         OmTepm22hNnq2+tz68B+ay4PWroUTM3bQxflE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729626902; x=1730231702;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GyiwtrdDNttqs/EmE5JLMsYdKcmXilzmJKF+u4QMJ3k=;
        b=BA81EEubUVOWfvcaiL823hfRr9dHjPFQRVyVICf6RPhdwRU9Cd5Pzf7iUHR+UdpHTD
         WiAfm9HuUbAZfKUE/ULSqCE7PlroPOc03jIlmA9q3VuqZqe3J2r8gsANQypW2XL7CGna
         x1Ef+5yjC4IUFZLGVvlp+8FHPyzXCU6KCpV6Rn/ZfuwDFyocY1SeF0k1ikFIk6G+59L2
         4qqk60ma25M7RuNyX4EERz7dWl4lZ/LCNc7l3+Pvi8b2cNWmTf4qbt2bPbJ0H86YzHB9
         Y4+j9fFor7Qlg+3VKrUDamMxvaI1VXjG7drRdTUI05G12OAM7GPcJiQbIXxK7yPOeFXC
         u2RQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0eBO3D1DfyGvFlpwgCwD7WkXkJ1MhKgzjH/ziCea6blcbN2WZZBGXaX6oPHvgaEh+OCfK1UKkIdu0aa0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+lpxNbmRtVh2WZFooa8RaQAyAz1kmIOaPqHGuQnZIyCmngSho
	khA/tHEnVOz8nAMl+fm60MWVJa8pU/afOOVoQgxZ5PodKr1LAtugmsM8JYa4phE=
X-Google-Smtp-Source: AGHT+IHOS5ZW9hfqejqTSv0uUEcgV0zqvj28qCLjL54AXpj9P6o2oacvHMmutTEyUR5UBufxHBYjiw==
X-Received: by 2002:a05:6a00:14cf:b0:71e:f4:dbc with SMTP id d2e1a72fcca58-72030cefe05mr409232b3a.25.1729626902274;
        Tue, 22 Oct 2024 12:55:02 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec14159d4sm5085891b3a.210.2024.10.22.12.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 12:55:01 -0700 (PDT)
Date: Tue, 22 Oct 2024 12:54:59 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, kurt@linutronix.de, vinicius.gomes@intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [net-next v3 1/2] igc: Link IRQs to NAPI instances
Message-ID: <ZxgDE96t2iWXlI8o@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
	kurt@linutronix.de, vinicius.gomes@intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20241018171343.314835-1-jdamato@fastly.com>
 <20241018171343.314835-2-jdamato@fastly.com>
 <d4eccf1a-3346-4446-a7ef-67e6905be487@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4eccf1a-3346-4446-a7ef-67e6905be487@intel.com>

On Tue, Oct 22, 2024 at 11:50:15AM -0700, Jacob Keller wrote:
> 
> 
> On 10/18/2024 10:13 AM, Joe Damato wrote:
> > Link IRQs to NAPI instances via netdev-genl API so that users can query
> > this information with netlink.
> > 
> > Compare the output of /proc/interrupts (noting that IRQ 144 is the
> > "other" IRQ which does not appear to have a NAPI instance):
> > 
> 
> Minor nit: 144 doesn't appear in either output, and it seems like this
> intended to indicate 128?
> 
> We think its a typo as the 144 appears in the data from the second commit.
> 
> I can make a note here to fix this typo when sending after we finish
> validation, if there's no other issues.

Yes, that's an error on my part. Sorry about that. I re-ran the
patch after updating it and amended the commit message, but forgot
to update '144' to be '128'.

Based on the e1000 bug report that came in [1], I'm going to take
another look at the igc patches to make sure the paths where the
queue mapping happens (in Patch 2) are all in paths where rtnl is
held as I attempted to do for e1000 [2].

[1]: https://lore.kernel.org/netdev/8cf62307-1965-46a0-a411-ff0080090ff9@yandex.ru/
[2]: https://lore.kernel.org/netdev/20241022172153.217890-1-jdamato@fastly.com/T/#u

