Return-Path: <linux-kernel+bounces-210938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C154E904AB0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0092821C6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55243716D;
	Wed, 12 Jun 2024 05:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nZp2VxYI"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF3E33FE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 05:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718169328; cv=none; b=jCNXijYcjj/uXAktG41pNWMTkpx/3q4lOZkV8RM6KrbY2YW6k8gdENOZke7oEcnD2pzre45mTcaNHwR+42mONAMIW9hFGwPXcVaCgSq9TV2k6gQys9Bo1cO4bAPhHyIqJnULh81KsYy77VyTuGGmN4yZzJcF1+BaYoM9vPg38eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718169328; c=relaxed/simple;
	bh=J2OeQjaH4mI9m0kePz8+0552aToqUmZdlzTjOeX4qOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9gry9txIqQZGYT/fYwRoYShADUGkYUN4QEXG1MPIcnHrP1XfNdhdu/w1cUEzvuvR1/oCti5ZvndZOeKf9E4bkkY48SBG5dXatwlTcYqfhNe1f/q49wBhZnJthIQfYYYmRYApH8ynGGctIvctIpLcktRNCC8oMeyRkzhOju+lRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nZp2VxYI; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42189d3c7efso30742595e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 22:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718169325; x=1718774125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1jHnLs3tlSqmjoWiOcApOLhuBytH4bw7h4RnPZ1Abz0=;
        b=nZp2VxYIXYhx7sjgAxMcSHdNUKiTt1jPmZFkhehG5TMLyOrvIItiS5ms0rLmQUkoPz
         VjjjY81Oj6dDAF1pNyYNlZQVTpBjQ1hGXFhncsgvm4vwX5l19vBsCucZjmJ/s59ffYpC
         d5pXqCM5+bkKILYNPYB3iGrvfWX0Mdi9GaDBweQQ+VJ1vdTSJ8u2CNW771ExOVbdDAfY
         C5yPu31FkFiP3iSkaQK1BUAQQZjWCNKcqE9yDqbEBIQojGgrf4S2AI4E+wal/PkiNQAF
         iqMTcUp6DbanQfixP+yl54Cfd8ozX6l00w7obtQ8ErxlEiS/DMRT1pcv5uPOrQsNY2vH
         z12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718169325; x=1718774125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jHnLs3tlSqmjoWiOcApOLhuBytH4bw7h4RnPZ1Abz0=;
        b=FyS41Dssptljy4tTq2ovJbZnlOxOq42YjKOUdC0D3b+21B8FujsmSSV3/8WtzCgbzE
         f2Z2WxnmMqiSUuFAx3HncfBwuuo+Wyr82QnXUMCOLcuaWjivG/VlbPKJLSb43YaeAd12
         I9Bx3cjT7A2VQY1RjjgeJKTWv54WnNQZg6WFzTiWE/wP2F04SDxG//hKeLKX7DpNPXtK
         8Hi12zF950xyKU+JQ4bohu+tKUzZpXXr/4TbD8KrwvlCgbcSoEOOl5e8iMzMav4pRf1V
         052UjrCswxDuAjws/3t8UK5T1K+ZOCBgdb+gwSsiVgOoJkXzuY8tgMW6sQNbKVG/OLIe
         ItPw==
X-Forwarded-Encrypted: i=1; AJvYcCVhBxeJd2fVPJW3tjhpzsjsbVSHJ8/SwqVQY4lERy3tKCqY3n7x8b71osUZVCygGMXiYjWjFKjQr9Yca7vviPNLan7XyWmcVN6FP4tN
X-Gm-Message-State: AOJu0YxScKuXCurVMmNkr2PyuEAsO7zjIBl0Xwiazb3LfPOWXfGFoQz0
	x/2eqt4k+EFm3MaknJRyHLma1+5gssDSoYI7v1Su5WdudYbOgfauRyGIjh3dd9U=
X-Google-Smtp-Source: AGHT+IGlIFJM3AqkgXoGMTmfk4udTWHaHCwWFLjaUlCR/Gyt/GPa3LkXWgqJAZgegqJt3xVRHjFWyg==
X-Received: by 2002:a05:600c:314d:b0:421:7c1e:5d5d with SMTP id 5b1f17b1804b1-422867bf846mr9874815e9.35.1718169324472;
        Tue, 11 Jun 2024 22:15:24 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e71dcsm10374195e9.44.2024.06.11.22.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 22:15:24 -0700 (PDT)
Date: Wed, 12 Jun 2024 08:15:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] bitops: Add a comment explaining the double underscore
 macros
Message-ID: <df85a7c0-714d-4cdf-ad18-63bca4f75d9b@moroto.mountain>
References: <5a970f32-25c0-4955-b480-a4738bf86153@kili.mountain>
 <Zmi2oUOjh5elr57T@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmi2oUOjh5elr57T@yury-ThinkPad>

On Tue, Jun 11, 2024 at 01:42:09PM -0700, Yury Norov wrote:
> 
> Applied in bitmap-for-next. For the next time please make the subject
> prefix [PATCH v2], then [PATCH v3], and so on. The motivation is to
> avoid sending emails with identical subjects as some (not mine) email
> clients consider one as a reply to another.

Oops.  Sorry.  I meant to do it that way, but I messed up.  Thanks!

regards,
dan carpenter



