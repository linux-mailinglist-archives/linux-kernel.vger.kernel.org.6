Return-Path: <linux-kernel+bounces-300011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF46495DD83
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 13:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811701F21E8D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 11:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC40158D66;
	Sat, 24 Aug 2024 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/6fK7W4"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F311156871
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724498515; cv=none; b=TopSPFkaRFIU2D5OyEXdxa4mZcL3fthw4uaMtBHQFHBor0jp1+VMDJeNTwulbn70yP6aJidK2ZHe41NPFgWEerFWhcrT/y41/yjj+tP/9BojDzB/yQgamhmLK1B0/8Y4LN4OPceUB0844Fevet3DJphVeM5mmXQcsXMptRppgYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724498515; c=relaxed/simple;
	bh=5zvM2KFJSLmf2j0o4lyODLjaUQNRb1ZGJX8epv/GGVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e96Oy1nSkQt8LVPSKhPbqLy+H2M664d06PNcUSwdGSgS7u/I3xxWKAOOC62MIMuz0FXA9ZTk+kxLk7ZK3vadYbqqsHFYC1sjcm4HGOPc9jNDFnnFLqo0ZjEbb32qpF5RSTJAfRyZHCc2b3SxH8zd13V1Uu7nxS6lnLurrmGD4Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S/6fK7W4; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-533462b9428so4832690e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 04:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724498511; x=1725103311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWtz5uoijD/6sdwyrDoZiDmd8tFNxLEA+zxzqd/1RmE=;
        b=S/6fK7W4QAH827MqfuAdqJ013BW8t7Qg1J59TbozRUWFshbRfxQ7r83roncKnszFcH
         LSDULP4XQuggrsXYbIgJ9WQfcMKEdvLKY8eIqAkD+zFY4MQxfJzQpj7msDqnd+9MAiJo
         6SsOJohXqCMe7aqEBYXK3ASL237Ac725IWbwiVoHnL+o1pkR2SJtbxh7n8PYEFe9EUG3
         BrwfrJqFSJZDJIhXtrf/ZcCizvtuL368W/gmHP5aSnO8qYjxDIfod0X4hwDZ8NZec1ag
         Az14DR+3C/WgN3CpuDDKNp1dbnxq7uEUZZL7dm4dK08T4wmD6wJ3MjhN4ZbnQpR7Zbgl
         aGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724498511; x=1725103311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWtz5uoijD/6sdwyrDoZiDmd8tFNxLEA+zxzqd/1RmE=;
        b=FGeYGsaRxsbWu0rmwJP+mAwcMiMOcPO2WqTY4zahsRkttker1sDBNQZkjerFAyq0JS
         kONDYgxTSRIfZzUkLuP/SesWuH51QWgdSk9R6UeqS8srguXbrWN55bRUC9MkR0Xndc23
         i0L3Ec/dW9sd0zUj/w3HVh38Zv5Jx2HE8Y1T6l1R6v4YaPOe1dzodkiwCuzBgPdQIXq9
         KRDhvY4Wahbn7hc1M4L45DdKU7cEOVlBTscCy/ggC2QHV1ixl0P3BDL+Fx4qbEf+6ahU
         8wHxkYSPGsgc8rJic+Xq48DdIILEe88SbpIjJbCx3eUpcLL+aQ+q/dC7sM9TnSsCVo0I
         6q1g==
X-Forwarded-Encrypted: i=1; AJvYcCVZWNJyfqR/GbY1TQ6lkxXvUk4DJTQht/I/vCPpZ7Jv7ll6ggVlsbZaFj9mqaVXfxe0rJ3Zh4UGTJprdnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcjI/CWdjxb8FZW62YNy9FgY9Bo4CADFEASa88GfnHYD7WyMbz
	0ML7+sFNGyIuyvqfADowJ0MG8llJ4ok6rWJ+/h0KEVnHpYLteKVnau8s/BxNeuk=
X-Google-Smtp-Source: AGHT+IGtUfvB4kMQlCuoYKzAcwIUuuNFxDcBEeAyNnD4OTfW/GqzvO7likpmTQdheQWzjpKz07iUyw==
X-Received: by 2002:a05:6512:b86:b0:532:ec7d:9c67 with SMTP id 2adb3069b0e04-5343887e143mr4772670e87.47.1724498511343;
        Sat, 24 Aug 2024 04:21:51 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f48a9b6sm393560466b.179.2024.08.24.04.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 04:21:50 -0700 (PDT)
Date: Sat, 24 Aug 2024 14:21:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: gregkh@linuxfoundation.org, tdavies@darkphysics.net,
	philipp.g.hortmann@gmail.com, garyrookard@fastmail.org,
	linux-staging@lists.linux.dev, skhan@linuxfoundation.org,
	rbmarliere@gmail.com, christophe.jaillet@wanadoo.fr,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8192e: Replace strcpy with strcat in
 rtl819x_translate_scan
Message-ID: <1c640c3d-c5db-4eb7-8a22-6d9886a1412a@stanley.mountain>
References: <20240823153411.74142-1-abhishektamboli9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823153411.74142-1-abhishektamboli9@gmail.com>

On Fri, Aug 23, 2024 at 09:04:11PM +0530, Abhishek Tamboli wrote:
> diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
> index fbd4ec824084..ec0c4c5bade7 100644
> --- a/drivers/staging/rtl8192e/rtllib_wx.c
> +++ b/drivers/staging/rtl8192e/rtllib_wx.c
> @@ -23,14 +23,14 @@ static const char * const rtllib_modes[] = {
>  };
> 
>  #define MAX_CUSTOM_LEN 64
> +#define MAX_PROTO_NAME_LEN 10
>  static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
>  					   char *start, char *stop,
>  					   struct rtllib_network *network,
>  					   struct iw_request_info *info)
>  {
>  	char custom[MAX_CUSTOM_LEN];
> -	char proto_name[6];
> -	char *pname = proto_name;
> +	char proto_name[MAX_PROTO_NAME_LEN];

In the end I think we don't want to make this buffer larger.  But if we did
this define is really vague and slightly confusing.  I assumed it was something
else when I read it.  It hurts readability.  It would probably be better to just
leave it as 6 instead and add a comment.  /* Large enough to hold "N-24G" */

>  	char *p;
>  	struct iw_event iwe;
>  	int i, j;
> @@ -59,13 +59,12 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
>  	}
>  	/* Add the protocol name */
>  	iwe.cmd = SIOCGIWNAME;
> +	/* Initialise proto_name as an empty string*/

This comment doesn't add any information.  Every kernel developer knows what
memset() does.

> +	memset(proto_name, '\0', sizeof(proto_name));

Normally we would just say 0 instead of '\0'.  The other way to do this would
be to initialize it at the start:

	char proto_name[6] = "";

regards,
dan carpenter


