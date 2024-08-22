Return-Path: <linux-kernel+bounces-296816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031E195AF75
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B337A2837DF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881CD16A94A;
	Thu, 22 Aug 2024 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rosiQb9J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E9016B391
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724312388; cv=none; b=lzLidddtSjs7siAOoeWyYd1q0BN/NBrXGldZmQHOxXrlO+87rlBtuSYcPol3ETMEjzQkT50dkuUJJT6KsyyivmyJUrqv1dLk7otRxKFoqsAkA381+shR/BLwnCLbVSMly7uO9CK7PXB2evBthKoasboA6WYprgORt6eU5u0+WfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724312388; c=relaxed/simple;
	bh=0625ThzK5zTHjNczZ23OpAA40ALjr//ZGbsohg+iaHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDvvtePr1wZlDvW/0nHK7Yzo8nSGTkMMOcRT/Z8UYIcVdPMguvTZfcG/PKr0l6Ey1Y0WzwbYlN9eUlqfqCsH34CxtgBJwvp2KE3ttaEov+1ZJOLMmIjXwVWMMRyWzA8H12WGsfBcwpO4G2EslMaqBPABQJqpdIlLaPgdc066NsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rosiQb9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC72BC4AF09;
	Thu, 22 Aug 2024 07:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724312388;
	bh=0625ThzK5zTHjNczZ23OpAA40ALjr//ZGbsohg+iaHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rosiQb9Jqx8hTP2ZUBJuzppRq0iVIBnGbHdhCqP7eLFIKTgPvPFJvBYgpC7hXNJ1J
	 VW5OV9n69wpHGmZQVI6VtCkPDNlg76EYL35GAwzuGFELzp1JrDPfMudswZKTsIplCl
	 T5U2L3le36uPQFsJsmMJ9GqNeCbRurs+WicUQL4c=
Date: Thu, 22 Aug 2024 15:39:31 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v1 0/5] driver core: fw_devlink: Clean up strings and
 mutex usages
Message-ID: <2024082222-number-amends-e2a6@gregkh>
References: <20240821154839.604259-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821154839.604259-1-andriy.shevchenko@linux.intel.com>

On Wed, Aug 21, 2024 at 06:48:18PM +0300, Andy Shevchenko wrote:
> Replace strlen() + kmalloc() + snprintf() by kasprintf() ond other
> string handling improvements.
> 
> Use guard() / scoped_guard() to handle fw_devlink mutex.

Nice clean ups, thanks!


