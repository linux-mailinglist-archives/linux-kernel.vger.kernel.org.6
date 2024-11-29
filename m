Return-Path: <linux-kernel+bounces-416436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FB39D44BA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29B9283AA1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CE61C7292;
	Wed, 20 Nov 2024 23:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HsjSXGJD"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796DC1B5808
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 23:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732147077; cv=none; b=NpUdM1tQaP7F/ZTYbLH6W1senc7jXvYPfZPdzkcF0kykWkOOJIRQS/1cfUxEN5+m6takiCOoyD4+z2lM+NKxZrZraTvKXi4rgYPG5LgbKrqZprKgCJYD8zhaJIZRe2NqrAQuts5hWIV2wEQV2PZ7jkRo2i8lSfWlN5dNpv9FD+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732147077; c=relaxed/simple;
	bh=xAJiMOy/tYwJ2SRHkwirLqKL/+U2qvyXPidllX/e5sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GypD1lglH7VLkws64jf60DTlDTJa2TLx0csHSNntsO3HWw1Hi7eUY8s356pwT6sDOdnOVrfJHbbKlmVXGd68N007FyMCF1U5Sw6aRtn47Mnahj8NMqM+kFMBqOAXnLoDc+FOl9ri2Q4QOiJZbxrXLzbAayY842rrI7boKUKFnWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HsjSXGJD; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 Nov 2024 18:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732147068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+/zQUiFZa2/Psd9mNiVAyI7r4UoULDnI3eDp0bLin/I=;
	b=HsjSXGJDjkCq50YVDxBlWSy0liTPKmzIp6QG5Y5lBGoOO9V+h6rlIpkJxkiUoj1fMTvFtK
	nvF60ap2G/fxq3GGqJpKsTYhamASQs+oSgMFxdHybVda6EIoCCckaq/0C7a+SN/i30ME4y
	/bagUqINsDLLpFJJmeFqNgohtnLNiU4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Michal Hocko <mhocko@suse.com>, 
	Dave Chinner <david@fromorbit.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "conduct@kernel.org" <conduct@kernel.org>
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <gdorei5imv4qs476pcshmmw7ty7zyhqkb2hvda3ucihxqwlgwl@brnwkt4e7ili>
References: <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
 <22a3da3d-6bca-48c6-a36f-382feb999374@linuxfoundation.org>
 <vvulqfvftctokjzy3ookgmx2ja73uuekvby3xcc2quvptudw7e@7qj4gyaw2zfo>
 <71b51954-15ba-4e73-baea-584463d43a5c@linuxfoundation.org>
 <cl6nyxgqccx7xfmrohy56h3k5gnvtdin5azgscrsclkp6c3ko7@hg6wt2zdqkd3>
 <9efc2edf-c6d6-494d-b1bf-64883298150a@linuxfoundation.org>
 <be7f4c32-413e-4154-abe3-8b87047b5faa@linuxfoundation.org>
 <nu6cezr5ilc6vm65l33hrsz5tyjg5yu6n22tteqvx6fewjxqgq@biklf3aqlook>
 <v2ur4jcqvjc4cqdbllij5gh6inlsxp3vmyswyhhjiv6m6nerxq@mrekyulqghv2>
 <20241120234759.GA3707860@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120234759.GA3707860@mit.edu>
X-Migadu-Flow: FLOW_OUT

On Wed, Nov 20, 2024 at 03:47:59PM -0800, Theodore Ts'o wrote:
> On Wed, Nov 20, 2024 at 05:55:03PM -0500, Kent Overstreet wrote:
> > Shuah, would you be willing to entertain the notion of modifying your...
> 
> Kent, I'd like to gently remind you that Shuah is not speaking in her
> personal capacity, but as a representative of the Code of Conduct
> Committee[1], as she has noted in her signature.  The Code of Conduct
> Committee is appointed by, and reports to, the TAB[2], which is an
> elected body composed of kernel developers and maintainers.
> 
> [1] https://www.kernel.org/code-of-conduct.html
> [2] https://www.kernel.org/doc/html/latest/process/code-of-conduct-interpretation.html
> 
> Speaking purely in a personal capacity, and not as a member of the TAB
> (although I do serve as vice-chair of that body) I am extremely
> grateful of the work of Shuah and her colleages (listed in [1]).  I
> believe that their work is important in terms of establishing guard
> rails regarding the minimum standards of behavior in our community.
> 
> If you look at the git history of the kernel sources, you will see
> that a large number of your fellow maintainers assented to this
> approach --- for example by providing their Acked-by in commit
> 1279dbeed36f ("Code of Conduct Interpretation: Add document explaining
> how the Code of Conduct is to be interpreted").

Authored by Shuah, so I do seem to be talking to the correct person.

Regardless, we talked privately about opening some sort of public
discussion, this is pursuant to that.

