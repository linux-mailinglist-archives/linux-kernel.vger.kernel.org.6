Return-Path: <linux-kernel+bounces-225421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A412791305A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 00:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D894B25EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B55A16EB6F;
	Fri, 21 Jun 2024 22:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwofSAjH"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78952208C4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719009289; cv=none; b=eIaekdWj1LzT2hxZP33c2p5pLwDfQXZWOSHFhCmFyCnQyuK9XUXky9JpXOVz7RCcgQv3QEjYy+HT8vvNlw/r6wJ96oTzziE1V4rTOza+lgP9luPLBYgxij3pxiUel+418GYLa4RKay8KKgAUvqZCJr8bwcO0ssSrsPOp2jHirlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719009289; c=relaxed/simple;
	bh=Rnbz2OWst5ZciivU8s+Ua+8J5IcvjGALgmFz8GqwDkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RV5RvYOHKyfrl7JQmeQZ5UOUfTJ4vOlOjO42x3BUvF6AbBfQSaU+/aVjKSpG14zY4jibvWw6ntuF7SygzA/tdSnzioC6aIiuohTW8320lFaP1bUgRDbka5h8j6ETslTeuoz/0mZFl49O2tVwZHWX6++RkArCnKko+hbtBpK8pkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwofSAjH; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70623ec42c2so1888615b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719009288; x=1719614088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uq48Q1GcyRPbsspGGh/x++AxwvVja4oEc9/9Ey9k5dQ=;
        b=BwofSAjHfLAK0qFq5g5FHKJfJl8VqtvPHaiaf8+MjhWh+L51DJM1Z6cIQu7J6N1LQF
         7R+YppeyzlzeygY/1AdeMrhoDtAUMHqCpryYFeKobmw0V/3EqpkEjCgO1tA2oDxNvzGL
         Av4M0OzmQ/V6T3W2qcwZGAB7loGxa8xJYggbNiS6inG0WxxSd7MEEta/eYb5wqtUuJdW
         Q+O/Zdon6jOU14k5f2REURuaRcjTxaoNNkxiS2MwKXofWCsZ7244Oo/8UYmYwCNXV/pF
         /dPuBHkN8KIPvpq62haHJVsnZ5qGczm2KYQKnzbgmejDN/dGDu9jEXevu12hOZ2ejg06
         /cJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719009288; x=1719614088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uq48Q1GcyRPbsspGGh/x++AxwvVja4oEc9/9Ey9k5dQ=;
        b=a+nNj1IuQLTmGyn4i98hl1nXOT4Zvp3JaGlWkj6VCiphrw4+KlsiWlUq11FFpmsaVP
         BIonLm69lrW4NQKujD+xCspqTk11HtgTVwK5z+4qpQpywS51CyUEEq1gcX3cVSzW6YOG
         w5IoFbFv0BnIG73HXtmCEVLl1ybJi8CeYgeVmb2kgmsE46EnMBCta8tIuyJw3TQiJCjM
         +iWhAigpngWvzQ8vESQnSCGM+9E3axvwVZ7YSNN/uXD8SLhYTptkm3eiOk54s3qfZKKb
         8w7LukhmbauerihJHR04bCECaemOTr14OWrFbK2X9FHwklp2MDZr5q1o2AYZITL+Tqay
         lrgQ==
X-Gm-Message-State: AOJu0YwyDAgG6rwNvIWxWaStaLKv4FREggRrvGnnLhbm+1T37VQiNquP
	LvkCZtcHKnFtoMK4ilzfKHue6vytFxDJybP/ECsfvy0Y2e+oS834
X-Google-Smtp-Source: AGHT+IFEFEnfw/y5OUi+qGoU/xyMOcBYufgS9LI9YWGLY8+mI1K+8A6A0QslaNQHR+WgfFX9/iRWdw==
X-Received: by 2002:aa7:82d7:0:b0:706:2a38:94e2 with SMTP id d2e1a72fcca58-70662e8180emr1384600b3a.12.1719009287617;
        Fri, 21 Jun 2024 15:34:47 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065129012asm1985462b3a.146.2024.06.21.15.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 15:34:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 21 Jun 2024 12:34:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH 0/4] workqueue: Destroy workers in idle_cull_fn().
Message-ID: <ZnYABsDYrhfoa0RA@slm.duckdns.org>
References: <20240621073225.3600-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621073225.3600-1-jiangshanlai@gmail.com>

On Fri, Jun 21, 2024 at 03:32:21PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> After e02b93124855("workqueue: Unbind kworkers before sending them to
> exit()"), the code to kick off the destruction of workers is now in a
> process context (idle_cull_fn()), more destruction code can also be
> moved to the said process context to simplify the destroying.

Applied to wq/for-6.11.

Thanks.

-- 
tejun

