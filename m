Return-Path: <linux-kernel+bounces-540469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E0CA4B104
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 11:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E832168366
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 10:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13661DE2BF;
	Sun,  2 Mar 2025 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R6N7zKvZ"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7950A1D5143
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740912925; cv=none; b=G3ccKuhDZMI9RGy/27UyoKigHy10WGan6YVjJdyNrj6RjIdmDlc25u3DnJep8LXTR4Rxqp2ZhEHupU7KutpyqL9S4q+ToSJaRHdv7BtWeFPS9wndfCTZleUrcNMikBTEkARUdEsi3bftdfC9F0NjSMS9ym6X7iR5cHStFk5Nfy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740912925; c=relaxed/simple;
	bh=YP9vFesE7FOkWTsjQeuOzqlZhTxpNdth3TwzKIctpts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBGtFXpqpcH2BM+JOc/143GBMDMikPbSFSs4d/CPyyhRf89XT2OuvmnYzg3kVxgNxH2ejRb576JATyb0O4rnN/yxY3YiK0x/jW5Ara96X+r9oEHkmeXI7wVTjo5NWZb6aNQ+41QJDANv4CYlUlI5doN8HRe5Xm8rdhmjeexYp2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R6N7zKvZ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e4c0c12bccso6265851a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 02:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740912922; x=1741517722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yVNL0sPyTN/JB4JKueVcudW2dTNqPhTdzuxyAD7JqBI=;
        b=R6N7zKvZlE4/rgMWk99r/RYVwzFGfaGvUj77eiGcWjZoOzFAuueP2cfE5xY1IG7z0R
         gYlZJS/HNggi0AxfmCxDIZ3yGHszRp/hCiQiqYNTL8GqLOOADzP9MI95+8dqUJphUuzO
         wHEAoxz8IVEHv/MCzXNdqsDagD+yYlfKjfHzGSZ3o8TcPdIzscqzmJKssuVt/xO7mC7J
         qUAWz+BvqMiQuaM1tTag/JcOmTrX1ZEkSjoweaQ+BGW/mOwVMrDWbxAjsQzj7ePn64t4
         6oTfZqh4hiy5e79XN5QQJmQsX0a6Xc5yu1Ae05zzvx7CzEzDAJ5O4HqBsHsXAQpfLhI9
         lv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740912922; x=1741517722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVNL0sPyTN/JB4JKueVcudW2dTNqPhTdzuxyAD7JqBI=;
        b=mmDWt0bcRJ0Xc+CSqg4LfKcN5+jGRNtqSPWkuVmcZ8ElKA8ISPG2mYXPE30TMz/bTq
         DO/r3K2Naoc50d3YXH3OklEuQt6BatfXCzNfy8/ZjApHDnbjHfsUN5Y3VrJdvEIzsxGI
         y6NsGLW/QwLx6vofni6NfUT947yhf2+OhoDFvh/Etpoh7al0busjKUjqMSEBcKDAN+V2
         3sAQNcNqBP267BA7ni0zryEcxnYLCck2TIzeIpjBfVQDoWnb3M1sFOKPbiI08T+cZX93
         oY/Q/rzhzY1DNxgscmGRvAKnyRvN0zzlgLRZ8saCD78GoH2279y6SafuRMZcoSoLeT9R
         DY4g==
X-Gm-Message-State: AOJu0YxAJFt0vsn6mk12ZeTkTIoy9DWnzxbGORv74YcPH6bIUZLYK2AU
	sEA0jlLJBkCugBFd/WQEb+OZQC9Xs+Tecs68h1DCZhmoJMBt0czEHgUt3m4meh0=
X-Gm-Gg: ASbGncuhAXOVFB780JqeWwTH619fECx66TrT4EMQvAqEmle3PLoQWjTpLBABU1Hg6aa
	nRYu0n7bio/E+Ffao5dunU3AbyPJ3mgUmeOgGa2PzUbINHbhcKXWArPSgRrWZxnLnlCWb40S2z6
	27zGiijThEAFjRDauDEPzyW97jrXgac71Ky3x52cW/7l1Qpar1wuVzzgWJcvoj4MSe1PI9aV3am
	WTn8IO1j5kMLcpi7swSRraSIp++KS24YUcQGQsOXWXGjQqbFPpfVdBRgiofkwOumn0I+mktV55o
	C3zEVKDkc4DXViu0zPaGN2vfB3Zy5VP5KjdaLu/KTYRVg8AtbA==
X-Google-Smtp-Source: AGHT+IF5u6hOznuueVO45DvOr3tnpJV+3iyHP7nKiHIBEz75iKNJU9mKeQvZWjwJzKMqMC7qM6j60Q==
X-Received: by 2002:a05:6402:3512:b0:5e4:d13b:e65 with SMTP id 4fb4d7f45d1cf-5e4d6af15damr10563438a12.9.1740912921716;
        Sun, 02 Mar 2025 02:55:21 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5e4c3b4aa46sm5309846a12.1.2025.03.02.02.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 02:55:21 -0800 (PST)
Date: Sun, 2 Mar 2025 13:55:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-staging@lists.linux.dev, asahi@lists.linux.dev
Subject: Re: [RFC] apfs: thoughts on upstreaming an out-of-tree module
Message-ID: <b9c2ce02-dab6-4b4d-b8ca-ac1e7769e0c3@stanley.mountain>
References: <rxefeexzo2lol3qph7xo5tgnykp5c6wcepqewrze6cqfk22leu@wwkiu7yzkpvp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rxefeexzo2lol3qph7xo5tgnykp5c6wcepqewrze6cqfk22leu@wwkiu7yzkpvp>

If you're going to do a major re-work it might be easier to do that first
before you upstream it.  Once it's in the kernel then you have to follow
all the rules like breaking your commits up into reviewable patches and
not breaking git bisect.  The rules are good for quality control but they
can be burdensome for people who want to move fast and break things.

regards,
dan carpenter


