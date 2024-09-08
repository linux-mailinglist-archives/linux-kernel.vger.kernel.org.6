Return-Path: <linux-kernel+bounces-320408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE64C9709C8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 22:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B631F22063
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 20:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC85A17A5A1;
	Sun,  8 Sep 2024 20:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLIehhls"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9E017622D
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 20:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725828280; cv=none; b=ihLJOoqf9PzNVpnKJ3Wo0OsvEFtyqT9YP9ub3i70cKM34cIuPQSifoNr1LB9ICieM+ZgLtFmasqu4zUEEITjFs0ZbJwX5UWfjGndfuonLAxyYlM+xqNrTVRU/60h7MbQjwK+6OGZNIZV1Tzfk+8UPz6lbb2H9faU3VKSlM9ULCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725828280; c=relaxed/simple;
	bh=ce5/oy94qv4P5QWUjkFHth5O//hDjwj3U4B40R0gHfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FyzlLvwB0KsGhj1MrrGkIWSKcxs3aoodIZYO+LGNsd6geQ1XOVor0s9Cv9zSXP+nyL/1j/qUClqZ//N8Bx84ApnN1tIzptcKYWDuaVANuribQmm5+mS1xrHBI76tAnKprySqCHyidiqmEBm3KxSAdFPBQAdmmf5d0RbwMLeYbe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLIehhls; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42bbdf7f860so33348125e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 13:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725828277; x=1726433077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Asp8Q/euPnossaqJrTRIZ1Vkqf9RFiJuPtiDLCvZeQI=;
        b=RLIehhlsb+OoeIufE63mt5lgblGdQ/SfScUxP/5kvXJMXMDk4Y5NRwprRsohVSxfbG
         CieGmlCEBYrJEjN6q4jUToqaz5mEHNGIVFW45CoWm7riHeDQHGs6C2E2f87aTWoAnexD
         8x0Zn4IwbfAA6i+YqyeLhobPNKQZnLDRA6EsnyGwbor8WnOpgorp03qxdDTNR0UK4qYt
         Lh/3ABsvDQMafKGrAhjQO748efqcL6JVypxqA8DKwyUxU89xZtLITf++F5GpeurOB1la
         KszxnPnyRummN4CGtidXgNrtcabvCVniatr+JCCugPMyawzM7fXbfyhZWyDCij4kVH1B
         n0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725828277; x=1726433077;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Asp8Q/euPnossaqJrTRIZ1Vkqf9RFiJuPtiDLCvZeQI=;
        b=LnsC87o+j0nLExg2Cn9+cJrR2frx4HRJIDdqpVApjimkccdFF4bXuCidSm1cKCe/Fk
         4A0+JEOBgpGCBmwhNbqA7EshbvtzgE9N70VZbF3Y2noSiRD1V/kwK00Mh7889aRZJ27y
         41wq0QJ4loqUQt6/x2UTWRFZKK/mEUyvPDrrOx9pZM8CS1mk7p+TZwzJ8fWqj8ejK5Jg
         8DaT25AYs89R2iQjCC5eCdpJki1YWNABltrMQwygNQLaH/x4+uU6z57yK4IqBW+SVDqf
         kfZYD7uWtFZ3ZV4ifxAjr/pvMFE3rgvLcomb8n70PO9wl543hJHGaSJquPoLSB61apXN
         MNYA==
X-Forwarded-Encrypted: i=1; AJvYcCXfD1NX1FZkf993VSHcXR6hoqovs2wEZU19iy4lU8GYu2I3yFbzJ3auRQ2jpgIvts2tnWoHnXLuMw3CEzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyZRgSVscmjeowSbRO82bHMJWbvtCYHLQr80sFLqFWkhJnKsiD
	D5KOZNEndIStQlcm+c8mCNjXvdObMbZGval8tgsYW7HZ/9HT8I0k
X-Google-Smtp-Source: AGHT+IHM9xQj2l/pnuowsDJq0ee0kHagA1SOlJxibcTBQRb3up7/6pVWYiWNY9O39D5wKe7cZS6Abg==
X-Received: by 2002:a5d:5e0e:0:b0:374:af04:d6a3 with SMTP id ffacd0b85a97d-3789913417fmr2521402f8f.57.1725828276957;
        Sun, 08 Sep 2024 13:44:36 -0700 (PDT)
Received: from [192.168.0.104] (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25979fa3sm244384266b.71.2024.09.08.13.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2024 13:44:36 -0700 (PDT)
Message-ID: <74e0d097-7883-446f-8722-f79169cab15d@gmail.com>
Date: Sun, 8 Sep 2024 22:44:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] Staging: rtl8192e: Cleanup even more camelcase
 variable names
To: Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
 anjan@momi.ca
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240908192633.94144-1-tdavies@darkphysics.net>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240908192633.94144-1-tdavies@darkphysics.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/24 21:26, Tree Davies wrote:
> This series performs variable renames
> ~ Tree
> 
> Tree Davies (16):
>    Staging: rtl8192e: Rename variable pReorderEntry
>    Staging: rtl8192e: Rename variable SeqNum
>    Staging: rtl8192e: Rename variable SignalStrength
>    Staging: rtl8192e: Rename variable pFrame
>    Staging: rtl8192e: Rename variable bPacketToSelf
>    Staging: rtl8192e: Rename variable Para1
>    Staging: rtl8192e: Rename variable Para2
>    Staging: rtl8192e: Rename variable ScanOperationBackupHandler
>    Staging: rtl8192e: Rename variable Operation
>    Staging: rtl8192e: Rename variable bAssoc
>    Staging: rtl8192e: Rename variable SignalQuality
>    Staging: rtl8192e: Rename variable isEncrypt
>    Staging: rtl8192e: Rename variable nStuckCount
>    Staging: rtl8192e: Rename variable bAddNewTs
>    Staging: rtl8192e: Rename variable RxBufShift
>    Staging: rtl8192e: Rename variable RxDrvInfoSize
> 
>   .../staging/rtl8192e/rtl8192e/r8190P_def.h    |   2 +-
>   .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  40 +++---
>   .../staging/rtl8192e/rtl8192e/r8192E_phy.c    |  22 ++--
>   .../staging/rtl8192e/rtl8192e/r8192E_phy.h    |   4 +-
>   drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  14 +--
>   drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    |   4 +-
>   drivers/staging/rtl8192e/rtl819x_HTProc.c     |   4 +-
>   drivers/staging/rtl8192e/rtl819x_TSProc.c     |  30 ++---
>   drivers/staging/rtl8192e/rtllib.h             |  32 ++---
>   drivers/staging/rtl8192e/rtllib_rx.c          | 116 +++++++++---------
>   drivers/staging/rtl8192e/rtllib_softmac_wx.c  |   4 +-
>   11 files changed, 136 insertions(+), 136 deletions(-)
> 


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

