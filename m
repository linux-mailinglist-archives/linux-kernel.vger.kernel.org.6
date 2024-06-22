Return-Path: <linux-kernel+bounces-225855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0511913620
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 23:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9C51C214D9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 21:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6325BACF;
	Sat, 22 Jun 2024 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i8Tic4gF"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F9C3BBF6
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 21:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719091416; cv=none; b=QW2LiHFZq/Fhk3QpdV6QZLicsidfBxSrfm7enxo4tDEtCHzYtquomzsdf24GY1bKpCwg/Rk7NFpLfjgo/ZH8twqTBsg65Nj6PVBtP+UPWSabrds1R1HmjGpkVPk+rmbm7MRptCYzmH2UklPG4LLSPvNrNCnl6+rf+rztCEsUR44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719091416; c=relaxed/simple;
	bh=UFV+r/FdDgjmW/Bs3itLM9/eqc9N3lhVHlLcntS/llo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMoN8TOb4hfhD87AF6fhU88LTx6X4WY/JnPYCNHbX3vabYE0uPNOMYLgF3AYTGYzT1lNTt7RW6jGP5EwqlQA0XyvgyKZIcoMp9gZez2AXsbfjULdhF43qXX71rEYCifJNIm4u9EadIUZ2//5fZn5ijRpG8Ck7rU5o75osB6f47w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i8Tic4gF; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: syzbot+ad60312dc46671a69480@syzkaller.appspotmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719091411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UFV+r/FdDgjmW/Bs3itLM9/eqc9N3lhVHlLcntS/llo=;
	b=i8Tic4gFZr4ge9c/KmD1Kbu85leejf0lLwal5ZVUvlqH28ZmNFyU0a4vlv44rWA9Z63bGt
	wg+JavM/Ua+kWQD2wEBaa/EA6oiC/WeV+nQdQ/N8d+JAQ3WsRzjkem9VfLJM+KVU77K7tk
	TOCmiVDbN8DCmy75ohyjbQX6pU+Jmkc=
X-Envelope-To: bfoster@redhat.com
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: syzkaller-bugs@googlegroups.com
Date: Sat, 22 Jun 2024 17:23:26 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+ad60312dc46671a69480@syzkaller.appspotmail.com>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_ioctl_fsck_online
Message-ID: <dqc3qdllll7xcvsc3k7fpwumigi5dg77zxzdd6aq7hg3vshpe6@clcu2hyaz2n3>
References: <0000000000009fb1e2061b802aea@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000009fb1e2061b802aea@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Fix freeing of error pointers

