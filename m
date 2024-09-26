Return-Path: <linux-kernel+bounces-340896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8CA9878BD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F8228621D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F84168491;
	Thu, 26 Sep 2024 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FjnM95ds"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765AD161311
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373297; cv=none; b=CddNb/rM0GiMWstIiMKOOZHe1U5YlQIekMIOvhhVziR2Datzs3f1BJg8iFnHalKC1AZdwcIdtPMGa3mFdSLP4rB39ySVnSEG8rLJ3K0qs7Mm1hcZf7LzLz7mVcjoLiDNv8bAU24YDWV68jtfYtGvICoSzi1kzAm3A8siNV0T3q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373297; c=relaxed/simple;
	bh=0aRGTn4qZNYsFHdSLtVVTADgFQWgEkqzVNawgnPQ2i4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MpUO759zZBtcscBYbe45nyAifCJoiKHiTyrLNHrkPPE6ezzyaxN0AakI38avN1vD3PEzVbQuXh1g4UwUyoSXO38O+Jnip4Ttyfh4oFaDsC1vJk7GmXvifbkzBAQe+831Z9uFE+RmDlXc5auX+RGYhDt0C82/BKKaYWK7PKS9MSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FjnM95ds; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727373294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JjoTb3DDkGQpWq+NC7yAzgO/O7gkqyS4FMGzMtxEfpU=;
	b=FjnM95dsTICfEw4SaYHHeow+RNYk3yMPUZPyK0lc/BIXHGAz24Oqm7GeCkPC/UJaD7b+J+
	YKqVDBw/nyznmtIjIbAZRu8GUPRjUtCk8jLZLbFFW4xURtrnpiqRTEC3Fjqk6Ag2Zzye7S
	doI+U1jAF0rcTMVkk3o1GeKGqoYLg+o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-DpDxnIO2Pxyf3u0eMnhOTA-1; Thu, 26 Sep 2024 13:54:53 -0400
X-MC-Unique: DpDxnIO2Pxyf3u0eMnhOTA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8d3085ab6fso71351966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373291; x=1727978091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JjoTb3DDkGQpWq+NC7yAzgO/O7gkqyS4FMGzMtxEfpU=;
        b=b61X+SKh5EKB3GUI1McHL5p19TF0KHI/rs+5eNPopt5NIQUJq2+SxheCCzcvl1MgTm
         xvBiQcXkfyN/OAYIzEd1YydVYUy2cNdEw2w8eLFCqvdxRYFf5KasWGfU4oe20T5+UA+k
         L1/IbmtgvZwJQshe3g5Rk4PsDRH3uSH0cvbS8yZXpT/NnIGV2G1+SEa1SXMjRXw1V0RV
         y7K5jJ+lbWwyTVo+S4JW6oKKA/gUad0rRHVkwkK4yC0llzF9CRJpLGqOhKAVkm0hlNUg
         68BROm2ZQ//2ZdojF46gMpDYqo0wY/4z35fKyobl+9E8QHxH86aFHBPlurobVSvqAgAI
         Huzw==
X-Forwarded-Encrypted: i=1; AJvYcCVkdVj9rfXZvplEvk/6pncPNiGKISxrFbnBMxeyJ3ONEeFaOU8i0q7r9QnyiERMyKn6O2Q5GjTm2AqnObU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2pS8rEzsSLNOJ52bRr0nPyW2LIbR0TmnMR/UfYulirbNzs7fI
	Jtc40JsbiIoRs92gPfgYrvK+J2V9ECFeOXd1iMcQ52/PoyED46a6XzXAUv4v+/pfY3LygAdj+Vc
	8Ako2EfD5doGvgCU53GS6Bhi1/jwJ9BSFL2mvf8CvoqujUrLLymHEKXVicYE2oRzb7/B7XyvQPF
	Y=
X-Received: by 2002:a17:907:1b96:b0:a93:ae71:994c with SMTP id a640c23a62f3a-a93c4aa6c84mr20387766b.57.1727373291485;
        Thu, 26 Sep 2024 10:54:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgJ2ce8we4Rd7DeLh3WEv+xfrahHxGE4lyf2Nkn1gqk5KwScN7/aCChIQ2CyyjKxqasmeoQQ==
X-Received: by 2002:a17:907:1b96:b0:a93:ae71:994c with SMTP id a640c23a62f3a-a93c4aa6c84mr20386166b.57.1727373291119;
        Thu, 26 Sep 2024 10:54:51 -0700 (PDT)
Received: from [10.100.0.2] ([94.101.114.121])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c297bcccsm22614166b.173.2024.09.26.10.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 10:54:50 -0700 (PDT)
Message-ID: <f8546c5d-fa2e-416f-8a1b-431025b4df4d@redhat.com>
Date: Thu, 26 Sep 2024 19:54:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/tracing: Mention that
 RESET_ATTACK_MITIGATION can clear memory
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mike Rapoport <mike.rapoport@gmail.com>, Kees Cook <keescook@chromium.org>,
 Ard Biesheuvel <ardb@kernel.org>
References: <20240926130159.19e6d0e2@rorschach.local.home>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240926130159.19e6d0e2@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 26-Sep-24 7:01 PM, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> At the 2024 Linux Plumbers Conference, I was talking with Hans de Goede
> about the persistent buffer to display traces from previous boots. He
> mentioned that UEFI can clear memory. In my own tests I have not seen
> this. He later informed me that it requires the config option:
> 
>  CONFIG_RESET_ATTACK_MITIGATION
> 
> It appears that setting this will allow the memory to be cleared on boot
> up, which will definitely clear out the trace of the previous boot.
> 
> Add this information under the trace_instance in kernel-parameters.txt
> to let people know that this can cause issues.
> 
> Link: https://lore.kernel.org/all/20170825155019.6740-2-ard.biesheuvel@linaro.org/
> 
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  Documentation/admin-guide/kernel-parameters.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index bb48ae24ae69..f9b79294f84a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6850,6 +6850,9 @@
>  
>  				reserve_mem=12M:4096:trace trace_instance=boot_map^traceoff^traceprintk@trace,sched,irq
>  
> +			Note, CONFIG_RESET_ATTACK_MITIGATION can force a memory reset on boot which
> +			will clear any trace that was stored.
> +
>  			See also Documentation/trace/debugging.rst
>  
>  


