Return-Path: <linux-kernel+bounces-332946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5A097C12E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 23:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952551F21CD1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47331CA69E;
	Wed, 18 Sep 2024 21:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxVwG5r+"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814FC1CA68C
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 21:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726693706; cv=none; b=JVVB4/Dl1TDptHK05YMLJzzTNj2INgJQrPnMXDBe52atTCJyt5Snb08FIq6cMGZLlnSL4GpHca4XDJ6tWWloot+8w+Izlni8kViYob90ZxUrDsuQorzbqnC8dKKyIOw6PFICeId4vuVBte15mixy1mZE7uNYH4ONeVFrlVJZ9Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726693706; c=relaxed/simple;
	bh=ouui963+aICLxgwY9/zA41gtArKIiNf4aHjyfrJLHAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uiBAzUALQEdaoRsKNNyQve3ceK5uNloemuZCVJqSDY2PhBIQgf1Xgde6XPkODiZTByQtbr8cIYXSkX6kxJ5Cm53998g5Z3CQrg27gzkVmXs3Pgg0Vgn1uyrkgcLmRR2v5I9kEK9S6w0ZJzsBXP4zox7L9NmjNbzytLClmF5nhVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxVwG5r+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso895355e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 14:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726693703; x=1727298503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MVe1RHJ36TdPZ0MCm1xGfLwPh1KD8ExatGy+oVbAu6I=;
        b=DxVwG5r+62cPF6iDWWSHykhlGDBLwoCTocWqSjNYVRrCfL3EKS6wgON0dRTcRW7Rhi
         cCrOqiOXUk9AKjVq9rQG5TIHCV+K5r0x32sGmMzuZ2Q519TK1lzST8+vd6kUGEkC3rHZ
         1qYgIkItNsmBmR5QEGHHaUhGJFvV1n933S7Z5TM/MZPLOKd0cv+BqQZJ9To6ObaAGPha
         uNLOgf0Nn9d3avzh/k4MI/sX1WIkm7yNggUvCgQf62JqHkmtxz9najEftygN6C3xxX20
         LufNu/w5bcxKpIsYQ9y0x7C77es1QhfSdAwDWAHkQfD4zVtVF3/RCcXvCp3WdsIa6lz6
         3bFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726693703; x=1727298503;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MVe1RHJ36TdPZ0MCm1xGfLwPh1KD8ExatGy+oVbAu6I=;
        b=awvsOkP7p9KGU4Fd36FnTBpikh34/UraLFlBcCeu4TaUdBdg74F0SD8LGCMb0CF80c
         88eytbL4JLpbZ4YsAMHJa8IMtWVuPPEiWuLMCdMabNfT6LGqSg/oYDYgfMYXPVvG23FI
         kmVHVkNTMfwTrgYR3bDzuMgmgIIltN2HfvFbvJFer36Qn7vUmWbYglabf5xlptwtMctI
         J4WyUxuj/k/Ie5XnxNc/7W09ocKtfe+/et7wpZhOehEbJl+o8v2MNaAmMvAZRETy0hth
         JKtmP3Gq0xdC3TvW9zn2TXdJSPUyt5ih7WHyzJzjHpAwWCm6v+1KPnOlN1NZTWorTnwg
         rQRg==
X-Forwarded-Encrypted: i=1; AJvYcCW03ciOB21guvWDDmtGpJHhFcaxj9dgkzNbzHYT2kfilPP1X5w1tfNw9CyRip0XqgNeIpgYKE4l3PN+7gI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfwoun7GjXiA4VKu40BVPRKB3dRtfNMFzwIljI5HVOx/pHREcA
	s2wK+jAs9AafbNA3KD/4S0IULHQ3rKJlTi7rQls3ysLSOTFX1QjT
X-Google-Smtp-Source: AGHT+IEj07TGOzKUNv0vYVV7Wj31JNqmb6g5rnW2gUBrVO1CBVS0JrGUlrsQUTvBD8Ze7CtesBb98Q==
X-Received: by 2002:a05:600c:4709:b0:426:647b:1bfc with SMTP id 5b1f17b1804b1-42cdb59148emr180118345e9.30.1726693702418;
        Wed, 18 Sep 2024 14:08:22 -0700 (PDT)
Received: from [192.168.2.100] (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75468790sm3074335e9.46.2024.09.18.14.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 14:08:21 -0700 (PDT)
Message-ID: <34860faf-b4c5-45ff-bbed-370a12c88187@gmail.com>
Date: Wed, 18 Sep 2024 23:08:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] staging: vt6655: Tidy up s_uGetDataDuration
 function
To: =?UTF-8?Q?Dominik_Karol_Pi=C4=85tkowski?=
 <dominik.karol.piatkowski@protonmail.com>, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240918191959.51539-1-dominik.karol.piatkowski@protonmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240918191959.51539-1-dominik.karol.piatkowski@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/18/24 21:20, Dominik Karol Piątkowski wrote:
> This series tidies up s_uGetDataDuration function by renaming its parameters and
> variables from camel case (including Hungarian notation) to snake case, and
> fixing its declaration formatting.
> 
> Signed-off-by: Dominik Karol Piątkowski <dominik.karol.piatkowski@protonmail.com>
> 
> Dominik Karol Piątkowski (14):
>    staging: vt6655: s_uGetDataDuration: Rename pDevice parameter
>    staging: vt6655: s_uGetDataDuration: Rename byDurType parameter
>    staging: vt6655: s_uGetDataDuration: Rename cbFrameLength parameter
>    staging: vt6655: s_uGetDataDuration: Rename byPktType parameter
>    staging: vt6655: s_uGetDataDuration: Rename wRate parameter
>    staging: vt6655: s_uGetDataDuration: Rename bNeedAck parameter
>    staging: vt6655: s_uGetDataDuration: Rename uFragIdx parameter
>    staging: vt6655: s_uGetDataDuration: Rename cbLastFragmentSize
>      parameter
>    staging: vt6655: s_uGetDataDuration: Rename uMACfragNum parameter
>    staging: vt6655: s_uGetDataDuration: Rename byFBOption parameter
>    staging: vt6655: s_uGetDataDuration: Rename bLastFrag variable
>    staging: vt6655: s_uGetDataDuration: Rename uAckTime variable
>    staging: vt6655: s_uGetDataDuration: Rename uNextPktTime variable
>    staging: vt6655: s_uGetDataDuration: Fix declaration formatting
> 
>   drivers/staging/vt6655/rxtx.c | 110 ++++++++++++++++------------------
>   1 file changed, 53 insertions(+), 57 deletions(-)
> 

Hi Dominik,

now you have put quit some afford into this patch series. Thank you.

If we change the camel case variables this way we need thousands of 
patches to fix this driver. Therefore we typically change always one 
variable for the entire driver and not for one function.

The following is just my personal opinion:
You can keep working on this driver and your patches will remain in the 
git. But I think I will propose to delete this driver. Reason is that it 
supports maximum 54MBit/s and the connection is always weak. Its form 
factor is mini PCI that is really old. I use an adapter from mini PCI to 
PCI to get it into my Desktop PC. It furthermore is not buyable anymore.

I like to focus on the hardware that is really well useable and on the 
market available:

rtl8192e
150MBit/s -> 12,5MByte/s real steady transfer.
buyable for some bugs as miniPCIe Card.


rtl8723bs
150MBit/s -> >3MByte/s can be reached with the Notebook:
Odys Trendbook Next 14
(Fedora with xfce) (I would prefer the one with 4GB RAM but I have only 2GB)
buyable for not to much money.
We can catch this devices because they run on Windows 10 which will not 
be supported after fall 2025
The Driver has 146 Files with 70000 Lines. I think we can remove a lot 
because the bluetooth part is not used anymore...

There are more device drivers which need our attention...

Thanks

Bye Philipp






















