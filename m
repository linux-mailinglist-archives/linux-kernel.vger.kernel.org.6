Return-Path: <linux-kernel+bounces-292827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A29829574F1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498251F21D21
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BD01DD397;
	Mon, 19 Aug 2024 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="x9I6e/NS"
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B1C1DD38D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 19:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096879; cv=none; b=XyHaDgMZ/qV0IMNrX0zOQirfpEJaNjrebWluWutfCt9oy67V9tQapWBI9T2L2mH2ZwdP9ibUOAyKAcmrZsl3b71D9hqIFzD2beuRrLQKme8Yk8WsmBVaK7l/RVgV8A5tp8beAZJRScs2O2ZMmudYCKMxthBpWaWb2VFJu0vv0aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096879; c=relaxed/simple;
	bh=bPsxVnYzwB2ddPCpY2V+I5MDlY+0dH/R2m1jbYnQhbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwsNMNCUJ/mcbA1oInWNPJ9nolx4FlIF4pEpewYYJUj2ISqApb7pOO3XMzUBmMcoLIeDbA1NKocg0dCbBz0Fb4BnnmrX4H07m2jdQu8ZoCnGmWQHzq7A+0ztD4WBaZDWuTl9o1XY81FjgzcoYBWfOYPEB3VRdk76jVgQz9PkrNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=x9I6e/NS; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Wnjn60hvXznff;
	Mon, 19 Aug 2024 21:47:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1724096874;
	bh=0KTkTIq+vCZqQkOZop6p0KjBIZk8NEe3uqGVmle1LoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x9I6e/NSUF7v1SqcJjGsRpDPTtBLEBz0Bq1UHfmBXbGhjjcJJ3Wt+/FSReQCvCea/
	 MMnhSqYxnpqbKDpnMdFTwR+BZeCrkoTiLz7g4eKWsgcgdjoMOvDF37m2z6xejc5bHE
	 oLg0b53/0snxhxvCjF4cG3BJwKxyZpkUCL28YqMc=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Wnjn53yGPzncD;
	Mon, 19 Aug 2024 21:47:53 +0200 (CEST)
Date: Mon, 19 Aug 2024 21:47:50 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v9 4/5] sample/Landlock: Support abstract unix socket
 restriction
Message-ID: <20240819.Ielaingoo8Yi@digikod.net>
References: <cover.1723615689.git.fahimitahera@gmail.com>
 <60861c67dab1e1e8cf05ec6bfd9e5ac75d09b63a.1723615689.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60861c67dab1e1e8cf05ec6bfd9e5ac75d09b63a.1723615689.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Aug 14, 2024 at 12:22:22AM -0600, Tahera Fahimi wrote:
> A sandboxer can receive the character "a" as input from the environment
> variable LL_SCOPE to restrict the abstract unix sockets from connecting
> to a process outside its scoped domain.
> 
> Example
> =======
> Create an abstract unix socket to listen with socat(1):
> socat abstract-listen:mysocket -
> Create a sandboxed shell and pass the character "a" to LL_SCOPED:
> LL_FS_RO=/ LL_FS_RW=. LL_SCOPED="a" ./sandboxer /bin/bash
> If the sandboxed process tries to connect to the listening socket
> with command "socat - abstract-connect:mysocket", the connection
> will fail.
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> ---

> @@ -358,6 +403,11 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  			~LANDLOCK_ACCESS_NET_CONNECT_TCP;
>  	}
>  
> +	if (abi >= 6 && !check_ruleset_scope(ENV_SCOPED_NAME, &ruleset_attr)) {
> +		perror("Unsupported IPC scoping requested");

If LL_SCOPE="", the sandboxer prints:
"Unsupported IPC scoping requested: Success"

> +		return 1;
> +	}
> +
>  	ruleset_fd =
>  		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
>  	if (ruleset_fd < 0) {
> -- 
> 2.34.1
> 
> 

