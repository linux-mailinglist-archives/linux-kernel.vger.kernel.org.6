Return-Path: <linux-kernel+bounces-261077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A62E93B29E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19C21F21E2B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE652156677;
	Wed, 24 Jul 2024 14:24:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9838D1E867;
	Wed, 24 Jul 2024 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831088; cv=none; b=hVgG/NJpjI4w4XVLtn4/JB2/hlVynmj7BJuOkX+K/THgroKNS5ghHFhob/OeYDB3UVCzd2/AM9TatkEYEgwm/eueASjzrKxSvpRK6legOjzEWnVWwc8DL6Bn/nP3Aw4PqsQ5UUgSgR4xEwzc8KB8dVqP1xUqHxSvuWPbEUm8jbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831088; c=relaxed/simple;
	bh=XXzhLQeI/4UdioAad4VnWoVlLlJqTjrKl8RM1Kw8kfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dE7eIs2YDrWigq26fpQKgc020c8Hh8ivro6jWMkUMp2n5LLAaho4K3TBvkhjumCWaU3RbM9tWtJwDokRD+sZMuiWi6fPcKtzB3JEY197kUL6PIqZ15Ppyn+AYHcnV6S2yUFvYinmJZTMHMTRIezDELDM5x1DFuRYHhaxdYP4wS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D3A7106F;
	Wed, 24 Jul 2024 07:25:11 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 925F73F5A1;
	Wed, 24 Jul 2024 07:24:44 -0700 (PDT)
Date: Wed, 24 Jul 2024 15:24:41 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Luke Parkin <luke.parkin@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"cristian.marussi@arm.com" <cristian.marussi@arm.com>
Subject: Re: [PATCH v3 3/5] firmware: arm_scmi: Track basic SCMI statistics
Message-ID: <ZqEOqTi9c4LAZI2l@pluto>
References: <20240715133751.2877197-1-luke.parkin@arm.com>
 <20240715133751.2877197-4-luke.parkin@arm.com>
 <AS8PR04MB84500E870B3BBD1FD270609388A22@AS8PR04MB8450.eurprd04.prod.outlook.com>
 <57e6bded-8d10-4db8-ad2e-11dfd126205f@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57e6bded-8d10-4db8-ad2e-11dfd126205f@arm.com>

On Mon, Jul 22, 2024 at 01:21:31PM +0100, Luke Parkin wrote:
>  > Just wonder that since ftrace is there, why need this?
> 
> Hi, this series aims to provide a useful debug aid for running tests on the SCMI
> subsystem. As you mentioned, ftrace does report some of these statistics,
> however DEBUG_STATISTICS will allow a programatic interface to access the count
> of failures, successes and an extended variety of other specific
> errors/statistics for automated (or manual) testing.
> 
> Hope this clears things up,
> Luke

Yes, the idea was to have some continuosuly running counters that can be looked
up (when compiled-in, NOT in production) to check for anomalies...ftrace
are certainly more detailed in these regards BUT you have to enable them
at runtime and then dig into the log, and moreover do not cover all of
the cases like these stats...

Thanks,
Cristian


