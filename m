Return-Path: <linux-kernel+bounces-215289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4B59090B0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73C451F21662
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406B118FC65;
	Fri, 14 Jun 2024 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOL7j80x"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085FE181B91
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718383423; cv=none; b=ifQvtFrDKbT2zQ+fnBRaxIAOdCF95lWZY9NQdUmeCLUKXxifH8556WEl7OGBGdYQ/uxDmWi5o3kJBacni/laGLv+078pGGT2OuehFR2utoSuOSVOTFjIH0gfIXZ42j1+UZXeNFC9LFODB5y5JKAQbhU5TUttIoCuEDtdI1mbfEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718383423; c=relaxed/simple;
	bh=d5Lvv7h5cpXDk6W/gnDRiwt19RfIXWkkQRdmPaInaso=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uTVPf6AY2YAu3+6QSvs5CWFyp5rz+Y+hvqEFJjQ+oKpQYtLuEB8ihXHXhIL+qXUNCx3+3Zyd2IiqqcVaoU4CYjCxF9JpuhRZk3nc4JPSYk2i7aicIONF7qZAeo8gyzJyYPfGfwh0vm1uFtzwxJvAtvKMBg4a51a7qUhzN+6r/9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOL7j80x; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57cb9efd8d1so3341964a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718383420; x=1718988220; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d5Lvv7h5cpXDk6W/gnDRiwt19RfIXWkkQRdmPaInaso=;
        b=WOL7j80xUccsPVleNhCDphc9x94xAtd1W0wwE/qlFqgVar2uygrYhKIiYhgC41dqMt
         jFjkyizhUnHi3UxlhFhYGsJv6FO1IhbvJPBdli2g/Fy+kEusoS3w0vJHJ+4CjMDkJXsz
         1TB+RXREUjIduvFXZNbzkmxSymbWYDYf0SjnoLFbcnl7WBWnwwOM7504PrFYv4UJ+ICi
         vGa31c5hUy2avCo/M8dhZTYPkxexsRaQOaXoeKuy5/bQ1+C4Pmo+jQpE51TB8KkdFRGz
         /H8DYwN8HXr5m0BTC8aYynLV3lNXAMAZ5tXbkCWbS5krfjc+9CntHZeZ5w6bVk1vPhik
         3x6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718383420; x=1718988220;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d5Lvv7h5cpXDk6W/gnDRiwt19RfIXWkkQRdmPaInaso=;
        b=T/gk9CxMXFUIJd+9K0BJOWeNi/fCsX8CXWPPh9UESkj/EJf7OQqs65eQ9FgC26dUZA
         50Uz6xVL9Vb91NWKU1oBMzGKHy90QZCPUH523YrSZXDxaUEyAXK7k//4xtCCe5p+Oetz
         pk5I+lOX0XDGx0EXq6LK1QdoY0N9y3+csXBAS3/i1kgNyHz4mMksLH0r+xDkXeTZGtIK
         OjkTGas23Fooowc/7HP6ZKuf1Rkhb5iBiR44nqZEBJx8Ykb960zN0Ap89KAN3eM/UU2k
         arX7568J12Xl0+3WG+fOhWXTs0G1GAaNOm0iJM69Bhc+OL+aOEmiDSCFkehPXnZXQs05
         /MZg==
X-Forwarded-Encrypted: i=1; AJvYcCWgvBssItUXuHlpGrosRRmE+GTZidktZsGcccR6Ahv5WpYXJ1+Six3Ed/kDIF7k7trYuE/k5XAlBvHxJcylnhNVNeE8LwFk9jBeyUBc
X-Gm-Message-State: AOJu0Yw2j1ZBEZiFgcLPZALhH0PD2USPHsvRra4Jde/WNj1nER6QhV8O
	Ghb3BSsaiBshx1CY0GaA4kmG10DydxBSoRJFSJaRiAhxyjYH/P79w6Z5LGAdKGORhEvSnEwZpEq
	AYc5j00tlESwmjHevSdUF2XZW3rQ=
X-Google-Smtp-Source: AGHT+IGPpkBq28XKJpDdjBk3xqnrBsnQijyAHpYp9bTM7Iv02IbJso4b9IqplKPZDYWKOLAW0VgpylUqyEQ3H7NBal8=
X-Received: by 2002:a05:6402:516:b0:57c:5c50:2ef9 with SMTP id
 4fb4d7f45d1cf-57cb4b9965fmr3884615a12.3.1718383420051; Fri, 14 Jun 2024
 09:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Philippe Simons <simons.philippe@gmail.com>
Date: Fri, 14 Jun 2024 18:43:28 +0200
Message-ID: <CADomA48VNZiDPVKrUTq6h8SMBO-GA5HUGXXRRA9jAQnPKyESJg@mail.gmail.com>
Subject: Re: (subset) [PATCH v3] mfd: axp20x: AXP717: Fix missing IRQ status
 registers range
To: lee@kernel.org
Cc: andre.przywara@arm.com, jernej.skrabec@gmail.com, 
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	macroalpha82@gmail.com, ryan@testtoast.com, 
	Philippe Simons <simons.philippe@gmail.com>, wens@csie.org
Content-Type: text/plain; charset="UTF-8"

Tested on my RG35XX-H, v6.10rc3 boots with the patch applied

Tested-by: Philippe Simons <simons.philippe@gmail.com>

