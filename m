Return-Path: <linux-kernel+bounces-550961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE6BA5666E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CADF11891C40
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A9D217673;
	Fri,  7 Mar 2025 11:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J08eV7ap"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C360217653;
	Fri,  7 Mar 2025 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346253; cv=none; b=osRm2lp7DeKNSjW+LqWY/vJp6JHOIRDG+c1tkkmApAHmUJ/w1id5zw+et6RnrN6msIPBfHfCxs8orWnEGKOWFllE8WZNYejMhFuH8XtzBznz486ifKWbhqE9rPwXaGO5oMC1/d41ramrs7br2/Dx30IJHgx5P9YGx4fu5JaldAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346253; c=relaxed/simple;
	bh=QY00a3rngmsVxLQDZ3rhfcfy8+4hGUDyLxDK2MVdQBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u6j8zF1xT8VFwJkuI5CBXvff49g4brXAyf0N0yc43w1IQUJ4WqcAN1CfWS5Vn3y89vV2fkStuA5F9BClcxaYEyrg6yaSDK4O2Z9OfC23WbMesr/QbTOPI6uyvecpDXtddF1fShxEbjBOM6WY0yLtE5D/Wu2TvNoNrk+nJPJ70A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J08eV7ap; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22185cddbffso53482995ad.1;
        Fri, 07 Mar 2025 03:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741346251; x=1741951051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9WDU/0AiPCuXExkzik2v+BtrRa6yZzdzICrZw+6l4Ag=;
        b=J08eV7apyRp/7zr2li9x1dsc0j4wTXDGWQFhJd7rINalz6N+2/2fItP+fFU0wPRmQZ
         AKe88xcpsI+tLHhjGQk8ox0+xjugYPasuvcdwZpc2sY7A7swk1UFXxtUhonEs/387T3O
         vKqmpffJSWXll9A64odVCUReG0MYGRBHZCP3ghK7yGv4DwdDtG8c/dQ429QZYd5WPTH0
         1vrF1p1I3uGcZximeDHlVHfuhug01nuWYMZhZaapaSPQKTaVAGX8cenZH1eiuZwWEkep
         99s5SdWzA3+zRJJOoWaSo58pwyLNYlPDqHoX4uqgBCo83plWkxiASaD1aSOpxLGkyCSt
         yvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741346251; x=1741951051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9WDU/0AiPCuXExkzik2v+BtrRa6yZzdzICrZw+6l4Ag=;
        b=lXfpbVLX84suJkZ2jQDlhnMjonHcLZaUW7ESIx4LVFGs+9DWUC7WcNKEGrQlRCIObo
         lWhL8V7xi2+BXMLZIc49tyqePmeWD+aDy5ZHHLNCs9JgYhZfiF+oeTq6c1eyb/vjm/ps
         Sv5VJEH52ZjiCvBq0k1d5eTCFQeLRA/gdRoYy6w1HZi8E81ngzH2IgnDiTWKdASEQGzP
         NIDZznQvG5mS/KQu2eXU9iQvpEriVYgqp9C0vlFQgXbszSmSEtIqIgwcgygTD/TJ18sq
         rRqAj7Ns1GcXRRSA3+giHTZuQdvB50m+/fy7TnMCyuRIW7xvXOaqSjv0V0gy5X60Dgc7
         SvWg==
X-Forwarded-Encrypted: i=1; AJvYcCVV9XKJFTHIxsqq225Ta0S+mIR4QtcyFyZAlC9U8cmzAm9AsWohfPnAS8UXkmHKPyYjgqwTI1c2C+E=@vger.kernel.org, AJvYcCVbCVFE51irR2nJisNXwrfzGmOsVB0+JS1VdSmejykK+M89mtnN12ciofW/O8qSL3FVBpIFaY4m3liombjV@vger.kernel.org
X-Gm-Message-State: AOJu0YybXBplsZj9DTfcZuqAQwWSFs/vAi2NHe3ayzjUcVKa/rOD6Zst
	J37FnOxjwT4YTNkQZEUpN5Mn4N8UsVpC8VzflfBBoeFVQyG4847O
X-Gm-Gg: ASbGnctalOWPnE/eNIwtVyLFPQsWJKcD/S3UAQj+J4LBSzXA6SKdi6SuVBVIA4l+nCX
	w8jmsLvecteOA/V2G0JMWdkVMsGKk8xPAJnbdjLtWW4gEjgcJiY8BJRopjpoxp287XTVRZ3TWKf
	ylvMpgM6g3vyuOwd0fbtw5bkQo1AJ1lXlmCz7d8p+uE2RDpVmV5MXSnRRqirwKSD4A3rFndaKHI
	g4XHWHqpXcPmjOlfQ7Loj1eaB27Oc4jUpbB0bLL1y8v3XV2DdD2rUyMhzi2U2K7TOtgVjhPX1qb
	XjN03ePJkPEyYSu+MHEd6jNFHWOnKz/HrSb3nlPU1Up1K2U9a7Lx0GaCYGSCGR4um4jNGAVlMYO
	eEsl+CieO15A5Li4=
X-Google-Smtp-Source: AGHT+IGLMqL97eIZaqRXzhmsR4cnq0XXC/PM8jbkeUNyeHsw1h0hQd26hi42sAz14nYj3gGZ9el5iQ==
X-Received: by 2002:a05:6a00:3d52:b0:736:9f2e:1357 with SMTP id d2e1a72fcca58-736a97e4239mr4650047b3a.12.1741346251281;
        Fri, 07 Mar 2025 03:17:31 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698514f4dsm2971364b3a.124.2025.03.07.03.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 03:17:30 -0800 (PST)
Message-ID: <e3637b13-1f51-445b-8d9d-bd53a691eca3@gmail.com>
Date: Fri, 7 Mar 2025 19:57:54 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] cpumask: Fix kernel-doc formatting errors in
 cpumask.h
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, linux-doc@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 Akira Yokosawa <akiyks@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Yury Norov <yury.norov@gmail.com>
References: <cover.1741332579.git.viresh.kumar@linaro.org>
 <f4ad81150eaa00b43c161f0d1f811f8ecfe21889.1741332579.git.viresh.kumar@linaro.org>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <f4ad81150eaa00b43c161f0d1f811f8ecfe21889.1741332579.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi again, 

Viresh Kumar wrote:
> This fixes various kernel-doc formatting errors in cpumask.h:
> 
> - WARNING: Inline literal start-string without end-string.
> - ERROR: Unexpected indentation.
> - ERROR: Unknown target name: "gfp".
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  include/linux/cpumask.h | 65 +++++++++++++++++++++--------------------
>  1 file changed, 34 insertions(+), 31 deletions(-)
> 

Didn't come up in your diff, but you need additional changes shown below:

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 656d2208467e..a6c1961cc535 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -285,10 +285,10 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
 }
 
 /**
- * cpumask_next_and_wrap - get the next cpu in *src1p & *src2p, starting from
- *                        @n+1. If nothing found, wrap around and start from
+ * cpumask_next_and_wrap - get the next cpu in *@src1p & *@src2p, starting from
+ *                        @n+ 1. If nothing found, wrap around and start from
  *                        the beginning
- * @n: the cpu prior to the place to search (i.e. search starts from @n+1)
+ * @n: the cpu prior to the place to search (i.e. search starts from @n +1)
  * @src1p: the first cpumask pointer
  * @src2p: the second cpumask pointer
  *
@@ -306,9 +306,9 @@ unsigned int cpumask_next_and_wrap(int n, const struct cpumask *src1p,
 }
 
 /**
- * cpumask_next_wrap - get the next cpu in *src, starting from @n+1. If nothing
+ * cpumask_next_wrap - get the next cpu in *@src, starting from @n +1. If nothing
  *                    found, wrap around and start from the beginning
- * @n: the cpu prior to the place to search (i.e. search starts from @n+1)
+ * @n: the cpu prior to the place to search (i.e. search starts from @n +1)
  * @src: cpumask pointer
  *
  * Return: next set bit, wrapped if needed, or >= nr_cpu_ids if @src is empty.

Feel free to squash into your 1/2.
My R-b tag still stands.

        Thanks, Akira


