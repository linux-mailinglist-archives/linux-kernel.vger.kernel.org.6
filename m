Return-Path: <linux-kernel+bounces-208862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAD49029FD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4934A282B63
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B7C4D8AF;
	Mon, 10 Jun 2024 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQXTj7Qj"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94227101E2;
	Mon, 10 Jun 2024 20:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718051503; cv=none; b=XpeAMc5U0CTVdhLlYAxNlB1xARTxBguO7GtIrJ77VeIRnqqGr8PwiDHE28O+L4Ifvq4YLDslIwjM+jCqJa5rUbamMF+V36HbTGyN7/EQah32XMLiVFoslf/V0suVuGeewtJwY60XeWawGx5mzdL8irVfSQa6n6c8QFwVwLzDv3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718051503; c=relaxed/simple;
	bh=elv8P9fFwGpTSQoGcKuv5Oihom+/omtzvE1lW7MjQIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cg9vXaiicbINs0qAG8D1UkBSpV7HV6LQwPxQtSKevOYSQoSQODJpKikcjAoK1B//igQuOb0S8zvWxUrJ7DOsmYQtUA3nEKr+TjPiduu06i7Xwh8PYaUd9FCZ0xbfE6KEjOM8Cl89LdPQ0I1Btez+HTn6FSLFSg8ENawvgTkeixA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQXTj7Qj; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70255d5ddc7so357122b3a.3;
        Mon, 10 Jun 2024 13:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718051502; x=1718656302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERP5Axcst5xdWgVkzpHEr4u588vU+xKpk0igMZU871Y=;
        b=kQXTj7Qj/21YBdUsGuw+Hjq+CBeQFXhPgvD9kLT2Xu3Vg4xRx4uEPwHpHIGKh0XWW4
         IaKn5bWx4pGsneBQthxtLTX6446SU8vsniskyVmDUSgJQLFuTgUCR6a8QVUC7uxW1yVK
         YNPBEL4gp1oZCKvTpn5OwL7Ckk/6SYG0rq+QALMIQ9OZGRU5GxJNeqn/jomN9zgU7RS8
         JRd1057o/RtdRagW0RBUXTc5BsoGuDfGyWR54gF3Y/IClDT6VUATQspaVOAmrCpAhGxw
         jJk6c8kQuXmxDGjno9RTlxFEw9xNpOiuwwJH/MCe0DaSMwUdFRDNHyYLfGXpZ6qlVts6
         4m9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718051502; x=1718656302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERP5Axcst5xdWgVkzpHEr4u588vU+xKpk0igMZU871Y=;
        b=YwEQVSn1r/5EKMWSmPYzpJCwqg1f8JVQP3Ix6WDXI56iS44jmz/PL5LO5HWlVFCbAs
         ubp0yh0XBeOwaXzqbpNW2h4MS7s5SVRgelZUC2hJ4JD4ejox62+vAD+evw0VfuJa3sJ0
         G4wjf7G+UtUQGVF1pziBfM72j2BBlrTG9kiaKSH2O/0EV9VKKJrhNFk5Y3U8slPHuabN
         Mu6UZAUXpO7HmFCQGXfXAnrQoKMlE84ZoB7Asass4oTIkl9MmVGIDZZjSp2P4IxaIwL+
         yQlxD5LtPzR4N6UruoUxsXD5FogJsKLlNTzE/9oBxGxKDU/fV+Yr77Al5wmkDchj5JA0
         WRyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF4gajs5HlmbZT7jYkCOOCzmDOdPysfLMeFiyck026Oxb7T0z3oR3mkMU35GJWmr8VCyrdvX7bxmqvGH+6ypAmtP2Nw20clCxU3wG4
X-Gm-Message-State: AOJu0YwXAIZlVaHuMxGYNNWTKiR5cfZTpd8fEsc4k65sZgmaf2PThjOU
	/MLTUbSdbg0otX3PCZ+CMlahUh4gKBEcPQHAaOXcFYKOu0A7Mt9uUa1DTQ==
X-Google-Smtp-Source: AGHT+IHjhvvrQEpSk6yGLFaiBhJmKf+tDnKAa4FkxYpdGxh2OFq3MzOMo25NpT6wXAosNl8ezbzH1w==
X-Received: by 2002:a05:6a00:2396:b0:704:21cf:3926 with SMTP id d2e1a72fcca58-70421cf3c91mr7888524b3a.6.1718051501828;
        Mon, 10 Jun 2024 13:31:41 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e52500c4easm4241405a12.36.2024.06.10.13.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 13:31:41 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 10 Jun 2024 10:31:40 -1000
From: Tejun Heo <tj@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: kernel-janitors@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 12/14] workqueue: replace call_rcu by kfree_rcu for
 simple kmem_cache_free callback
Message-ID: <ZmdirLnJ2RJXoGCF@slm.duckdns.org>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
 <20240609082726.32742-13-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609082726.32742-13-Julia.Lawall@inria.fr>

On Sun, Jun 09, 2024 at 10:27:24AM +0200, Julia Lawall wrote:
> Since SLOB was removed, it is not necessary to use call_rcu
> when the callback only performs kmem_cache_free. Use
> kfree_rcu() directly.
> 
> The changes were done using the following Coccinelle semantic patch.
> This semantic patch is designed to ignore cases where the callback
> function is used in another way.
...
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Applied to wq/for-6.11.

Thanks.

-- 
tejun

