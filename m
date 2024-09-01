Return-Path: <linux-kernel+bounces-310396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7BF967C30
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 22:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39BCE281950
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 20:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294FB6F2FD;
	Sun,  1 Sep 2024 20:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E14JW6a+"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F871E517
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725223687; cv=none; b=mWHoXQIkqCN68/8fyBDVy5YMNCb4qIp3BVY4pqRafkoPHj7TBOvMDe3JjqlydhRzZFl+QBZE/FRMk+AhypCbOp8vhBx1M8iqcOncGLTTgUlNYhyM0BzJIn350KAgQmgNKIPhNRTI7Je98uQHkXxOgp49PAUyTOyyBM6ZsQCPxNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725223687; c=relaxed/simple;
	bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/6V8Dlg/YKX+po/9KzrPtfg7JbF0YnfqaLUYevDaIWbmcy+y1PrTlS5E1MYg5bdCFHBkDAsv93UAGzrCW/324qCxGCsNyCUCpHJbWAgvwhfOYUVIgqFu39v0VyYkpcueP93mvjsGmle+82xAzywzVQy8MOkke8OElRUeSY94gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E14JW6a+; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7cd830e0711so2116936a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 13:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725223685; x=1725828485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=E14JW6a+zXiamQ82mhioHPOWx0X2A9M5gSVNLT35KHFxaacg40i1b/ladzXWa2OzEP
         z6NKrLrFUx9+Zx4aILApUuE8Pu7E0OKmK45Q07i7Zb8C55VtH9G4dvKrRzkqZNXvhaJX
         GGGbmdXzZE5lyg25xw6SLW7LwXR8Y0OYIQiid3qWKTuVtukdo2qeO113nKMPmaC5no4v
         VCs2WBiT76V0+D9cgqLb4bUGuSOCTXce1zFuPQxTiJbr9JgnwUEkfHZqHoDu3FyxoVew
         uF31vI+7Tdxq3Ito9Om874mRgYV00hV1fBuyfHfBEgdgCfy1tki2JLLb90TjsKG/+rNU
         eHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725223685; x=1725828485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=O6lC0YdwpYqF0LkMSEBpmdiZo+hjTjaAnGoTDv9rRZh8s4xtvva/thFZllmY44T8qp
         1+CjvfwHpN2BVTvD9vpsWB54qmTmn2FxdGhBt35VtMe5iPL9q9iyCGkBpZ5NwMGIZObi
         GGpucHo/iRyBTTIvq8rFXpliCdX5PjP0AMUUwvtWbpMZYMzX3sUvTiJCFZUvjewqhMMf
         ZGCaAQdzz0j25K/hgI2j9kyM/VdRHRYBDImuws2DaGH/4K+Z16oJVsWL+lJwdCFnQE8e
         hESg2DlqLX4zt4BMqEiMEKu3/3V2m268t1mOFoiCZNYmf3pf8xpzY5jyNPoALZnbQ6d+
         X5/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIBmKrzSiY97QyG1s/1q9AcI1Y5JUwmGwm6lryIYw9DxCdDOjXN9WFSbrxLlpvkxL+WeHMC3Ew6UxYRXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoqB7pHMDBbUNPNWxRt4nE5Dy74mte3iWbVCxrgF0ivh1U6JV3
	tvdUtXwfLCZjm3nLNxWxJzEbDCNqE1HVvGZOEUobcxO9b4xRl49B8948bGbefIFz58HcWJ2fKFw
	5AB8uOxbnxinCYH46aJNvh8Wh+9oNrHbs/2xrEWHsCewSQtXHMYOp
X-Google-Smtp-Source: AGHT+IEMvJPOrU7RuKGMf13ks25GLsZTvMpPVT1qgtrdF37+cbXAy+ic8ehvB5MsGIJjQhIvH/Wnnp5C63ZnslrlL4Y=
X-Received: by 2002:a17:902:ea02:b0:205:59b7:69c2 with SMTP id
 d9443c01a7336-20559b76c79mr66954165ad.7.1725223685206; Sun, 01 Sep 2024
 13:48:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com> <20240830032840.3783206-3-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240830032840.3783206-3-hsiangkao@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Sun, 1 Sep 2024 13:47:53 -0700
Message-ID: <CAB=BE-R5p+R4dOwvENJARtYFdiT2UaTgtxtxgp5GJd5nUNE5rQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] erofs: support compressed inodes for fileio
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.

