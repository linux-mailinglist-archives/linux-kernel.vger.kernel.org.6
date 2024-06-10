Return-Path: <linux-kernel+bounces-208536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A2A902662
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D015F1F210EC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36D4142E92;
	Mon, 10 Jun 2024 16:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVGkbVAE"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B7F1422DF;
	Mon, 10 Jun 2024 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718036054; cv=none; b=XVs6U2YiQhhXtQ3B4/tcwyRs3tmS6JeznhWAfUDdB/mzdaB52Gtoty2LQnbYsr1qXFiq0rx/2yCvqRmD3DJTW9hy8BFc2eCnCDfuFr2lhoxLdI1uxqqVpov7jYcP0BX+A4vBFDdqNH96+FLwG9QBRYzjpJ5NnhRUNzrKSvTGo+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718036054; c=relaxed/simple;
	bh=Cv+JJagk8BLmUV+fkuMujuu0FTmj3/rZ+QR3a9hd414=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmYiuUKoT9qTf5E/kNwIIoD693Mxgf7kbQPBYPN4CSGjMlIeAjlsldApTcDAMAw7+YALNV7BYjoeoOLocN43wZkIQcIh4DKWyRwGi3b9mtggenXbysukCM9ET9uCZ4/+VNDbyJ6dv44HDoKtL9Zkri7EuwTqPZJC7HpHdAoqXC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVGkbVAE; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70417a6c328so2351463b3a.1;
        Mon, 10 Jun 2024 09:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718036052; x=1718640852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1oeEDqmlJTD/HOHIYKYMG5NS4C/DrQ4penjrma+dFXM=;
        b=kVGkbVAEgMUou1eSniTESWIsdaLbxq7m4IqnRFr/+c3iCSIvuCDsinfG3a8kTJP0GS
         aksGysqaCs3ilTQ4Cg02IuoG6IUdUtYk3xVVemQqknRWjt0cQe+Dd8ZvWx1nY68Ic4Xl
         e32XOIoxpZHb8p0qtMMemalnAo1M01GLh23UdaOvtM4bt1nserAzzKj3uNm/ZbE+ImZy
         cUdDbVuqxH/+Inv/vCJkDpcSBWUOdcDWWOhpt3IE1sB0M/cgTn0Lyld17VVVe+nboPy7
         wq7nJgLIQAafXdD1cRrafEQnE+cnv+8oXMPcYNA4cd4mqMUGT3XE9R61HGl40vgGdp+R
         kC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718036052; x=1718640852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oeEDqmlJTD/HOHIYKYMG5NS4C/DrQ4penjrma+dFXM=;
        b=sZs4p0h1/U27rRfXNOkvPTjgBYYrK0uClEPj1pSCxlaPTo4BZMfYwtAR5G6fcoqJl8
         PFhYDNZvlvwDhnE5NPjMUYnveughs0bz+j6V19LBVQ06rgy6/cVbROEgrmhq6ykO5nFo
         QYvUE/8HR7T8/3A2SvsZY1IytNMEOG2cGxfC7bNNqo4NYZxXfcTyYixk0f5wQ5Is44RF
         Rr4zAQQJsYZj5KiRxDE3uAVx+yvULVkvf3I7YD79FfGFkhUPdGxagEARVAf2hASBjJ0r
         YtLN5XOmVJ+1H69Dwm8izQ7tCh7Q3RfKY4DPig8IS5qT3NeLX3BZlIothNsNz4GHHdp9
         MI9w==
X-Forwarded-Encrypted: i=1; AJvYcCVPo7Vz+jwLE36mbasNG0Q0l98HDdbFxP6phVWFNQQ1DNlBqmrfBeyPIN+mHiz80idZS6jNJYmxkwi6QnJ4D09LIHp2NHH/0VvDdbvidSqoP8mXOEfGLufAS61N1SBEibfXfXqH+IK1GZEWwL4nVHtGovxhmaqpBLvcxsRT5rbsI5MWNWM=
X-Gm-Message-State: AOJu0YyX+fNVjCD/W5/CH9vk/uZ2jn6oCqMGZ34+bPoeci5HUCie13pr
	pXAWYjhpTT4VnBHEvCgCHvSPSOKLKM+Dy7QjV/x5gXIZcP188aPF
X-Google-Smtp-Source: AGHT+IHsMUgQJcMlOw1LQHAhZ+1tTR1Kwn40VUlP7lleA0ViudEaUcDg7HydAcNiZk6izgTL5yKDZQ==
X-Received: by 2002:a05:6a00:3d10:b0:704:1c78:4f8a with SMTP id d2e1a72fcca58-7041c785413mr7941921b3a.21.1718036052173;
        Mon, 10 Jun 2024 09:14:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70432db7698sm2911920b3a.22.2024.06.10.09.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 09:14:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 10 Jun 2024 09:14:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eugene Shalygin <eugene.shalygin@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] hwmon: (asus-ec-sensors) add ProArt X670E-CREATOR
 WIFI
Message-ID: <4947b799-469a-4def-88fe-d4adc86f69c0@roeck-us.net>
References: <20240608085146.572777-1-eugene.shalygin@gmail.com>
 <20240608085146.572777-2-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240608085146.572777-2-eugene.shalygin@gmail.com>

On Sat, Jun 08, 2024 at 10:50:05AM +0200, Eugene Shalygin wrote:
> Provided and tested by a user in a GitHub PR [1].
> 
> [1] https://github.com/zeule/asus-ec-sensors/pull/56
> 
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Thanks,
Guenter

