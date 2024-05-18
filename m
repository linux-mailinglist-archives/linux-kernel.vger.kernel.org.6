Return-Path: <linux-kernel+bounces-182992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E098C92F9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 00:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25BD1F21478
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 22:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB486CDCA;
	Sat, 18 May 2024 22:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="NruATghG"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E0C50297
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 22:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716069760; cv=none; b=PYFe3N2oN/u27qMW9YTWMvpUYnYB8wGP/5xJ67fuvOroT2Me1LpaO4elemgsCp9LzOUqv3SQGsz6AHevcRULO2nfHCyXHfNycZ+r87wDfIKcHN8ge16YSv7Fl0R3A+761DDXHVmroQR7NnyAqvoHU2e+Xblu/Ik9X26uROU6Pmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716069760; c=relaxed/simple;
	bh=kedmeD4aX62R44RLOmYiPNNusWIBA/LEAOhBmBHsFjM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kB7VATpzoFIsGyZQ3xqIXFzSU2tA7H4Rm4xOc+RnZuIUflcL+6A4XXxIJo1x2uaNHE+7/BDaE5rqP75HM2nW6aQ6BKSHJJvzUcMHeQkqyQ5wNWAcBUoIw/IKl6OkGcMArcJ4Le5E+jjh417k1+948a1nXuvGnK3h5Gjut2TH9us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=NruATghG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ecd3867556so46074075ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 15:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716069758; x=1716674558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Dt6GgNMEhbMDY/9MX5M405N11rz/0+cbz8H78AH/cw=;
        b=NruATghGFQbITZDGgzuej6HUw6uMlu0LxeMQ3JLPZ/P+JXOKw0TUsa2STiPeAuzSDn
         rC5NOnEA+rj+4LHwN7PSwaN42vIqBCjOGBwKvJniyO+q77UDBuMIYywRZqU2oc0TmAoJ
         trZGhiHt9SM2FykYrmB+ops+J/+GXBz8qq4feORFsKOeJOfr6TUO5sHvhHtehtEWNEt3
         8Car+N6VtrsqnXDShoza1aE/FGV5dTbs9tOp0UJGhZaM0dk+a6sdp+6A6zKs8x5IC2ku
         Qik1XGmE6OiKBgSRZjBBiwHsTdaXbRcbD9OahbZHPCansoFTFBqoxnPDftc3RxdTpDwg
         gP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716069758; x=1716674558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Dt6GgNMEhbMDY/9MX5M405N11rz/0+cbz8H78AH/cw=;
        b=MgrP3/clnaSinAuOFSszPXNN69/C9bq0sTE3TwVXXutvhqg7JgOZICvIVKrtwasj8I
         ZDSkRrz1H6ksmrgHZG85GSJzRnOKp5lGn22B6r7bU3Pr2EiUlWx8rmNelsJWMG3WMFHH
         xG78M1D5c6QkuVfZfwT6zQpn9hrgKCkaGYbuOyl4qSVOI6Bwf+WVlxXTj+PFLriQds9z
         e3paax+SAxskWygOoGME92iCI4ihphadwnS9NdQm4hP1RUFLFn8ZVdZrXc4Z+8ZQGink
         34K/rk2rC6CRrPjrM6JqMyJ9rFXxaJXdOS8LkXlppBuFGVDa3v9V/pLAyqfeaz6evYwN
         GPEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvTgpMPNW/AWNj33SocztkCx8d+D9NhEQlXJAcBjm9OkiWiXJyr0gr+PKu13v0f8ccVW2TWczn6vsPY3InYyvWWWYijFoP0G9dqgVz
X-Gm-Message-State: AOJu0YxNUm19UoGin61yDBooxuOInYkEOlRioMLGpP9Gt5s+g9ut3auC
	GG89RTVbYBQUenu+yCALg+3H5RBgEzMC7NcFcxC2oh8HpaIL9G4BYeUbY8HpPMidKFxw5xFeCK7
	9
X-Google-Smtp-Source: AGHT+IEhdDfAdlW5zWrQVXUMQoQD3CaQAI159xoqyK3WPc5KCs5rHttXSJJg3iNZAXw+s5U/dsRbEA==
X-Received: by 2002:a05:6a00:9285:b0:6e6:98bf:7b62 with SMTP id d2e1a72fcca58-6f4e02ac4cdmr30838143b3a.8.1716069757595;
        Sat, 18 May 2024 15:02:37 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f6805cbe76sm5283629b3a.43.2024.05.18.15.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 15:02:36 -0700 (PDT)
From: "<Tree Davies" <tdavies@darkphysics.net>
X-Google-Original-From: "<Tree Davies" <tdavies@gmail.com>
Date: Sat, 18 May 2024 15:02:34 -0700
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com, anjan@momi.ca,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/31] Staging: rtl8192e: Rename variable ChkLength
Message-ID: <Zkklei8JM4zz37xP@lunchbox.darkphysics>
References: <20240515045228.35928-1-tdavies@darkphysics.net>
 <20240515045228.35928-20-tdavies@darkphysics.net>
 <2624273f-3589-435f-8bc0-8ae6514916b4@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2624273f-3589-435f-8bc0-8ae6514916b4@suswa.mountain>

On Wed, May 15, 2024 at 12:31:20PM +0200, Dan Carpenter wrote:
> On Tue, May 14, 2024 at 09:52:16PM -0700, Tree Davies wrote:
> > Rename variable ChkLength to chk_length
> > to fix checkpatch warning Avoid CamelCase.
> > 
> 
> Just use llc_directly and delete ChkLength variable.
> 
> regards,
> dan carpenter
> 

Thanks Dan, I will send a v2.
~Tree
 

