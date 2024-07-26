Return-Path: <linux-kernel+bounces-263046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FA293D049
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790EC1C20B00
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0932E176FB8;
	Fri, 26 Jul 2024 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+JCZ1YO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E946116;
	Fri, 26 Jul 2024 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721985389; cv=none; b=Lo0TghqL4+OQ/v3Ru0S5J9el56scsApdLGkKK/3gMcN991jdhpgloQityoGk0lKFbDYwhjelE96f2OFGsakc1TTE0kn13S1jUuVCFrjRlEkHXShLuUCCBbMeUzOwVwvzqhvZ8699wlFMf1zaJtJulOpaDUAXMGvqKT8XdkmPZNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721985389; c=relaxed/simple;
	bh=PnbtAbDjAPuh96YJQ/mUts5tx5UOs3uqSVoqQhxA+ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDAeTfn7cjrFFDSAoBspBFKNj8ZjUMwcyMPPfVLtlh24WIYEN0xCm1h34AUNoGV3Yb3uxUvozsm48lb17xR2evAZL5X2s3iBM1qVCYk3zrG+lOCNKJ+eQDIDXzp6XOF65s6LDMRQgWHSEP87GuP5YhYGe7GIIvVBqyBD3iWEJf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+JCZ1YO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27759C32782;
	Fri, 26 Jul 2024 09:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721985389;
	bh=PnbtAbDjAPuh96YJQ/mUts5tx5UOs3uqSVoqQhxA+ww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+JCZ1YOwIhojDTDdz8i0qs3E0cnsup3rbDEcel0eSAPNviCjLd+tJFCpwuEnhHoT
	 GgFvZIargYCqRE93v8OLacXnwv2i/eSAWfTHLWE2WY6yoNR9R08yUCQHOE3r9756Dp
	 GmSOJ0MhcRaL8ZKSoZnH95OZypcA5CjzJnSyt9Nq5Twzn5Jfy7A6NQg+x9BtSN2WvQ
	 n9TYn1tJdd9d3PxfrgiP21uZS1dxXnpeDjgyeDwKXAu65M/XMWWrZmnkhcirdI5xTd
	 9y3dZji+jfzBbCQo7eLTMKhZ+uRKMWRMB0Vljbnu8PgrjjQxJyYALcI49fJ4hJ+p1p
	 PiWvwzLKyaH1Q==
Date: Fri, 26 Jul 2024 11:16:24 +0200
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+dd73570cf9918519e789@syzkaller.appspotmail.com>
Cc: aleksandr.mikhalitsyn@canonical.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] WARNING: lock held when returning to user space
 in ns_ioctl
Message-ID: <20240726-vorsah-bohrung-5df17560cead@brauner>
References: <00000000000077c88b061d7b893e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00000000000077c88b061d7b893e@google.com>

#syz fix: nsfs: use cleanup guard

