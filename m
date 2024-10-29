Return-Path: <linux-kernel+bounces-387257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19469B4EAF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CDED1C21125
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58009196446;
	Tue, 29 Oct 2024 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="greHbctA"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BD7194AD5
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217444; cv=none; b=mMKq/A0VTtx+aL6pPhqeqfUD6y9mtGU822M+2MWYW7feI2dbJPBqex5m4kT63/92ZD84ZNqkVDCMFjrtjMa4473WPvG8BfcMV1vAFBx716HATPO16fjxeUfFzCpLzPms8va1vKQTpbzEPlnNtJBwReMfOLlWmSfOC3UoibbM86k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217444; c=relaxed/simple;
	bh=CcpdYNV8akfb0no5SPpIyP6TGiAEbcbT8dcmXVqprmU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=qCILprBH4BvtaaFcmtn+/Mhk6I36R+80uVCm8jYtJ+YozFI+hW4NSTna0/9FFq329Mz2HtyBumqnlh1ClyaZEfpvRACOivl5/l29DAw7kVDP5SBCam0T7DPHY8SotfKqe3GFZcFVYb390TCMpGVlLkcSlxpVxBvtmoUFjXKW5YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=greHbctA; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso788718366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1730217441; x=1730822241; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcpdYNV8akfb0no5SPpIyP6TGiAEbcbT8dcmXVqprmU=;
        b=greHbctAmFfLFUNEOqbF80HwlbsAGYc3d9wpo+ik+bGJ6myUL5soTvCoCF5N5mwKa3
         +Kq+eTwuPTY0CwRg7ytl7lab+9hPmZsflye9T6YTt+KCejeAQgCPOTdDOFvCELa07hBK
         oPhUnXrN4knMnoBlLtJqA3LG/CSX1sNc8/n23TtLSZYJXWVWfo2y5Jj+KhQC6Fr+I5PI
         IwSPEHp0bG2yQZ3ibNHInTT1YsVr2Os7erUGjuz6fnlFx2kWFM7jSOYMxtI9d87Vfgx5
         82sJivxBbFZcn3a2XT199/p/m9Vsu97rScqS0yaVTg3qiaB9Zlhiu/DiyzSipLKwtA/R
         +M0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730217441; x=1730822241;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CcpdYNV8akfb0no5SPpIyP6TGiAEbcbT8dcmXVqprmU=;
        b=Aq7lefZYDH1mrTHe4Jz5FyUKhzDzDxL12TQiubFaWP/tMNWxB1jD1E2YwIpjkSUKGW
         NqinDWJfbou6ihugKk9jHxvHJ5qgZLEx0J++wU4/jOrnEbXk08UOZkzy1BX17BrUr+hW
         7GIJowFCuu/huCZp88q44+ZspwLNQu8c2skyLquoAeZwQMdPRTy0qy5dudCLvikKpSg/
         /LMQR6iIUL4C93ySc+6zlhX8M4uMaEDrD5y2g1D48Da2eQwAEwJxC3kls4ejM/jTlqcK
         IEpSKTk9+EWuIjzXiI3T/EFelc9X9xHirZncCvcn1sk1215wNJJxYdKqq/JjkWOu6hvF
         HOtg==
X-Gm-Message-State: AOJu0YwFS9pOwkCIYLiskD7HmZuwccccVjc71F23oRlGpk4dwItlxsEm
	vK3BhhhkAlAKkQSUmioze1UAw1ZAz99YZCkoLpjfRObteZ3huiGvNd/lWoXy
X-Google-Smtp-Source: AGHT+IE7punfeesHQhPv03rzgDHxpzFFfbJ0CF/EkUYALB5LdfIXmCWOm2XY54HVwJiXxXpgtzdLvA==
X-Received: by 2002:a17:907:3f1d:b0:a9a:5b78:d7d8 with SMTP id a640c23a62f3a-a9de5cea085mr1116546866b.17.1730217440851;
        Tue, 29 Oct 2024 08:57:20 -0700 (PDT)
Received: from [192.168.1.178] (dynamic-095-114-051-066.95.114.pool.telefonica.de. [95.114.51.66])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e214152adsm103928266b.92.2024.10.29.08.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 08:57:20 -0700 (PDT)
Message-ID: <f631fb4c-2ea9-4a76-a6c8-3a7d49e728e6@googlemail.com>
Date: Tue, 29 Oct 2024 16:57:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: tl
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 phoronix@phoronix.com, devuan-dev@lists.dyne.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: metux <metuxitservice@googlemail.com>
Subject: Are critics being silenced on LKML ?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello folks,


I'm receiving lots of error bounces from the mail server hosting LKML:
it's declaring replies on the currently heated top (you know which one)
as "spam".

I sincerly hope that's just a temporary technical error, which will get
fixed soon. Otherwise I'm seeing a huge streisand wave coming on the
horizon.


--mtx


