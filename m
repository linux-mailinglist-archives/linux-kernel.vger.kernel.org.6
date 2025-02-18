Return-Path: <linux-kernel+bounces-519579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2287A39E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04295188C87A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B14269CE3;
	Tue, 18 Feb 2025 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWqri9ad"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15118269B02
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887560; cv=none; b=tUpsKIy3eLv+QrhxAP9nySVW8fHrCFddcs8Pyw288ZTWFpYQbSNtu6vVTOYZ/bm/hLOZzY7kCDWe4onbM61R3LoALpGaYROamKakqVcyqtUZWeuKpGp5NEA6tTqmHHBauMyhXuszB8rr6AMzC7aX4OmlkT0/Nym/x0ii+LkcgJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887560; c=relaxed/simple;
	bh=m74LP55OcTY86xa5jiDw1WmtOxbTVddWPS/0z262Gmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V4Y62B9Zs8fmwuF9VsvnR8sISMCcFFqtlpBUVOBMDiUBC+twBE5Re8gfPWy9SxrM/Arxs+viX18V51FnsMtT5cO1aTfbXBQ63kHFFpdSHVEZ32kuGRSg75TjG8me+flGLysYxwWvouWhw1BelxqStqsnv8jiBasvTzB2u2ZeMRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FWqri9ad; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739887556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMrruAE5SiJm5VJDlkLG+tKoURFhiL1O+/bcGgjwo1Y=;
	b=FWqri9adEKleNCZxhcGKWsVstj1goPHGI0ij9ureWHPCiSDBFBch0j5ESqrhYYeCe9HOof
	g2Smw855h8xuZjA24/CsjZGSiTSkfsLl0kyeaXxiUPUYORv+VYa9E4K3+L6N4vUsEoA6VD
	58zW/z+mIqvOg883rD/CA6ItQHWIZe8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-EAQOEwS3P0aUyqi_ol7Jsw-1; Tue,
 18 Feb 2025 09:05:55 -0500
X-MC-Unique: EAQOEwS3P0aUyqi_ol7Jsw-1
X-Mimecast-MFC-AGG-ID: EAQOEwS3P0aUyqi_ol7Jsw_1739887554
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC1DB1866D90;
	Tue, 18 Feb 2025 14:05:40 +0000 (UTC)
Received: from [10.22.65.116] (unknown [10.22.65.116])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 45BE31956094;
	Tue, 18 Feb 2025 14:05:38 +0000 (UTC)
Message-ID: <87850a70-4a93-492f-a6b5-fec5d5480cf4@redhat.com>
Date: Tue, 18 Feb 2025 09:05:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: Sagi Grimberg <sagi@grimberg.me>, kbusch@kernel.org, hch@lst.de
Cc: bmarzins@redhat.com, Bryan Gurney <bgurney@redhat.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Marco Patalano <mpatalan@redhat.com>, axboe@kernel.dk
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
 <ea0e6445-9770-4df9-91bd-80f44cd0388e@grimberg.me>
 <ea9537d5-721a-4b37-84d1-df797646fce2@redhat.com>
 <ccc171d1-8de3-4632-9483-71fd5ea63d46@grimberg.me>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <ccc171d1-8de3-4632-9483-71fd5ea63d46@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 2/18/25 3:19 AM, Sagi Grimberg wrote:
>> We can send send a separate patch to address that problem, but this patch, which simply removes the nvme_core.multipath parameter
>> has beeen fully tested and is ready to go.
> 
> I think that we want to print a warning in this case though. Can you resubmit with logging a warning in this case?

Agreed, but I was thinking that warning should go into the second patch. The second patch should disable all secondary paths when
CONFIG_NVME_MULTPATH=N and a namespace is discovered with NMIC enabled. Basically, we don't want to instantiate more than one
namespace when CONFIG_NVME_MULTPATH=N.

But if you want to add a warning to this patch, we could do something like this:

@@ -3909,16 +3909,23 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
                 disk->flags |= GENHD_FL_HIDDEN;
         } else {
  #ifdef CONFIG_NVME_MULTIPATH
                 sprintf(disk->disk_name, "nvme%dn%d", ctrl->subsys->instance,
                         ns->head->instance);
  #else
                 sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance,
                         ns->head->instance);
+               if (info->is_shared) {
+                       dev_warn(ctrl->device,
+                               "Found shared namespace %d but multipathing not supported.\n",
+                               info->nsid);
+                       dev_warn_one(ctrl->device,
+                               "Shared namepaces without CONFIG_NVME_MULTIPATH=Y is not supported.\n")
+               }
  #endif
         }

         if (nvme_update_ns_info(ns, info))
                 goto out_unlink_ns;



