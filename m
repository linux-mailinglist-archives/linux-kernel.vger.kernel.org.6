Return-Path: <linux-kernel+bounces-297702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA7B95BCA4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738541F23847
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158601CE71B;
	Thu, 22 Aug 2024 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QCqeK03I"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA46B2C190
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346144; cv=none; b=MIRhaHcT/ZrJfO2aEGPtLrXmPR4ozoWjeHPSekW9NU4npfSePhkHSw5nAHlMS7wtozAAnZvaaT1Um/rRKQ//0g83aQBaGEves/74Y9Zgyq3q4/4oeKx6qJ7HqnsbkxrFzPf8fh5CQnTM0xUp33eBQENqHB4OQqb+NkyzKGpC66c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346144; c=relaxed/simple;
	bh=qIyac7FRZS17y5NyPP/vvfgIoZ3YGywcMPcNzGHXg3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQocrz8SIjW6OytlNLxkzVl8kJO6DQMU/4ax/1kGQA1bTJSNr+pnlEtGYzWwxLBho0RI1zVL4YL3NRVjFnqD11eEbSC5TEdwY9s2FQqXnXF4418mo5lZqBIUbi/DTLTbAw3hQdu0JJyi75gBd7O/ltRU9kaUB/XmfXAV0BRRIH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QCqeK03I; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 22 Aug 2024 13:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724346136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qIyac7FRZS17y5NyPP/vvfgIoZ3YGywcMPcNzGHXg3s=;
	b=QCqeK03IFwHrJyXxqTBzBJL6kwoP2I9cpIXnTxrWAZAX6jfVMAjA7qOry04CsrJad7BSO8
	0/I11A0TpQy5RvxnDbL1wp6UpW8pS8MmWCj3rbK4fptAiQhVwEGkEKvhKI/4dTaNMLwr99
	Hm9GtoQGIFnKz3SbUHxWzYUX/fLdyB8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+6583a960ba94699a7da6@syzkaller.appspotmail.com>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_bkey_val_invalid
Message-ID: <7uewvrde6szmhrchebb2rmtlrjaujdc5h2vjfycoc3ffd5wjn7@xke7muibwxzc>
References: <000000000000d0a6c8061acd2012@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d0a6c8061acd2012@google.com>
X-Migadu-Flow: FLOW_OUT

#syz invalid

