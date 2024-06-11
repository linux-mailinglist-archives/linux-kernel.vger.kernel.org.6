Return-Path: <linux-kernel+bounces-209176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C55902E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38E08B211C5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F46FBA46;
	Tue, 11 Jun 2024 02:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="fOsOLcbh"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F1F8485
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718072155; cv=none; b=o5uQlQ6eopGR5ats5YJTUA6gdSQUghn9ezT+Rn9/K7zS+/dvePM183gbY1dcKB1b5mlkNa2w18Hdza0Eie5D8H28ihkoou+wftAPR+ZsTCXYlo99FbNw3J9OW2CyjfMYtClVqCkMszpGcm5ID3+pqmB7tdfBkUUyNppRaDl6Wt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718072155; c=relaxed/simple;
	bh=Hu52NiUMZnfWmhYSBz7t0d0I/Ggbxn0bNqdedmqTXY0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rA5z7F9uYIZxQYxjNwEqVaD1qlDoWsTrEbFc0AtYIjuLlNY8YDX901C9UUP5cAG/3MUUqXsYiXXj7+r/6nYe5UgaJuxGzYtqYyXpAecuL5IaXyIlMBtYez1JOe5WJHliTwBUG3s3yu1k4WdKcKgbfX1ChmvmcditxdW3R61uTDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=fOsOLcbh; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6e4e6230f42so2200887a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 19:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1718072153; x=1718676953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M1iMWD0cXe7m//eT5hVbZ/CrnHyq5DzwD9T5UDxYRWk=;
        b=fOsOLcbhJea4ykTtjVfPRH0IM3wjxTNLWh9kWIHiWzDbck5VLk9VAeecaIPtq7R0Ew
         yUO4AOO2td6zWD3q0KmObQCoXVkmEhSDwzw0HpR035/O1/uZKruPn7i3syA0tMM+YWKT
         d884rvnPAIALc3brMlbSI3zl8dy06hvbVE/DV/JF8WXmXGqBAn6qd+enQSRjmk9wUVpV
         gLox0afb6fe8T9LPPWJsVDVKvwfMwbI3to98uZFZSe7rTzpjBRXFL2GTWqH5RjDrAAtC
         7JnKuKW2pJ0T0njpCYfJ1ZNnhW29AZvkaLN1Wtt/aLADGv1bxPcv/9CM8hwI4IpyW15X
         HZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718072153; x=1718676953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1iMWD0cXe7m//eT5hVbZ/CrnHyq5DzwD9T5UDxYRWk=;
        b=ZBgYIQa1fvB5aWZ0AEvGIgQb0bSuycTxxjwqOzoQOwtUZGWFnOKrN+lmbB66+4BUTn
         xgYdZppUOLFJuTEMtpJQ8vkYarYdX+R6xZJU/JvM/BIKyzMqYzzRnCAP1UViifkmVJ1e
         uTvjMfx8QWHdSCcceMDL9O7RUizfBOdDyv+jnCD2VQZdwhmGthabGkvOpDYdxxNhZUIt
         uiXb4U2z9V157IGIpD/4QoZc96IaBUhMoVnYzUfy4sib5YMthPFkkdSZeO2VbDKdn+8W
         j2q31x/hOs/7NKKOLZ6xcSnMoNaTk88H1EAEO9zPRqZTUT5QZgNrTY2XjXKP330VW20+
         1dQg==
X-Forwarded-Encrypted: i=1; AJvYcCXWz/d8OWpTWohp4f4hqHeU7kddlo+gmxvKnm0YCver5TzEYBevxLUnmNtEt0vAfGbtC1GXh5FloBc6g4IyrH89Ab9MRjGbuF5dqSZS
X-Gm-Message-State: AOJu0YwNCLcM++KhoQfcwDLkYaSbck+QVIM6WRKQupKyleLqtCrWUc3K
	p6BR95wLLhxLd9yvXBxeXuRFGCeepl8xGcfF+L3MbFyybew/idmry/I1PBblHj70FDNTt8xVT+l
	byW0=
X-Google-Smtp-Source: AGHT+IFCCmF1Pb0/pLej1CnnPxa5PYZWpZ4USpYe65UOEQV4kdYmk/TD1yjqtPqRTKpKrqRMvMYysw==
X-Received: by 2002:a17:90b:3701:b0:2c2:d66d:1b8c with SMTP id 98e67ed59e1d1-2c32b4e55bdmr1755621a91.20.1718072153177;
        Mon, 10 Jun 2024 19:15:53 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c316e0fc1asm2039654a91.29.2024.06.10.19.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 19:15:52 -0700 (PDT)
From: "<Tree Davies" <tdavies@darkphysics.net>
X-Google-Original-From: "<Tree Davies" <tdavies@gmail.com>
Date: Mon, 10 Jun 2024 19:15:51 -0700
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com, anjan@momi.ca,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/24] Staging: rtl8192e: Rename variable bforced_tx20Mhz
Message-ID: <ZmezV4UvCEImxMBX@lunchbox.darkphysics>
References: <20240610054449.71316-1-tdavies@darkphysics.net>
 <20240610054449.71316-10-tdavies@darkphysics.net>
 <5ccfa433-f1be-45f6-9138-348cb4093866@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ccfa433-f1be-45f6-9138-348cb4093866@moroto.mountain>

On Mon, Jun 10, 2024 at 09:08:03AM +0300, Dan Carpenter wrote:
> On Sun, Jun 09, 2024 at 10:44:34PM -0700, Tree Davies wrote:
> > Rename variable bforced_tx20Mhz to forced_tx_20mhz
> > to fix checkpatch warning Avoid CamelCase.
> 
> The correct capitalization for megahertz is MHz.  So the original is
> wrong but the new name is not correct either.
> 
> regards,
> dan carpenter
> 

Thanks Dan,
So... I guess just spell it out as 'forced_tx_20_megahertz' ?
Tree


