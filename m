Return-Path: <linux-kernel+bounces-566370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 775ABA676FA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D173D3B8207
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BFA20F08E;
	Tue, 18 Mar 2025 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXjVjP3R"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A88420E6FC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309522; cv=none; b=BMPdNrebAXS4gN8w867PyT44dGAazPgFoQZjEBV1GR68pKcQ/jJc7t5UcMigT44AWHFbSjec0WGsBZzAjgfo9HUKvOCc3cIdR8kxu7u92qbD53zbZqp6sQ4ERzsXiZ1eAorfLmxtXLFh3xkEslojPTmma4JSCQRPEREx01kLAto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309522; c=relaxed/simple;
	bh=93t4KyxAcUwbpTxvRYd/L3yrVfyxbH9hPjYa6eD1Myw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyFbj6AG0OgLirwFBRcyBgzPOxmeIWCDsAln6msgRqfXx/9BSsMSx73cD86Tfu/vKhb5KLJzsXtErvgBGrDz+YgxCOEG4zKaKqlB7ro5IKIrJrJjJrdqu6llcrQMh9KIY2dpY6RfBlk0jQfnEQ6PdtpWQvFIxf2BNDjUwZq+vUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXjVjP3R; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so16583175e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742309519; x=1742914319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kmZFMU52ggHv/uxQXlUIKSkNor6eZqTTV/Z26Ntqf5U=;
        b=bXjVjP3RrDFQws7d3+6ogoGwKndKVKvfLjJCdEm5EHlPscWf7VP+IPU+NIEqmU0JQB
         8aBtQzhZrzpKU/TA8M1ljeHs+dn+UPvpCXFIPc3DxiNNuKftNYxWSCWRPLxAZGVtgsrn
         knxvtSjyPVet3yiM1R0PCH7Xhfm9nV+G0dsszTgr/7HMXupIMG+kwBG33tVhcWTkVFJL
         2QCGAZVcDyJ5E837mFv62kga8BwzwrJ6Cd00Gc0+I77uRt0W65OcCaHDCg7gSpT3CtEE
         O7gIUzBJ5P1uf/UcpuKrzNgeQnY8aOCgTjIUytY6Wn07x5JYgLkwTc+jM3B0LIJLSDXA
         oQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742309519; x=1742914319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmZFMU52ggHv/uxQXlUIKSkNor6eZqTTV/Z26Ntqf5U=;
        b=KjKsMVZCMUe5n8cf88SWuY2mm0GawosxIdzOirYa047b6vjQzd5ZyShFVLsUIf+Cyr
         NKVwEbWXQDuqBCvYsKiRgXDOCX2+7qfYm/RGeShW3YLDPlrtt62zWRrGrHc6pXIsDCY+
         K2a6dU2Hsku9u9f0NIBFoINQnGawaRY6NJWQqed63L+gZv6hm5m/MDkhcj+EmHcbmL7+
         2uuU+E+p3UPO19Djwq9/ls9TZ4Kwd3CDDgE0oIp0JEVPZ9FFKfaU3M2B/QvfZq/RA0vn
         K+lVnPIxZXvUE8MjreuzGkjWYHs/3c+KnPmBIz1bEdJyfLmSDK/Pah/oY7vZJoWp8gS+
         a/Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXOKPpjTlMdKQhs0ZFkyawxTcox5SuOy7HGKnyu2nlKq2DEP7C2uRojP0IfB/SOfEAXzpIMRZrEeC3Tcl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ZYDMxAEhfBpCdWcFAN4Jc4ID7G1bl2I0ULNKHEB2zmin9ngW
	hvVCokSB8w4KxhwnyUr0H12W63Cnom/+/BQ2/QjGVsXSpnkOMwza
X-Gm-Gg: ASbGncum9m0QAPMDpoGlHmBvyR9iI2zzk+6kxpfURtLKOsXPPHMuHcwT8QGJ6iWiANT
	FazK9OLKFdSOaeJBiLn4xBiMW6RDQ3I81+nSswlgJ792yOMhJIyonL8JavvkC9x/W7w2ZxtuSo9
	Gw+ReAXEfleNUtn4dzZwR3OMBfq5WlA0PR2EDSSVkrchiGW3syIdxSwA0JZvnLYQWwdbE4d/xxv
	lOKO1d/m5XQlWLXZWsU3V4lUG9RJDvhsYIHDGpof+1mnHUA8Y9VVbm7ex7RWlRTUxrzBW1E9+kA
	ugEW0EYu+THgjumvUxzNsurbb2BYFcuvpl2SaAP1OobTULc=
X-Google-Smtp-Source: AGHT+IGxWW2bln7EbsKSCI2v/veWnprS2ogGfQvgu/+i0PWPhdsfLcc2mml+LBsDf+xF/aKKiMurmQ==
X-Received: by 2002:a05:600c:6dcc:b0:43d:a90:9f1 with SMTP id 5b1f17b1804b1-43d3b9502d5mr18784485e9.6.1742309518667;
        Tue, 18 Mar 2025 07:51:58 -0700 (PDT)
Received: from qasdev.system ([2a02:c7c:6696:8300:c99:9d6f:1130:510f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d200fac7asm138937955e9.28.2025.03.18.07.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:51:58 -0700 (PDT)
Date: Tue, 18 Mar 2025 14:51:49 +0000
From: Qasim Ijaz <qasdev00@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: miquel.raynal@bootlin.com, Frank.Li@nxp.com,
	alexandre.belloni@bootlin.com, linux-i3c@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] i3c: master: svc: Fix i3c_master_get_free_addr
 return check
Message-ID: <Z9mIUc6Ln59umJtT@qasdev.system>
References: <20250310023304.2335792-1-yschu@nuvoton.com>
 <174225158210.1593610.10018812780731849409.b4-ty@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174225158210.1593610.10018812780731849409.b4-ty@bootlin.com>

On Mon, Mar 17, 2025 at 11:46:29PM +0100, Alexandre Belloni wrote:
> On Mon, 10 Mar 2025 10:33:04 +0800, Stanley Chu wrote:
> > The return value of i3c_master_get_free_addr is assigned to a variable
> > with wrong type, so it can't be negative. Use a signed integer for the
> > return value. If the value is negative, break the process and propagate
> > the error code.
> > 
> > This commit also fixes the uninitialized symbol 'dyn_addr', reported
> > by Smatch static checker.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] i3c: master: svc: Fix i3c_master_get_free_addr return check
>       https://git.kernel.org/abelloni/c/d6cb667b8e15
> 
> Best regards,
> 
> -- 
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

Hi Alexandre,

I sent a fix for this issue on the 9th March, which is before the patch
Stanley sent which was sent on the 10th March.

You can view my orignal patch here:

https://lore.kernel.org/all/20250309164314.15039-1-qasdev00@gmail.com/

Thanks
Qasim
> 
> -- 
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

