Return-Path: <linux-kernel+bounces-514957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE268A35DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D6316FD0B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880DC1EA91;
	Fri, 14 Feb 2025 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="l9RDNYQW"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382A920C00B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537698; cv=none; b=DgANvlg5gM8nMpVrAhktFxeXBvPLSYOpS2OJrAzm5LriPeUv6jgbsp2VFXEdrKBMggXgmQJmUeaCJSp+IByOh0eQzGAhUQc7wgEpmp/jnGp/Olcz9S+TmiSCsphnPOJDuWlTPscW7Ocwjdg5bxS5dgFkv2oFbG5fjvC1oyoQ5iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537698; c=relaxed/simple;
	bh=0mYcHvTTq+lgf1qomm4p1Qr7bp8yKjlUDa+0QhmoQaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvf3T/WpAjb8cmkiL4Uc1qAv4T5E9f2CSwPh/5Dms3Ghtyyx7RVRjdfpYj3b4M19t9YBJXswP4QzID5AnbHHAf/r4snHo6C5UInX3ctF6Z9SZ0NNIL+WKDbHTMRk0sV3wpekuFlnurRnk9Jp3kvTjwA4bJzZc61V6YYWlGLltJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=l9RDNYQW; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f31f7732dso100087f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1739537694; x=1740142494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1+lEmaDHN5QnNQZg6dCs36v4GP8d4TTbF6P3QQiuPAQ=;
        b=l9RDNYQWjNIhbSF1bOL77lG+Xu/R8rt0bhOvuqx4U191NKle1j+tUzwvg8Z0WygHaO
         1ZPGcUbiW4hi9bMdI3WjDbUdu5zhUw0/KL+dg54bxTSrSWi354QS/iYdEIUe/1kLFD/i
         c71vhWDbAClalxsTyUAI3YpHv2Mo+9a1KO0Lx/yaQiov6KzW3VN9wi5LSAp8wVF39Q7y
         vmhvbc4n6ADdW8392GcwMVt1UWQiTCev1M9lWy9q0D8ycszm3NXai2SqxTikMnTm19U4
         GH0ZX3ctFLLGtCP5x52gQ4x6kEejF3WrIucOSrxnFjUw3Uu6Wtq9q+ZX/IHyWbNFXkmH
         CzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739537694; x=1740142494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+lEmaDHN5QnNQZg6dCs36v4GP8d4TTbF6P3QQiuPAQ=;
        b=tINFVn0gSzSMUuVVodGGAs5xkYeGjHPPikcKZTssUs129nsJw7DbrQjVgCZS4BF73p
         psE3SeWBiR43aXEzeql0red1dmzxtLMyB5d31ZlM8N0YOdaWH2uZ1sVavQjr7sBQgF1j
         OwIMOhkjpdVih5GlKKRYlfOSYr0LJ1kp3MOZHCS8kBMej+yWRA6g+UAY+SbyjIDLYZgZ
         PicI7JagxJP+VVmJJvXQDEV7LL5wonwMfev0z6+1BTVC4BlZORFRckUixPFVEf3kvxqo
         IIYnY/CcO2ck/+IztUTncfdJNDnpDw2fHt2CBHPuZZGFz+k//N8MoToLGuVFKJfxpxj2
         /6Ww==
X-Forwarded-Encrypted: i=1; AJvYcCW2LsI1qJ93uIizKlZOgNJ5aurOWUA5q96sBQjtn6V+lq4VmYuGly58IBrNkCD2IyrRf+ak+foX/bToIVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDEcwFxUqahMsBrTPiW4Qeyu3HE7/J/q7xwwC+PhKQEzm+WP8k
	t2Q9STF2JnJQB7nVCaTuPWEluZ3hp4Fz0bGd7BeKnBo10PLcHb/ikBKqk3kNFx8=
X-Gm-Gg: ASbGnctHPoMQbbPqhy6Ouop7QZCen2cXKEMr5RGVNsFw+iipqb/OOxGVbDUdLK+sd9P
	xKVnZYCNOaewQaixM3qsMD6Fo0q/ykWyNIMY69GKx+B7t1AVls1kwfQmuYTCx0jcq107MIXtSzd
	nxRkof5MStAgAu3C3qMvtMxMUTyUvOdop9Lz564LXvpPc6EDs6/AlKOMsrVYyOFSXiwXfcVQlKt
	YyL2nF3zp2EpkCGBfqlu9iSAVbIQHkKv957tRKeO+zmf85FmdJNzwyQ/JQTppOffhWF6z4akCir
	w4Jslom5Z5cwZF2c+p+aP/g=
X-Google-Smtp-Source: AGHT+IEk52uqZohTXf0fCVa4pieNwKGseiJ6YLDBEGNj11Ir7TJrVFFZcb2vaITJ1n0RtedVoY/5lA==
X-Received: by 2002:a5d:6d09:0:b0:38d:b349:2db2 with SMTP id ffacd0b85a97d-38f24f948bbmr9416003f8f.22.1739537694226;
        Fri, 14 Feb 2025 04:54:54 -0800 (PST)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5ef9sm4545091f8f.76.2025.02.14.04.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:54:53 -0800 (PST)
Date: Fri, 14 Feb 2025 13:54:43 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jiri Pirko <jiri@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 03/10] devlink: Serialize access to rate domains
Message-ID: <ieeem2dc5mifpj2t45wnruzxmo4cp35mbvrnsgkebsqpmxj5ib@hn7gphf6io7x>
References: <20250213180134.323929-1-tariqt@nvidia.com>
 <20250213180134.323929-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213180134.323929-4-tariqt@nvidia.com>

Thu, Feb 13, 2025 at 07:01:27PM +0100, tariqt@nvidia.com wrote:
>From: Cosmin Ratiu <cratiu@nvidia.com>
>
>Access to rates in a rate domain should be serialized.
>
>This commit introduces two new functions, devl_rate_domain_lock and
>devl_rate_domain_unlock, and uses them whenever serial access to a rate
>domain is needed. For now, they are no-ops since access to a rate domain
>is protected by the devlink lock.
>
>Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
>Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>---
> net/devlink/devl_internal.h |   4 ++
> net/devlink/rate.c          | 114 +++++++++++++++++++++++++++---------
> 2 files changed, 89 insertions(+), 29 deletions(-)
>
>diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
>index 209b4a4c7070..fae81dd6953f 100644
>--- a/net/devlink/devl_internal.h
>+++ b/net/devlink/devl_internal.h
>@@ -121,6 +121,10 @@ static inline void devl_dev_unlock(struct devlink *devlink, bool dev_lock)
> 		device_unlock(devlink->dev);
> }
> 
>+static inline void devl_rate_domain_lock(struct devlink *devlink) { }
>+
>+static inline void devl_rate_domain_unlock(struct devlink *devlink) { }


For the record, I'm still not convinced that introducing this kind of
shared inter-devlink lock is good idea. We spent quite a bit of painful
times getting rid of global devlink_mutex and making devlink locking
scheme nice and simple as it currently is.

But at the same time I admit I can't think of any other nicer solution
to the problem this patchset is trying to solve.

Jakub, any thoughts?

