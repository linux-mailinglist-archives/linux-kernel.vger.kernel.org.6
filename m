Return-Path: <linux-kernel+bounces-438601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 231AC9EA357
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E283B164CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7762566;
	Tue, 10 Dec 2024 00:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c/NjWcYB"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AC4625
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 00:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789276; cv=none; b=CL1rJX8FIDSdg0GtHF2Obd9MCzKprnxOeeHD6WjtA+z94zs+NgHLFj/1QY9rStAMJlciufQgm5UcXPBKvwU9PCUKEYvDRLwius8Q9clLlngeQZKJWpRhQrZ2IV9ocETyen9dHk7FrQa5S4PuY+0coWwENbBx6irwZTlv5b2x56A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789276; c=relaxed/simple;
	bh=vU/AXyI/VDdYgyJiIBB96ymrPgTEBl7XbGI7wWDZiWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i23l78KMTHMMAwPnR5P/E7O4aI0iV2u4Nl3l2C+ov+ncRMFc+XAw+uiG3Ema4LPum/mvmrExu+zzYqP5kDaA/JCcZYr2AgSLHl0nMkq9/ELmsxsKN3wWrKdwmYSmBqVLEIlOKIshfZtCwzKAk3j0s9uoi9AgOWL9V1KI9nbBQbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c/NjWcYB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-215740b7fb8so13855ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 16:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733789274; x=1734394074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vU/AXyI/VDdYgyJiIBB96ymrPgTEBl7XbGI7wWDZiWg=;
        b=c/NjWcYBMyWumAiFh5PacAmElAbVQ8lp1X5hi0d2LMKH4Rkj8NTmJA4B6pz4bX8wjr
         eHsrJrSFENNRsq0w8dbKUe7lXTRvqbdXB+P1p4vmOXpcVVQAezbo7K+l9eCtzf3lEw4V
         z4yN06D1NNKSAURUjDPFIrt6jVku1eAPBlKByAi3F21VPjok22DjU4Pj/XSTyo9VZKZD
         vqa/VAABxJNjc1m9sM+F6moom1/fMlGNveTuT+eMXOI8PgBORALOlC1UR9Gs0T6vOlDb
         NcVShf3hBSBrMLCaf5piFIE91RMo+lt2KTg0/62zAF5gvqHILtITJWBhlkeQF20mXYeJ
         1+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733789274; x=1734394074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vU/AXyI/VDdYgyJiIBB96ymrPgTEBl7XbGI7wWDZiWg=;
        b=USxCjqdU+mx5AryagtSkQHb75xLFqn3ZSk/OA6uqnf6sE68SLBdBiqCAolwagmqCOp
         GIA+cE/TEttr7Ydbibsk+pwJYM3PTpS7ddygAavG8nDswQrpVwjTL3hYmMjSwBKwTZeF
         zs6fSsQB1FRw/8x5U54esmEj/60T9/QQ9qrG3ErSn3aM9Dmox1GT9yKAg4IwLB+q+vkB
         dESXP3tLWZA6uwwKjEcN+J+YMd8ctRStru2LRJr+Ih1WcfHnSwBbjoZDo0sTaNvKPIje
         MSy5XfDXM9/lPRxnKaBpljh44Y83YN0gMK8T1k7nZJy61CYuNatknVLfdcnv/nzO2Us1
         3zkw==
X-Gm-Message-State: AOJu0Yy6SJ6tjSvTGKtruFGpWzuwvm31fb+PhGLsn3ggUgZo5J5jNEpT
	UuSzslx9nSqva24XGmbnAH/4mYq8wwaDCMzfeZ4GHc9Chw/I+V/io1GAIO4xLQ==
X-Gm-Gg: ASbGncvbucelL7yOxE7d/3KZ+hM6MqKwpIUQLrimXWMsnAtS0BNMyxQxKEKq5c+3R47
	aMymLa55TwSuQb8Z9bAdUbj4xp7ydJD4btzz8bm2Ihx56lgtFRvSMp65TV3mqPz8Sau5mESsiOo
	kEcjbze435sX2FX9NZ4miNufqPZhIZ3qm1QrALjmUVvgaE2vKA82yuIGBborsvKxwSr28VlIu8i
	GEpZ6VD1Y8syTrqyK/uYdeZK6HNcPUpvfaYNM3Hb/3dpEDjvbtrJNAWLp81jHcu/t7eMFyqKJgU
	HWX7CYcQu2zM3I7c
X-Google-Smtp-Source: AGHT+IGQ/2LlFIpWqHJ9hzAYDRCjXzlbcFA3XsdpYiCBshLltwuxoCLtU/CtxgK3ynbCgrNggfogJQ==
X-Received: by 2002:a17:902:d547:b0:215:4bdd:9919 with SMTP id d9443c01a7336-21674d47726mr462855ad.17.1733789273664;
        Mon, 09 Dec 2024 16:07:53 -0800 (PST)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4e202e9asm2372636a12.72.2024.12.09.16.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 16:07:53 -0800 (PST)
Date: Tue, 10 Dec 2024 00:07:49 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Shuah <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH] selftest: media_tests: fix trivial UAF typo
Message-ID: <Z1eGVcdqMrKZGbny@google.com>
References: <20241205194829.3449669-1-cmllamas@google.com>
 <ffa9aa21-deed-440c-872f-69090fad06c1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffa9aa21-deed-440c-872f-69090fad06c1@kernel.org>

On Mon, Dec 09, 2024 at 04:24:30PM -0700, Shuah wrote:
> Please cc linux-kselftest mailing list when you send kselftest
> patches.

Will do.

Thanks,
Carlos Llamas

