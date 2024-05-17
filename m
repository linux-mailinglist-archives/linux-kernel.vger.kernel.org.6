Return-Path: <linux-kernel+bounces-182270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152488C890D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463951C221B4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F1A67C53;
	Fri, 17 May 2024 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="gi+I/uwM"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52F569DF7
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715958668; cv=none; b=h28FkuKpWcjfzH+BOQx0DTsQ4LsixovMEB7sTXWOWP8Hi5PfrnEA1O+OKm/JV7rxejrvhkH/nFF0qo2ECFbTRuMcS7nIlpQxue252H54/NrnRXUKFJBh/wGUOEsdxpWCKj7DI7E1VaOnZkTKKF1JQ23JLQVnl2aD9s627AmF2BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715958668; c=relaxed/simple;
	bh=0U3sf8Hc8uG0pt5j1TXMHSmEl5W5zQP3g9W1tgxp3YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXhQTIDFD8vYwZgH3sj0fmZ+wbuf6Cia1aiY/eNMGvvy/PK6LPj0+CneFT3u8HJFKrJ+KOO9Cyo0OXrSU2YIGTZCwwbfXKkdk506urjbIVrJ4mQlylAhVKmQBGPa1YgqQIi6Nn551PVxGsIDC+CYEpQlkhcIOtjuGv+zQp9ncAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=gi+I/uwM; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 44HFAfIg005865
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 11:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715958645; bh=53gt3U+FPEO+PUBC7Ra4RhW5FF25V+xJNdlek+/C4FM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=gi+I/uwMs8AWOIZoVgSpzp1LTjUsBsgcufR8K4dcGGobk03DWYCSMIAX2XXIMSuUG
	 IMrBAkasJnfWWkcczcF6xvzajb6fj/yiJ3pvmgQl96LxNnrcKasqkILq8Tm2dmxpfg
	 wrJ0M28N0WKdPhUL4sKblaLS2as1zpWW6aIxJxX2U4TRdp1HUbKkMQXYp1ym18pdI4
	 u0OH9N1LyyWIOvzAlJzH0NqLH5LpF4UJ7Pc30JoHemfw0Umsexai0kzBgOADkLdKEY
	 Pusxqpf6O8Npax2VByBowDCN7YmLDseO0R3jr5+JILbaXlrSlb1vekr8NnhO4sNYj8
	 JxChXbyt5Zp+A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 20A1F15C00DC; Fri, 17 May 2024 11:10:41 -0400 (EDT)
Date: Fri, 17 May 2024 11:10:41 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: David Howells <dhowells@redhat.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, Jan Kara <jack@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ext4: Don't reduce symlink i_mode by umask if no ACL
 support
Message-ID: <20240517151041.GB10730@mit.edu>
References: <1586868.1715341641@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586868.1715341641@warthog.procyon.org.uk>

On Fri, May 10, 2024 at 12:47:21PM +0100, David Howells wrote:
>     
> If CONFIG_EXT4_FS_POSIX_ACL=n then the fallback version of ext4_init_acl()
> will mask off the umask bits from the new inode's i_mode.  This should not
> be done if the inode is a symlink.  If CONFIG_EXT4_FS_POSIX_ACL=y, then we
> go through posix_acl_create() instead which does the right thing with
> symlinks.
> 
> However, this is actually unnecessary now as vfs_prepare_mode() has already
> done this where appropriate, so fix this by making the fallback version of
> ext4_init_acl() do nothing.

Thanks for this patch; however, as I had mentioned in the discussion
of the v1 version the patch, this change is already in the ext4 tree
and linux-next in commit c77194965dd0 ('Revert "ext4: apply umask if
ACL support is disabled"').

						- Ted

