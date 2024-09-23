Return-Path: <linux-kernel+bounces-333989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 167A497D115
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D679B21854
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 06:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EE53D0D5;
	Fri, 20 Sep 2024 06:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LTh7HeZW"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CC1B644
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 06:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726813279; cv=none; b=oiO8a6sP5ITXh3/xs1rUlRvCaeICT5yc35Uwxu4kylXvb9ZVJx0sE6WfNK5G62z+SNxDxmBSO/neP2ehNIr5DGC63qYtt62rfW+Eje8hVdcClNyVkKH+GPwXKgu+zvjUyVk7sXgwE7VPdWLUAP/y1deNymMVWJfj4hmLvkz1pD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726813279; c=relaxed/simple;
	bh=x/8tp2rG2IGjz3caKUOsHBf1tU+8jqDcVYS/WbSU3e0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tN0dCaP5srv4Lqus+Oeh9gPS82Gqa9z5hQkiQkasJ0NidNC5Kw3EPw09hdMy77aRO6TS9vWlnhsK6h9CR/IDvD9NPj96jvnnZZTHz+CAt6JU5zc6xtj9UH3H/3Qo2XxL97vVyOhnWzgcs9m1A4vLgopK5ztachMZhsfpz6NiSnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LTh7HeZW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso13171745e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 23:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726813275; x=1727418075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxTie3o+2ZAtDp1PjLR/OoHHfq8L/seIGfduFy59TX0=;
        b=LTh7HeZWtIGXVPt0Mrt7EWelvIshHb7hBcYxtTAUhn4Sj7UmbIZRR0+VpT5vyuhSFp
         wk/ek9hrcI+uLCRI0E6uaghUwmQlWIUytkyKWWU/2Kt1ezc0TOuMYuMjVTd9GSW245qI
         ho6r/tYolGjcyWfNCFeo5JDLBGBTMXx1Mi0SLT2xKWUU26hqw9I/iXwlC6ksRGWhi7yF
         JP5GD5a1uA7Sx7C4ygBxEyK/RLPYeR7l12ZJ15yzcH4MR4tijiiEnRM18WrnssYXWial
         /vhpHWKOdMivuTUuZ7UMIe/fXDMsBBNxjeW55QSUMvGTwBNb6Jl60IireAG7/wZC2/mR
         9Yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726813275; x=1727418075;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxTie3o+2ZAtDp1PjLR/OoHHfq8L/seIGfduFy59TX0=;
        b=MauONvFAJEALwI2QEOshRXTaQQ2uyySbrHpDxvpco15oLf3OmFGdqCaHZB+QivBeep
         mDHFVeVeF8Wcrq4GCCqt6lK21vUUdAigIVAG/hYP0t2v7+ARhVOnYjJnxbfghYkp7aj7
         Ju/Z3iNVyFfJvPAfpxbPsVtuZmPLOqrmB7efXknkDKzxTpHyIo3L2ioxXwVJisLvRNLr
         gKWJPpHsYY+U2ydm9+AoCi7uDUHsgXOr2JPwmuxujn1zF5fNQxnOaphxjzKgr063RRz2
         AlYpSmKXAtGXEh/3k1QLWuia6FoDSmDaynoF2IjRz/7j07CP3bjl3ADo8PZj/eMFD7KI
         NEiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8VBVG5Dbci1QTWuZYO/cIRUYPNLWm4iiKlMeskXsdXpGz/h0kVGqFZhca276UWBh4D3HAhfYji1t3kaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjlqowkO6mAMHRCl4NIBzpdh3EwKUh5EaUVweZ3kkwZvEA8bTu
	qJaklaZfwcmEhQMK4lmy6amf+5gHYlFKwQNP4CCGGkzYS8jk/A4+RSA5hTOZOIk=
X-Google-Smtp-Source: AGHT+IFDk27Z4fay6biiUFNe4AdHuKGgvRLIgi2So8WsIf4hjeHOC33tIt9lsKDztH0eS5Ca8llS8Q==
X-Received: by 2002:a05:600c:511e:b0:429:dc88:7e65 with SMTP id 5b1f17b1804b1-42e7c1669f1mr5983665e9.12.1726813274678;
        Thu, 19 Sep 2024 23:21:14 -0700 (PDT)
Received: from [127.0.0.1] ([185.44.53.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75450ec6sm39780565e9.21.2024.09.19.23.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 23:21:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, linux@treblig.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240920004817.676216-1-linux@treblig.org>
References: <20240920004817.676216-1-linux@treblig.org>
Subject: Re: [PATCH] block: Remove unused blk_limits_io_{min,opt}
Message-Id: <172681327241.42824.15179757360545790108.b4-ty@kernel.dk>
Date: Fri, 20 Sep 2024 00:21:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2-dev-648c7


On Fri, 20 Sep 2024 01:48:17 +0100, linux@treblig.org wrote:
> blk_limits_io_min and blk_limits_io_opt are unused since the
> recent commit
>   0a94a469a4f0 ("dm: stop using blk_limits_io_{min,opt}")
> 
> Remove them.
> 
> 
> [...]

Applied, thanks!

[1/1] block: Remove unused blk_limits_io_{min,opt}
      commit: 9ba5dcc722de4390a1d3211b2ee3c864f84f5461

Best regards,
-- 
Jens Axboe




