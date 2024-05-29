Return-Path: <linux-kernel+bounces-194600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A4D8D3EBC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 21:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D2312873AB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 19:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F733181D09;
	Wed, 29 May 2024 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jjwq8F20"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B94CDDA1;
	Wed, 29 May 2024 19:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717009359; cv=none; b=mLwacKq38HhwPLNR1Huwv6UlrrFWyC7C99dmND3Af67Tz/7RZCnF8MDrlzKytwP+AiGpU7t8VFOgFAHS071jCkh5BJxK2fCr3dcwA1ZZ8LwuJDvTn2PNVRwU3iipgapT4zG+ygdRjxz9TwLSVuK5WEaCspMnPsEfrmFcI2SjFz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717009359; c=relaxed/simple;
	bh=bpYNO8LbmJyc05+u4bqQjo0S4lnv0flmzs78GZEnzdI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=WYc6ewdCyH6ef9mnARKuL7RPA5cLSBzFVYDuWie8x+arnNEmH2WWY2vjuzEiAat5gle7Auk99MF18/RTaAqYDo7FnQ5N6QkuYpNZMARJKqrbwjPRUSjutoe0t22PZjlPCPQf5Ho3KXx6aRQVddSIW+lnz5RdZuu5NlKm9olB1II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jjwq8F20; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4202c1d19d5so448295e9.2;
        Wed, 29 May 2024 12:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717009356; x=1717614156; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpYNO8LbmJyc05+u4bqQjo0S4lnv0flmzs78GZEnzdI=;
        b=Jjwq8F20Wfz9QhPBByZ0f/mZUHS4IpjtrFE4LBXycrM7+hdguVdkuaFjKlIVbl2mzl
         bq70bdA735NFX5bTlSNUzVpuxP2uFTEzlX9d5Krc5zKCR+/cFXCbOy9DZnLPOrsnHHJe
         ttC+eq7/H6796kpBsr+fiLgVCJggrMa0ZBu+dlKvXSNJh8dmZ30Y4LlB043ero1+UehL
         qbxx16zHISvxQheiMOIaytvACKRLPQYymtIfmnO07RbSqoeqTV317/Mf5bt+mSOlSKwf
         5MR9dJwEdhZznsTooVBC4S25AEkq5FJgStSbD9FhiICnCPRd4E31Q8qyXHSksq2DcfB+
         aREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717009356; x=1717614156;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bpYNO8LbmJyc05+u4bqQjo0S4lnv0flmzs78GZEnzdI=;
        b=pw3Vs21apCJh5rF2QYH5yDXmE0b2woB5UsKi7KNpAxSLGk6xVZBSQ+oTZFBHr8yCBH
         YXg8umOr2NihJOEm+iCOczb0bFjmIAsJ2A89VnIsd//+QeJHvBpG4lkIHnJCKY6Lx3++
         xKTZRSFKnlyqnUkKSmKcaA+3OzqGTKOYqgLMLsDZOfQq1lXmkg2DsZg7WruBWqAnDPKi
         mdQoj82YiABMbbH3cFsacDqJp+4ikBvWySlq1qjh6RdrPHXV2ji+sVBKOagMo5rp54s/
         ePHjhp7mBapDXsJLTdSbL1vZ6oLX+gfaTBDjv5fnt0BiYOAd02df92lz5um/s9WOa5t5
         H9dw==
X-Forwarded-Encrypted: i=1; AJvYcCVz7Hh6xt8DRbqP2BECUGrsRrxn4IGM0OMRsJ3LZlTBLmMFKDSYtM/d1CbNxsa2LlQVVrJwZaztxgHDA+RXR3X3oxwHlrp3seoCqZNC
X-Gm-Message-State: AOJu0YwV6IieqV8bWZsuP3dQUirmiM6EX+NiBgzh9ILOIhnOo+RSd56M
	I3Az0JmV/1Iv6c9cdNiHYLqI9a35IdfeeDjQPDzqk5Ouo3XGjOOGt8t7BtykFekFIg==
X-Google-Smtp-Source: AGHT+IGbrXWDERnRAl5ktgVopq2DpLc+hSFTqTn8Vn0pqLKAFK6N+tybPiyTOVxksBZ3QPlBFYRyfg==
X-Received: by 2002:a05:600c:4f42:b0:41f:e3b0:83ee with SMTP id 5b1f17b1804b1-42127811758mr633645e9.3.1717009356276;
        Wed, 29 May 2024 12:02:36 -0700 (PDT)
Received: from localhost ([31.171.153.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7de7esm15359626f8f.14.2024.05.29.12.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 12:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 May 2024 21:02:34 +0200
Message-Id: <D1MD0O5LFZZ0.1UAS75ZVQJKOF@gmail.com>
To: "Alice Ryhl" <aliceryhl@google.com>, "Miguel Ojeda" <ojeda@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: alloc: fix typo in docs for GFP_NOWAIT
From: "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
X-Mailer: aerc 0.15.2-211-g37d5fc691aff
References: <20240529083452.779865-1-aliceryhl@google.com>
In-Reply-To: <20240529083452.779865-1-aliceryhl@google.com>

On Wed May 29, 2024 at 10:34 AM CEST, Alice Ryhl wrote:
> Fix a typo in alloc.rs by replacing Ror with For.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

