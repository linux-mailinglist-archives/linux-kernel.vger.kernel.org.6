Return-Path: <linux-kernel+bounces-557183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A86A5D4A4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 04:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA32D1745AE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 03:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0401BCA07;
	Wed, 12 Mar 2025 03:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZaoMwDRo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBFB79EA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741748929; cv=none; b=rMZHWomwYbVKainL3TH2ZVop6PbXI1a9qcRoOCLbQlP1t/qaConPKIpSxiHJJCx6LHSTZU+6ECzGhWzlBZRAklztzHUUEWd69FRBYnKpNkXDyIZsLoifOTUGJjf52wCOnI4E2DbqsS6+Q+n+nJ59ToZDtc/BdtsTeZBUsEd4AMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741748929; c=relaxed/simple;
	bh=6zOPvTNiXKwH5hho8Ng+De+yAB8g8hyXwQGnyP/i/lE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tvfvXly4+2cD90SREd+m2rohr7rY2FnbJoEHIJcH7s/F8FekD3pygYylbHd5hCR4WWuWAVrGj2801+d6AI2pyIiv28YDrq1TjJ1BHf5pV9uI0S0gjCjgwEBf0NZ3HuMDTJ3Q8VMCG8yHRPjES1Uc/enACC+JDz+Ja4l5eWHEdxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZaoMwDRo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741748926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPbjQ3LyJEVdlvelmk4xTYprYRGR8Y0T9tIA9nw+UI0=;
	b=ZaoMwDRo9zXNHgy1kVgrUEcUgc8MzVaF6OjJZY0+Qmcd49DZUxulncHEmeAEFF6YdghR0Y
	2YnrYa628PWyCgouJhdc/Etg9ix/OwBI6zEMHiE3dJw48ddoBRb9Et42x44EScknsE7keh
	Qq4Vs6PmgB9NoVk93T+Ckf1D3LVnNiU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-LP3YnjyvPRCORz_uBG9ITQ-1; Tue,
 11 Mar 2025 23:08:43 -0400
X-MC-Unique: LP3YnjyvPRCORz_uBG9ITQ-1
X-Mimecast-MFC-AGG-ID: LP3YnjyvPRCORz_uBG9ITQ_1741748922
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D37B118007E1;
	Wed, 12 Mar 2025 03:08:41 +0000 (UTC)
Received: from [10.22.65.26] (unknown [10.22.65.26])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 87FD21956094;
	Wed, 12 Mar 2025 03:08:38 +0000 (UTC)
Message-ID: <ca96d675-7ada-42c0-a3b9-6ced9e399ff3@redhat.com>
Date: Tue, 11 Mar 2025 23:08:37 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Nilay Shroff <nilay@linux.ibm.com>, hch@lst.de, bmarzins@redhat.com,
 Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
 axboe@kernel.dk
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
 <Z7Sh-3yHbXVmRbNL@kbusch-mbp>
 <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com>
 <Z7TARX-tFY3mnuU7@kbusch-mbp>
 <2ff87386-c6db-4f2e-be91-213504d99a78@linux.ibm.com>
 <0656b66c-dd9c-495d-b1fc-4f09e763fa66@grimberg.me>
 <Z7dct_AbaSO7uZ2h@kbusch-mbp> <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 2/26/25 4:55 AM, Hannes Reinecke wrote:
> Plus there are some NVMe devices out there which _despite_ being PCIe do report NMIC and CMIC set 
> (I won't name names, if you came across them you'll know). This is causing stacking drivers (most notably MD) 
> to behave vastly different on hotplug. Having the module option is an easy way of debugging (and, in quite 
> some cases, fixing) the issue.

So some MD driver configurations that use PCIe devices that report CMIC and NMIC need to turn off
core.nvme_multipath.  Is that what you're saying?  Are these PCIe devices multiported?
  
> If the module option really causes issues just make it read-only; that
> way you can still set if if absolutely required, and at the same time
> catch installations which try to modify it.

If we do that the parameter can't be used to support use cases like your MD driver, or Kieth's ublk driver.

/John


