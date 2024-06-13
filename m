Return-Path: <linux-kernel+bounces-212548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D39FD9062F6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCD0E1C22389
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 04:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E83A132122;
	Thu, 13 Jun 2024 04:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTW5OF2v"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AA32A1A4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718251999; cv=none; b=LE7+sJLNqAKG1qV0svNEgCvDXLTOBb3qzjJHLTbRcIe5IXzSBw0MfSzp+8DMi7dAcgGLXgwjdQEWfllEh3ciatFWjyYfPT0uWNP+l8/puR13o7iBU2g4y2VFn69H6MqxTBJ+eFJC2w+KWpPzgt73cS8qkLx0VV+gDrhIWBIAKxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718251999; c=relaxed/simple;
	bh=YnGruI6ke1LTqvhwxji7FfE65WSyDFiZmFTd5kUF8P8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gUhte1QfnTCi5ZroJb0/dl+S9TxWbQOKONynL7uYtWLrflOFbcBCJEnVVdFPShrZENXWsOsBgPheqIaM5gbodb7C9Rt3OtxovAE4GDVY+hrrK457iMlq6dI4oS8TZuDUJKv1dUGh3hrf0xy3knVSY9G53pwD3ob1HFZFlKQ1f7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTW5OF2v; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6f0d8f7794so8997066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 21:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718251996; x=1718856796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wsi910S9P4YLj4+W6cNwBMVH+BbAm1SNImeKNN85EnY=;
        b=mTW5OF2vN+mUPXg1P7MjpVCo88mj03mcd5l0balqhnXNms1/zqATH7kw7vRSKZ+Bmt
         YT2viYQoxVYWP6mCjAg0ZB2KePiKcrnFZ0Ug2sVrFBY+4rJEl5fRVd1/JSMBPmB4kcOv
         KMtW7FxpdOe9pRCTqlqVYASQbymy2MvFa+4TgQTPBbJqWOxNjUh+yFP+SQg5LyRwJltZ
         Y47dxSr+X47t0C68ykJuYXhrqfLk2KhqL1EhPuEFZ8jEuGgUvk24K6y+kluzxcF+mBFd
         NDCaIGFJxP2C4ylJneR0G3dHxuNKUrW3/yztJ80tIDWYfK/9PA5Lh6C5D+LKEtamIjsj
         qX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718251996; x=1718856796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wsi910S9P4YLj4+W6cNwBMVH+BbAm1SNImeKNN85EnY=;
        b=I01DnJxFkHO1C3v4vte0s9n+5ezmjEwO/DUN21t6nG3RtD8qMx9ZeQj8RWePGQe8GX
         Y+GZhG5rMnAQmjz63PcFiNyO2o9drVPbM27EJXlokBTbor8buXk7MYy87ViZcGgD5Gsv
         AhQOvu3yBh8bPDxmmcTxfgGjQP/WnQbOr4OG5chnqVQ2vK245MGJPBuWocICx4VYiNtX
         O19ViZcpkQFh+KzhzveTDu9cljJQoY9BL/CHnhSVWQ8P3HzuRZdMS9L7zXeAItRy3LGs
         UVYiWazg6C36CMI4SDZG7Tgz9rrQg9EiH1EqVnVGqg6kWnk1PrkfCkh2DCbeLdJ21jPO
         FCLg==
X-Forwarded-Encrypted: i=1; AJvYcCU9g/yhIDARcDLV1f+Qxmje2mex7+eBdOl9U7ElpIAMtJsu6yU7fXUT3GFtCbLyGU5+4718b5yUq92bABxc7Jgbluh/oLHOQ+Q4Zo+a
X-Gm-Message-State: AOJu0YylyEoCVJFepG8oMTyGgh4DRgtkCXZ0gkGj8bvk43ittfkurwu8
	eF/O1SXVkzbuZIsegPMfe4KJzaAPHdVa06zXucspgYtBNqygACvN
X-Google-Smtp-Source: AGHT+IH2vIwtsYNIV+qxVW0MxspQqq1ctuMGmx96NKeDs/K7BHxOXl54USt7laYU0xgjR4pYyLf93A==
X-Received: by 2002:a17:907:9445:b0:a68:67e4:7f11 with SMTP id a640c23a62f3a-a6f47cbf327mr248114066b.2.1718251996204;
        Wed, 12 Jun 2024 21:13:16 -0700 (PDT)
Received: from [192.168.0.104] (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f40fe2sm26305066b.148.2024.06.12.21.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 21:13:15 -0700 (PDT)
Message-ID: <e92c7967-73b2-49e3-abb2-6c476a1378bb@gmail.com>
Date: Thu, 13 Jun 2024 06:13:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/24] Staging: rtl8192e: Maintenance renames and
 cleanup
To: Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
 anjan@momi.ca
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240612032230.9738-1-tdavies@darkphysics.net>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240612032230.9738-1-tdavies@darkphysics.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/24 05:22, Tree Davies wrote:
> This patch series v2 attacks CamelCase variable renames, removes
> un-used variables and adjusts alignment issues found in
> rtllib_rx.c and rtllib_tx.c.
> 
> NOTE: Patch #9 doesn't completely resolve CamelCase violation as the
> correct abreviation of megahertz is MHz as called out by Dan Carpenter.
> 
> Thank you in advance to all reviewers.
> ~Tree
> 
> Changes since v1:
> #09: Change bforced_tx20Mhz to forced_tx_20MHz, and update commit message
> #21: Update subject prefix with 'Staging: rtl8192e:'
> #22: Update subject prefix with 'Staging: rtl8192e:'
> #23: Update subject prefix with 'Staging: rtl8192e:'
> #24: Update subject prefix with 'Staging: rtl8192e:'
> 
> Tree Davies (24):
>    Staging: rtl8192e: Rename variable bHwSec
>    Staging: rtl8192e: Rename variable bIsMulticast
>    Staging: rtl8192e: Rename variable HTCurrentOperaRate
>    Staging: rtl8192e: Rename variable HTOpMode
>    Staging: rtl8192e: Rename variable bRTSEnable
>    Staging: rtl8192e: Rename variable bRTSBW
>    Staging: rtl8192e: Rename variable bCTSEnable
>    Staging: rtl8192e: Rename variable bRTSUseShortGI
>    Staging: rtl8192e: Rename variable bforced_tx20Mhz
>    Staging: rtl8192e: Rename variable bPacketBW
>    Staging: rtl8192e: Rename variable bBroadcast
>    Staging: rtl8192e: Rename variable CntAfterLink
>    Staging: rtl8192e: Rename variable bUseShortGI
>    Staging: rtl8192e: Rename function TsStartAddBaProcess()
>    Staging: rtl8192e: Fix alignment to match open parenthesis
>    Staging: rtl8192e: Rename function rtllib_query_BandwidthMode
>    Staging: rtl8192e: Rename function rtllib_query_ShortPreambleMode
>    Staging: rtl8192e: Rename function rtllib_query_HTCapShortGI
>    Staging: rtl8192e: Rename variable bUseShortPreamble
>    Staging: rtl8192e: Rename variable bRTSSTBC
>    Staging: rtl8192e: Remove parameter bIsAmsdu from rtllib_classify()
>    Staging: rtl8192e: Remove variable IsAmsdu from rtllib_xmit_inter()
>    Staging: rtl8192e: Fix alignment to match open parenthesis in
>      rtllib_tx.c
>    Staging: rtl8192e: Fix alignment to match open parenthesis in
>      rtllib_rx.c
> 
>   .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  16 +--
>   drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |   6 +-
>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |   8 +-
>   drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    |   2 +-
>   drivers/staging/rtl8192e/rtl819x_HTProc.c     |   2 +-
>   drivers/staging/rtl8192e/rtl819x_TSProc.c     |   2 +-
>   drivers/staging/rtl8192e/rtllib.h             |  28 ++--
>   drivers/staging/rtl8192e/rtllib_crypt_ccmp.c  |   4 +-
>   drivers/staging/rtl8192e/rtllib_crypt_tkip.c  |  10 +-
>   drivers/staging/rtl8192e/rtllib_crypt_wep.c   |   4 +-
>   drivers/staging/rtl8192e/rtllib_rx.c          |  45 +++---
>   drivers/staging/rtl8192e/rtllib_tx.c          | 131 +++++++++---------
>   12 files changed, 126 insertions(+), 132 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>


