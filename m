Return-Path: <linux-kernel+bounces-321375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC419719CD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19801F23219
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF521B81CA;
	Mon,  9 Sep 2024 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mMB73AYF"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009B51B81B7
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 12:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886041; cv=none; b=P21nDyTb09GyscKWXWaEi0RmzmLwB+zwfycpQyYNaSLk8L6JZtzXZJG2Swr/BSuMmTHzKD3gCddC/B4E43l2mG7CvdxpjkKYhME8RS6dpE/WnWCPqVO7MVaqE7qPdHCgSSPVmwHI33t7/vILiD4MbVgoa/dG9l7jPGkYf1nXmIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886041; c=relaxed/simple;
	bh=olgYAQFE70KObWliJ+bbP5Exly3fzgalSSoMAsFCD8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VglLugLRkzio7nWTVtClM4PhDx0Qqf9d7/rs3Fppqawiu3LiJJSdd/XExpJlfolc810sGTXyClz4N/JKGCeFPCDB72ZpGq4c0lLLUDrFtyWTWamnlkjrhV/xWT0hk3TJEC8SouxNwyS0vb1CakS76+fFxP04G7+Wy/TewOK9wdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mMB73AYF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cb2191107so10626445e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 05:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725886037; x=1726490837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jFdSn29D2vbF5C5b2ylmb59wYWeic4q4prRLAv5rTI4=;
        b=mMB73AYF8s7M1E0gHPsg4gv5tdmMd0TCSyyGDs7/g9RV2u/ymNPViBWHnV11JA8LBt
         QG2B3B6igkRwVPniwDWgOj26Gp9otY0PoSTZo8TSRv1kv4bxyOwNKGeBgvVDMO5FUa8R
         QYWwocrkbxxbRWzo9wyjMTWfgV083Q7EvFg+8y2Oeh8mt+qGX0zI96OfiBom8hsBocsN
         DBroFOwRsRYuR8KsQotLvrqYArK1CU1toFE7Zbe8Eh0eVdT2ur478DBeQZOrZbWJtA/e
         Zx//jrJ6B0jja9LWZv/bzGQYg/KpeVzaIsGuC01+YjaLixgRJRxihUN3gYH44xLSMait
         Pjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725886037; x=1726490837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFdSn29D2vbF5C5b2ylmb59wYWeic4q4prRLAv5rTI4=;
        b=JidTI8cZkBw/i4vX8RMNigzQVvXIAGhbAwqYFRG3r+0lD6/F1ncp/GG1LTjWlkmS+Y
         sNrkszNF8MxrWvHREoQCM4Ct6ApOgL31Nd2tUrypsinNAl5GOYvwVXAY8yEdpkJLOiTO
         DiDn2DvQWCwaEwP09Djc4WbHhtaEp2rRACngNR5ODAikgKJ9J3G7xm8NAd4DOPg3xwTX
         pkClFFNDmal3YNsmqUBZ48T0YCxe+nhnr/07W2AmJAR98E53ghJGBPQ5RV30e+wK37fP
         YE/ezFTmcbpm05W+h5kxHpM4hqqJhyuQ/j5JFtZ/fWrwiPv9V/GkfABkRfMBv7Mrri0n
         9u+A==
X-Forwarded-Encrypted: i=1; AJvYcCWLeKV3uvLL+VAvQV5LNFBaw3iZsdmrwtau0z+cGBVVNftQcX+FlIorvnwXzwdZHJnO944Almy3aqN0fLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxrznkN55896b4ZPy0TLnycAnBWUm5oB7Mw6YBDH64YanmpXhg
	XdsW8mQOY66vs5nJVcIt2aaw6egAKxbXOzEEqeIjjBXqXXmew/SL6O3elpzfrX0=
X-Google-Smtp-Source: AGHT+IGNVpmNYEMCrZnUHl6rM1WqQqMqFiNR+myLEWeiswQRFxR8AFfvou1NnDq7soxmYBAG5Uzmug==
X-Received: by 2002:adf:e64a:0:b0:374:c1de:7e5e with SMTP id ffacd0b85a97d-37892727dc7mr3791168f8f.54.1725886037310;
        Mon, 09 Sep 2024 05:47:17 -0700 (PDT)
Received: from [192.168.0.172] (88-127-185-239.subs.proxad.net. [88.127.185.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb226ef2fsm58370845e9.13.2024.09.09.05.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 05:47:17 -0700 (PDT)
Message-ID: <b2b8b181-1bbd-4925-9d6c-40c4b9e29743@baylibre.com>
Date: Mon, 9 Sep 2024 14:47:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] ASoC: mt8365: Fix -Werror builds
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240907-asoc-fix-mt8365-build-v1-0-7ad0bac20161@kernel.org>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240907-asoc-fix-mt8365-build-v1-0-7ad0bac20161@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I'm embarrassed, my apologies for this oversight...
Thank you for the fixes.

-- 
Regards,
Alexandre

