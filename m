Return-Path: <linux-kernel+bounces-379105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D9E9AD9FB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 04:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9449C1C217D3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 02:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9BF13DBBC;
	Thu, 24 Oct 2024 02:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w4/iCes9"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E5C442F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 02:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729737475; cv=none; b=RvnSChzxXuXs08DgoVCl+EvD58tTbXkN+PnOj8F7ayAYktrjtxVqkpOI0lxODe4+va87Mimppif1Dt1EtUBMAhtz4KkDK05jYjdu7XoKFnqH3Wrg/hcxOhAzFbxxk7mEkldcQRE6LCqgIGlxqvH2W16dVob8uOJ+LWXRbW9yZDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729737475; c=relaxed/simple;
	bh=dYG2T+EMlbUYv0xUeVXUCJLnlO3zS+S1ghfZsv4XnYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3yGI+FwJP4dVhfPo7umkpRVYBA4dvdG7jQPGueumd7iHRsonwIxsedlBI4vcByAlSuYuz1lwKp/WpS/0d9VqKpJdmMPNsItcYVVfQMl+XC6KiKhuxQQgoWG4amW2QhNl6QPno6ppO3uOWKSJh9+QPBF8Z4iXdXKh5V3rJ6iOs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w4/iCes9; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 23 Oct 2024 22:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729737470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sXvm5QJgql3sbI3Zbv4p18wErlYFI2WN7u8mYBrO2mA=;
	b=w4/iCes9nlavwo81toFawsqACqtlVuvnDCPgH5sVSAmfw1qZL/BofAUB9bGSkO02LHJe7G
	9OrdwdHbFhUXARVvivTNN+SIZiuTFBfwOoBiqGCYD71vasfG5RbXZAKbm9bOsT7k5Dxyb6
	Mjpes2n2TnBbkvyrQoZDXET0DuGUntg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Jeongjun Park <aha310510@gmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+b468b9fef56949c3b528@syzkaller.appspotmail.com
Subject: Re: [PATCH] bcachefs: fix null-ptr-deref in have_stripes()
Message-ID: <mu3tb4xb466rbfvnqkd7dwitbxqdkpf26oitf6lvn4j2kubpgf@evsyze7an3xd>
References: <20241023161345.80029-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023161345.80029-1-aha310510@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 24, 2024 at 01:13:45AM +0900, Jeongjun Park wrote:
> c->btree_roots_known[i].b can be NULL. In this case, a NULL pointer dereference
> occurs, so you need to add code to check the variable.
> 
> Reported-by: syzbot+b468b9fef56949c3b528@syzkaller.appspotmail.com
> Fixes: ("bcachefs: metadata version bucket_stripe_sectors")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>

Thanks, applied

