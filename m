Return-Path: <linux-kernel+bounces-381388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535039AFE6D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AFBF1F248CF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310E91D45E2;
	Fri, 25 Oct 2024 09:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ozAbrd1r"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F371D435E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849037; cv=none; b=qM0UFyCM8JdkGUiSgFUspH98WSbCEBsXbtxR7xeB8gqaIHfHa73ScKF2R+xPwbnZ7hIsnsTkmD2v4codXSFm6hnyuFO/8OfV+WeFUZvzluhRBXNX69vu4ob79woxNp9dahspktuLdNsOz60U4E6UUc04+boorY8tKoxhfDQXW08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849037; c=relaxed/simple;
	bh=Y5xwwIYNKd2GpnAtE56WXV/B+R3Uy49Vn/yzPWu7Fb4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UA1j4AbSS4oR7JcxeWWozDMCYQBXBD6Z6khK9gy3+srKqOfk4fjIygywiHyKSmxeUkKPGgkkrTF0FN8QIQ8OGgGafwcVrEbHTMYCr/79pwNI9CAeO/OmJYps+Fvpw7tvgTArS2ZZv2sXU6cNE8BzEnz9BtkmcfQW4QzxyDJd5Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ozAbrd1r; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Y5xwwIYNKd2GpnAtE56WXV/B+R3Uy49Vn/yzPWu7Fb4=;
	t=1729849035; x=1731058635; b=ozAbrd1rl58cHw7ff3hH10NAfvpIC2uyVOQB+4cZJdbj9CV
	g8U+lou+n89jMlcEY9uijSxAFppdBRfTcm8IsQ1Eb232s7RQQg/UdQT3wQkqNHKo7MFJtDDGC2jFa
	4Xte9rQuF+uOYFt9nqS9ScFYtPeXw53p2QqKJ7bVTWrX9objZd+elanYMwfp6sfC4KVt7mArctneG
	xbyBZbg5ZU789dTAJE7Kijzxrjck/0npOATQyy1DBXU52njtIuo41r9HtcK4iXCv8JR8C7KT1zRSX
	NL66jArYbrj+W2d/A8NMN9h8AUTy+OTKrJpmFGjk9/HSR+iyQXcXypEIKbYb3dcQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4Gkq-00000004SyX-1MOa;
	Fri, 25 Oct 2024 11:37:12 +0200
Message-ID: <8926c205386e9b71f05764441b7a44a24964f50e.camel@sipsolutions.net>
Subject: Re: [PATCH 0/4] um: Set parent-death signal for sub-processes
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 25 Oct 2024 11:37:11 +0200
In-Reply-To: <20241024142828.2612828-1-tiwei.btw@antgroup.com>
References: <20241024142828.2612828-1-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-10-24 at 22:28 +0800, Tiwei Bie wrote:
> The ubd io and write_sigio threads/processes may leak e.g. when
> the main process is killed by "kill -9". Fix it by setting the
> parent-death signal for them.
>=20

I always used killall, but yeah, good idea, thanks!

johannes

