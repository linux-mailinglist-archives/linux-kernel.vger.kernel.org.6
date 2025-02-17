Return-Path: <linux-kernel+bounces-517330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6872A37F69
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC3D167F4B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41C5216E1E;
	Mon, 17 Feb 2025 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ugfb8tXw"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECAE2163B7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786673; cv=none; b=PiU3qnoszlVqkhoYJpa2bVKsSqXvX/ymBqkK38PaeAd9OBS8bEvgIMpiCBwOwMYoLbDNzpi8Zmezncj63N7vuyKecSNOQ4tQeiGrNVshzLAfbSxXlTMsSqStAbdDgxHr0MzRmTiwbUAptFgfObiTO6aDedyJzwyrLnDB8sDv23I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786673; c=relaxed/simple;
	bh=U0HtHK1poZiGESOdrOrgpOi2G5JJ/usr50rmbJv/Gfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7UZGW3sA8BRKqBtyZFWiLpuzmRWDYNiUA9RA2jvRWilxz/I72vWvTceFaL5gotl/V4aWqorKCBFDK13iEeK5hlsgSbLm531jljqFceMsl+lvvnBSVl2OoCszuNZp1LA6gsOfzBkzNiBQ1LAMPCFWts5v5VzDdGRvytulfLRvOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ugfb8tXw; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dea50ee572so6142928a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739786669; x=1740391469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9icW+RZ9BUlJeT9qDjb0oU0qZhKkpwVHO3FgIOiJAJY=;
        b=Ugfb8tXwDraXTkCGkw1gaKp6Rm7obJgIuteSycDrPz4OdfTUVHZRbKktJ0QyVW4wjk
         oQekwS8opN+9jqRB32121H4iMPDUNKNr8627bzGqWLroAwdZxWJwit7fxizVtSqKCUFw
         xKyeYLIwK01gDfpbRJckezApr/CzIkenOMbDpYL6OGKarmDaiAC9swB2egudBcgYd3Tx
         sWfnh/uf/5fnm8Z3vCEi5hNtK3hPikk7Vdwr31njOZSo0BuVf2LadDB+p81XbJO9HK4D
         y/nAONM0McFfDCGAjaCwDBpbRg5vEdR80LhQWSi4JxZvXL1R4xhtVttFmI44GJZ1g27v
         ZWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739786669; x=1740391469;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9icW+RZ9BUlJeT9qDjb0oU0qZhKkpwVHO3FgIOiJAJY=;
        b=jM4iNnx8822bd9uDiZVcoviX9JztLOo2ycP+IqXeLWKcd1cMK4N+/P2jSyNWgKtxHk
         FmUa6w9++fKYoXFZ56lqcmOd7QMCsYwZJT8xz28QyOcw/nZiSLOEgznGkE2Nw7oGkRyC
         kghCxwzzewmYemmWVqBbcEofpTyfcWCQFHRQJ9ykkQUiN2rO+5Cz42xdkF4RTYGQ1GzX
         YFr69HhF3OJLu7dOHkfVHyuFYmbGCtJORv31qlPxQru1Lhylc4JAKPJ/Kj+TxarLvY/h
         pVtFxHwMc7TAUvn5Ac8zNuDU16/gxP29/Po9OOIqF9Vm8qfYAA79Bf2Rtgho7ThbrFpm
         hdsA==
X-Forwarded-Encrypted: i=1; AJvYcCUEhCYykX2UscvzvC4KbJsr26G07ewlD9PAyHQ7o3x5iGO/zxuHuZbCLDMMw2nSosBMOzBGWBIoFLn4l0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFc4JjXQjAZ8nbTP1ArWiNgU45smIPxiZ6wpU2pwxSGLjDRScJ
	eTB43PNTvtd3oHhUwFDT8WFRBBQu1Wkky6cOcCwGf7ZB4E/mEfa66kMC+TL4s2M=
X-Gm-Gg: ASbGnctvGEzW/XK8Nor8USSgbDbkq4abCHF7HONkPeKCD71xEtQ+rsvqenvR2Zp68PN
	zajNEzrc1T02WVw3gqrUhWkA61x4gumjgO51bMdUBks7tkl574Gggs/0G0KX47z6CjFCZKKzeTj
	iQRqO8J0axoF/SkA0Aq6ESftp5vFiq8ODrbD/XJPd0vX59OFzIlLlhtQGqnMSwdVaVJA3UWOQHl
	uPrCDXcvmhth22osS8VfgFCnXYxvRkqea9yC+/ENv4IWpqTHgfIu6C1YDptqZLAB/0LuP0athc1
	gr2BD/TwzpsSK9f31+I=
X-Google-Smtp-Source: AGHT+IF6opUQlIwxb92mSmm1gEo9G17RkPSkKeifhJ7EJuyYBZxee928DaKRSRvvfQmUPMLsNyXEjg==
X-Received: by 2002:a17:906:3087:b0:ab6:e10e:2f5 with SMTP id a640c23a62f3a-abb70d950f2mr787890566b.37.1739786669553;
        Mon, 17 Feb 2025 02:04:29 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb952c7364sm234250066b.18.2025.02.17.02.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 02:04:29 -0800 (PST)
Message-ID: <c8cd1730-9472-4b02-9828-d1a8221fc487@suse.com>
Date: Mon, 17 Feb 2025 11:04:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2] params: Annotate struct module_param_attrs with
 __counted_by()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250213221352.2625-3-thorsten.blum@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250213221352.2625-3-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/25 23:13, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> attrs to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Increment num before adding a new param_attribute to the attrs array and
> adjust the array index accordingly. Increment num immediately after the
> first reallocation such that the reallocation for the NULL terminator
> only needs to add 1 (instead of 2) to mk->mp->num.
> 
> Use struct_size() instead of manually calculating the size for the
> reallocation.
> 
> Use krealloc_array() for the additional NULL terminator.
> 
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Queued on modules-next.

-- 
Thanks,
Petr

