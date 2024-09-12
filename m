Return-Path: <linux-kernel+bounces-326490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC43976900
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021611C2340E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829D31A2638;
	Thu, 12 Sep 2024 12:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U6eBUPon"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0139D185B5C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726143669; cv=none; b=eDyh9t1JNYQQ1r1zChtRB7OCtqdkk0pcl6HfiJ7mOR6aOudjCfjw+IL2oGGd9or0lJeEpUZhKG0Co5V5uhseLDWRnn2g74HGwVVV5b74RK1a4QdollVRngaQQCeFuwA9HufnchHjQQ72qpoutYPzs6b/nZW/KuAppmiGrVTAT3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726143669; c=relaxed/simple;
	bh=L0hcGBj7Xb6gErZ6s+YHOWMB9M14abApg8vVfzKv/FU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nH17iY4uSltLjSzGASsyRgxNb1gxolv12cT/DGtgdkkEsR+C/jfaSE6BZKSk4Fvhdwtyu6cjPOBya+qxZLoBKe35oX1cEgEhbA9s5LpMUdVEdrmJxinSnjV0vaJ7LfULoJjjUtEaDPtUOKReemBud7j5yaQQNpLR7Geikf5rp9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=U6eBUPon; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cb7a2e4d6so7544375e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 05:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726143665; x=1726748465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TIVPdywrUFGG0FkWKS+0hdfToDR9IybfnZXJF/jGVNM=;
        b=U6eBUPonU8CnQA/3oLp8HBG+cQBnUxdD1YAeQsMAP0iJL1/Pb8i4G+0eRtHSO0IC3j
         fp+DRfQdUxTARVy57DcViDDhSMd6bScxvrjivBFvq6E6iX4WjojzF2rvbL8autFC7sqi
         9Yl0FX/D5E2CbF5PKzgXpEYZbKI77e/RJHqbeEzgrMgJGhdUKEtktI1jppB7WZ0MfGXe
         4vTZJlm4MXf50On8N3oBj+70zZApQ3bwnEVr2XaXvW1UdpgRWbq6wVnB3Ht+aIf7+X4Z
         jFtbE2u8hO1POtZewl9YV6B8U6C94XFacQOqi2M+7FZawPPwQtsIfNB6Rl10xqkxnmAy
         11PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726143665; x=1726748465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TIVPdywrUFGG0FkWKS+0hdfToDR9IybfnZXJF/jGVNM=;
        b=G3T8xsHEPmoVRZ/bnkdgy5ZXQwdBc+Dzx+41i3SIshrVttn/G0RIjf68UFC4kUzs7R
         TpnFlbaAjUHM7Zf6lNVAhKu4NbhN3R195/sIsLUV0wxGt8dWbrvH3eR01YrZP3Hlir0s
         k8HEY7WOLq9hg/a0aw13E5Q/S+PwxAPXWGVu0Zbl49m+uYZ7tLpPDtyUbNT+nJR/ETH2
         ncoNrlhLNKIuNFo6I0+WKpKZkpEcZvdRHkgUvsku/Vlv2XrPW+wgxEySyRMO8BAzW3bd
         vlnQCGc/FVF2aWnuW0oVb0su0ErdwGW1WctUbJdVCpxWAV31/jYvNZtScMI0yX/qNDxr
         I4zw==
X-Forwarded-Encrypted: i=1; AJvYcCUIbfdCw1y/Aah6ngnu/LozIBOY5IL6j0NSLtX9D5GdeNjix5GKjT8Tegv1ta7zOFAB+tFwzwQu3dBLtUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt/LsuGDx+zjVgjM4AP9k4Y/DC3PpGZ32dIMV6icVJGZzbI0+Q
	IJwKUJuQ3Y6WmgskhEexGH1zeATOpimFrYFhtP/MBqoOspuSRjwKlxaXgrrBcow=
X-Google-Smtp-Source: AGHT+IE6tn+Ot7sdV8Xz9YXERqzLMkoh4GL4PglAIIkRJBCPWuSCUxcEiM52/iHe7DMNk1u2EI2g2w==
X-Received: by 2002:a05:600c:1987:b0:42c:b4f1:f281 with SMTP id 5b1f17b1804b1-42cdb58f2bbmr21556165e9.34.1726143665103;
        Thu, 12 Sep 2024 05:21:05 -0700 (PDT)
Received: from [192.168.0.172] (88-127-185-239.subs.proxad.net. [88.127.185.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564aef9sm14294356f8f.5.2024.09.12.05.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 05:21:04 -0700 (PDT)
Message-ID: <88927a41-a49d-4560-ba73-f01d0c1601e8@baylibre.com>
Date: Thu, 12 Sep 2024 14:21:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoc: mediatek: mt8365: Remove unneeded assignment
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Nicolas Belin <nbelin@baylibre.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240911123629.125686-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240911123629.125686-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 11/09/2024 14:36, Muhammad Usama Anjum wrote:
> The ret is being assigned, but not being used. Remove the assignment.
> One of the reviewer mentioned that dev_warn should be replaced with
> dev_info. Make this change as well.
> 
> Fixes: 1bf6dbd75f76 ("ASoc: mediatek: mt8365: Add a specific soundcard for EVK")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

-- 
Regards,
Alexandre

