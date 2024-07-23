Return-Path: <linux-kernel+bounces-259514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A67939781
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 02:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EFD01C21985
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 00:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EB878C94;
	Tue, 23 Jul 2024 00:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FHYanmM6"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3733D7604D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 00:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721695070; cv=none; b=GDL1atNEyFsp6WnSuo++AI3dtbVanic3daNe7EbNP8TFmXCmTlvP/FyZK+U9E38ULbNeMIwebWGVM0ydHxNsO4ZkKDnqob43NT4LvWW1wvt/JJXWVDI2+MM4d3hPgmDToSVS9w7sHuWp2u2A+V08uth/p2ER2NPyI8MdzPxAj5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721695070; c=relaxed/simple;
	bh=D3a+dXiPQthlFfvcmFIw71AHdyEHZH4vd1kP4C5B44s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KCYKWJ2NBGF5aIAAtkr9Q2cTrplYuqhxAuZGQ+/uDnlk6mgLBwHe4srv2kcMVJpjQGxIaca0BcqzoJ6pG4re3J689nYBIHfYvgAk+cqX3GBcM503HMDiO/kIPoUfxbX/WNCFcblEpQGGvTs+oSTPjS933pTHSNnl3hiiAvD+nLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FHYanmM6; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2cb0bd684bbso400525a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721695067; x=1722299867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JtcUJ3RWleMldUajMj+zej3Jpt0/SjlD8RirhRbH+6s=;
        b=FHYanmM6o5iaI90/hbcpBY0MX60hXEPGLHYyoE1d9Lz3fuhW8NsySBnD60dIKAud1/
         JFyFcRY1R/a5H6QKVT3/xkFEXquRfAC/0nlNqikd2Iy9+c05WAAb+xX1T6SPJ6d7d0vE
         RTMd1IHaRGJbkZt3FxhuO0JXJK3dJfbfhoq3QbkPVdAhBUT4RvIlU4E29dYXJBxHX3/p
         xDQtjaHgpbeboe+bd8IGKqGlll3C2RjLauymsWTwbBE1os8/PrrLFjyx7UxEgW3jnpKq
         Ev99GzHARFkBkOhu4Dm5OLFKzsVa8l1ZZyT5h3zkPwrXSuQZx9RsZMFcXb44Vbn8D8Eb
         eDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721695067; x=1722299867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JtcUJ3RWleMldUajMj+zej3Jpt0/SjlD8RirhRbH+6s=;
        b=J1UlRckiHPoTd0MSYLqmZJVvCJ348ycGCLtQ6QZevW9DP2bB3I+puH7KzfEvT/thfr
         y7tnfIcoJ+8GwBAd5aSXQiCHu1QiyMwdiEsFhpYSe26U+O4P4WURL5/RjD3hfryuMG7+
         h7EinwfhZpW4QOFmxVwooya76tEF24lBqK+IbJog/gPQP/bZQVjtNbWEQZtX4uIcLMOy
         QVjDUjwCQOPgd2mULkB0CygdRfSCeynOO/MXmkA6+Sj6sBiwjZmwaVwNYmZbE3liwl9m
         CKGEa2yVL/qkPXP8PpgrP5snfTXWhzs0PE9l41BALQ5wJhQcN6EL06e+X6lm9DC9h/hS
         C3Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXvMzqQZEbRsg5cANAkiWvozaiwfEn8NsX93IYmlXVhfLXLf39L3JnWRebAsHWsxehkqPs6ocOV15A0zV8ZD7oBKTbtyXOChLzP2tLa
X-Gm-Message-State: AOJu0Yy8CJBvuwO1zGThgwcc+algCeacbbbaoe/20Rln+KXqx5Xpsnaw
	4MOmeFYbQLykn23B/Mr/TRUP5Sr/cgvuPQPSNDtO17Sic6FX/vy06D6H/ZByVlc=
X-Google-Smtp-Source: AGHT+IHBUsV3UF5T08jKSUPDiyfiD6ZXVUR2DV7PF7MqUJc5LLKo4T7ZP31NDftyu6cLa5jJqrrM2A==
X-Received: by 2002:a17:903:24f:b0:1fb:1ae6:6aa7 with SMTP id d9443c01a7336-1fd7455cac9mr74649405ad.3.1721695067484;
        Mon, 22 Jul 2024 17:37:47 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f47c828sm61173635ad.276.2024.07.22.17.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 17:37:46 -0700 (PDT)
Message-ID: <55d9f47b-5833-4e3c-9e56-f56a30083607@kernel.dk>
Date: Mon, 22 Jul 2024 18:37:45 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] scsi discard fix
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Li Feng <fengli@smartx.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Damien Le Moal <dlemoal@kernel.org>
References: <20240718080751.313102-1-fengli@smartx.com>
 <c1b47037-4754-459f-9e8f-ae4debd3fcf2@kernel.dk>
 <yq1o76pdltx.fsf@ca-mkp.ca.oracle.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <yq1o76pdltx.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/24 5:55 PM, Martin K. Petersen wrote:
> 
> Jens,
> 
>> They can, but is there some dependency that means they should go
>> through the block tree? Would seem more logical that Martin picked
>> them up.
> 
> I'll get to them. Busy with a couple of hardware-related regressions
> right now.

All good, just wanted to ensure they weren't waiting on me, as the
cover letter seemed to indicate.

Thanks!

-- 
Jens Axboe



