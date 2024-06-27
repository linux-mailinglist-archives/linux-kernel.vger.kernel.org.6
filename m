Return-Path: <linux-kernel+bounces-231971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726D791A0FB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5C05B21B91
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3DD73176;
	Thu, 27 Jun 2024 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b/W57GPb"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04316F2F7
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719475011; cv=none; b=P5sbXdf0arsk3DWvWCFFAu+ESiqqYuOgf6DXyct5+dulKTADRT0O0It+TwBhXb7zFMqwV3tc3OsogpyzMJO6lXH32IBkh2whlkxnv1sxFTSjx/WFCsmGUru4tfqCz4e5JvBbOsLEngmkmc3oF53Y9TzC+pBv1GMBeDIHcLCiii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719475011; c=relaxed/simple;
	bh=YvK0YOGglF6B3qVLLvjIk3198NBvybzRxx+tGQ3ZOBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dw7dE34T+7tiEiQ00IZtUjzW39lxJtvVlLzt2UWTnioDmKaj4X/I71ryE12CDM3zSZfDLr2ONnDds7gkD999njWmoMNNdgi/X895td01w19/fEPOfmtpvCZPTIqzuxxn7iIoDwfv1yUSBMV2lhlanoB9fYQ/Fuu2ncQB6nohlEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b/W57GPb; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-362bc731810so6653210f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 00:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719475007; x=1720079807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BeKAKFTiJoXvGxvP+5QpWS6/6iqSauWGWG3EsM7sPNU=;
        b=b/W57GPbGTbKuojJ+2xWHjRH7l0reXezR30bDZDITRZEbYwkqreYPpZ/En9AmuwMy9
         ULoup91gRO9PM7wdV2meiufYLdj46276URQJCNypequsZ7FqwuGP4cVYljHN8+gCn3Us
         YtJ4V6MxHEitnY15WV+oMkg5Ontc9wER9Ap3flew7LHPKRGcdxgZGA5oS+iproUylwNN
         w4BPvJGboYztns2kWDyGFIjZdesZo7i/BYMNbUi8N+8bzFC9ok27p7ag6mIR3BJYBt+Z
         MnWXCbtDXLGPJWzyiIXhxhMxnBYr0yDt/MxCg7B4HIsTHbhT3bNnTlO+r+Clm6D5Crtj
         0Hvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719475007; x=1720079807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeKAKFTiJoXvGxvP+5QpWS6/6iqSauWGWG3EsM7sPNU=;
        b=pWCfBaoMmTGMUsywtSWA89LXmbddUCIRVH74Wcessn0lz41EnoGdbq7Si1E5lzGp4R
         +1lRHFPz3Us732uUncFXUoKmEHKvs814BDTiiKrRsW/dr7RdR1QohuUrn22dISGNtZgJ
         WWYCMmf2pW8c2WCY7PLoXR7eIV3ubf4Q28nCdQf6fbvd3wKnESiZgtkEtRmPD6si9tTC
         yFb2un8E2Rn9/PTyK3DWxXpFmIeswiKtyoJY8IXVcZSOCrSzpcKh8WzNfAPt0XbdYgL7
         FIXieK1jo/ZXwceRZzVzaC431ztHqlVCP3gRXAX8M13x68PNXVH4y7ggx+FH2DRB8n9b
         Xysw==
X-Forwarded-Encrypted: i=1; AJvYcCVWhhXO6SYv4mG5AtQ/aPcGXem9I8URgowdZFoyw3vGSFDpdst3gvAUnYPwMi+2ESwaN+iaD8dXw6QyMs6w3FMuxqb+/RfaaJnNKFmO
X-Gm-Message-State: AOJu0YxRl/DYJGq8aslkXkLKKmzdNgljvKC+ghZ7q4hIY8oh0n4cbsPs
	8x8jEiuFkBxos2+fQcDV+GNPYxJketechyGIC9P8TlIswRjrOa7cng26b3BiQ/0=
X-Google-Smtp-Source: AGHT+IEuZ1HDaPcVZDfQybhQ/xjKpMr79NpY7GSaA/6MF2nq1gD76fXLybEUy+vkW/wVK3o9l0m8Iw==
X-Received: by 2002:a05:6000:1863:b0:366:ec30:adcd with SMTP id ffacd0b85a97d-366ec30ae93mr12260267f8f.7.1719475007239;
        Thu, 27 Jun 2024 00:56:47 -0700 (PDT)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d72032csm34726766b.83.2024.06.27.00.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 00:56:47 -0700 (PDT)
Date: Thu, 27 Jun 2024 09:56:46 +0200
From: Michal Hocko <mhocko@suse.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jinliang Zheng <alexjlzheng@tencent.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Tycho Andersen <tandersen@netflix.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] memcg: mm_update_next_owner: kill the "retry" logic
Message-ID: <Zn0bPrHrBGwdrGwU@tiehlicka>
References: <20240626152835.GA17910@redhat.com>
 <20240626152924.GA17933@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626152924.GA17933@redhat.com>

On Wed 26-06-24 17:29:24, Oleg Nesterov wrote:
> @@ -446,7 +463,6 @@ void mm_update_next_owner(struct mm_struct *mm)
>  {
>  	struct task_struct *c, *g, *p = current;
>  
> -retry:
>  	/*
>  	 * If the exiting or execing task is not the owner, it's
>  	 * someone else's problem.
> @@ -468,16 +484,16 @@ void mm_update_next_owner(struct mm_struct *mm)
>  	 * Search in the children
>  	 */
>  	list_for_each_entry(c, &p->children, sibling) {
> -		if (c->mm == mm)
> -			goto assign_new_owner;
> +		if (c->mm == mm && try_to_set_owner(c, mm))
> +			goto ret;

You need to unlock tasklist_lock, right? Same for other goto ret.

Other than that the cleanup makes sense and it makes the code much more
easier to follow. It should still die but it can do so in a better
shape.
-- 
Michal Hocko
SUSE Labs

