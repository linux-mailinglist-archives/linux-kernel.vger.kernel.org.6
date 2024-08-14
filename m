Return-Path: <linux-kernel+bounces-287030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E97A9521DB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 20:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB339287E24
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4511BD510;
	Wed, 14 Aug 2024 18:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kiLQx9WG"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9271BD4E2
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 18:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723659183; cv=none; b=Hlnf0wBx4SE3UGSzmBrtp6bMs5QuWQ/msxzNyxZijVC8jMG3cGIQuDcKuq+Bd/dQp8ep3eOYOaEXzg9WuWSa0BsZMSNxUjGgrWNgE9pv0SrZFxlrgXpzrlQMEK2kruzhC6W/NhjfiEGdlFeY2kaoa/pvoKcg1mPekkwAXjDvLtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723659183; c=relaxed/simple;
	bh=YI5N+mtJ/H+BnmIBb2YDCx4YaQZcZE045gxSMKjZwpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyuKoyYtmQoB9EDFmIKV6gCYtDp3SlEoWiPXYtX5pfGhmqSu8oF6o5u/OkT27zm64SuWzV2QKU8Tr69cUGAzXItUYVP4/k05AvwqEiiytQDw6BwfaCWwHQ1K8FabJLblmy4zZSaenfBRBGq6/PoJwX5no/ixsh7U1Tqr9aaN1k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kiLQx9WG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428119da952so612065e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723659180; x=1724263980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YQK4WIFJlg0Pr3bgPWFxyO1pMRbjS6HS/s5fZNGBJFI=;
        b=kiLQx9WG3yNdW5+TTje9dLgJk/phU8DHvr2BohfRLaTwjdgn+QJ0I/kUKFdKaXiW1B
         +cv6uvXfL2URlOEEb/Gszpx9/YIEIOKrfBkEx2u0DiJ0sKHpX4vUebfyrOa/TXnIq1ta
         5nFnoHFsuKEZdJ0h/1D00yRoimghB3x6jwlgnYAvcgmtwhIVrH+Th4poowq9AMNOz9ag
         7MHGBjuzRWaH9RA4qwkUgG4iaiTj9zhOftY3MrUsbZyo3MgKQeC0EXC9FBnLSx47aw49
         KMPUTxYIgJrLS72Rd/xXLOTITgQ5VJtbS9ssHW3S4aWcDrp6uW8FzXV7USsE4r1kSDkK
         i8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723659180; x=1724263980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQK4WIFJlg0Pr3bgPWFxyO1pMRbjS6HS/s5fZNGBJFI=;
        b=Uvap/l3IUah851zIlZXb4CXS66ksYv4BaUOcOHV17RXE384trLKEWPFJ8bijmguJWi
         ToIdnZuRx/Pzp+2C28B71cU5PeMWKcBuVEQeJmrUe9vrqoXF49QwFqPDU53OdPXW90jx
         QO3OwkHxkM7p+3vD+4z1xq71MjIF6weYNrueliHJ1TPdwsfEg9r5qJoNCbD/rGBLr5+g
         CL7h6jAoxp0tGSSWQyK0UajFEB1JzwpeE95s8wodRe6pejLjfhQhQTDgzBZl46Eaw0hg
         RGRpfSbUNRl+z5yR8yO8r1xHVZldIZHUy+j3A4sjHA+l8qJl8o/BmoSMFda5inQLRNJp
         WeLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXEgpB/f9vDoVSDGhfqXejqdzf1yGgCxPA/CBZ73kvRAJia9F2dj+SjJ7YVTwyE9E98Xqw4qydjetxZO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+S6LfETRCEP4OCSeDBFUTXnUcJ6sNCFcZ6EeJReaGt0x4t8PH
	hUM7WDZYVEW7PXwcHDYg+uWCSIwlLsUOcvRx8bJ7+TTTYAOHspVApP6jo82tvW4vfLz3bZMXpqx
	q
X-Google-Smtp-Source: AGHT+IEOjDl/BhuqBsL5bqiwHpll0ReohyKa3GDN2uua1LW4Bqs1iUfsJncFiEThEd6hW0yeN/pgNg==
X-Received: by 2002:a05:600c:4593:b0:426:5dd0:a1ee with SMTP id 5b1f17b1804b1-429dd22f3c0mr28925845e9.2.1723659180036;
        Wed, 14 Aug 2024 11:13:00 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded3d4d9sm27292645e9.27.2024.08.14.11.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 11:12:59 -0700 (PDT)
Date: Wed, 14 Aug 2024 21:12:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Enno Onneken <ennoonneken@outlook.de>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] reboot: add missing break to switch statement for
 LINUX_REBOOT_CMD_HALT
Message-ID: <7bb6e1c5-8ab3-4d1f-9e34-d231f0684572@stanley.mountain>
References: <FRZP193MB2563F43FFC350926C0B7EEB1DC872@FRZP193MB2563.EURP193.PROD.OUTLOOK.COM>
 <750452a3-ac8a-4af5-849f-3db83158a1e5@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <750452a3-ac8a-4af5-849f-3db83158a1e5@stanley.mountain>

Please don't drop the lists from the CC.

To be honest, I wouldn't bother with this patch but lots of people send lots of
patches that I probably wouldn't send and I send patches that they wouldn't
send.

If you want to resend it that's fine, but the commit message should say
something like, "The break statement isn't required for after a do_exit() call,
because it is a __noreturn function.  However, other do_exit() paths in this
switch() statement have a break statement so it looks weird.  Let's make this
consistent.  This change has no effect on runtime."

regards,
dan carpenter


