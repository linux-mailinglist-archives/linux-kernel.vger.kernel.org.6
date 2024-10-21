Return-Path: <linux-kernel+bounces-374403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C07C9A69AD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B892821BA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461ED1E6DFC;
	Mon, 21 Oct 2024 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+6HG9IV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34DC1F7092
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515897; cv=none; b=CplU0XmjfFS2x7Tufqg1rSoNl8XRShnVS3vW6AtxfYSeYTAtE0UohcGCclES9KA/bRmhF+byEETqvb+L1APJWb3IXSrTDgksjbvkCdEx6hV9OtSems6BwhIucehR4QLnAa3xlqR3PMO86Cuu11uJN9Kf6HCkINojxPoLnNw1YOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515897; c=relaxed/simple;
	bh=ZXsRzzI65oFPL+bLiMeRuzFe+GIf/sYuOmsoAjRMaoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAYwuR5K5Hce9oG7Qx2XlGasf/pgeN08GK+GrBAtqux0qgghcLR9CSwFe8APVzYyms6LJUU4Y4lyaAv0ip20cxpyNcE9Rt6tRge+qRrzpeUyFzKZ8vbDdIM6XygSjNZrp2dezZpQB0sdjnA/Lx9ncRlZ16kuMvU1OR5yy1hlKEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+6HG9IV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729515894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MnoXKlaAADuYo7UIHUrYglfpwoeZ7XCU5QulYnBo9iY=;
	b=O+6HG9IVnZgEn+7/6pqtTWv/WHtFt9vMp8KT7ZiCN7jz/Ux0JpY1fcgXbmYkGV4eqmY0xU
	p0MXlFolpoxV3iH6PmNk9nJCLmo9YEKFYUqgSG5BSk+lBRmHD8H6j24foQXJTqnOlVjNE9
	2oiLHJH0SO/SB2Eswj2CukjQ2RBkbzQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-DvCiHVakN0W9WuRLtzFoRw-1; Mon, 21 Oct 2024 09:04:53 -0400
X-MC-Unique: DvCiHVakN0W9WuRLtzFoRw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-539e0fa6f3dso3324939e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729515891; x=1730120691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnoXKlaAADuYo7UIHUrYglfpwoeZ7XCU5QulYnBo9iY=;
        b=sVSwoh59RUpR7182ubrwgEtEY+BTVYfg1znAJN9t0fX6p+WRcRAaPKjhgufQwLlxtk
         C3XcEwbnyjLcgiN69uy0/CKL+pSK00WE1FblqC6Q3MBGBQTvRz47IrbUUGAnz84BJkN3
         1gxxc8sAOsVzJXU1eaDFz9hb+lLi+iq+K4dsKiOzDJDddw0TO7LNufHnMHdwv8CtgN3t
         14GucIkUf14rqpNgfvb33I8umCCsBPXGPZumiQb6JYgmj8DiGAAdsSTWspFIfb7Qbtb2
         iF27c4S+PsvaX1ralWkd9wsm8pOkZG61HAv/Kd/a4WbUgP5RgzGQcncsqpQjKVADnwnM
         wHuw==
X-Forwarded-Encrypted: i=1; AJvYcCUzNQ3oqnZqS7Cs4qyzfqA89LrAU0jlvU8DL1WJochdpBYrutzov1UICKGzb44Ae9PtEFLkWh3+YUG/Br4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3T82rD8SZV5O7zNRXgLvvVrmLrDLTTbXBtqJYrJDoUdVi4oj2
	QEIS8uOIYtKu77/rRHW+8ktDvr+QToL/tio9dhl617z+mPQQQzjQNLbZQt/jnLKP7XpD+xWDgjP
	0AftchcT+Bx44l6nh7Eww3iQJvtPJYnLiaeM9fA4X2skbmF3+vtM/jRyptcxJgW6wPbdK4zoY
X-Received: by 2002:a05:6512:31c3:b0:535:6baa:8c5d with SMTP id 2adb3069b0e04-53a15444970mr7461445e87.20.1729515891549;
        Mon, 21 Oct 2024 06:04:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL4sQ4qrfDrX36WQMDxjmFjytkGRNimdA+M0d/Uy0JJag0mVaYAC5dva1+mNzQ1SHOAQb0kg==
X-Received: by 2002:a05:6512:31c3:b0:535:6baa:8c5d with SMTP id 2adb3069b0e04-53a15444970mr7461413e87.20.1729515891071;
        Mon, 21 Oct 2024 06:04:51 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d636csm201407966b.36.2024.10.21.06.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 06:04:50 -0700 (PDT)
Message-ID: <4b9736fd-82db-4863-a251-80d82b375e1b@redhat.com>
Date: Mon, 21 Oct 2024 15:04:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] platform/x86/hp: Avoid spurious wakeup on HP ProOne
 440
To: Kai-Heng Feng <kaihengf@nvidia.com>, ilpo.jarvinen@linux.intel.com,
 gregkh@linuxfoundation.org, jorge.lopez2@hp.com
Cc: acelan.kao@canonical.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20240906053047.459036-1-kai.heng.feng@canonical.com>
 <87d40775-9bd4-4f22-81da-4e670236c15e@redhat.com>
 <f6b62a45-c44f-492f-8f79-96b4fd54555e@nvidia.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <f6b62a45-c44f-492f-8f79-96b4fd54555e@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Kai-Heng,

On 7-Oct-24 6:22 AM, Kai-Heng Feng wrote:
> Hi Hans,
> 
> On 2024/10/5 10:25 PM, Hans de Goede wrote:
>> Hi Kai-Heng,
>>
>> On 6-Sep-24 7:30 AM, Kai-Heng Feng wrote:
>>> The HP ProOne 440 has a power saving design that when the display is
>>> off, it also cuts the USB touchscreen device's power off.
>>>
>>> This can cause system early wakeup because cutting the power off the
>>> touchscreen device creates a disconnect event and prevent the system
>>> from suspending:
>>> [  445.814574] hub 2-0:1.0: hub_suspend
>>> [  445.814652] usb usb2: bus suspend, wakeup 0
>>> [  445.824629] xhci_hcd 0000:00:14.0: Port change event, 1-11, id 11, portsc: 0x202a0
>>> [  445.824639] xhci_hcd 0000:00:14.0: resume root hub
>>> [  445.824651] xhci_hcd 0000:00:14.0: handle_port_status: starting usb1 port polling.
>>> [  445.844039] xhci_hcd 0000:00:14.0: PM: pci_pm_suspend(): hcd_pci_suspend+0x0/0x20 returns -16
>>> [  445.844058] xhci_hcd 0000:00:14.0: PM: dpm_run_callback(): pci_pm_suspend+0x0/0x1c0 returns -16
>>> [  445.844072] xhci_hcd 0000:00:14.0: PM: failed to suspend async: error -16
>>> [  446.276101] PM: Some devices failed to suspend, or early wake event detected
>>>
>>> So add a quirk to make sure the following is happening:
>>> 1. Let the i915 driver suspend first, to ensure the display is off so
>>>     system also cuts the USB touchscreen's power.
>>> 2. Wait a while to let the USB disconnect event fire and get handled.
>>> 3. Since the disconnect event already happened, the xhci's suspend
>>>     routine won't be interrupted anymore.
>>>
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>
>> I was wondering if there is any progress in trying to come up with
>> a more generic fix at the USB hub level for this as discussed in
>> other emails in this thread ?
> 
> This patch fixes this issue and IMO quite generic:
> https://lore.kernel.org/linux-usb/20240906030548.845115-1-duanchenghao@kylinos.cn/

It looks like during review the patch has changes and now it only applies
to S4 / hibernate.

So I guess we may need something similar for S3 / s2idle suspend ?

Regards,

Hans




