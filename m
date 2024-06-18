Return-Path: <linux-kernel+bounces-220207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5FF90DE14
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B720284776
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9A8178384;
	Tue, 18 Jun 2024 21:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="wlmvvA6B"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7DB1741F0
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 21:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745575; cv=none; b=mRLl8q6Sqc/qwOugtKT4A7c0cR5d5Un6DO4PTQ6LnNGXWm+DlyHfuBolNGdHYwCL8t847TFN0XKY4M7vVzMRFqlueZxhlBROFFSc6laoOus0e8udJLDeiHtkh4St0smI6zLaTvlqOSDThMkdJ2ZppHUumm0Sr2cKIh5+f+MVkmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745575; c=relaxed/simple;
	bh=OmfcprcSrUb+Cz3hA2CEgypCro4sSFG4VGiwa764RG4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbLSfmK261sTLxQbOGjYCBkbe3kUhsZx1yGQgPRuWaspemfdAbd+V/X/4mmzoWaqcNacJsV+923cVopYuHrizygy9edt3y+8ltd9gmsnkbs/Erj/2HDnEe7Nha8myTcJpc0fhF6GbRMRMf+WuwnPJZDfbl6xiC83vGG5EZYvSSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=wlmvvA6B; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7042a8ad9f5so139598b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1718745573; x=1719350373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBOXu3AX8iawimeoI7cVv0ed5p6W28OLisBmj7DoqVw=;
        b=wlmvvA6BvEqyuuBoqUKOoJyj4PwPrQFUKWUY5IQnA6vyE+rc+I+4L8TXE9roOC9KNq
         2eJymBdop86ofjXk1IE38F6oSjUq+md1puHObDGI+MdxqRU5nQEp6UW9rX5M4v5LYOT0
         pSsjmDtQtKue4APmmOpq7EVYrK7dgK7bW7DwGXZT4qd9SKkorJbdJblZzs48AEgKYhu2
         wwpOPKhS+7Qbeg9aXb9GkAUJGL/lToe0/kw7SPHkL2nib6Mz2OTynozca04+VvrAakBW
         1lCILexuJFfGDD51T8KhsaBdHcnhkLg6pxMr5BWv8W4jefX10WrDxiM+U74GfJTXEzpa
         TEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745573; x=1719350373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBOXu3AX8iawimeoI7cVv0ed5p6W28OLisBmj7DoqVw=;
        b=ghHPKHQV+CdwwMhRSm6m0e0ZP31/0nrvp37VTLmnA6nD80TjkUOSxKUArSqXM8Bn7D
         epcarOJTMqbb/7zW9NQkJrCggBkytx0vQijZNfJy0MnQKkbpS7S6A1h2nytOqm768S0r
         OfnYDrqgDy6MnIvFRyAtZonryKjZ80+ev909DAw88KZEUwKkLjhaI0BPXZDpnUom3ck/
         D2kRs0JmKAZZKu+MXhceaSeaIm5kwvGYdTZfhZUyt/ihg4kIgUxCmZuoGZ6BUprqEeve
         b008biSz5fkYkqkPxjHAj/jPehd5e+D1S4AH+0LV8tfmeGdY/KWlAEglRarWNzIFEyZ5
         qWhw==
X-Forwarded-Encrypted: i=1; AJvYcCXWUz7FxyHgogFfH0u8zUEkKn6JXQ6eTHnXWlGKuh6zFED+76Q2T0Ad8XlvPpkgcPlGRJXJMFg4S1ObhakjQdRJXJ154Yqyhcw/RKte
X-Gm-Message-State: AOJu0Yxv3zorP9yTCrbajqp6PqmcpSUikFOEfj6Yash4caHMv5r0IQlB
	uAO25nLl79kpv0SndT73HtgRWboIVqhF9FldnNPGpbefGZWILFT5YkP3hvdLDyA=
X-Google-Smtp-Source: AGHT+IEDJdHgqhnpdjG6jF8Kggw629x32bz6eKrC/MAgTBCxU/oW9mH69BRNudTCCPM3Uu+J0MTMjg==
X-Received: by 2002:a05:6a20:3c8a:b0:1b4:b9f0:ffc4 with SMTP id adf61e73a8af0-1bcab0528d7mr5844124637.18.1718745573134;
        Tue, 18 Jun 2024 14:19:33 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-710744224c4sm390475a12.66.2024.06.18.14.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:19:32 -0700 (PDT)
Date: Tue, 18 Jun 2024 14:19:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: Joe Damato <jdamato@fastly.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "ogabbay@kernel.org"
 <ogabbay@kernel.org>, Zvika Yehudai <zyehudai@habana.ai>
Subject: Re: [PATCH 09/15] net: hbl_en: add habanalabs Ethernet driver
Message-ID: <20240618141924.5a62a3d8@hermes.local>
In-Reply-To: <16369c7d-af15-4959-9e84-8a495b6b5035@habana.ai>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
	<20240613082208.1439968-10-oshpigelman@habana.ai>
	<ZmzIy3c0j8ubspIM@LQ3V64L9R2>
	<16369c7d-af15-4959-9e84-8a495b6b5035@habana.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 19:37:36 +0000
Omer Shpigelman <oshpigelman@habana.ai> wrote:

> > 
> > Is there any reason in particular to call netif_receive_skb instead of
> > napi_gro_receive ?
> >   
> 
> As you can see, we also support polling mode which is a non-NAPI flow.
> We could use napi_gro_receive() for NAPI flow and netif_receive_skb() for
> polling mode but we don't support RX checksum offload anyway.

 Why non-NAPI? I thought current netdev policy was all drivers should
use NAPI.

