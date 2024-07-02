Return-Path: <linux-kernel+bounces-238158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E53924517
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D29B1F21DCC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D50C1C005C;
	Tue,  2 Jul 2024 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFvpqLCT"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E6E1BF330
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 17:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940674; cv=none; b=QJ1sfo8swvq8pluXOloqDbfRSYF7gzbskqpZDECGdfl6n3SAH5WyP5ajCl4eSQuOjZibiJlOSkWIaICeT1EG43fov1htNQmzf4NA6bnuwjwkX7dvszpqk5+bPpuVvyfx6tbcpK2OkbRjEzkOv3wGlintl5ROfSIPNVGmWV8vH64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940674; c=relaxed/simple;
	bh=lP2LIud1g0sa3kAm3+mA+w6VNI5/RRh8XoxWEwh4aDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQE9NQOHP/q30/oLHHl6lYkbWzZCYwnK8nrYJwZnLryUf4x+WByHLAVd8btq8/8XGoDXQfqbTwRob8lfIjebaVt5RV8DvQKxxkQTu192FH+LnMZQx2aDvIID7Li8oOO1PzJ4zB3ZJitKcC3+UtwmrNsdWWluPoVZ/DVNoO/y6q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFvpqLCT; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c93627e773so2557655a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 10:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719940672; x=1720545472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unr8tLI2rSOo5jyWjsTXearnI6B7VetjKPb8shQgSHM=;
        b=YFvpqLCTB9clM5RL6hvbELahQWHZUtbByopuWkdOkzF/FpMUJVFXRaIHCu91QpgTSu
         5fu+pqD0bmx/rDnKihcvvJ3bOT1jitsXXROpGi7xhqoJ2KnM5f5DZjK1SS68Vmu7rh6E
         GkSLNdmAzj2HULrnfDoPXSkS2Pzy8zJ/Z3DaFLV4hRzecO4TkcDjDCHSVdVOuGSGI/B+
         +s9rb/GWFwOUP3uDvl8BHvjsuukvEm+q8YSadlvagsGwe5loJZD98z7BE7HE738IcaYP
         iRDzkPLujGeaZLqnCh03OGkqR+pUnQcc1G3SJzDvOShPqyWQleP9f4/RQmmiOoG2GHjh
         1avQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719940672; x=1720545472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unr8tLI2rSOo5jyWjsTXearnI6B7VetjKPb8shQgSHM=;
        b=r1WLG9qpXf4yellueu1L62pAF1aPtv9YIForkBzhcRN6VjXkZtm3D4Xc3ACT9hmnd4
         BmnnQp7v1WT5UYB+NtQ5xUhsyBNMY0rPGVbrhscCef5QVKKtZkrUbGsnPRmXOV5TV224
         xTQP5Rk8QpGZJhJb2ga7jwweZam9mVxchmfXKl6n3/ujthvpBtN6A45qEzPVvpywMw3E
         dbZU7ZvH5/wLs6A72zDOdG4uN9+5VeBLL9AmtcVB3YIpndoFJDzJdSkgp3BjMSumDShY
         Z5FpvYejTvoYHkpXJqM8NRKlAkU56sw0ZcsHMSGhpiZ/yHC/j/V8L0iyDRrOnnvkEsDB
         ab/Q==
X-Gm-Message-State: AOJu0YyY2ofgFkUJK9Qb+9ylEG3H0Kx2hc0Wr85N5kEX829Aqnv9BlON
	HIId9vd+R0I3vS+wDv29ERtYFlfpTXjoUqpxStd4SLwqv8/C3O92
X-Google-Smtp-Source: AGHT+IGXMiWdmOO/OUlzaaxELnH1ouQLY7IN7sNrn4DKSr5Y12VhWITXqG8BivmY4L8pZn6glWacQA==
X-Received: by 2002:a17:90b:4b4b:b0:2c1:9892:8fb with SMTP id 98e67ed59e1d1-2c93d6d4a44mr5538265a91.5.1719940672384;
        Tue, 02 Jul 2024 10:17:52 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce4668esm9153218a91.21.2024.07.02.10.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 10:17:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 2 Jul 2024 07:17:50 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 0/2] workqueue: Simple fix and cleanup for exclusive
 cpumasks
Message-ID: <ZoQ2PtHGYEkAtR25@slm.duckdns.org>
References: <20240702041456.629328-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702041456.629328-1-jiangshanlai@gmail.com>

On Tue, Jul 02, 2024 at 12:14:54PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> Simple fix and cleanup for the commit fe28f631fa94("workqueue:
> Add workqueue_unbound_exclude_cpumask() to exclude CPUs from
> wq_unbound_cpumask")
> 
> Lai Jiangshan (2):
>   workqueue: Update cpumasks after only applying it successfully
>   workqueue: Simplify goto statement

Applied 1-2 to wq/for-6.11.

Thanks.

-- 
tejun

