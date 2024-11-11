Return-Path: <linux-kernel+bounces-404542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C859C44EA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4791F2214C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2951A76CC;
	Mon, 11 Nov 2024 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJXtp39l"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DA6450EE
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 18:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731349544; cv=none; b=hTrMFkDRExdjlAN4Er7XTcbn/6ADkGYEm1VWlcfL6BzTjevrgF4IaLVH3In0cMilVrdvzv3g1dif3kd8ynIg9jzVtRlvbzZlvd3HvJIo60Chelb8u0/BRCgQNQN2oHmQCrF8g2qA+Bfy7ng9O9nAUDRdiGWlaq0TB7Vgxny258s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731349544; c=relaxed/simple;
	bh=XSdIb/2EOCgN7HCMEwphquecmgO/cFXowPlkDf1i3uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXaRNZfkWhiDNgD9q+pBcLV80X10GvV8NwxM7URJ8SkYmPsXheeJcviGfTRJoZW33yHpcQqJVKinKEEN+QL550alWzScAK3wgujxwrpA6HTyGISgjTpVrQhAhzrCxdmud+b7tkwC0a8JtO4w44l9ytBkuqkw5ZullQTPDcNe+TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJXtp39l; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c8b557f91so51619195ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 10:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731349542; x=1731954342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vT6+cn/CwO7PkXOoQQ+UP4WR4C3xsUaYci1Y0e19t/E=;
        b=UJXtp39l3AGU0uHd6xOPOFfYkeGu39DezisipeOxq3HSw2+KUmh4FDcLtm3lm9aKig
         cFh+Vcin7CPIitLbz7KPyEvPTv01Cw/Ky80pmMD08s/RBsaBseREMy3uZf9j5PMwLD5U
         ny03GZ0ggZt6mUMetkljP+AREUkpPiOBLda3xNpx+ZbDcxp81l6BHjgLFwsXurHDst4/
         KGSnfPbszSgZwl345t8B+jQqP9a4nxidpEO3ImmaD00rxOgYqdUI5zWBza5YdPIm1jes
         qnDhhtIwuJjsr3A0ODfXmlnZOkjndsjripmQatUzxxMq5UDNdxZOw5W9LyHqtZk0Ggsx
         EODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731349542; x=1731954342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vT6+cn/CwO7PkXOoQQ+UP4WR4C3xsUaYci1Y0e19t/E=;
        b=JxIZhfC+sr1HhzqJs43NDwy1xZc/E8VjVtdobVQDoc2N3c37EQpp1CTTmwkDkLpzds
         QV3KuEc6Z5GPhz+x1UOu7/1nWzCLCWKWZQWnMZ1t4NNApKe+Nl0nKI+KJ3ZFmYGLieXa
         CDhHMuqdrdi9ftxNuolmWO8k9k1A8veoEw4Si7qEq1qu/7VHPZgOZMqpFoWEVoEyxpSV
         N/+mYuSm2fPmi6hGFrcOXDMEq7LKZelxGGlksp0E+mFgg4+eS/pyvNAPgOVIErVfBc4G
         ntfxyaUdA3OPWT7kM/UnM63+1lwIFMuVe5EfnYBEwxmVMfIT3az674Rxn7hpXx6C3Bs3
         C+ug==
X-Gm-Message-State: AOJu0Ywa3MXjnp/DiBa0OnQTbwajOGbD3UComtTlmNzoYY2ltuq/ja9G
	qLxebab5gsRFzY39Hz/g8OmyD0rGaV4okcF48JlfxFwsSzYR0nC+
X-Google-Smtp-Source: AGHT+IGk0FxI9pFas46pgRdxkFcmDyebua6WmOmOQJ3zZpcdkmj+er6i4ZlDXAe6brnZnTwk+jEC0Q==
X-Received: by 2002:a17:902:d508:b0:210:f6ba:a8c9 with SMTP id d9443c01a7336-21183c8cc59mr200651005ad.17.1731349542291;
        Mon, 11 Nov 2024 10:25:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a55bf2asm10982753a91.31.2024.11.11.10.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 10:25:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 11 Nov 2024 10:25:39 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.12-rc7
Message-ID: <5c173a84-5c64-4706-82c6-e3ef4bab984f@roeck-us.net>
References: <CAHk-=wiWK-GCmFGNqknDZzWMZM-u58tmP=jZ9ooTo9b8NURvgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiWK-GCmFGNqknDZzWMZM-u58tmP=jZ9ooTo9b8NURvgQ@mail.gmail.com>

On Sun, Nov 10, 2024 at 02:34:05PM -0800, Linus Torvalds wrote:
> No big surprises, and I think everything is on track for a final 6.12
> release next weekend.
> 
> We've got the usual random driver updates (with gpu and networking
> dominating - no surprises there either). The arch updates are mostly
> devicetree fixes, and we have some filesystem fixes (bcachefs, btrfs,
> nfs,  smb).
> 
> Some core mm changes, mostly around error handling corner cases.
> 
> Please give this some final "kick the tires" love,
> 

Looks good here.

Build results:
	total: 158 pass: 158 fail: 0
Qemu test results:
	total: 549 pass: 549 fail: 0
Unit test results:
	pass: 472307 fail: 0

That is with several additional unit tests enabled, and there are no
patches left in my 'fixes' branch.

Guenter

