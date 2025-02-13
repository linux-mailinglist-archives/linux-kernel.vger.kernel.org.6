Return-Path: <linux-kernel+bounces-512382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 783F7A3388C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4A343A376C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A843E207E02;
	Thu, 13 Feb 2025 07:10:49 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED8E20764A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 07:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739430649; cv=none; b=IuRraRMMTUlq/eqh/YM1Iqe4W9+T27D5DVhR0dNOn3Rbr7MmbYMH14MHVQ1ufPOfpVtKEswXzMnroAi6FBx66PNkHvzO7C+L/ye3NEx0yVJ4F8Um80Q+dqngWI+ovHDco1O9Z2wnNEfgT2bBm+U0mm6f8KeU/9LUHc0haI3hV4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739430649; c=relaxed/simple;
	bh=e7X3A6cuqeejGZR+4HMbZkMNXu2KpRXXLJWRqF7V/w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJ4aN1M0/UX9/8Be6VJztslFLPLZJ1z07sgp/vtpHn4umRwd26R6HKhgPhXvk0YLKP4V058IbhfPOwhQ8tR/tZGu96myOBghhQ2coWGgr+gHz2g+hfBsM7Ac/iHpoGWVj4E/rNsYLpLS1wmodXZWJ4IkwlgYrqnEwcomar0nMqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B75AB67373; Thu, 13 Feb 2025 08:10:43 +0100 (CET)
Date: Thu, 13 Feb 2025 08:10:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
	kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org, rafael@kernel.org,
	ulf.hansson@linaro.org
Subject: Re: [PATCH] nvme-pci: Use NVME_QUIRK_SIMPLE_SUSPEND for Qualcomm
 Snapdragon 8cx Gen 3 platforms
Message-ID: <20250213071043.GA21238@lst.de>
References: <20250126050309.7243-1-manivannan.sadhasivam@linaro.org> <20250208185124.GA1120888@bhelgaas> <20250210040446.GA2823@lst.de> <20250210063605.yp5rkraain5oqxka@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210063605.yp5rkraain5oqxka@thinkpad>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 10, 2025 at 12:06:05PM +0530, Manivannan Sadhasivam wrote:
> Multiple times? As I stated in the commit message, this quirk is *not* going to
> be extended for any Qcom platforms as the rest of them can retain the PCIe power
> state during CX Power Collapse.
> 
> And we don't need this quirk in any other endpoint drivers as this chipset is
> mostly used in Laptop form factors and only the NVMe driver is found to be
> causing the issues. Rest of the endpoint drivers (WLAN, Modem) are all coping
> with PCIe power going down during system suspend.

No matter where you need it - the place is the core and not the driver.


