Return-Path: <linux-kernel+bounces-172119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF6B8BEDCB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6C02815B7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086EA21373;
	Tue,  7 May 2024 20:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b="oyHizF33"
Received: from smtp94.iad3b.emailsrvr.com (smtp94.iad3b.emailsrvr.com [146.20.161.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E878314B947
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 20:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715112124; cv=none; b=PQySA4SAEMxcvmaud1JI1kR2D3Qv3/wsyhI/9vJMjbJ/WPJguTIJwqoxPotFr7yROUn/GlEyTULa1VWwfwh3c/Qf7F8kSMFdTBXBGsj/UfDnt64lJfTrW6njBh32BdUfvuzs6c95hEIuhbG9wc6Pjl3lpj0Hi6O/b4GeQqLtixA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715112124; c=relaxed/simple;
	bh=Qkybr0ICtPOdOIgP4Bi2fvNRD8VjwHKkQtnvW+vmQBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1RER2uRb+AH0vYfvRaGkdUta9UcY/K+LA6G3YmvU4BIXnoMzXRUbWmgxMwaQoHU9q3Gy1I6P8iq4wqa3hvg0gfBFP1FPRXDd9T1yB5j1Aao2JPgv+NcydEo6wyvpWGMLNW/JcwiSQsM4eTXbn2j6B8d63lAiwl6rrBSGMOfQrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com; spf=pass smtp.mailfrom=oddbit.com; dkim=pass (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b=oyHizF33; arc=none smtp.client-ip=146.20.161.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oddbit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oddbit.com;
	s=20180920-g2b7aziw; t=1715110992;
	bh=Qkybr0ICtPOdOIgP4Bi2fvNRD8VjwHKkQtnvW+vmQBs=;
	h=Date:From:To:Subject:From;
	b=oyHizF33EJ9iPYpjHhjzhbUyxd4IKJc047Qjp1SV2xtzZaVViI5QEGEQXBIwOUhcK
	 6jS1781D76NO4uaIx/i5/Cyw0q+6i2hyCTju4SK/sLJaQZaSQ4o/ASrGlWvQNyM3sZ
	 g6ZBjMao8iV6oR9+pxsJaoxVAZyZQjPl/RZImsLk=
X-Auth-ID: lars@oddbit.com
Received: by smtp12.relay.iad3b.emailsrvr.com (Authenticated sender: lars-AT-oddbit.com) with ESMTPSA id B0AD9C00FC;
	Tue,  7 May 2024 15:43:11 -0400 (EDT)
Date: Tue, 7 May 2024 15:43:11 -0400
From: Lars Kellogg-Stedman <lars@oddbit.com>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hams@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, 
	jreuter@yaina.de, dan.carpenter@linaro.org
Subject: Re: [PATCH net v5 1/4] ax25: Use kernel universal linked list to
 implement ax25_dev_list
Message-ID: <sijkuyypbnelg3w2shbxm3y6zu3qhfurvpvkoij5eluolnqr5w@y5dq74ycxzkm>
References: <cover.1715065005.git.duoming@zju.edu.cn>
 <bd49e83817604e61a12c9bf688a0825f116e67c0.1715065005.git.duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd49e83817604e61a12c9bf688a0825f116e67c0.1715065005.git.duoming@zju.edu.cn>
X-Classification-ID: 3459c125-4b56-4fd5-9dc7-757dbe40275f-1-1

On Tue, May 07, 2024 at 03:03:39PM GMT, Duoming Zhou wrote:
>  typedef struct ax25_dev {
> -	struct ax25_dev		*next;
> +	struct list_head	list;

Would it make sense to replace this with:

LIST_HEAD(ax25_dev_list);

And then get rid of:

> +	/* Initialized the list for the first entry */
> +	if (!ax25_dev_list.next)
> +		INIT_LIST_HEAD(&ax25_dev_list);

-- 
Lars Kellogg-Stedman <lars@oddbit.com> | larsks @ {irc,twitter,github}
http://blog.oddbit.com/                | N1LKS

