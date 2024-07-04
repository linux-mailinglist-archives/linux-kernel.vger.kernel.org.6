Return-Path: <linux-kernel+bounces-241164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECBE9277B4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C430B22FC9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769BE1AEFF0;
	Thu,  4 Jul 2024 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EN36+H3K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFD01AEFDB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 14:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101885; cv=none; b=Lo5XW95a6LWmJDFnoap/v44EIno3i/eOhkG8onBr+rkAdyabYo8zhGsiKx53cjLBXH/9HlXw2jS04UvsgiFWh1Mfrp1h5UpcC5t91Mk17V417OSJRNwd+j48DpBYtrDqW2Fp/TEStabCsC1Bj+A2Xc5q445sxUyJPWCOswNNI0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101885; c=relaxed/simple;
	bh=LJIikiAlv2CubzjXW6DIcczHlDXpnOk+iFoZxUOviIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihrbohAo+dSbQPMZiYrpIee4lL+qXJk3w+qLiThiz8DK02KecRQRtJbzxpD1bUheyhGb4MXUxGniJHgmiAKmOvZB0Mqz6wpJpnnKJ1cKnQzJcbnS82G8jWoMJeSnBgoYmSTcNQUgbmvxL0eVe9u/fqv55oF9oHWSdUJzh+cOWlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EN36+H3K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52707C3277B;
	Thu,  4 Jul 2024 14:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720101884;
	bh=LJIikiAlv2CubzjXW6DIcczHlDXpnOk+iFoZxUOviIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EN36+H3K3gzPgzMwEXnsdZwjMP7SM2yD6rACvZSgkLhOwzgQ855ESsMUZy50oHkW4
	 NlzlBMu82+bOseKyj23rkvOCylZCw5y5KrtDBuT9lr8DNCOa/kCGzHsV2eGZ6PAqtM
	 Q8xuTvXyv1O/RLobLEmwipKx+zPzKiqgXa3GLfO4=
Date: Thu, 4 Jul 2024 16:04:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: 88c258bd-3d0c-de79-b411-6552841eb8d0@gmail.com,
	Linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org, luisbg@kernel.org,
	salah.triki@gmail.com,
	syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fs/befs: fix shift-out-of-bounds in befs_check_sb
Message-ID: <2024070416-hatbox-playlist-9886@gregkh>
References: <2023082746-antelope-drop-down-5562@gregkh>
 <20240704135057.1174408-1-dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704135057.1174408-1-dvyukov@google.com>

On Thu, Jul 04, 2024 at 03:50:57PM +0200, Dmitry Vyukov wrote:
> Hi,
> 
> What's the kernel policy for such cases?

What "case"?

There is no context here at all, and I can't find any patch on lore at
all.

Please always properly quote stuff...

greg k-h

