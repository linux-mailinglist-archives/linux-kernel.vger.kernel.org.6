Return-Path: <linux-kernel+bounces-301402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B025D95F012
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 281ADB22985
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857FC155751;
	Mon, 26 Aug 2024 11:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Jg+gnVXN"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2422E154C0A
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672662; cv=none; b=HEs6oF0Jb59ll5GFzyPs1WwdAA5v87E8YGG1oqsmSomy72B3G06FwTtHUrlscuq3T6i1uYY1lQUj9Wq+qL6l4+9GpLqhB5NOrVcroiJfOmTkombH4/WqYI8nEb/1BiPrp3/6fZ+kfteZci/TpHxOsLTGGED6oXw6vzhTt9nJDKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672662; c=relaxed/simple;
	bh=Q0WCBQ+YQhJIRNMx8ZqrxOmrXT56oBALfKJQmsCvtjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCKfh84uA+0dEKN5DfMDqp6zgvClUgS2CKaUSb4Jn4SUbmRKCY9gY6j9oYdvudSH/5VZnKPzAav74jkHZEGjHAqtbZ55lJFYMW3R4p5qN0VHA5NM5kXHzg7TRZmbxIrTmpuY7J7tyaVAp8dKVaXcqKlKHFZIeZoJcogZWq/J9mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Jg+gnVXN; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-428e3129851so37589795e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 04:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724672659; x=1725277459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rjUOttzFKwY2nuZEkD+CwQhqUwBV7ybSocpNKcj+DgY=;
        b=Jg+gnVXN47c4XZ/bOLnGZ+jCShSixFgRKiR3S10+NjKVG8A3+nen0q0/G27JlnFSsZ
         paZVCYJRR0pJZEtASFwZMWqjtEN9OfGX1HcXbb/nvHoQytjSMdEr88EqW6VwNcPY8SSN
         E3W/u8C7vtgf0NeIo/8N9CoCnp9Kq6F+TwH2/gCQ0LhmLIsJFfm0eIL5MGSfHDkMHMDN
         ZweNRtTmvN+HWVo5syRyXqq+o6J7O+BWpHRF3y4s6XSCW2p65muWqQp9tyzfW45k2w/0
         AXyim/u8MDr98fCv36vXSI8D8fsCzi96j7BinzFzKhY9djvBoewLVHah8ELlu/UOPaHm
         dbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724672659; x=1725277459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjUOttzFKwY2nuZEkD+CwQhqUwBV7ybSocpNKcj+DgY=;
        b=C+wZsBzEDx9xLUnRkZ4MQP3KsCtXILqb3psRwPNVCsQj+xKSZ7eoEh/b1J/sdmFfwt
         1B3cgSyF4FrtioPfZgv7bkQMrnvT10rB1WNvM+k9PM2ONBVcykZzK+uYLluVQ7AblVbY
         Sr5dW3YBc0fsQBlJidfjq4rfGrmlf8lIlwZYCq5Ly81jhJgHf0fmX7blPGXhj45TwxTn
         vMbcTz/3EvEhMXSvZ3e8n+nITIKY9ytqrNIU0q6wfufzCfXGl+A9dZtrZagNLi23S1AG
         GIjh9Wkw+l53cvg958dZgwMgmXZSpVTG+jSjoy1NTNLpdFXRfBqKRwIab25LoGXjdTib
         wyYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkZ/2whqpc9kXrzRdJnnXLNFol1yEjfZdY9gPVfTBnV6j+ibyxlQlNnqP7cqKYMDuvG/wDTLKC/71p5M4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi71C7u1knDE05nKnFWrJOX7/SLuT+Byd07FlN42JA7/sVPk7S
	7iy+NG8v4WaSd2B9soAGnfWUJeHx4hEqRfNqKXLYw3Blp3Gngl7O0wc2wDGj5X8=
X-Google-Smtp-Source: AGHT+IEmvcGc7wd4ir9DzV0B4XPRNnCMACGg2Jljc1sciB66eE9kAhJjzoAZa61suLeAH/Jsj+VoBg==
X-Received: by 2002:a05:600c:3b90:b0:426:6ed5:fd5 with SMTP id 5b1f17b1804b1-42acc8d35e0mr64320925e9.6.1724672659114;
        Mon, 26 Aug 2024 04:44:19 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730811044bsm10569394f8f.23.2024.08.26.04.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 04:44:15 -0700 (PDT)
Date: Mon, 26 Aug 2024 13:44:14 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Yan Zhen <yanzhen@vivo.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, trondmy@kernel.org,
	anna@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, neilb@suse.de,
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v2] sunrpc: Fix error checking for d_hash_and_lookup()
Message-ID: <ZsxqjkYDk1k0EbPn@nanopsycho.orion>
References: <20240826112509.2368945-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826112509.2368945-1-yanzhen@vivo.com>

Mon, Aug 26, 2024 at 01:25:09PM CEST, yanzhen@vivo.com wrote:
>The d_hash_and_lookup() function returns either an error pointer or NULL.
>
>It might be more appropriate to check error using IS_ERR_OR_NULL().
>
>Fixes: b7ade38165ca ("sunrpc: fixed rollback in rpc_gssd_dummy_populate()")

That certainly does not look correct.


>Signed-off-by: Yan Zhen <yanzhen@vivo.com>
>---
>
>Changes in v2:
>- Providing a "fixes" tag blaming the commit.
>
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

