Return-Path: <linux-kernel+bounces-359421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D83998B3A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2982953A4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899F11CC152;
	Thu, 10 Oct 2024 15:18:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BFF1CC886;
	Thu, 10 Oct 2024 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573504; cv=none; b=YLNNGwZp8WWUm0HBxMWcc9J6iXkgB8o7j4csfpJ4XMp2kNiszKfIGV4CCte4iW9baoPTWbK1fkYP2jdI8H73niFJ+Snta5Wtn6qgW3i7P3aPHSJHZuA7v871h/g56EC/2ORXXQSrnKNrLI0YGIE/PeI12j4OieVRUegSpKTRDsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573504; c=relaxed/simple;
	bh=viwaf0hIsbX8/+JoR07qZxwwVnqj0e5fG/3wM7QAPL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqhYYuGaB0O/IJxCfuRjDFwGtYqG/z//aoqWeSnfODaV1+1VS0DCh7LQLrmHlckNpC7rgs83KR5WTK+HTzczoxby7n4lqkBVIU80YWR666NwNzlZc2H575feLxXKN0lIbKeLo6nnk1nAVtuprusKo8byjvAdV9qyTLW101/8iqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DB31497;
	Thu, 10 Oct 2024 08:18:51 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F5253F73F;
	Thu, 10 Oct 2024 08:18:20 -0700 (PDT)
Date: Thu, 10 Oct 2024 16:18:12 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Johan Hovold <johan@kernel.org>
Cc: cristian.marussi@arm.com, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	quic_sibis@quicinc.com, konradybcio@kernel.org,
	johan+linaro@kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: Skip opp duplicates
Message-ID: <ZwfwNCRLbjYBsSQP@pluto>
References: <20241009143905.2440438-1-cristian.marussi@arm.com>
 <Zwfn-kGr1yYP8Xff@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwfn-kGr1yYP8Xff@hovoldconsulting.com>

On Thu, Oct 10, 2024 at 04:43:06PM +0200, Johan Hovold wrote:
> [ There appears to be something wrong with you mail setup as the patch
>   had a bogus Reply-To header:
> 
>   Reply-To: 20241007060642.1978049-3-quic_sibis@quicinc.com
> ]
> 

Hi Johan,

unfortunately the setup that is wrong is indeed on the other side of the
screen (i.e. in my brain :D)...since I mistakenly added a --reply-to= instead
of the --in-reply-to= when trying to post with git send-email this patch
against Sibi original thread (which is the bogus message id above)

Apologies...

> On Wed, Oct 09, 2024 at 03:39:05PM +0100, Cristian Marussi wrote:
> > Buggy firmware can reply with duplicated PERF opps descriptors.
> > 
> > Ensure that the bad duplicates reported by the platform firmware doesn't
> > get added to the opp-tables.
> > 
> > Reported-by: Johan Hovold <johan+linaro@kernel.org>
> > Closes: https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > A new version to include in this series that should address the limit case
> > described by Sibi...not tested, of course :P
> 
> Thanks for the fix. This seems to do the trick and gets rid of the
> warnings about duplicate entries on boot and resume (including the
> debugfs errors).
> 
> Tested-by: Johan Hovold <johan+linaro@kernel.org>

Thanks for testing !

Cristian

