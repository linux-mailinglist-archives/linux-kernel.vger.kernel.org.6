Return-Path: <linux-kernel+bounces-186017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1FB8CBED0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC5E282FEE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1808C81ADA;
	Wed, 22 May 2024 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="adgRT1jj"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE7781AA7
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716372005; cv=none; b=KxC/Qg8beA0aToK/q6NH5/lCU4bo6Pi6G0LCKalZM+n3D7lUUhE/Z+uEStf5aVIUyuUnSGDfy52zDFx1+MkybQNvN1ldZcADiyii8tRmyWlBEta5yMMv9yp43HbC5YNVKvGt5QnSwt6v7JtZfat30sblR5U6+cjAHX7F7cQBFVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716372005; c=relaxed/simple;
	bh=UnqolDuaYo8ErtJbe0FrOtS1sHe1/V3hT1Cq1/3MYAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i2tNSqJw1x5QBN4ZuN+kLeakwRk0+NDyYZiGip26xZ7qdu430xhvCaGRCz4jgE6kylm0OKUR3b9vCLXBPqMBGMrGUh6v6eeSgRANv1Y2LoXCQwakKlCcuoyMKVnzkFfI0pioR+V1v0/sK4wWeXucxJcsyPrXctl0hDMzyo+zphQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=adgRT1jj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41f9ce16ed8so7668155e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 03:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716372002; x=1716976802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zv0peKN7El4wwmaoW8dg3u0DkCkTmb42hFB9WP4X0fc=;
        b=adgRT1jjTUWWMuv66KXsEGQ3+OWRlxOl3QCy2ARKJIc7jVMx2ntZnAF0ajFow3dBVR
         FFfM9LMsDq8clIi4zPZLjCe7htk1JMhHW/EpqgjP2EgmJh0X8dE/cKLQkAumbABDP4gD
         UwrIZl6A6EODZww1/tnLQ9Xr8cR58mPtv+ULuYNEUapdmLflU5kzxyfuu1btCb4DQmY5
         V1lvXU1VkV3D/T0pZdngLRnkSbvYWZtybJYMEfhlAIL/wEdVArQ+2+rtI9t1CWGrUhcF
         G04dCsPJkpG8qAw1rw+Qp/q2J9hs5bDHUZ3v/by4S4L2nA/tAl8xOkrkdn75aNgL+5co
         Hyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716372002; x=1716976802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zv0peKN7El4wwmaoW8dg3u0DkCkTmb42hFB9WP4X0fc=;
        b=NYaa/AyoptaTZ2v4NgCTCbBE4io8cOLTYkxJMqNEUX/zbrV+vUEfi5BzugnwuKxw1i
         FDr8jmSMHa5IHZFO+weAXRYOhfwIERMi+UuoX1R3Rmx+HagPlJT9xckRhCkg+1GhH96C
         JX/VArMEus2sDNLAIX0ucrQE/v6vnOZHfz5vWFZlc2T0iONW9O+4HhFyM15ymI99VWYS
         ZDLvY8dfAbWJzaZpYLFvd/D6yx1EHrYCXWlL3aq0GsnAvf2WoJaoBSs7IlHJvAkcKy04
         Yn2IXgZ3rBcACSjVRvuwqHVDtDD3jqkXj2uTIcIC34OlXjPL94f17pK9294gtqlCIlJB
         GJtA==
X-Forwarded-Encrypted: i=1; AJvYcCWjiHfoZjeHUjwmV/XKpV1GV7410P0/hIhLk4Qzm2+myNDHK/qQBInGSZ7uAbzXoYVNh93cEX5bMsAPt+y4bEgO1yuY4achAPKeCjfg
X-Gm-Message-State: AOJu0YwvxcJMQe25eW+rXtvwJ7Eign7MYhmlobRAWtQaF4HNp0ZGPZZx
	yhOOoY880akSkSOwV6bsmrpFzxrrsPlPJSedFmWuiKcv53k1EremvmBiGsNwVK0=
X-Google-Smtp-Source: AGHT+IHD8u/xHqQMmXbgvlyuMqT7VRwcCG7YYtZUITTUReH2Thqf/mg7BsJniTmEF8WFfyWgndT5JQ==
X-Received: by 2002:a05:600c:21d5:b0:420:2cbe:7f16 with SMTP id 5b1f17b1804b1-420fd3726d5mr15710025e9.34.1716372001739;
        Wed, 22 May 2024 03:00:01 -0700 (PDT)
Received: from ?IPV6:2001:a61:139b:bf01:e8eb:4d8f:8770:df82? ([2001:a61:139b:bf01:e8eb:4d8f:8770:df82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-420273cff03sm269711845e9.26.2024.05.22.03.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 03:00:01 -0700 (PDT)
Message-ID: <9d37e0b4-91fa-4239-b767-2eb17e78ea84@suse.com>
Date: Wed, 22 May 2024 12:00:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: usbhid: enable remote wakeup for mouse
To: huanglei814 <huanglei814@163.com>, jikos@kernel.org, bentiss@kernel.org
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, huanglei <huanglei@kylinos.cn>
References: <20240522092257.19373-1-huanglei814@163.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20240522092257.19373-1-huanglei814@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.05.24 11:22, huanglei814 wrote:
> From: huanglei <huanglei@kylinos.cn>
> 
> This patch enables remote wakeup by default for USB mouse
> devices.  Mouse can used to be wakeup devices, but the correct
> place to enable it depends on the device's bus; no single
> approach will work for all mouse devices.  In particular, this
> covers only USB mouse (and then only those supporting the boot
> protocol).

Hi,

could you explain in the log why you want this to depend
on support for the boot protocol?

	Regards
		Oliver


