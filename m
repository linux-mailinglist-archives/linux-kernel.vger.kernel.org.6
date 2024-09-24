Return-Path: <linux-kernel+bounces-337333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7F99848C7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE12E1C225AF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDD51AB6C0;
	Tue, 24 Sep 2024 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OO/D7jvj"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF141AAE2E
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727192131; cv=none; b=fh5nIax/NUZXw+H2kh6i5bXRLGfjugSnJt+X5i5924YJdSRWr2FXBegHhyYbg2FmtoX233k1xeKioxmMSpkGPzKfHWuWTccTkosmnBfg23sRBSp1+djtOxCw/jXv3ZgafcbzPc6BeUupuMkGNOA4U1gjg/Jf0qYVF1W66GbkIz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727192131; c=relaxed/simple;
	bh=9oXraljCgJmncIczkzC8b/I6XBliaW4OOWquEdQehlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1MRZ7OMv2naLaCI8hEMTicHaeLYCnN7bN+zaVNmvGgO4vfLryJ9kYJ0QbOoILUvoEVEOECEawiETXsVRJeeWtLBP30+PkOQtONafvPCAjOde44cB55ELaNWyXiP3gB8uv+Wa/pYreHUiixxRq+O/3wz9HyAnmdhtF9qU3x8v/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=OO/D7jvj; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c25f01879fso7195718a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727192127; x=1727796927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t1x55u8/wbiYT+Evq+gKxO2ziL9+ftLVFxuXuV1/aLY=;
        b=OO/D7jvjD52XzA56eMSLDbdjV40xl9HvDdIlnPm3TwR7WXi5lKp5CZiSsFbtw5jRYd
         IDCCoMvfOjxc4cGJnehELIsdWA228ksWLdSWseemuCC6UP8UJQ1tSiK18WgiUOlKIGIg
         FzwRatahxp73q2kUvgsWJLj+JLl/Jsg57miBoKUlLgDcz3SBJ++jzGa769fKqLERfhY/
         sOc66iNACk3x8X2ZUclNSZ4xoZcHRtDdEFq3zw4gCErHlpic3b/gxey5cJZbekqZtwfU
         RBGXg9pSnZNkSUyYLSAdgh0sh6a7kZ3X1CnThlOGGimhegX+wV6s/MgYd8AWqz8im8LD
         XHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727192127; x=1727796927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1x55u8/wbiYT+Evq+gKxO2ziL9+ftLVFxuXuV1/aLY=;
        b=JnLcOG7QsxpZ4Dcub1Vnl+KbKpN3RwMCyMIOrrzDxF3pwO57ZQ2v7477uI1rueKcJj
         phRs/VbJf0dHuoTsO/kw/dg2sVNA9aOJWMHXNJ/HzMZREDninoy7lSPHh63a5aemFBRV
         feuG9+4TwhSlV8TJ80izMJAZXxdctKRHDCKmM/N6u5hwT6bZoUqRcjbU3tJlhDjy74kJ
         prUXtUTj/4IzOlRZMbwVFBzYE8Rw48mRCwp5ITOkASASRxOzagoAiMy9nczNZjQacr7L
         DcQyO31E2TrkAelfi9zLdN2o1u45dF/8HkxCSWfIhykTQGVI1chAvm5lXfmDMBFiImZ1
         twZw==
X-Forwarded-Encrypted: i=1; AJvYcCUeYsZV0Oj8RV00Nd5Swj7qlYbtcLlFaxKIUYo4TgSveDozH8Nu6uvYkefmQvezm6Ts0s22INc6qDT+RlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo2n73eJKAMbQLPN/Ktzk/0UFeKpeO4kKebj8M+ROC3WwoaBt5
	wEd6TJr4XHoV8FYVH3YBUMDYhWWIu8bxpMLtFpibjnsFSZdq3qnaFS9SAdfRSsY=
X-Google-Smtp-Source: AGHT+IFFXrP2XviAfUkcRMlJcRsqbCqZF870pQJD+m6daRgki1vAq8sSqhb4YmIhtcqENfUh5aXc8A==
X-Received: by 2002:a17:906:f59f:b0:a86:743a:a716 with SMTP id a640c23a62f3a-a90d511b060mr1654222566b.53.1727192127351;
        Tue, 24 Sep 2024 08:35:27 -0700 (PDT)
Received: from ghost ([185.30.83.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930cafb5sm96637366b.132.2024.09.24.08.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 08:35:26 -0700 (PDT)
Date: Tue, 24 Sep 2024 17:35:24 +0200
From: Charlie Jenkins <charlie@rivosinc.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/xattr: add *at family syscalls to common syscall.tbl
Message-ID: <ZvLcPDyv8Q3gv9e3@ghost>
References: <20240904-xattr_standard_functions-v1-1-60ccfa9d41e0@rivosinc.com>
 <c607a122-ebd7-4da1-96a6-be153258f0f4@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c607a122-ebd7-4da1-96a6-be153258f0f4@app.fastmail.com>

On Wed, Sep 04, 2024 at 07:27:53PM +0000, Arnd Bergmann wrote:
> On Wed, Sep 4, 2024, at 19:03, Charlie Jenkins wrote:
> > Commit 6a7fb6ebe371 ("fs/xattr: add *at family syscalls") didn't add the
> > syscalls to the common scripts/syscall.tbl that was also recently
> > introduced in commit 4fe53bf2ba0a ("syscalls: add generic
> > scripts/syscall.tbl") which a handful of architectures use.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Can this be picked up? It would be nice if the *at family syscalls were
able to be used by architectures that use the common syscall table.

- Charlie


