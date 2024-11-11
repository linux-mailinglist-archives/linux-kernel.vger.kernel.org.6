Return-Path: <linux-kernel+bounces-404226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DB59C4117
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB0F280FBB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BF019F10A;
	Mon, 11 Nov 2024 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rwOGCO0b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3411C14EC55
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335851; cv=none; b=k4XaLznU91UCpOgT7AHz9TcKJcouuCsCZzCAuuJuJ22aShyQEmdNpeb9+RvV+nDRnT3qN47DoGWr/8wa/D3g6+aCmzx2SNlRM+LM5lbsYa8i4CLog/V13ebg72kdZwPfxGX1Hzes5UiSyfFFhsl3P8dxbPxK1ypIiN5Vd+HOYWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335851; c=relaxed/simple;
	bh=p29oz0Vmi6Ugrv4v0aORlBi8wDkmgjp/i3NLlCdu6c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHSRAGnqbUPGjlHn5LznEIbwf76FrvxKsgbjqVHSAu/1e1iNEeXO9bzQt578Bo+uA7Z7eGU8eN4GjEL/35DtFuJ+IfTrgyWKPjc3qEIu6jSWuvG/brT7xU5iOgrWPX4Q2IWBPLU9Mle9mXS0HBK4ALZnTboQdGXKKvCNRXK3QU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rwOGCO0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F33AC4CECF;
	Mon, 11 Nov 2024 14:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731335850;
	bh=p29oz0Vmi6Ugrv4v0aORlBi8wDkmgjp/i3NLlCdu6c0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rwOGCO0bANzPT+eSGF31Qn7DQOqowmLJIew5LywY6yB0ARsMjCUHQet+AA22PkbfN
	 Z0nLdk63jgPTeSQKPhU4M+AJnxUyrx0Hn1VIw9QeTczPKjM0M792QdR+RohF3/pGMB
	 K+R98WlfTF0qG8xjBcqh5uaPePBelkjync+NUh90=
Date: Mon, 11 Nov 2024 15:37:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Aleksandr Nogikh <nogikh@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>
Subject: Re: [RFC] syzkaller/docs: reporting kernel security bugs guide
Message-ID: <2024111124-hardly-jaundice-08c4@gregkh>
References: <CACzwLxjdRmD02Uu+3umNEvP-b9fXuT6WWS+a9gYhOeQEayK_ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACzwLxjdRmD02Uu+3umNEvP-b9fXuT6WWS+a9gYhOeQEayK_ww@mail.gmail.com>

On Mon, Nov 11, 2024 at 06:24:36PM +0500, Sabyrzhan Tasbolatov wrote:
> Hello,
> 
> Greg,
> Could you please confirm that the updated version of
> reporting Linux kernel security bugs guide is correct
> since kernel.org is CNA as of February 13, 2024 and
> with linux-cve-announce reference?
> 
> The updated doc and drawn diagram is available
> in this PR of syzkaller project:
> https://github.com/google/syzkaller/pull/5461

I can't read this mess:
	https://github.com/google/syzkaller/pull/5461/commits/35b45ef3c4600fd62f5d05a17fc6855fc0b5e402

So I have no idea, sorry.

Just reference the in-kernel documentation about security bugs and cves
for this information, that is up to date properly.  If you wish to write
additional documentation for external projects, that's up to those
projects.

good luck!

greg k-h

