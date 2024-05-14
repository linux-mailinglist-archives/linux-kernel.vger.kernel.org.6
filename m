Return-Path: <linux-kernel+bounces-178661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E09968C560F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13DF4281718
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CD261674;
	Tue, 14 May 2024 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iE+DMTCz"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807C1182D2
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715690087; cv=none; b=lzrAhHWLKFef2Qdx0J3GcBnToyO8xay5lkYvuA+wq/LAcr8DUxJm6f9AynKg3N/Wj5o1rYczRvXfIRi26uYIa6o5hwLKXWM0PYCSHeyXvEu5IYKC+1hUq8/YjVy9NLDa8Woq0RPMePQ/PkzicrAoIeDue1kBJ5rNADr62tjmIdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715690087; c=relaxed/simple;
	bh=mWVHI9lg7cNXrvhOBGbAI/uT6TR7Zz83fpMXAkvTFJs=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=aKzSMvplD54P+gvNIdqVhLoFVE8Nklin82HAvXL15iF4Rr3INd/2Sv5gNztXb/ZKd8btaWTzPApZBLJCVbt5IoVLnkdh8bA454lCpaL80p+fHQXqW2HQMpKf+tajsuWU8zMi9ey8fHz+C9Nm3VdTxHC/3vWQwmyvYPrjzd6Qxqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iE+DMTCz; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f44b390d5fso4695965b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 05:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715690086; x=1716294886; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLMMeOBA3Eom7Y04MlDJcn0Vz6uRZ6HEs7F9rDlmuvQ=;
        b=iE+DMTCztOEbYk3J7S9vNvRq03GrtTI/PE0td+DRqDoDMKZ0x42l5eGRPrp7RqZZYJ
         os+eSye4+HXKT5wb812a4tINde/bNMTJmVXGf1+dB7+v94RCntDvib5FR7xXGfSeLqkU
         UZ40QSHcjNs4omId79oWIf1GIlOIFMl6Y/jLQgW/Iw/31tCAutUbhvQ44mBRoifrB3Q4
         YaZa0I6MIg+FXGj74qBep9ZGBOJYRkW36u6l0SWvjmeW9P9uoVupAtnMcISRJ3bNiLKF
         U6hClbKKqXFyI5FYVNSPYy5cyQz3zSm8XmF+4XmLxIgW9IrRmb82qWDhHsB2h9JZTVrV
         uQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715690086; x=1716294886;
        h=content-transfer-encoding:subject:cc:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iLMMeOBA3Eom7Y04MlDJcn0Vz6uRZ6HEs7F9rDlmuvQ=;
        b=i2lPjGSCTX+R1KNR5iPLJcqgJOZnHJwu5DM++j6f84ghU0eqzBYkvC96RjZqg0TOLd
         mMSTXEvIley5TBt1RcPR0UZZoYVOheeH09bsLAe0oIvCiHW+dBAaSCjXQfEIExoK90vl
         Ds3Xic2LqQjq/axZAcqChndkVMNKuecp/AZLFHSW7uvgVcGkRh5vU925YTIqguUyTWkI
         Fdvi1VA8m/8PCvgPCXP9yRzFrk3NABXmKYSKXULIzkTn+0Gt9R4pG+FCVxqJFHOM1Bg/
         j2MEiy9ICSGLYcCE6WuAeXjxNGmQZYZIIBFdQBzq223rZW8wlNU5Mk5FTMS8yL2xcoFd
         HeaQ==
X-Forwarded-Encrypted: i=1; AJvYcCULZ4wUVsjYdcI6PHFAL6hIeAF9cOCCmiYAWhBTh6FxZiFNW/iUOPz9G3hS49o6iqN8zB37VceNLYEV2uirLbpeuqR+uGcNA3qytCB/
X-Gm-Message-State: AOJu0YzCHkCOzZudsUGGxjDlBPqzXLT1jOUz8igXAUuMMSvbjFSCnrfE
	ce7bgH12c9dz6q0KvPBW+4t4tF2TNNIc9EY/A+ID+JrawtoXtQiP
X-Google-Smtp-Source: AGHT+IGcBuAMmpcDkrdMvpzHqIVCcDFq/v1udaRWj0uEXkMqi0r6cCOX7VXyOXDghCIll3E0MQpHDQ==
X-Received: by 2002:a05:6a21:279a:b0:1af:d228:ca5b with SMTP id adf61e73a8af0-1afde0d5488mr13849253637.21.1715690085703;
        Tue, 14 May 2024 05:34:45 -0700 (PDT)
Received: from [10.0.2.15] ([106.222.210.243])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340a447429sm9353569a12.18.2024.05.14.05.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 05:34:45 -0700 (PDT)
Message-ID: <e5c0a250-8c91-4523-b980-5b0e13749616@gmail.com>
Date: Tue, 14 May 2024 18:04:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch
From: Manas Ghandat <ghandatmanas@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: drm: Remove driver dependencies on FB_DEVICE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi. I recently looked at the todos of drm and found the topic 
interesting. I wanted to get started with this issue but having some 
trouble identifying the devices. What would be the right approach to get 
started?

Thanks,

Manas


