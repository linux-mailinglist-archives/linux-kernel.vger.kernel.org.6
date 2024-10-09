Return-Path: <linux-kernel+bounces-356156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC91F995D28
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 03:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ABBEB21607
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 01:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D2E2943F;
	Wed,  9 Oct 2024 01:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XP9QTP+C"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B2218EBF
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 01:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728438174; cv=none; b=N37If8AcK1Dwm402H9J7TGhJKIPlA6vUfxCaCJzQyNGiwSqugz7QzajGEybU/jHjN0kRhLiZ280CVgjmYd3rBM0powBqyK9uuQnG9n1+8k6UDnLV2ThPyBSSfKkFCxO3NYBqXp5NYPc0DAnEdIdFFiNJjtFLC1s8/Ev7h3aHzbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728438174; c=relaxed/simple;
	bh=on2LqNJOLLUlgEZbmX0NjEQT2X0ys37jMjR11mjqtgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CObsJ3JtMlvUfY7qBJ1gdPF7t2YjT7H1iSS9C2SjsGiK2cjJlRJawnkgSczPQWr+vbTYuSOGZPNVOvVn4sg2H/7aau6E0wvxz5hIDgsE+1uj6ehaQazzvSEDrJpeLjpChHwSHSmmo59I+jTNgdXdxbAnJkrD1rpYzOhfAJ20xmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XP9QTP+C; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728438169; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hYQPusyvrKSUfWo+Hmtwuzgi0loTd1yKbesF1iF+YPI=;
	b=XP9QTP+CYhYyPYArJm8v9vvzAZ5enb54LrkZ7+5XYKd+Eu6raJYM4zpbE/7k6i1mY2ul+kRE/tTEWGatlA8RQDugV2PCj6ALyyfA3PXBwUBqmG/8cuc0HplxqRnADomrRKgYFk1nZjBTt+ch5VZqgAfvSNHlFYUbfXkzHQ+pcTA=
Received: from 30.246.161.56(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WGgjsqE_1728438168)
          by smtp.aliyun-inc.com;
          Wed, 09 Oct 2024 09:42:49 +0800
Message-ID: <41a0090c-5c2f-42d3-b8a2-92ec094fab96@linux.alibaba.com>
Date: Wed, 9 Oct 2024 09:42:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] perf/dwc_pcie: Load DesignWare PCIe PMU driver
 automatically on Ampere SoCs
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Jing Zhang <renyu.zj@linux.alibaba.com>, Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241008231824.5102-1-ilkka@os.amperecomputing.com>
 <20241008231824.5102-3-ilkka@os.amperecomputing.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20241008231824.5102-3-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/10/9 07:18, Ilkka Koskinen 写道:
> Load DesignWare PCIe PMU driver automatically if the system has a PCI
> bridge by Ampere.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   drivers/perf/dwc_pcie_pmu.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index 3581d916d851..d752168733cf 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -782,6 +782,16 @@ static void __exit dwc_pcie_pmu_exit(void)
>   module_init(dwc_pcie_pmu_init);
>   module_exit(dwc_pcie_pmu_exit);
>   
> +static const struct pci_device_id dwc_pcie_pmu_table[] = {
> +	{
> +		PCI_DEVICE(PCI_VENDOR_ID_AMPERE, PCI_ANY_ID),

Hi, Ilkka,

Does all Ampere PCI bridge use this IP?

Best Regards,
Shuai



