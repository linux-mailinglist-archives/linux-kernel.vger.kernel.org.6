Return-Path: <linux-kernel+bounces-519677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E382AA3A0A3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916C93A3553
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5588626A0D2;
	Tue, 18 Feb 2025 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Abvx6xLI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF9426AABF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890641; cv=none; b=jxZzeMwwJNcHvjjwAnOeCSsux2Bi51xm3TBR1vBAGEgxuigOTgcWehw4NFIg0NODue/rwqtDqRUDGqw9UMYbHHw926wMxcp7rUibYmxau0ltXXLCohEwJNdMRBnMKBUuwEulkVGKnZmYXr19Tnn/aDr6872n4uFRihtpEn1Si5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890641; c=relaxed/simple;
	bh=tkzBRjr0ZYnzfzrcQzw0A/TkfNA5oVNet8zEjRq8tjQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=O2iXDzSPWGDoadMz8JVPG44t/t+p4MtG5FSk5E5olzfw8cL7pHNKjQFRVKhQUAkU2MWZuimgEJ308aQ6UNysnKp0g16N7FNI9qKsjzz6s6Z4dH5eC6107QLBCUKlgQb+U/EOSiNOLl8ZltTv325Mfh6vqGnW8FhwXV2KxwsIkzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Abvx6xLI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739890639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+4AZod0zwwoKSkEdpQmvjuKbyYTyP5Z7/IeKW01Ztg=;
	b=Abvx6xLIevjBwIpiS6g0IZjrsAprmpV511L+TMYmYlZOYBVMXd1smImGljpEXeJX17iDe4
	nmK3OXrE2gROYoZr3vfE0uCqH/0tcwg1f+dHDO0YU0r7c5+sV2d67MlqpzHz9yTulEmQuB
	x4O3kT5EDzjZWclEFYw+DBJZniyYcI0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-bkK2-au8O8CFbsTrdqMeEA-1; Tue,
 18 Feb 2025 09:57:15 -0500
X-MC-Unique: bkK2-au8O8CFbsTrdqMeEA-1
X-Mimecast-MFC-AGG-ID: bkK2-au8O8CFbsTrdqMeEA_1739890634
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43EE418EB2C9;
	Tue, 18 Feb 2025 14:57:14 +0000 (UTC)
Received: from [10.22.65.116] (unknown [10.22.65.116])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 121BE1956094;
	Tue, 18 Feb 2025 14:57:11 +0000 (UTC)
Message-ID: <efbab2b8-7723-46ee-a296-7e76bdaedc2c@redhat.com>
Date: Tue, 18 Feb 2025 09:57:10 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
From: John Meneghini <jmeneghi@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>, kbusch@kernel.org, hch@lst.de
Cc: bmarzins@redhat.com, Bryan Gurney <bgurney@redhat.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Marco Patalano <mpatalan@redhat.com>, axboe@kernel.dk
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
 <ea0e6445-9770-4df9-91bd-80f44cd0388e@grimberg.me>
 <ea9537d5-721a-4b37-84d1-df797646fce2@redhat.com>
 <ccc171d1-8de3-4632-9483-71fd5ea63d46@grimberg.me>
 <87850a70-4a93-492f-a6b5-fec5d5480cf4@redhat.com>
Content-Language: en-US
Organization: RHEL Core Storge Team
In-Reply-To: <87850a70-4a93-492f-a6b5-fec5d5480cf4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 2/18/25 9:05 AM, John Meneghini wrote:
> +               if (info->is_shared) {
> +                       dev_warn(ctrl->device,
> +                               "Found shared namespace %d but multipathing not supported.\n",
> +                               info->nsid);

Or maybe this should be

+               if ((ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) && info->is_shared) {
+                       dev_warn(ctrl->device,
+                               "Found shared namespace %d but multipathing not supported.\n",
+                               info->nsid);

/John



