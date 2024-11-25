Return-Path: <linux-kernel+bounces-420456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9213B9D7B02
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 06:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09A67B21C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 05:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D772AE8B;
	Mon, 25 Nov 2024 05:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R+zB8iDk"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E34D537E5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 05:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732511587; cv=none; b=evq1OvR9fEQxt3SA9xc+MTLzIdmPJ2GB8lscjQ1LRokEacB61EErZD4plXQ+0hyFSvnHXB8r2RCTCXjnnf4xVP1WjpoHCgGvs/6PGnZQf7IY9r7xAFS7W/BXq1h1s8IOGBjXE1EvvxwCRZVFpS75JHz+0Q2/dSLLJFLSfZZCruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732511587; c=relaxed/simple;
	bh=Uxp3iPzfUnlFAtZhMOzTk6Quj5tPd+jppMxgxAL2OVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qksE0imGGc/ZaNMXl7KMK4qjFdE2cS3ez2UPOHesIt1U5X80QEx7NoxykK/ekjgRnpvuE3RR9+Q5N1VROfuA1oSdkQbNP39LlreO7qy3cSWn5z0F6PZD5wxEeQz5hanQ3tOXkwmNOCvmhXtdlOCapOlhTulh//LKhxfGMWe8o8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R+zB8iDk; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-212776d6449so43625765ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 21:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732511585; x=1733116385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AL0bPZvRR1BK5PQ1+xak6vqZ/ECTRZ5b4f4dhCxRKPI=;
        b=R+zB8iDk7BdqgDfwjF/vkM+4Nad2kgphcvCfHB9AVz+cxiXuaUGpQR68Is3zugtwJs
         7dlnfiLtp5WQEZjWP9Lhs62tYLtfaVyn7lIffGdsE0ND1ZUNZI1yLElCEblX/uBz1BOs
         27vDYgEsDiFHBotdBxAWreDlvmdqdHlVfrBLkFtnwh82DkANAawZQ1WB3LNKgrvN6+jV
         l26naEW9KHY93XTd3I6cOVwbM65RYc01pTDNHxjM5A1eRvWR3TXqPIsfmEuoflqKPiX+
         QNnadFKUPinD1wcnc9Uj1p0wUr/lw6AHBdKQ5WBTDrSILIcCzCRFVM7bqUL9TwDW6/XG
         uCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732511585; x=1733116385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AL0bPZvRR1BK5PQ1+xak6vqZ/ECTRZ5b4f4dhCxRKPI=;
        b=TiEM28FqV9aeV8tTOoFVSI2Hu1HXcH9OfhLwk4U6LQvF/qF/9Z6quQqef4n3MUBUkB
         o7i3wv6clD3Jw6hNl4hwpk3tlhhjH7u9W9fbCc8+NcscfibUB8WBpm2+uMNfr7yGlRsX
         YaP+j6/seOzuuieqGQFU8T2hnIm65bLL+iLpeMbz4ExrzVywZ6783Cm/UeiQUtjLxZHQ
         4jTQ6ba5zEmap0OtVKpEJqoJ3er3k4GDEWKM4beJyOe1kVFMP/9J6lUditGKrPKDru5n
         uAW0nGbwv4J8c3xc99t++Cui6cmatA8chg+dg1NpBbrm7QzD5VfBvr0/m36HqoXY7CfZ
         or3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJ/BWlzpDmIc8efaWvhzMRT20fp5nABduV4VEV32cljjbovtGic4zk6MMMl6jiV/0aH92XS6gKFKIMZu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN14mZNUqimlU4qxBeMV2zDQABLxUWsHJ4O6wz6AB7i/o9y907
	Vk3xktpNxwsSFEBJWFAHnEOJ3VZXW4I5aKVEpKddl4ZJq+ijozdQ2Mb9rO6QoFDpaNK+LeW+HEC
	Z
X-Gm-Gg: ASbGncv0yqZ5ccDWD+BpD5IMi66abGvl1FOf930bU/g+RNylo0b9QYQJvrBGgejbVAr
	2/1iHcKvFfK+w3kCHDER1Hsi2DxEBNApGZHCIgqmtx3PJSVk43RFkocI9Gn13sNJiQ84Ge5hpKv
	iK5qa8au+viC2WyWXsfEWG0AiA20953xTM4e18tGrbJyUDMQW6l0XlnUg7ULOE55IFmc2upFjXO
	BaaOFjXD/fAzfka/bPIN+Cb/WTluaqmU6J/MEthCKNR103KUP2G
X-Google-Smtp-Source: AGHT+IGb7tmx1BneKh/B9vmKsU5AzzHIggDnEW9pXM5m409dP4HngsAxqYc/QOBvt2L7HfqexG1ylA==
X-Received: by 2002:a17:902:f652:b0:212:655c:caf with SMTP id d9443c01a7336-2129f6122fcmr153868475ad.55.1732511585476;
        Sun, 24 Nov 2024 21:13:05 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba6782sm55270585ad.102.2024.11.24.21.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 21:13:04 -0800 (PST)
Date: Mon, 25 Nov 2024 10:43:02 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Kevin Hilman <khilman@kernel.org>, rafael@kernel.org,
	zhipeng.wang_1@nxp.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: fix using cpufreq-dt as module
Message-ID: <20241125051302.6tmaog2ksfpk5m6u@vireshk-i7>
References: <20241103210251.762050-1-andreas@kemnade.info>
 <7httcmonip.fsf@baylibre.com>
 <20241104201424.2a42efdd@akair>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104201424.2a42efdd@akair>

On 04-11-24, 20:14, Andreas Kemnade wrote:
> no clear idea how. What aliases should I add? The cpufreq-dt-platdev is
> not a real driver, so I could not create mod_devicetable aliases to
> match a given device. It constructs a device under certain conditions
> depending on the board compatible, so no simple list of compatibles, it
> contains allow and blocklists.
> 
> cpufreq-dt then binds to that device and that one can be built as a
> module (which then made cpufreq-dt-platdev also a module, causing the
> trouble). I do not see any benefit from having cpufreq-dt-platdev as a
> module. ti-cpufreq has a similar role and is also just builtin.
> It does itself no real work but provides a device cpufreq-dt then binds
> to.
> 
> Handling module removal would probably need to be added and tested. I
> feel not comfortable having such as a regression fix and for stable.

Applied this patch for now (with some changes to commit log), as there is no
clean way to fix this for now. Got reports from other folks too about it.

-- 
viresh

