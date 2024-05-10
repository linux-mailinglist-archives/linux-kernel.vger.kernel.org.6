Return-Path: <linux-kernel+bounces-176062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9408C297C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 19:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052C51F22C54
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFF2219E2;
	Fri, 10 May 2024 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ssdy8x/g"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC92199B9
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715363089; cv=none; b=bOK6I7lgIKXziVNLXxNCXkxdNx6sXcR1ERauAD80mkyVhwm0JROaueQeQYT6C7ivlG54ZqM9XfOF22BnFp76Dpj/Ov4qzglfS2Je8OrQZsLSXUrqU+JgmoLiOzeNwvID7hm1UfI4MHeK82roODbC167A6qkppl7Tj2uPCyArIEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715363089; c=relaxed/simple;
	bh=xJmMGpijLVbfzV1aLbCyIFqmqtVghhRlL3fIAx0Zf3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msh/reZiJnbw6pFE2juCwUhJlxw7W3KJlYv8ap0zGsgiwmp4e6XwC5ZCmfqa6Hsx6fyDYwpDz4Ao4U7Yry597mu2uOb4PKJuqBuo9E+HNxdlD0msgliDnW6JGoY5yqQUFrIbI2MuVV9wrYlrwT4oMumKIfHnI+gHqlD0gHvO64A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ssdy8x/g; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5f80aa2d4a3so1980313a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 10:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715363087; x=1715967887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L57+zK9MzVoCupg09U6DhX9rKCFQrUW4lM5mF0fCgNY=;
        b=Ssdy8x/gu3v6owk4cRKjS558k6DX65Wm05p8vmbUS80yA1nhMtBEJKTlXakydU7iv4
         jz8AfO4nTvtwcQQHM5EqSaU/QOgxMSGVsoDmr4ZGk5pIburKLY11uAn84+0OKXfb5nef
         O8XA4bl+7ytiI5z8A35fyK64yuLYpUa3igqEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715363087; x=1715967887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L57+zK9MzVoCupg09U6DhX9rKCFQrUW4lM5mF0fCgNY=;
        b=ABwgw7fkqXm0NLxtbpuOY7SwEkIMM2VI3emUWetjZSUb8Nug/m9K1jSRkf+XnsDo4o
         Jfp4hgGQNV3df18gh4dFEyXxHm9tbD6t4wxp4Lw4aGOmAry6l0hzvq+wAPgPnjRoPQ0+
         kHIJH1R5m93ybftSlzbNECB/ewPKuGYvTC5CDqaHrnr3I7yA+VRku48HmS9Whipp37pg
         2uAaEfiWvBI6Vuqem7FhoVZDARglcrZBjcgunw6VlgNpmzrXJzsyilGkfyCLzL7SNX7o
         D/57heevlIKCSIq7m3gBt0i9w6O/vjDD2SL1dLLb13e1y+rEMUrwHmgaK1CQPw/gWk2I
         vn5g==
X-Forwarded-Encrypted: i=1; AJvYcCVT26hsIZyjxkP3w2aBkLywO6MA1c/TgTGbdjdQ4LbtFXTrosRimyIDI06LzFdNOjkt60xEqP9AWwhp++m8QGCSzzygo1hPgln+GCpG
X-Gm-Message-State: AOJu0Yy6FlsQFrQZSRrB98ETT0mEazu7KjTK8uCSVGfafznHakg7HJh0
	tHQWu7pWbELghyjFxOzYgYrOPBZ4cCEn+rzKos/WqAQL+KBDkp0WV78Mu3RGLQ==
X-Google-Smtp-Source: AGHT+IES457OerJ6E+sjpYxMiTqrSeTP8IOKWgMKTpX1LuCp+KnQ+g1iaESf6bNjK6mubIK/EdZwFw==
X-Received: by 2002:a17:90b:46c4:b0:2b1:817d:982b with SMTP id 98e67ed59e1d1-2b6cc777f3cmr3358191a91.14.1715363086792;
        Fri, 10 May 2024 10:44:46 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ca53cesm5360572a91.44.2024.05.10.10.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 10:44:45 -0700 (PDT)
Date: Fri, 10 May 2024 10:44:44 -0700
From: Kees Cook <keescook@chromium.org>
To: Edward Liaw <edliaw@google.com>
Cc: shuah@kernel.org, =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@android.com, linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
	bpf@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 13/66] selftests/exec: Drop duplicate -D_GNU_SOURCE
Message-ID: <202405101044.5D2742EC@keescook>
References: <20240510000842.410729-1-edliaw@google.com>
 <20240510000842.410729-14-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510000842.410729-14-edliaw@google.com>

On Fri, May 10, 2024 at 12:06:30AM +0000, Edward Liaw wrote:
> -D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.
> 
> Signed-off-by: Edward Liaw <edliaw@google.com>

Thanks!

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

