Return-Path: <linux-kernel+bounces-563624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5640A64588
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E82E07A406F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9B521ABA6;
	Mon, 17 Mar 2025 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vt29bOSL"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4ED18C03A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742200314; cv=none; b=FSDpzaX9LrxK7DAbRDLwk0+B8mSmm+m3M0iNUCMwvK4zL9OAnxvQBZVbtgXC6oF0O8J/Dku/NY5lxTebxeRLKZlJ+U2wp8AyNbb2x9jL0sI21PtEA8K9VshAEuxbJ5IGqoSA+qMYzexJWAwHopDbWiHh7t0Aso+Yd5o9JihDaC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742200314; c=relaxed/simple;
	bh=4vfa2nbOoNw6ZazHPFyQUz4LY0q33gkHH2PnpcGUm3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxTa8mfa9zS2CbsD9LEQTMOSqfVw+y86HaaVXlorh5F/daAvIg4lB7VnIc/MEvJ1vjPmP8YzCIXmIuAKlDxg9RiA1wsLFZcy5eTLALn7U9sAzhba5rZfmPkk44hGJXuCHkUUIg/5r/wd15R8FTH8sqo5Usc3tSWwvdiaTN8Tl8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vt29bOSL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4393ee912e1so68595e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 01:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742200311; x=1742805111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ts/iSgo7uroCJrlhqFf9mwkUABh0eKE3Qcf3xl8ptu8=;
        b=Vt29bOSLqlGQXkOI1Hq24YlRfPr4IMCvq+8ZKFfuObGF4L/GkUnTg0vOU7bbzNV1ny
         juhMLPyVQcTWYmBjqbK50Ac6v5ZzQt0kby8xqyub+qDYl9+tbxl08u8KJPyCIrOsXXpN
         MW168xjtFPYYNgnINAZdVEIzNVuuVowfuru5Mc55Q1IiwgzHLL/BoarsJEaZqpF69l11
         yDmBwAjGvhgJSupYg5xn7JsEbF+JWCXjXTcx1iCB6Osdw9AeNCjq8nKD5PEr2WoS9li5
         lfkhwYp4G0D8h2r+K82kwh5MNHd+TkL77oNNS0MxiBSc0HZdhPh1QUuU2Juk6lRx40s8
         xH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742200311; x=1742805111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ts/iSgo7uroCJrlhqFf9mwkUABh0eKE3Qcf3xl8ptu8=;
        b=nW1fppCmLuDV9bD3hTKCB8f2W6RFBpj8c+DXODrXMWSPYMPvcC3S0RYV1fesUMmj9y
         ET7J+BBIXJM4veq8al6s5/BLvr3LNz4TxOUbeUOm5TpDW+bU64pmJNs4+a/rw9lTiRZn
         tloetofUbH773mJ4H2MFoVwb5yLRPMLsoyIxW1OHQxZCHeAqpNlX4f4pwvnQ96R3mYfA
         6SlcSFf6RzvY0aJmthdmPKEKBbyOFkIrjKoZIo+jW0WlI4i2t1dQNkMxkbLsSEz4DNZj
         cNWE1wXTOfAwPrn2ph+4iPqpmtu3Um0ic8n7g2+Ls1vmHO19KVD+Y4oVsmNqtGwraC5S
         CPCg==
X-Forwarded-Encrypted: i=1; AJvYcCVFlsFJx2n+bl0YwGHMc7I2Ar9fyzHD1m2MgS+F7QjaoK2xidkZDiAoKxjU6CH6F6godZvfSaM9vSJqKB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTenTU/k3ifZQe1PkRntuxsBJBaDMyFKxBzcnpc5x+OFMD2v5o
	tgDpHNYy0bYOA4TGPSh5SnXcQHshCkNZqKYlAUeIBMa1fEksevoja4OpG7XjRg==
X-Gm-Gg: ASbGncvkgZwbRAqlEcGdUkyn3WBSae43ymjroqp8T8DwHKhDxvlnuuxgti2hmEjiuAc
	0hjNgioPZbnV3Qq5STsquE2YGCqdjAMwPRNdKeIpQw28faa3kPYhAkh/5WN4I+QkupJua0lKn0s
	prh5EYODIccmDTfW+tnBaWGG9XN+dNXAuoVX0gHpVdbgGGtco8XnmZJ9cRQNRARkYHkvQKS5KKk
	j6WFqbA/68m6nM3VHuf/RfizhwGBmBAd+AY7aK4u270DMwb6dhBgmXu8qkeG4ubjJIntHUPFu+2
	dF2cRSocGNl2XcKXm9dYCaI6aT//8qRmCD7VV4/aFE2tk0ProifCZtsoK+QQGemEwA0UoDgGuWP
	uG5UF+BE=
X-Google-Smtp-Source: AGHT+IFsKXe3JR+ofIJ7M32FHsFHp1kz09RRhdQuWukTEEKLv1/hhyNOKe55+KjtAhpwBNlpPmDcaQ==
X-Received: by 2002:a05:600c:3b20:b0:43b:bf3f:9664 with SMTP id 5b1f17b1804b1-43d25bbee13mr2337835e9.5.1742200311269;
        Mon, 17 Mar 2025 01:31:51 -0700 (PDT)
Received: from google.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7ebbc3sm14092661f8f.88.2025.03.17.01.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 01:31:50 -0700 (PDT)
Date: Mon, 17 Mar 2025 08:31:47 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 03/13] objtool: Improve __noreturn annotation warning
Message-ID: <Z9fd82KugPxoGaRS@google.com>
References: <cover.1741975349.git.jpoimboe@kernel.org>
 <ab835a35d00bacf8aff0b56257df93f14fdd8224.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab835a35d00bacf8aff0b56257df93f14fdd8224.1741975349.git.jpoimboe@kernel.org>

On Fri, Mar 14, 2025 at 12:29:01PM -0700, Josh Poimboeuf wrote:
> Clarify what needs to be done to resolve the missing __noreturn warning.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  tools/objtool/Documentation/objtool.txt | 12 +++++-------
>  tools/objtool/check.c                   |  2 +-
>  2 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
> index 7c3ee959b63c..87950a7aaa17 100644
> --- a/tools/objtool/Documentation/objtool.txt
> +++ b/tools/objtool/Documentation/objtool.txt
> @@ -319,14 +319,12 @@ the objtool maintainers.
>     a just a bad person, you can tell objtool to ignore it.  See the
>     "Adding exceptions" section below.
>  
> -   If it's not actually in a callable function (e.g. kernel entry code),
> -   change ENDPROC to END.

Did you mean to delete that?

