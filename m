Return-Path: <linux-kernel+bounces-510622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0895A31FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8533A9688
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7296E1FF1BD;
	Wed, 12 Feb 2025 07:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a8ruAj6j"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225621E9B04
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739344075; cv=none; b=eLkBj92g+AFBj6wiXZwD5DPrb9k9OfW5LrbJMyGYFArdQ6/baNFwhvOGOC2/mNAFO9+ivpS13AiPZoEy6yQPwTOw/GtHvywO5x555br6TjiTUL55LXatHiJI7sqwo+VaA6dT/bxdojbPCYrK1KKU4S9Nb620LnWY2ZNpzjefe78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739344075; c=relaxed/simple;
	bh=dkRYyiNHgbX4E6o4jZE7sY+B/pqUL1x5kYNpWL116yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dulcd45AgfhDe/s2R9YXC+PlLU2vwtgxM17X62FYlxK7JtToqBA8qdLePNlgjHix6Zv1p7dEa00Gf+8t4PKpz/rS15Sh36d9iRIxoP5h9vUShC6neEvwMHbfA+ht8JJSHxBNnv5CncyOqYIKVnzBLJMsboH8bd/INjHWPe3oJxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a8ruAj6j; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5de6c70832bso902781a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 23:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739344072; x=1739948872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6vdw5JAh/EXyOI+v6B5L7CVRs51CFfVUUaX686Jwf6M=;
        b=a8ruAj6j7FJiSUxzkN6nLPeNKhgCK0TaP45ErnmMdvmKuEu3v5mM3rQgKo0HyRIEwQ
         u9EeanOfFY9abj8tEaonvc3Ba6ND4nupSr3zx0PSLud+6n8Ri3EWf1szYhGxUx/iqZyU
         FQpPzSUMZ4lYQgrgfL7s7DwA/pi4Bti7hjJGArebNhqyZ9EDl6pkhv2+1LIy7VQTWoLY
         pMLysa9mVxK5eHDcAhQbiWQEhPXn0bsHXgTU2edn0m02/yFjjnVBePhm8hWgOoeHscgr
         9EmS20RroJm+Bj758cCOv/nStXv2Rvqhk4JRquhJtMJu2jmDx5gwy7RcvBW4B/wd3d0p
         OdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739344072; x=1739948872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vdw5JAh/EXyOI+v6B5L7CVRs51CFfVUUaX686Jwf6M=;
        b=S4+EzveOAd6+SdH6QzskExoVRCpV/XCWWvCRLO9yyv81MnXn1DecGJ+EqeXy7Wj24r
         XB0ypQZ/fY03TGegL0/iwIFSTnWVSkXJ/41LgRPrFC09L7xeAFtUdNfj4GFwclE423XA
         clKxFoXp8kK9YtsUS6EXOLveg26Ul/4vh+n/2R/NHKo78F6Sf1gvY+jkxs+OplD7dPJf
         2wLvCm1W7x4Tp3Ft/4Qg23tJ+6t0SIopYXYHJS5n8cJ2R+eUhRuQRaF1HTNtn2ZF8qsZ
         ydNqHl+9ttW4g8Yyj5s1/bDGGC7MRQBgp5aUAOozafUYsnghZ+wEzS8QiCfRMCCTAXhZ
         ttWg==
X-Forwarded-Encrypted: i=1; AJvYcCVoBdHR9+tjeKbJ6kODjLQ3N576fyv+AwdKz5i3m3mLKTEWpvm5cD4xyaV9ZRuspXeVGdM6rtATyeSq9jI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySYXEgK7TvaU6sDmxLVyFoYiKnsiVa/JPoAPu3t+tTdKOPZDwm
	jNJg2R4wDr8vl9xfZzjkESnxYhh96oX2iE4qikt1EkzkvQTRAcCrjxouTxcCKNs=
X-Gm-Gg: ASbGncsIJcmmU1kTiad6VOCbOrTg/+y1l8FafTcJOP9pGcavUgwYj65HdflDqMtL9Rq
	6EVvFAxI8OQNx5YzAO67UPh+7wVIKcd/+y9jeV33JvxxEaNEovQFd05ebtuGJIWl4iWVM3cubKI
	Th8FG50eCZF0kov0S+CrzjsE8wlx9V8iJaN5tF63L5Cwg7XRcivEim0xVgh83qeSLQuXyY/aIXW
	EBmm1FSQiN4MO5YBjyv1UXt8egxDhjUSMH4F5QpRmBAROQC3AJD2q2AKJhyLuDeKKe+zmy/RZFq
	KqPjg1TeGiQpSVsoEZFk
X-Google-Smtp-Source: AGHT+IFgfEsk45w4BbHfHihrHNRv5cyQh7wnujELnD449C9j+IMucFgzuOEVQz03tIYly8IZgxS/Wg==
X-Received: by 2002:a05:6402:3481:b0:5de:5e08:babd with SMTP id 4fb4d7f45d1cf-5de9b9b7230mr5460876a12.11.1739344072391;
        Tue, 11 Feb 2025 23:07:52 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5de6d3c6785sm6421368a12.55.2025.02.11.23.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 23:07:52 -0800 (PST)
Date: Wed, 12 Feb 2025 10:07:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: gregkh@linuxfoundation.org, dpenkler@gmail.com,
	~lkcamp/patches@lists.sr.ht, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: gpib: fix style at nec7210_t1_delay
 definition
Message-ID: <a8da3395-e383-48d2-8c1e-fa70874ad551@stanley.mountain>
References: <20250212024247.176572-1-rodrigo.gobbi.7@gmail.com>
 <20250212024247.176572-3-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212024247.176572-3-rodrigo.gobbi.7@gmail.com>

On Tue, Feb 11, 2025 at 11:35:37PM -0300, Rodrigo Gobbi wrote:
> due a change of the return type of t1_delay function, checkpatch
> was triggering a style error.
> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>

This should be folded into the previous patch.  Generally we avoid
introducing checkpatch warnings and then fixing them later.  Sometimes
that ignoring checkpatch and then fixing it later can make the review
easier if a patch is really massive but this change is only medium sized.

regards,
dan carpenter



