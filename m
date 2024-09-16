Return-Path: <linux-kernel+bounces-330795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBA897A45C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F47C1C20DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580BB15699D;
	Mon, 16 Sep 2024 14:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="sh9Sn6pM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2A715820E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 14:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726497868; cv=none; b=AgprKkNaRpZ12ehirb6GLvzC4WGOcxc+Xmj4yYzln9cGN9bWaaJszDdweDsI5WfGbTChcnrG842pt2lJpbZHn2aoYi/JmGAISp1ZMContpXZWU0RM/guBP78im8g/repJfaK+++pOES9OmTUmp6Ugg4Ee3rviLvuw7iavE7macE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726497868; c=relaxed/simple;
	bh=H5QF6RimUczga0z6rsvRC8r6FhGexRluinZZWFAkNEQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jkF0dzRVeTiv7bELMnO+bGPSlKTAdIquVXENaaN5mnp1cYfxsc5ssrMS+nQ3jsV+nuPW03GUcJcJMmivGyCymDul+uJ3x0VSG9jQpRv336sZosVT8WF+TVUXilEQTjCaphXcfUR976F8+i5quxw/eb2jJqlENkdF8Ft1xkikOEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=sh9Sn6pM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0E3C4CEC4;
	Mon, 16 Sep 2024 14:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1726497867;
	bh=H5QF6RimUczga0z6rsvRC8r6FhGexRluinZZWFAkNEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sh9Sn6pM5KlKMozx63opty3YBVKdfMzwS/nJkJf82/RQEHzczFkZ8C0tpO6s6caFV
	 mgdONmK5HHiOf4PUEuixgLsafcXXV4iX7fiH5ixCsA3a/V19A++ILvxexJskprJF0h
	 aG0qYih6CXQ/3f2iB3kWlXbUv3RiXIYh+2gH7zno=
Date: Mon, 16 Sep 2024 07:44:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zram: free secondary algorithms names
Message-Id: <20240916074423.36ec570115c556ff0ab78425@linux-foundation.org>
In-Reply-To: <20240911025600.3681789-1-senozhatsky@chromium.org>
References: <20240911025600.3681789-1-senozhatsky@chromium.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2024 11:54:56 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -2115,6 +2115,13 @@ static void zram_destroy_comps(struct zram *zram)
>  		zram->num_active_comps--;
>  	}
>  
> +	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
> +		if (!zram->comp_algs[prio])
> +			continue;

We'll probably get emails telling us that this test-for-null is unneeded...

> +		kfree(zram->comp_algs[prio]);
> +		zram->comp_algs[prio] = NULL;
> +	}
> +
>  	zram_comp_params_reset(zram);
>  }

