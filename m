Return-Path: <linux-kernel+bounces-294159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B04958A19
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A4C1F21604
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969961922E9;
	Tue, 20 Aug 2024 14:48:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C811922DD;
	Tue, 20 Aug 2024 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165298; cv=none; b=f4FLEzMjBaJKh8Pv/WInIpB0WoeG4BVXVg5kfcU20aLDuK/XPgdd4y9gLcKjM4ZXNWgX+jfcpXfSqW/w5Dm6Am8nK8bZmi9RI+6ZmlvwTbY6UZwSk9yDIwBvuBbjv+7FLhRhpliOGkqIgmSFD6Gc+LdauA+Y7dnWMyJjgIJKd2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165298; c=relaxed/simple;
	bh=Tb22dduees/8qZVbHW/1yyoCMCxgQQcl+0y4YdF4B+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKP0tpMyt8mKYCMefpoQJa92YcDaP76Z7MzcplgK1/zF2h7/cGnZQQtNmKp14dcAVyIfz55ten8yl3pMZ21XQg58Pc5oPH7CjCPTYicnkiHoWShwVIxjjVirhthXIYHL6aQObbm6oYl0aYpp6VEqReopYzNM1E2GjoRUXx0Y3xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39577DA7;
	Tue, 20 Aug 2024 07:48:42 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.198.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A98113F66E;
	Tue, 20 Aug 2024 07:48:13 -0700 (PDT)
Date: Tue, 20 Aug 2024 15:48:11 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, devicetree@vger.kernel.org,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	quic_nkela@quicinc.com, dan.carpenter@linaro.org,
	Sudeep Holla <sudeep.holla@arm.com>, souvik.chakravarty@arm.com,
	robh@kernel.org, krzk+dt@kernel.org
Subject: Re: [PATCH v1 5/6] firmware: arm_scmi: Use max_msg and max_msg_size
 from devicetree
Message-ID: <ZsSsq_Do-KEyy7vU@bogus>
References: <20240730144707.1647025-1-cristian.marussi@arm.com>
 <20240730144707.1647025-6-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730144707.1647025-6-cristian.marussi@arm.com>

On Tue, Jul 30, 2024 at 03:47:06PM +0100, Cristian Marussi wrote:
> Override max_msg and max_msg_size transport properties when corresponding
> devicetree properties are available.
>

I am holding off on these changes to think how these max_msg and max_msg_size
can be used without breaking any platforms allowing space for the header
and the message itself which is around 28 bytes. The binding itself looks
good. We may have to adjust the value passed to the core driver taking
the above into consideration.

--
Regards,
Sudeep

