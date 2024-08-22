Return-Path: <linux-kernel+bounces-297424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A83595B81F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98261C23569
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09231CB31B;
	Thu, 22 Aug 2024 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VlsmIbPn"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BE82745D
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724336169; cv=none; b=euBjSkpMjlWEW9KN5UCPyIbEZ/MQcqVUuWQ9o4y7jF96e2wV0WTxGUzLvfPYN2wcBfIAlyfMVUGdtnoUmyuyBcM/vmessJBFB2hwTFc8L2z5mkwqeILVxBw1y9p63SlSqotdPGJGMN/bb12YaEg/Ih/NqRyesXVjLppR4Y0Qvb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724336169; c=relaxed/simple;
	bh=pnlqb54BCgrU88we4AzcecXX9ELQqqJgryvKOTvHp80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pv+VDeAhVVLv28HHHHqGWvpDU3ew7e4VSONTvIGEN9lqV7ql8KNCh6i8so3LEMMFKcENLz2Iq2/G/3E4oew9fVZTj/vvERDZxfwnsdihbgSkNplmXupeAegOx9A7YjvK6AKd1ecXdSqFFK40RzOiNyJdtQO6vWchCcjaH9D/Tl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VlsmIbPn; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428243f928fso8694205e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724336165; x=1724940965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N3m5wiBO0uoqTyLuk1zEtLyS3nxtuNvj0xsiED0Pv6Q=;
        b=VlsmIbPnYc9w/tINWURMLu+6CPv+bNcklg7EY5OrhvFVgYd+PbZSz0ttCfSyK4LqIi
         ikeEV7yzTu9fMnyr+2ET0F70HydC2xN+srMsPfG3+4iKsMzM+/WCNN3WYMlwWWQumOiX
         eaaGVKGDSFTBayHaw3Xk0Pz3ggdf2Vu0zF+MFs50cBycn9ilucnNh9Knyg38z46j6VUG
         RgzbXGmA5FsOwJciyJIhae4uD1rz3bK76IhTQm7KRInkBuw21OF9+ig/GIr98AJ4wSHF
         KE1hJTXf0M3Za4wQYdptF0QBaH/p2xRkL9/7Wz4Ld0NIuRwxz73kbqyq5LuK+AUBOj/J
         lzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724336165; x=1724940965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3m5wiBO0uoqTyLuk1zEtLyS3nxtuNvj0xsiED0Pv6Q=;
        b=KDXRGSrss+zoTO34Gdn7F34CIi957rXtVBuHykgchuh4qtrrV7qXqsqqTanD9Oq68n
         I+z1wPGc6tW8hfuqM9wJy8SpskL2Rm5uUaTSJP2AEaFIOJAyufggxHZSWSQJX8/Pwd50
         7398W9MI5VI7xloBVA6uipL9OJZF8S/z9RYU80miJCvf47UUfPQXKM6aRaQjQEuiLFRd
         NHIu+3UFmY1IDELY3QShj3+5sYAAn1Vhyx6eSy6FyosQ4elTcOImFFdN5uQCnpSj2rwW
         Cya7M2pmjNpEq/fgSnNR5hG7Qt+PfZ4cx7+CU+SGUayRxCnBvGDn+nAn2sQsJ6XUjDOC
         6Dhg==
X-Forwarded-Encrypted: i=1; AJvYcCWLY2EnWCR/alUDO1s3cVH13c2BfAJ0pp4MrZCpxzSAVzVEzO2v2w7+t8uVAvGQhaTgl6+Z2jZd4f/9odU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3b85NXb88Np7ad6RmFS1OfuC3ohhk3kMz7e3Bt7NSIilHuWJ7
	+XoHDmj1dFjf+cPNUmUdLGd1rCOivJ580WEY9SFZ9T22V746atEyWj/e5P49Cug=
X-Google-Smtp-Source: AGHT+IEn/cSUzXrM2HZrrKfRXByXKxSQj8B3nbVnGKe3lrIdC9YL0mqMoF1BsVccck4SGVbq3LvpQA==
X-Received: by 2002:a05:600c:4e8d:b0:426:63f1:9a1b with SMTP id 5b1f17b1804b1-42ac56371e6mr16898125e9.33.1724336165516;
        Thu, 22 Aug 2024 07:16:05 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abeba89a5sm64073305e9.0.2024.08.22.07.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 07:16:04 -0700 (PDT)
Date: Thu, 22 Aug 2024 17:15:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hans Buss <hansbh123@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH v2] staging: rtl8192e: Insert spaces around '|'
Message-ID: <69883eeb-9c01-469e-b2cb-58e2ed1b1ff0@stanley.mountain>
References: <20240822140022.11197-1-hansbh123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822140022.11197-1-hansbh123@gmail.com>

On Thu, Aug 22, 2024 at 11:00:22AM -0300, Hans Buss wrote:
> From: Hans Buss <hans.buss@mailfence.com>
> 
> Insert spaces around '|' to adhre to Linux kernel coding style.
> 
> CHECK: spaces preferred around that '|' (ctx:VxV)
> 
> Changes in v2:
>  - fixed typo in commit message

Put this below the --- cut off

> 
> Signed-off-by: Hans Buss <hans.buss@mailfence.com>
> ---
  ^^^
here.

regards,
dan carpenter



