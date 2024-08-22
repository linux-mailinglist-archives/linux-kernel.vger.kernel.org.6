Return-Path: <linux-kernel+bounces-296596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9446E95AC97
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FBB82835EF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 04:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34CD3D38E;
	Thu, 22 Aug 2024 04:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UMjTRSvS"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081F113AF2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 04:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724300960; cv=none; b=YHP0T/r1fRTqKXv6nj6ViMElZ+mUzkUHsLwVBLOHkaB6XdQ6o/Z6JoFaB0TcE46CTH/ZlEzZPYtSk++R5MBfYYnIpPqdHN6qsCuleTYtmVQmcHHd5XpHEQGlX7Y2w9lVjx1ZnR45bu0uAV+3005vVUCzVXFxGtR0N5ti/Jwo/HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724300960; c=relaxed/simple;
	bh=VBVn1UNVB9UR9KxUA0zU5lBMMkeFmjLunVz7PUtOHKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVDiuskcN9r0Pxl3hhyP5g66A9BEQOZFtvvaAapWxt/Yg1CmExtJo+DBxsjJ/MYm4WyQ1x3xnmmDvziKbvsiFwPCzoyq5nyr8GZkizFiGHCwVS061Gx4OMqWZ0pctxBJaVQiRFgSqRzgnuuOpICQ6juXWIodvB9Z0+yv57MTRj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UMjTRSvS; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 22 Aug 2024 00:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724300956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VBVn1UNVB9UR9KxUA0zU5lBMMkeFmjLunVz7PUtOHKE=;
	b=UMjTRSvS1xKGJE6oAjaxj2RN5TaRex/j6gcyMvgMSs4R3i1jnFEvArCOP4kieMbrF5NNbD
	SnDwsJA9LeAgH1fhjvlg8qNlhrsMcGBGgUPg+v8JWTa5ipLKUImBusRobzaedIiWvNfiGR
	en6JaVqcqZzNMvpbQVA6om82NEraurQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+46405fa9afa07e6c8c40@syzkaller.appspotmail.com>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] BUG: MAX_LOCK_DEPTH too low! (4)
Message-ID: <wyilin4upo2najlktypsy2seqkass7y6vewjdkf743pzndyu6d@yrw6nlqqkyv7>
References: <000000000000071b6f0617ec3c17@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000071b6f0617ec3c17@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Add lockdep support for btree node locks

