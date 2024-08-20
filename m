Return-Path: <linux-kernel+bounces-294673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF82959139
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7FE8284BB7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877711C824D;
	Tue, 20 Aug 2024 23:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s7BnA2wl"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA214A4F0
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724196777; cv=none; b=ftcow2NyswUWgbDdWrDrhHign6KZDGZlSMAh+btz5tN9SUg4w+xnV7xQ4MAJt3sKpPiyomniiAhImhseirmzB0ulDUZ2ukqC9P3I7VzXQZZE9r373owo3PYGT8Cz/okkEhbJiVmI3k2K8sEDnYIKdoTRLvuOrATaFNSwaC+qtyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724196777; c=relaxed/simple;
	bh=7Z5LeSU2q+pvGqj3g/BFZtbVg+1PwhQhunU7FBnwMHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9MKTDophBF+8t3jW+1ts49RKLFVBtO+Kk+QT6EF93YWRRlp06G1L8i0KvH3YAiHqru9sqgbqR4Hg3Y3UzN1zl2ZxTW3Q1IgSET7081KFb9TqpTAeGdGO3yJAgjmCraYNpxmr+no27iyyfF22/u7WKOlOZ/nLZAggR8Wp/cCkwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s7BnA2wl; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 Aug 2024 19:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724196773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Z5LeSU2q+pvGqj3g/BFZtbVg+1PwhQhunU7FBnwMHE=;
	b=s7BnA2wlhhq1cIpNOvWBWn6YwWrtc1jZ29bmGcRKLoqJzVhhID9kJSyoG/lz/kna308qc2
	+BmSKvKhRFEUYHsroB+w4xaIkiFIkNrNVQsIi9tq+//xgnRbMNILR1C+5oinNnhcwo3ND7
	JsKTym3KRP/1iDf4adO3tjFhWKOofGg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+7e9efdfec27fbde0141d@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] WARNING in bch2_write_super
Message-ID: <slqmzqevvgpdzvtcferxf45mzfj4rvk4g6fr74styt3csdk3z3@dayd7ytn5jac>
References: <0000000000000b533e062024e702@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000000b533e062024e702@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Fix locking in bch2_ioc_setlabel()

