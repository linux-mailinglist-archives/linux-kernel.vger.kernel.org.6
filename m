Return-Path: <linux-kernel+bounces-243450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5BF929643
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 03:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3676D1C20BA6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 01:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DC61C01;
	Sun,  7 Jul 2024 01:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QrDkk5me"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC397EF
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 01:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720315917; cv=none; b=qBl24mMataqOKhbjIH4rFMp6UdVnffGJOAAa+McgtAYR+L7a2xvXbPl79yiMrH0PnmXSbxuXIxUop56C//G+seEMRACZXp2VYGOjGeY/PG7IJ3gPOhgLjzVungT0K2GtnsbI7ftODNS0PqNqoLWVAcRKSkml4Vw5KeG/xq9X8ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720315917; c=relaxed/simple;
	bh=G4JdRp9bs01DKUZilKJmQu5/ImqW8pJU4ROeKR7HNsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NK0i8MPwO28GkiPLLX2RY2hEm9AG0eAnRwYEIpB1xmHxU3Vxm6elUfFrMG09NHFmaj01T9I8Fj8ocO5pRj+lF5E4Mz5pLXd7Qjj4UrOwXv03aSn6++raLM8L6bh7wu/CF9dszPtvxq+CUyF9fUaJfVr0odVzJhjBwhr14JSb1b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QrDkk5me; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6e7e23b42c3so1410936a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 18:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720315915; x=1720920715; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sbVm5UwrtqTvMlaGCWHB4VKMW3RBZkYIJveewL1hVMU=;
        b=QrDkk5me8JbOY7vJTmtGOq4nhcjEEtWxbTT675FeWfT/DxJlORlupdY5Svr2mo+ZU3
         Pwp0todgItrgpFMnp/DSoeyh0uLi9+s32N1mgukhw1mTV3eB1V1QuWLgH33RbRJn4A71
         V+GUJlMiO/iZN0X+0acjHEmPvtf/s+bxJWzt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720315915; x=1720920715;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sbVm5UwrtqTvMlaGCWHB4VKMW3RBZkYIJveewL1hVMU=;
        b=oRA06qbyaXG7P0c9mM0RzZsBFFIOPdjnvqq6M0DQvWEEEPYzGFlEUxBJNzfXdGAUmT
         MuhxnManQhO18Lc7TBVjKiP9aLrg7uCsZ9PF1BKojsJOl0LBlosuU4EBW+AtTxN/2Qxj
         R2hXtGQqVms8/TTx2S+/Jx5BJQV/XEfiYY6BL1oL6CtlHlopdxaYh+niYdWScbIWZExl
         lMCcUvDbqx/uYcyMOnzlm8Hb650UMIRXnL9Gr7FVQouO49/gZQG6ZGUnrtEokBJPewtC
         BIdkCSZaLm88DWOa2CUFM/AX6jAocnqYJ1dsyR5OlIoQmBxxhus6mAJkkHE7l6mIDkv0
         WdTw==
X-Forwarded-Encrypted: i=1; AJvYcCWj9+EOp8vz6XuJU6uwpd0r+eYVfgbpymzhRrrhR2wQHvxx8C3W/DPrzwHuOJz5kyziceLna/uLa+WZJ3T0pJUsQV9RuJhU/GKuBo2Q
X-Gm-Message-State: AOJu0Yw7r1nd2fz+fDG/jNDdTzivLKBk7x9kYALq4h4p2L0U4Ae7kxK5
	u4EwrU80VOqKZBZuzr5cc1w/il0aZMe/LooSYyuBMaTnQZhFWb49tZ4zfO8T8g==
X-Google-Smtp-Source: AGHT+IF1FDOQGMv9nEIlsztrrNgG8YqP76eLWLboMUmuHr6tciFvrw9DHatgwlhGof1KUoEyxoveUw==
X-Received: by 2002:a05:6a20:8401:b0:1be:ccea:41ea with SMTP id adf61e73a8af0-1c0cc8baaf5mr8307705637.49.1720315914937;
        Sat, 06 Jul 2024 18:31:54 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:88a7:e7d7:713d:ff09])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1599d4fsm162225625ad.264.2024.07.06.18.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 18:31:54 -0700 (PDT)
Date: Sun, 7 Jul 2024 10:31:51 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 04/23] zram: introduce custom comp backends API
Message-ID: <20240707013151.GB244190@google.com>
References: <20240706045641.631961-1-senozhatsky@chromium.org>
 <20240706045641.631961-5-senozhatsky@chromium.org>
 <8fe873d4-b9c4-47ad-b779-e1012677011e@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fe873d4-b9c4-47ad-b779-e1012677011e@t-8ch.de>

On (24/07/06 09:50), Thomas Weißschuh wrote:
> >  /* dynamic per-device compression frontend */
> >  struct zcomp {
> >  	struct zcomp_strm __percpu *stream;
> > -	const char *name;
> > +	struct zcomp_ops *ops;
>
> If this is "const struct zcomp_ops *ops" then all the backend struct
> zcomp_ops definitions could be constified, improving security.

I guess I can do that.

