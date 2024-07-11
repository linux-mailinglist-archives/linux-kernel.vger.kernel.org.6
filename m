Return-Path: <linux-kernel+bounces-248535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABA692DE88
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 04:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90F81C217F0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 02:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076B1F9E9;
	Thu, 11 Jul 2024 02:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="PINhV/+R"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B557DD524
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 02:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720665743; cv=none; b=e7lszDnKH0uN1/PqAHHnn1mNKIARdY0ceuyermQ+F5scSrGSN3AE2t1HWxR5h73xGSwdTxKDXOxRGfYXfO5LvhIiQIRkDiOMPYIMxJ/ejd+tJlef/FZp44GXUE8ZA7Hp236yjoaWZPwIa2jjFHN+x6MN+IsdyCDKtaW6YHET0jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720665743; c=relaxed/simple;
	bh=PP+UCm2LVmmj3GNTFmi05xT/IodpvXYirFBYe1yPqyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdZNRh4a7AeWTPWNkNYNFvwBbdLw2nMrU22UIC5vMkZsjG45fgKYjirl+HJbBU4K0I+705vls0+Fxghh1ixahnYYB7aDBR5EJqNNPKe5TrV7TMvWG3kbBILbpAH5Ws0h9CMB7XdjN9eiJn4B1UD1uIv3C3oqFazING16SiiVqKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=PINhV/+R; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-79.bstnma.fios.verizon.net [173.48.116.79])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46B2g7wI028035
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 22:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1720665729; bh=F7H3+b2mAWAnFVkw4AcAdFXp3IHMf4irGnW5EZZM87s=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=PINhV/+RMiou4iHMX8KKjwNVuGiLgvJFw9v3r6kBYH8+Y/vQd48bir2+83ml0j/W1
	 qdwIoRHp23eeD92ltl2aL/WCysMYv07jqzR8m0Sf5I9FhtVnr+MCB6Znw7EQyg8en1
	 UqS7FsombG8OCK5GUywVc1ESWZoEYDl4AwXETWm33POkOH0OFrWiBBgpNX2ci+sgAS
	 DytK1LrSLpY9/iZiQxSELWZGxjbVj9QgXFtA24Zw+8jSpSf14vTfrW9nfa7RoFG/V1
	 vhWzG/zJKYOxfBatU0HU82EMkEIi/37pRdAI1psvyglyxSOJlIN8xhVOfhUMCAc3xl
	 Jn9570MFehGdQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 364EB15C0250; Wed, 10 Jul 2024 22:42:07 -0400 (EDT)
Date: Wed, 10 Jul 2024 22:42:07 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Pei Li <peili.dev@gmail.com>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        syzkaller-bugs@googlegroups.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+2cab87506a0e7885f4b9@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] Fix WARNING in __ext4_ioctl
Message-ID: <20240711024207.GC10452@mit.edu>
References: <20240702-bug8-v2-1-be675f490db1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702-bug8-v2-1-be675f490db1@gmail.com>

Thanks for the patch; however, the correct fix submitted by Kees with
this commit:

commit be27cd64461c45a6088a91a04eba5cd44e1767ef
Author: Kees Cook <kees@kernel.org>
Date:   Thu May 23 15:54:12 2024 -0700

    ext4: use memtostr_pad() for s_volume_name
    
    As with the other strings in struct ext4_super_block, s_volume_name is
    not NUL terminated. The other strings were marked in commit 072ebb3bffe6
    ("ext4: add nonstring annotations to ext4.h"). Using strscpy() isn't
    the right replacement for strncpy(); it should use memtostr_pad()
    instead.
    
    Reported-by: syzbot+50835f73143cc2905b9e@syzkaller.appspotmail.com
    Closes: https://lore.kernel.org/all/00000000000019f4c00619192c05@google.com/
    Fixes: 744a56389f73 ("ext4: replace deprecated strncpy with alternatives")
    Signed-off-by: Kees Cook <keescook@chromium.org>
    Link: https://patch.msgid.link/20240523225408.work.904-kees@kernel.org
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

						- Ted

