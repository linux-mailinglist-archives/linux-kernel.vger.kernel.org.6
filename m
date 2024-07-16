Return-Path: <linux-kernel+bounces-253272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A09931EE0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86A41F22476
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABB0DDC0;
	Tue, 16 Jul 2024 02:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H8MQ33Od"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EF3182B9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721097071; cv=none; b=IwXq2Ayw3Fas/asz+W/9KkBYaVuO6Cyjzoy5dZz1geNLBmeB5w5uF/bK4dijnuBZEQ2ClSYDdMO4204LJJ+ixz06I2wMeN6T8q6eqkQ6CiOAFl1aIhh4ih6N5O7QZeYX5EHo362sfBrnUyepD918opS0qPU4J/xuMvVYCNAYFGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721097071; c=relaxed/simple;
	bh=mXtlf6yx+UQfOiM5Bt9On2FgzKxuGLzAdiKPY6+VSM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QW7kzlpeSb8LHlvjXQ21AWyRkR+LlRoK0xueGIKOgijDRu39P3P304Xxf527YjZPSftSZH4FER8vQxIDRdsPHok/kKXdV6qq3UPDopyPPIRqPxcsoEu5yExrdS9KvTkeZlaI9Q+1nckYMViizXeks4w0PIROdsA0jCGJVrswfhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H8MQ33Od; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mXtlf6yx+UQfOiM5Bt9On2FgzKxuGLzAdiKPY6+VSM8=; b=H8MQ33Od/V+0Y7VflaQ1IgXUZw
	a33kzLtCYRtLr1YScZRXUJy7/T9ytk6jrsVXuYcLHj1GjXtnaHxtKirNJlyrrFlHm0qEmhX+tiQ0Q
	DBFDsN7RS7nQN1RhGSA1v4zMsLnycJvHrOPcXxfXa9ySrlLo57P9KwL9GXYdEbz7/QkTXqLFKQLhF
	vUEAPPOLO4jwqjj1OmQiV46teFPywDk3nsNjY3wYL2fBVwMsjCcAVwSrNUDbnMSSlkpQkaiCF5LSP
	2eVKqeNbC03eyeYQXY7NSceqUBGkdvJvrhNTg6RJGDXWVxTiuvB/YK0fsMbonRSffjsJLPFqe0sTr
	PKUKWGDQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTXy6-0000000Gcqf-0eUV;
	Tue, 16 Jul 2024 02:31:06 +0000
Date: Tue, 16 Jul 2024 03:31:06 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH 1/2] radix tree test suite: include kconfig.h with
 incomplete path
Message-ID: <ZpXbalVnI9FzHMHx@casper.infradead.org>
References: <20240712074151.27009-1-richard.weiyang@gmail.com>
 <20240716021543.ghzeiq5yqtov43lk@master>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716021543.ghzeiq5yqtov43lk@master>

On Tue, Jul 16, 2024 at 02:15:43AM +0000, Wei Yang wrote:
> If you think my understanding is correct, I would send a v2 with proper
> changelog to describe it.

It seems like you're trying to change something that isn't broken.

