Return-Path: <linux-kernel+bounces-178024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327DD8C4794
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFADC28292A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93B576058;
	Mon, 13 May 2024 19:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MV9xnDpf"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8877D1E49F;
	Mon, 13 May 2024 19:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629051; cv=none; b=LBAhn+k/U40pLQnhWzgB3g2Qp65nhnk31Bu0xEMk1jOVS+5+GeaieHm03c9xU8owwBRwiPVOXWslRIjJyhRD33nSxhiegBoYK+zBfoh+jbMJTVKCOsvq+iTkQOmg5LLGrFpnbvtYuwuZD44Ea3EWp93Jdzsf+9JWJpv/v6EKZro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629051; c=relaxed/simple;
	bh=M9Av3oU8n04AtsbwLQfSL20FncYfaav+0D7ozavvTf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UT32fCgW2nQld4lUWL4kNLfY1ypL5H7cFA0USybeZCI9vRg6J9ix4U7a6nrQe9+h31xxGDDeBh6lWs6fDuE9ShAOyWrEWsAnbq/6LewSI7Erbas9/gb/60SBdePEQvTUK81nHjomkzvuwJud2f4NL67jSgnXMKi24Lv059Iv5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MV9xnDpf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e3c3aa8938so32333845ad.1;
        Mon, 13 May 2024 12:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715629049; x=1716233849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WrXG6JI63u00fBjFaKN5tlrQUFXX0nIsNBWnFMgexpY=;
        b=MV9xnDpfkPXU6HCKJfPx5M8Uvrjm1yJj51BDhtj+GbnkpQrAmAMVWJdW1pFKItA7sL
         PY1sjkW3XaeqdS4tEN0I/Kb//1uVraDWoPN+Hq3UgiZdC/pvDqJwNsSNjK2yhCwreaHD
         z/uARP84lHemkZe+h9Zw5aYzOOsOFvz+O/6vsTE2JD33p0t0DS6aQru440qC3UY/KjOx
         68vdkQHy6FZoKCsVx297rIZyO11FUBoljnRWEVrLe6jJfHCC1N6pxUtfgG/80uMteKGU
         t9HwpkQ5PkDtWmcnuCrOY/GqWnpaaoVQZ56ZRMKlQBmdeEAC7TORw54cYTytePMZABgS
         BgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629049; x=1716233849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WrXG6JI63u00fBjFaKN5tlrQUFXX0nIsNBWnFMgexpY=;
        b=XvQVwErzefBnG3IJnVKlduMbWDkjN0pBkfdHDY9JgGgtAuk0JCMRO+B4Kh0ngch8PU
         nTFQ9EoMILOGXADvpqnyLRHT2sZvOQJAEpwEq/HcA1K2OZj2f+S1O1JuUwHc4curMYOQ
         PCKRtNS4dWlovzRrnfPsH1ef0K+t6EDixe3OcSIxOQNk3zllik1rbv3b2vhm9sL4HkBD
         1cbOhwY2wyO0Grlb5T9CHGNAODITH8zrVufbQSqB6Q0un6UMroMHk5prUdWehFxuq3Gf
         Iol2OLfS27nbFxcS3fWsBC/4HXgXpIJ3+N7bzTSBRgUvXahksafHtd/s3ZRwpdOoaonh
         8OqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgPb3mMM23aPq0lgFh0rPxfbV8viQmwiJIwyGkGr90tHOSF86GZIrkA0xO/zSInE/X8sb6Xp3jzsF3HiX/PFlsmpshwwW2Xfplt/EJ/JbIh7upYV8uxKQ5Q78ksORpmraKXajt7wGGK+A=
X-Gm-Message-State: AOJu0Yw2zGAFTO1M3P6pZ0a8mH+OXofJn4NNDqrY5w+ajAxitKIw8vBb
	q05PJWve56+L7iVqTHFig+SeTCvlGXb6T0zJkBjWEKCGXY41Rr6n
X-Google-Smtp-Source: AGHT+IHqZslrfWabBRBr1EVGcLS86482a+ubhlYZJKVMxH4xU5RvaLQMxScoq+w3QCmTcw5tZ62+6g==
X-Received: by 2002:a17:902:da8c:b0:1ee:b35e:963f with SMTP id d9443c01a7336-1ef43d18cb3mr129145865ad.26.1715629048802;
        Mon, 13 May 2024 12:37:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c039e89sm85207695ad.224.2024.05.13.12.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:37:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 13 May 2024 12:37:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Marius Zachmann <mail@mariuszachmann.de>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] hwmon: (corsair-cpro) Add firmware and bootloader
 information
Message-ID: <6d063681-03d5-4270-9fe6-7879fc019382@roeck-us.net>
References: <20240513192538.40144-2-mail@mariuszachmann.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513192538.40144-2-mail@mariuszachmann.de>

On Mon, May 13, 2024 at 09:25:38PM +0200, Marius Zachmann wrote:
[ ...]
>  
> +/* read firmware version */
> +static int get_fw_version(struct ccp_device *ccp)
> +{
> +	int ret;
> +
> +	ret = send_usb_cmd(ccp, CTL_GET_FW_VER, 0, 0, 0);
> +	if (ret) {
> +		hid_notice(ccp->hdev, "Failed to read firmware version.\n");

Please use the following pattern:

	if (ret) {
		hid_notice(ccp->hdev, "Failed to read firmware version.\n");
		return ret;
	}
	ccp->firmware_ver[0] = ccp->buffer[1];
	ccp->firmware_ver[1] = ccp->buffer[2];
	ccp->firmware_ver[2] = ccp->buffer[3];

	return 0;

Thanks,
Guenter

