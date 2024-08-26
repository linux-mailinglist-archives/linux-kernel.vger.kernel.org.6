Return-Path: <linux-kernel+bounces-300833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B1995E908
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F055B281761
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7C282D7F;
	Mon, 26 Aug 2024 06:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KFv8mioO"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF0778C89
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 06:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724654048; cv=none; b=Twgu6EGwStQt/hGZdn1DlVVdiP/Cb4degJvHC3thhJwXKVQ0xxVQ4PIn6UffP57iYaVzP5SSFfqy3sCG1WYh40eCwJY1TsTckJOk24GnXjhxo/RJctR/MHMxhcXe5h4V74xED1TIeIDiE0k/nhakkzc9IR2MW9b00sYqIiPlUng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724654048; c=relaxed/simple;
	bh=79dMh3ozZ2lqnDINOcOVhNaezlAI70Ja2qWWVLvBDAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fo8BhiUGdKMMXQwzhwETZGpyLnqzBzc8J3U/f6pCC92eiuxwql3UpDcTPS08ZbOpn0B2lskXBMWRexHjoLIbIr/tzWPaeXhT586o2VGnBOtVGMFFuS8YsJ/vpdcGuFm2mPehC4SwGsTu2snSQm1UDjqB69wVZ2OPQKoG4zRU3SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KFv8mioO; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f50966c478so8912961fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 23:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724654045; x=1725258845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PVKhJvWevINCBH2qBuQO224gk6DRTc+AR1O2dLVPxfk=;
        b=KFv8mioO6b5UZqb/NciDh+fsByh9ERiCdut2FDSAPK6PnmsuCuj4G4ZeKv+d8O6YGr
         GexpPBFdW2sktxf9q4pzF4nnRao7OvI4rlpaGDVbPW+m7s9gJsUI/mE2lEl34iKwd+cl
         k+dLXoCvsa06q7PC6PCMtR8/7DYhWTs8BPVxRMA/vnXZJ4fu9t87ITxTx3uWt8vHB6Ni
         GACc6Fo8c19UPsTzTA5Ldp2dDhO1KpJiZVww3zTOQjbQbsEMQmLNkpLr+tak/5Q0R8/K
         hYkbpLYcZIbtJ2vC/xJJsvV0fAA7zrng/UPiUT7s1HGURZVXCV9k635lVxbxrUBmqID4
         Pbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724654045; x=1725258845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVKhJvWevINCBH2qBuQO224gk6DRTc+AR1O2dLVPxfk=;
        b=t5cBJ7ki46UnWPvyp/8Yy1Ql1IvWb5C5NhQrl0WDJr/dncIVKubJqs1qev5G+0hEoi
         Jy3JzNX6Kw8pwcV0BmDjVBJx7Vss67UBMGXe/oIVX7JFg+k2l9yuA/4tA9+/qG7m2RH1
         GCcsllNjhWyhzoWFKlNBJH1iGmgIGw2yYWtCy9aUZIvVvyMYfvY/gzA7Uyszqda+DITC
         XH5hs+8BK+K46Tvs47zcFwPuN0KUiBUzgAEoRplqeuL1IktuyoRzatDYHk+rU5U/qzwA
         JMSccwxkS5/zw7rzYeo2tKXdmDV2fZ339fjZruclv8TmuZzSHojxt7gMbBnebToU3cLe
         gOow==
X-Forwarded-Encrypted: i=1; AJvYcCU7Wcg31Zsvfj3eXh67x3KGtPaVn0aTFfUbBS8VIHL/gMnyMjInKM9hezJN6l4uVMgfC+QbrusoYPJNvSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpP8nL+9dwv5CH/4Gxl6m726P04wOUusulPGAtS9mnUBLhf81y
	DGAvzTVax0xImbkhAmvLTN1o5pxTvF7Cy+h80qyTCIHGXLY93TDiDwO3pX6Z5l4=
X-Google-Smtp-Source: AGHT+IHoy8mTyOxGm8laDg2utdl6ZPS732jQpJxtvh9UZHiw5iSkQt4l5jJLs4LhlX4N8QgJo+tsrg==
X-Received: by 2002:a05:651c:209:b0:2f3:ee5a:ab8b with SMTP id 38308e7fff4ca-2f4f494246fmr61411181fa.43.1724654044600;
        Sun, 25 Aug 2024 23:34:04 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0515a94e7sm5211639a12.89.2024.08.25.23.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 23:34:04 -0700 (PDT)
Date: Mon, 26 Aug 2024 09:34:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: Change slot number type from int to
 u32
Message-ID: <535bf435-5f50-418f-ab69-84178bc49d90@stanley.mountain>
References: <20240825072955.120884-1-riyandhiman14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240825072955.120884-1-riyandhiman14@gmail.com>

This patch introduces bugs.  I wrote a blog entry about how to choose data
types.
https://staticthinking.wordpress.com/2022/06/01/unsigned-int-i-is-stupid/

regards,
dan carpenter


