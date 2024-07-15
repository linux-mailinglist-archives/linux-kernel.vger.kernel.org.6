Return-Path: <linux-kernel+bounces-252996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65210931B00
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973F21C2199A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608F11369B1;
	Mon, 15 Jul 2024 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJUUsQRX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4326481D5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071684; cv=none; b=gIx47zsR+qX4tgV+ks3eYHTVE577YFEuk9UBQqWbeXlbiabTjYiGPxSJRFVADbrJVRbQGysJAKyRu9skZTIcUvAjrxVjil18Kz4glGOQleCYJ58wv2uT9eNdvzdt2ZNYmt4pD7kre1HGf8F2jaoLpDjqmdRI2rYR/r3dh3xNDuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071684; c=relaxed/simple;
	bh=+cAcwfu1XFM2Re2QY6QGILP5HW9nUKA+nnTHqTtfNcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzFVWF3ASPJoMzwQpeVZYxOCe47b8+i8gK4wftKxyJN9MpcvktSrc4GKpXm5oFgmbTo/OsXMfhjtPg1Z5e8ZsDtVdZGeNLmabDdg+7QCFPJDLgncUxqhAKJuosgHW7LULi4vW61CKnxOhL6jJQeJ7b5MdQgvUNSV3EW/d62eMuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJUUsQRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C3FC32782;
	Mon, 15 Jul 2024 19:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721071684;
	bh=+cAcwfu1XFM2Re2QY6QGILP5HW9nUKA+nnTHqTtfNcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PJUUsQRXHSsJv9XuuUyu68lhpJdLcMM9EwiLUFnu40Lj82cnZLZ3FFz0cAZV8CYss
	 SguMWl3A1+eaB5te3/RJJlW7YB4xB71OULE4oC1pgC5YEztzYFH2nUGoo3ic+JObye
	 MfPFHYOHNMj7+nD8UmSgP+f7nL4YNYtUjplJuUuCYu7GIh3jqPbwqMLRlcsH1UfVUY
	 JL/XMG3c74UVRGKJuKfnQf2Rr6Ah7RtTEi85kGapE5jsS7rMKpG0ltOW3LBOs0kFwZ
	 4F1WGp3y+YfYNRCB0XuYWQB8ROV11JmA35I97GuIHZBhgFmysSR2qxSh/jfLektMv/
	 27iZgkeVwMryg==
Date: Mon, 15 Jul 2024 21:28:00 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] timers/migration: Read childmask and parent
 pointer in a single place
Message-ID: <ZpV4QLnktCXcuNqG@pavilion.home>
References: <20240701-tmigr-fixes-v3-0-25cd5de318fb@linutronix.de>
 <20240701-tmigr-fixes-v3-5-25cd5de318fb@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240701-tmigr-fixes-v3-5-25cd5de318fb@linutronix.de>

Le Mon, Jul 01, 2024 at 12:18:41PM +0200, Anna-Maria Behnsen a écrit :
> Reading the childmask and parent pointer is required when propagating
> changes through the hierarchy. At the moment this reads are spread all over
> the place which makes it harder to follow.
> 
> Move those reads to a single place to keep code clean.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  kernel/time/timer_migration.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> index b4391abfb4a9..a681cf89910e 100644
> --- a/kernel/time/timer_migration.c
> +++ b/kernel/time/timer_migration.c
> @@ -535,6 +535,7 @@ static void __walk_groups(up_f up, struct tmigr_walk *data,
>  
>  		child = group;
>  		group = group->parent;
> +		data->childmask = group->childmask;

Should be "data->childmask = child->childmask;" ?

>  	} while (group);
>  }

Thanks.

