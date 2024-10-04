Return-Path: <linux-kernel+bounces-351363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A571399100A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50ACC1F273E0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0465C231CBA;
	Fri,  4 Oct 2024 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5IbmUoK"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D737F231C91
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728071489; cv=none; b=HJ9kBU76Z226zLj5g0sB283XUbwONtsXy0VUl8Tv/1+OaFnTPY28tk+C8wiINnfkiy50BgvtRXBP15Wr3CtkgPtVpq5zKfjHDrQM19e8frKjOA6oY+RBQBzokrUKjYpWeVmNdjlG1JWlcVM/pvitOWHjztbZmVkfZ4xChfIzpfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728071489; c=relaxed/simple;
	bh=7KR/7GoMBymZDQCzfBPhQD+6VkyHQhFG5FZMeAYZPYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtVHdZGxSQ0nSS1ZCJXQFu9gTn4Do60Z56s4cHG5ZRGH8bZgjQkyqgzDTvFikOHDwLo3AhTnY1+k7j5PpMDGnq/a39zFE2SKXWeXkTbbi84suV02jCqEuj1QrY/Jww0z5+ynsrnE4OZloP0H8Kg1L/7WPc0T7jFmZA1y7ZeXS00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5IbmUoK; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d446adf6eso389242266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 12:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728071486; x=1728676286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UtwLUxMuGBoEZtFCzefxrU1o3PrTceG3MOpdppWQn+8=;
        b=Z5IbmUoK1BttcuMuyZoOXfKqhj8V/bWOdEhd5h57cylflLzSuAglL1/qBjCFhxRe0m
         aoZy628oAiDLcDLLauQ6byO3hEJAlAzH+ritp48QHylUGUau7G2B8/JXOU4w1IzS8P3T
         dWT0IjRQD+Jxk6DVdQaolt8jtigkD2rYMZasFcKxJaof8mZRLO81l7XM9sKm6AF0VlxU
         mY1h0Ns+Q6T7tcYaVlK5LYuT4EcvNE3fFszsXnBZ5IksxQce3yUIaSrLi910gfKyXJVm
         FK2YhdOGpXiXBPvDo9hTE/c/TXpmzqAcnEGxnTZZ5POoirkmuz1Mth57iWK7YW8Sb3xg
         WEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728071486; x=1728676286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtwLUxMuGBoEZtFCzefxrU1o3PrTceG3MOpdppWQn+8=;
        b=BNGPyo9yEvg99huPD93kzRjuPb+JAcZKmx64LI2QIBqKp6eALnvFr9PSC902j4zThs
         Hu0ysU5+OO7baymCaXf12B2ZuDbN09djAL5ttrDUMvbC4dgToWu82tBnW2r+TUfuegf5
         B8jwQCifoXfEsUTwHX9p2trUco7FKltE9VXVt15kgQsvXPGhXj79h2IYYx4b57I8T/2o
         W+cYH5MlIc2Uz9id5mrXSA2tHHgkRO77SQDOFEddNqXxPE8P7Kswc/2SnCJBY/pbKV7n
         onzxZScU0FEmQgIYRVohvGFlSb3BAEDNV0TU1D3EnjCSC74F/T/FoYsvYL1IdByxRIqU
         FxcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2Xw3lxceY08xUYvqb7MqoSAV6QxvnHCo229wEJqOnF7OYIvsUWbEAK10yaWk/sY963Z09rQ8Jv2mdz/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDmWGqkp8jgbIDDA9j934k1JV5Gtg6U52xK77Ikd1BO9csStEM
	XbCk6CK2nQC3fWtbUBwWGIz2UpzVBqR8sw1H6mXpKUsACKRt07zy
X-Google-Smtp-Source: AGHT+IFyzhbjt/f+t0FTkE5WXLqceQp16zOe/Y+dc+GNEjdNUWLgWCrBYVXpz5UIN212re2tlyClYg==
X-Received: by 2002:a17:907:971b:b0:a91:15dc:34e4 with SMTP id a640c23a62f3a-a991c051636mr405033666b.59.1728071485952;
        Fri, 04 Oct 2024 12:51:25 -0700 (PDT)
Received: from gmail.com ([45.250.247.85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7ecb52sm32772566b.217.2024.10.04.12.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 12:51:25 -0700 (PDT)
Date: Sat, 5 Oct 2024 01:21:20 +0530
From: Brahmajit <brahmajit.xyz@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] fs/qnx6: Fix building with GCC 15
Message-ID: <hcjto6ziie4vlzw3baotdzh6km54nggzihs6htfxgii5bkuhx4@iopcp2buiawh>
References: <vch6gmzqaeo22c7473qyabrfwxlkdhx5vgvosjyp5l2nwgqnxl@5x3ny35qyfgx>
 <20241004094921.615688-1-brahmajit.xyz@gmail.com>
 <20241004184440.GQ4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241004184440.GQ4017910@ZenIV>

On 04.10.2024 19:44, Al Viro wrote:
> LGTM, except that I'd probably make the commit message less warning-centric -
> something like
> ...
> would explain what was really going on - the point is not to make gcc STFU, it's
> to make the code more straightforward.  The warning is basically "it smells
> somewhat fishy around >here<, might be worth taking a look".  And yes, it turned
> out to be fishy; minimal "make it STFU" would be to strip those NULs from
> the initializers (i.e. just go for static char match_root[2][3] = {".", ".."}; -
> an array initializer is zero-padded if it's shorter than the array), but that
> wasn't the only, er, oddity in that code.

Thank you very much for the feedback, sending the patch with updates
commit shortly.

-- 
Regards,
listout

