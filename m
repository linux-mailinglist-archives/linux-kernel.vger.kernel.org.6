Return-Path: <linux-kernel+bounces-214204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1654C90812C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4781F22C6E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B281822F9;
	Fri, 14 Jun 2024 01:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ngASyHv2"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297CF1773D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 01:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718330220; cv=none; b=lkfAGKOff247uUPAjOuINa4cNewS+PaftMvGA6sXjNeyNaoiTb13/8RxvhGbkQjYOEmpjH3096E9C/HETnB+Q1L2isp/f2TjdjtuOT7ATMZdmL0gM1AtPikk99zfcSEjeu+M+qwDYxcy8rKNTTyYruq3InKKFoNegwn6H3sg3Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718330220; c=relaxed/simple;
	bh=vyOqg9db//0BT1sFIeTPiOlI0FScPbhfE9kHaAwECak=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mu9ZuNZYamNpX4mt6wXRVFnJJkodG5yGCtNO/SKzCUuO+MMhGMQeWoiOpmweb82o6nNeGlPwiVMVfi5S2nWv4VQ8VZAJMll5GFh/TKCcbGD/lc7LqIUD9LXfqnTmOUeVvZ6Pmmtm9aDy38pNpnpcFBKx1GVpLKizh9czZlIU0MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ngASyHv2; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c1baf8ff31so306726a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 18:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718330216; x=1718935016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L/cT5QY86RD4pMSybSC7ezIiLKHexGe78wlrIu7nM5I=;
        b=ngASyHv2k0Db0Cq2osrtVPvYZk0/CTFgqR3Al7qtLA6d8njdD3//ZI1cOCYOBHB22q
         QDLJurvT7lM59AQ9KTNBAC/fD3WqsZp7u6m1lY4VG15cpTv+q0KP00mVBwJf5VL0OBSy
         J++L1EE18DSptIJfxjsnom2R4LJCnLVz5UiVLuytNZ1nx7TN6yZ7jecs5vO50QGho1U+
         /UinVVmTH8fLaOh2SuaBH6UfUlFXvEHA61oBGL+VzOD8sVbzTVleokbA22z2cOh++KAG
         lYvyTdqGV2XFsaDViyAwNOe1xFJCQgzkY5/6o3c15UlPPYAWGM0zytIdDgvQYISqsNFQ
         Ds8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718330216; x=1718935016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/cT5QY86RD4pMSybSC7ezIiLKHexGe78wlrIu7nM5I=;
        b=nIB0GSv4DZNvqKXfKg2hLkq+l1vEgTyAR3mtZKcjAGT6WMhp1blxdXt2lOQLj0plgw
         VA4OqrXvObHbY5oH8SuTUcQik74L4AXiO2ZmXJpjyw/4XNPlnwq4SLI6+AonOb8zrgNV
         OBBa2R+nEzcHAYV4nkU/Mrh9CSxLmbjQZ+/aI7lOTVkLMSUFDhmwKgFGEd0VMWsDt6fX
         B790+Pp/D3hvQY4AJ4Xy2UN3G1lZ7kon7T0wYU3Tud5Xo9bTMN6ocMpWTO6GMMTTDvR2
         +U2uzOBJuQGIBPC/PsUK3fgeVotH8xrdHY52L/N64wMziF+8ls7ybIHSzyP57cMC263c
         pWjw==
X-Forwarded-Encrypted: i=1; AJvYcCX3JrS+zVLAa2jW0gpeLpeo0XW2/03Jh2w/xQ7dqsyHT9ZAwXW2En2tZCqW2VTfYQWERGiw8mOpTpRohJIbCKY+Lq2tVz0zjqGROZBW
X-Gm-Message-State: AOJu0Yx2AsZrJOUi84b1uYojCz4C5YF+5Cs3u7mTQ7e/OfYrADx9UIxl
	gsaxZGoUinpULUjRdOPmeRsBhzBepmgXCR1piVLsVd4V8mLZ5XeMLrQr1MU3RVk=
X-Google-Smtp-Source: AGHT+IG01YkLWFpFb5K5FGuGR1Hct+TnKSUI8iy4lKTY3rTUKYG2lCSLI60kr07UAtfDFCyqy/+wfw==
X-Received: by 2002:a17:90a:578e:b0:2c4:cd15:3e4b with SMTP id 98e67ed59e1d1-2c4dc03a6a5mr1447650a91.4.1718330216343;
        Thu, 13 Jun 2024 18:56:56 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4dc5f7e0esm631767a91.48.2024.06.13.18.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 18:56:55 -0700 (PDT)
Message-ID: <fc8f4adb-feef-421b-995d-ae9ae059f4c5@kernel.dk>
Date: Thu, 13 Jun 2024 19:56:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in io_req_cqe_overflow
 (3)
To: syzbot <syzbot+e6616d0dc8ded5dc56d6@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000003835b9061acfe0c4@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0000000000003835b9061acfe0c4@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


#syz test: git://git.kernel.dk/linux.git syz-test

-- 
Jens Axboe



