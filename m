Return-Path: <linux-kernel+bounces-285797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5B99512E9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA6A286DB8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203D03CF5E;
	Wed, 14 Aug 2024 03:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q5mAvL3t"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FB13BB21
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723604974; cv=none; b=t4zpNFNx/Hx1Esmu/PkZqee4iqKLMLuj+z7WeOE0WIgtvkRGR4zYJDUDe1fUMC4o6L2W1yKN8WKYduBzNw4Htzz7VgYEwzfU5Hihv3Gixrs5v1Pt8VWD4o4TE7tdAVf27slNfj6meagSgxnLwuLrSQ9IxYaFCG6CeEpSZqOtNHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723604974; c=relaxed/simple;
	bh=+18z8awbFGOMsFUf1GdjEuFhnPr3J1pE6Cvn3x0S7uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6zOh4E0z7FZpwBMloiey3HrKlP4m1SibkQns+nAMMCs/9s/pnTd2IUWMp3f4FLqTKZIt5Unnyu1FnEKi9witmPUeXnHFr2uH5nSqmGPCbzt7FrUfuTsMgq1K2Yhm3/UP8UGHgjd6Xt5quXzlCvs2YgFHNwNsOWY2XFZTY8cd6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q5mAvL3t; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+18z8awbFGOMsFUf1GdjEuFhnPr3J1pE6Cvn3x0S7uM=; b=Q5mAvL3txXBroM4xjozsCj8OSD
	QvAbMtIJ6iI4FikKqsMriiIjVkN4ccen+r/6NN7UE0sX8SvvMEGcOtnyBqZxgBoEGO36LHkwbcNhs
	RC0EnuNchT6HSFm8mV6EbVONUmOAW2QgpLceTFxMfzJ/b3Vo5y5XQoIQuWhgSYAcQZe0hDHt6HG/u
	6llpEZoU6rE1erTtyBiq/UWyWieDZYMXHaUB6tO3wII4qigD0UoEGwyky2JuUKKFB5KoKDpYF2nMf
	j4EoPcQZYkomq8+BcfTPUlHLW/w7j/wHjnXJ3OHh3mbst2pWgViJoujbjzQfPnGLcvZ6PuvMlpCYz
	DGCphtBw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se4OA-0000000HRGY-13SK;
	Wed, 14 Aug 2024 03:09:30 +0000
Date: Wed, 14 Aug 2024 04:09:30 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mirsad Todorovac <mtodorovac69@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [RFC] Re: [PROBLEM] =?utf-8?Q?mm=2Fvms?=
 =?utf-8?B?dGF0LmM6MzQ6MTI6IGVycm9yOiDigJh2bXN0YXRfbGF0ZV9pbml0X2RvbmU=?=
 =?utf-8?B?4oCZ?= defined but not used [-Werror=unused-variable]
Message-ID: <Zrwf6sxlHVYDHvVx@casper.infradead.org>
References: <b604b19d-c548-4795-adb7-3d0736b8b560@alu.unizg.hr>
 <cda74cd5-e6b6-4be3-9d01-387ee1fbc229@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda74cd5-e6b6-4be3-9d01-387ee1fbc229@gmail.com>

On Wed, Aug 14, 2024 at 01:18:42AM +0200, Mirsad Todorovac wrote:
> A little homework might make the #ifdef ... #else ... #endif forest more readable:

Please don't do this.


