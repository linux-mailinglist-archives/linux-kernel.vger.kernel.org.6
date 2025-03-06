Return-Path: <linux-kernel+bounces-548170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B28CA54117
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 04:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCEDA188EBC4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 03:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70E6192D9A;
	Thu,  6 Mar 2025 03:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IqsLn+Tj"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707A9192D86
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 03:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741230829; cv=none; b=FDuDmzlMbwIcj8Y0t+FU6RTsbstKMUyeK5mLZbKX2ZUlv9XHtKCbrBiksix2TosxHWBLLjx0+2EK6HTaGGyhv2NTPCVzCBC1dm8GAliWua5mPNazGoZo7P8l7WxIgQ438z1gaS7qBqNdHQW8ERE4kjdJfncF1FDQjumYsv+M3+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741230829; c=relaxed/simple;
	bh=oZj2gcVqtx107nGAwDgWw/kXoOh4Lwz/K/smzUH9Qtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGtRQfO78cyPI+mW90i+xLcMAsAiyEbvWpp+eGOnqvNFJHohjOO1SMTVqB0qP38udf3GDbtnUQkHlLNi3ZCYdWdK24LdPAit1bsfCaFy5gGConpAEd339RUlRRXFoMYpfismBtXI9s+23D4VoFyRvC2cGtS7Asv/z7fEXx0g7Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IqsLn+Tj; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2feb9078888so445390a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 19:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741230826; x=1741835626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I5RD/anlchtvUN+J2asseqeoYe9S0VGBCfqERf+0yHQ=;
        b=IqsLn+TjnzVO9kfZQU8c/t0LkueDvnHhFA5o5hi5QjDFgOsVhtPDWOeJnF+UQ+3qn5
         bjuSZYL+PQ3BuI3b65Lz6RijP6n6wFzRfe7RcZSVM4M78Mh+Lev/cnd91IEmB+xazFWY
         QFLWaefEEiIlmpHQIsWt5BvEH8hY5v/kb3n+e0dxz2J/5LHk2isr9of7b3NyXCAx77eI
         CTcFWdAv7GFiMgq6z8joYcQbLSu0x0svPsyJ3DSFEJqiYzo/YnpMYBidl6cWaSzydByG
         d5xGw+BINq0PDd2uZ5SFeye1/q4Yh4gOGYd5C30ZhM7nPCN1yhc+YGmeyGadYt3NMw2V
         upKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741230826; x=1741835626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5RD/anlchtvUN+J2asseqeoYe9S0VGBCfqERf+0yHQ=;
        b=nDa0Dt/YoxorwIaCstXTIL4JH+phvqZXZTkMDLmnP+JXIaJ178EUm+ldnMNiMdXrne
         BCN+zdHUCxYeIMqqSXowuhdQbLJCCiXGtrLVE0ej6u5Bv7G23wZNzTuLScfrEVX3wNWg
         CaGKrnTRGCLZr7LgJzsSeQQb8qgQJDsuMVNdODKDr8HxWWkqa2ICitbxNcrZx9PxpApR
         1TteflP59pmPrkklA4nItTTEYCWXN95Xe4DudZrUDHn7BDMvjS8UXTON3ggt3VuT72vi
         Uwez+oE4cjDxqWvfXxKjIXtGJDBW5OWlQdLhhJGS2Gj1pqSY2gbO+0Tmv18+d/imly/o
         Zsog==
X-Forwarded-Encrypted: i=1; AJvYcCUWuaobQXaf49jnnWxQXlIpo8SIfFS0vD3IYipEIFpSl5mBj2l36fcIDLf4C0BFjjxIAl+0OejwhIchhJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq+h+GEeoGdCHXb/Uz1FtoDQbLZgiNt1U39GZQ8r3/Ymlx/GmR
	lGHdvg64+Y73U25dlDzZf1FV3vewUq8/lGU15JlrMZhdm6nISxQ7gkCj+YYDGXU=
X-Gm-Gg: ASbGncs+uwkivoKrnCq+AmBWzWcqbyeyh2ZxNP1SUDdjqnZgqsI6Me/4Je+72K1daJV
	++2s+m82fQQ29/JF2UmbVVTLWYHPoC4TIs5/Lw//luadHcKyQUCrHygJmx2pNerJ29v8vOohCrb
	hnxXEzLE6Mb7YG/ae3AfXIBK1QvhDlZnppN+qfuJ9WmzyX6/BIodGtoOfJp/PpX6LJfdkOR0ejR
	+Yxxx0d6+lbrVn9yFXr3kjg5yUiJGWkDmTI671OGTbE69UVpCTG8i02JxRrzSTP6KhqmxMm+HpS
	z+yb62Rjy6qT2SdXCtnAPIWaMw2Qzc5ctaeheiMi
X-Google-Smtp-Source: AGHT+IFAnj1sMagzrkHZedECAW3Sn3VCCOpRuX3Fuszd2qUqpa+SE+imKpqY6qvecbaMRMlKdEZ8Rg==
X-Received: by 2002:a05:6a21:7881:b0:1ee:ef0b:7bf7 with SMTP id adf61e73a8af0-1f3494d8caamr9973803637.19.1741230825737;
        Wed, 05 Mar 2025 19:13:45 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:9b3c:3246:a388:fe44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698538818sm202152b3a.178.2025.03.05.19.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 19:13:45 -0800 (PST)
Date: Wed, 5 Mar 2025 19:13:43 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: corbet@lwn.net, acme@redhat.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] docs: Correct installation instruction
Message-ID: <Z8kS5yd4znhULlSY@ghost>
References: <20250306030708.8133-1-richard120310@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306030708.8133-1-richard120310@gmail.com>

On Thu, Mar 06, 2025 at 11:07:08AM +0800, I Hsin Cheng wrote:
> Ammend missing "install" operation keyword after "apt-get", and fix
> "build-essentials" to "build-essential".
> 
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

> ---
>  Documentation/admin-guide/workload-tracing.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/workload-tracing.rst b/Documentation/admin-guide/workload-tracing.rst
> index 6be38c1b9c5b..d6313890ee41 100644
> --- a/Documentation/admin-guide/workload-tracing.rst
> +++ b/Documentation/admin-guide/workload-tracing.rst
> @@ -82,7 +82,7 @@ Install tools to build Linux kernel and tools in kernel repository.
>  scripts/ver_linux is a good way to check if your system already has
>  the necessary tools::
>  
> -  sudo apt-get build-essentials flex bison yacc
> +  sudo apt-get install build-essential flex bison yacc
>    sudo apt install libelf-dev systemtap-sdt-dev libslang2-dev libperl-dev libdw-dev
>  
>  cscope is a good tool to browse kernel sources. Let's install it now::
> -- 
> 2.43.0
> 

