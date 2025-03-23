Return-Path: <linux-kernel+bounces-573006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E09CEA6D167
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6572E16EDFF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71B31ACED1;
	Sun, 23 Mar 2025 22:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="JDUR9PGO"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683C53D561
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 22:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742768562; cv=none; b=FWQON9eyRWjngulHfkAbS8oj+MMUULnQKOcICeav+i9nOI6D8pocPNGyyeO0s86CugWYcl9dM+MM7i6PCOyX6sXYZwIW9uX+DaTtBntfhMGWMywYpCcBXOQVn5ANvWlOPEnEocz39/0y9BGHXrfpiCAFUEWChUnVyOHctQTCYxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742768562; c=relaxed/simple;
	bh=UaDSzJEFU3HxiKYeBIN3vLKun7CzCFd06gaVh2Rjc1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJ6QJgqnEa4fMIWCWFe4eJlIbdoKS8v4p4QqgMnquStX9K65mXPEuzkTeBTqXQRprvmQSCqMRKG4XczBqrn77u3COuflBxgo3Oe9z4v5AFCkbOUfmr87gG1nuHQA207YZnTsn/djZR/Af8kXpl7cgqIFLXV2zd0CZ1HB+X2aEtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=JDUR9PGO; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Sun, 23 Mar 2025 18:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1742768548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jBdt6K+1FRRtxV1RM4zhQcREKVKV+utbOhrg0IIMgak=;
	b=JDUR9PGOmfNe81ydDTGeaPgibvwP+SUVdVLswyyJwxIz2iVH8XXxHPVGYF2LC/pY45mjzF
	PRpvDOQUvJ92PMV32TRGuW9xbOELBG6MGwDpMNq5uyxAUgAP2TEoh0sSBPRgbve6ImHre1
	1eKqPR/gkbftnMQ+vixiX7QzCCfCkypI88USsZ/2351OLZSNat8cu+/I5oqvl0Bo3JStWn
	+RmDK83Pu2Qywy+7pzss7KwJVDVBWdLCYI4/pmycEN5RzH6/An/O/LdaxhxQtoxDWyJqDo
	bixjdLUYkrjfUCbZdyfX4h/WASPJHOMW6d1s20h5dyAxhZpnpenFdoweKMBh0Q==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Faith Ekstrand <faith.ekstrand@collabora.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?=22Bj=F6rn_Roy_Baron=22?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Sergio Lopez Pascual <slp@sinrega.org>,
	Ryan Houdek <sonicadvance1@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	asahi <asahi@lists.linux.dev>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-doc <linux-doc@vger.kernel.org>,
	Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH v3] drm: Add UAPI for the Asahi driver
Message-ID: <Z-CJmw9BKteSj1Qx@blossom>
References: <20250314-agx-uapi-v3-1-3abf7e74ea2f@rosenzweig.io>
 <195b507d4b3.b25d0dad175771.7566427576910952468@collabora.com>
 <195b582682b.121ba4d5e219032.3109114844776468245@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <195b582682b.121ba4d5e219032.3109114844776468245@collabora.com>
X-Migadu-Flow: FLOW_OUT

>  >  > +    /** 
>  >  > +     * @user_timestamp_frequency_hz: Timebase frequency for user timestamps 
>  >  > +     */ 
>  >  > +    __u64 user_timestamp_frequency_hz; 
>  >  
>  > Why is this different? What are user timestamps and how are they different from GPU timestamps? 

In v4, I've made get_time return nanos which should clarify things.
(Since it hides the SoC clock rate from userspace, leaving only the GPU
firmware clock rate and nanoseconds as the two time rates to worry
about.)

