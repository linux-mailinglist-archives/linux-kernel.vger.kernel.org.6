Return-Path: <linux-kernel+bounces-250282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B699092F613
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66900281FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A9C13D8A4;
	Fri, 12 Jul 2024 07:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vXc01ofO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A456C12B71
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720768746; cv=none; b=aoy/D5Ti07q8Rufq1DQa/JyP6lph1CpIEtcU8B0BI3+RYuVxj0lJibsE0uBoCRbyFjagPNlelYjjLQJOYbVl8b29rrcpsY4N5zDI9L7n0aSuKWHHNr6UfZ6tuAZMvYmx67R0L9H7mel6ax8HUY96MBeUxZW+O4cMQlFObqoiIk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720768746; c=relaxed/simple;
	bh=DN0yhcGErt3ZK+10gBvOnzNHZaDv6LP6/yELSW7NStg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cI+dS95hT6/bfo3hr+ZQ60L3jtCUxYweGvTsIOaUD4/Y0NAbpt2UMCCPOBzAV2JlpTWEEdvqYyNaJg+NX5hwexfE87XMgUidx2VJvqrn70Yjj9ufMowfACwrbtKGpeYNKcwWNI1gq5fu2fk3uOiNrk3zr9iwRLBRwRkbFvur5N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vXc01ofO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A83C3277B;
	Fri, 12 Jul 2024 07:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720768746;
	bh=DN0yhcGErt3ZK+10gBvOnzNHZaDv6LP6/yELSW7NStg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vXc01ofOEyUbSoMQq+IcU99xYjn1nbTe8ExG9YPOTjbfSQMxwy2gqgbj9v/+cLPSq
	 B898SebhVs1sGjtyubhP1TmYmaXC8AGbcmM2OP3BoH3m2iUnb96kLmmK1ftYdxacYq
	 VE7X3rIcDEGUMJYoY+J0m+UtnATzD5jG3Fy9hXxY=
Date: Fri, 12 Jul 2024 09:19:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Leesoo Ahn <lsahn@ooseel.net>
Cc: Carlos Llamas <cmllamas@google.com>, Leesoo Ahn <lsahn@wewakecorp.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] android: binder: print error message on failure of
 creating proc file
Message-ID: <2024071241-entail-icing-58cf@gregkh>
References: <20240712032140.4012667-1-lsahn@wewakecorp.com>
 <ZpCqkPIOCsnmf5lF@google.com>
 <CANTT7qi_qZfFH+T1z22GMQ-LmG1vHG1adzD=hxXiXyKT4kkhOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANTT7qi_qZfFH+T1z22GMQ-LmG1vHG1adzD=hxXiXyKT4kkhOQ@mail.gmail.com>

On Fri, Jul 12, 2024 at 03:52:32PM +0900, Leesoo Ahn wrote:
> 2024년 7월 12일 (금) 오후 1:01, Carlos Llamas <cmllamas@google.com>님이 작성:
> >
> > On Fri, Jul 12, 2024 at 12:21:40PM +0900, Leesoo Ahn wrote:
> > > It better prints out an error message to give more information if
> > > calling debugfs_create_file() is failure and the return value has an
> > > error code.
> > >
> > > Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
> > > ---
> >
> > What are you trying to fix? My understanding is that users of the
> > debugfs API can safely ignore any errors and move on. IMO it doesn't
> > make sense to add this without a real reason.
> 
> What I was trying to say, users would predict that a file under
> debugfs will be created while they are opening a binder device. But if
> it failed for some reason without any debug message, they would get
> confused that the file doesn't exist and have no clue what happened
> without a message.

And that's fine, again, the kernel does not care if debugfs is working
or not.  It's just a debugging help, it does not affect the normal
operation of a system at all, and as such, userspace can't rely on it
being present for any functionality other than debugging issues that
might happen at times.

thanks,

greg k-h

