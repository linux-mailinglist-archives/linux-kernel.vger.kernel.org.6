Return-Path: <linux-kernel+bounces-219752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CDB90D8F4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1280EB31CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A938061C;
	Tue, 18 Jun 2024 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SgqKOl8J"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2C96F30C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724383; cv=none; b=AjNVlaDxCh3D415otkdAetX4T1VQfCObdYfFIkvQE1vKl9I2KfbLWVB3dqWOYapF4Z/EQOArSdTSM7DTWbQZ324a3LBRnRKzLmW0K5jvWybuFRegvlvZF1PmDl12aGG4Kpm6DSnCaTzM29MaAkvf5qyNDetwVWUwsdnCyoVLJNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724383; c=relaxed/simple;
	bh=CurE6Dkz9pV9+txAi+R7t+xa0vDbGQMbECnR1uv+xKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmAxRbYTCp+dmAG+l6KPeoZxDsHNJJvVIx5l/gC9gWY0W1aWbzrrYqemfy5fW3yJVJvNZ66yCet550nr23vgEZbhZVdkufkhCz3gz+u3n1ElIigxErsnuk7YwvNo2bnINNLq8+++ezaCIEP2TE19a8Wr32/qRaDeEubPTUe1cbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SgqKOl8J; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-361785bfa71so353393f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718724380; x=1719329180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j5B2trNpXh5L0I47RQYjAXwFGQO0vFRPcG1PhQTg8CE=;
        b=SgqKOl8J1EwJIh74OiILD3lhfJ5JSWVFg31vL+6ZqHyUOaUN67LNKvcvl3n5vFCAJT
         y61koQH7HXik7MItRsosYs6nUtkONFurKqdtOszO+5bIn9jsusx4ISWy4kHrTVEuH6KX
         kafVs5ox0yjjyC6vzmMzr5Oj59GWUkGecljcl8OS/rA/2fH7zyFOkXpQxCIuCV+tVfZv
         z3ItV6GmDvm6ljQQGWK2d7zMOsAm9Ty8voZ7AY1EFg8OQLibRKQll7JsRaDlQhS+TeEF
         6093Dn3dB8gBKU07evKVS2+sOPg7/sdM0eLPWNLy8aM4fWZYra0+5NA0i0pMDnbekHwY
         YgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718724380; x=1719329180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5B2trNpXh5L0I47RQYjAXwFGQO0vFRPcG1PhQTg8CE=;
        b=Z3DfyWH2wD9mxSvNF24EOCVvKKF/+LwR3hIkCNiXW+opJljB8uonDcjHEylXnUGN23
         VoCOwCnR1p3FISUoCBf5vVusIFu0IjSTYWS1Si4aR9ENBT3MYxqNDhZSsGBchfQO01/I
         GjDt1Sokb4sOqQpTxaesz2GO9mAqxr2vOAS9RoZ768rh86qCzR3EFJMDTuXhdk3FiGzZ
         F0u3nUhJEFvZNwbHRGqzDTTOp8YKUsR3+UgzobE4wrJRxeK1wblB4bHAaNSs8Tp5Ao/d
         FeFt2oTsqHS7Vo6FoBXdxBJdmaIe+98sS2zat91i+EM1evcsAc3QzUdlLIgb5GLjNw2d
         vY3w==
X-Forwarded-Encrypted: i=1; AJvYcCWJ/uK7H7Fu741jKAGTXmz3238ddS9qgSUkXPh5vph79JfLVlZb+UxWPJbzx+2ndT49g1spjzhWkwaKLdtpMXg8jbD4j866DdMH/BzM
X-Gm-Message-State: AOJu0YzIlKoJZYM+rOcMKanWvHg6KSder9Je7T4RCWU0knu+kVCc+vEs
	mXycCJTslSMa5RllJZIo8ypbXJo34Q1GKPBUcl4iIxUeImejLI+6L3C2oDXoXZI=
X-Google-Smtp-Source: AGHT+IFko0ZVQHKPPOkLVKQkbHGo/8Z4TkJ5VFh493yXuyA4aG+1zvplXZXGK68vb6yBbrYE7fPF8g==
X-Received: by 2002:a5d:5917:0:b0:360:7c13:761e with SMTP id ffacd0b85a97d-3607c137725mr10358113f8f.65.1718724379686;
        Tue, 18 Jun 2024 08:26:19 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36268ad16b6sm1097771f8f.92.2024.06.18.08.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 08:26:19 -0700 (PDT)
Date: Tue, 18 Jun 2024 16:26:17 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jason Wessel <jason.wessel@windriver.com>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/13] kdb: Use 'unsigned int' in kdb_md() where
 appropriate
Message-ID: <20240618152617.GF11330@aspen.lan>
References: <20240618003546.4144638-1-dianders@chromium.org>
 <20240617173426.9.I95a99321878631c9ed6a520feba65b949f948529@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617173426.9.I95a99321878631c9ed6a520feba65b949f948529@changeid>

On Mon, Jun 17, 2024 at 05:34:43PM -0700, Douglas Anderson wrote:
> Several of the integers in kdb_md() should be marked unsigned. Mark
> them as such. When doing this, we need to add an explicit cast to the
> address masking or it ends up getting truncated down to "int" size.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  kernel/debug/kdb/kdb_main.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index fcd5292351a7..c064ff093670 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -1594,8 +1594,8 @@ static void kdb_md_line(const char *fmtstr, unsigned long addr,
>  static int kdb_md(int argc, const char **argv)
>  {
>  	static unsigned long last_addr;
> -	static int last_radix, last_bytesperword, last_repeat;
> -	int radix = 16, mdcount = 8, bytesperword = KDB_WORD_SIZE, repeat = 0;
> +	static unsigned int last_radix, last_bytesperword, last_repeat;
> +	unsigned int radix = 16, mdcount = 8, bytesperword = KDB_WORD_SIZE, repeat = 0;
>  	char fmtchar, fmtstr[64];
>  	unsigned long addr;
>  	unsigned long word;
> @@ -1722,11 +1722,11 @@ static int kdb_md(int argc, const char **argv)
>
>  	/* Round address down modulo BYTESPERWORD */
>
> -	addr &= ~(bytesperword-1);
> +	addr &= ~((unsigned long)bytesperword - 1);

I think the round_down() macro will take care of the cast for you (and
probably render the comment pointless too).

Other than that it looks like a good change.


Daniel.

