Return-Path: <linux-kernel+bounces-301545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0056F95F25A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9541F21F39
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3209017ADF7;
	Mon, 26 Aug 2024 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="37cOTXWI"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2581E519
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724677554; cv=none; b=dIwpBq2VpcXeYrLrYuAah2+IhUKZ0L3LmOuMzHlt7Ah1IWDQGGF1NHUdx0kTrHhdwp1jayLPXCaYzdZwqurFL6DtdhRM35g4ky5Dpv7E5Iv07vcgZ8x1cNKZMe5R/3k5dhZzng0132hpHsTrFSGQRoYSB+UgXXicc9hK558e//A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724677554; c=relaxed/simple;
	bh=tD25NcdVWs3hlMpBUgKjPkntJrW9TCFnXdRsnM4/Ulo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjDBGE6o7xxRRpEXFbo4wCrhP/+VgXKy9jRWhIAZLs9y+lCZf1enmO/CPLe4GovtLl8E81yJIoQIYBDC85jDPdzxXCFDgXWuML9p1lDwXni0+6kwuZiyjM00T6bjsL/+UlbtAuK2Wzabiyp3Wh2eRizMlhUTruOsa2XmKYsFKIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=37cOTXWI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BEP1Es6ym6Gqo8W4vOk1XZ9s/WrHy6ypMYPkbGwH5Qc=; b=37cOTXWIcoFI7JC3MpJF6+xCfr
	UHphNExENf7V7JQe03mgreYASCbWgUkLEZ96Q12Vt4htIEyt1rdMfRYZhWV+HAduNCZbUhdzUILj9
	ozMC9YmYMh8pY9SgjiUeVo1cOdQeXXpImWm/8DFYVxFHfhZU6nQSqtf4DfHG0rtzxtLI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1siZPe-005i4a-TS; Mon, 26 Aug 2024 15:05:38 +0200
Date: Mon, 26 Aug 2024 15:05:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Diogo Jahchan Koike <djahchankoike@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maxime.chevallier@bootlin.com,
	christophe.leroy@csgroup.eu, linux@treblig.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+c641161e97237326ea74@syzkaller.appspotmail.com
Subject: Re: [PATCH] net: fix unreleased lock in ethnl_act_cable_test
Message-ID: <9ac272e6-b956-434b-a90b-60be6a5ad106@lunn.ch>
References: <20240826121435.88756-1-djahchankoike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826121435.88756-1-djahchankoike@gmail.com>

On Mon, Aug 26, 2024 at 09:14:15AM -0300, Diogo Jahchan Koike wrote:
> fix an unreleased lock in out_dev_put path and substitute
> both labels (out_rtnl and out_dev_put) for a simpler out.

Hi Diogo

We try to keep fixes simple. I would of changed the out_dev_put to
out_rtnl, and then removed the unused out_dev_put. That makes the
change smaller, more obviously correct.

As far as i can see, 3688ff3077d3 is only in net-next, not an -rc
kernel. As such, we want this patch added to net-next. You indicate
this in the patch Subject: [path net-next v2].

Thanks

    Andrew

---
pw-bot: cr

