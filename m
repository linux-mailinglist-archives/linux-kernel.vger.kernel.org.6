Return-Path: <linux-kernel+bounces-406946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A99439C6682
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 02:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 959F7B23A77
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 01:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BB414A84;
	Wed, 13 Nov 2024 01:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBDugLE0"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627192309AC;
	Wed, 13 Nov 2024 01:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731460599; cv=none; b=Dz5x58opWG0XXwh5b8CKY9QrkLJBUowaT0XcAREWiqz3RKREn0UsPKyHOQbsRhRH+TKfN548iYnTsJ1M4S0ayLPvpZ7D8G8Dgj9q2/01xXIAyNrG+aLpUKk73OVhGgiTKpmUVav/j6PAhbzLSDL7V7F/Q9iQeft+wdTFam5Kz+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731460599; c=relaxed/simple;
	bh=FmZqa6woVTYIKFBuVqy+nvUShJWTq/0RdUO/NHkLOiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEfMTMVP9YWdIjfllaRdEYOOGC5Dl0+zOLxE2FtgV1k94w8Lb1oMABwKzkoM974rCds+foOl64I8xuXd++qzFG/3o9R37gtkl7SuVcx1QPKy8wC5VEGgd89fOVugOIY6LX4kmMNQ6R3YsXryXTqGv86c/IjaPzawNdV3EH4gGto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBDugLE0; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b150dc7bc0so440692885a.1;
        Tue, 12 Nov 2024 17:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731460597; x=1732065397; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7q3DDbKVAus+N5tvow0q5HKxDltItzretugBPQSfYX0=;
        b=PBDugLE0OhZcG0NHfcPN1LFpmA5Wd+Dwg7g7QGqKwsWCoEWzn1U2ubCxcAMCp84UbE
         QUsQfz8XzgA5eovr6GoMgU5LqjjohnXpbEbkhXrXy2xj1IGHYHCauuiQPuoII6q4jT7z
         DZNpsGg+tNN9k8W5vIyXjg5oF6THMWS/jFycUWdlAiYwE/vD4N816LStRS3Zsp48/BKn
         Y5SXPUqIwIJNcu6Z/kn84f8NBZJbwv6jMO0N+XNTcjNX0bSXiDUpHsgw6Cfq0yeAykxR
         kgQoENhDpyPeAlEIfK4ksx1ddAmUj63A9nFeNMwGTA3/F9JsmjZo0hhFziG69s1HQopl
         SEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731460597; x=1732065397;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7q3DDbKVAus+N5tvow0q5HKxDltItzretugBPQSfYX0=;
        b=KyjxVD6FFJoIOax++hOWtqaHq8tn1hJET+y+obNZCrvNLtOqgB3BEMgK/6emyKl6l0
         RWUKMeo9q03BpVsiejFQKpoc2aAAhPKNyWhJjPc4UyIpLjd7UGxxWqKrz/2mkx7KLn2+
         p4X4vI0nvFHVjFWWvypVqykG+SxIURKfoVAR0u+GbaOwhXbpcw0NoBMuxUWB6xD7ZFwG
         XruMDOq6EwJxs7C1VsXXgKlOFB/L98RrF9yUJBQVjyfcbNRobKsy6Q9IV2XoDGFVoO7G
         TXPFlqpccEZTtCYja3t0hLJoCdcWtGb9lFSmNQEwlfGcPM1Eoe8dsLZ5FrVBDHm5kPUg
         hiWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMOmASs8zN75iuOscmtsBDRJz31z1ZnTQkN9PBuqn3WLv2LRfacj44GUdIKFIKwIp2sNnyo51YVQ2Yd/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtLS6rqOX2IPHRuFxwT1S4c5DF+ApG3y7ClliLd3x7W3DIiNVK
	H8sHkOE0aslOThg+HccupliSRQbilBYf87Mj631CoTWY/QFgzJHt
X-Google-Smtp-Source: AGHT+IGfCqVvMxi06pZSRAGM/3QLh9/cYOD5/M2YyJXgtBHpTLxiaopAKIWI4ZKx4cgHjMybthxWAw==
X-Received: by 2002:a05:620a:2943:b0:7b1:4579:61fa with SMTP id af79cd13be357-7b331f30f83mr2388049585a.55.1731460597262;
        Tue, 12 Nov 2024 17:16:37 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac427cfsm644337585a.30.2024.11.12.17.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 17:16:36 -0800 (PST)
Date: Wed, 13 Nov 2024 09:16:33 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>, 
	Ragavendra <ragavendra.bn@gmail.com>, mturquette@baylibre.com, sboyd@kernel.org, inochiama@outlook.com
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk:sophgo:clk-cv18xx-pll
Message-ID: <ryzruhrgh4cygftrtoig4epyzkg3kgqg4ua5rmadvlylyh5oan@5fjaqecknce4>
References: <20241112225832.3518658-1-ragavendra.bn@gmail.com>
 <MA0P287MB2822EBB6FE58EB4C3BFB7BC7FE5A2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MA0P287MB2822EBB6FE58EB4C3BFB7BC7FE5A2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>

On Wed, Nov 13, 2024 at 08:33:54AM +0800, Chen Wang wrote:
> Pleas improve the patch title and just write "fix..." instead of listing the
> file name changed.
> 
> On 2024/11/13 6:58, Ragavendra wrote:
> > Initializing the val variable of type u32 as it was not initialized.
> > 
> Please add "Fixes" tag here, see
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html.
> > Signed-off-by: Ragavendra Nagraj <ragavendra.bn@gmail.com>
> > ---
> >   drivers/clk/sophgo/clk-cv18xx-pll.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/sophgo/clk-cv18xx-pll.c b/drivers/clk/sophgo/clk-cv18xx-pll.c
> > index 29e24098bf5f..04a0419cab4e 100644
> > --- a/drivers/clk/sophgo/clk-cv18xx-pll.c
> > +++ b/drivers/clk/sophgo/clk-cv18xx-pll.c
> > @@ -87,7 +87,7 @@ static int ipll_find_rate(const struct cv1800_clk_pll_limit *limit,
> >   static int ipll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
> >   {
> > -	u32 val;
> > +	u32 val = 0;
> >   	struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
> >   	return ipll_find_rate(pll->pll_limit, req->best_parent_rate,
> 
> I looked at ipll_find_rate() and found that the parameters "rate"/"value"
> are both input and output parameters, which is really a place that needs to
> be treated with caution.
> 
> Seems this patch change is correct, otherwise the value of "detected" in the
> function will be random after calling ipll_find_rate here.  Actually I
> suggest adding some comments for ipll_find_rate() to emphasize it.
> Otherwise, it is easy to think that "rate" and "value" are only output
> parameters at first glance.
> 

Since ipll_determine_rate does not use "val" in later,
it is OK to not init it. 

> But I raised a question here: In ipll_find_rate(), do we really need to make
> "detected" depend on the value of external input? Inochi, can you please
> comment on this, due to you are the author of this code.
> 

As using the detected value, an extra mask is used
to emit unused field. See macro PLL_COPY_REG.
A more suitable fix may init the "detected" to 0 in the 
ipll/fpll_find_rate to make "value" is output only.

Regards,
Inochi

