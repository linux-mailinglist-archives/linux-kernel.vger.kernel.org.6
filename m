Return-Path: <linux-kernel+bounces-301192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB38895ED81
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C16B1C22175
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B65E13D630;
	Mon, 26 Aug 2024 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1D6h97nm"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C66B6F067
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724665148; cv=none; b=TmhXdgA+vFyTkV2cC57rEzl2DaoLwJy9uflH89oqWzMFORXaWsphYdjq9WbxTVfJGD8Tlffli3G6swc5fa3rvFNg7tshtC4F8rZiy2UkzbkDL9B/ys/5gsGjtIGnn8T/2ip20RfoE0Q2C9m/UoCiPHJWEG1rFZAydeLxTa4dJpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724665148; c=relaxed/simple;
	bh=q5NKpvpQmHFhkVuhB1yf1UaD8tdgXAOJImWQRQKU2yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRGFOL20BU2DifwXLc0FgX58SRi/Qk7NVSK9Oga4Gf2Ra5N4YYZm7dfLuY4mJYL7yR38FrKwSx8vcfUwEC54XoSvCOjKvQLDN5P+JqaOq8wjdNYnwS4TzDH2pzyxTY0dxUU4dUuR4p3lBOyycDBs8X7hRpGV6Knt/1Ye+Cf6Hi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=1D6h97nm; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a83562f9be9so360934266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 02:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724665145; x=1725269945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7x/Iy4WGMT/angdlokuIQnh2/Lh8TylG6czBnlIKoXY=;
        b=1D6h97nm5Ehb4XrmamqBRFsGGI4VTACwW5KzkGYoWzxvaeUmHozj6BtajzISbxCpgz
         H/jAgTB0nuveezaz3/Sh6KKHXNHRYhvb94OnDQadgsTBjs8C2kWJE+Nejv8qx38cTBhb
         CF9/ZFB8m8xW8JgXOBtr6jkmu3F/6M1R/gksdDEts1F8jTA+8FHfZ9OkAkfegQmJ3Nja
         ct75JrG6DKKUm1OonPHCoztYMZrlciw85g5ycWeqWUJFAdm69WTyk/woPlV/zXGh5YE9
         IQek1fNvIOsjQbqoGK0nArOw88D27kagz3L7LXzRo4wslz8QBgEKzfP0hI7q7JVAA0DJ
         Y2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724665145; x=1725269945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7x/Iy4WGMT/angdlokuIQnh2/Lh8TylG6czBnlIKoXY=;
        b=j9oxiT+ATmYGNyhv3EXrot7+cDpO5dajonXas0Ru22cuIeUtimlBzEE/txE2RI2unN
         2nMnwPdyoZaqdVcbUwnRS/bh4WOPqmjqouRYSP+BeIOD00BGjCHOeoMw2PSMmOHzvJzd
         tZXjyVZpEOPdyBo8DBK+tO20ysLlbFxno1xpSboQBFZlsVPRU3UEiIb3Y/susw4LvP0l
         0gepfc+rE0DEyOPmd/N4DMqmYfo//IQNPrwM47Ee6h8i3u/rpmCmC4a4z1NsEUIctclN
         s0lybA5YRfK2y+ONGsyzfPVwTOnBIat2e7riyN8Mh3gByDMk33f9bixrz0Fgp8NqLLEO
         yjWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXREq4zvc0AZLUIgonOk9D4mIv+QQ8fLqdGHlkYq1d8PbfCK+pDp0q6h75jxobev6hDFw0g0uG5B55HaKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzNICYc8Rhxn9TJuqKDtL08gYMboX0Jz3C0lf60h7SX2QW7jqs
	emasltOFZFk9gCR339JQCuFEAMOnAcrS4ORrePZLGiqm6AaWmY6oKZFZx42dl3Y=
X-Google-Smtp-Source: AGHT+IFpRjFOKt+B50Fc+4D5fJb5MlFKXArq0SrGZwNTFTrYVvRDghIi0mHC4rGnYSH+FWm20Km7cg==
X-Received: by 2002:a17:907:f702:b0:a86:a3a6:c143 with SMTP id a640c23a62f3a-a86a52c1b29mr619779866b.31.1724665145123;
        Mon, 26 Aug 2024 02:39:05 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4360c0sm640406166b.108.2024.08.26.02.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 02:39:04 -0700 (PDT)
Date: Mon, 26 Aug 2024 11:39:03 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Yan Zhen <yanzhen@vivo.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, trondmy@kernel.org,
	anna@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, neilb@suse.de,
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] net: sunrpc: Fix error checking for
 d_hash_and_lookup()
Message-ID: <ZsxNN-CmxarJi9ns@nanopsycho.orion>
References: <20240826070659.2287801-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826070659.2287801-1-yanzhen@vivo.com>

Mon, Aug 26, 2024 at 09:06:59AM CEST, yanzhen@vivo.com wrote:
>The d_hash_and_lookup() function returns either an error pointer or NULL.
>
>It might be more appropriate to check error using IS_ERR_OR_NULL().
>
>Signed-off-by: Yan Zhen <yanzhen@vivo.com>

You need to provide a "fixes" tag blaming the commit that introduced the
bug.


>---
> net/sunrpc/rpc_pipe.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
>index 910a5d850d04..fd03dd46b1f2 100644
>--- a/net/sunrpc/rpc_pipe.c
>+++ b/net/sunrpc/rpc_pipe.c
>@@ -1306,7 +1306,7 @@ rpc_gssd_dummy_populate(struct dentry *root, struct rpc_pipe *pipe_data)
> 
> 	/* We should never get this far if "gssd" doesn't exist */
> 	gssd_dentry = d_hash_and_lookup(root, &q);
>-	if (!gssd_dentry)
>+	if (IS_ERR_OR_NULL(gssd_dentry))
> 		return ERR_PTR(-ENOENT);
> 
> 	ret = rpc_populate(gssd_dentry, gssd_dummy_clnt_dir, 0, 1, NULL);
>@@ -1318,7 +1318,7 @@ rpc_gssd_dummy_populate(struct dentry *root, struct rpc_pipe *pipe_data)
> 	q.name = gssd_dummy_clnt_dir[0].name;
> 	q.len = strlen(gssd_dummy_clnt_dir[0].name);
> 	clnt_dentry = d_hash_and_lookup(gssd_dentry, &q);
>-	if (!clnt_dentry) {
>+	if (IS_ERR_OR_NULL(clnt_dentry)) {
> 		__rpc_depopulate(gssd_dentry, gssd_dummy_clnt_dir, 0, 1);
> 		pipe_dentry = ERR_PTR(-ENOENT);
> 		goto out;
>-- 
>2.34.1
>
>

