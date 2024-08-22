Return-Path: <linux-kernel+bounces-297707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9778895BCD0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3C13B2BF9B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B041CEAD1;
	Thu, 22 Aug 2024 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T5kLeS14"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C601CEAC9
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346197; cv=none; b=qgzkbElLtUi11j4biUU0bj+kNP5yWAccYcc/pzK8gvt8NfhietmFwAvu/MqYsz06jv4uJsWx006CmtrWgXGwB5ih6DwCEZHlZJoB4gWa26Sr7H8+ZBgqyT/VBtOQFVK40Ibukw/fJSLSpMfF5Tly4PxAndo/sNXq133tTiK5BWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346197; c=relaxed/simple;
	bh=qIyac7FRZS17y5NyPP/vvfgIoZ3YGywcMPcNzGHXg3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8p9KRqosps21pQmyy0O6SZZ6fWE+B+w7Z/D+Qm7A4KW6ZeQ7xvQHTaysLWeXbP2w6nWoBkiz6m+a0/i/PPEEp1SIRzk45Fp6IcHpr68uKS+5dhovcEdcxxWC1fOoAFg+JVbs49IH7JSNC8T2dkzLm8fUnBOQDS6EFgqAQwapp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T5kLeS14; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 22 Aug 2024 13:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724346193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qIyac7FRZS17y5NyPP/vvfgIoZ3YGywcMPcNzGHXg3s=;
	b=T5kLeS14AE075sUTQOX1iff1Sul5WCjlrRCbbte14+7g0DquSelP3vdlPtInxH+BXnpr1U
	W6wOLAT65f/2HpIW39kOYRpqHr9/zjikO7SaT6OAovNf/JU87JMeARWhY/qiS8v/KsjOk4
	2oBig5PSGRykBmOYGpqBLJUgzRk+mmU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+c816b9d76d3c2f738309@syzkaller.appspotmail.com>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in
 bch2_extent_crc_append
Message-ID: <h6clqqjhdqt246nwydv6ja2eyxmk7y2t5f3zlptkztarz7qffr@btx3eye7ccam>
References: <000000000000aa690a0619ea7b3d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000aa690a0619ea7b3d@google.com>
X-Migadu-Flow: FLOW_OUT

#syz invalid

