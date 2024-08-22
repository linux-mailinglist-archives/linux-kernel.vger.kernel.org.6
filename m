Return-Path: <linux-kernel+bounces-296540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF1395ABDD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 05:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E66B1C22C1D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F4345013;
	Thu, 22 Aug 2024 03:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Se1OnH7r"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD0D3B791
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 03:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724297135; cv=none; b=pFSRplotSvKNQjYmDol5d7+NT38+xfpBuT+pfNe+vX9WeJgkQNn1Zon8ZsQH90GtvoK+Z4pnyHXsTiJF1yS71e5c69h4vBPFHd9/DsD+lwQRg6WBI7kB09bj+C13thEg+DCMvSTXnUDU/oxyx7GBxwxTuX4acgEPJvGvfbK0O4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724297135; c=relaxed/simple;
	bh=dwjZgwmFj54iAi2xARnFgrDtlt6YXD0xExJ1qtXX06w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HK/TxGjTMN9klsdLqet/EmfbNE99uarQlxjZOrW+sEtcJrb8t15PHYlJMTV4yijErDN8yZmIYOJLzcAyFpw/SlnU6umsC2u1Ze1X/jAuhglRgphRKVSS1HIj/Cv1GDWtk9zPlevoCWOSExjK2zPBQGLs75x/Wailbp3/NCa95hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Se1OnH7r; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 21 Aug 2024 23:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724297131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dwjZgwmFj54iAi2xARnFgrDtlt6YXD0xExJ1qtXX06w=;
	b=Se1OnH7rAkHKCdDUHul+sV9KiqX4t1EgLJsRBER2dTwexqUIK0GjvC3vreM3QNQvJUAU97
	SrYhIHCmQYJFkKMyiYnpE83W1VnUAPPLXh5sqkLoRx5UfSjJyW9SIf9K+b52aT3aPrGIfp
	fqi5CS8ts4Hw61O4PwgIDMsBJdmXdXo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+9e0404b505e604f67e41@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-use-after-free Read in
 percpu_ref_put
Message-ID: <fmgmxhirocusm3zmnki4m7miyqemwgxyjybjr4wvq7u2xupjyg@qwqjonwarhcl>
References: <000000000000692f33061def2a6d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000692f33061def2a6d@google.com>
X-Migadu-Flow: FLOW_OUT

#syz bcachefs: Fix refcounting in discard path

