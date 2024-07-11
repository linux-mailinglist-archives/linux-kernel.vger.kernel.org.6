Return-Path: <linux-kernel+bounces-248533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E798092DE82
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 04:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36152823BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 02:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0D212DDAF;
	Thu, 11 Jul 2024 02:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Lw8/OaHK"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F395422F17
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 02:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720665364; cv=none; b=qnqNFkPeAAEDvuehw88s2BUdFuBbZnF5uEWIVldFMpzUED9U7TdgUr2QXXfB7WMJSii4fNdix6VI8teTwQImVfof/WvmthHI9cI7t0OBTcuG4a8fJM8ZnXlUhp0L889LCN+RMEmcW0vg3rq6lFMrg9JffCUju9NR4v7PqRV5ntA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720665364; c=relaxed/simple;
	bh=YGLvWQJeQjTOKJ3gXmJbqqG2PVZ59UeXzZJl4sYUhTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aAN6osl8fAySMw5dzjOTix286Tc7dSaU6pdYOvqvh3CLaLK4gccarlPG7BSK2lXadPVk8H6wsd5lBv90DRCM04tqw2rhiIQT+Ri9K0vKYNDuNl4CQ4XIxvf/62aImlakOLHVGuAUn6791dv9uUCwKGWIt/Yulk0oiUsaX3p1mkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Lw8/OaHK; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-79.bstnma.fios.verizon.net [173.48.116.79])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46B2ZfY6025368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 22:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1720665344; bh=nFoKNnZUpTVqvgOZgriC7SwE48n2Vz4fjiGPip26FTI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Lw8/OaHKF/JQB5mnd5lcyg3CP+YavC3/2erCuwSxAfi1YmRrxQctZHOCC9oor7LkD
	 ZCZlNbnE2GGkbXM3UIPG0YwY/REhYbg8phq0I1ccCDLy6ou1mcnm0+Eg0A6a+NWPqc
	 uqvgHhIAg/ZA62oKrzCYCSw88WuD6THVMAP4MBLV0F9NLvzVjTCm/OGP2GNpHA9Z1P
	 Mv6JWSaDB1lAxs/jEiLvY56rdR2oFY47W6O7m6N78zE6FyNZ12EDysjoRcS2QdSiBd
	 p+4rEE40xYu7e6K5L9EwkAqk0UAH62MCTbXHNUhX9myqAJg1o2XmZsu5d8mB229mQD
	 V4A2sBx9Glx6g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id CC32115C18CB; Wed, 10 Jul 2024 22:35:41 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kees Cook <kees@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
        syzbot+50835f73143cc2905b9e@syzkaller.appspotmail.com,
        Justin Stitt <justinstitt@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ext4: Use memtostr_pad() for s_volume_name
Date: Wed, 10 Jul 2024 22:35:30 -0400
Message-ID: <172066485809.400039.2045305282487026392.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240523225408.work.904-kees@kernel.org>
References: <20240523225408.work.904-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 23 May 2024 15:54:12 -0700, Kees Cook wrote:
> As with the other strings in struct ext4_super_block, s_volume_name is
> not NUL terminated. The other strings were marked in commit 072ebb3bffe6
> ("ext4: add nonstring annotations to ext4.h"). Using strscpy() isn't
> the right replacement for strncpy(); it should use memtostr_pad()
> instead.
> 
> 
> [...]

Applied, thanks!

[1/1] ext4: Use memtostr_pad() for s_volume_name
      commit: be27cd64461c45a6088a91a04eba5cd44e1767ef

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

