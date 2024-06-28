Return-Path: <linux-kernel+bounces-234284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2A091C4A7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900621C225C4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90381CD5BD;
	Fri, 28 Jun 2024 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="oybsNbu8"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A061E1CD5AC
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 17:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719595098; cv=none; b=NgNCQ+3xA0sDsbK/Qw+FOfqgxfH0+dk9RPZqqpx4AxfsMOxu8L0C/t0BTWCmw4XbBLx9GOJkYJpCha1VcgLHoZ/6ia7+bRV/JXTBnWTEZh20R6Xv05lD0VIZLuOdZkvOuWf1vxLSF1WwGvlVQAn/caPKJKHWxrth9D7qLxQ8lBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719595098; c=relaxed/simple;
	bh=Ll7VDh97eSU4kzvGtZjZQRvp7nqnAh5Ud2rSAUstZJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iKr2cL8qoZKgTGvD0nPHu7xMoUcIccA1yXE2RzwM9k8REgoVNb35wqjdt/l/AZxdOYq2bfYHq2DQ/lsGcKSevLP9WOQ6tEyR+cGuC3YAVvT0t48AoZLvIKsXrkqCa/s1NfoLOj416/96g9LK9/dOvRGie/6Mm1Vn8LRcYDxBDB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=oybsNbu8; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-120-63.bstnma.fios.verizon.net [173.48.120.63])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45SHHtls024129
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 13:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1719595077; bh=KfV/rAv/XQlmF5zcjtWgflEmVb+bUQhJ46QMD8rb6A8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=oybsNbu8tI+R3CK5LpIiqCzIx7IKQrMNkQEPRKX2RbocWd+Vn5VeNtt89vRB8gjz+
	 AEarE6Y9MunTkNpuvnH26Ybuy/kFA3SdVI9ZH9jJfK74rQVFox4bNKESKro6L4ZV5i
	 Pg6VvWZ4LU/bX2kxCY4EbfmI0X1xi+eqqQXToXMCtCc5Ep0G7aV5P/zNoTp6O3+oK0
	 JzBzipbw/z/1uLS5u+08PgwoGMCN4JTO7+rEohY1AzTauDe5RHosTGMLxdPZMA2p9c
	 B4Qjfs0KgoAPXcRgU60WA8uK7+EW0J5O5F1q8neV9URKhNniUVoYjLDI2XY8MLmU6b
	 crdXjdqERFuqg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id D42F515C02C7; Fri, 28 Jun 2024 13:17:54 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaxi Shen <shenxiaxi26@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, skhan@linuxfoundation.org,
        javier.carrasco.cruz@gmail.com, syzkaller-bugs@googlegroups.com,
        syzbot+eaba5abe296837a640c0@syzkaller.appspotmail.com
Subject: Re: [PATCH] Fix uninitialized variable in ext4_inlinedir_to_tree
Date: Fri, 28 Jun 2024 13:17:47 -0400
Message-ID: <171959506217.737463.6996650484265246906.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240501033017.220000-1-shenxiaxi26@gmail.com>
References: <20240501033017.220000-1-shenxiaxi26@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 30 Apr 2024 20:30:17 -0700, Xiaxi Shen wrote:
> Syzbot has found an uninit-value bug in ext4_inlinedir_to_tree
> 
> This error happens because ext4_inlinedir_to_tree does not
> handle the case when ext4fs_dirhash returns an error
> 
> This can be avoided by checking the return value of ext4fs_dirhash
> and propagating the error,
> similar to how it's done with ext4_htree_store_dirent
> 
> [...]

Applied, thanks!

[1/1] Fix uninitialized variable in ext4_inlinedir_to_tree
      commit: 8dc9c3da79c84b13fdb135e2fb0a149a8175bffe

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

