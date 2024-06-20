Return-Path: <linux-kernel+bounces-223690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C962C9116FE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 01:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F69F1F21909
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F4E14D45A;
	Thu, 20 Jun 2024 23:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mmh1XHes"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859EA1459F2
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 23:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718927040; cv=none; b=e1H0TKUQS8OJPYbtEwKWV3dhV6SXugzpfDo0ZXEFx8NiyJGD6SVqYOa0KCc9b2KdQ1k7LK8CpT06mJC85l00VlzIkGPWjyaBVjlQ9hRkQ2GRcFn1b53JZcihM7TQSjdrxpMvdKmg7Kp/TF1LLybJGGLXmI2fKSgv+DaLN6h+xKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718927040; c=relaxed/simple;
	bh=m6vq7fMNbPJ8y49RfcxdJ9XHAaMwQ/nP8IlMPwhiy7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBQFqa/PrtAQM341qMLqjE0Zj9mAlYf/0NKVb/UEouGJWs9fiJbabSVrBdt0Avrf+PiFiHYC/CRPIZ3aPUX4jVYsoQUEtFeTKzo9aA44qun7RBn0kZRB/Dci6yIEFwVQ03XunbT7yMzZrea14wbscrKfVAK8BZuYPJuu37Gd4fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mmh1XHes; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: syzbot+8992fc10a192067b8d8a@syzkaller.appspotmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718927036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m6vq7fMNbPJ8y49RfcxdJ9XHAaMwQ/nP8IlMPwhiy7o=;
	b=Mmh1XHesQifgS91BCVHa3GlWWJQRpOszPdw/wgvlAEYm6xq6bSO6MAxZJsOUdp1XwwFBnh
	kiJ6qr2dmXOnrXci1El0Y98ZjBig3LwmDD2SrGNDrHj08ud1/sNS1qO/kEyoKixGvjyEcr
	i1XByYncCl4wuIz9gxxwvm3f5laLLP0=
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: syzkaller-bugs@googlegroups.com
Date: Thu, 20 Jun 2024 19:43:52 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+8992fc10a192067b8d8a@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-use-after-free Read in
 bch2_fs_recovery
Message-ID: <udyg4sx7bwsbtaj2nfnkvqtgdhprdymdpghelimpnxcft3scnd@c3ccejbtq5ze>
References: <00000000000090adbc061b5acfd9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000090adbc061b5acfd9@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Fix a UAF after write_super()

