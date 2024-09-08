Return-Path: <linux-kernel+bounces-320404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178009709BC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 22:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C441C21339
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 20:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9F4179658;
	Sun,  8 Sep 2024 20:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzPIIGQE"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7F7176FDB
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 20:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725827701; cv=none; b=EMi559Jsb2JFVrJfeqH9F03qFC8Vl85oinM7yIuHAguvycArnJb/8nPtNJfZfhKitaIVOmi3J99W3uirt84b6YBpAIiSiREoAXDnCq8OW8OWQJwLMweXWFOBUTnaw2kVljuXP8yjlSltBlrN8sadga6Zx48G8+xT+UtYYznNsFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725827701; c=relaxed/simple;
	bh=+pMLN04S56lAq85RIxX9RiClF8fhTbYZoEsWW028IxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RrcUWfpZenR8ISzotjOhgBeOuJanTMAlW8clfvknsdFbQ0aM9vZWNZTQH9AWqzZJnFIAoe+DtC91Euwtet3VquPQdkYxHdP4KJ8zaX2CpDAARfVkID/D4K6uYnsjf9pzylwsk+TLO8Tkt9sF4IfVi56R/BVEpbKo7cLZATySSaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzPIIGQE; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f761461150so13197631fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 13:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725827698; x=1726432498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wwAgKG3MjNdWJJ46a6f9nMyHqkocgTVWsSRI47bgPvI=;
        b=RzPIIGQEFqB6gEmDzRDV/GMmwSomjprl/OytyRFgAFKmOCFQQukOGvxRJvs0QrmLid
         fUROALoZezkQY+jl8BB6+k+wbuKyPlb6wA34ffKIjcfyoRyRIp9pvktz763IXrWQad+Q
         KtuYP5ZxNI7PT89s2PSll/Rkfr8CbCk8RDZ8zhSTwUwqcR5I9BudxToakyNYD7TPSScw
         bGhdpGyATBKZgai39Xmis2WHjr/5tEzOE2vVIsg4GU4jQBDFAyRly21HRM3IGyRnyZm2
         k+zVrY4AIUUD0YiGHAcQ66RfYI3Hrh/VOoAwoalZwJ1Vy28CKYQv/nWwKeWNBr4a4egE
         FR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725827698; x=1726432498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwAgKG3MjNdWJJ46a6f9nMyHqkocgTVWsSRI47bgPvI=;
        b=wsDEZLs4WeblClaGAJvT31za7WVrv9kmgl4jZxquO8FhJveeK4m7TaOCmA071uieTY
         FnIcoE+BZV66+aYVQ713Fi701R6fzEuo+1XI3CHGAB9NXVFoB2bPBGZrCdx2ygj9wg3u
         X6fv9ZmECf0JQ0R4Ws2Fh60XvsNDTcMQ6+Ag+cZOfrZTEuJUzT3ZdVLYUPlFUlwLX1em
         71sL+2V/64oE+Ca8K0U4X6DUI4Mqo/R93OBa2sluQtlxhkL99EKx+v249tMA3+IcoF1K
         YCUSjvHFLDka1rbcIM5ioYZPZGRfTqZQaXeokbMIj9piDmM3PO2rtpHlry+jMvFPi9t+
         SbWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ6Cv/+15fESsraGSko5CH7I9410hLMmrN/dnXxS9vCSlK3S943Z3H0J4nzQR2Nf66nCXdpJVxBYBuvsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD9PvAcrusHKVqTPhM3UEKxyKIeieTzHH+9k+B+FmCRGVmtyzN
	hqpSebWrYvn7FYI1eCxdRkCz8s2WOCpbDNndBQHg2nF63j6pPJXC
X-Google-Smtp-Source: AGHT+IHdu8DeRAFkv5dqkoi3zd2OuN0xB+xEPifmnIJZZ1OhX+mQue/HtypaNmzl1gSCxIYcLgOmOg==
X-Received: by 2002:a2e:750:0:b0:2f6:4a89:9afa with SMTP id 38308e7fff4ca-2f75a992205mr36381251fa.22.1725827697172;
        Sun, 08 Sep 2024 13:34:57 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8576:4416:5fef:fc17:c89e? (p200300c78f2a857644165feffc17c89e.dip0.t-ipconnect.de. [2003:c7:8f2a:8576:4416:5fef:fc17:c89e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d3eef7sm245296666b.192.2024.09.08.13.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2024 13:34:56 -0700 (PDT)
Message-ID: <ca1908f3-74aa-45e7-a389-3995aba2660c@gmail.com>
Date: Sun, 8 Sep 2024 22:34:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8723bs: Fix tabs for indent and + in comment
 blocks
To: Sayyad Abid <sayyad.abid16@gmail.com>, linux-staging@lists.linux.dev
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20240908180902.3196764-1-sayyad.abid16@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240908180902.3196764-1-sayyad.abid16@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/24 20:09, Sayyad Abid wrote:
> This patch fixes the use of space instead of tabs,
> removes trailing space and adds "+" each line in a comment block.
> 
> Signed-off-by: Sayyad Abid<sayyad.abid16@gmail.com>
> ---

Hi Sayyad,

please apply previous send emails to this patch as well.

Thanks for your support.

Bye Philipp

