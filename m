Return-Path: <linux-kernel+bounces-527031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0B0A40670
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 09:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF173A86BE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 08:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C17B2066F5;
	Sat, 22 Feb 2025 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnZOhFGm"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E182063EC;
	Sat, 22 Feb 2025 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740213677; cv=none; b=HtN9PSvq8mZE++2FuSqyMNcPZ4+vq3vEdufmh3hhFFU4BH+hQ8leTX+pNEo0jQB46AQ+G5wZDY+iMJaMco26f9caweJNgGCcPAP0S9lXYglFecUlOZErjI8iGxtpJVMBoJdfMHqkq1eDXuQ/erXB5DauWnCoD+oR1xcFMD2gxFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740213677; c=relaxed/simple;
	bh=ipT8QGteDw5f/sH4Qq/CmGG+rJIDqYmTvgmdclMSeJk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HGkkeVB8Owr1+okg67p5/kzTkkZi5lf56kRvILf8SX4418sVCvIVOnRpdWunL9A5CRf9wzE32CGgRDSz4u7B74S0P4kqr+QGHmdG15Zk8GUzkzWTGiQjvdACgO/d0r5+3tD/2WGjl2B6hfwES++g4TLWAPaiceL+LSwGXizhUo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnZOhFGm; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f2b7ce319so2400477f8f.2;
        Sat, 22 Feb 2025 00:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740213674; x=1740818474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaJV665AV3yPzU+JriL5zw7cJhNHTOrH7fZFwrVgwF8=;
        b=PnZOhFGmx74iy+Kp5BKkQGBGUi6dUj5PJx33W1fHC9BcbY/1dAUnt+jxoOkqNdLZlE
         /6lJBhkS7vG/eGI1k4tRa6KxET9WPmkj5EqURWx0HO/JX9eBA6UhyaFhUL5Zm2Luzb0F
         QvcN2Z2Iu/awQzeDkoSaTtLw+jF6sl8bwwx4ZbpSJZoRAdHfe8+Z8mpWB/egAljHnnCk
         /xsqzHlPkhAzXyC4Z5eZJB6cGZ4E77YB/rlHjjLxv5vOWl1rTPeU/6aAIoRjklh+lgv8
         6TmN0E6e+DoX/DWk62ofHA7AbQxgFRDuqbeTyt+oq+m9lpCKkjHylV1x7vvjlWIOy520
         5+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740213674; x=1740818474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XaJV665AV3yPzU+JriL5zw7cJhNHTOrH7fZFwrVgwF8=;
        b=HsurGF0aQS4hthYrfVeiLPKHfCIeNfWZVjinULfH8DHikhpoPOg31Dybv9hm98ZgJe
         DNNz3dwHbP8037d7KjqWcopPZwsLb0Sl2weXBG3Orpc2rGI/BetQ97HgIqceos6Y2NuZ
         71JENNB56xre8A60pguSsOsFvXWOgmmdURKU/3xvkuybciNcDx8eSb4PfwoxD2zwNb0P
         JVIjyq8bD44R/g4S2imCTCM+6KcUQ9Tq5jkQcGtpXBZ1l5XFrUREA0vN/mjJRxZQ8KxW
         SxCl5ep5/2ReRXeths+OBRL2rk2cNKJWpsGhynTallCtDDbyDwLqxu4zFCPucnkak/iX
         B4xw==
X-Forwarded-Encrypted: i=1; AJvYcCVt7ixqElqYjJL0ypt2s8kesRIPdEO6BBm/vcIvesiG3BOPsh9q1rkyjmHDHGYpNmAjD9AbsZY0GiW7mYWSr3o=@vger.kernel.org, AJvYcCWdUQWZIOouDtxvmGjjGqnDvL+G82kEqf8hqrpI6y7USVmfhcebuCYUdvMdmSQP/Jw/jGb2rBI+5oeJ8zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKGS0iiCB2aFYWvtcajPjur0rRbLqX4PjWpYMYy8g/4yzpBdEm
	2ho04O49VY7tr6ETanZgF0j5Y4MwgOVwf6jlbLqwNmJet+3oZkhS
X-Gm-Gg: ASbGncsEHNNYq1ZIiAbGabCc5+wPoS4v4TLyg6Q4TXSjItZoD7Lxx8+9Ja/SejcVgD5
	0LifIZqrnVY6KeXvBROhuzzN/o9RfnC+kp+wdnWnCP+UScxQUDowq6Vr6rHg/j/zUxWqa7DNJVx
	dTjUptVXcPxu9cX0V9JcYtJmf7OSbWQfie08/hKsUBg913LQ886eYLRQfLF4H0+9n6VGCrKwYO9
	afkmItEYVa+RpVdMJ+kGxnogYJEhtw0gqbBXiSy9h2t1HhAVEAewyLtMMPb/JskRAtlHHnDSJfV
	TbkOOeDgD8Y8KkxPffxkGb3lIOVnHmSlTjGmmnX0D+t2HQVrnVsZ8ldCOgKhYQen
X-Google-Smtp-Source: AGHT+IEXdU1fuHO8qIW2d1ilr9ZJTNlJ0Vo8IHgRtK33xwA9gvTMGEqNrn0XDDuoDvlxbx6680O3gA==
X-Received: by 2002:a5d:5888:0:b0:38f:5120:129d with SMTP id ffacd0b85a97d-38f6f0bc676mr4633805f8f.49.1740213673840;
        Sat, 22 Feb 2025 00:41:13 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b037213dsm40479475e9.40.2025.02.22.00.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 00:41:13 -0800 (PST)
Date: Sat, 22 Feb 2025 08:41:12 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jan Engelhardt
 <ej@inai.de>, "H. Peter Anvin" <hpa@zytor.com>, Greg KH
 <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>, Miguel
 Ojeda <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig
 <hch@infradead.org>, rust-for-linux <rust-for-linux@vger.kernel.org>, David
 Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
 ksummit@lists.linux.dev
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <20250222084112.23eb2856@pumpkin>
In-Reply-To: <20250222063730.GB11482@1wt.eu>
References: <Z7VKW3eul-kGaIT2@Mac.home>
	<2025021954-flaccid-pucker-f7d9@gregkh>
	<2nn05osp-9538-11n6-5650-p87s31pnnqn0@vanv.qr>
	<2025022052-ferment-vice-a30b@gregkh>
	<9B01858A-7EBD-4570-AC51-3F66B2B1E868@zytor.com>
	<n05p910s-r5o3-0n36-5s44-qr769prp69r5@vanv.qr>
	<20250221183437.1e2b5b94@pumpkin>
	<CAHk-=wjF0wjD4ko7MgrZ1wBZ9QOrQd_AnyhDDUJQ1L5+i-o22A@mail.gmail.com>
	<20250221214501.11b76aa8@pumpkin>
	<20250222063210.GA11482@1wt.eu>
	<20250222063730.GB11482@1wt.eu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Feb 2025 07:37:30 +0100
Willy Tarreau <w@1wt.eu> wrote:

...
> Update: I found in my code a comment suggesting that it works when using
> -freg-struct (which is in fact -freg-struct-return) which works both on
> i386 and ARM.

The problem is that you need it to be an __attribute__(()) so it can
be per-function without breaking ABI.

> I just didn't remember about this and couldn't find it when
> looking at gcc docs.

I can never find anything in there either.
And then I wish they say when it was introduced.

	David


