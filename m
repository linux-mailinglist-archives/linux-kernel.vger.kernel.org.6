Return-Path: <linux-kernel+bounces-172698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88AA8BF593
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 767F7B22A2E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 05:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD1D17BA7;
	Wed,  8 May 2024 05:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="j88ccihM"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E12E15E88
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 05:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715146460; cv=none; b=owSHh8tWjDboVNLZlEgoYAgu0uuBidgrgD6leYQO9acX/H1tSglZNPCVqB0NwpDahph8kpBnl6wjtd4TukeAyaRzoXYqAwMClbv6lI6qdvq5/c+xpaOPbHzYdrjAdgiTGjLApDrOtQFCZBxaqr3eA6AUpMd1zHZHrpLXUCCa1aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715146460; c=relaxed/simple;
	bh=Mgc4qvmHI5USLX4TSJDzE/lN4QyO/e2B1pGdj7DbaaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6LTurs2EqtsYgWEIknbzeFcW85JHeOgVAIrwU05IVwkUpaePL+5SyGtr1giVx1Nay9dp9u/82FiiiMVsIy3ApgGh6LxEHsjkfLVBrjkBcSwkwu1JRrfjJK3PZ4hNFos0YbGBwPtojuKXv1aPfmIHjuWTp5D0PWAlZvb9mbjPEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=j88ccihM; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f467fb2e66so3166168b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 22:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1715146458; x=1715751258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fXT/Ht6B5HpOzfTzjvvlcw2AzVRmZ1Sdv0MVJNtZ0AM=;
        b=j88ccihMcOAO/pW9IWO2VnDt8+i5GMktEE2DgjBrQFnnrmjmMfvToiDkXjfg18HqDM
         Chwj0dVx7JIfRhdvhiwLGn1C+XKiEpGqNYG5g9QyQPijPaO+hoXZC+h9Fix0qQqNOroI
         cr+/SAg52MxCeLuavjetnd+EFdtB7riq6XcuA+lXOhkk9O4Kdrp3Op6SvzFQndVU1wYB
         g2uydNYRPyXIAIZ1v5Z5YNVTn4OdCZQ1XrCVZ3La0r+uZrqFDsHYe4TzerfuH0S7UQz4
         ASWLpDq+tXV25IEKlpMbBGNd5MeDFEer52xwNmdAXp4Mq2F5GHT6uXO6U/ZCydnOuGH5
         6Vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715146458; x=1715751258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fXT/Ht6B5HpOzfTzjvvlcw2AzVRmZ1Sdv0MVJNtZ0AM=;
        b=QyoB05QNiyu5mvO26bOEz6/+2sLUi8Bs5DDZFO/UD9bePz1Y2i1EZ7y+Z29TGKFsr4
         zwHtQ5l2BAmrMcSWnOMzKYIcUeQDAAxDudfUMZ08qYQr4Ci2/jL2ZB+n0717jgNkEUbb
         L+960lvCwxvgt1Pn9T0MwwDlT5ovKqXwB85zWvjCaKTRct969/YzkpOLRX6vj6+h/oIA
         dsQhVPXmbDsWxbSQAgiBxGdR3KvnLxKT8JLVWeerVRpsmjXw0t4sGlYfjcvF3h8c35r7
         e6Yh8mVKBwkFeK3OHTQBKW1X1/Z/uBsLj57qVky4z1c9+huOYs4ejbo2TgmSQLI4XlDd
         W/Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWet+DExcfXHgQp0A6CwDD5BqYY1GNd3ThABp86YV6Nj7/l2uIqBJz4bkRfqoZNI73KRD/kihrlariq2fk9BUP+IrcCd/FwUkx4rOts
X-Gm-Message-State: AOJu0Yw3AdcqprgxIJKZgecp+2eTGi4ZBasAWkrluVgmmUJ4Uo2b7TOy
	1P50rqSbKz8MtkNOKQkoMuf7JN7v70m0mmvaxtA7pvRrvH52gKWXl+irP5QBsPU=
X-Google-Smtp-Source: AGHT+IE6nF92f8yMJvw4QXM30dHJBCHwIsLxQLj62XpbEJNdClKoMiShhkTXCvn5sfSkppH7D38bPg==
X-Received: by 2002:a05:6a21:880a:b0:1af:9e3c:63c0 with SMTP id adf61e73a8af0-1afc8dbe1cbmr1900935637.59.1715146457800;
        Tue, 07 May 2024 22:34:17 -0700 (PDT)
Received: from [192.168.1.15] (174-21-160-85.tukw.qwest.net. [174.21.160.85])
        by smtp.gmail.com with ESMTPSA id z8-20020a170903018800b001e4464902bcsm10911053plg.60.2024.05.07.22.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 22:34:17 -0700 (PDT)
Message-ID: <64a7690e-50a1-4b3b-9b9b-5c2efa552806@davidwei.uk>
Date: Tue, 7 May 2024 22:34:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] gve: Add adminq extended command
Content-Language: en-GB
To: Ziwei Xiao <ziweixiao@google.com>, netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemb@google.com, hramamurthy@google.com,
 rushilg@google.com, jfraker@google.com, linux-kernel@vger.kernel.org
References: <20240507225945.1408516-1-ziweixiao@google.com>
 <20240507225945.1408516-4-ziweixiao@google.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240507225945.1408516-4-ziweixiao@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-05-07 15:59, Ziwei Xiao wrote:
> From: Jeroen de Borst <jeroendb@google.com>
> 
> Add a new device option to signal to the driver that the device supports
> flow steering. This device option also carries the maximum number of
> flow steering rules that the device can store.

Other than superficial style choices, looks good.

> 
> Signed-off-by: Jeroen de Borst <jeroendb@google.com>
> Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve.h        |  2 +
>  drivers/net/ethernet/google/gve/gve_adminq.c | 42 ++++++++++++++++++--
>  drivers/net/ethernet/google/gve/gve_adminq.h | 11 +++++
>  3 files changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
> index ca7fce17f2c0..58213c15e084 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -786,6 +786,8 @@ struct gve_priv {
>  
>  	u16 header_buf_size; /* device configured, header-split supported if non-zero */
>  	bool header_split_enabled; /* True if the header split is enabled by the user */
> +
> +	u32 max_flow_rules;

nit: this struct is lovingly documented, could we continue by adding a
one liner here maybe about how it's device configured?

>  };
>  
>  enum gve_service_task_flags_bit {
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index 514641b3ccc7..85d0d742ad21 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -44,6 +44,7 @@ void gve_parse_device_option(struct gve_priv *priv,
>  			     struct gve_device_option_jumbo_frames **dev_op_jumbo_frames,
>  			     struct gve_device_option_dqo_qpl **dev_op_dqo_qpl,
>  			     struct gve_device_option_buffer_sizes **dev_op_buffer_sizes,
> +			     struct gve_device_option_flow_steering **dev_op_flow_steering,

nit: getting unwieldy here, is it time to pack into a struct?

