Return-Path: <linux-kernel+bounces-348604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F3E98E996
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB32286DE7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 05:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1314EB45;
	Thu,  3 Oct 2024 05:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wwOV8QwM"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7302545023
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 05:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727935190; cv=none; b=EEPzGgWDSft6nh0zzuAbCOQzPfL5hKtbU3oq4OU00Ti1l5TFbhv632LvPONYHT4sCDkJt+Bolot7P9HiEbhc0E61HQ6uDhv6qbPPAbLtmOne2IGbQNOjSixXdlAodOMYuwn2XzKMAveU3aj/dz++0XHkGlmjvqlg7peYdqVcpl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727935190; c=relaxed/simple;
	bh=OWOsm7ZxtLM/gvpBAV1VPiDsfc0QEqjnnA4NgVabO3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXcgBhR4y8EJ1I0W9Lk6dXJmidXecENtc9AN9/nCKAET2WpSrrAoIjaYOVgY9QcJi/t9e8VhupRlhNbM6pBVhkSAvRrYyiXTKhnBHM1bXjfsxJTztpjVMWK0zk1Q6GFoYe1/oe0iaNDf9VikDcxNz6lrIpMe3yiTkS5+t10ujGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wwOV8QwM; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37cc810ce73so340650f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 22:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727935187; x=1728539987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QaLuPXFwFEMXzwdJuRm9nCMZ+olqm02WUGH6BxqckLE=;
        b=wwOV8QwMYJIe29CHF6Jm7wNuItOkmA2jflTOnILTFIs6zJ7+8vAo3nXsXvxczh7czE
         AdJ3/Am4M3b6/uPejys37Ps5eqUyeMCkuxfiPz3z4xf/5NMa3qn6SfYmSqVQKA8cZt5T
         JrtOSMuPc+kaBwzwVbTw77jxWnRgWpQLMXgT+JJbHqs5TYr3cfA7QMGKHqCKr+Laq9Oe
         dAHJvf6L7i56wgQVnjafAwsCSM1DuGd5MHsQ8HJCzUXJhTm53j0gx7JSnsA+lzKu061V
         XPsW384+4brQG8whDWcFaWmgmAg4ziudNwcC6x6mcDwsM9svR/ROcRnxg1K+7CtQCOnf
         EiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727935187; x=1728539987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaLuPXFwFEMXzwdJuRm9nCMZ+olqm02WUGH6BxqckLE=;
        b=Zj9HPWFg8CJ7xXQ1o3jhIfYdJa/Nsw8rAWt1TMluzOWHgAcEouRHfIcuGboRfXuTUA
         q+QIrYlwfwlvIbbk4fBcwQM2K6VdPWVEHjmS23xRkgkrmlmF7QN5VSrj9IDcqZQanr/O
         g4vTaubyns/3QCFQKRgYYNf5cEDrpnx0EkOnnx2nlMj/pJ73cyO1f/kOFw2ZDS+mEVtl
         /71sGo98ETOFuvfKdRDQG4qPefoo+dgylMMnqNgb5GKq4nEn/1Gi6h8TVELf80cEOAI5
         AG+dO1tNiJ1jvk4tJtXspFQJBz6m90gufaDAzR+flaVQGWx1qoRsjwbIU/U9lNCZZE1A
         5sZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtOYJgL2QZb9FbfYpLqySKVQ9sd+VPXOxrbSeeBE59RaGWJxr7ZcHL+WaUSLpBCaoJjA+NC2QH+UE33HE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzABKTr+lvq6KLXbhlzKeI3KrSyrmyuavTTj3rDxAHBVtu7CPMf
	TR3K7bvzWXLySZqtVJ0NyyfLCVY6izx/ImxUoz0KJGKQlSwjnst31pzskrDdCnc=
X-Google-Smtp-Source: AGHT+IFhfzemxSCvKHPyI9lyhE5X9vj54jqzCvp5GjX9CuBFrvGGQSyGFB2LBZXOwoC5OjFWE4N+sQ==
X-Received: by 2002:a05:6000:bd0:b0:365:f52f:cd44 with SMTP id ffacd0b85a97d-37cfba0aa23mr2849115f8f.57.1727935186868;
        Wed, 02 Oct 2024 22:59:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d22b0sm464564f8f.102.2024.10.02.22.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 22:59:46 -0700 (PDT)
Date: Thu, 3 Oct 2024 08:59:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andrew Kreimer <algonell@gmail.com>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] xfs: fix a typo
Message-ID: <1fe2c97a-fbb3-42bd-941a-c2538eefab0a@stanley.mountain>
References: <20241002211948.10919-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002211948.10919-1-algonell@gmail.com>

On Thu, Oct 03, 2024 at 12:19:48AM +0300, Andrew Kreimer wrote:
> Fix a typo in comments.
> 

Could you explain what the typos are in the commit message so that we can spot
it more easily?  It saves a little review time.

regards,
dan carpenter


