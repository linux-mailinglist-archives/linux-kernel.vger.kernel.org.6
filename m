Return-Path: <linux-kernel+bounces-376163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4CA9AA104
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D281F241E8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F81E19C547;
	Tue, 22 Oct 2024 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PXccPCRC"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600B419B5B4
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729595807; cv=none; b=fuQMns0LK8chy7y/A4eGUYRudoUfcysNgRJh5FPCOxcAUP9RPPgb0dmAVl8Px6OxuCAzRwc/vqjCBHHLNOPlMIKCfLwHPpUFx1Futbi5zHkzWDprRLi7PdBIrgI3d4Hb5Bkn/ouG4Pm7nbebTq2bD7MJefRBP6XVtW0jKUTDTQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729595807; c=relaxed/simple;
	bh=ndKt0N0mM10ySkShtmyv0gB8Qnxy/SbRI9DGvcILxhA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l6a3+6mzqkYC7PFB9RCeJhwatxPYDO16J/CDVAShiuirn1WgbRi2K469khU7bIEBUnyP81MxH240rzicPTX/gMHqIIstbhqTycO8J+nnSkEDoLclDLc9+kr8B1ks8kYkGd/cQUaDgJchhc1fahxK9LqxBLMUvpwIMGpjzNIIE6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PXccPCRC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=ndKt0N0mM10ySkShtmyv0gB8Qnxy/SbRI9DGvcILxhA=; b=PXccPCRCxIghE/T0TDKTJ4u2Hp
	/s4PaAcScJVaswYLT237RxfDwDeUTjWVr/ZPf2G5b2vzbYUKDDziNAxUMBmgX+hzYL55BykU3eY5z
	B0Xm4DlT+1vSgmyr8w9fmn8WGR6VE9eCzohBE+nYu4HRcj1rXbGW/UkmHej0eWJknTpnDVhAiaa9s
	PI1H7SiNUieyFPWYFSQxhFRicgZpDtp03rvv4LR+mTzICsIeyGg5RExYKogl/LNGivxSSvhmKlks+
	s3d2AlllXtWFQTKqUIVY+Z/bofYzd8bDhyEgkVLxxaDMqwZjjzTj7Cz8kVnR/+VEoyXNI/0xtY4fc
	Y6mTGfGA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3CsQ-00000001YuC-1a7b;
	Tue, 22 Oct 2024 11:16:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 15CA030073F; Tue, 22 Oct 2024 13:16:38 +0200 (CEST)
Date: Tue, 22 Oct 2024 13:16:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: andrii@kernel.org, yhs@fb.com, jolsa@kernel.org,
	linux-kernel@vger.kernel.org
Cc: daniel@iogearbox.net, sean@mess.org
Subject: perf_event_detach_bpf_prog() broken?
Message-ID: <20241022111638.GC16066@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi guys,

Per commit 170a7e3ea070 ("bpf: bpf_prog_array_copy() should return
-ENOENT if exclude_prog not found") perf_event_detach_bpf_prog() can now
return without doing bpf_prog_put() and leaving event->prog set.

This is very 'unexpected' behaviour.

I'm not sure what's sane from the BPF side of things here, but leaving
event->prog set is really rather unexpected.

Help?

