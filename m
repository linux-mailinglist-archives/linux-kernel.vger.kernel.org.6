Return-Path: <linux-kernel+bounces-276596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0979495DC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF251C219C6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1083C08A;
	Tue,  6 Aug 2024 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrXoBdWE"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC5615E8B;
	Tue,  6 Aug 2024 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722962842; cv=none; b=OHSfvSYKIidNyb6iRJZyg7jO6iqGzMYkoi9c4mn2Ogc7CPuB9Y6sCM4ukdp80VUqrnvFUE3FcOEek9VZPc62EYTlN4mokfcYaipiSFAN9ZYSy7cScQU/DRM/n6oE/yPlYAC8kxQWxQIf4oLNwN8x78OSWgdiAqpZae1fshKzekQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722962842; c=relaxed/simple;
	bh=pX04H9+El3MaxLyQjsJwR/PmcSr8YhnJI9pyndAjMgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rnoN8qopyUQOIJNqVp16V3F4TnLAomvyvZYGB9yV3WEOkEWW4WZsm1n4+Fd3ntIWjhtVl+cJgqiWmZ5mR70Q9BZJx/7DJIJO7vF8hB0xcCNJQAcCp+x8pvKNkoaKtdnQIf0MDmxZyELUZvqlyGmFU1JCL78KZqHDGtfNUU7gLT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrXoBdWE; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7107b16be12so668660b3a.3;
        Tue, 06 Aug 2024 09:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722962840; x=1723567640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+fAYh7NklhLBjpKe9sHoFdzJliLK6+I4PaScht2r68M=;
        b=jrXoBdWEjhEGctJSvlFq9XxWsUFmZmGl5Gkm2ywouR89aqsQDrGjyWvHumdJ6kCe2X
         cbu9u/1RGz9HHxhXBRav4MdLhLcabLKFbd22w4iSpokD2w3DsWIVZZE8dq1TGLnqK6lS
         w4/ONHwufnwip9G9opR3M2TRxheVG1fiXPkofVoc7ksYiuwYOXFLmW0ZtEId7LG228xj
         keA7uKJvCIkMPvXYVmMiyLIvqCdI7GSkO7taa92LfcJpGA8J7DiIBjhFoitBV0Q5fSXD
         6KKBxK8DYgynQhmHMSYuLC1XOamHfBWMlCofpxaMve3/booYj8Sd2v7xTZTzxvNCGL6c
         9QHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722962840; x=1723567640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fAYh7NklhLBjpKe9sHoFdzJliLK6+I4PaScht2r68M=;
        b=AO0YiU1n3HLECtrISKVkaLd8fgsCCxQvl/LyoGPgIvBChw8KojnGa8adTUeaQzV9G6
         UNGsCgpQHzOhugJwXd+4CsrXe67iFbV0d1wRiEd/VHKXQMzFb+egM+nE46xBputXDZ1V
         Lw7XYN1MFaZto2PY0YegaWoLAylkCYIdUFbmY/KIf88EobEsg+DdVbK6RWxY3gRUZ5V2
         /zQeyjGhmdGNW5FdPAxrX2Pja6g1iwKgdY67zramyUUf8yvUj+3TAJT2CYF35iCCEdOZ
         kdBmiWBdVs+IbRm4DdFKt3ZUCau4EW41mQWSzZo/332Nb+7pg7BE1ss3ffz+NZUJixKZ
         NRDA==
X-Forwarded-Encrypted: i=1; AJvYcCVeVukbazQAVVrvBxMYl0Ko9LRbWbReoGynqBJp3f48Y8eNpdeK1wQnLjhHCw2nC/lGIJnp0XdX1yqvt4AcnhZxPJ4lk9YZPpNBBVb3uCmHueJ2fZfC667CqRpgjwGv3ThpFmH2RFc=
X-Gm-Message-State: AOJu0Yxk4qya4oI635cKO8mORWQEL1Ym2NGbYUYTi5nG3zMigZ/yRU63
	i1D0UpE9as47aS/O4J+WD3GxVclcO0WaPS9vOL6o3WZL1AOpxotk
X-Google-Smtp-Source: AGHT+IHNn+3tDwOKtFAmo1AONjvRl0gq90xof22nJT9D9Qh8nzmQSzz9i2x+YAL1tQ1smdjThcVLMw==
X-Received: by 2002:a05:6a21:10f:b0:1c0:f23c:28a7 with SMTP id adf61e73a8af0-1c699668f98mr14273228637.44.1722962839602;
        Tue, 06 Aug 2024 09:47:19 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7106ec0bda0sm7141971b3a.8.2024.08.06.09.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 09:47:19 -0700 (PDT)
Message-ID: <6c2b185e-42d4-408b-a7f5-972b2099067b@gmail.com>
Date: Tue, 6 Aug 2024 09:47:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] Make SCMI transport as standalone drivers
To: Cristian Marussi <cristian.marussi@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com,
 vincent.guittot@linaro.org, etienne.carriere@st.com, peng.fan@oss.nxp.com,
 michal.simek@amd.com, quic_sibis@quicinc.com, quic_nkela@quicinc.com,
 ptosi@google.com, dan.carpenter@linaro.org, souvik.chakravarty@arm.com
References: <20240730133318.1573765-1-cristian.marussi@arm.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240730133318.1573765-1-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 06:33, Cristian Marussi wrote:
> Hi all,
> 
> Till now the SCMI transport layer was being built embedded into in the core
> SCMI stack.
> 
> Some of these transports, despite being currently part of the main SCMI
> module, are indeed also registered with different subsystems like optee or
> virtio, and actively probed also by those: this led to a few awkward and
> convoluted tricks to properly handle such interactions at boot time in the
> SCMI stack.
> 
> Moreover some partner expressed the desire to be able to fully modularize
> the transports components.
> 
> This series aim to make all such transports as standalone drivers that can
> be optionally loaded as modules.
> 
> In order to do this, at first some new mechanism is introduced to support
> this new capability while maintaining, in parallel, the old legacy embedded
> transports; then each transport, one by one, is transitioned to be a
> standalone driver and finally the old legacy support for embedded transport
> is removed.
> 
> Patch [1/9] is a fix around the chan_free method for OPTEE transport; it is
> really unrelated to this series, but included to avoid conflicts.
> 
> Patch [2/9] is a mostly unrelated (but much needed) clean-up from Peng,
> which I included in this series to avoid conflicts at merge.
> 
> Patch [3/9] simply collects the existing datagram manipulation helpers in a
> pair of function pointers structures, in preparation for later reworks.
> 
> Patch [4/9] adds the bulk of the new logic to the core SCMI stack and then
> each existing transport is transitioned to be a standalone driver in
> patches 5,6,7,8 while shuffling around the compatibles. (no DT change is
> needed of curse for backward compatibility)
> While doing this I kept the module authorship in line with the main
> author(S) as spitted out by git-blame.
> 
> Finally patch [9/9] removes all the legacy dead code from the core SCMI
> stack.
> 
> No new symbol EXPORT has been added.
> 
> The new transport drivers have been tested, as built-in and LKM, as
> follows:
> 
> - mailbox on JUNO
> - virtio on emulation
> - optee on QEMU/optee using Linaro setup
> 
> Exercised using the regular SCMI drivers stack and the SCMI ACS suite,
> testing commands, replies, delayed responses and notification.
> 
> Multiple virtual SCMI instances support has been tested too.
> 
> SMC has NOT been tested/exercised at run-time, only compile-tested.
> (due to lack of hardware)
> 
> Note that in this new setup, all the probe deferral and retries between the
> SCMI core stack and the transports has been removed, since no more needed.
> 
> Moreover the new drivers have been tested also with a fully modularized
> SCMI stack, i.e.:
> 
>    scmi-core.ko + scmi-module.ko + scmi_transport_*.ko [ + vendor modules ]
> 
> Based on v6.11-rc1
> 
> Any feedback, and especially testing (:D) is welcome.

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


