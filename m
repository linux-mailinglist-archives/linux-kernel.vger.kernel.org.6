Return-Path: <linux-kernel+bounces-398685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 704A89BF4A9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E8A1C2337C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDE320408D;
	Wed,  6 Nov 2024 17:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nVTr1xfu"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E3C207218
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730915586; cv=none; b=u8iCg5NfkYnynaSaTcQrbJG2YEqhs1Y7sECATa0rpZzzgme//kY7tnpdKMjT4JtyRDOHkivtJLim8xGGdydrx8NxFRO23GzzkQUNTemZPUrz1LVci6Q0dOrO5rPCjjpo6w6KHrPKMNqmrJfTEH0Cz0/28iywHgZTGJRbHIgVj9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730915586; c=relaxed/simple;
	bh=KC79F8AAKN9zqsEsq8PEeOTMFX475VCxxZ6E4T2vDxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zi5iCqxIP8K73yliWM9w3teUk5M1WFLmZYZ/SPWPZyIskTcE9GnWgMjGq2YOurZJ83zFN0Ny8mqprAzEjBJLjurlsiMl7giYDjWu8NCODq1dGwgHhWhmUPmnSIlbRLUSKGmZpX3ShpVq1eW+SySr8GklXZESQyJcHDm9DDk+eMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nVTr1xfu; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 6 Nov 2024 12:52:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730915581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QRUJHFqF+m0efCjGnDS9+jrRg248YsINL1Mb2R1+v28=;
	b=nVTr1xfu8w6uQJeTqK9x2ouT757pOCHXirpVgAkH/sc7TXR7+0wgV5PAH5eV7X5R6MwAqM
	BcCOFGgQjcqbqQvV/6yd0Ixv3+LPnM02BOpeuwNAfs4psecHTRPY1UL8Gyuem77X3zCPIH
	0OBZ4p46ce0Ri4XHLvXgu/RrI9tLPD0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Piotr Zalewski <pZ010001011111@proton.me>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, syzbot+bee87a0c3291c06aa8c6@syzkaller.appspotmail.com
Subject: Re: [PATCH] Fix wrong max check in bch2_opt_validate
Message-ID: <v5wttxaimwpqb5jfpxvcs3rmg27fm4mf7446slutl7ztha6q4p@434ppx3gzv7l>
References: <20241031231823.688918-2-pZ010001011111@proton.me>
 <pkxqQnSTQLReyYEHegx90LNp5dbR6LlpcqUIkBFa2CiL-0P48QWpGJ1YYKtWwu0IFM7H-2T4fYQz0MldP6OqZppPzmqafQDKouhETLnM5o4=@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pkxqQnSTQLReyYEHegx90LNp5dbR6LlpcqUIkBFa2CiL-0P48QWpGJ1YYKtWwu0IFM7H-2T4fYQz0MldP6OqZppPzmqafQDKouhETLnM5o4=@proton.me>
X-Migadu-Flow: FLOW_OUT

On Wed, Nov 06, 2024 at 08:11:13AM +0000, Piotr Zalewski wrote:
> Hi Kent,
> 
> Did you see this?

Whoops, I did miss it the first time.

I think it'd be better to fix it in the OPT_STR() macro though.

