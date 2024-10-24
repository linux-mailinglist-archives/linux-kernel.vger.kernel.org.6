Return-Path: <linux-kernel+bounces-380404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E603F9AEDF7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 232271C2358B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90D91FF047;
	Thu, 24 Oct 2024 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6ydm/pp"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05471F9EB5
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790790; cv=none; b=UZ7AbbQyyVDNikoXnQi3qwJwJRQN1nevD1KF+KmpQDHxYTOzWdCwhYHJL7rYuutjaFyH9r1/gOXcVKBRvcZJxKML//Q8LMRJiJAcZB4zMGaHvyyZAKkWuzDTqhs11PJqST1ejC8qDKlYzqgkDUt3VBcPE2mcPP9rOXFF9/wONKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790790; c=relaxed/simple;
	bh=EPzTvnU4xHLM40+oyhbnYLNY+07QYM7NvmVvPKivS9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJwH4ULuP6nHoXTxFgXbo6E+h/6PeYz0CPnIZ7JkI1MJnMBH3FO40Tw2Jiz9b28q/TaEBavCZjj+RJ6V7r4r3NDisnID7hYkZbq2XyNP9x1274V0ya0l4jhSU9mTJotqkclRiQnfc1YlB+4E76ZhUB9RVansz7We96+8JU4YIRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6ydm/pp; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2b720a0bbso222336a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729790787; x=1730395587; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3r6uYQsKW+wrttlzZz4ZLHuXyEQGUBCkXu2O1o3CZjA=;
        b=K6ydm/ppXNvYBGDhR740anevG2dtKEfyL+KyP9OngwcC5uzvO8ot+v594wHp0aN61Z
         0FIoPMmEYsoDcfw16Syyx2nh0uijnSIgYB1AaK6LEY3/U0RWhtxPAZW44j05lu2FQQiH
         aShi5MSi1/WWDEMOvzwTMauqOUnGfz36Yqdvdaq8nbEQDcYXGHAqT69PMSDkF3/2hMMz
         amMOEhn0sOrTTrNixqLep94/41jfNSvQniZoRR9cqIRZuj9fAQCCU91IgMI2rDhONHTH
         ogFMitKh2cGVV0Q8pluOgHVe0Bq2MaforaqQtw7hYPhwo9Qz+mG6JHM0ZVFFZipCmP7q
         CD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729790787; x=1730395587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3r6uYQsKW+wrttlzZz4ZLHuXyEQGUBCkXu2O1o3CZjA=;
        b=XtHxmKZX6i1qirr9com4SBinjipOxQK9mzr09d12S9hfSt4O/At/MSe9vuGMIODMDj
         oRnz9saHlPA2y3ybvr7FnjiGuJzv1Z+UEK6m12muI5iiIbnGMvQyZYD5f2pK8LFIWNKY
         tpRVqy87dBTbxdlS4LT3VfbyG0HiMea79qJEG5fwlkl65ruwXq4XHt8mYtAvD+o3djcy
         pl0nariF9wzzciHBA/hhZbSHwyDyYgDnAUa/U2LsXnKDAk7U92i2J08AAI/JAWbFj2No
         VKYHXxg3YYHWm+A0uxOCTIQ/2Yo49W08cBWUX1l8L26zQ0cHJLvkL/4a0W9Jo6H8cWmV
         NGZg==
X-Forwarded-Encrypted: i=1; AJvYcCUUDS4JpDSWBNKiaw2UTvhW0M3/1Mjb1O1Iyp5MHxm/872tHqqeHjiBMQa1lCSWURtF6n3df39OMCEM+U4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Bxfox7Vv9We5vStt+MzcYGWe+uPK0QmsMdoUHFK6aCxXs2A0
	loy50L4FD0al7eqUV8XnDtTIft8K1aSsBcpMhQZiB1vSkQF1Zmq5TZduGPCupAo0e1fH+pTJNJB
	RnfxWe0as5frmKk7dN6nd+2gixPA=
X-Google-Smtp-Source: AGHT+IFKzyv2aozK8Hg6KjGyJj8AWgDiS/1WdwJMeOpimVh/bhQbmbdjeJAisdQPnL/vKGpjga2mkkfH0alrzAfqpDs=
X-Received: by 2002:a17:90a:ac18:b0:2e2:cd5e:b25 with SMTP id
 98e67ed59e1d1-2e76b6fb4bbmr3305188a91.6.1729790786984; Thu, 24 Oct 2024
 10:26:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024032637.34286-1-quake.wang@gmail.com> <20241024164939.GL3204734@mit.edu>
In-Reply-To: <20241024164939.GL3204734@mit.edu>
From: =?UTF-8?Q?Dragan_Milivojevi=C4=87?= <d.milivojevic@gmail.com>
Date: Thu, 24 Oct 2024 19:26:15 +0200
Message-ID: <CALtW_ahBpQkwCqeh0QdYwU+SozXnsDHYd_f-0MnJNHq+7nvDAA@mail.gmail.com>
Subject: Re: [PATCH] Remove Huawei
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: quake <quake.wang@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> different sanctioned entities.  I will note that China is not
> currently attacking Taiwan militarily at the moment, while Russian
> misiles and drones, some of which might be using embedded Linux
> controllers, *are* actively attacking another country even as we
> speak.  So it might not be surprising that the rules might be
> different for different sanctioned entities.

I wonder if Israeli missiles and drones are using Linux?

