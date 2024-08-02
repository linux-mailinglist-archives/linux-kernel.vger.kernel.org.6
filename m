Return-Path: <linux-kernel+bounces-273146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF249464EF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6C8AB224A2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C026A325;
	Fri,  2 Aug 2024 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eCmQCS56"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0416249634
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633592; cv=none; b=QOYU4noM4yakLjnJkqFCG/d/r6HlxQdn93V9uJ7kKrxZngPW4POg3peCOkwpRCDKCQ+/ywc16An55yHA3SZRZjL6CEZfx1wyC+iw0JPz2XRCijeU/+DjZTIYd45cCLX3HJNR+W199kkV8IJL2MDIYctoXoOcN/B8Uc2F7M+BqXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633592; c=relaxed/simple;
	bh=BdKM1YAh6SbXNwlF9dZikTa3D/XtN/zpoQ8J0VV2zG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rd8ey6W+C6qyuzqBaS1GEph08UGaq2ZaQtDqsgS71TLwnigF/5WocjIQfhvQKwaDxqMfBCrY0leiSz4TtATxC6MZi0nIWM6CwvTG162ALIFsavp5Mte5TESpj3iaeoR6AH1o+/fk3ShQNIpq87TTwTxLjbmfweFy7qCtxoSKRNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eCmQCS56; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso6417625a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 14:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722633590; x=1723238390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vT6rtMiXe3cVV93nXqn9P1Cf/ISdlIhsVzPvH7Eul+E=;
        b=eCmQCS56+d0w2CV58+vDDUuhZHJEaR+mFpfJSJ3+i8+E4dV/Gbw0mc2yKNBW8wFpko
         TPlwVLBepOyqzd8BSWa6axS4MEcoL2jisu7U+1EqNoROJqg80Ijxet2P4on4H4Tp2MFZ
         WcUqsfPFKxc0S4cHu3nWeZkyL1UI3kSl+9oDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722633590; x=1723238390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vT6rtMiXe3cVV93nXqn9P1Cf/ISdlIhsVzPvH7Eul+E=;
        b=bJvM46nOx/vJh1/Zvw8kLpRf2zdkNy+4kyLWP8HEcMuvYrSZ0puF1l3dcIZ/WMzSf8
         3OpEhXuZN4xxqZ+KuNpLcC0A2UQmMpUOs2NngQ6/omIEnbrPU/SRl4qJqkl+7j12AgAt
         8g5ppsoxs0yh9l/eLiEeM9YVDn9X/IQAugSRLZurfnYJpMvGTZcIE+3MR+ghUW7VziJk
         Ek4WdD5Gx4MG/GfpzOJAU5oH0aps+Eu3dNL6/jfpXI0nyM5yHP0Y5PhOlsUWaTomZM4v
         0O15wY+WP4koQYDHBIqCLXikAWTOhDd/rk0qgpoM5YdBQtH2Ari4/8niw4+0r0plwYSt
         ZW5w==
X-Gm-Message-State: AOJu0Ywb6CtyWVUvOVf3Mwq0jYko9hXrs68f7hAdNz6VAHCE1R+apxg/
	KLna28z+LCG7cFacfQNlvqhk9cVdb97oZDoiLx4x87UnlzNTwgvxqrcehELcQw==
X-Google-Smtp-Source: AGHT+IFTYF2Do8vdPQ58bSKEPsVr4yMiIg3mBK2cU+kX+qNSL5VkCcGfb7nKSyPN1XIST90Jc3L+cA==
X-Received: by 2002:a17:90b:489:b0:2c9:6a2d:b116 with SMTP id 98e67ed59e1d1-2cff940e469mr5948292a91.7.1722633590238;
        Fri, 02 Aug 2024 14:19:50 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:ac3b:d38d:edce:bf32])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2cffb091391sm2228821a91.18.2024.08.02.14.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 14:19:49 -0700 (PDT)
Date: Fri, 2 Aug 2024 14:19:48 -0700
From: Brian Norris <briannorris@chromium.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>, llvm@lists.linux.dev,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 3/4] cpumask: Switch from inline to __always_inline
Message-ID: <Zq1NdFXhN3IoYm3M@google.com>
References: <20240719005127.2449328-1-briannorris@chromium.org>
 <20240719005127.2449328-3-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719005127.2449328-3-briannorris@chromium.org>

On Thu, Jul 18, 2024 at 05:50:39PM -0700, Brian Norris wrote:
> On recent (v6.6+) builds with Clang (based on Clang 18.0.0) and certain
> configurations [0], I'm finding that (lack of) inlining decisions may
> lead to section mismatch warnings like the following:
> 
>   WARNING: modpost: vmlinux.o: section mismatch in reference:
>   cpumask_andnot (section: .text) ->
>   cpuhp_bringup_cpus_parallel.tmp_mask (section: .init.data) ERROR:
>   modpost: Section mismatches detected.
...

Hi Yury,

I'm wondering if you've had a chance to look at this latest series. I
believe I refactored it the way you recommended.

Regards,
Brian

