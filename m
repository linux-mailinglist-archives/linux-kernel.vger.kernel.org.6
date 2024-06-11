Return-Path: <linux-kernel+bounces-209569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B5F9037D4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12204B24924
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D402717B429;
	Tue, 11 Jun 2024 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Em7OVcsK"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD0717A92E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718098211; cv=none; b=Ufxny0k8tToNGwNe+d391oa4mr+WMHPSgUjq2KtE+9SST0J7NDRSsGY3+00X2QRQ0fYw0Z8fQjHQh2gnFy0wtZpJl+7pNxrf9pk5WcKm9P3VXI/Om3ui8jT/ecXGensgWbrInnfdz6xY07PH5Et9kWT6UbB1m1MAn2HuxU8PdB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718098211; c=relaxed/simple;
	bh=jWN+yGkKNosTh7VvPp62+8bUuzK3hZMqb3x+AAM6aOo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jHgj/F7Xys0Kx8KnUVF2q9XLZ6fCR0DuPOOUNeogORmcV51m2ZoGecbjn1DoE6pcfo23FWheodb1T+EvQw5cIpgo26pHgzViCemCV5JJjzZbajzMFZrZXwpzFzA6CoUawE8D2oT+HuO1B7HG/ZOCwFYEIUTp15zZr+2cSdZucH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Em7OVcsK; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6f1cf00b3aso352266066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718098208; x=1718703008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEiolzJ9Rm1ucL36ZKdGfO9BXAHThbq3hA10O8Bq52E=;
        b=Em7OVcsKVH6nBgX8RRQv3JIVgtm8rF/860N0oW5MmyTQ3njQj7C5b+OL0qrD2r8PlR
         MpsnzOt5tgwPLp1cW9mUBavsoCZ5oBDMJScp2cCvgvf+M0/+QaQy8wR7ml4Dh+vIvJNx
         SU0vqiXJ8Us/j+5acA8jnhtbso69RT0kboeRL6Vfn/NJIq1Hif2K/jp3MpLKzp9dhV0T
         VwF9RAo9djZZDygIuHWrdxDIGIeUAopIz2FWziQ4Eh90GODsemtQX073YWUbtPc1ZtW/
         1U+Rx9BczNFyRTDk9iyiEVGkVm4M+D+5ewU1neWUMFtIRlNtm3bGDg1sxSj1nJK+ST4J
         kwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718098208; x=1718703008;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEiolzJ9Rm1ucL36ZKdGfO9BXAHThbq3hA10O8Bq52E=;
        b=MXQeP01I3h8rHqE3r3DkO1C0CMc+2Lt634i2b3oSb1Bl+v+lCEquWmVTOV4YDYDRJg
         ZQsDv0HUDwOtn4wQCJb/KMdwhWU5GLNUZU7c8do2E/9GPYDbGKPwoCkufrci5OsMQXhP
         29Qp0pqYunlaiRm0QFadsHjcuZnUWxX7xb2S/pud4bolpL+nOCElLirQqk+Inrq8MET7
         WxawRZ0lV8PI1uJu0xMhf57fJQZKu3F/KvnLH6F2MIAxQ3azRKvNgZAvGyEgUW5TSFBK
         UnvvZhQX/KwnjDcJHYZRoZY0VCH58R6YDg2HLF975p7hTgl0bSFgygAGdSbYhvYtWipT
         7G5A==
X-Gm-Message-State: AOJu0Yz+TiNmmoK1IlV9o1ZH8sXR+SpTRQTjLzSOk0U5L9u0H6On7jnN
	R/lOwWTBQK5bxid5T7vC7c2AHCFJwQ9zqmL06EPmRhduH/hO0vX5Wjm91vKOG88=
X-Google-Smtp-Source: AGHT+IHgSKwaveghpPlJADPqdDkr6LtFnf8M7V3JtUNRohufMYfKUyiu7bTEjWZm42g2TjAGmhoQeA==
X-Received: by 2002:a17:906:468b:b0:a6f:dc0:d6c5 with SMTP id a640c23a62f3a-a6f34cefb92mr138382866b.18.1718098208002;
        Tue, 11 Jun 2024 02:30:08 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c806eaa4dsm735715966b.110.2024.06.11.02.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 02:30:06 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Joy Chakraborty <joychakr@google.com>
Cc: linux-kernel@vger.kernel.org, manugautam@google.com, 
 stable@vger.kernel.org
In-Reply-To: <20240607160510.3968596-1-joychakr@google.com>
References: <20240607160510.3968596-1-joychakr@google.com>
Subject: Re: [PATCH v3] nvmem: rmem: Fix return value of rmem_read()
Message-Id: <171809820628.51273.17270495551404270565.b4-ty@linaro.org>
Date: Tue, 11 Jun 2024 10:30:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Fri, 07 Jun 2024 16:05:10 +0000, Joy Chakraborty wrote:
> reg_read() callback registered with nvmem core expects 0 on success and
> a negative value on error but rmem_read() returns the number of bytes
> read which is treated as an error at the nvmem core.
> 
> This does not break when rmem is accessed using sysfs via
> bin_attr_nvmem_read()/write() but causes an error when accessed from
> places like nvmem_access_with_keepouts(), etc.
> 
> [...]

Applied, thanks!

[1/1] nvmem: rmem: Fix return value of rmem_read()
      commit: 139eb4bb33a2857fe439c02a201a85af52ce6186

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


