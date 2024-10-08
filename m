Return-Path: <linux-kernel+bounces-355667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB03099557A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5131F24412
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95841F9AB1;
	Tue,  8 Oct 2024 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSahTHSj"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77161E1A08;
	Tue,  8 Oct 2024 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407936; cv=none; b=Qev17iE+8t4I7w1NTdzURyV5KwT+I/O8tiLC8uskiTg3orp/llv3B9/8A+pdn8RsDBxUFgXIGtcACASX9ZmM+qDY5wJe5wnaL1sFiifF12dbHOLf8T8CJv0hINalLvhxV5zOF+TRdY14B3cuz1jBXndfesAuc4plvNEvw7Lu8Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407936; c=relaxed/simple;
	bh=FZgPYx7TBP9wJQ/hZZYr2GFKYq577ixYA5BIVu0+gWo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=re6aY+tD8QlmY9GHWQ6Hzy7rZSObjXD24esLchxUAlcVJQUXufRnqxdZF49U5OnOCqSS8ffKGAH1TJiqLNW4bR6QyZSAlNUlMnt7BWUX0MEFoVJd4q58dbtvhzlnRvOdV0N9RbetlCRjaA2d4BYhWLEbKHQ/XTGQyxFjoBtkc60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSahTHSj; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53959a88668so7423633e87.2;
        Tue, 08 Oct 2024 10:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728407933; x=1729012733; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbVzk8DseAfkG3gNp5Is1zNFXwpUEzSD0elv7Vn5RNM=;
        b=HSahTHSjC+qyYycTWfPR9upRAt8vm9eFnxMctoJDs8gAxjRmb7uLiNXKiqTM78/zpv
         52lak1bD7MjiyJbwns8JRc/KQIgVLg2Uwtqo4EpsPe0ZjRo83/VpPMTIGGrQivNpCX4C
         g/lp2vkSE4AWbCQRc9euaoO3L83YSfAf1tWCKmFklxhvJLWuXjq4opfZ0/BsV84rTZVH
         ZuiAsAGhkq4Zkl8eUCf1rwBqcFv25FKtP0+UIx5dk1ceJFqzWEME8o3TAyaUxUZlScvd
         FYuJS2THPeMG5Rn5/d6j1FVQgJoWTdnXlHxZkqoFGv39pHfMj4i1MDhfj89z00geRkvA
         iMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728407933; x=1729012733;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cbVzk8DseAfkG3gNp5Is1zNFXwpUEzSD0elv7Vn5RNM=;
        b=CZ6BdoLHCghxcGhi7paJWeNmiMYdaH0DRgft8u7OaMHBxk5TndzzEVgC2dPvcKTOTH
         PIBzbwUOZVjxQQGpv53Gk6omygZxnK04cbw0M6tTvNsooAelNxp6FVenT0AtKF7grXHv
         DKvlL5WNsCLlsi8ywaV1VVQna3CquDv0A3aPOIqndIBqpI3KSfHO8f7qgQ9T1JQ4NJdl
         IFe8Xy/KFkHpbm89mBkVz+BkpJ8BfKT4FdCHsLayNnf3gpRVGXboAMTaUoROw0mtRlSl
         EvlGRpNfAdv4ZNcQYA8/+fkeHjHC7MrQ3IMj514gXwfi0fZeGeBxKXpEF11/gMxy69lY
         GMpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcFmAVUoNkF1qsUl8cIp8dnVWTsteymp2NCQmw/3l5COySOC6tQwINW1T1AglVqK0SDjzqWoWtLiPuSkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6QcNLkIQQhdZ/jzaSlwDgPuXZXCTzFcSHeyOsCf5HVWMi5eX6
	KPUwFmzp8vefe3TPuFrBIL5queRTRTWB2okwwTaq0DrsP5klgc7QbfCxTA==
X-Google-Smtp-Source: AGHT+IHHBeXv89i/o5DrLikofeuiTmUt4x1m9H41ksMvdEGq5wZVLz6dQ6v6AEG+3iaVsinnjQ7UiQ==
X-Received: by 2002:a05:6512:12d3:b0:533:43bf:565d with SMTP id 2adb3069b0e04-539ab88c2a2mr9522222e87.27.1728407932389;
        Tue, 08 Oct 2024 10:18:52 -0700 (PDT)
Received: from [192.168.0.101] (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a994a8da5d3sm381814066b.134.2024.10.08.10.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 10:18:51 -0700 (PDT)
Message-ID: <cf3c5ed3-69bb-4ff0-8377-29cb6fe7a358@gmail.com>
Date: Tue, 8 Oct 2024 18:18:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jack Yu <jack.yu@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: re: ASoC: rt721-sdca: Add RT721 SDCA driver
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jack,

There is an unsigned variable check in commit:

commit 86ce355c1f9ab943bbe099ea7d0b8a3af2247f65
Author: Jack Yu <jack.yu@realtek.com>
Date:   Tue Oct 1 09:17:38 2024 +0000

     ASoC: rt721-sdca: Add RT721 SDCA driver


function rt721_sdca_jack_detect_handler, the following code does not 
initialize variable ret:

         int btn_type = 0, ret;

         if (!rt721->hs_jack)
                 return;

         if (!rt721->component->card || 
!rt721->component->card->instantiated)
                 return;

         /* SDW_SCP_SDCA_INT_SDCA_6 is used for jack detection */
         if (rt721->scp_sdca_stat1 & SDW_SCP_SDCA_INT_SDCA_6) {
                 rt721->jack_type = rt_sdca_headset_detect(rt721->regmap,
 
RT721_SDCA_ENT_GE49);
                 if (ret < 0)
                         return;
         }

..and there is a check for ret < 0, even though it's not been assigned. 
Should that be a check on rtl->jack_type < 0 instead?

Colin

