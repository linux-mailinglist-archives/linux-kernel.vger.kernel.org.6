Return-Path: <linux-kernel+bounces-348666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5D398EA32
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACE5F1C2225E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB3984A22;
	Thu,  3 Oct 2024 07:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VnRZwKqg"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE1A84A27
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 07:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939656; cv=none; b=nPqDWtsbZBnl0CaMoBh+M+RmpOXMAdWKHQX/zphTLEoKHnLHlRIJ9hdTwu5Gj9KVj/lkKNS4L/X8BStV4TzgLr6jpmbmql8xztMMsBLMXNXKg2ZhiNzRrs+dkKm1TrB2F7rikLMPW3pjZVWqNLg0IjGMbncd3JuIOUgS5ssODys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939656; c=relaxed/simple;
	bh=rnCYbVwISgvzQVboy21nf7Z1AYb6vbTzmAfkgBhkYAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPiAf7mnCOF199RtYfsVomjiK6V/AcetEbeCm51kJdf+awkpyfNAPTCX95ZkoVEnTaMJGKap2+6Lvj+2GCAhvGiLXvzvQ84pzBCqKkYFtXWH6LQ/KRyRa4kkNhNDtlDTeUXRD16E5Wdsfnlq72e6S/rLYazi09cmucbGBLqyCho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VnRZwKqg; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b1335e4e4so5710945ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 00:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727939654; x=1728544454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0/Uq9tkcCY4Z9Y0M4J4n4ZTY4ZNPUaY8aYtXqjP/jKI=;
        b=VnRZwKqg+PIHfAql4DCT6/P7/taq98tr9YuhYDJey0U+JUUnz6nDkW/D/d3ZNSVCm5
         GnXwjYNooZSXeUf0lPa/kOcfT2uSYrvUG8O1AoV0tRlWtKl8LpUgx4q1EBQmCq3kxvt/
         sG4nuTxoIOrbtfrUNFbn20+6ePUTGCEweeoZFK0U9c98vXbHd9TjUAxgfgtFxoU2Xj+a
         RNZm8/nIlSMpBhBaY8MTwhzgSuhE7DSJ6zfG7c09WksyN9RCWz8o9DfDa84YYWtcNCD3
         cGvzlqkXYkBEQxxWCnbxP3qdxbdBF+TPLWmPm1xx6weQR0xr28aClfImbZA39ixfsHZp
         F0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727939654; x=1728544454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/Uq9tkcCY4Z9Y0M4J4n4ZTY4ZNPUaY8aYtXqjP/jKI=;
        b=XHE/lUnl2++bv0rpyRZtIiVKchUn2A9VNqn86dXDCN11ZQY1ASbE1TH95ivo2F0KBS
         cOZ1BXQl8I9SPRjSb8HFEPdDfrKeXpb2rntMsI0SvczT8Epuz5P3LK+BGuDtiFtTHh0y
         3BftDRGyzq/JQUuudkIVQix/ganuVy7PCiqYP9ZnkC9cg0hl9E67VsagcXPqdgepVjFu
         v9Cs8TwspWQJXogD7qEz4U5eNZ8xeAdvYBEIPXbQRRRIG9LyOoR7VUpxrsqVJZ8TKOEA
         /9aW3TMllU80475/7mNDdR30iSdJBFFcYEneG0xK7or5Owb4aD/RumiCvzzSh79plkM/
         Xaig==
X-Forwarded-Encrypted: i=1; AJvYcCVMXnwvvJJnQfTopgOTufSwO0U794kZUdDAaAUzplqBSDHpHXjACYgIxmKlj0fTJQPLPL/JYDqf71W5LEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/BtXHwwOfrVSwMOFE3TrIi0QzTbGFnxXklHn321ZYQJK08/sN
	2T60OUr3SSijD0T2s5s5CaWkPYxyjy28qiZbG/omFBeX9VVDmJrA+Ayjhu/jEmc=
X-Google-Smtp-Source: AGHT+IH5ip0y/7dbLpJy/zrNgjlhVxLD8xYzpS7Yi6sWbO5a8a6piAQZB8S2CXnGMq1Q1WPiBAhy/w==
X-Received: by 2002:a17:902:d491:b0:20b:4875:2c51 with SMTP id d9443c01a7336-20bc5a01e73mr79268295ad.27.1727939654336;
        Thu, 03 Oct 2024 00:14:14 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f770b30sm2919794a91.15.2024.10.03.00.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 00:14:13 -0700 (PDT)
Date: Thu, 3 Oct 2024 12:44:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Vedang Nagar <quic_vnagar@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <quic_kdybcio@quicinc.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ilia Lin <ilia.lin@kernel.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/11] OPP: Rework _set_required_devs() to manage a
 single device per call
Message-ID: <20241003071411.vvhqb6bxxnrbkaw7@vireshk-i7>
References: <20241002122232.194245-1-ulf.hansson@linaro.org>
 <20241002122232.194245-4-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002122232.194245-4-ulf.hansson@linaro.org>

On 02-10-24, 14:22, Ulf Hansson wrote:
>  /**
>   * struct opp_config_data - data for set config operations
>   * @opp_table: OPP table
>   * @flags: OPP config flags
> + * @index: The position in the array of required_devs
>   *
>   * This structure stores the OPP config information for each OPP table
>   * configuration by the callers.
> @@ -48,6 +49,7 @@ extern struct list_head opp_tables;
>  struct opp_config_data {
>  	struct opp_table *opp_table;
>  	unsigned int flags;
> +	unsigned int index;

Maybe name this required_dev_index as well ?

-- 
viresh

