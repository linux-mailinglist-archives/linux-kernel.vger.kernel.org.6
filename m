Return-Path: <linux-kernel+bounces-302585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B2696008E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715032835E4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84052131182;
	Tue, 27 Aug 2024 04:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idGTov+o"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296E580C1C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 04:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724734426; cv=none; b=NvfjCAMhb7SgOmsUHF3PwIof+tPfhGJrMsqwi4jTkJdMomyROpwYDj7kVxLQXrgy2m6iLyWuPg1d0THfEVA1Z8AQ8fye3eEgcEUn7iWka3o484hcsP34BI3JvC/hnVi1H8lTqmHCT0rPRDAFtSEuQu70d2KAdn0GuKm/+Med0Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724734426; c=relaxed/simple;
	bh=kOPzyvAC8aNU/3TnytzRlYYlzPt98C/Ead2vtFcmScE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MoHuFe3YUjDVKjOcRer4RNa0H3dUIxucD1HKs9v1zCYpWiZxzWhY7qOIYbwyXo+c8bGDsw7o8nexOMqyZ/dEki6DJJXowJmNPYNKItdxvjWdNSyVZNLd3hSg/6Lu1esn5yJb8Yjt0CXkBLykgXQzd4ocfy2xd/jpt3eOiLXpsko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idGTov+o; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37196786139so3136049f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 21:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724734423; x=1725339223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3iys++LOfj8pdlpHxM42IssXw2bmawf0GVi7L3mAqks=;
        b=idGTov+o+Slt35FXUXr+hE+KDN8lDJ4j6xKgjuL4NhzRjk0PeJw2AyDq73Kh8z2VZI
         owwABX5dXKda1rbCBvDIoYvB5KMvwmoBoyf3ErNdgtCuW2Kj9skXnk+4OcTkrMcP1S9e
         LNm9WqA5SP/SRx9xBrvY4QliBdfoVn5Th4e5iDnmpK+/6kwgyHxKyOtSJ70HRpwey+XT
         172Mh8hQMRH/8vj76qFidaMalT9mKGzMoHVxx5BswQCErT8aGJW7J3miYtPyq4//v15O
         WQsRkfjDsBfVgHqpmSTm6tRedJ4K0tcdZMAgadCmV4doJ46LRuUMeZg7R2Xu+RrdUVVU
         Sz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724734423; x=1725339223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3iys++LOfj8pdlpHxM42IssXw2bmawf0GVi7L3mAqks=;
        b=iRmLaj4ishq/88w8pJZRiNEVb0v2YfZSjGMSNKmEExVRBKqJNR8+WOw4N5apiE5tWp
         BIq9yvdT5MGoVm4H8FkwDUujtxJnB0e52KVI7ymDq246QErA36u2pBAu61/7aNLnFMVk
         BScLzEzuZvf/khW0CrwH+269Ni+svb9I61njGABpQZpk3kU4qzSHQMhpCM+tg5l0qWPD
         aM8rv8OYsyQrC6ae+PVq2K3VBnFirtD+W1xW12+aReI3UVy/YZdmThT6I3jU2bCWYrgT
         yWAvx2jMOwir/foTKKTuGdWYzRVOmsN27jGEWZTm7Wxa5tIYyg0EjLkNHmqgJLKfUk0t
         J7/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUpGHl/p38B3BWvE3r9x9aYZjAcakhhfvAj70cHqsvEGJNOExZhHqsCLfibcc2tuULlGG3Ho1Wo/GnVxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF6zwI9PVUnjdf1ng47QsPcrZ3dEJzDx+/BKa43jCVf6h+LCI6
	QqRVaGUlLhlexQ2cVvQXIU8s/A9Go+ZzCuZUYtry0uI+Kzkwb4Pc
X-Google-Smtp-Source: AGHT+IHR/GMdTc2p0xuThLBO00V+v2Q/g2fhDIepwtZKNWzPVuBEf6annKsOoOHLRYpxdS4XtEs2DA==
X-Received: by 2002:adf:f991:0:b0:34d:ae98:4e7 with SMTP id ffacd0b85a97d-373118e35b3mr7063180f8f.41.1724734423283;
        Mon, 26 Aug 2024 21:53:43 -0700 (PDT)
Received: from [192.168.0.104] (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5878434sm58442966b.165.2024.08.26.21.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 21:53:43 -0700 (PDT)
Message-ID: <397a0f83-19d8-4af6-beb2-76d50ecf0b33@gmail.com>
Date: Tue, 27 Aug 2024 06:53:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] staging: rtl8192e: Fix parenthesis alignment in
 rtl_core.c:325
To: Gabriel Tassinari <gabrieldtassinari@gmail.com>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ~lkcamp/patches@lists.sr.ht
References: <20240826214853.21003-1-gabrieldtassinari@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240826214853.21003-1-gabrieldtassinari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/24 23:48, Gabriel Tassinari wrote:
> fix parenthesis alignment in _rtl92e_qos_handle_probe_response to
> silence checkpatch warning:
> 
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Gabriel Tassinari <gabrieldtassinari@gmail.com>
> ---
> v3: Adjust the indentation by adding one space
> v2: Include the modified file in commit message
> ---
>   drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> index ad21263e725f..75192041008d 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> @@ -322,7 +322,7 @@ static int _rtl92e_qos_handle_probe_response(struct r8192_priv *priv,
>   
>   	if (network->flags & NETWORK_HAS_QOS_MASK) {
>   		if (active_network &&
> -				(network->flags & NETWORK_HAS_QOS_PARAMETERS))
> +		    (network->flags & NETWORK_HAS_QOS_PARAMETERS))
>   			network->qos_data.active = network->qos_data.supported;
>   
>   		if ((network->qos_data.active == 1) && (active_network == 1) &&


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

