Return-Path: <linux-kernel+bounces-190266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFDE8CFC36
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97983283F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8191469D31;
	Mon, 27 May 2024 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AGY8VAfy"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577B628684
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799900; cv=none; b=Gk44vlM/7OuXTVEoAEnsX+BzOrktHi9tF26zqPcmIKOXRcWstFDT1T5f+4doTrNyJsbQ2Kdi1oWg9u5TZt5MkXvXAGQrZPKUCYUVi7I/5TSBjU4Cwdd6pUfjnq9yEPWQMfxV5z5YfXoe85S9Vu3t+/02PuUzXV54PWyFNRQunJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799900; c=relaxed/simple;
	bh=9HUeoIxJVed2oXzn8k+z1lp95CXmZkk8jYnTEeuKwZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfMBldCroHcZlDQlKm2FLEsIf9HaVRL/dz7tKy7L4IJikNWNmWpwRuK9QF1xpEogtlkfvmwQtzU/w32zvxBhFc8senkkfYTK9hclhJVJIwTEWMxIRTUv4ueQq+ECqxKY5t5AGiNZ4LNCGeQV5Z5QbcuFqsHo0A7gUitbGV2YfJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AGY8VAfy; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a63036f2daaso50010066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716799898; x=1717404698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KMXCYLp7PnphXFH4ZP3dDuwhlXaSPog9pjAwXo0KeQQ=;
        b=AGY8VAfyPYv3dae02pPNdk/iXLJg6bJpzRdlD3OJ1b1cb35nYpA1FWQNZfmo5zAlwi
         sRAGHN4oi3Hf7T/t3uSjUsCDAuRWB2QblPpakcs0WJiM7hsx8N0yzKZJ5tXSuYpTBvwq
         tF67qb5hl0/OQrNeeEP2pIeJbrnnDxhJ1B2tdNdAuOn44ZVW0a/SdQzm24rQvMEX/zLG
         8He8boW5vmKaAq6dfiOrvapsL2YZB8r68Pt1DZzMlZoDnSDXJExEbQQTvfYd9lxSjLyx
         I6rYbl29DOj36wLDFT7IyBOIRgSw/S3tLLlHh/D5Il0R3jNQsuav9FY2MrluhRuSe2N2
         zptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716799898; x=1717404698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMXCYLp7PnphXFH4ZP3dDuwhlXaSPog9pjAwXo0KeQQ=;
        b=GNSEqVtsIlzla0Fx1vILwy3p5QstD/hvOhTNxIDDScrqX7UZwPdbpCca0IiWso3KLw
         9jhehC38JvPEZN4VppDgrWHwECNuzVT82bnwaVtE3uOkshUaVR+Sb0sHNU1k44p9bd2e
         khDpqrFE1dMSi93t7eHe+9diWHDvjAzfs4fXNfzZgABPV5eJRfLA2gDWV0xBxuj6Xae0
         HaKpQFDt+ou2uCsqddx/JWHqX33f6Gqe+vD/fOQIcZ3NVVxzpQkAhOVGi438OZn5s8Y4
         BV7fgUhJoP64fc3ZGAJByAzDi5wTIoTb/eb4jjwOOE9fRfaJPrtxHjF68PucPgV4Gk/F
         jpyw==
X-Forwarded-Encrypted: i=1; AJvYcCUBGZR1YwwuyV1/3nSSUlgnPLOVfg95s001t5Hbw52RehqH9pgdjIPEaTMBQW9IzKPsE5QgMOTJgiFkDgSuTvedKwxfkXsNT3McRZ7r
X-Gm-Message-State: AOJu0Yzj87+7D3GGP+nbuz3QTLWcz3M5qs9ZpfB7Z+CFUUkJ3BClxhXv
	TQ2ommMEJDQ9SsCKoQmRnXP7QQldsCU3IITOBDxT2LfK/+auotjtrEUqHa/xbFc=
X-Google-Smtp-Source: AGHT+IERvbG5ixvm82wd+6mm+v/y4ttE7uUn9cqPTV8DsrXmE3OajQ5DWcpp6JlL8Ys1RITrP3uNLw==
X-Received: by 2002:a17:906:c20e:b0:a5a:1871:e2a1 with SMTP id a640c23a62f3a-a62649bcfebmr627437966b.33.1716799897660;
        Mon, 27 May 2024 01:51:37 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c817a98sm469249266b.37.2024.05.27.01.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 01:51:37 -0700 (PDT)
Date: Mon, 27 May 2024 11:51:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michael Straube <straube.linux@gmail.com>
Cc: Nam Cao <namcao@linutronix.de>, gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: rtl8192e: remove dead code
Message-ID: <fd953272-5dd7-4d5b-9938-1e1c68e73b18@moroto.mountain>
References: <20240526111928.14574-1-straube.linux@gmail.com>
 <20240526111928.14574-4-straube.linux@gmail.com>
 <20240526143100.FmVupNWq@linutronix.de>
 <e25831a9-9913-43da-831b-d37bdc4d9dd3@gmail.com>
 <9802cc9e-5962-44a1-a384-3e5ee226cbcb@moroto.mountain>
 <2d1dab52-72ab-4f4d-8f77-ae54f16b9b4a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d1dab52-72ab-4f4d-8f77-ae54f16b9b4a@gmail.com>

On Mon, May 27, 2024 at 10:34:41AM +0200, Michael Straube wrote:
> Am 27.05.24 um 09:39 schrieb Dan Carpenter:
> > This patch doesn't affect behavior at all, but to me the original
> > author wrote the do nothing case for readability, and I don't have a
> > problem with that.  In fact, I applaud the author for caring about
> > readability at all which is not a given in staging code.  :P
> 
> Then I think it's better to leave it as is. :)
> Should I send a v2 with this patched removed or will Greg just apply
> the first two patches and ignore this one?

Resend with Nam's reviewed-by tags.

regards,
dan carpenter


