Return-Path: <linux-kernel+bounces-444380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88E49F05E4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4CB284064
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF98619DFB4;
	Fri, 13 Dec 2024 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VgkXP/nL"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D947A192D70
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734076829; cv=none; b=HKQRJiPrS3YQ9LpwgiVn33f9tlrsi8IjBvTIIeNTtHP2MsD/RqL7cCPKlwMZX4UG+7mQaYZk504JcXoO0ZVpUOPZUERMm3qvJfsZWvhxbQ4ttKMIdEKTrx4HudQE7W/mojqRvYBRTXiAM2cSb4BcIpEiRx5zsLKK1lDhPmFNNqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734076829; c=relaxed/simple;
	bh=De+XKUlxdDAtzt4S9WN2Ib9SR9euZ6C9SeLMwL3zAMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OThvXSifL5ek8J6W5b9Xs9uT+L+uip4nuwxQ9VWsEGzb3owYxGVQiQm2pHOp2vjyPJj2tipZc0/rek/7v1zhbGZS6sXrO2ps7jRoQVzJSqW9LLpCA+q3Am6xbU69dxxahP7AITCjDkVvoHLJtIBBVlz5XeJ0manA4tRTbPfGkhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VgkXP/nL; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ef6af22ea8so1270988a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 00:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734076825; x=1734681625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+VcW/gT5gahGNm/Yx5OtnhIWsW1Q4wxzsxZW8CFyCo=;
        b=VgkXP/nLdEA6wgw/NvGoRuAJeAEpUjcdfMp4a5fRrfAWYR0JrMRaJ9G+KXZXZT8vjy
         sP4/8vt8amw5LQJ69+aa53IVMzVACCrL5lwVr5Ie0BYtYfcd0QDn2JdxMyrBQQjRnv8I
         lHccFaybScCGD3AIhDw8Vd8mqx2R4z7ZNOgtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734076825; x=1734681625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+VcW/gT5gahGNm/Yx5OtnhIWsW1Q4wxzsxZW8CFyCo=;
        b=m9xSFmrIp8s9MicG/HeqVEdkEMH0H/wFSdLBoKnjBOiyejyJHRVL+VR5hsJP3jvy1J
         fuYSQh4R76rzrmwwAnMabUZC4xiEbsKFfINXTAS2cIn3RaXKrEUWpxvXnh90/4qWw3vk
         b7TPmFZZoMjBVJgkzvr2MtV/bPARkPzKRWWCNQw4kFXeIIN/s8yvohfDDRaZmlgAyof3
         W6FfqAL9W3AKXVZHPGb/lszd4Uor/mh+U89SDEM/Y+w4zleADQLTQNBvvi00cRWbHdxC
         savAx5j7UJ2+qa++/hBmZdaYZbMSFVvq5IefyU+2TzRXJgxwO+sCKi4Upw9Oymiajqcs
         uAAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTrwg9wjcTXUGuPv2D30cvKE09QRSox9tpP6XWMy5AJ++s+EstZLanex5H64jVoc/xcpI0IXAYOsOl3JY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Y61A6fI6qlblE1fDQXpaegnvhenMXOHYu4L4qI8uKEooXYxc
	ehQk0R+b0K4lLzxVpRqgpWhevqMvJj1l0uBgH42YeAU6ZClxgiJf2W9m5KrG+Q==
X-Gm-Gg: ASbGncvYZ+8YEVJ50h7YMLXolwczhWmSGiFMXgAWGZ/Vlvk+kKZsOcBX+7/KKVrNjrD
	Y7511s7AICiercRfc+lYZu5oaPgt9MxOJseFlI5NyTpu7lPWxVioUhPgPGNDW3hmQtFsqWnFwc5
	2i/0q14JL9PH85lRBxOIcsCKQY1jFlhv1Fi1RbKRKa6o5trpZx2F842Uic1rO/98JwES3H1ZPWL
	9TQLEHhbtEms0ZTP01kBIGvlDBmlsGHvB1MHmEk8o7wuxhE+gAHD4Br0xRS
X-Google-Smtp-Source: AGHT+IGAG3di1prCf2zZpmnUtKcuvJ11czBwkHzRleM6YVn0pT7NTaRRJDPHKzAHCHVn3u7r0aeXMQ==
X-Received: by 2002:a17:90b:38c5:b0:2ea:8aac:6aa9 with SMTP id 98e67ed59e1d1-2f28fd77f87mr2308613a91.21.1734076825081;
        Fri, 13 Dec 2024 00:00:25 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:2d7e:d20a:98ca:2039])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f12cd09293sm2245435a91.1.2024.12.13.00.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 00:00:24 -0800 (PST)
Date: Fri, 13 Dec 2024 17:00:20 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: Clarification on last_comp_len logic in zram_write_page
Message-ID: <zod7krcdvew5ntmcpbpgzpan2yph6jz7tfao2xowh7c2wmbckm@vc3bsf4fsoyf>
References: <Z1vf/ladGMjeGpfi@HOME-PC>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1vf/ladGMjeGpfi@HOME-PC>

On (24/12/13 12:49), Dheeraj Reddy Jonnalagadda wrote:
> I am writing to seek clarification regarding the use of last_comp_len
> variable in zram_write_page function. Specifically, Coverity has flagged 
> the issue (CID 1602439) in zram/zram_drv.c
> 
> Currently, last_comp_len is initialized to 0 but never updated within the
> function. This renders the conditional block shown below as dead code.
> 
> 	if (last_comp_len && (last_comp_len != comp_len)) {
>     		zs_free(zram->mem_pool, handle);
>     		handle = -ENOMEM;
> 	}

That's a "known issue" [1], I deleted one extra line during rebase.
However, I expect last_comp_len patch do get withdrawn soon [2].

[1] https://lore.kernel.org/linux-kernel/20241211100638.GA2228457@google.com
[2] https://lore.kernel.org/mm-commits/3awo2svbnsv2mvozhaqspwztgxhifphj7ffpmykc35py6wp6ol@xlt2q5qgv6c3

