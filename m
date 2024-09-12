Return-Path: <linux-kernel+bounces-326716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A95F7976C1D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620B21F25479
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C911AE845;
	Thu, 12 Sep 2024 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sjev1iLb"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D1E1A4E7C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726151389; cv=none; b=M9I+xWNfkpumCfFFf+ApnQe2FiEQgqLE8yzMMgquzmUTjz9etliPe1JhRmOYO52cQocawWnfws/j7MzlNhrEXym5Gj3mNLYnwwO3BEsqLg4B6ykeTDRu4Ml4u6WfrVoeyqDXzdjgHEKrcwiJoBpK8GUTlBEl8CKXj0VWORzkNtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726151389; c=relaxed/simple;
	bh=ZVmEAnByI22/0wWeDh7mVpCpPy3D9gVx2N86bHpD1WM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S5OYJX7JFNmv6gDoKVz7ziSiBu5vsXXiiHYnQGJegbWap5dWePg431rc/yJRpRrF3SB0Mtlc+elSG6JL8vRydSHsP914OjNtw9aLeRLpWQVBgMKs+KXYy75KHgWt1hXmC8om2IWmx/9anPvE68xSkTrB2EJsV0R9jnM3WKbsE+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sjev1iLb; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7db1f0e1641so429305a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726151387; x=1726756187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kObZ7lH40iypxnXLN5YIJLKZF7D7KD3d3B0LY0pTPiw=;
        b=Sjev1iLbVdEP57mcZjpJvhsPT9bUlw9ekN1URFHNL4bE1q8Sojz3f53r7CYtwLxRZt
         V82S1cfvsNXQ0qalhw0dL/Fd3XlKIjhbc4bm/TxWmAeqKF7ZeVCjrFeo8yi1Zx2LaSaW
         eVCs03sCC1KqgpHBJ4zqOq9EoTVowW2JOe8g9N/L3eYxJmfeCzeg33OBA7w6nlK6T4VT
         iooCFn72RZYIdUY5e6PlXHWCzZrOsnFIaKB4w7r0PLLwO9suK54pzsOhaTZvWo+r9UcM
         Iqgh3NcIrF+4Uai2GMHZlEdePu5b5NNr8aXqwrAcUvuoKJDGMv1wi19kGmB7V7dRnLAz
         uzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726151387; x=1726756187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kObZ7lH40iypxnXLN5YIJLKZF7D7KD3d3B0LY0pTPiw=;
        b=gtdc/jJV5sRq8a/EtkxAxl/j+H1Z67JUIMqze2IzE7np223h+fwzkZ4pFqAWA6gyWY
         AAHYbldFVgU87+HurinyHZXOHYZeKDzQgPwX8lSe6pb5lFKzsNJvUfE+gKAOAaptwKLK
         1hdQzax5o+bfHAR2wmK1FEjqjACYcEEv66YR9anVIuWhW5UN75GJ4mtUWh+P49veuuWl
         4OL1r6yXVeZrSPiL0y1gFFq0/6w0wHRPwbWlhE2UJ8Bi2eMIbFSKf7czLS5HeOLL1uef
         /Oy6PkJFCCaBF6Q5R6nDGS95bk/3jPSl1wJiHDrpK0Bju9ntVfmxphb8XZ48gtR9AdwN
         1cFw==
X-Forwarded-Encrypted: i=1; AJvYcCXVGr3rR9izdXuiGikqig8UEZU0wQgo4iKpyLk6WNPoJdH9GxSYHp75loBI1lQ0pswrio5VLC/uTimgmKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh4Hqu7MfkjMeM8mMsRFQMAuTrq7Confys68oEQWrGcSEmKXSL
	KE6qzplaryUs9yN118WNYSQVRFpGXJA2WFyB66Qs3VbCE/W5z6PT
X-Google-Smtp-Source: AGHT+IHsIiP9is0MIit0yZGpDZaJaJi4yUCuk5PBYlnsfEvB0Idphp6Max7FdjJrq4pVAYkwoNzY+g==
X-Received: by 2002:a05:6a21:6816:b0:1cf:6953:2889 with SMTP id adf61e73a8af0-1cf75eeef69mr3793545637.16.1726151386687;
        Thu, 12 Sep 2024 07:29:46 -0700 (PDT)
Received: from [10.3.80.76] ([103.4.220.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71909095184sm4655926b3a.106.2024.09.12.07.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 07:29:46 -0700 (PDT)
Message-ID: <4c053d01-2f67-47c3-9f08-e20e8e6ef1dd@gmail.com>
Date: Thu, 12 Sep 2024 19:59:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/gma500: replace drm_detect_hdmi_monitor() with
 drm_display_info.is_hdmi
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Laurent.pinchart@ideasonboard.com, patrik.r.jakobsson@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240911180650.820598-1-tejasvipin76@gmail.com>
 <b0f77fcc-5d84-4727-9a17-9d1f1e2c5b76@suse.de>
Content-Language: en-US
From: Tejas Vipin <tejasvipin76@gmail.com>
In-Reply-To: <b0f77fcc-5d84-4727-9a17-9d1f1e2c5b76@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/12/24 12:49 PM, Thomas Zimmermann wrote:
> Hi
> 
> Am 11.09.24 um 20:06 schrieb Tejas Vipin:
>> Replace drm_detect_hdmi_monitor() with drm_display_info.is_hdmi since
>> monitor HDMI information is available after EDID is parsed. Additionally
>> rewrite the code the code to have fewer indentation levels.
> 
> The problem is that the entire logic is outdated. The content of cdv_hdmi_detect() should go into cdv_hdmi_get_modes(), the detect_ctx callback should be set to drm_connector_helper_detect_from_ddc() and cdv_hdmi_detect() should be deleted. The result is that ->detect_ctx will detect the presence of a display and ->get_modes will update EDID and other properties.
> 
> Do you have  a device for testing such a change?
> 
> Best regards
> Thomas

I do not have a device to test this. Reading the rest of the series and
given my circumstances, I do not think I will be continuing with this
patch.

-- 
Tejas Vipin

