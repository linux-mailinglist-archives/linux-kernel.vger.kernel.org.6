Return-Path: <linux-kernel+bounces-206798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5811F900DE5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C351C214AD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF49B155300;
	Fri,  7 Jun 2024 22:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liYB0M3B"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EEA153517;
	Fri,  7 Jun 2024 22:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717798116; cv=none; b=YU3FcM25ZMm5gzTJndnZbmqlzACoC0YbAqWSJudAg1BhatNnLkDk7iaedB3GzNp8FyaiO2bRbX8O5IHiVeB7EhdsEHx4Qntnq3uHnoIDy7By/5fAe8sks99IvnPH7OggtUoGoPgIDRMWlBu8g5f80lQrnT0PaRBBMDNwYx/9kUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717798116; c=relaxed/simple;
	bh=X0XqUrYOJ+/axRTziCgVjNc+Zqgi8AfvSjUQVzmbmZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0LRSXci457jLSBd1O2+7DjCQWUQjQ5dy5XMIk5RBLyk78bdc9XDI0pHEVAacMN/rl3FoWg4XoxnzaeI9QkX0ug56eLLGk4ugWPrNdEWo3n6fRQT2NrEip0Nchwqgobs73lCILG6gBatTVGtrdM9WOxoZbiGoP8KYggwK/wgJEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liYB0M3B; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c1ab9e17f6so2324421a91.1;
        Fri, 07 Jun 2024 15:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717798114; x=1718402914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tjL1fI/IK1fmmOTt7dCYi2cVdCScqaBbh8g2CZYU+V0=;
        b=liYB0M3B02DGx9P26+TTL/tPUzWnl4r5MdoA4hbQy5BeJ2WUjhmvqPNd9NUyNArOK+
         xbas/3hQQZN9D1JC7jnuEaAtfUUjemtJUrnQp7LkZmggewbFXYjZsz1CgAmWtuzaAJbM
         qZKp+Y7eqLI2oFM96IGQPtGQrf03jSyZfl3HZcPqsD/mtw3x2SRhESxaSRtqdpLT8as9
         styvefFzpiSSIaxfp6395DMxn/pgcBGescVjV1WxI5kylCWs57EH04AQprKtstHQm6Rl
         4BrmcUdHLmYVDvd7rX3g3uhhwwN0wfL15Wu4LLWFp/QU+Nh+4nq5u2/1n3ARWg/s52jX
         CI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717798114; x=1718402914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjL1fI/IK1fmmOTt7dCYi2cVdCScqaBbh8g2CZYU+V0=;
        b=ObI4HM93uQnNVcmNxEE5zrUTzYN7nPP7KAoaIUNAWmgHBvEr/FJspv7HGsrfU/h/sn
         WB+8PImSwAnHY8y+EHSJ+0c0481+C7QST65GOxYerADM0DRsErDK7/H9HOx2muODp+xb
         qEsJBaVxtrc2Bc+RIDc3G+nQmOUhw7Pgigu+Rd5hQLS0Hv76Kfa2vVJl//9MNAwMricA
         QdTrcof2Jn7zmICHIihPAPKCa0V+XYPEEXQijbOCNLYvnL2dbVnLE9A+SexWTz0NW/h3
         qRsQL3ZVrp4rpAgQ7DQP4xwoCwczvi5L2sWa3YfC6qdNaQvvsGvIlgVoekrdasyKtExO
         xFRA==
X-Forwarded-Encrypted: i=1; AJvYcCVm69D6QD1NUjVpPHmEV+7TswyWi4LA2fq8cjnxCQdRgiubSVnRjaDIAulsv0txaFIN9z2cXT9z0YsGT1441G+ZKyaAOoqcx2bXbMxAQQr4usIrbflFHkLuE6MC0iuZKvDYwZcTxtldkGc=
X-Gm-Message-State: AOJu0YxPppjzDUzAjaBLMiMZtkpRSRElgIgV1VT9c4ijc7Cl2xGxnmM0
	em+vrb64n/I6UjkJf9xMbpBdu9W8DFVX4ny46o2eQgIg0NjAW5LR
X-Google-Smtp-Source: AGHT+IGChmawK4zkE+D9W9szWfv9Cxmt5l6QBRHfW8hRCsjYoduvbVXQaWQ2Qc380gHB0D26TQ55eg==
X-Received: by 2002:a17:90a:788d:b0:2c1:ff35:78f5 with SMTP id 98e67ed59e1d1-2c2bcaf6920mr3740683a91.15.1717798113686;
        Fri, 07 Jun 2024 15:08:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2c661f8basm1830971a91.12.2024.06.07.15.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 15:08:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 7 Jun 2024 15:08:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jean Delvare <jdelvare@suse.com>,
	Tim Harvey <tharvey@gateworks.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (ltc2991) use
 device_for_each_child_node_scoped()
Message-ID: <6416e24b-ea6d-4b3c-9803-b87ca5aa43ca@roeck-us.net>
References: <20240404-hwmon_device_for_each_child_node_scoped-v1-0-53997abde43c@gmail.com>
 <20240404-hwmon_device_for_each_child_node_scoped-v1-1-53997abde43c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404-hwmon_device_for_each_child_node_scoped-v1-1-53997abde43c@gmail.com>

On Thu, Apr 04, 2024 at 01:13:27PM +0200, Javier Carrasco wrote:
> Switch to the _scoped() version introduced in commit 365130fd47af
> ("device property: Introduce device_for_each_child_node_scoped()")
> to remove the need for manual calling of fwnode_handle_put() in the
> paths where the code exits the loop early.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied, and sorry for the confusion.

Guenter

