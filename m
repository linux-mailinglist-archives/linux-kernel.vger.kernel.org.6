Return-Path: <linux-kernel+bounces-199875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7928FA716
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 02:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A29289C83
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407375382;
	Tue,  4 Jun 2024 00:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsbcczYl"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2311CA5F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 00:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717461514; cv=none; b=jyHte9QvfVClhl5k4WJOy36QP6RornORGFkfk30YiT9LoKehdBjArDqqdOoghlJ4ppImp6jB+fpIKq9RaapdlE9n8s458G9Lb1GllnfqxzrUXfO/ARk+buYcH51GTNONge+ntEBv6DPJWwQfg+jyMXM+2J4/OoMuu3Bp272OEoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717461514; c=relaxed/simple;
	bh=YDU1Dhsr3KT+mfMya+MZmz7rPu7CE0JSUYz5RrRoIz4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=E6DYEVvqvA6DDe6HrjbuqWA8mADdHpNKZvsc6//KLwT99IM63iwOW2/Eb0HltMQ5VDMD3uupWH8B8NeX0EBKOWGIXy0qrSr9nfjYpe5M/VDjRyj8gHiWZUdsNjCdPmAmYQYUNrvdZ6dWU1u4iAO+vV3BsDYVKGDnTgo404JWssA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsbcczYl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42121d27861so4744245e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 17:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717461511; x=1718066311; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNrik73waLfRCE0M6HnOnzqRYLaiC1N+WSsxINID/rI=;
        b=ZsbcczYlAqhNjjGEZ7McijbFOq1TeCyn7h9yVDmYgXA29h9QDmcaY5esuy0qzXqOX6
         K+hVFRXwPRPgh1+ml2Xjx+71aGORnTWgCS44rvQfwXRLQgMs57gyVGGI0psGSuFi9hf1
         OBZad8HxCCoqut0XzY+p7goWCbv58Emiv4BJZoAn/3K5N0GJDM49FWtrjRPAdOV42lC+
         //9lCu09s2dF7obf2GHYHwyF4ZU3s2OTBT2kq9hRcR4sMbFh5ZrA9HWSxGmv7PzvBMON
         JDec1MJiisvWHui5twf6D9vjd3emmxMrU3kfOSDWf3fnM4ZkuDOYmMaiQL2cfEArqj1W
         ICXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717461511; x=1718066311;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aNrik73waLfRCE0M6HnOnzqRYLaiC1N+WSsxINID/rI=;
        b=qFy08Vs5RxhSJ+D6LHx4YT4zi0mr1UDXxZDa2PE/Z3bE2nuM47a7fB9/ITrlcGIf/w
         ex64pIHo3tooLS/0NVBxB9RfGf5TZoH4jMxAUYAUConUSKaygODtzdyYKX1Hlb+dgXFL
         yndsUCZ2IMoF18mPgAEzSjMhtGxKQ6onkjBt8jFywaYVTAYXfBenT2I5YMWP4P01Rnpp
         D+1ngneT4AIAKmP3rS3vbmBixv9w13aTyXluEJwnYv552If3J0s4zB06bDtO0w5bylzq
         Pm+1cd2AOtIRK70gc2GO80xZTK+eRem/hdtvf1sIb8B5s9qITMvf43O87zxVq9yXMs9a
         mOkg==
X-Gm-Message-State: AOJu0Ywy8vpnhf4BLCVZG02mg64DobMOtAIRkVupcjXZN62rWlRu4g7p
	dWFQNU2jAWAOq+9pOKEY1lK5Xxb1wYj/CklzzJgiU8r/VQ71F+w6Xs6B5A==
X-Google-Smtp-Source: AGHT+IHFC3dUs0TkHZn3w8fCXnYDJ6rNoQK/eT14wra0Z+hxsRD7P5LwrBVMwBKAjP2YclWBkzPyzQ==
X-Received: by 2002:a05:600c:1d17:b0:419:d5cd:5ba with SMTP id 5b1f17b1804b1-4212e0441e7mr83339505e9.7.1717461511196;
        Mon, 03 Jun 2024 17:38:31 -0700 (PDT)
Received: from ?IPV6:2001:8a0:6cd2:9000:7743:6619:c46d:98fb? ([2001:8a0:6cd2:9000:7743:6619:c46d:98fb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd06499d8sm10202119f8f.90.2024.06.03.17.38.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 17:38:30 -0700 (PDT)
Message-ID: <ce0408ed-4738-4a0b-994b-f3b6cd17091b@gmail.com>
Date: Tue, 4 Jun 2024 01:38:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Andr=C3=A9_Coelho?= <andrealbergaria@gmail.com>
Subject: user structure
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

im not sure, wether, this is correct, but i assume that the kernel , 
doesnt have notion of users?!

perhaps a kernel structure like

struct user; {

something

};

could be ok , or that stuff already exist?!

thanks

andre

-- 
André Albergaria Coelho
andrealbergaria@gmail.com


