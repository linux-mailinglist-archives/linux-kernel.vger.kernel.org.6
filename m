Return-Path: <linux-kernel+bounces-333719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF9597CCDB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46E0FB2199E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595961A0AF3;
	Thu, 19 Sep 2024 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyAJtX+y"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616E819E7F7;
	Thu, 19 Sep 2024 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726765537; cv=none; b=kYpIo12iQm3bkdjIMbNGkDPr1PXgVy8EMA12w6kZkrA1egzSCC6giPjA4ynUiAIpydNT+Ag9zTg+d2u2uYUKPzNU4ABvoq9jEvuQ89HFSAPlErD7m21Qo/b1adCdsLTF/cTTVjnMBJ+815sVeTvgZhhwQEgxKRbyOQuyKsDvGr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726765537; c=relaxed/simple;
	bh=tmjlpyB85Q6N1sg9vWiYUB6gK+1tvXPXJS8FFJH3dt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIgAHYOoZH+NOVJx8WoFFOhIty42dfQIo454O3KSPiGQIVMhndP8o/Wztp4Blao2maBMT8vQArYicRjsc5F8g0EVsqAfHORLR1mwDOYhmBKPIqqfSTiiUqwGy+HWaCjcHJtnRi9r8SeQB9v6dg+WIxs8NS2dvLD91azymVBdd2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyAJtX+y; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71970655611so984847b3a.0;
        Thu, 19 Sep 2024 10:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726765536; x=1727370336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mV1DknXCkvAZqjV+mRTTW74vVUQgKPm7zmZ+isecTs0=;
        b=JyAJtX+yhN6DVy7Ow5fRsXoxUvpW8M+B0lWLsYpwXNWcl1xVeh9kTfX3EwkQVKMYeo
         3TBAgSFH9BkXWoOzOjCffOeIrZS2wbqsb8l/AFxMuDyW+rNIj7YbbgBgGd2uMVLsOQm0
         uGiOMmw/oPiOqgdlKFO1ktQoUm3kO4FiDxeEKTxfrRynqRe1lQZnIUpq7iuNEbtgqfxg
         5anh+WPQ/y+4jJrW29p8uGMQXni1oyo/+rW7E6kWOeed9pPdPFEDTc0z/nOnQot05X5f
         RyP4vSozb1ItUapz5Tu/dwgjdC3IuPcQ1jmiHHNaORAVt0WwrbRNTkOIMUD+Hq/jLwek
         zXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726765536; x=1727370336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mV1DknXCkvAZqjV+mRTTW74vVUQgKPm7zmZ+isecTs0=;
        b=LiQorZMV2a4SlOC3lB6skt0eSn5Gym87yrTfKdng1vXjOKUBiuno1Pr9uHDuUk7iYW
         t6GuDUicQLXBF1xzqTRtF2zTE/mw/N+Qha+WB5xR7v3Fc/h4oz9X6AJB7jYc89faGIVj
         IWUzKVYz8EqmOg6F4as3M3XeN3DRnKezZwzC3q6t/+wuBBfegRJSF9w3bWN9t0BcJ4ti
         qhrzv7BQLxe8Jegc+LONim/fE9HwF1zm+sC4wzgIZrycvGQTgFXvNLZ6ZNIdDfy+vx3i
         8dMSzepXektpdRhpPkfN/+ig5RdZN8T0o09JASrq44ETNwSxD4Ly1uypZlb0GmqLzk35
         t2mw==
X-Forwarded-Encrypted: i=1; AJvYcCW4+l6NlKUOSwdHwDr5mSmWwbqFarXZFH9KMdPN6WiqgK1TrOFSU5SrRvR8M37O2mij68jd+mkCHj2p2A==@vger.kernel.org, AJvYcCXSiTnK8dmTSu933VUwOdG1KAwqEQN6EYBgQOWwq64Q/2U04RofagwleneYA6tOD6TjtJOOKEeTa4nuBTP/@vger.kernel.org
X-Gm-Message-State: AOJu0YzvB+/Z5dPphDjXJvCThRyrG+bY76wX/Rpj69ZXImTKNCk1glhn
	rPufJZiH7FZV005M/OsB0CUNsw0hpmyzrkJnFNbjJwEyKQMmnykI
X-Google-Smtp-Source: AGHT+IFO6rMn22DhE4EN11UfwN23Tc70d09Wnui03aC7YoZwemtfphARDtS9VnAnXRupCuJbsd20fQ==
X-Received: by 2002:a05:6a00:1906:b0:70d:2621:5808 with SMTP id d2e1a72fcca58-7192607fcb9mr40445550b3a.9.1726765535601;
        Thu, 19 Sep 2024 10:05:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a97e6fsm8498365b3a.26.2024.09.19.10.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 10:05:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 19 Sep 2024 10:05:32 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: jdelvare@suse.com, ythsu0511@gmail.com, u.kleine-koenig@pengutronix.de,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v2] hwmon: (pmbus/mpq8785) Convert comma to semicolon
Message-ID: <d58532e4-10e7-43f3-bced-90340a3cd7d0@roeck-us.net>
References: <20240919064939.3282-1-shenlichuan@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919064939.3282-1-shenlichuan@vivo.com>

On Thu, Sep 19, 2024 at 02:49:39PM +0800, Shen Lichuan wrote:
> To ensure code clarity and prevent potential errors, use ';' instead of
> ',' as a statement separator in the function mpq8785_identify.
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> ---

Applied.

Thanks,
Guenter

