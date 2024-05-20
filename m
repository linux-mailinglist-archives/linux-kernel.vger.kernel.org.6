Return-Path: <linux-kernel+bounces-183465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 243648C9960
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3141F2169B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 07:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6043718EA8;
	Mon, 20 May 2024 07:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GPHSzAEO"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B3718C3B
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 07:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716190526; cv=none; b=icfnUw/XlKzxYpT6QuQK7KVxthFm4y3ep6eDPZHMNETaUVcx7dl/axuQ4cqQK3gzWs6fVZHuMIez1/RQZ6/QE9uTMzchyUoAv9nu9tLqkhOxYUwNSGxAWT1sCRLv64XXYUx6XVXonRm6zqpToaQ+h9ngsciMOUM9SKc2xma4RYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716190526; c=relaxed/simple;
	bh=CreGSXMBFRDdh+HIhlg2OcR+mWGxYmJCDZEvadFcUiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tH07j8fFEhxW2OaLe6vEf/5Wme2cLVZq2+kbb8tr3kB5E62f4je0OqLbwjXGiw7Tw1+dyVgWmfT1UYjsPBE0IhZ+uoXXHV8kWSx1Ktw7SWdqCI1S3sR6KRX+Jz82Z6B5jeV872TFXSQhoWS/5kRemKuSV8VWNe9UmGsUAc0b01M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GPHSzAEO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ec41d82b8bso75573685ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 00:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716190525; x=1716795325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TdeskcQGCOqUgsMYL0wvQIQkx8Opxo9clxqEYF92eYc=;
        b=GPHSzAEOfrDshMyMDR1sf1Hx1I+UK5XRkpI/RG+LDkJO/JgO9YcUuvUakpaXJI3Qtc
         V4XPrGCWDT6HHXZTuzAJjJ5ts7GfpHM8wHtnCvhh8NuaQKj1j8zFFB6cu5STuEiGyDOF
         KGdWa3FOmu0Ggdl5/aRjY79jNGVDnHgIIT8DworrQOYWoFG3tRZ6JHCy9b3B0NBTpksd
         ln9V4OSmmZzj+6YGQB0YWtiAcSpXw28Y1FtbqVN6DbmMFGDReMbrApjOaX4LZwy0LcDn
         PiumhBgMJvKtvydlOeAGw4SFUMghvWvtXr8rjTDe6S0V5sNReBLjxBZBtf7how/kAftA
         CU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716190525; x=1716795325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdeskcQGCOqUgsMYL0wvQIQkx8Opxo9clxqEYF92eYc=;
        b=CkueOXjSSSakcI4UGApvJNNlltlFZiunqHo5PxD85T4hxeUUSn2AlNECl3EOkpSlgk
         fDcssS1YgwIh6elbZCp2ZWh2fz78PZNcYkW4DoQUqqZAqdg5KKzixCJRFYjZqZ08ek0Q
         zuGDdSuG9ueXmyqTxbS4TeK8M1QWGBCzyxq1SqY4mkzVxZES2+G6+BvIuavL16XLUNZ0
         LSOo7LUjiV60GyViPajWVUnkts47HcuOpYIm/Jx9U9Z+BTyEV3+UDMONF9l8W394esBO
         ECYf4Pii6cqZoVOpFu9qmN45ZVoZvrdeF5ZZA94xkC0Qdl9Cj+hPAHBNc/gakR7qaCJM
         sCVw==
X-Forwarded-Encrypted: i=1; AJvYcCUcBS1WMiGqUiNAeD6MOgKf7BuVPOBdiV86U0jV7SbVu6wev/RvhVZOST7yraXhKzsLGVNS5ST8E92G5G7q0pQ1knCb70EEqNMzV5ry
X-Gm-Message-State: AOJu0YzAgu4D4HJEvImfwDxJMxzRV3IFCJxb0qjFJnhUDN0vYryo5kHp
	QDzNfnkEESP7JFvNAcJIU84GSYicmkT7lMVCGy2GsK91GZFpPW0dZ3vXcBO16Hw=
X-Google-Smtp-Source: AGHT+IHPnUMf1hHaC0TYUlsq97fbQdCCRP95VeDkuaFDGW9CA2YAIYyeywDjHu54+bcWgGQVcpgq7w==
X-Received: by 2002:a05:6a20:c78c:b0:1af:cb89:15d7 with SMTP id adf61e73a8af0-1afde1035a8mr32774233637.27.1716190524677;
        Mon, 20 May 2024 00:35:24 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bd7f6c90f0sm1214435a91.2.2024.05.20.00.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 00:35:24 -0700 (PDT)
Date: Mon, 20 May 2024 13:05:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vladimir Lypak <vladimir.lypak@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] OPP: Fix required_opp_tables for multiple genpds
 using same table
Message-ID: <20240520073522.3nhy4x6fnrqxay6x@vireshk-i7>
References: <2eb72832e852c80e5c11cd69e7d2f14cefd8b1cb.1712903998.git.viresh.kumar@linaro.org>
 <e6fc06eb-fe52-4cb3-b412-a602369ee875@leemhuis.info>
 <CAPDyKFoHoKK-RZsGwnZhbW9_ZRQtL1MFZBuVVLMx-MxL2cQQbw@mail.gmail.com>
 <7c6df194-fce1-401a-98c5-c903d78627c4@leemhuis.info>
 <CAPDyKFqKRy6zJdBpK3bNTvkvAjty691-Vi_HV3E5CeqgRAWGmA@mail.gmail.com>
 <CAKohpomKbhdXRgFxxbg-_hG5EFZT0LrvfQcrwjQPon6AZNbGag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKohpomKbhdXRgFxxbg-_hG5EFZT0LrvfQcrwjQPon6AZNbGag@mail.gmail.com>

On 11-05-24, 10:03, Viresh Kumar wrote:
> On Fri, 10 May 2024 at 16:14, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > I wasn't sure of the level of urgency in this case, as I don't think
> > we have that many DTSes upstream that could hit this case.
> >
> > But nevermind, it should be easy to revert/replace the change when we
> > have something better to take over. Viresh, feel pick this up - or let
> > me know if you prefer me to pick it.
> 
> Please apply, while I enjoy my holidays :)

Merged to Rafael's tree already now.

-- 
viresh

