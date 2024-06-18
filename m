Return-Path: <linux-kernel+bounces-219139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC0C90CA57
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8151C20AA9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E79713C3E0;
	Tue, 18 Jun 2024 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KVKkqEa4"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F027345B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718710174; cv=none; b=Fk0TZfVBm3yJ2jP0zE8JseaATVRlSzPwYf4oS9cc+e2b99hux/v5fzTw3NGvDxLbTInSXbuGHX29+E29zl2rB6bVit9hR63mP4wgVa4/orJdnmGc8w0oCQAz9OhH3nx5gICT1GYprD+vqxfSiu3HC/NWi14HSZP3DT5jyY0/rgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718710174; c=relaxed/simple;
	bh=iuEULfPROOq35x4NJJBV+yCPhPHR5vJ/r0TJ1Y7Ddqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=garXVYm822/cD0LP2gF5USkpShsHPjooETIxvH3cgMIeHb/ZB0wp1NdBsgv6O28pkgD0h+WAvJey4SgY2oNjkc+QSxZ1BMsflHzLLAJ03aP2ca4yd87LD8OO6vC20vSE53DKZIl8XyArdM4Q734Po43XVAib94Lm8dyx1eMlzW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KVKkqEa4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-421820fc26dso41951035e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718710171; x=1719314971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LMN0lHQUNyyOEnjzsdgQkhnJZTG/+fjhGRlDTiJfS7c=;
        b=KVKkqEa4CNufsvvXJyMepaFUCBUV8Xhzv8YMVUvN0dZT6FjuVH/oBZeWoboNaHyokU
         rvggGBOsMI+c3NUXlSj791BpqvYj1pCxYdgalPEMrHRdZ4dxxwRn7gQf690KjeFZFqqd
         y4hevRP3+tRxzeWkJJhGYbP7q1UJdSqHBvY6JHSw5w6OlE29+i7hAodHImUnoOGJHc2V
         G3IdQVq7+0ZHApa/N2QD/BfyudCE2ilfKAjDS5ujfJhp+6ROGehhZEChPE5noKMb0wt/
         FZcpuY0N0Kp1Sgks+wRska+0tmwEQPdtXDOnoE8JWAavNTrqNxAe6BhksDzUvlkR62kY
         4s9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718710171; x=1719314971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMN0lHQUNyyOEnjzsdgQkhnJZTG/+fjhGRlDTiJfS7c=;
        b=TdCkjSUmZ0iH1aJgC89A7NIazqwE3vf9enKRLuv9UG5+Bz2tdELEeW4E/RxG1tS5ve
         zh+tVRxU/vwBb98hzsr0UjRHpMbuP3w8xUTfBLbRo+S6JwFxgKBDwZs5oda7CGH21Rw4
         CA7DufE5s7moKLjqdb0A+L6ia14qbMzpDOd6ehyh8++lu9oVaQWzhTmd1+EZttkYC9ca
         Geagms2Ow2O9eGHiCUyxQ77izs67xI/ybZScxQVSu7mE4sTz9otNxq3bYes/YLrWQFtM
         5gkPfIc4seTeqEykEqXDVYEzz17l5A27FYB617LYjNJQBCq56Le3iq+Q7dFJb9ChRt5d
         U5HA==
X-Forwarded-Encrypted: i=1; AJvYcCWRHpfymPGiPsmZ7QAjZQhkahlAQ/uv4G+kuZx+M3OWjPrOo9brwCPuhNr+aRuWXE9t4yjawUIOu5rOAhJ4HJGW0N+VOjA39uUr1eMY
X-Gm-Message-State: AOJu0Yyn3t8sJjHYCtxUSenvgUpEklMKzeYF9mt6EXLiVwLGeo2VNZKl
	Yjg+iS5afElN4J3ZFUFWLHGPa2mk1SUfCvASYdcIrNZuIrt/WXRbEFnDoQgZ/Nk=
X-Google-Smtp-Source: AGHT+IFoBVbibxFBBRP54qGNL9pP3/CQPvxT/7VhUR/rxCcQy+D7ZmiytRE9jrev+pRfTnGMTjwNNg==
X-Received: by 2002:a05:600c:b43:b0:421:8e64:5f36 with SMTP id 5b1f17b1804b1-42304820d7cmr90339155e9.14.1718710170852;
        Tue, 18 Jun 2024 04:29:30 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e74c7sm222347045e9.47.2024.06.18.04.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 04:29:30 -0700 (PDT)
Date: Tue, 18 Jun 2024 12:29:29 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jason Wessel <jason.wessel@windriver.com>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/13] kdb: Separate out "mdr" handling
Message-ID: <20240618112929.GC11330@aspen.lan>
References: <20240618003546.4144638-1-dianders@chromium.org>
 <20240617173426.5.I2d17f61d496641d28c778be587b36d138a211e50@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617173426.5.I2d17f61d496641d28c778be587b36d138a211e50@changeid>

On Mon, Jun 17, 2024 at 05:34:39PM -0700, Douglas Anderson wrote:
> Though the "mdr" has a similar purpose to the other "md" commands in
> that they all display memory, the actual code to implement it has
> almost nothing in common with the rest of the commands. Separate
> things out.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  kernel/debug/kdb/kdb_main.c | 65 ++++++++++++++++++-------------------
>  1 file changed, 31 insertions(+), 34 deletions(-)
>
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 74db5c0cc5ad..c013b014a7d3 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -1480,23 +1480,42 @@ int kdb_main_loop(kdb_reason_t reason, kdb_reason_t reason2, int error,
>  /*
>   * kdb_mdr - This function implements the guts of the 'mdr', memory

This is out of date (this function no longer implements the guts... it
just implements the whole thing).

With that change (and just to remind myself for next time):
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


>   * read command.
> - *	mdr  <addr arg>,<byte count>
> - * Inputs:
> - *	addr	Start address
> - *	count	Number of bytes
> - * Returns:
> - *	Always 0.  Any errors are detected and printed by kdb_getarea.
> + *	mdr  <addr arg> <byte count>
>   */
> -static int kdb_mdr(unsigned long addr, unsigned int count)
> +static int kdb_mdr(int argc, const char **argv)
>  {
> +	static unsigned long addr;
> +	static unsigned long count;
>  	unsigned char c;
> -	while (count--) {
> +	unsigned long i;
> +	int diag;
> +
> +	/*
> +	 * Parse args. The only valid options are argc == 2 (both address and
> +	 * byte_count provided) and argc == 0 ("repeat" AKA continue previous
> +	 * display).
> +	 */
> +	if (argc == 2) {
> +		int nextarg = 1;
> +
> +		diag = kdbgetaddrarg(argc, argv, &nextarg, &addr);
> +		if (diag)
> +			return diag;
> +		diag = kdbgetularg(argv[nextarg], &count);
> +		if (diag)
> +			return diag;
> +	} else if (argc != 0) {
> +		return KDB_ARGCOUNT;
> +	}
> +
> +	for (i = 0; i < count; i++) {
>  		if (kdb_getarea(c, addr))
>  			return 0;
>  		kdb_printf("%02x", c);
>  		addr++;
>  	}
>  	kdb_printf("\n");
> +
>  	return 0;
>  }
>
> @@ -1582,7 +1601,6 @@ static int kdb_md(int argc, const char **argv)
>  	bool symbolic = false;
>  	bool valid = false;
>  	bool phys = false;
> -	bool raw = false;
>
>  	kdbgetintenv("MDCOUNT", &mdcount);
>  	kdbgetintenv("RADIX", &radix);
> @@ -1591,12 +1609,7 @@ static int kdb_md(int argc, const char **argv)
>  	/* Assume 'md <addr>' and start with environment values */
>  	repeat = mdcount * 16 / bytesperword;
>
> -	if (strcmp(argv[0], "mdr") == 0) {
> -		if (argc == 2 || (argc == 0 && last_addr != 0))
> -			valid = raw = true;
> -		else
> -			return KDB_ARGCOUNT;
> -	} else if (isdigit(argv[0][2])) {
> +	if (isdigit(argv[0][2])) {
>  		bytesperword = (int)(argv[0][2] - '0');
>  		if (bytesperword == 0) {
>  			bytesperword = last_bytesperword;
> @@ -1631,10 +1644,7 @@ static int kdb_md(int argc, const char **argv)
>  		radix = last_radix;
>  		bytesperword = last_bytesperword;
>  		repeat = last_repeat;
> -		if (raw)
> -			mdcount = repeat;
> -		else
> -			mdcount = ((repeat * bytesperword) + 15) / 16;
> +		mdcount = ((repeat * bytesperword) + 15) / 16;
>  	}
>
>  	if (argc) {
> @@ -1650,10 +1660,7 @@ static int kdb_md(int argc, const char **argv)
>  			diag = kdbgetularg(argv[nextarg], &val);
>  			if (!diag) {
>  				mdcount = (int) val;
> -				if (raw)
> -					repeat = mdcount;
> -				else
> -					repeat = mdcount * 16 / bytesperword;
> +				repeat = mdcount * 16 / bytesperword;
>  			}
>  		}
>  		if (argc >= nextarg+1) {
> @@ -1663,16 +1670,6 @@ static int kdb_md(int argc, const char **argv)
>  		}
>  	}
>
> -	if (strcmp(argv[0], "mdr") == 0) {
> -		int ret;
> -		last_addr = addr;
> -		ret = kdb_mdr(addr, mdcount);
> -		last_addr += mdcount;
> -		last_repeat = mdcount;
> -		last_bytesperword = bytesperword; // to make REPEAT happy
> -		return ret;
> -	}
> -
>  	switch (radix) {
>  	case 10:
>  		fmtchar = 'd';
> @@ -2680,7 +2677,7 @@ static kdbtab_t maintab[] = {
>  		.flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
>  	},
>  	{	.name = "mdr",
> -		.func = kdb_md,
> +		.func = kdb_mdr,
>  		.usage = "<vaddr> <bytes>",
>  		.help = "Display RAM as a stream of raw bytes",
>  		.flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
> --
> 2.45.2.627.g7a2c4fd464-goog
>

