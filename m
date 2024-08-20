Return-Path: <linux-kernel+bounces-294522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B68E958EB0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 21:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9851F21C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E01615855B;
	Tue, 20 Aug 2024 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ds2RpUyi"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C6314B94B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 19:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724182777; cv=none; b=oz2VkmuYW3EAPx/WRz0iiJkL601b0KzdgRbfsS21X5oZCFuGZHiGz5Bjs0M9OrOes3/n/vFPE+bRNqE7VwXVALtYV6Vd61lV+NB7lDUSwb5vu4n6YWlql4tsGymk/32tncXYGILYyBjt+PoMlGpsc+utwiSwMkdKDUO4QTurjgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724182777; c=relaxed/simple;
	bh=p+73jwOiRMEHDI4VnzsLui6gVDUzdN5EU2KnrT9exYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTSCGjTP/ezVEV/2D7slBNW6KpuVhCC+MzRhqolHuCzMpJpTtDie4E3iP3Rvs7IObbfmfGX8VqiGoPjPEWLQUNa8VeyRvmHZDHwlNNM6qk4VSKrGkRKe9T4RQr0ODyliow0Bw3TpZgNhyvm61ZKwaQQBDGxFRq/3OH5cpEU3BNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ds2RpUyi; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2020ac89cabso34638815ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 12:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724182775; x=1724787575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHg+MoKApNaJfmLhEFw9WuAJlYQTCMn8fl375UPubwc=;
        b=Ds2RpUyikyAu2Nho2x9Pl/26H7/gAPZBHilnX+swdaalmVJzlP4KU+tnFcf3M9GMVv
         hxQpfMs6uIH/5K13iFkjIunMHquarILgLNg1jB/QLlrBLy6Acz4qVfCrBolOUt+Yb80A
         BlLiOD3/AAG420KRMXflAV0F9i1OHUJFDk6MtUiGljq73YK9gkaWiPeGk1K0NwMUoQup
         VQSFRfcEqs7xkIMTxXTS+6/r8yRhZHY/1vM3+1AB5Vy+FKFnig4BtRv1IX/YcvFIvuBB
         Yot3blzrN6pGphEy6zAHRO3PyJUi+uRKc0G5geUA/WaqSnRaA2IH+aDoDGmnEl6+KuVV
         3xqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724182775; x=1724787575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHg+MoKApNaJfmLhEFw9WuAJlYQTCMn8fl375UPubwc=;
        b=VBTQ+RvgdH+YMmWz4xM4eqY4EhilIauKtNbRd/Un2OmLhfZjQNepTGX+kcsaRT7Es7
         71vLeyiyKNFJOXmgvf0fTvWHXrDR6dnsWA9aP7jAZZv7ylZmY5UCZZRf/r8iKS91/3GS
         RZRvrGWSSgNx44nbzXCmNYZDb/Rzi9pnD11c2wDgrFOty4SsQYkQoJ6IbqGap3vkJvqg
         odPT5oUK1rkynIbrGOWQ6dZ0ZNcJqnQiA65AiVqH5KPxTfuV2+6B6WtZQyB0ast+89Mu
         BOrplEzxsWdg6FSz94er6sOK4cH7lNvYieHT6EBdqIRjbcz9TxFvai57O9lucu0qnOWc
         sFsg==
X-Gm-Message-State: AOJu0Yz/ZmoczGahb8TsLo9/k28XXdHrafgF//HIZk0xWIIhtB9m9Fc3
	d3OJYvruqdjMyKnQ8OryrBG+hZPxdtN09XWbrXzRWqA3IPHX02Of
X-Google-Smtp-Source: AGHT+IGiSpj5xxWhBReJwd/6rFOdUiClRwT1r4HdmPHUdG/UlfaYlsS+JnB/+Y3xmBSSWdNAVpdD6A==
X-Received: by 2002:a17:902:dacb:b0:202:4317:79a4 with SMTP id d9443c01a7336-20243177c0emr93142955ad.33.1724182775392;
        Tue, 20 Aug 2024 12:39:35 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0375626sm81200035ad.156.2024.08.20.12.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 12:39:34 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 20 Aug 2024 09:39:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: linux-kernel@vger.kernel.org, senozhatsky@chromium.org,
	jiangshanlai@gmail.com
Subject: Re: [PATCH] workqueue: Don't call va_start / va_end twice
Message-ID: <ZsTw9YH-R2tPA8CG@slm.duckdns.org>
References: <20240820193808.1127501-1-matthew.brost@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820193808.1127501-1-matthew.brost@intel.com>

On Tue, Aug 20, 2024 at 12:38:08PM -0700, Matthew Brost wrote:
> Calling va_start / va_end multiple times is undefined and causes
> problems with certain compiler / platforms.
> 
> Change alloc_ordered_workqueue_lockdep_map to a macro and updated
> __alloc_workqueue to take a va_list argument.
> 
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>

Applied to wq/for-6.12.

Thanks.

-- 
tejun

