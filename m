Return-Path: <linux-kernel+bounces-335365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBD697E4A2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 03:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4332D1F210E2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 01:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9FC1FA4;
	Mon, 23 Sep 2024 01:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZYlfTsT0"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD471103
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 01:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727054790; cv=none; b=Qj7YkfFsn7hzj7E+TQUTW6dcJVRYRptegoifPi+QPwbHOk0HR4rrekuqDOSgTlVkVCkbqmnSCb6O4+havxnKKNuiVIzE17qGpob/tF4kgQCN4GaNhbrlSSkvG++iFmi+JiMpkrYcIV2p+3aKi0/yaVqjsXnSUo9qKcmtVajZ/1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727054790; c=relaxed/simple;
	bh=IHz5cUqUcudWMfNkrH+bd1ZBH0jcWAT5LyQ/LnYEX0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qg6EJ67b01bZcUuXE2bH1MTlMGpIqS6BR/iHdw1Q/fs0VZQO2N/HSQ5DCtTdhI4tzKgPLlgPfhxd9rVQVts10PDzjN3fH8NWM0qI/MzBG+qlM/vERzo+NTXPyLFpR7z7H/SAIb774J6v2XqoK7/bkDUtUXMB7L++fOir//WwSGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZYlfTsT0; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 22 Sep 2024 21:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727054785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fVYLckngLZFcrwZoZa53jDL48cy0jMXUCWtgc4tWl3U=;
	b=ZYlfTsT0is/9pypboGTkxKCwzj6yI9i4Y794s6DD5tSpmMEKP5IHCRnZNAJbqBbyE3z/QO
	E+FtR5BZxb1ZZNr7nGEmy3lA0qDkTikS6Ac8yj9RwDc1Abzhn5f3cZ1R23EnrqcOmOkf+P
	qYfytpGiWRP0bNTi+A1+a0XKEtMYIoo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dennis Lam <dennis.lamerice@gmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+24beef64217854da05a4@syzkaller.appspotmail.com
Subject: Re: [PATCH] bcachefs: fix divide by zero error in util.c
Message-ID: <v2go5yn67ca5eivavmkwe62qbyhrynirmq7ipqjfy3kqbf6dgn@5t45szpytylc>
References: <20240922233343.121427-2-dennis.lamerice@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922233343.121427-2-dennis.lamerice@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Sep 22, 2024 at 07:33:44PM GMT, Dennis Lam wrote:
> This patch aims to fix a bug found by syzbot where a crash occurs due to
> a divide by zero error in the bcachefs subsystem [1].
> 
> Bcachefs has a file called util.c that uses the function div_u64 to perform
> division using 64-bit values. The function's parameters uses a 64-bit dividend
> and a 32-bit divisor to perform its division, however sometimes in this file
> a 64-bit divisor is passed using this function. When in use, the 64-bit value
> is passed as a 32-bit value, creating the possibility of a division by zero error.
> 
> Therefore, this fix replaces the function div_u64 with div64_u64 where the
> dividend and divisor is a 64-bit value to perform the correct division.
> 
> [1] https://syzkaller.appspot.com/bug?extid=24beef64217854da05a4
> 
> Reported-and-tested-by: syzbot+24beef64217854da05a4@syzkaller.appspotmail.com
> Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>

We already have this, from Reed Riley

27663d7784b5 bcachefs: Replace div_u64 with div64_u64 where second param is u64

