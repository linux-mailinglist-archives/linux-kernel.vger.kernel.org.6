Return-Path: <linux-kernel+bounces-362062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E578C99B071
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 05:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A647B2835AE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 03:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1FB4642D;
	Sat, 12 Oct 2024 03:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvOIoUcX"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECED14286
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 03:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728703908; cv=none; b=KbyqRJqJ68zSae0gE+MfihEBF1W6AvMzNso3Lq86CF3a6aUvjqjNOoW9Y5Dk44ccy74XcJuxKDNk+Gtikl5aNBjk471EpbOzay4BINwRjg3EoliFokaJ8lvLyC6XkfthGS/VGl2Q7deY4Brx1ajfbrEbpVFKfh/WG9Cwc85t4D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728703908; c=relaxed/simple;
	bh=WebmXUhWQ5u4LhU9iZSk4ZAS/7E4V3DNf1FzOYe6PII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vp5CCPnmCP1ktVD7ieBjD70q0utIzaO4dBboVNEjlOIe5EGL2UK2l8Tle4+TvoEeBacNEm3q9e0Kk2sifSxXRd2ajrTXdSlwcpBiYhvX+UkPCeNgh1JiUcXa+c4L4/e2cWC+6Y9eHaRdZZWAyzAZ3YSbtxwUhdVhS5IuIrenx1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvOIoUcX; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c9552d02e6so1195825a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 20:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728703904; x=1729308704; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QsKGo8Omt2Eyqc1qAXwnr1uQz5CRFvUdDKrZEWtFMM=;
        b=LvOIoUcXU689JUsOlPVbxevci3PhArdpSiSUBUuD2ayfCzVldtrYFhQ5pOkptqr56W
         9bNp4FTcCPtToLyB3JSsRa1yYmfP2G9CQqP7pPQkIOOcMNyqWRUMc2L90SZQmLhw1P2u
         xcM41v2VzzOy/0Yf+IpMJjbtQl2s9eWtvFDTVdFSdOejXpqXc2K0RPQ+1EdB4YCVc62R
         EPiOuowvsQma12GcmeQgRTKOxIWoE3f5hJHHTPwBIwhrlmrhWD6RdglliNDvSYvysh27
         9ROkpETe4Ebcg9l/h8il5F18P5PzhPkOLdCJFBXQv3HCTE7CU8SEWWghyuZbWdvqNwZa
         C77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728703904; x=1729308704;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0QsKGo8Omt2Eyqc1qAXwnr1uQz5CRFvUdDKrZEWtFMM=;
        b=mZ09cWD3+6u0KD6ZN1ey1yryXf6f6UHzoevXYZSYA4h8tRRW/GPhDrkI+Lz70zj9QT
         qL3LeYPYynGO7EhQxEsbQ6jDAPFQlDx3ctVy70rwooTgjVIhJLC+wkjGUNUPeGWjow3E
         uZiG2fHICQNQM/wdSbt+C4JyjjfWHgolgMTEGQMD4XuLzLagtORDcDuLwMADX0RtMfyT
         FFsBBhwUvAnFx/7vn6u3D2gADI5xGLLl/qKbdB1gG/n8Me6JhRHismo/YwuEp52Vp50L
         Kxokln08VqIptaKhS8214wLXUN1rAiOfVdpYT1jg4jx6ZxByKy6MUTwDFaqEKtm6Xdgc
         XObw==
X-Gm-Message-State: AOJu0Yx0xqT1yrNmEclyhRMyv9UB0uNGSW0b6pMWiwdxFxGfaGIXITP0
	ULFHF72d6UjUGs/TXQjijamHTMhyU4GRjJA1rm9cwK7w23dfEkZ4
X-Google-Smtp-Source: AGHT+IEeHWLgzP632OSTTZ0brvpI3Wl01mBFPVWdUuAm46KlIG5n44Po3U+vJaIuAG2gMVCQqYSliA==
X-Received: by 2002:a17:907:9809:b0:a99:a44b:e622 with SMTP id a640c23a62f3a-a99b937a769mr345597166b.25.1728703903961;
        Fri, 11 Oct 2024 20:31:43 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99eb86acd1sm32334466b.106.2024.10.11.20.31.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Oct 2024 20:31:42 -0700 (PDT)
Date: Sat, 12 Oct 2024 03:31:41 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
	linux-mm@kvack.org, akpm@linux-foundation.org,
	liam.howlett@oracle.com, willy@infradead.org,
	richard.weiyang@gmail.com
Subject: Re: [PATCH 2/2] maple_tree: refactor mas_wr_store_type()
Message-ID: <20241012033141.3p2ieftywbkmlw4k@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20241011214451.7286-1-sidhartha.kumar@oracle.com>
 <20241011214451.7286-2-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011214451.7286-2-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Oct 11, 2024 at 05:44:51PM -0400, Sidhartha Kumar wrote:
>In mas_wr_store_type(), we check if new_end < mt_slots[wr_mas->type]. If
>this check fails, we know that ,after this, new_end is >= mt_min_slots.
>Checking this again when we detect a wr_node_store later in the function
>is reduntant. Because this check is part of an OR statement, the statement
>will always evaluate to true, therefore we can just get rid of it.
>
>We also refactor mas_wr_store_type() to return the store type rather
>than set it directly as it greatly cleans up the function.
>
>Suggested-by: Liam Howlett <liam.howlett@oracle.com>
>Suggested-by: Wei Yang <richard.weiyang@gmail.com>
>Signed-off-by: Sidhartha <sidhartha.kumar@oracle.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

