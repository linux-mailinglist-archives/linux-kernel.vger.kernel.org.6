Return-Path: <linux-kernel+bounces-309159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7069666E0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB125B23EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E9A1BA89C;
	Fri, 30 Aug 2024 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f53AMWG3"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA361B81C5;
	Fri, 30 Aug 2024 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035244; cv=none; b=lmVUwwxeY1ZmzoakSC2I4Q0ftyPhhGws1234VPDkPkKQiWW9MA4a1mbJsd7SCN6M/pUeDKEnrvhYhThnYbUkDWZaitB7FQX79l/XcY9i/S/lL6K958mgGRotCrAb/s1VePXXiNkk7uuV68Ov5FJWWK+gT9XVdGwiV9jDqSE9gpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035244; c=relaxed/simple;
	bh=EmgsbvjbWy2HJxgl44Y6x2WOI+6Ob1l4rAyYzIBhZ90=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqQtjkHEl470s5ZFGq7/AGncFkQotGC1eetLtbH6KNrMCe1lzxtsRPpta7maUOx4kvscJ7kjur9bo0YgAGmK3nFwvWFc7UqI7VDHpUDyb+x7dPO4T8lrnz8N/eELyekV2ICS/6Ycy2lOKQ3IUwbSmYINSP67PKgWOk1VvPYwFy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f53AMWG3; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 34D52FF803;
	Fri, 30 Aug 2024 16:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725035240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cdwLIRS2cQsy5H0cWhE+G7Yz0IOQKDjmIOGIrx0jSw8=;
	b=f53AMWG3EIIesMn3X9ye+RWoA+8LJV1VieFBbFKkpB3zkHCruEDQv/uSDLf4b2tpTt3jxM
	IJEGBp/TO+EaDUfoVKpGSAgh+T72OqNSYLZbFZ45TWiLSHPuXlLdqoLGfGvZ5zE7ZewNgC
	xObosrqUhsVdyFesnRgfEolrm/iKP6ncFD4p1JUyACfG4v1akAIrsDPCI6AZckeBzsyd0I
	4t1Vb+Jdp7nXDpsW1ypgyMvA8lhzHYCKUH/4CDBjp3kPEiqWYOoYvAdajCyEeF4m+dKsuT
	7Hv/ohU1+zPkFV2rY25n81D2XHIJedM3/57D6+gSlsBRoGxClmG95kImq1Kugw==
Date: Fri, 30 Aug 2024 18:27:18 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Diogo Jahchan Koike <djahchankoike@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch net-next v5] ethtool: pse-pd: move pse validation into
 set
Message-ID: <20240830182718.6ed8d8e2@device-28.home>
In-Reply-To: <20240829184830.5861-1-djahchankoike@gmail.com>
References: <20240829184830.5861-1-djahchankoike@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Diogo,

On Thu, 29 Aug 2024 15:48:27 -0300
Diogo Jahchan Koike <djahchankoike@gmail.com> wrote:

> Move validation into set, removing .set_validate operation as its current
> implementation holds the rtnl lock for acquiring the PHY device, defeating
> the intended purpose of checking before grabbing the lock.
> 
> Reported-by: syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=ec369e6d58e210135f71
> Fixes: 31748765bed3 ("net: ethtool: pse-pd: Target the command to the requested PHY")
> Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>

This looks good to me, thanks !

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

