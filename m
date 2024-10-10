Return-Path: <linux-kernel+bounces-359375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BA4998AC8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC62A1C24F97
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD071CDA13;
	Thu, 10 Oct 2024 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C0t1okDF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047D41A08B1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572225; cv=none; b=QOsMeb5NnjE9X4skahVRA44WxBTaC41XWbPSYAHiqiEFDat2ZRNStMDpCUiZpljsqMz1Ul0sNyo1hYS7XNn9XzT3RgSmEMl72P+fvhqYAgUv9+nmq5yKTVS/kD1AvlHFezYA0S4ErTcOW+mtympRe9FvSyb+JWZCP2iWI5HC0W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572225; c=relaxed/simple;
	bh=kjpRKuV4tbatVPigY6ekkuGh+sOYIZqQ+15Ct58uO0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXDfpA3pyG4APBRyFWvolTWxqlrnyEIRjYV4ztpsXF64yrpDVarjY9Cm47nZgia+cwTgWsrOBv1s63CEEBewI5D3mAxEPOk7Clgx03PRykXWWmn5SDUjc7JPeD5RcchEn53dQ4Xucusia2RQy4IGeDyDs0hllninZEhSLN3hzi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C0t1okDF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728572222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uqsJZF4Duw5kitMXfbrXj6+7AGTScIlaY/jPn2ZPVH0=;
	b=C0t1okDFfGWdYo3nBkTbm091YJg03mKcxsRvw83pFybO7WpEgcCNTU5wLChQipLqTqoasP
	TC02WnaUM7hGsmjLJGPm0YhOTRAubIj+waJ3b0JRrNOkzgloVT315u88kRs8hLCdeYlywp
	ueFP2trlx4Py1pv5B1M/pLwcMlUvnzw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-ZIIsxh8gMXiFPylbf6Bqcw-1; Thu, 10 Oct 2024 10:56:59 -0400
X-MC-Unique: ZIIsxh8gMXiFPylbf6Bqcw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-71de9e1f419so1525505b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728572218; x=1729177018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqsJZF4Duw5kitMXfbrXj6+7AGTScIlaY/jPn2ZPVH0=;
        b=cF+oO0QKQrhOZoTPQKNX3ayZZxIbeKKVLkFBdy7cbkmKF6kmawc3/s55+wQYHjvhCB
         2O48QlwNhAd3/yZrx2KqOHyVxfyl3iqIWkjncjiuig0jrYcO/IDzREc3lbka5wkennHl
         CBG7STptQ4ExFmphGFA0NtUiypT4OIk4B5MdOhzCP/Mj8TOw7yPx2FSlnH/e9B+c3m8+
         mamODWnm/AwdG6882TU/eQjw9aNMXEn0A9eMpezPhZyB8iDCoH1n6HOsUMl1uJ/54lHH
         Ij+JooWpz5JQyZb7zzcXlnQ/RXhxdHY9ppFymOnqNDRzx0G9zxAvIvxBp9g1MQixiauT
         WQYg==
X-Forwarded-Encrypted: i=1; AJvYcCXkUPcQRzBzjBQy/PjX8Cdprb7iKINo8Xd8CaSMc+JAdsYfY7Y0r526wAE18m4FZdi3M6DBdVB5RjcocZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG5EOejDz6uBb4+di3KS577f2iqtlxucNprXUe1WU4JwdJPPMS
	0bPwQpeOErwju6Ur1tp69AXpoozdywTZMcyqxPgmx513SUgC9lpZxOVFSd+m1NxzHRl3RhlaRvI
	D3FQnWktrD7Lkj4/2n1IyEt+aMwd9jXnxq3PjOIaEH5DUgLIOaVf4crK1ycXRjw==
X-Received: by 2002:a05:6a21:a4c1:b0:1cf:6d20:4d6 with SMTP id adf61e73a8af0-1d8a3c1088amr11721943637.16.1728572218364;
        Thu, 10 Oct 2024 07:56:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPPvmwZ/YduupyNpk21Spus57YB705giTluFgtwLzXlLYwFIh7b+1sMUWImV8Y4NTmi+cywA==
X-Received: by 2002:a05:6a21:a4c1:b0:1cf:6d20:4d6 with SMTP id adf61e73a8af0-1d8a3c1088amr11721918637.16.1728572218032;
        Thu, 10 Oct 2024 07:56:58 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9f4f35sm1111401b3a.47.2024.10.10.07.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 07:56:57 -0700 (PDT)
Date: Thu, 10 Oct 2024 09:56:53 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Keerthy <j-keerthy@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
	Eric Chanudet <echanude@redhat.com>, Enric Balletbo <eballetb@redhat.com>, 
	Udit Kumar <u-kumar1@ti.com>, Beleswar Prasad Padhi <b-padhi@ti.com>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] arm64: dts: ti: k3-j784s4: Mark tps659413
 regulators as bootph-all
Message-ID: <wl6ri2djky2rkfuaj6hhotzgie6el7leno2qupze6geshp6j4i@g7q5a2rt2cmr>
References: <20240916-j784s4-tps6594-bootph-v3-0-ab70da0de7bd@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916-j784s4-tps6594-bootph-v3-0-ab70da0de7bd@redhat.com>

On Mon, Sep 16, 2024 at 12:14:50PM GMT, Andrew Halaney wrote:
> This series marks tps659413's regulators as bootph-all in order for
> the nodes (and parent nodes) to be accessible during MCU's u-boot SPL.
> 
> This in turn is desired since the tps659413 needs its MCU ESM
> state machine setup in order for the watchdog to reset the board.
> 
> This took me a little while to track down, as enabling the ESM, TPS6594,
> etc in u-boot would result in the below boot failure:
> 
>     U-Boot SPL 2024.10-rc4-00007-g44b12cbcd1b3-dirty (Sep 06 2024 - 14:25:52 -0500)
>     SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.4--v09.02.04 (Kool Koala)')
>     Initialized 4 DRAM controllers
>     SPL initial stack usage: 13408 bytes
>     ### ERROR ### Please RESET the board ###
> 
> Which turns out to actually have failed far earlier in spl_early_init(),
> due to these nodes not being accessible in u-boot. That's hard to tell
> though since console isn't setup until later (and for that reason I
> think spl_early_init()'s return value in j784s4_init.c isn't
> evaluated since a panic() at that point would leave a user with *no*
> information at all).
> 
> I've tested this in conjunction with a u-boot series which I'll link in
> a follow-up response on the k3-j784s4-evm. I'd appreciate someone testing
> on the k3-am69-sk at a minimum, as it should suffer the same fate if things
> aren't setup appropriately.
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
> Changes in v3:
> - Added Udit's Tested-by tags
> - Reordered bootph-all to align with dts-coding-style (Beleswar)
> - Link to v2: https://lore.kernel.org/r/20240911-j784s4-tps6594-bootph-v2-0-a83526264ab1@redhat.com

This applies fine still on linux-next, any chance this could be picked
up?

The associated[0] u-boot change is dependent on this and it would be
nice to get the wdog working on mainline u-boot + linux.

[0] https://lore.kernel.org/all/3bf2177d-178f-46bf-abfe-6f00a52c623b@ti.com/


