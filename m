Return-Path: <linux-kernel+bounces-449187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B24079F4B26
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A84188A81C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F671F4263;
	Tue, 17 Dec 2024 12:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vHV8utAr"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D3A1F37C7
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734439264; cv=none; b=EYVlmZrMzyZvKPwoJcDP79qyRsyim3ErRoFK/snXWftD0wSFeTazdCiGpPh5xvIEEbYtQxiqoQC5/qzaNehFzkDOsc7x9Ea4/R3tpKK96hh1fwkMahDYnDiSIi8pp0DfAh9ezVvD5KYWm1IeKVEDF3lXTQ7pX/hjloeAd/22aYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734439264; c=relaxed/simple;
	bh=zktOsVkVxxQOGMhkfdhIaNBA4MeCVA4pyULsaxoa5BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jg0zIjQ0v7CSPs/35Ccz2tZzUNLqvZYUF4Ni9DVw5JL5addVzZR4+cS+8mgJlUDQNAFZ9NEIEdNEPV/1eUvTl3II+H34aWjVJidGiqHyxQi9lPvXle3MfUq9bIvpOBcBLyshagIL7dRzHS8+5l6KIGYU55SZoseiaIBAVqXYr+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vHV8utAr; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d0f6fa6f8bso8424839a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 04:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734439260; x=1735044060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zktOsVkVxxQOGMhkfdhIaNBA4MeCVA4pyULsaxoa5BU=;
        b=vHV8utAr2ZI75QvSNUfVCuVmaBkEyDqsTYZ7eFQGZpu1w3Peey8HR7g0sk2NLAQavU
         BPfVX+OHbELO9oF6J/qb66qA4QGhTQZbA3yD4459MwGUC0PSr6XKzFcQXeI40qdi+wpI
         K62xWySC+dvmtWu7ZiV/7TWw3WtOPe+YSLIXAnoDPChuZQrbE8NIKQ53Ikt3eNP96iCz
         cGZayxOR0AcMf8CbIyja2Ux8A6mmFi3nsq2PvO9mKEcEt6bGwPoq/nald5Jhw04p3BZh
         ebhKWNKZR2rD4D5787GBRyrGAxQ4iK8hk8wndIZtVv+lVdcqfN7i3X27pJD63NsiM0rW
         o1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734439260; x=1735044060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zktOsVkVxxQOGMhkfdhIaNBA4MeCVA4pyULsaxoa5BU=;
        b=cwn3BV3rEmWI9kqvwn9nNle3fBO+Dr7aopO4MquhiXr7c3moKluuiKku2WeEaBQVf8
         xKbKLRqXVxP9kFrPu1GTFCiRTBDpevvokq/5+sQlJHgkWyjMTOr1sxO7KD2vKy8szq6j
         gHapyOaqV+ICjb/95odlSyGTYPb02LkuVF32xihSPFy6wFj+b1Gv3b5N4l7pRVnUpJzG
         WyZVYj559bnVsJpYyWq37bXpc1sctciJyLhAC7Bk/bjauABCB8cyZcLC4wogI3csiXOJ
         qw8iO/PGtXTV+LuWrhrUautuvf8F9QwSJxOLqUqLY2AbbEjOp2PrBy2YsRMUKH0It3Lc
         RFmA==
X-Forwarded-Encrypted: i=1; AJvYcCXIYbknpCbRbFkmllt6uK9CEdHSEJ/a7JmAMTvHaWRsIKA1oESb2v4ZWUKPv+0klxBCcDp5lR6JJgO9B+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YylSd10wz1mEqZo6LWOcaDLKVRYrMMSfI8fdkCSCmr9cIpk77kN
	B1uJssEL9x1TGx3E3aEkWhaed/OE+YetrBuAhRldWWkz9jibVX+PMAK2ckZpCNuSrHSEd/HlwgK
	m7qP6KojUdCFUrqPll8Kn/hZ6jAPs6C1Pj0Kr
X-Gm-Gg: ASbGncvfrkQoZHXZqMBV571SUtyYja0KgIvv8VLDQjX9MZF/+oPPIHPyKkS4Us0C9Mv
	uD7IMIFvyKoXEyweTbJmV3N+B7qHMyh4ZzeCHU8C9hpvRQ47OowqQkNBHQcmWUCDuIPv4uMlG
X-Google-Smtp-Source: AGHT+IH3mnMSz1W9u8JOiuZGydso9Cjd9kGw8eKTwmdRl9f7Hcj7+iXrFyrilZSWhlLyhDwpWe8u2Ky8DmHErNw/FlI=
X-Received: by 2002:a05:6402:34cb:b0:5d2:6993:ad91 with SMTP id
 4fb4d7f45d1cf-5d63c3da9a9mr13515477a12.32.1734439259961; Tue, 17 Dec 2024
 04:40:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217110731.2925254-1-make_ruc2021@163.com>
In-Reply-To: <20241217110731.2925254-1-make_ruc2021@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Dec 2024 13:40:49 +0100
Message-ID: <CANn89iJEE69y=Vi2c_2uE6k2Sb4bM+k+D+4KVfrR4QjMFK-7=A@mail.gmail.com>
Subject: Re: [PATCH v2] net: ethernet: fix NULL dereference in nixge_recv()
To: Ma Ke <make_ruc2021@163.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, u.kleine-koenig@baylibre.com, horms@kernel.org, 
	mdf@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 12:25=E2=80=AFPM Ma Ke <make_ruc2021@163.com> wrote=
:
>
> Due to the failure of allocating the variable 'priv' in
> netdev_priv(ndev), this could result in 'priv->rx_bd_v' not being set
> during the allocation process of netdev_priv(ndev), which could lead
> to a null pointer dereference.
>
> Move while() loop with 'priv->rx_bd_v' dereference after the check
> for its validity.
>
> Found by code review.
>
> Cc: stable@vger.kernel.org
> Fixes: 492caffa8a1a ("net: ethernet: nixge: Add support for National Inst=
ruments XGE netdev")
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
> Changes in v2:
> - modified the bug description as suggestions;
> - modified the patch as the code style suggested.

I really do not understand this patch.

if priv->rx_bd_v allocation failed, surely the device is not
operational, because nixge_hw_dma_bd_init() returns -ENOMEM

