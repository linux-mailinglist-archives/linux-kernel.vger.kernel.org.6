Return-Path: <linux-kernel+bounces-341601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24137988245
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF78283F09
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0143C1BC9FF;
	Fri, 27 Sep 2024 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GKLLTdnN"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC22C1BC9F6
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727431850; cv=none; b=o+S1tl7HwQzBEcL8vl7f12VgFt7ulZXeESokdDRaTGa3lHJeRKAciMP7GNcOLvwV+5fYKFHHEP6Qix6yy/XjM+GwW/yzfZGJzJEcaCgzH67t1uIykkAPdLN6v7iWK9v/xcQBjkDwy4BjRPN80AVODntNnwUQBRP0dUK1aD+eV58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727431850; c=relaxed/simple;
	bh=82V/weC2dG7OB/opVXdY0JQstq8r5ZG2HazKjLEYZz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKNGezzjzzyft9WmDDlB6aUXbZTTmdPjLwAps6hvCvR7gzSy1GNcOuPPAvrgM29vbxpDameBbluHuQR/+IeZtuG+UUYDVbB6uyYQ6NIgIAitOxVayAep0j5PG2FxC0/zyrp7Xziu+i+xz9+9ikhpwFmaQJSGXZZRAksWSDq9e+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GKLLTdnN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso12512525e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 03:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727431847; x=1728036647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qihw7+w8108Risk6Cj7+yuN4HLwBR7iDJgyzm7bJIQ0=;
        b=GKLLTdnNJ/lS5jKg/L+X9kc3oRFXZfcrkFacZOgb3KMP/urqoPQbAvM15Wp9vvTpry
         jeyV5Q+fMknXdDuGJpgGbtugQE1y+QjD91f568RFRw86TSkJ1gCZshhHA+kPiJu7sBJ6
         FvsTuki3mwW6GRs0PcPFebv664yFuZqmgNdzRIO+cnbmEo7PMzZ5Bm3En5nuQmx6ikEC
         1hePNpSoUjxYEMpPd/ztzD7VGb5FLkmiN+ezS91pjLPjK1XlUXpb1a0a2lzh/kEIqlhe
         ojcMC7qLiWkVcWfsaFSUVeAlsTnYk0gSouCNuaMWtWANnwHnAmx9r0rvKc2YAMJRRvoy
         Ckcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727431847; x=1728036647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qihw7+w8108Risk6Cj7+yuN4HLwBR7iDJgyzm7bJIQ0=;
        b=jWzZ4GhAYHUzUcsv7r90zWFfpAnuu0i0XiPw4rE0ychrSN/7ELBnozk07DwJH5vuMq
         EhSYubIlAt3gjw05WDZTwAty+U2ydIKhxjcDkq+HBH8B14V20JvxtCQHPsesPq/MZXy+
         A7TV65k04VBlOwwJ+3hU/N40gHvhUeeGKhUlcWBFAJ0cS5dxGjsTg6SdHdShI7RGK8Ls
         88N/GFEid2Z9bz9Rs0Qz21q96r9h+hcDApMoz9IkZUu7HvWvBGJencGCA/flsL2e9tnS
         yF8WUNiKVylr3MsS3iKpdnzp0FfMaXP5M8c79UdRms2E8X5Ie67Dzyj/kzFjQ/7tpHBJ
         D7ig==
X-Forwarded-Encrypted: i=1; AJvYcCVIbiaaxEZiaQVdRtceVWjtE8fVsHnURyiGvGyTm/McLdzL7kBXjNNTPKBpaHN5p4QVza5eFeC94L5q9bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YycAGUMYIdyGTI9D6RmN5g3aNMWkDeAwKbt1XzdlSC359NzUgvo
	HPASEtTlK1Rvw3yGDl5uukmLE2TbGJHxE8U8SZCqnJTy9uZutmXgHa9wiOWmCuE=
X-Google-Smtp-Source: AGHT+IHcgcyQYD74PprfDGjdFD8bGNs61lZ/QrBpu1J/emsL5e6sSlWoWQavNAXIDSV+FDiS4Uirog==
X-Received: by 2002:a05:600c:3550:b0:42c:b7ae:4c97 with SMTP id 5b1f17b1804b1-42f52200f17mr36164135e9.11.1727431847307;
        Fri, 27 Sep 2024 03:10:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57e13a28sm21924985e9.29.2024.09.27.03.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 03:10:46 -0700 (PDT)
Date: Fri, 27 Sep 2024 13:10:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Benoit Parrot <bparrot@ti.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy@kernel.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 3/3] media: atomisp: Use max() macros
Message-ID: <aad1bee3-594a-40db-b81e-f7917ab1a408@stanley.mountain>
References: <20240927-cocci-6-12-v2-0-1c6ad931959b@chromium.org>
 <20240927-cocci-6-12-v2-3-1c6ad931959b@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927-cocci-6-12-v2-3-1c6ad931959b@chromium.org>

The commit message doesn't make sense.  Please, wait for a day before resending
patches.  There is no rush.

regards,
dan carpenter


