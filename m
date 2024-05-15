Return-Path: <linux-kernel+bounces-180168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 266A38C6AEF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5AFA1F218BB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5475338C;
	Wed, 15 May 2024 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4zNcT7i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559DB482D8;
	Wed, 15 May 2024 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715791776; cv=none; b=lPQC9le7oYvt4H69G3xSkBhaqwUKoWy3J6qjWX5SilLuS04eJUPL3uOvaUhBLGufl84kNrTxoqxd+Pg0VKRWykI5jl3ANM4CnWE2Gbi88HPkLivgKkbdTPZXqW4VRy0q5DSOguVceBmBhpaGUEI8mC8/oaxttVw8pWKm2ybZv2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715791776; c=relaxed/simple;
	bh=Sy7fg6sLde1LrN5LpXaaDz61xTRkcMNqUiWkoxLXcsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efM7k0w/udJEcOBVWhPMTZKQ4POG9PvtJKNKcucQtl6XxnLgUinDCZkC2edx8TL+05O9X9xAR0xjj+EUP/2Mcrqt+PprwSLF8DLQ0Vk3OcKxYwlZW+mtS7QYTwmrYcjxVmWZEr4/xBU9b176Jss8Z5i599rmlHhAQjGUNQh2rgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4zNcT7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C8FC32786;
	Wed, 15 May 2024 16:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715791776;
	bh=Sy7fg6sLde1LrN5LpXaaDz61xTRkcMNqUiWkoxLXcsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O4zNcT7iz5HQtbHar/FHncoQJ1YmnSfN8JyU1zdQD6MG/3HUUNLFSCrwB/4L9+dXj
	 2q/GS2QvOkMiMharQ3pMK9LB6UE7eT0TH7Nm3TABVe6lBmQAUJS/IHnW717Sl4icQj
	 H8eAeIyqz7fWCTCRgLP/lng9YbA2F8E0S8lrr3i6HILYpn+4fHulc79NpFFSBIolxu
	 oyj383gmKAJ5j6VeaJML9Ao/OWlKCwlJarLVKS5umJpSNQebl20sb++LjVNZVLQ0Sa
	 ad8AtGuB5hrvFaTMlgk3UxPzx33UQHEuq0DB1Q26pMAuKDjXCHCQdebjYpq/FPlLBT
	 ym8lvekjPKPzg==
Date: Wed, 15 May 2024 18:49:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, Jan Kara <jack@suse.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ext4: Don't reduce symlink i_mode by umask if no ACL
 support
Message-ID: <20240515-unbeschadet-wehrlos-64401692a4eb@brauner>
References: <1586868.1715341641@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
> 
> Fixes: 484fd6c1de13 ("ext4: apply umask if ACL support is disabled")
> Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Max Kellermann <max.kellermann@ionos.com>
> cc: Jan Kara <jack@suse.com>
> cc: Christian Brauner <brauner@kernel.org>
> cc: linux-ext4@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

