Return-Path: <linux-kernel+bounces-268262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DB0942255
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76B03B22045
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3FF18E03F;
	Tue, 30 Jul 2024 21:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPMv8qZB"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25529145FEF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 21:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722375837; cv=none; b=A64HJ+tvsLQ3cJOlFq7nYhNnTDZ61GscevuaZnrpcwmAQmXHL0Z1Eqqi6P/D15BoDsfOGGJhB5aYM8JwdKhdqxYTfB1VJsKs7y3evJh6817AiFSgENsw73fkyjzfhaunklDeHdovQAcq7NXWmVORS/7V6o60YdhLay53FTJS/Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722375837; c=relaxed/simple;
	bh=H4k4uuz3MtlOfS35S3ZYJRnGiD/5CiwPKIQIVLza/AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKXw4B+Eva7FoDTxgcI6DUYSv5w5Hvn/koSVISeinUJ0AIWNo5H4x07DvMv0Wl5Qpe/1QJw+bXbwjSFWdeFWB6lDEYLybCAeKlJFsaM0UFiQMymA3YXDLw/q1qD2lHL1OlwP4eXZqnIi/Yc1TsZxUWxquWlbMxzSxYyfC7qgXac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPMv8qZB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc52394c92so43243805ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 14:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722375835; x=1722980635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wjWFy0Xz/59nG7qfbsVp42f+aWtmhJqv0OIpDlmrsk=;
        b=PPMv8qZBLI1MAvFUNhxEKk81vjIZFwNxCgTzjFf5yypCwaPb9FI3oyjDODbHtEhUc1
         858Z6+IKWM0SLYbeeEBzmV9AnLF8vuv4K10Jig0fuDbDBzX3t9VAzYB3FBCkZ4SnDzK7
         o8gE4WTOzGwDhaL+fVV3h7gtbeA3dJkf9wmxAsNLGjmq0TLaGj4UisE5kfbbzx08eeNB
         nQJcjNIXcr+q4tn2j1A4ZozPglzVrUxA6GHojxB7v7XIkUWuXV3MWjHOLsgBlkdqk11b
         EFPqFlTpnLdpVYyKS4J2Vd0G5XXomDDxtjOqk6lJBiOSW9J2fSaPVrMnhqfgqfj/lX+/
         Ehiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722375835; x=1722980635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wjWFy0Xz/59nG7qfbsVp42f+aWtmhJqv0OIpDlmrsk=;
        b=aLjp8uQyUxUhs923/mbRD3W0mXzUUwqCZZcWGD9IEuJ2SxQFeYJkvm+0w1UhxT4ByD
         UvpoUp14eRJWhE/sNRY38HJoo+My5lcX4HZzesl0kQdoWZrHUH0TV8REZ82a3SAnhcSi
         uceHpVkPK13EOM0o50qImtepRawNRrpN8BPu3tcwJTSpWMN2xfl7q02jrzBEBxBnQJK3
         fRAJuFSPW60V4Kwi5Ez3cldQjvmipnCvjxY6mfpLHnt5PLbe6o/h8vN841O61EQHe27W
         oHRm7RkAgO0MjWiFJAhSe1k3US1cQflRRG6a66TDvqFCO30uZt4vDxdmREhoi3oET6t9
         Fzqw==
X-Forwarded-Encrypted: i=1; AJvYcCUosT6lbMW6cs9NJx49mCl+gjOoeQF2Ukp7FKwN6LAOov5eY+IpeGiDfqIzXPllpL04E59iCp9pL6u+ehjxF9VnfeI5NORZXQWncrHc
X-Gm-Message-State: AOJu0YxINRmfss6FZZkpUIFVn/kFL3ufC9XXqj2X07TkDIuPRTzlKGEp
	vV0c0pVTL583B/kq6UqMJ7oB3U9K8IkSt+MWGxkWq+uLIBqst6dwLjedHg==
X-Google-Smtp-Source: AGHT+IHeMy+moFoHtf2qXQGlrUIWtADl1bXFwBfFEnMpcRqlY0cYLhmyjKpBr4Kg726xByQYei4zug==
X-Received: by 2002:a17:903:1246:b0:1fd:9a23:90c5 with SMTP id d9443c01a7336-1ff048b0447mr170350375ad.49.1722375835230;
        Tue, 30 Jul 2024 14:43:55 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d292casm109676705ad.111.2024.07.30.14.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 14:43:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jul 2024 11:43:53 -1000
From: Tejun Heo <tj@kernel.org>
To: Sangmoon Kim <sangmoon.kim@samsung.com>
Cc: youngjae24.lim@samsung.com, jordan.lim@samsung.com,
	myoungjae.kim@samsung.com, Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: add cmdline parameter
 workqueue.panic_on_watchdog/max_watchdog_to_panic
Message-ID: <ZqlemexVxV0LQVGR@slm.duckdns.org>
References: <CGME20240730080541epcas1p144c86d09c0141102bfd89e58759b9140@epcas1p1.samsung.com>
 <20240730080428.2556769-1-sangmoon.kim@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730080428.2556769-1-sangmoon.kim@samsung.com>

Hello,

On Tue, Jul 30, 2024 at 05:04:28PM +0900, Sangmoon Kim wrote:
> +static bool wq_panic_on_watchdog;
> +module_param_named(panic_on_watchdog, wq_panic_on_watchdog, bool, 0644);
> +static unsigned int wq_max_watchdog_to_panic;
> +module_param_named(max_watchdog_to_panic, wq_max_watchdog_to_panic, uint, 0644);

Can you combine the two into a single parameter? Maybe name it
wq_panic_on_stall? 0 disables. >0 indicates the number of times before
triggering panic, maybe?

Thanks.

-- 
tejun

