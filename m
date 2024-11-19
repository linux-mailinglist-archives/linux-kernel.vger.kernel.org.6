Return-Path: <linux-kernel+bounces-414917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 486E69D2F34
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F234B1F232EA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA861D2F54;
	Tue, 19 Nov 2024 20:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qxP3XB+s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C645B1D26F5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732046437; cv=none; b=UOBvmLI0YFb3kOuXoMxLH/SZTYlXxMWSz5r2AwB3+dwoqOBDNSKzq+CAnGV3WHUy99UCEamI9Dqgpof4rbaLOT+W0yiMHTGtekNz/PMxFzSSaoXDxKNZ9wsTUHGST6WMCxM9nmAa6i2AXBy/GrOVCv3JEJQ/zLdePp333fGCmD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732046437; c=relaxed/simple;
	bh=pedsLdA6YvjdZESvLTkXx5LGWVUyQ3CkZO+Xp5M2Sr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flkC5fV68xNgIOTlzhogrOV1iuHV9kKVI2cYM8FKcvisFwb9SN4zxV66NKRqXiA1AYpv3cSoHXS+XaB33yWoePklVrA4CXrHN5fnNr/WlillD/oER56Zx3UcQtoOy6M7X3SHhPceoiyiBTyIR3d0rxVLEV5zQp6SAIxCJpE1iQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qxP3XB+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B544C4CECF;
	Tue, 19 Nov 2024 20:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732046437;
	bh=pedsLdA6YvjdZESvLTkXx5LGWVUyQ3CkZO+Xp5M2Sr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qxP3XB+smHLY4zqkBQr0js9HXjrkEWU/WwIelofDKR698Z5yrmEUURzVyTBSArneM
	 2J97HydEulyASk7OAvo4pndPkfm3GyJz4Xl72N2DjFjtUw2h175VdUbfxzEspEyCKG
	 IPzZOXg1B7Y/uZjC5pRXMfKhmW6cur4kBX4CCXJ0=
Date: Tue, 19 Nov 2024 21:00:12 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Carlos Llamas <cmllamas@google.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH v4 4/9] binder: remove struct binder_lru_page
Message-ID: <2024111905-hassle-craftsman-14eb@gregkh>
References: <20241119183250.3497547-1-cmllamas@google.com>
 <20241119183250.3497547-5-cmllamas@google.com>
 <ZzziucEm3np6e7a0@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzziucEm3np6e7a0@casper.infradead.org>

On Tue, Nov 19, 2024 at 07:10:49PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 19, 2024 at 06:32:37PM +0000, Carlos Llamas wrote:
> > Remove the redundant struct binder_lru_page concept. Instead, let's use
> > available struct page->lru and page->private members directly to achieve
> > the same functionality.
> 
> I'm not entirely happy to see this.  I expect to start a patch series in
> the next six months which will remove users of page->lru.  page->private
> is OK for now.  The goal is to shrink struct page to 8 bytes, but I
> accept that 16 bytes may be the best we can do.

Can't whatever way the replacement for lru is going to be in the future
be used here as well?

thanks,

greg k-h

