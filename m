Return-Path: <linux-kernel+bounces-217334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA4090AE6F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9481C24138
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6F6198E7E;
	Mon, 17 Jun 2024 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kTgSVStw"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50688198A0D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718629039; cv=none; b=JF0ORNYPppq31aZBBAPw2Kbz/x4RsfDfB1A/LV52P3jHBO0/qlOHynBv6Sl8gO+wZoKSIMaoqpPJE28sG5VyGTEzbXE2xU6sfxKrG8KPxkfkuruApXmZ//rM98MZeVNRrSBW2F194Gxkr7k20M/104+eIdSDH584HeuDhVY7SX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718629039; c=relaxed/simple;
	bh=R/WKolCm6aTpT0rLQ/5czZbGgTM5R1wePhXh/jKstbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VTakvU+FunJEI3kP2sw5L1eqBAE5Ms/HqHhqHmyh5K7/IfqatMQplSzb88kgtGkkh+cbtDW8agR6FyCZXCqYOXR/8mNW7eBvk8UDnT9p2ewFCf8N2U7XND7fKSfTndiqJFG+Zd0C8JPs9dKIrponko3osuklMfhgsz/kr90Ej7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kTgSVStw; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f8d0a00a35so3588126a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 05:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718629035; x=1719233835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6WRkrTaLy9bYrj4t5fzFeuqxrm3gUqPzfb+KoMhhmoQ=;
        b=kTgSVStwfUH2jmmzSTMDoi0AK0SFXKqPt8Ox97MiX2xGxMyt9hBki8zNulYYcBwfvj
         osOqHN3COkVFa9uLtZGMTBLJcQXhBrbO6ezgMmGQ7wpOVirsfzhqbtISHUCRaNIteqWk
         nrF8wxfuoHGUVpGXPxSipiVF0z8Ui450Ke3lO9uQQtLD6pWPsv9I9mwU/Q0xWCH1w33a
         BnKUNXuKPkhXN4fRhglwbh+Hgkm4LnTcXd+HToZ4RAzAWe7lDjbYAGRWilmX1BEYQhVr
         NW28FnMsi0FWvUp5YCdPcnghPQc1Mkp9o4WcCoLLFdYK0Q3QXpkyxa0CEb4FCtpQgtMt
         ZWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718629035; x=1719233835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6WRkrTaLy9bYrj4t5fzFeuqxrm3gUqPzfb+KoMhhmoQ=;
        b=iKuxBl9/RNyUCRN3QgkIa6apNoRmIHByWmGN8Tu7t63eVGpHCfGNEMlOIMTcDjem8i
         Shuw9CH6YHjINDY6GSzLPshS1otn7M0MxPWJWA/7ThYKWv4vnjysZsoOVs4Kj/gPdn38
         wV69gEILES9Jn7lqwBrfCVB2hFjXF6vFKPHJWu8Bb8Lews+EHQ0LrEeZSSbNs3TY0cCB
         koJgaBtr989fgT0ETwWkhu+6kt6y3vdkING2YUwNc9mmJTafbK8TQyrxCeorz72qcRNw
         Nd2mvtfy/T7fXf4kaPLrXR1s1ms/gOGp8NCdK1M9ikLUwkET9cc07aGGNsK4Dp2pIdZZ
         RzLg==
X-Forwarded-Encrypted: i=1; AJvYcCVL54G71ZgDgtF1oYCPJGntnufmIRg+Acq6L5diAxUSXRVK02VRvCscz5deuSV8RizMnha3pgREHPzzX92sIOj1yRDetSyr7NJn+l+I
X-Gm-Message-State: AOJu0YzkAg0bBIfZl3hM/i5YptKe0nYqHsvOeR7E9AJnMBk7lzfEdaRV
	pJDBI2pWTPJxjbU1hhcqsWaGuWH0JjARuw/orc9M9eTNu57KGoQ+zRsWlMwyvZY/Cq4kvzuH4v+
	q
X-Google-Smtp-Source: AGHT+IF6+UFGbJjkOb90pXY1tk27LLx4ShlfrN0M6h5QSv1w6bpMcf2oa86xTiR0j714bhRmykF/WQ==
X-Received: by 2002:a9d:784a:0:b0:6f9:d204:1948 with SMTP id 46e09a7af769-6fb9364b043mr9974351a34.6.1718629035488;
        Mon, 17 Jun 2024 05:57:15 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5afa9f57sm1508633a34.13.2024.06.17.05.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 05:57:15 -0700 (PDT)
Message-ID: <c7ac7634-9661-45b7-b3a8-ff2ecfcbb1ed@baylibre.com>
Date: Mon, 17 Jun 2024 07:57:14 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] counter: ti-eqep: enable clock at probe
To: William Breathitt Gray <wbg@kernel.org>
Cc: Judith Mendez <jm@ti.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240609-ti-eqep-enable-clock-v1-1-1e9e7626467e@baylibre.com>
 <Zm6tKQ8KvIh9nnPW@ishi>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <Zm6tKQ8KvIh9nnPW@ishi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/24 4:15 AM, William Breathitt Gray wrote:
> On Sun, Jun 09, 2024 at 03:27:11PM -0500, David Lechner wrote:
>> The TI eQEP clock is both a functional and interface clock. Since it is
>> required for the device to function, we should be enabling it at probe.
>>
>> Up to now, we've just been lucky that the clock was enabled by something
>> else on the system already.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> 
> It sounds like a potential bug is being fixed here. Should this have a
> Fixes tag so we can get this merged in the stable trees too?
> 
> William Breathitt Gray

I suppose. Will respin.


