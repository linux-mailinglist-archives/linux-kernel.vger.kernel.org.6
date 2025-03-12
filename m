Return-Path: <linux-kernel+bounces-558211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F89A5E2CF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27DAA177CA6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748A82571DE;
	Wed, 12 Mar 2025 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcuRHfwF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA572571A5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800550; cv=none; b=HbLgDG7nwh/CccbEg66v9Oi9TDr4NI0XIs0J8Dc3FHNm+8uYN5TfmTTLDluy6JwKOoIghErJGRPD6qly+eeNDzV9C+8Tzp9QYWGSKZOCxymAU+FLyHyBlN3OYe5zfrMogK8VOU92/n/pjdSOQZE+qEGkekUF9SdpDoddHYBWQEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800550; c=relaxed/simple;
	bh=wiZ3gI8knSno7vCydpNF1uHdUFebRXO3ZkPZn+zaQZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2E8tNmhLaP1nux59vW+k915010aH2pqAItKB6lwGLXzt3snl+lgz20YziNVATuFAuYTm71cRiqk4jU+tqKoc37vufAoKlMH6HzjwPPaawvticQTgW8esPNqJ5Wq0txdyq/ZRKXSTJACmIx0Qpw25JRLb8HhDRjK0Ntxa/yHd8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcuRHfwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0659C4CEDD;
	Wed, 12 Mar 2025 17:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741800550;
	bh=wiZ3gI8knSno7vCydpNF1uHdUFebRXO3ZkPZn+zaQZ8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mcuRHfwFxiMTLj789526sJ+SGs46A+gHzKtgKHRL+2uqi6HX1t/r4BlKjrBlNb0+5
	 HaXmksl0n8HRctOaltE5imiW39EZG72kI79B9MNoZQKEgkT+jtXVbXeo2nAj3gaQKz
	 EYoWiXZFVSV18ZnHROE621mcVaNwYzMlj8jmLwnW9tMOCMJeospM3hgN/C+yv8vD/w
	 2F0s8TFHbCHR0tp3ZH1JSgZRDjMBAJ323wQy8A+KmtkF/tmQvxXs6fQN8pxYDX942W
	 1VWM0TpeP7E5keybkqNSDQy9KQqHhKcfaIUOSCJfCaVX+POsQ6GVwvG+MqUpFSGgyg
	 ySKliQuj9cDiA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 55580CE1401; Wed, 12 Mar 2025 10:29:10 -0700 (PDT)
Date: Wed, 12 Mar 2025 10:29:10 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: Corey Minyard <corey@minyard.net>,
	openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] ipmi: fix suspicious RCU usage warning
Message-ID: <e28d914d-5842-4bfa-8208-9ac34fd38a95@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250312131932.44d901f7@fangorn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312131932.44d901f7@fangorn>

On Wed, Mar 12, 2025 at 01:19:32PM -0400, Rik van Riel wrote:
> On recent kernels this warning fires:
> 
> drivers/char/ipmi/ipmi_msghandler.c:1238 RCU-list traversed in non-reader section!!
> 
> This looks like a fairly simple lockdep trigger, where
> list_for_each_entry_rcu and list_for_each_entry_srcu are
> functionally identical, but the lockdep annotation in
> the former has an extra check.
> 
> That extra check is whether the RCU read lock is held,
> which is not true when the code uses srcu_read_lock.
> 
> Get rid of the warning by using the properly annotated
> list traversal macro.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 1e5313748f8b..a2823763fd37 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -1235,7 +1235,7 @@ int ipmi_create_user(unsigned int          if_num,
>  		return -ENOMEM;
>  
>  	index = srcu_read_lock(&ipmi_interfaces_srcu);
> -	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
> +	list_for_each_entry_srcu(intf, &ipmi_interfaces, link) {

Doesn't the above line want to be something like this?

+	list_for_each_entry_srcu(intf, &ipmi_interfaces, link,
				 srcu_read_lock_held(&ipmi_interfaces_srcu)) {

>  		if (intf->intf_num == if_num)
>  			goto found;
>  	}
> -- 
> 2.48.1
> 

