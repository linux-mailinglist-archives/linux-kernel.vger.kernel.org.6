Return-Path: <linux-kernel+bounces-348300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC59298E575
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A50D1C23EF7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AEF1993AD;
	Wed,  2 Oct 2024 21:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mtuSgWI5"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B59919922A
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 21:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727905620; cv=none; b=Xx8xMP81xLlHCMsRDfYpZ94fI9ZynGkezjESFfQBlfrOB8K92cU9qw64gs6QA56AySOfBhjPcBuLPQMf3qvqwabJp5jJMuxgbyTKN3gUT9qXNAShYlGkqBLWMQ4XZBX4AbQm5gB/eMsZ4b2IgM6J2h1fIFjXtYvdW5PPglmc3SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727905620; c=relaxed/simple;
	bh=GOO+ZEd0Df4QSLYOqau98CRSdRG7Vjym9ywot5jL1j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcxgFfJvLX2+MJv9dCV+vzFrBCMutP+dBWKsAX/ZfWTFBD+gkEECs9ewSfnMf0xLx0QTGB2/06LLvQ6yIFEQ7ciHQ/Cdqh9oSB9cy2agb0hEVTGLJAEaTbPdF0YYLMQnbwc2RjO7R+ZNqp5W3hE3qnX23/Z4aTGyEDS+/wW8E3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mtuSgWI5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=m9lnvk66sH/OMWQVnsr/ZLwHrs16y5wsLet+cWbjD+I=; b=mtuSgWI5Qo+wtkbKZVM1O/vVZM
	tqh5v6CC5yYBbCUTVfZY22+StLdRjWdwjNV24QWZhlzpFIz/89rhc9mb1O4+s7QSZvQVdWxV0niEh
	nQyTP1aj1dSfCKKYTqNaLYzfxXRx36UK1r0XWtK0y8WmsPXwqYPAz/F09x15nQJKEcIa3rMwRZggC
	b/hCNTOlDVZvx3aE0WPaWHpIQjFTBMB5is06RU6ZkHtUTNHyImqlPNc92tSUQQvp33JMHoNx6UuGM
	+d5NFmoScDEIRcmSUg5xoPMY1SSUyflNYRtZeXGRRxGckN6HP7gVhu/ML1MV8eb5iSu+fZgASEUWQ
	110cp8Fw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sw7BQ-00000000KD0-2YnQ;
	Wed, 02 Oct 2024 21:46:56 +0000
Date: Wed, 2 Oct 2024 22:46:56 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Brahmajit <brahmajit.xyz@gmail.com>
Cc: chaosman@ontika.net, linux-kernel <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: Build failure with GCC 15 due to
 -Werror=unterminated-string-initialization
Message-ID: <20241002214656.GG4017910@ZenIV>
References: <ytw2hroanhyyvrh2ps24l2a6qsdke5m67ynfqcqpzo7wgp3ibv@spvsq3mzltnk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ytw2hroanhyyvrh2ps24l2a6qsdke5m67ynfqcqpzo7wgp3ibv@spvsq3mzltnk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Oct 03, 2024 at 02:46:48AM +0530, Brahmajit wrote:
> I'm building the latest kernel with GCC 15 and got this build failure
> 
> fs/qnx6/inode.c: In function ‘qnx6_checkroot’:
> fs/qnx6/inode.c:182:41: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
>   182 |         static char match_root[2][3] = {".\0\0", "..\0"};
>       |                                         ^~~~~~~
> fs/qnx6/inode.c:182:50: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
>   182 |         static char match_root[2][3] = {".\0\0", "..\0"};
>       |                                                  ^~~~~~
> 	
> This is due to GCC 15 now enables
> -Werror=unterminated-string-initialization by default.
> This is not the only error, there are many such build failures in
> various subsystems, some of theme are easy to fix, while some are not.
> In this case I was thinking of something like:
> 
> --- a/fs/qnx6/inode.c
> +++ b/fs/qnx6/inode.c
> @@ -179,7 +179,7 @@ static int qnx6_statfs(struct dentry *dentry, struct kstatfs *buf)
>   */
>  static const char *qnx6_checkroot(struct super_block *s)
>  {
> -	static char match_root[2][3] = {".\0\0", "..\0"};
> +	static char *match_root[][3] = {".\0\0", "..\0"};

Huh?  That makes no sense whatsoever - you get a single-element
array of 3-element arrays of pointers to char.

What you have written is equivalent to
	static char *s1 = ".\0\0";
	static char *s2 = "..\0";
	static char *match_root[1][3] = {[0][0] = s1, [0][1] = s2, [0][2] = NULL};

and match_root[0] is *NOT* a pointer to char anymore.

Just lose the last \0 in each of those string literals...

