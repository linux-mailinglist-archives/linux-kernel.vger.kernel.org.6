Return-Path: <linux-kernel+bounces-577329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F545A71B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628F63B674B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7DF1F5428;
	Wed, 26 Mar 2025 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GSoYnput"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21A81EB5DD
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743005888; cv=none; b=LynjUj34Lcyeu+xB3q+CgglZsCOBxUMVNdIRl8jXZdjmlQeFX+OEiPSIGWx7C/zEj83V/gVSd6Sb+n4SzYgMX/YayWv2ohwNvV/KQuT+RxX71bJwOlTUZlkLiHdMRbM59g3n4J7yxpn/8Y1ZSRoOu0a3IIzUiVJHc1Tas48cO5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743005888; c=relaxed/simple;
	bh=ofP62jXvBIqAWzWviTNCbSn41MACM6sOf1GC1vNYNR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iT5dxbT371nkSpWQnr1evEANGlvV8KzHgMUKd64BMnEyzNhKTcg6Ce10T/WE/UHtWVV/nSTlqhOo7B4/h0/svQ52kJpsJU9ZgEg/6K1PhpDkqwHGmR8HT/tbGPW1T/PQ2Ew5PiiJP+b5Hn3FrSpDRgYv0nGLC0z5pqVv65qA6kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GSoYnput; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Mar 2025 12:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743005874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8j2vw7QjUbZln+KhxU2q51f1/Vi5QWt5LCZG2SQyQhc=;
	b=GSoYnput23BCDTjyJjM3MqjCtBm+2shfO+gy5phrERaIjJOYOW44aYxDzadqpjMY6qjAID
	j+pjMA0G7vSRllMl99Djsm+09LgA968lV81iPkiEtyyUwo25AxFCNK5/pbEEebDi3d83gP
	n1tyvvzhcbvGGqdG2lakaO39gyjMloU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Cc: Roxana Nicolescu <nicolescu.roxana@protonmail.com>, 
	Alan Huang <mmpgouride@gmail.com>, linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] bcachefs: replace deprecated strncpy() with strscpy()
Message-ID: <vfszytfd66lqj54nmkymhnrdjodylb7l3alxblzixnlzv7kxom@4dji3xuvmknj>
References: <20250326094449.16473-1-nicolescu.roxana@protonmail.com>
 <5F3AB2BC-43DA-47A6-A07A-72540B327D11@gmail.com>
 <bmjvipermsvb454mdh5zmlmw4gv4oub5fgh4eowedlit75gqei@3or3va3e52ce>
 <MnHJR6KH9EcCqnLtdxKf3XYBSQQbvXWJafG28O2C2itnS_eETVFoDMfVvFva3dkLMZ-LPRWUhG2g_5HBY_lPZkWOYW2aOg_T4YWTrzXmVZ0=@protonmail.com>
 <wdagx2vwyv7s2t2tcndwmambwdhmoitvhmnzcopdl3xkfq6ct2@evmzpxnuhi4e>
 <CAPZ5DTF+Q_-10xF915wF3b3aUm5jqZepqoyivF+G4S6ONf_PcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPZ5DTF+Q_-10xF915wF3b3aUm5jqZepqoyivF+G4S6ONf_PcQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 26, 2025 at 09:19:06PM +0530, Bharadwaj Raju wrote:
> On Wed, Mar 26, 2025 at 8:22 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> > Or better, a new helper: when we're copying to a fixed size buffer we
> > really want to zero out the rest of the buffer - we don't just want a
> > single terminating nul.
> 
> I believe strscpy_pad does this?
> 
> https://docs.kernel.org/core-api/kernel-api.html#c.strscpy_pad

almost, we don't want the 'required nul termination'; that's a
requirement at least for disk labels where we need to preserve existing
behaviour

