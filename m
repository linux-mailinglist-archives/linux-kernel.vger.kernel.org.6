Return-Path: <linux-kernel+bounces-232838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B40791AEE4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A421C21FDE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA0619AA53;
	Thu, 27 Jun 2024 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfDjUMmT"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDFD13A276;
	Thu, 27 Jun 2024 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719512389; cv=none; b=eyyUvUqoTb0msOwiS+URHO6G2o2l/zNonpmd2/CV4sD71rRNnjs9A8MDcWKpJBFBJC5hU4NzfM9+VxyrAzwpQM21ZoaeWer6RZzOINx+3HBun/TM2Gyc1X+Gys9+Dtz10mis9DMN1baJWhMuDPRttNQMeuN22EJ+ApTqD5YlQ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719512389; c=relaxed/simple;
	bh=S4yZTjNdAasOLmi/6sNO0zqGI1eHp+DjtJ00j4c1U8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpbXOWNUEavLC9kIqesosdpl+SLj/GgLmzHQ7U6RAzPg16Z1eFDAVy+09equ61LIFdKYnodPjxUUl5JaMQRenGlxAf8B3GH7LBY5uaeb+f5G4NEyi301Pc/g4ysfmWdx9TUUbNr8wL8TyBMam/AUEWRhhRuSQhC4Np9blStIVxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfDjUMmT; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7024d571d8eso6392996b3a.0;
        Thu, 27 Jun 2024 11:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719512388; x=1720117188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62JiO+TkNEq74EVObdgZGlo5gS5AEmMQRPiPucmgw2E=;
        b=HfDjUMmT05LgrNU2EMCtvTuaZ0wEN/4BPWuOYyK66YVMfyQBYeyVqnVV7VrGmB6r+S
         SWt/WxxpRy20OyjRzqBzerxaR9UIQwoOa41DLv9mt0PByMhofMjmQNmwu3EjA77jM09a
         MZk2jad92Z3fI4GP9kVOCuQRBI/dbC4mq2r8DvaPfg3tB/RKiilJW7ZXzQqeCSLVOhch
         xjPl/bd1sqF0wxgPTd6QwbvcwSNqGzh2clsmhMDh24w5X7gPY94IcFF7pADJc1ct4rKI
         uoVqLr8EDdUQyb3H7PECPUBn0eeoqfvVff3lkn93Dmd7ihDI64z5Fkgglg5osoogZnzV
         vQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719512388; x=1720117188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62JiO+TkNEq74EVObdgZGlo5gS5AEmMQRPiPucmgw2E=;
        b=mlajJfc00MshD7A6xDRbGyO5u4UaKE5q4oW3CI+DTyCoWg06L3qBAB+9/vfZ9NTcmi
         hbzXV+o68LYibf/fQO0B7Z/sZjeJoOmXEZU3c9EZWYz64kttgfN3RTntIozokdNcgm+x
         TdaZ/QG/B6hjbZrOxerNI39jcFX06D9XrPTU25tlRR5cwOISKnmUGP9DcXJpblFafg7H
         EBsq2W9yESkokSme/Xc7T2iANeIYjmd3xgCWG6zI4XeL9oVWJBGfQFhU4velnpBu4pMu
         aSUHAUE54xoW/45RCTnoDH8uK/z/SegX0aeJH7YshULg/0kYXBZ9EWO+yYxJqgoluvae
         pRrA==
X-Forwarded-Encrypted: i=1; AJvYcCWmomBQDyPfNn+54Fm5cuavrQp56WZlN+EhzsJ4qN+imHAjj14Z5GY/NmB1zm2uHCJwDlEDgiarR3HtWAENyopvrRQ2+gB76meGafKHUNDfAy7bSs8jzdpiScLjV96h2VXVIJ7Lobf8OXUBgOWw
X-Gm-Message-State: AOJu0YwZKOsQxA4pmST2tzlOax95/TrB5vTlKaoRbqGNUpo6Pub/Hi/V
	euDslhgZxoHE3iIQYEStUILEkBTFRyru9x/dlMQ8Kdzk+m6M+L9sPF+1KQ==
X-Google-Smtp-Source: AGHT+IEl8sgpfds4KPZSn+LUFHWqwLNrS0W6hvVZB9wSF0P+9VAusVh9Nk7XVIJ/ZGuXsmK2xAJHtQ==
X-Received: by 2002:a05:6a21:6d98:b0:1be:d299:d818 with SMTP id adf61e73a8af0-1bed299da48mr3100401637.14.1719512387749;
        Thu, 27 Jun 2024 11:19:47 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15691ebsm541075ad.213.2024.06.27.11.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 11:19:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 27 Jun 2024 08:19:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: David Vernet <void@manifault.com>, Josh Don <joshdon@google.com>,
	Barret Rhoden <brho@google.com>, Hao Luo <haoluo@google.com>,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] sched_ext: Fix spelling mistake: "intead" ->
 "instead"
Message-ID: <Zn2tQpNQVAHtGo7h@slm.duckdns.org>
References: <20240627171132.127421-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627171132.127421-1-colin.i.king@gmail.com>

On Thu, Jun 27, 2024 at 06:11:32PM +0100, Colin Ian King wrote:
> There is a spelling mistake in the help text. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied to sched_ext/for-6.11.

Thanks.

-- 
tejun

