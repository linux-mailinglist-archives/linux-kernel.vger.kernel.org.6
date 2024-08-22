Return-Path: <linux-kernel+bounces-297701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FE395BCA3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3CC01C23261
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DD61CDFBC;
	Thu, 22 Aug 2024 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GL+G/dc0"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4FB2C190
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346120; cv=none; b=NCrsDIiqRbEx3rr8OmPCT6mIrswxiKBLve3Gr6IOlBnY6b3Y6oL6EUhLQfOfd+SFYG/q8fCV42pciKuJnw4euC6D49JbzNcfK4iqIZNGmWMNulmrO+toTP1D5mqThgfaUnW5+kIWnu36JuBqNrnECzv25dhHpW0D9aRpSEzsBoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346120; c=relaxed/simple;
	bh=qIyac7FRZS17y5NyPP/vvfgIoZ3YGywcMPcNzGHXg3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2te6FpB6MfX4npl7Zi8bv38osyuKmb0elMde9CxjlijBXMhFdJIXSC7bLjba/l3+JIQZeYdK74StV0T99mqBLCCmiC1cfi21jTFBpFGXPqaHbA1idJRzO7kW8gYWeXswAzfkeb0P1Ljbdst5s53hKv9LwDfap2BFQCAxXl+IgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GL+G/dc0; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 22 Aug 2024 13:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724346116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qIyac7FRZS17y5NyPP/vvfgIoZ3YGywcMPcNzGHXg3s=;
	b=GL+G/dc0RijXuZKtyP+egoLDJXc4IOCUKtVhHY54aRBufN6Pidw9WBKKtyOubZHPRworMM
	aBtls63F/KWAAQc2KUT0dW9rAlNdihdrUVCZ42sMW8gEJKUltfarnuKIbUGZfrGaEYfG44
	crFeba5xRjNyuyQ3SxCRLVgbNu/NbZQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+f24f0d68e1a0dc1b8ec9@syzkaller.appspotmail.com>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_dirent_invalid
 (2)
Message-ID: <6ffwugp6cfmmjva5kah2futl4k25c2gflnfgtn3yprm6r3vibb@fidztian6sx7>
References: <0000000000005b7bce061ad89550@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000005b7bce061ad89550@google.com>
X-Migadu-Flow: FLOW_OUT

#syz invalid

