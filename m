Return-Path: <linux-kernel+bounces-382782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 963849B1365
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 01:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302C11F20F95
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 23:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A7820C301;
	Fri, 25 Oct 2024 23:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XQLNsbid"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03D41DD0C5
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 23:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900165; cv=none; b=VfhlBqyWepgJoy+D5kPTVc+1I758fwDoUebeLGGmFJeggRsXaOIuwAauSZfJtENU5v4A6BBmctRQUgglEtsmVA0NAP5JQPzymb2Nt+RrTFqWXwGsw4bums+Z2onFLMK7d1LvjBERqKB7HuVg+jM0beY113AkH5nGGMX1uoiTRv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900165; c=relaxed/simple;
	bh=KRUgBdtWNLQnrKRI7zqV/GNJV0sRIUSLqd2/ozPBP7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKj0LgGowfd1z3fOnVS1JEsha/cAmWz/xmWKJJ5BUOri7L8tw091J113mbNBtDxi3aX4S6aWt1FWm8t1AJ+5OL2Xzz2Kt2vKQhyeDYy902VBG7Ib79Wv7ApKuUmuNNPCn/MWc9bGfF2/R6G3sGCvgPq3PTf2xpA72CFCbnKTkFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XQLNsbid; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 25 Oct 2024 19:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729900160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=thH1By+XoYf++5lu7GTdux+hJ/6K7F+L3dD/ksklv9k=;
	b=XQLNsbidfyLzIqtZiZEU4zEwf18PwVyO9sJbD1znTHL01ZTqn8tV+JpN65+udixEUrtR03
	zIvhUgNn8d8bMiza1NzPAjRE2CkMD1VWE2y8feQEt5/t/Ti2l69ENx15UNUcHPUHg2laPU
	bg5PU3sZDN0ohAAxSro7b7Qnk6cdRjc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Piotr Zalewski <pZ010001011111@proton.me>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, syzbot+2b6a17991a6af64f9489@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] bcachefs: init freespace inited bits to 0 in
 bch2_fs_initialize
Message-ID: <qalevkvrryheertfbzndlvz7qjbgochksqkx7mvrokwjp46nxd@njfi47slk5si>
References: <20241021174151.37692-2-pZ010001011111@proton.me>
 <tIKMrcwD8p9tGpwtsUsngf-py16xl6htT4OaToDQOGvHOOk4SyBTQ7L3-XNy2Gs-1LjKj4TyugnAP7OXiCJ7QyKzWrfuiNCLrd_OU76vOzY=@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tIKMrcwD8p9tGpwtsUsngf-py16xl6htT4OaToDQOGvHOOk4SyBTQ7L3-XNy2Gs-1LjKj4TyugnAP7OXiCJ7QyKzWrfuiNCLrd_OU76vOzY=@proton.me>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 25, 2024 at 11:42:38PM +0000, Piotr Zalewski wrote:
> Hi all,
> 
> Any comments on this? I saw the most recent master and I think this might 
> be not applying anymore so I can send v3 if needed. 

I just missed it before, send me the rebased version and I'll apply

