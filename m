Return-Path: <linux-kernel+bounces-189935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0CC8CF75E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 03:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF8F1C20EA4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 01:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23658BE7;
	Mon, 27 May 2024 01:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akYtCvQk"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0410979F6
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716775175; cv=none; b=MrtGXhS1SM/B4g+dGcmXz6bBsj+Qk0ToYUKzR33m+eDwIFrJ6jcyC8uP6fAroiGpWCq/WKC2diB0Z6V2rLs7AuKwHTnWWZypDELipZhIKweyv9WakjwQ+O6+04Ke0q4CmjC10N+mpJj95YoHj3gywp+I0PRSDd1ajpVhUD+ATB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716775175; c=relaxed/simple;
	bh=yOIe72PbQbqtVcTgh+G6eF84DeLeYwtfA8DIj9hEyMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C4ungOqs6Itozf9F2QMlXUgLPyy2xc2r0yIPjX5ONSmt1RD6RTVxjxCm8pu+0hEEmlm8C3jIYlO95gh4yrm+2Z4M76sOgrIwxvWhoUNSAnfueKphvVMu1NrtVTUO5BowLR0X/k2ySfisJSXk9Iy3EN2UKVew6gW4vdQnl4dDPrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akYtCvQk; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f47f07acd3so8124795ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 18:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716775173; x=1717379973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U+zzWyRU5qWnzugd8CovIQiw+CxvZcxWliAl2kOBqqY=;
        b=akYtCvQkAKyNF8aDmG/L+VutQD0EL5wqqaDRGTHbiuVE3HpBOWbvlHIyNaunL+jHB3
         S/3CFzQY8TUU3f0pJn8Bvdgl9P9T40A2qwrHhAUwHSzD1iCzuGnjeziVX7wUUFpYQrWv
         NGj/EBnF2flPvMfoYFz+8PXoUFkd8l83vKN1E11SvbzaRSnsKzV96g5OElMNgbqQB0Bj
         zHHe3muCfzvon2zIw629OFUupGeGC071yPLowTX0n7MRvG6Rfjy+/ujDy33fEQyDxrEy
         MMod57Bu41/TG12McIQEmv9tUHqc6DdQmB75e2dZGh4ehVw5rLggLW0HY2xG+IwGfHlR
         u6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716775173; x=1717379973;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+zzWyRU5qWnzugd8CovIQiw+CxvZcxWliAl2kOBqqY=;
        b=Hm9wXnjwl2HDtgTyGYCOe/4MXW23nbhU8CGh4T/beNoK+O5ivaNN5s5YPseJfu7GWd
         CKW3KoYu6LAyg82IbIs8PR/EvS6GljyTk/0ge1W4ooFtY2WliD68PGdf9TBxq+quUAMP
         sMNONxTycLaYLBo1L3+xVep/7VYyEe1qSCG9OMcx75zEY2Fwe9rOx3SSgYLyfttlq+0a
         jDxeXnnqacQeS7aHxQpk1wYfSOyjwiJRdJLJjAO4ANOBNtBDmHkIbGgP2lmcTQGkinkq
         xU+QZUYfHr9pUJeOnAiecTZvUVdK5uvIdyIu2AKhRJooImFthjRRAfaCK4tKO5ksTU8A
         oYNw==
X-Forwarded-Encrypted: i=1; AJvYcCW7hzQ1nJs2ti4bqynp/y+NEX1cqiZQcui/1PK8wtGXVFmXJFYSTUrvoB86HTbxpLthXt7XagozcW29+e0d8NoApA/jYm7ddjbEcEVa
X-Gm-Message-State: AOJu0YwJK25R8gppRtF35RONXpOAVODrv1juCFX4sRNTqp8N8oNY4I0L
	+5Pr6VF+Q6hDRO5O1J9/TWcTcFtHLA8HSxPF671ce4+/ycdty/DfuOkfikhI
X-Google-Smtp-Source: AGHT+IFUBex9jKUULJQctg3O7TT5Yd/cX+zdgKIEgDux6Xih0RQneJcV5BUi+AqmAJzO7vKZ0VjNyQ==
X-Received: by 2002:a17:902:eccb:b0:1f4:6fe0:f950 with SMTP id d9443c01a7336-1f46fe18c78mr58102495ad.67.1716775173035;
        Sun, 26 May 2024 18:59:33 -0700 (PDT)
Received: from [0.0.0.0] (74.211.104.32.16clouds.com. [74.211.104.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c97090dsm49364135ad.124.2024.05.26.18.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 May 2024 18:59:32 -0700 (PDT)
Message-ID: <8142808e-0f87-42f4-a46a-e21b74bbe1f8@gmail.com>
Date: Mon, 27 May 2024 09:59:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] workqueue: Fix rescuer task's name truncated
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>
Cc: Wenchao Hao <haowenchao2@huawei.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-kernel@vger.kernel.org
References: <20240513140115.3892827-1-haowenchao2@huawei.com>
 <b09604a0-83b0-4317-85ad-ead3d7d5bb3e@gmail.com>
 <ZlOEXWx4WJdeM4GZ@slm.duckdns.org>
From: Wenchao Hao <haowenchao22@gmail.com>
In-Reply-To: <ZlOEXWx4WJdeM4GZ@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/27 2:50, Tejun Heo wrote:
> Hello,
> 
> On Thu, May 23, 2024 at 09:36:57AM +0800, Wenchao Hao wrote:
>>> The first patch fix the rescuer task's name truncated;
>>> The second patch fix workqueue_struct's name truncated.
> 
> I missed these and the issue got reported separately and a different fix has
> been applied:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/commit/?h=for-6.10-fixes&id=2a1b02bcba78f8498ab00d6142e1238d85b01591
> 

I applied these changes and the issue has been fixed.

> My apologies for missing your patches. Can you please see whether the above
> patch addresses the issues you saw.
>  > Thanks.
> 


