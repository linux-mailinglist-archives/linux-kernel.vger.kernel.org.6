Return-Path: <linux-kernel+bounces-576908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B3DA715E0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5E5173A51
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7470B1DEFDB;
	Wed, 26 Mar 2025 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="DsLVm0+t"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643851DE2A8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 11:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742988889; cv=none; b=C29FqiYwH4xQggwb6No4irlZAwWvc7KHmPzucxTXSlknZgD5vysOaiJ/SC4t+kEtaxeX8pCzI/IDZZyumnYofVwqKhJ4h3ML76cy9mv9eyI4ZbE0Oks4zRcLPZ9HkoknICrg3ivufSTj2JH0Xz8tCKJ+5BgQAw6aKoM5Kn0Tvo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742988889; c=relaxed/simple;
	bh=LQlREbuhw8TtrSQMwA7+v95KY6p+jkaDHwJ+jdV+YTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmWplr+7MMfItIs9npJ+5Ek05K2Fqx0d7lVVij5zP5RPW2qUfQfPxtB/XKt4iyfq+NC3jATCzHJrfC/B+HUFvGqWEg+TNe8+FYSBFxl39W5Dj4vCUSNPxrz167IZdiBbQln69nikdWDpn4Mmj+iEuOV6rCShYsWuvEXGnYyNtaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=DsLVm0+t; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=DsLVm0+t;
	dkim-atps=neutral
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 4BA1A3AE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 20:34:47 +0900 (JST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-225429696a9so174291205ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 04:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1742988886; x=1743593686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I0EBOdLjUoNP4WLAtqeyEre7cO+lEkXao+VqDbYoEW4=;
        b=DsLVm0+tsKh9NllAn7wlcyrSGxqQRTnG2fqpZ0HSE061ZtZzCuYmid7hTimUYLOpji
         8knfERy5P/m25KcyV0VAvAWos3KMRrA1cVFbSpB4zYte0tM4yaKDK40ym2kqeWrNQu0r
         VjVfbe7mjpKzehupe3BmB7RrdbsLYzjszz1wSM6cKCTEl8/a44bNrzLW0LJ/ByRY8BIm
         830BeCCmNegaasG+SYrdmnKvf8aPg6wyLbQKJ9ndUXSQGQ70yRCBx9qjt23mTPXHcxMk
         klySnYKA5b+H0oO/O8nngtAtwOjGRdEUbNepUTQqHFT70f1hxFvPCMqtU9jRHcrJOmjJ
         +sEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742988886; x=1743593686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0EBOdLjUoNP4WLAtqeyEre7cO+lEkXao+VqDbYoEW4=;
        b=mDKKgeG/ERFhRWkMlCzpKiA1bA7yyaRHKMujnb6AkFpuUlZcc02pYuDA3465B1qmQY
         w1uFqn5aSxOBuhHMFWLrOuBYa4bLrinIJ+qDxhuAGdek1T8kgfGELEuZK6C75fdZedGc
         nWifDoHM3tIf9h8lQ+Daq+aIiMWjUfDTtDGfnF1W4cgV3RD9qwMicX540YQ1wxUJBEAC
         50k/u5J7hUzJIO4FuDgS5DU1L1RjLGrTW4G15B01NL+qduZ1qaXBlpsp9LZuIAiLFd2q
         5Qo+q0f62UPTXY+3AjcH+5M7pHsEwVqtuC57FQntHh+b5GA3O/hjqWpfGDcUzguj9MR8
         DdCg==
X-Forwarded-Encrypted: i=1; AJvYcCUk91RxT5MGfbJu0xSeVJ3mW7HwNqqq575a9C2Z9I7qtkiDcvVSOGIXmTxKc5YprphkSvrXe0npsLMf9L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWUHF+mSBKJcoSiM/5XBq8TAi5ACrda1+cRsugSJMEHgdbb5QU
	u9K7Irzh040JUsZ1kOuDlhKWwzPYpti4UxOB8PwVPHR7SNhplyxHzcJC8PFWCbKhAhvC15KspDX
	Bou2KNZUfqDDSHNUcpq78qQI4Wkvvvoq8k+mv4Ii4ig9NYz4HZNeHVJ9Id3iOLLM=
X-Gm-Gg: ASbGncsA4tIcLXlUBat9frykE3AXkr6b6lWTc/LKvhUvPYs/8BqMkZN2C8emDHsoxP9
	TeuO6Zcb0edOnv7N01ArpoC6nLWmCIW7AuRzqBCNmcMK9MtSQ+AljmcOh+TZ69AwbigOnup5bCJ
	cGC3fPXdBrOAnEZ7zP5ApusSXgjMa5aeQTjYjmCTMCYQdyjwB7UDoFVfBZzzivzbbg2Sq8/J234
	L5OuKOdjiob+pyqdx+/RFo5YgZUew9o/0idj6zC3HLuoIGOin4xElPje4rvjeR2grMNWi/WZ7zS
	dN2Lit4XAxevOrzwOHt7AujbUkJM7QhoefqjKRiqBJbamg+9513a4+kbnvJdYL2go/uQEwfiSaI
	=
X-Received: by 2002:a17:902:f54a:b0:221:7b4a:475a with SMTP id d9443c01a7336-22780e46a4bmr262392265ad.52.1742988886295;
        Wed, 26 Mar 2025 04:34:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGne8Dsw/FzoPIcfh+DvvXsx5JNmQUDmczbTum6IdyLkRnskQJzwKRbnNBiyWOmQFsRlxaMmQ==
X-Received: by 2002:a17:902:f54a:b0:221:7b4a:475a with SMTP id d9443c01a7336-22780e46a4bmr262391735ad.52.1742988885667;
        Wed, 26 Mar 2025 04:34:45 -0700 (PDT)
Received: from localhost (117.209.187.35.bc.googleusercontent.com. [35.187.209.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811f9a00sm107931005ad.240.2025.03.26.04.34.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Mar 2025 04:34:45 -0700 (PDT)
Date: Wed, 26 Mar 2025 20:34:33 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ahmed Naseef <naseefkm@gmail.com>, asmadeus@codewreck.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, oneukum@suse.com, pabeni@redhat.com
Subject: Re: [PATCH] net: usb: usbnet: restore usb%d name exception for local
 mac addresses
Message-ID: <Z-PmScfnrMXqBL_z@atmark-techno.com>
References: <20241203130457.904325-1-asmadeus@codewreck.org>
 <20250326072726.1138-1-naseefkm@gmail.com>
 <20250326041158.630cfdf7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250326041158.630cfdf7@kernel.org>

Jakub Kicinski wrote on Wed, Mar 26, 2025 at 04:11:58AM -0700:
> On Wed, 26 Mar 2025 11:27:26 +0400 Ahmed Naseef wrote:
> > I hope this feedback helps in reconsidering the patch for mainline inclusion.  
> 
> It needs to be reposted to be reconsidered, FWIW

I just reposted it here after this reminder:
https://lkml.kernel.org/r/20250326-usbnet_rename-v2-1-57eb21fcff26@atmark-techno.com

I've just remembered the timing might not be great though with the merge
window that just started, and now I'm (re)reading through
Documentation/procss/maintainer-netdev.rst I pobably should have added
net-next? to the subject... If it weren't closed.

I'll re-repost for net-next after -rc1, unless something happens to the
patch earlier.

Thanks,
-- 
Dominique

