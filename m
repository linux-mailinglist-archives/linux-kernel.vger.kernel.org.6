Return-Path: <linux-kernel+bounces-554855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73305A5A1EF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE7C3A660F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F60B231A24;
	Mon, 10 Mar 2025 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZtBQFUKu"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F025C1C57B2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 18:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630504; cv=none; b=diPqLk6q75WUsIEYi86PdnLAI38GsuEW2Cfwp59CvwylAWZszftydzZPt0PnLf3W9f9YnzqVeGT1AdPamIp6MRSremBI2700RPmyG4lM/pav5F3F7Wga0DScHAJKFgLupHN4AO4fM8mU5aI64NevW4ly+BXnFmgId9CX4qORRvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630504; c=relaxed/simple;
	bh=JtQ4T7DUXV/4zbw/s9ZH5QQTnRitO6guKWphr/3ZL+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6QzrFhp2rRyVklSsks1/FX2fBqehfjk/tjssup1zCGtHOrQgjOqUxlof5e8J5nLYOUwkFyyRhlyTQHGBWoIU6/kfF5s+e+/0rgaWQRwfcswi42d3WQmykjvR032u0KO9SPo9h+wZYRTr+rgqS3eCnMKi91KdNfT7yVQObCw1b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZtBQFUKu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43948021a45so39304125e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741630500; x=1742235300; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l3RzlGFhAvuM0cuDF00eJyPgemDXX9EL9Mn84ikQ4pw=;
        b=ZtBQFUKuzE6Qx9/6tqBcGKu+ekc87RGrOeWeqwW6ST81kNHSDDC61cMJwTvfp4JXGp
         5p8jQzFnO0P1bFMvjRRJsyixuohINrtpGnVFJullClIJT3IdPCYWjlba8KuTClOHRizT
         MqGz9KHj86mNMsn5P3uDGScppRQK1sEgxvgrSpeylVrkOSAsnyMW2r04c39UtaqpGKZX
         sQzAxAx8MdxGIrGcj9z3jEZ0CmX8VDEI0jNgvaFNfw4BDUtdkuyG29SYXKUgqE6la36E
         e7W+8VdFyXRnriPagvcb/kcZ0ncG6/1jS27hcXBnRzrC4ICLJJeOBNmtocLcZKUFyawZ
         NtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741630500; x=1742235300;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3RzlGFhAvuM0cuDF00eJyPgemDXX9EL9Mn84ikQ4pw=;
        b=gRCr1zmrq9VlRghz+hdIToAKog6bh/iglEzjYdm4ACk9vlt5uHPFMYN9iAruTKKTBc
         V4jTkUnjfMnYT/pokeE7UqGsDTTDhrwL/0v0IJzqJ3dON9ydD4G7/1nNL0GAbApH1zkB
         VfB9kkq3tr5xXVObAL1Y9050BoEIODvZpNfLX0qu45vMWp7ZqWBjM9Aa2y/Y1qO905g1
         7siLH6naBD/5kVrIM1ev2AfoBza96gL64Bx89pahXuLCZcsYyokBZs2eKM2D2R5iDHC4
         FikAlA9zoVi1ahkM14u5XHnp5Q1LHlyVEKsnwNAFLybzVzCyPc3XL2pDH6a4ygPmUiG0
         QEjA==
X-Forwarded-Encrypted: i=1; AJvYcCXhbnk059t96ucunIQVubf/OXYtoQZJptTRP2imClEucTrg2WapX0mOT3/kDQGqHLaI13nsLQvPJiFMgY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMz+bEwPj0Uoy7UVIwnIFR1JdKESLQWwCp9PZSwIiRL7VWQyWD
	/80K7loSqAm8Uc753exnZ2Q5wJSFud6GNQuX8kFmfbD8dKWCDGO37774FHZ//Ik=
X-Gm-Gg: ASbGnctfTfp4DfAjh6QbHW4AlHUGe8gUhw2Pg9QmvneZAQoL+jj62RoJewMiDJv1yaI
	/yMJEgityXhJrg+clZ5adK8ckYELVNPcivTIQNHJP0FiwTgO3O6zMmipzF9U6l3YNyKKEE/W426
	R4RQg0jLnozqypOxNV/D+tg8qEn1yTY0YttSQ1Ybhf4Zj2pECNUzFnAlg6Uz45o0nfQla0rVevy
	JUJzy50huKCrRyyjbb4VxqVefH1dEsIq/VH5uPCHDavMcsRDo735Vb1XDifx7dD+5RQC61m0Yof
	w42mLwNTTm72GJ2cNrjsb9eSBru12Yp1lWy3eYCrFcpkZ95hFh5SIz1SlN6p
X-Google-Smtp-Source: AGHT+IFt3w/t0krndV7nu2YZ6CAjcoMbnNHYnSPvnNwZG4aH7mpi4yFNuonaavUpPD2h5koG09zTWw==
X-Received: by 2002:a05:600c:3b21:b0:43c:fee3:2bce with SMTP id 5b1f17b1804b1-43cfee32d16mr19567085e9.26.1741630500212;
        Mon, 10 Mar 2025 11:15:00 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43cf7b88494sm45446875e9.0.2025.03.10.11.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 11:14:59 -0700 (PDT)
Date: Mon, 10 Mar 2025 21:14:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vchiq_arm: Don't use %pK through printk
Message-ID: <eb4eeb0c-7cdd-44b6-a9bb-11133ff55925@stanley.mountain>
References: <20250310-restricted-pointers-vchiq_arm-v1-1-dd04f208ee55@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310-restricted-pointers-vchiq_arm-v1-1-dd04f208ee55@linutronix.de>

On Mon, Mar 10, 2025 at 04:53:33PM +0100, Thomas Weißschuh wrote:
> @@ -2003,7 +2003,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
>  
>  	if (((unsigned long)header & VCHIQ_SLOT_MASK) +
>  	    calc_stride(size) > VCHIQ_SLOT_SIZE) {
> -		dev_err(state->dev, "core: header %pK (msgid %x) - size %x too big for slot\n",
> +		dev_err(state->dev, "core: header %K (msgid %x) - size %x too big for slot\n",
                                                   ^^
You deleted the wrong character here.  :P

regards,
dan carpenter


