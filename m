Return-Path: <linux-kernel+bounces-178238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305168C4AE1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 03:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8071C21A71
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 01:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D031879;
	Tue, 14 May 2024 01:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q11ISna/"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EE217EF
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 01:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715650179; cv=none; b=fKJM+B0BIlsVHVPlT0d8hWzYTNVNlf+6aFGpM4QsSDRhAa+gs4BUu8CJ9bVhY8nTXTfOmS2QsaSaFJ1ZrFMen9vpbmnDBhcYexAtuoKV775XolXHIey+9K9IAxtpRQU7WOfxhrOucOXXxTwOJzAO/1O8wA9bplyddgmcceKAeAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715650179; c=relaxed/simple;
	bh=ydzzvUXzzyHYXDB3rdnfrOfaFvankCzu/PpfufEIZ8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXYLnfR8BETidnJUbGiRRh9QN1urDuApC23SDyaBYLJRIk6+FylPuRlLzIrJjv9UVBboKrbIf5VbeNlBLbuTRFzmo8WaNMitpXUb91umV//A3Kt43CWyxq7kyXSu27Vs9F+3uaEN/cARU7yGT8HqjJwvM+9OzRQAg6tjJ5sgGbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q11ISna/; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2b3c711dfd3so3912590a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 18:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715650177; x=1716254977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G12oTJkF8iLsh/4R29i5V3FaUw9E3HvRiqsr9Lc4hks=;
        b=Q11ISna/dGYd0RKqsssggPYEJ09PrCw7rr9dXahPg6UfB972ECTIihuHy5MsNKuDv0
         XsTtJNAnPgHEyy474vIvEb48pfycJ1wt+on7chv472yD7edWkJBJ2Mx/f+w6dcnx/AKw
         VK2sjWba+n4MZ0CnQH9D/B3Q3xbxschvB7Zmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715650177; x=1716254977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G12oTJkF8iLsh/4R29i5V3FaUw9E3HvRiqsr9Lc4hks=;
        b=qjqxuOTqEivuY7afqd8AgHV3BN3VppppDzctGaHf7FxdbfUl0B97ApVx07btAz3NA3
         IhNakdCJLwxkbVKin/0xxwaF7fT3MCb2rtvudkF1OwRsbAg8139+O6w1vyOugRPA/Gtp
         8XBkCBeMy8thjmtzgu31+WOKJirz4M3Tf1LUU73URn+2W0zIkGBRw8vS+4D20YS5KyN+
         bfYGaZ7R3lVGp2uVXUNIbFeAY9pJlt3SHCrumX64RyY4zbNLr1Ym/g2k8/W+ZQaMoxXu
         URQWIPiWuoCbZESLdWIDl5N/T6EW/eWMJf5wx9mJr2y6fg+r1PO3Ir34AoLf43YeDB5f
         cE/w==
X-Forwarded-Encrypted: i=1; AJvYcCVKbDZts3cwXPJC/agWDrlU9+fwMwYbh/fXt5OUsn/UhPoqVo4zhBH3H3n5tkLRBRI9miJBC/45Nbunu+P9rwd21I60qevHB96fHB/4
X-Gm-Message-State: AOJu0YxIZwsuAO2a8kH43h4m81VHmdm2sSEg5993oYrz46uVGqfdTnBm
	q1gsEmjkC3rMsbgPiPhFHoZA3Y/uHq/qT7S+Qa6twgcsXM4LJwbaHaxNRkusYyjI4G4e3xf1oR4
	=
X-Google-Smtp-Source: AGHT+IFEJye/Z8WAoZs9+YbGZcRqMhUSZmFn6dkSlu0jABBG8huBwOzQtMUM1ErHVjwk6NyoQ170SA==
X-Received: by 2002:a17:90b:3a85:b0:2b2:c85f:aa0b with SMTP id 98e67ed59e1d1-2b6ccfed296mr9212935a91.42.1715650176932;
        Mon, 13 May 2024 18:29:36 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ca53b8sm10361200a91.45.2024.05.13.18.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 18:29:36 -0700 (PDT)
Date: Mon, 13 May 2024 18:29:35 -0700
From: Kees Cook <keescook@chromium.org>
To: Bill Wendling <morbo@google.com>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-hardening@vger.kernel.org,
	clang-built-linux <llvm@lists.linux.dev>
Subject: Re: [PATCH] hpfs: Annotate struct hpfs_dirent with __counted_by
Message-ID: <202405131828.9CD8E5A@keescook>
References: <CAGG=3QW4b9mqh9oGQ16NmMGbo4HVHmdM00Be1Qk97StCpW4xTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=3QW4b9mqh9oGQ16NmMGbo4HVHmdM00Be1Qk97StCpW4xTA@mail.gmail.com>

On Mon, May 13, 2024 at 04:45:54PM -0700, Bill Wendling wrote:
> Prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time checking
> via CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
> (for strcpy/memcpy-family functions).
> 
> Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
>  fs/hpfs/hpfs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/hpfs/hpfs.h b/fs/hpfs/hpfs.h
> index 281dec8f636b..ac137787f1f9 100644
> --- a/fs/hpfs/hpfs.h
> +++ b/fs/hpfs/hpfs.h
> @@ -357,7 +357,7 @@ struct hpfs_dirent {
>    u8 ix; /* code page index (of filename), see
>      struct code_page_data */
>    u8 namelen; /* file name length */
> -  u8 name[]; /* file name */
> +  u8 name[] __counted_by(namelen); /* file name */
>    /* dnode_secno down;   btree down pointer, if present,
>         follows name on next word boundary, or maybe it
>     precedes next dirent, which is on a word boundary. */

Looking through struct hpfs_dirent::name uses, I think everything checks
out. I do see some confusing manipulations in hpfs_add_de(), though. I
*think* it'll be okay, though.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

