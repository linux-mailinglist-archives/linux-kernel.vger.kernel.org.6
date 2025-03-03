Return-Path: <linux-kernel+bounces-542699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB52BA4CC9C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D7818922EA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B66232386;
	Mon,  3 Mar 2025 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMMsssRI"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0771A0BD0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 20:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741033287; cv=none; b=ZwPRjOaSRVcbTEA+JFD1vzTEePCm8fuWuL22IC5ysZyV9tZhPsNo26XFGiFH/fOvg+DcYTAHUblWB0YbPw1FKfgelZ2pC/PIYGQu4kP747+S+KMLhqyNPYySPydAbjVQK7F7DjavWZH0i5L5zpx3wXCYNbdZ58xskfe9MAECBDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741033287; c=relaxed/simple;
	bh=M5hy+IApsnvR3gs4wBc2MP60XCf6kA1zDwYtmzuSj78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IN2n0AnHusrJ4V4o3MNIqrczg65vKE6y6yxa7NwHCN5v7qsu3zgQMGoSBRRtrAoRPGzoM1VlLcpqm/TXK0jlfN0Yc2iMhYazwXl1VypRKL/gea5HbqLrNEXlYRYwOCHngoixBqSX+TkZvaNxeYV0liObfUWpJaL0OT+/Z2scsRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMMsssRI; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30761be8fa8so52904341fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 12:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741033284; x=1741638084; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNaT9RgM/Y+mWe5v8mtBaRRNnlVFcx+nN2Sm8KBcodA=;
        b=SMMsssRIGJi/aHbPYJ2ZqMOO0UZ2pe2SJB5ShhU2Pw3RcONYQGVmJkLijZIHmFsX2Q
         VgIz4vls3FiPPlDJbKVQXQJlrT8WvcljP2vq4UoPu235fvHpJYEDMo3lbT+weONMeeha
         Sle2mL4gt6x0JcU7e1nNKHZmFkLGQz2ZGuL8uZnWAyLHwn4dVKz0VQkH+VevqAN/EbCJ
         I8iNM/eLslUA+MHkOmNCclo7Sl2FEBdg9dg8kf83E5tg4J17G4+mZlwssr//ckZfy7tB
         kN+yKnBCFg2dgPDaP7ZIQd5N2wEh/iQtR8dtpeuJxJxz2Xs+w3rGSConn+bzFaMP+6PH
         jubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741033284; x=1741638084;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNaT9RgM/Y+mWe5v8mtBaRRNnlVFcx+nN2Sm8KBcodA=;
        b=ZXH+1h0YCBk0iWPlHNiulnDreqYigLlQZv4PpdV81eANgpg4KpatnzGWlAiU69cU/H
         DelDfsAFPffAfcAyuKO9n30KaZ8yToi50/AgBsKMjS/uB36zti8zqbeHagV5377lzKUw
         Ub/9By05qckPm8hs1Q41K1Uvq7u0FkVUl9FA4FKdCodwu/xpMI4NqYtrQjffarFHP4HC
         E37vRUKjAMkjJFeh/YK8p/EZJYN2ZFoH334EAX+Vgcvdf9DOhTpuKQzOnM5defRgEXl4
         y7GQUDg9A6s1/NtomRgTwd4BJAM1Vn6ZmRjwSULNcR2Q+PZyShUODNJwVCBZwjCx6A5l
         RlXw==
X-Gm-Message-State: AOJu0Yx1VReqhuJZP10O1JitKftmzGFuFpKq92aevAeBx7RjPc4ZP4vn
	xci5cXOJR9QAKVwtsDslSiI3D7yUNbyU8qHk/zp8b6RGemkFjDgf3bBDpVNP
X-Gm-Gg: ASbGnct72Z5xlpPv86qItzWUcaTrQvPskVOXWEik72U4387cfxb/eldt73GZjuNJNVg
	TpKty68+1rTbGdwo6luQTBhZngi9A5/FuXzQ3mT8mCqVeLzBMbIYq87npFQMsYXR3Nl6rSJzxJU
	JssBvEV+1Y9BdNwS66lpMDlj1Aw2rCM4TAWL9JOT2RIlfIoADiF5h8kvCB0oEmku4J9sBfzAeAa
	ztmC9IgRswLaTFeB8Le8QLsq/0AiXvpPgB8pcDJRIBeuCSScefzzcmqEC3hQbi52yWtRmqeuEqF
	Ysb1NpLcJynp41i5nEENdeZAHC6KiP6a/Cr7AXjhSLohmA==
X-Google-Smtp-Source: AGHT+IHRXtFpyR+1ZeuVf4D2S57cBQL117ip6e+subQEqweiTigEq0BD5vOxsWWvXwIJVkAH/LvGJQ==
X-Received: by 2002:a05:651c:2211:b0:30b:ad3f:50a9 with SMTP id 38308e7fff4ca-30bad3f52a9mr34272511fa.22.1741033283649;
        Mon, 03 Mar 2025 12:21:23 -0800 (PST)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30bc4fe7fdasm2459291fa.97.2025.03.03.12.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 12:21:23 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 818A15A0136; Mon, 03 Mar 2025 23:21:22 +0300 (MSK)
Date: Mon, 3 Mar 2025 23:21:22 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 10/17] posix-timers: Make
 signal_struct::next_posix_timer_id an atomic_t
Message-ID: <Z8YPQn0UpxucZLJP@grain>
References: <20250302185753.311903554@linutronix.de>
 <20250302193627.543399558@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302193627.543399558@linutronix.de>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Sun, Mar 02, 2025 at 08:36:59PM +0100, Thomas Gleixner wrote:
>  static int posix_timer_add(struct k_itimer *timer)
>  {
...
> +	for (unsigned int cnt = 0; cnt <= INT_MAX; cnt++) {

Hi, Thomas! This moment slightly confusing -- are we allowed to declare
type inside 'for' statement? (c99 allows, just never seen it before inside
the kernel code). Not a big deal though, thanks a huge for fixing this
problem with timers and criu.

	Cyrill

