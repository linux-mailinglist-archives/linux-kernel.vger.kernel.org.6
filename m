Return-Path: <linux-kernel+bounces-327749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F5F977AAB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DAC228193F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB761BD4EB;
	Fri, 13 Sep 2024 08:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="hQ1sYzGq"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D550E154C04
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726214849; cv=none; b=QyWd+IyYJzNIw/XifSp2mNORchDqzBvpVpYMpf+93oAHtzseMUa4coDuDD7AuDcshwRHE9JFHPzdGZD3+foTNCvk+YMNSsRdCLqTJ/BmaeI54di06JSXCIw90+I1OB5QvB7YHXQMzd2Mo0zuzqVbaD7WKjJTBW0VbFgK3q9Ej1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726214849; c=relaxed/simple;
	bh=yqwLZ2LI3whzMjlCRXdDh07KaVH9PUVEAxZ1ZiWkd9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JMPAO6rfNG66LECnvf5t8HFO4ElisIp3Mi7spBc+cbr+3I5LVzMIHGEA+RDX5sBPa2p2oL4FUdjTqxrvc0PVdQ+Ovh+ASm5UP3M6hN4X7kUhDQned2E23aK+EbExcmKmklsjxebYwHjDmoJ4q6jIPiMRyKqFUOBzo91E8qorHYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=hQ1sYzGq; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id oyyBsMKtyg2lzp1KrsqWjy; Fri, 13 Sep 2024 08:07:21 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id p1KqsZOD1mqhip1Krsp4KJ; Fri, 13 Sep 2024 08:07:21 +0000
X-Authority-Analysis: v=2.4 cv=NdEt1HD4 c=1 sm=1 tr=0 ts=66e3f2b9
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=rpUMG24A1zG+UrzXDtAMsg==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=XDqWC4Y5o2EKXtXKao0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6KfcZtPVeZZV/1trMGJbgYpR83sGh6LCzvZuwD+hI2A=; b=hQ1sYzGqhnO9XQDtwWNSTBhuyX
	5xBTO8VpxiBaSx6ob4XmniY+X0tIUGO+l3OMHXgwLUPPBY/tXpOYQU+jqGP1A/Wqpt9grR4pctGDd
	/SmrnwLT18OH57s7mYh2SmuJtrYFs8IEM0Db58ioidys2VIYzOM6xWSrSIrxEcpQhJFzZxPDoPd1N
	R+QDOH+KTaRGqaHiyHEzxyJ88kxVGoYbtlJbPbRpyrOpB1TM47FIaIS7s9a7CgL4GMrVEzUG1broa
	9kepKcT0OdcSDUAybAtqcgQhoxnTRrL5ak4iTv4KeJDgrUVpIyioe1fj5Q90mstj41uU/sZpjNRed
	zPD6wtLg==;
Received: from [185.44.53.103] (port=33586 helo=[192.168.1.187])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sp1Kp-003hly-34;
	Fri, 13 Sep 2024 03:07:20 -0500
Message-ID: <9fabe73e-23ea-49f2-9c06-17766a07fe9d@embeddedor.com>
Date: Fri, 13 Sep 2024 10:07:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] xen/pci: Avoid -Wflex-array-member-not-at-end
 warning
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <ZsU58MvoYEEqBHZl@elsanto>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <ZsU58MvoYEEqBHZl@elsanto>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 185.44.53.103
X-Source-L: No
X-Exim-ID: 1sp1Kp-003hly-34
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.187]) [185.44.53.103]:33586
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNrTLV6CtgMvAvPIO51s6XYCac8nFJ5BaLGLs393Lr4qNPo/cwnT6ZqFfkI1LfJTClFb5P5ybL7z1PdsXm3i3OdVwz3VHvIT6gqlivk24dsu4AsjR/A5
 zwXJyBtaCiTuPaNRF3p1WkOSf9JMI4/HgtldQPphHinBveIAbXcECYITd7XoakIe2tEfmpdh4uZPQGaJnojJScDWfFwkpY/SLpqMHe5oAzEQuSXEQMpFbUrM

Hi all,

Friendly ping: who can take this, please? 🙂

Thanks
-- 
Gustavo

On 21/08/24 02:50, Gustavo A. R. Silva wrote:
> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with this, fix the following warning:
> 
> drivers/xen/pci.c:48:55: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   drivers/xen/pci.c | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
> index 72d4e3f193af..a2facd8f7e51 100644
> --- a/drivers/xen/pci.c
> +++ b/drivers/xen/pci.c
> @@ -44,15 +44,11 @@ static int xen_add_device(struct device *dev)
>   	}
>   #endif
>   	if (pci_seg_supported) {
> -		struct {
> -			struct physdev_pci_device_add add;
> -			uint32_t pxm;
> -		} add_ext = {
> -			.add.seg = pci_domain_nr(pci_dev->bus),
> -			.add.bus = pci_dev->bus->number,
> -			.add.devfn = pci_dev->devfn
> -		};
> -		struct physdev_pci_device_add *add = &add_ext.add;
> +		DEFINE_RAW_FLEX(struct physdev_pci_device_add, add, optarr, 1);
> +
> +		add->seg = pci_domain_nr(pci_dev->bus);
> +		add->bus = pci_dev->bus->number;
> +		add->devfn = pci_dev->devfn;
>   
>   #ifdef CONFIG_ACPI
>   		acpi_handle handle;

