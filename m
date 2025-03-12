Return-Path: <linux-kernel+bounces-557348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D4DA5D7AB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA31189D7A6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963F422DF9D;
	Wed, 12 Mar 2025 07:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hz0Ybvgt"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E561D88A6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 07:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766198; cv=none; b=EAa3m0c1Xygylj/HVbu0snrReqySsw5rRr7I6LsEmv8knGpWKdXS5hBck7bLLNC/zo0TySsFzAv9+uKLtVuhHZtKrUiCEulX6ppLix62iT5oYG79NiwiCwad5v/rclD5xlx7G6W72XcJuHHA61pfkPTAZ0AuV4wzTlb3GNl3lpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766198; c=relaxed/simple;
	bh=35CZaj9e0EDEqpNnf5IVtlgWXdDQPbnOKfskpsFe6uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7eId2IslH5geKze7+CZfopcp8CVFkezatjCyXyAFivX4nefWzBKFhruoPpM9+AlYUJOQ2xvF/k1MW9g0rmM32Ol+M7TiCrBJnIdW7k2eIbCgY2UEeVr5lhy01agjJ7tDQPkOfMUeqXl07BxHiElLmpSa6Cra5pTVI4Gxzj9RjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hz0Ybvgt; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5495c1e1b63so6629672e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 00:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741766193; x=1742370993; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3wyyfwOpoNsq0clOc6hSFVvZfLJtb8AcaIz2Ox+0V8=;
        b=hz0Ybvgt0jq8t02yldqP9VnW7I5YgW2ZeXaln2Dqr9CpHQh+T+5KDW9MVghirW1Aqh
         yeHPhNluxGvN+TNgkkabJ4TWNfJIOTRRGhyTNJLt4+kY5J3WcYGBzK/HKnAuUu5TVap4
         sPoxf30yxxMpuNLc9tRZWQyM+C0pmXMmAzUDpMi8vhj6h0gCoZ+tXXrwoyyGP9w1kizf
         lSE+9GPI2SgbL2WLp7kMGTe2Pc7pyNHf87slUIgEkTunVKhVkkmk40TZPyein4kAC3BH
         LH7js3H998oI4XcO0kKOfidLrh8JZOvrbZvvT8CXk1BYxWFtN7TSsV4Cc5kyP//+vNCW
         xNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741766193; x=1742370993;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3wyyfwOpoNsq0clOc6hSFVvZfLJtb8AcaIz2Ox+0V8=;
        b=vywt+1GM7GCIHOzwmDWziVOBgrsp7zWkhkz/M+s04EFPsM91p0gPqhRRYNprf88tgs
         WhhhAT8UHqBQi0ydLG9KwISZsweSSRphjQaSdUNEWh1ienB/JII4GkDBR3hlgmdDoZYb
         zAuNJKR3rUVa+t9nOxq0mQnKWQPwJh3tcz5qIa/uuQHIQIGSCPEwIKJxUbdXXgAxej7t
         8haeBTeVAFOmlBx6REyDTpYQMFm2quldHcM2C5CvC7oHKXEBSEKsDh1HrnsQQbaM+Jwg
         ZSKvVVLHLDwjkNk9h4TsfRnHV8Z+mKQ7OV+A5AND9wX+HaJGQc7I2tY1/yZ2EHNCgqZu
         1DEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA9AFxWyyp8rtv1nzwg0hzhVlOhz/MJO1rlxbFqexIq8bzrtuuKNfbi+0kD6PYD8yJ/bPktQi/f/O1v4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1huJU1b9YF3jTBR22XGWAR4xhBIjDbJ1zcoNBZboxCPOjhNpk
	fF4mIihyf3SsMVAiv8RfrUoGNUy4BQV4z1KM0OlwqSkch2HmVWMx
X-Gm-Gg: ASbGncsyEOZzh/0UQV8tK9qYDtJf02ttfNq9bc9rmCZmYebWgyIpXfovCMrUA+5TGti
	nUARR73Qut4FGt2r+3IQBw5KDH5vfDhB77mBLYUrnvPGRINUt9YUjkDhj/Q0Oh223mh3vXPy/HQ
	aVPtQuOnaAdEa16Jdt72yKvQVcoH7p6jEHRxZxmAiez5GVGuhFBxSvf/n7+hEvJn+O+x0CmxQFv
	+oSgZOw+pWcnjhS0IB+b1Q5XqXAk7RqD/S3HejRuqiUkk3tK0BTd/DUO7jlbs373ek44IypxGag
	tQ36h2Lr4lKU8EtOj7riQa9Rd+GG2OPOpdWvcQ8w/UkiMws=
X-Google-Smtp-Source: AGHT+IEjQaZs5T5ZDDjAKYJGVt1s6iYpZ8Lci0SjZKojtUFYU2/65513d3B9k+EdWSOZIVi3BNR3Hw==
X-Received: by 2002:a05:6512:158e:b0:545:cd5:84d9 with SMTP id 2adb3069b0e04-549ababc3bcmr2484258e87.12.1741766193120;
        Wed, 12 Mar 2025 00:56:33 -0700 (PDT)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b0bd148sm2045714e87.139.2025.03.12.00.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 00:56:32 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 0AB565A0044; Wed, 12 Mar 2025 10:56:32 +0300 (MSK)
Date: Wed, 12 Mar 2025 10:56:31 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V3a 17/18] posix-timers: Provide a mechanism to allocate
 a given timer ID
Message-ID: <Z9E-L1pvl1j_4E3f@grain>
References: <20250308155501.391430556@linutronix.de>
 <20250308155624.526740902@linutronix.de>
 <Z9CsstMf-EVZpsiH@pavilion.home>
 <87msdrz0i9.ffs@tglx>
 <87jz8vz0en.ffs@tglx>
 <Z9C6GpaB9WvNzvJS@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9C6GpaB9WvNzvJS@pavilion.home>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Tue, Mar 11, 2025 at 11:32:58PM +0100, Frederic Weisbecker wrote:
...
> > 
> > Recreating two timers with IDs 1000000 and 2000000 takes 1.5 seconds with
> > the create/delete method. With the prctl() it takes 3 microseconds.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

One thing which just popped up in my head -- this interface may be used not
only by criu but any application which wants to create timer with specified
id (hell know why, but whatever). As far as I understand we don't provide
an interface to _read_ this property, don't we? Thus criu will restore such
application which already has this bit set incorrectly.

	Cyrill

