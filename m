Return-Path: <linux-kernel+bounces-172530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 051008BF323
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5851F22C34
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5402B1350EA;
	Tue,  7 May 2024 23:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b="czZj2bFr"
Received: from smtp91.ord1d.emailsrvr.com (smtp91.ord1d.emailsrvr.com [184.106.54.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6265134404
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 23:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715125620; cv=none; b=oC7OxrN3VfE2jApWQ0Od+w4I822SFz8NZLCsuzEaBSn1Y65aKi36nvRF0nsa4SDlAke+49C9CifXE9l/keFitCPWT5QUG6hpuKPBb4oZ6tGdtA2M+6XnYwSKp7waT/4FgIcKfE4yJejcugHxddOgd0UoEfSiG8WysRjOg0IMY+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715125620; c=relaxed/simple;
	bh=/TOv6fP0vQebAxVEplVjdQOI2uzzY71yM9grBNcY6Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWqqIJprOMd0TSYp87kJ3btzXi56rEO9302PCnMRG69cgSooObvTZ+8yllATcE/EHYIEVfr90vHkXyagi9LGaKc8ekPo/EDII9swMgT4lNS9q16n7O4keNtOfIBpDz53LZ5PHc8fi910kWIDodeW+0DixbkRE+xfK0gq4urWeGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com; spf=pass smtp.mailfrom=oddbit.com; dkim=pass (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b=czZj2bFr; arc=none smtp.client-ip=184.106.54.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oddbit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oddbit.com;
	s=20180920-g2b7aziw; t=1715125612;
	bh=/TOv6fP0vQebAxVEplVjdQOI2uzzY71yM9grBNcY6Zw=;
	h=Date:From:To:Subject:From;
	b=czZj2bFrbwg8I9OB+pHUp343UlDFKC46ap8dR/xAGn1p+Bt65WKBMMTzsautPOHFk
	 J19fxMTqeqj6IJlS/daQySD6lbc2hSAAjcmQcHuB146QbwpBuJc3VDRh88oN11dLia
	 CWKVB/6mf1cbASHBLSrmGA6TMpJ5mAOFFouVrDKs=
X-Auth-ID: lars@oddbit.com
Received: by smtp12.relay.ord1d.emailsrvr.com (Authenticated sender: lars-AT-oddbit.com) with ESMTPSA id AD4E3E0099;
	Tue,  7 May 2024 19:46:51 -0400 (EDT)
Date: Tue, 7 May 2024 19:46:51 -0400
From: Lars Kellogg-Stedman <lars@oddbit.com>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hams@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, 
	jreuter@yaina.de, dan.carpenter@linaro.org
Subject: Re: [PATCH net v5 1/4] ax25: Use kernel universal linked list to
 implement ax25_dev_list
Message-ID: <z5l3dfardxqrwf2lzzpktuifqaxvv2clrgah5gnz4t6iphskeb@otrcl5cwyghx>
References: <cover.1715065005.git.duoming@zju.edu.cn>
 <bd49e83817604e61a12c9bf688a0825f116e67c0.1715065005.git.duoming@zju.edu.cn>
 <sijkuyypbnelg3w2shbxm3y6zu3qhfurvpvkoij5eluolnqr5w@y5dq74ycxzkm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sijkuyypbnelg3w2shbxm3y6zu3qhfurvpvkoij5eluolnqr5w@y5dq74ycxzkm>
X-Classification-ID: 0df3cc1c-0dba-498b-89fb-d2d91bbb82a1-1-1

On Tue, May 07, 2024 at 03:43:11PM GMT, Lars Kellogg-Stedman wrote:
> On Tue, May 07, 2024 at 03:03:39PM GMT, Duoming Zhou wrote:
> >  typedef struct ax25_dev {
> > -	struct ax25_dev		*next;
> > +	struct list_head	list;
> 
> Would it make sense to replace this with:
>
> LIST_HEAD(ax25_dev_list);

Sorry, *this*:

> +static struct list_head ax25_dev_list;


-- 
Lars Kellogg-Stedman <lars@oddbit.com> | larsks @ {irc,twitter,github}
http://blog.oddbit.com/                | N1LKS

