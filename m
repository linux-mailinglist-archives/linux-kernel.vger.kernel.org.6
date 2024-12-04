Return-Path: <linux-kernel+bounces-431368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1B89E3C72
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD61163198
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1BF1FA826;
	Wed,  4 Dec 2024 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cn8v+tl9"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A93198A05;
	Wed,  4 Dec 2024 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321768; cv=none; b=YKEMnV9r5M/nc6qiwbxGYuTQ9OPskaXHdw0wkYWJ+iz1t0bKVuPaOBCQNqpkJrhOnef+/Fm0KLSoDbn59yFhqsRqTBHPjn+Fmxgbl51JTUYJyLVpbAG0B53Fh93R479iMTmOOK7+gQr9Ln2YABJ0Hs7OoKwC3bl49AWSRYhgoJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321768; c=relaxed/simple;
	bh=32EqbbKgH8JsssiHgI4ePkOybtoGOsnklDhrUj1Cn6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWtol3uTwXV25w8wDxt3SNxMdv1Od57RKsPagChRUb4NTHr8d+pQtkNjitTkRRz5RK09Mw5/Ka8q8f8npHWTVbc6w/s4m3PQFA8NHBQur4jH3XCpgLa6KrHOsu+Q9I1TxEmQtmVqh3d4nnkDgrqNSzmVQLi9z2g/YSL5sCVzQFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cn8v+tl9; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fbbe0fb0b8so5201666a12.0;
        Wed, 04 Dec 2024 06:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733321766; x=1733926566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6UoYI/6wjjQHlIxm1akrbMbioBvwu+FdjbV698jP2Z0=;
        b=Cn8v+tl93SnDA9l8vIbzHWLCWvNVvEHAXNneUzjFkmOfwpN+8bmXO+d2aVukoSHDf0
         bLfXoGhUDnK1D1UylG8PrxcmyFG6VkggZEbTF3ioe+K+j/rlniE/w/aAOwHIVYAM4iAp
         siZJssoLvJOqPFeHj2UaHjWE6UBJ4SaknVi5juTSiLKOn8YnPf09+MnI1EGIXOBBbKec
         2tTtjmVlL3L7LNIoeZQf0TTTjFUJBolht4TicLXK2G2xwDHodHzTd3PwZahvxpAG9S3q
         SBRtzswc4Ps6C+giJWwaI5CDcK+BRIrk4Go9ry26JlKsgt12KpToHnEY1056ezrppLSn
         MMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733321766; x=1733926566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6UoYI/6wjjQHlIxm1akrbMbioBvwu+FdjbV698jP2Z0=;
        b=WZjTkZCf+uK9er3Ou/T2cHwWjY0kon1flhcD7TADOLHQSz7c1hOSnjR6aaO4jT2vJb
         4F8WxVeAdoiP8mOKLmnYJ0A9jRM6seAl1eZLrJTJRtrXfelcbhRQY/y7GnDbCd+a5kzM
         N+v3u2WUf/WS/H4XjiliWjYpOeHJ7jhu53QDZDBLmLuL5AMd00gJ0IVXSXZ684YKWODZ
         JBSoz9LCs/FFq0pS/NBQ2cDH7BkvPMiZTBSIKDcUBDdm2uRU8bMgcJgVeJu1j1PK8fkd
         GN49t0soMKCPgJgzga4cAfGHcu2zFHYdf7rdvlz5ZVLICbc1QHFcqoPKWJmDf8jrhs4m
         QHtw==
X-Forwarded-Encrypted: i=1; AJvYcCVsCad5N9TyemcCty/ojok6McqPLvVdwLpMHNkajsXiUnsa5hfEPn8hTeyRPYyJQQtvV/SdlHvzTRfSZg==@vger.kernel.org, AJvYcCXvZMEbOUjRo4w1OlLiXdn+pntaMOYzjwwVXJ+k+CGZTq82y8Mo0TNn8HzAsZ1gcy96XEY5lDWcNaF4vVyv@vger.kernel.org
X-Gm-Message-State: AOJu0YzVwOdu5L6gKn6HwRclXa4su98pbzqQk0NNnwhv++nE4By9kye5
	17NS2zBma/HNFFHkHRyN9rf0CYi5W3JB6H49XVoXsijpTYw4o5zI
X-Gm-Gg: ASbGncvf/OMCJXk+A14tRgAcYvfG2Hmj/1c1lpntZkoI1Wm62qc18i/LLw5NjkDOT8v
	f1B2Bz27pYtnYFRUFLiD0rN/PRbMFNoFm7aAcUojHYWVwe6fWOm/BU6Em0onmzipe8R5OihLfmw
	lgmdcc+pbOSuSRSjIsEkBlVc2rgVouAaDqcNMYaiqL2a90FUc5WsS4SRicnCYMfJ47JkrJmlYut
	WOj/0SWdTwj0I9Dq/LeIRjwaSfoPFOGr5oE/2Ip03OoZ8Lzl3krtc3eWYFSa9Q=
X-Google-Smtp-Source: AGHT+IHR1+FBG4a3NUTYX7/FuhDP57kaiIUB1PCkRWwNo20wTo+HWNWdUciIaNY0VnGFsuvIxQd0EA==
X-Received: by 2002:a05:6a21:3943:b0:1e0:cc01:43e4 with SMTP id adf61e73a8af0-1e1653c8321mr8713277637.27.1733321765983;
        Wed, 04 Dec 2024 06:16:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fb36asm12317528b3a.116.2024.12.04.06.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 06:16:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 4 Dec 2024 06:16:04 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH] hwmon: (tmp108) Add basic regulator support
Message-ID: <2715de47-b880-48d2-8aec-76c377455e87@roeck-us.net>
References: <Z0WJg5MMu_1AFYog@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0WJg5MMu_1AFYog@standask-GA-A55M-S2HP>

On Tue, Nov 26, 2024 at 09:40:35AM +0100, Stanislav Jakubek wrote:
> TMP108/P3T1085 are powered by the V+/VCC regulator, add support for it.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>

Applied.

Thanks,
Guenter

