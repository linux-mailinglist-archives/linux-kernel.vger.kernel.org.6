Return-Path: <linux-kernel+bounces-538635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C69A49B3B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F5293BC930
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CA326E14F;
	Fri, 28 Feb 2025 14:04:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A695925F984;
	Fri, 28 Feb 2025 14:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751468; cv=none; b=FG5vcYMzs78mPeVvjioVZi88wPFyZQwiDf9BJxMWb3K5G9KiU/cHy9vTyYdEUn8gC9vZnJQkZ7JHxTEovsTkHZdWRlpAKGUFEQfwZvaDjda1/LsCsJmCY5ntzr57C13z/MGa1i+nMc1QxbwUod5hLPOyDqZUR1xP0dMUQ5rzIrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751468; c=relaxed/simple;
	bh=1lmEBu63cYbLTK76KGFv2Qip+2pW2SmO02INamDKcgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0+psJTcUFu+KUgaumKEG0f+6J7jdhBPXygzOa0436jEjSgB8VUYn57B7XjbNolJ4iFPAKbaEsIWGXNHmjcPYgtESGg1nxKRQFUwm62jce75bcJtoCd1GHe4nOuIazVIYpeP6Xdd7LeJVlLdnNkhUI4riJT8wDrLma43nP+Qn+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AD981515;
	Fri, 28 Feb 2025 06:04:41 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E94613F6A8;
	Fri, 28 Feb 2025 06:04:23 -0800 (PST)
Date: Fri, 28 Feb 2025 14:04:21 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Rob Herring <robh@kernel.org>
Cc: Peng Fan <peng.fan@oss.nxp.com>, saravanak@google.com,
	cristian.marussi@arm.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [RFC] dt-bindings: firmware: scmi: Introduce compatible string
Message-ID: <Z8HCZQQLofaiGtpG@bogus>
References: <20250226094456.2351571-1-peng.fan@oss.nxp.com>
 <20250226160945.GA2505223-robh@kernel.org>
 <20250227030924.GB11411@nxa18884-linux>
 <CAL_JsqJOqKeDRuASWxCT=EA5LJbONpCX=Re8=XxKUbPToWy2Dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJOqKeDRuASWxCT=EA5LJbONpCX=Re8=XxKUbPToWy2Dg@mail.gmail.com>

On Fri, Feb 28, 2025 at 07:34:09AM -0600, Rob Herring wrote:
>
> - The parent driver creates child devices. The child devices can
> either reuse the parent DT node (i.e. set dev.of_node) or just get it
> from the parent device if needed.
>

This is exactly what I was thinking to deal with the issue since this
discussion started. I will give this a go. I believe this must solve
the issue, but I didn't want to spit it out loud until I tried to hack
and check.

--
Regards,
Sudeep

