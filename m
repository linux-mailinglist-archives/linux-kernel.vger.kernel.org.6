Return-Path: <linux-kernel+bounces-190322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8A38CFCDD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082C52825A9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CF013A3F3;
	Mon, 27 May 2024 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qt+TIp/X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF04F13A268
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802191; cv=none; b=fgz9TmZ9G8sGCIV/G4BkXspj/wBvxf9JLNhJJqFFTZGWy8I0TDLOvUTK53SCi/71DZWA4IB5h4fu0Z3hvBQyiKSKuuXH93Cr+s6XYfjiVgS1oTn0FEVVU9iHDj/jMEuV0ox5vZE9nu7h27ImgNwPzIiufsiAGxWQ+bmpxc6Sagk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802191; c=relaxed/simple;
	bh=GVk5OV/h2v884ljEBZx1wxeGLOe6kBRIDF8Asd89Iyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZkAkRCdYwY+dQKoSQp7Aov4F6HyxHWzs8Rju24LznnVnTMr/67RMvPQYsPd+7Qvg485MPIV8Wv/x4/xRB2I25s5nL1mCXmC59syKFKcTuorehqW2hV/pltJD/EILeZpyyUs9kfeC6EpUIv0fFVjS3IqaI9D7FZh4J58p1pRvr88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qt+TIp/X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716802187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a2KHdQxlr+nCK+72i7BoiThRuJXfjIGAcKBIGrSIL78=;
	b=Qt+TIp/Xaivkay4KjM0URuYWq6SsiRecSq3TGBWjstDG2cWTkfC7VJt6Q6JlFh01hh1eK8
	oLv0cXBir9xW8y7bREWGx7qWbmFNMFCF+VxbGT6igKx22yOuQubiMhhfDbetBKDZsigY7W
	mnU7rftnBVLrAlBeQuiSnRFAyGnjAZo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-gVslgbvpOO2TOfpFcZ1Oag-1; Mon, 27 May 2024 05:29:46 -0400
X-MC-Unique: gVslgbvpOO2TOfpFcZ1Oag-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a6266ffd419so141754366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716802185; x=1717406985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a2KHdQxlr+nCK+72i7BoiThRuJXfjIGAcKBIGrSIL78=;
        b=fkTELPnM5xZL9BSaZaq0clDmFr+s5RxGrxasyO1ceXS8MgDxlkk5ua3AcgMnexBYYh
         u9o+s678wEv60pPk0tZWJhZDlPX0OsYAzyifag/PF7euZIXfvs9GvX5HM5PfDiP9+pTW
         kKrUQ11SaUsS4pmJEr+d0eW9LIsGD4wBCOo7Xt0OujZ0FGgPy7PZQW+EiRaF2fAVe1iq
         a3smKBncoEPommFRmtudvgLDQSsHlaEfoM2gEQSch6rdLq9A3Y4R8BErCZSNc0u56Mfb
         Hocq07EhVvlcxdu0IyqSsOMQrea+qJATqgdDtYy3bknbHxGU6ME2NJesHg61H4s35IoL
         MmVw==
X-Forwarded-Encrypted: i=1; AJvYcCW4BeCWQgLSuCc1vpKkgTAvBz3z4QjnNe3IfztoDLZVitcPhZMnzDxZXMVBwyHkH3Sr2ICeB7YhrVImr1QqBlT7cmcOGC5GEZunW+AB
X-Gm-Message-State: AOJu0Ywzf3I58sBSNl0v3gIquYoakqW8w73cNhQGqCSuZP6mluXV9kfR
	SxlX2daKmKKA2LqkPK6/KrNawlKTzBrnod5DL8S6CFMa70NQzCFmWpMtkGGKCY60qiUy5slnZow
	dtctsIaywuzQ2bFNW+KAjSv+SU1U9Xv/qTckDuLeuCPbSQX7KXero/+FEcJCR5A==
X-Received: by 2002:a17:906:b15:b0:a5a:15f6:157f with SMTP id a640c23a62f3a-a62641b42fcmr573358366b.14.1716802185027;
        Mon, 27 May 2024 02:29:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY7hYRzJQt/K0T3Xo6dt+GVQ6bfmi9PMBGZAhv1A5DH1gxbNqtbSUlQN9ac3tQ+gdHgt1I2Q==
X-Received: by 2002:a17:906:b15:b0:a5a:15f6:157f with SMTP id a640c23a62f3a-a62641b42fcmr573356966b.14.1716802184553;
        Mon, 27 May 2024 02:29:44 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c9376edsm466532366b.59.2024.05.27.02.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 02:29:44 -0700 (PDT)
Message-ID: <e6db0add-e290-4fac-b90c-da264939693d@redhat.com>
Date: Mon, 27 May 2024 11:29:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86: ISST: fix use-after-free in
 tpmi_sst_dev_remove()
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
 error27@gmail.com
References: <20240517144946.289615-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240517144946.289615-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/17/24 4:49 PM, Harshit Mogalapalli wrote:
> In tpmi_sst_dev_remove(), tpmi_sst is dereferenced after being freed.
> Fix this by reordering the kfree() post the dereference.
> 
> Fixes: 9d1d36268f3d ("platform/x86: ISST: Support partitioned systems")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans




> ---
> v1->v2: Add R.B from Hans and fix commit message wrapping to 75 chars.
> This is found by smatch and only compile tested.
> ---
>  drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> index 7bac7841ff0a..7fa360073f6e 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> @@ -1610,8 +1610,8 @@ void tpmi_sst_dev_remove(struct auxiliary_device *auxdev)
>  	tpmi_sst->partition_mask_current &= ~BIT(plat_info->partition);
>  	/* Free the package instance when the all partitions are removed */
>  	if (!tpmi_sst->partition_mask_current) {
> -		kfree(tpmi_sst);
>  		isst_common.sst_inst[tpmi_sst->package_id] = NULL;
> +		kfree(tpmi_sst);
>  	}
>  	mutex_unlock(&isst_tpmi_dev_lock);
>  }


