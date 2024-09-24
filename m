Return-Path: <linux-kernel+bounces-337390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D93984971
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D485F1C22E75
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE5D1AB52B;
	Tue, 24 Sep 2024 16:19:40 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F25AD531
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727194780; cv=none; b=pQNH5jh4ZDjhMTyI3J2F910ZMuxUNCEM5B50WOaJpEAuZDQcE9i6lGS/FEJH1+cu/CaVwvlQnQ8Um4Ccdv3s2u+brzsiIOmnHmzD8Ohc/2KlarrODb1Wf/xMRpMEpE8bJits3tZjdFlOEx7GfPdMxR+6VWYrc+oOVDpiXHb6VZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727194780; c=relaxed/simple;
	bh=J0edZNYmxyTudz88gosgpsN4y/1SzA6o4oUfMRpZNkA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DtyHyHPhOQDh5rJBJdS0OpqBjMs9E7aMWBivFfq5bBUJ9u8xm1ihN6EfQOyLLkR23zqJ0q5buboYRvUg6xWhOgH6JipQK3GCTR5k/US7FGAPzCx3XgZ31A09RV8aKELsNiLjIAoSb0eEhqIfVORazx0DpePKEyZTq5IlGxUP7uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XClRb0Y40z6K5m6;
	Wed, 25 Sep 2024 00:19:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 49AF1140A86;
	Wed, 25 Sep 2024 00:19:36 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Sep
 2024 18:19:35 +0200
Date: Tue, 24 Sep 2024 17:19:34 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Gowthami Thiagarajan <gthiagarajan@marvell.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<gcherian@marvell.com>, <bbhushan2@marvell.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v8 2/6] perf/marvell: Refactor to extract platform
 specific ops - no functional change
Message-ID: <20240924171934.00002882@Huawei.com>
In-Reply-To: <20240919074717.3276854-3-gthiagarajan@marvell.com>
References: <20240919074717.3276854-1-gthiagarajan@marvell.com>
	<20240919074717.3276854-3-gthiagarajan@marvell.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 19 Sep 2024 13:17:13 +0530
Gowthami Thiagarajan <gthiagarajan@marvell.com> wrote:

> This commit introduces a refactor to the Marvell DDR pmu driver,
> specifically targeting the extraction of ops
> (referred to as "pmu ops") from the existing driver.
> 
> Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
Looks fine to me.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

