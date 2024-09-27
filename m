Return-Path: <linux-kernel+bounces-341620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF56D98828C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921A7280DD6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2971218951F;
	Fri, 27 Sep 2024 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Og4wUFVZ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D985F15FD16
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727433142; cv=none; b=W45uxNa2wHXi+oQC+yLcrIovVxH/MmyMUUID0peys/QuPks5ZgJS0wH9BE1ICrVi0SuxtU5gyOJiMxyzbdmQVQQzQ7chnjWCDXFiF4tojI/jMyoypxodHAhFhjdCFoJ6UMs6H2Jpcv/JGYb3jpiqG0N17tBwidbJ+I3CQ4uOg/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727433142; c=relaxed/simple;
	bh=/5SZIcto7qgN2Tfj4OlkP3fsvngusO4epQHLOlVZsmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Olk0ewYBo6w3jFsRet6nacAbXOpVstuTEOXk4oVS0A4XzBxkb4NRzdu7fCT9m8Uju/Xn7meWGV+pNcrM+RUcjjrWGuOXd5PRYgXLySKfezIr5618ITUheCXy5pGd+pI5SGySwt4vqYXWZ9SHvFfU7BrndkzGxbaWIgKP0pkIxKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Og4wUFVZ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so16426035e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 03:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727433139; x=1728037939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DdmvFk1zGQs2rFnRAdCqQIY/+ci6VPOq7UoKUH/vbeg=;
        b=Og4wUFVZNllH5Db63/5av3S0zilMHYv3uu3ObcjPZGuHxz957gvS3osillpFG+4G38
         NOim85FF9bTuocb3ARVETffDp9OLlBEXgPzovqgobgwHA4KaYBK6Me53wmwgT3ryCoFb
         gPK1dcy/HzhtSGAzLIPJjztal4/3d6FtjUwt0QB5wQifTBNdjL82Jj5ftlUniwblgS1m
         2SxP1hJeUZ/IjkhWiaV09m4yEJoczg76b93V6XCQTbJRg3MOmrScIXYw5ZrxIPAiGjPz
         vyZGW+YPYp1cnJOjn4+uoC4TId28DLNtvdczh3QJy2BQUxVaPdNVXZx09JpbXMSlOrpw
         8gJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727433139; x=1728037939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdmvFk1zGQs2rFnRAdCqQIY/+ci6VPOq7UoKUH/vbeg=;
        b=BynYljDWdn5vsDO6ZQ+ONmM1LU/f5BiVyaA0wqj5nFgjSs8L2ZOpPLwtRpJNC2N8Ir
         oAwGMJ5t5VS8zlIUX22RRt3q9JGze5WDhEfEdTNXQzmMxzonkz9NG7OeDDWYK4kxeHx1
         Or1/96h93vM5V8hoQf3NZavCgplCXGnQiorNEVCznPcr8UcMNLAnmG1R+TQ2VyKdCYFd
         O+hVLLWI3XaPMgcj5N3QOrnHNjIOXb7rFzxrk9MEk85MrHqjop7VHqrtEZ0EnMbOpwkG
         7pXsEXe8HIfZ2E5HDwhMU/gaPbk/vwh5JPaF47VoL3tIan3EgR0dbl9RpEuvoFZmiEUE
         hxtA==
X-Forwarded-Encrypted: i=1; AJvYcCV35lqvC4hgDAIMK7u8vTETML+vCoZqdHv+ME0Ou8W4+lIceqRwoEK8nLQCkPkmGU/JaxY8iJ3mcmoIvZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHTZ8oQNJcsfJBRxsPyEnG5Hd0vw0A5PumzJPW/VTSkCEVJz0M
	7cIlo96OcaXnNSW6lvxu+lk0ae5L4ET03EZugNj/SPl11bbk4wRJFFJtcUrpurA=
X-Google-Smtp-Source: AGHT+IEI5zaCi7IffgRkiXlGP/nEaiUxN6UmQFK7bvc31AyVqNBtOMrQp2GsXDb0ukk39MwDBlTJzg==
X-Received: by 2002:a05:600c:350f:b0:42c:b037:5f9d with SMTP id 5b1f17b1804b1-42f58409dccmr16523645e9.3.1727433139311;
        Fri, 27 Sep 2024 03:32:19 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57e2fe7dsm21657055e9.46.2024.09.27.03.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 03:32:18 -0700 (PDT)
Date: Fri, 27 Sep 2024 13:32:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: andi.shyti@kernel.org, shyam-sundar.s-k@amd.com,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: amd-asf: Fix uninitialized variables issue in
 amd_asf_process_target
Message-ID: <cc527d62-7d0b-42f8-b14c-6448d3665989@stanley.mountain>
References: <20240926151348.71206-1-qianqiang.liu@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926151348.71206-1-qianqiang.liu@163.com>

On Thu, Sep 26, 2024 at 11:13:48PM +0800, Qianqiang Liu wrote:
> The len variable is not initialized, which may cause the for loop to
> behave unexpectedly.
> 
> Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>

You forgot the Fixes tag.

Fixes: 20c3cc299218 ("i2c: amd-asf: Add routine to handle the ASF slave process")

regards,
dan carpenter



