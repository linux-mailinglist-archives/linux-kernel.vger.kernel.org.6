Return-Path: <linux-kernel+bounces-526538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F00EDA3FFFC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC933AE177
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C67E25291F;
	Fri, 21 Feb 2025 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Ewl2gdGZ"
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051AD25291E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740167166; cv=none; b=Y2XfIbbAPonSdOGEiOHmbn5MUhQazsPIvUs/awUTf/sV0as9vCK8G6AJK7huIJFwuMoyD17yOAx5QU0yT4oJJLFSIbE3Ox0wmH1y07uW59xZ5eZYGDgW6sYPnye3dJJfJn/kB6AdjOq/EMfEUCLEYd2wbiqR8G2RzGTzHKovQr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740167166; c=relaxed/simple;
	bh=Qe8yglpOVRl08XDC6oKRGtJ6QXAw8XWVocSPl5/Xr4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcL8X/JwadbSidpBm3IHtCKJHGBpW0QEoYB+VPtSLMsIcpgzAsW6DEkPllbv0CEuM7jwFvmlP8mVHq5cl8Sva/KHorIyPNJOArpp29zLEEiuZuy7xq0pbnMH+j+nhUReUv/ggTZBL5vyYd9l7OEgPa8hoz14jgDZamHsiF04U8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Ewl2gdGZ; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-220d132f16dso40925815ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740167164; x=1740771964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qe8yglpOVRl08XDC6oKRGtJ6QXAw8XWVocSPl5/Xr4g=;
        b=Ewl2gdGZqUnw+1NGxfN9LFXUi/jnRhe6kbiReEtsGi8aUUe97RrDO8ixR8GSL9hEqU
         IkD/jMKWng8UIUEiD46a8jzaNdsMAhxuS90sc9fEli64C0s53Mh631xZOmn9kUlhag+5
         Mc9zdUtG/kDorSNTItki/BIyuJ+8wSvshCjzMgv732qTvWboIzwsYZaUdTNsN5bMGFly
         pQndzMBfmJDRVWTP366HHkf9xC6WNZBEUdIV9QtraPiycEtVGGJJf0nxa+dt3tQwLZAX
         J7+aUWBh+P2+2Bsl0UGAKn+jKVGBSaHsQtwiFqwm2Kp650L35hZgzTZrjVlsF+zVWGeO
         xizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740167164; x=1740771964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qe8yglpOVRl08XDC6oKRGtJ6QXAw8XWVocSPl5/Xr4g=;
        b=jsICsWqo6GA8julXv8EQfb+UIzP/ql7Maj3E/og4rMN80Srt03yMHRvbft0uTIv6Pz
         AiwnHxoYZyz/VPOICjqXWVV5VnnNjppgTKkoq6vbsnqAJxnYIVIX0/ztamHvY/OBl0pD
         zGmrezUPh7/d6zfbd6i1na6TqZoiEJnXs2Ti+/mbCUhkxTJZ0V7KzESPS8Cnuzu5XVz4
         4AzwXVXrQv9tNu1rUcpA4+qFGPB9SRMAX2SaP9GvF3U0I/NS4msFOTgcAJYOSQzkDHir
         zOQU0naokUVsTHRoW5hXyDVBUBkYp6AOyAILUjxb3tJlo3wLrzc9PbbkSBLtXvSOdne9
         clsg==
X-Forwarded-Encrypted: i=1; AJvYcCUafr/wlAxuW3jJivelkbkrtqrjb0c2o90Ifx1WxXzwqK/OKRpCxNK3L5XplJbbeGxycDOe/Rm6/UPgVBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwBi1o6ntzn+krRm4tfE3EZM8zCPmTZwgPOnuzeVuitpFF16KD
	H3RUzcgRk15j41SGSx54TOPGh8EAPF0xEoFwkFeC9LhLscyy29ECt/5dwDXZvvyidOZZPB4Lweo
	tPdnzOtw4PSndU/V5V2Dfw8aATiQaKIrK
X-Gm-Gg: ASbGnctJtWXmckYFfKYicIv9COVAYuoblt+RWvUy4ZfRA8ixk8hIXe+QoMc5FCmSf+1
	tcHV1uAMJrqevEWP9+vv72SZMb5xGK7Y014HxMp9IcBT6MRplqhWo6NGyf9Y0Nq2NCWp5CgUbLj
	k5Co62XcDNqKTCgfjFcaFfCxpvoMlkTeULLOqfExp+50GKMOl25687Q5pFW+1MM+Jwo9zjTAMC2
	z4cDDCHkRxSmiPSVsOg+y3YySMo40+VsHLnNlUOgIOh9h3uSNJgCAzXb1yL7L0PX/c+3/QiF9t3
	FdDpbYf73yFoccJwnvuIOJEAMJDN8fJyNrunSSgrdpQYlfNahg==
X-Google-Smtp-Source: AGHT+IE99U6jlftn3nPn0N6zw6A91ELHQp6V/gmyF5loNHs5o/JogzFMPNpAfsJgR8a+p2Gm7+cQJsAVNGtn
X-Received: by 2002:a17:902:8686:b0:220:ff3f:6ccb with SMTP id d9443c01a7336-2219ffd3251mr58361775ad.42.1740167164247;
        Fri, 21 Feb 2025 11:46:04 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-220d5431e51sm9073475ad.116.2025.02.21.11.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 11:46:04 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6B312340216;
	Fri, 21 Feb 2025 12:46:03 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 60ECCE56BF4; Fri, 21 Feb 2025 12:46:03 -0700 (MST)
Date: Fri, 21 Feb 2025 12:46:03 -0700
From: Uday Shankar <ushankar@purestorage.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Simon Horman <horms@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH net-next v5 1/2] net, treewide: define and use
 MAC_ADDR_STR_LEN
Message-ID: <Z7jX+z/Ucq5iu5bS@dev-ushankar.dev.purestorage.com>
References: <20250220-netconsole-v5-0-4aeafa71debf@purestorage.com>
 <20250220-netconsole-v5-1-4aeafa71debf@purestorage.com>
 <20250221131750.0630c720@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221131750.0630c720@pumpkin>

On Fri, Feb 21, 2025 at 01:17:50PM +0000, David Laight wrote:
> The fact that you have to keep adding 1 or 2 is a good indication that
> it really isn't a good idea.

Having to adjust by 1 when converting between string lengths and buffer
sizes is super standard in C since strings are NUL-terminated. There are
tons of preexisting examples in the tree.

I agree that the + 2 is a bit of an eyesore but its needed in that case
because that code wants to tack on a newline in addition to a
NUL-terminator. Maybe adding a comment there would help?

In any case, MAC_ADDR_STR_LEN is a much more descriptive name for what
all the changed code is actually doing compared against 3 * ETH_ALEN -
1.


