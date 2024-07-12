Return-Path: <linux-kernel+bounces-250200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 799D592F51A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CF581F23CF8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0011805E;
	Fri, 12 Jul 2024 05:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ufiURPzU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6B718037
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720762759; cv=none; b=lvCshJNQddy02ctxZwJGxdKDjIi0FUrIVnAcIs1ZWci5i0o9S8xrPsihG+6m+N4g6dhqKfIeFZEwlO6sAtqfc1GMy805z3MfumBpYP8dQ+zPdzHpQWmPoCWT7P9QP5MT0MmJTWDN++sFw/ANtXahN5l74EyvgSehvd6dfIIOqx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720762759; c=relaxed/simple;
	bh=EGh4rAfaizDEjwcWTFypbdbfP5HIubNn2YwBU+cec9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4sPNVe2U2DPLyYdzKwpHT0ZfZ93Rffdz5K/OW9g/hems321GD8CsXynh5YZWvOO4yB+HW5+0mBiI5Cz0wG5wJGm6xsixx8U0qvmELM4YzJXtzOh84u0csRck2gkAL7VLIbhz3+w1oep3OnyIml0Nb89nz6z2F5fwrze3PUoFUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ufiURPzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0ABFC3277B;
	Fri, 12 Jul 2024 05:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720762758;
	bh=EGh4rAfaizDEjwcWTFypbdbfP5HIubNn2YwBU+cec9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ufiURPzU7J6trowTRjWr31Ma+2ZCQLqZWqv2d0elcayVakRqWvIXP+CWi7Z6WpvV4
	 JjeSmPtvyYqUGKN2AfoxoKW2MPPH690MRqoYV4D7RsjXZTjxmDyXOIx847SlsOcRhk
	 B+GYuSbOkcK3t9JEujehkVxcP0W5ZZZpfZXUkZ7I=
Date: Fri, 12 Jul 2024 07:39:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Leesoo Ahn <lsahn@ooseel.net>, Leesoo Ahn <lsahn@wewakecorp.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] android: binder: print error message on failure of
 creating proc file
Message-ID: <2024071259-pelvis-penalty-dabd@gregkh>
References: <20240712032140.4012667-1-lsahn@wewakecorp.com>
 <ZpCqkPIOCsnmf5lF@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpCqkPIOCsnmf5lF@google.com>

On Fri, Jul 12, 2024 at 04:01:20AM +0000, Carlos Llamas wrote:
> On Fri, Jul 12, 2024 at 12:21:40PM +0900, Leesoo Ahn wrote:
> > It better prints out an error message to give more information if
> > calling debugfs_create_file() is failure and the return value has an
> > error code.
> > 
> > Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
> > ---
> 
> What are you trying to fix? My understanding is that users of the
> debugfs API can safely ignore any errors and move on. IMO it doesn't
> make sense to add this without a real reason.

Agreed, no one should care if debugfs works or not.

thanks,

greg k-h

