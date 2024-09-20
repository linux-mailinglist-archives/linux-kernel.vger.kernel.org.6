Return-Path: <linux-kernel+bounces-334307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F2497D574
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 14:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BBF8285065
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 12:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F84D14D280;
	Fri, 20 Sep 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wDs2Ootu"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE6D1E53A
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726836028; cv=none; b=TBBlyjoo96d/C0Xzg3KSNVM+eIcEFffIbgb8GT0SSRJkZFfeQ8KkmelMLfPp34uMRwlRpiJQAkDOXcSPTNhl15rNA5OqvDx1LkgJwhrvMeuSBt39gPZk4pHRPkcUvlCdxAxTD+QTXZX+GP+xCZi2+0SBMkmSItepSrekCy+A7lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726836028; c=relaxed/simple;
	bh=q4/BIqY4njqvHVv2+iuLTLDB8guMw7qRfA1PrzlgKb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hp2DxAb4ArY6wPA2YhyXNUhKQ3zZvdKZsbcVGiglUggqSWLGBf4eE25ppioKrGGOB5QWkd2pCej24PoYmH2xbbOZieEd965zYErFFHu3Hlo9wNuexGa41Rauh8nQWZu75Yt5Mu8AupUOfx1jj6aXuoD1/vm3zB6ihAE0VMiPpHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wDs2Ootu; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so282657466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 05:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726836024; x=1727440824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AiKowJe0HbnPow5P8xWO2DJd/woQKyyq0ClUMSBtZrU=;
        b=wDs2Ootu85NAu+i9fOnsV7ZU9vKx/VgA5WsNTzbPiitKhMDjhITdQ7+RP1btZCngA8
         tpynl8xn/KrjaMt0iWbnGajVk4CwqSNoHTiOqTEV/j0IOwMivFokvQYCNlleS6WM4xX0
         k28w673Y8zRekRi5XK56Y/cuPT8K3z00U4DrjmcyjFxIxz+FY1zUdwg1wyfwc8bGehYs
         GHsn+4tj5vRPTfMphFnA+tfHAW4rbjCFe2zl5GmAp0AjCRcajvOhSd0Pb2nmhg2blTEn
         Vt9a0JdvJ3QcjhSnilU4ljJ171HUqCOmmrOqXSsCvMEjq5PWTWP15WDG4V4ArffBV5JN
         /vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726836024; x=1727440824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AiKowJe0HbnPow5P8xWO2DJd/woQKyyq0ClUMSBtZrU=;
        b=OkGp2cBbT6NdkzVCIH1UCWV7zdWNyik6fSYSqwDZkKvWnqoQ4l7pZz5TGcu2UU1Hae
         uXvS7hQzCaprQA9q2BjTIsOnzPxpUwo1ULb5FAOZUlZA6lgWXrp3CAUXLRSstkP1jiB5
         eN7o1kH3k3uJ+odmJ4MwPPv876NzLuMk/cWgARiVNwq4ic7et56l8IMgKfNvHbAA1DDH
         yLTZcz5+ZJeGGgxtDpTGvGSMK+mJ757/z+mRmuYJDCWh0hzafnbUxI2gNPA+jFPuZ6c9
         sHDEiVc7E+O+q+Mkb8b43U663pIhScAZ0M0UuWtk/wl7L03gcfyhEXkTf5A8Z1taQkG8
         f8Lw==
X-Gm-Message-State: AOJu0YwdxKAjcHlpsdn1zbx5GEJqdN3Vf4w3FQEVCk4VUChRvI6cNNDi
	Cxof+pWTx+zxJrrX5qnBN+Z5ReqlP9+mux8oVL2WdQ8Riw+k4tpytbl7S97+BK8=
X-Google-Smtp-Source: AGHT+IE81ecvGa811EkXoyxww1gN9FJ7ZQtA+4G8+0JY+jFcluigqv32wSHx83rVVcOb2/GjOEiFpg==
X-Received: by 2002:a17:907:3f9f:b0:a8d:4631:83a9 with SMTP id a640c23a62f3a-a90d4fdf292mr246651966b.3.1726836023713;
        Fri, 20 Sep 2024 05:40:23 -0700 (PDT)
Received: from [10.241.208.32] ([193.32.29.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90613303b4sm838990666b.213.2024.09.20.05.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 05:40:22 -0700 (PDT)
Message-ID: <05c413ac-c020-4270-86b5-de407d878cd6@kernel.dk>
Date: Fri, 20 Sep 2024 06:40:21 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] MAINTAINERS: fix PKTCDVD DRIVER to use L: for the
 list address
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 soc@lists.linux.dev
References: <20240920-maintainers-m-to-l-tweak-v1-0-ea80b5cd3420@linuxfoundation.org>
 <20240920-maintainers-m-to-l-tweak-v1-1-ea80b5cd3420@linuxfoundation.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240920-maintainers-m-to-l-tweak-v1-1-ea80b5cd3420@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/20/24 5:03 AM, Konstantin Ryabitsev wrote:
> The PKTCDVD DRIVER subsystem has an M: entry that points at the
> linux-block mailing list. It is perfectly valid to have no M: entry for
> an orphaned subsystem, so change M: to L: so it properly indicates that
> the address is a mailing list, not a person.

In lieu of finally being able to delete this ancient thing, this looks
fine :-)

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

