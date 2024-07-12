Return-Path: <linux-kernel+bounces-251018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CAB92FFD9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02F11C213E4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6872F176AC0;
	Fri, 12 Jul 2024 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VAVrclNd"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3C643AA9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720805793; cv=none; b=u7s69HXIgQIqIP2wKSwxwcRT8JG0zfxesoJyayG6LbBynXTjuiRoPRXOblAwcUmiUk5KNOYpjmB6l8169oJIlHEgtbv6dDwDqZuUX0C29V/roLyhw6PUXPlKm+wnf1M5Gct/TH6bpJ/XFLhA4aA8sHuEA9tEzgk+Ix+2Xv/gpJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720805793; c=relaxed/simple;
	bh=xLbQ4mnm8CR1dmzKoOiWpU/it/H1a9K8mlW2KpsBTAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wm/xgPIx78ImfJo/me8Z/8b92wG/bqbA5rymXsluZe+SSSG8ZoiHofcqOOdBiGnjheI8zfcegNsKvj3xkgVoaqRKeDAyIm0e13aMIfiEzr6C/DIAzD6CDT3RLSQtTB6i4BqDpwP3K1JTSRWFr+eEdgut6Bgj7+cVY5LEJ7tEDwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VAVrclNd; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: syzbot+e74fea078710bbca6f4b@syzkaller.appspotmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720805788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xLbQ4mnm8CR1dmzKoOiWpU/it/H1a9K8mlW2KpsBTAo=;
	b=VAVrclNdl0WCja/GYZVHtmL+NIgXSOq5xzIlh+h+8O5r7m3+KRO2ewJKyJ4fMtIydcpGLM
	cvCqnQ3LmazbRDDgsvcRH4o0kLYnyyig3vGROvHyek8goJ85UmqZGNJ/y4USMnsO4BzLIv
	8zc/VJRHpitoCqdaP+kwqUEVRapTMyA=
X-Envelope-To: bfoster@redhat.com
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: syzkaller-bugs@googlegroups.com
Date: Fri, 12 Jul 2024 13:36:23 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+e74fea078710bbca6f4b@syzkaller.appspotmail.com>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] WARNING: suspicious RCU usage in
 bch2_bucket_ref_update
Message-ID: <vh6oaa4iwehrlxvkmfbsbzfwces6iv3hfbih5axldnxe7f2mv5@tdoyjkmxijvh>
References: <000000000000ee4d7c061cd1c21f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ee4d7c061cd1c21f@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Fix RCU splat

