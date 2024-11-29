Return-Path: <linux-kernel+bounces-425968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7C49DED14
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 23:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3634F163893
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 22:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDA519F40B;
	Fri, 29 Nov 2024 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XkwwLXSU"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E593DAD23
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 22:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732918109; cv=none; b=Hnz4AP+c14sD/ETp+EQCCO2fBWOquxJVCWLpCQOhME+QnXozrbMjiD8T2je2rU9BAFz6U+DP/Kql7ymJlSdZSeeEJacvNIDedVlz2uO2SGXncIrXD1Le2I9VF8WX4rlZ5h3v6qREhY2Em2sVHwKoWdO/mtcEaG7KZgvX5fe4xw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732918109; c=relaxed/simple;
	bh=/WQcakJntjnKDdENquAqv1u573OYRHhGtVyLY82xHb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6jsgJ9G6irSQZoiPZN+TYVU8OEdhG2B9iQWtb1+1IKIistkrbJAVpxtLW4tbk5WrCK3pqKAaR+1eDpehU3M5U6xZLFJnSGhBch/Fp2kg3TIbY6TircOM1fdioWyFpWq7hg7iSuK/YnhQ/yrXArNDW94GYJeCidY4KlACqBTGz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XkwwLXSU; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-382610c7116so1701469f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 14:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732918106; x=1733522906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bv+RDL5VtDpiSASI6Cfg2FBEfPwyElLYZP3W3W3ijq0=;
        b=XkwwLXSUDFFRrCzf/W6DXZmOTFEHJwqzSQI4iy7tCDyfXLKguG5O228NVSHjiQwSls
         V/ViTHKWFdY8VpMJYg2ntb4GPxLaWkBWuee4429P6PUMNfI7ukq2WFrim0Efjb3W+1P8
         jR27GdS5fEIFnPYpvqNFVRKMZ86z7bxoja6yvxc+G/zRI/RnW9FF5Avftaeo22oFltmL
         SLadVizSDcdjmRKEr1fTh+B/0OoxpbKDUy+L2llWQXiKLWQ/CSoxDKqZVC0LuXDLKa6a
         tbyTTgXfMqEYa893GFwdI0D9jiAf3Ut0y4T88+dgbUNCXWCHXrpZfTadnoG8XXpgjYoh
         Wwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732918106; x=1733522906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bv+RDL5VtDpiSASI6Cfg2FBEfPwyElLYZP3W3W3ijq0=;
        b=hCrjNyRIvwZfsc8VQ8zIlAydl7y7NQfpmjeZq4R6WFQcsbUP85u1KEqfme6QD12iBC
         tAwqiDR7RyFLixZgAWV7uLjxjBxJc7o9ay23VVGCv/isekmdCTuo4HnAFtWt2HfyQlv8
         cDVR2ID8jBQ5FjiO/6wol0uQON6wNGeknFD3lDVxTFFlrpWOKYSvMq8ioPCD1cQQAJDs
         j53/Qyqpa/SxYHHLSPI7aeAUVoOyAW8dlS/uSOsCdrxkyG3bGQjvirw/8ceypWn5HAdm
         hRJH23fzt1NZbdpKozW0coKUPE0KBW6RV9jhMKLE1P+07CQP3/xVHfM/iNTkEKAOyGHk
         nAjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXUmFDG3kQwum2YyImJuIn9nbX385vzvL2UM0C9pvpbttujjlSeEypXTTZ40WIfdAGBkUhOZgBULfPxTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLtp+Vg3xyCRSbuzi9znKN22FfqPb2DZXqOOloffn2cMY4ReA9
	PNaBVmFPEGeIkneIej0ROXFzJHobP2Nmngpxl4JjIPoR/3X2MEq0mXzhqnnYzPM=
X-Gm-Gg: ASbGncvGLqY7CgtUuAYr/oE6GP4o6b8g5RJSp0L6BJ6VwiLZsgao95/2gPXoosam3+Q
	QA6EDzbBmxe0pO385pc0IqzgwS68UYC1rV4l0K4RxLJJHojAoWt+dJpBdVllmk+paeq0pAJNlyn
	1VXgsbCQspuHHat2jPYi889po6drdICGzwoZoHBfA9D2RywZ4nojvA6PfKZxHE0PrIjbIaGmyBC
	G8A+8NnMp4enwGu0no+iBpTodiE85qri4SwHRuE5JLvwqAHhuQe5uI90pkP5B8=
X-Google-Smtp-Source: AGHT+IEHWl/sgWlQ+JvJOImjM3Psic1w8cd3Fdn/taMUlSNKIrgzN2K8BkjTVqK7etuq74l/9gSjCw==
X-Received: by 2002:a05:6000:21c1:b0:382:5010:c8c3 with SMTP id ffacd0b85a97d-385c6eba982mr8609141f8f.28.1732918106207;
        Fri, 29 Nov 2024 14:08:26 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd2daffsm5492759f8f.13.2024.11.29.14.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 14:08:25 -0800 (PST)
Message-ID: <f4e47953-5a68-4ec5-860b-820b8eff2a2a@linaro.org>
Date: Fri, 29 Nov 2024 22:08:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: qcom: camss: fix VFE pm domain off
To: barnabas.czeman@mainlining.org
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yassine Oudjana <y.oudjana@protonmail.com>
References: <20241128-vfe_pm_domain_off-v2-1-0bcbbe7daaaf@mainlining.org>
 <3a5fd596-b442-4d3f-aae2-f454d0cd8e5c@linaro.org>
 <5cccec71-0cc7-492a-9fb9-903970da05c5@linaro.org>
 <d3a8d38c-9129-4fbd-8bd6-c91131d950ad@linaro.org>
 <a08e95fc03fce6cb0809a06900982c6c@mainlining.org>
 <8dfd2ee1-9baf-441f-8eb9-fa11e830334a@linaro.org>
 <ac765a062e94d549f4c34cf4c8b2c199@mainlining.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <ac765a062e94d549f4c34cf4c8b2c199@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/11/2024 13:46, barnabas.czeman@mainlining.org wrote:
> On 2024-11-29 13:25, Bryan O'Donoghue wrote:
>> On 29/11/2024 11:44, barnabas.czeman@mainlining.org wrote:
>>>> The change does not describe how to reproduce the problem, which commit
>>>> base is tested, which platform is testes, there is no enough 
>>>> information,
>>>> unfortunately.
>>> I can reproduce the problem with megapixels-sensorprofile on msm8953 and
>>> it can be reproduced with megapixels on msm8996.
>>> The base is the last commit on next.
>>
>> Can you verify if vfe_domain_on has run and if so whether or not 
>> genpd_link is NULL when that function exists.
>>
> I have added some debug logs it seems pm_domain_on and pm_domain_off is 
> called twice on the same object.
> [   63.473360] qcom-camss 1b00020.camss: pm_domain_on 19842ce8 link 
> 42973800
> [   63.481524] qcom-camss 1b00020.camss: pm_domain_on 19840080 link 
> 4e413800
> [   63.481555] qcom-camss 1b00020.camss: pm_domain_on 19842ce8 link 
> 42973800
> [   63.481632] qcom-camss 1b00020.camss: pm_domain_off 19840080 link 
> 4e413800
> [   63.481641] qcom-camss 1b00020.camss: pm_domain_off 19842ce8 link 
> 42973800
> [   63.654004] qcom-camss 1b00020.camss: pm_domain_off 19842ce8 link 0
>> That's the question.
>>
>> ---
>> bod

Could you provide this output ?

index 80a62ba112950..b25b8f6b00be1 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -595,6 +595,9 @@ void vfe_isr_reset_ack(struct vfe_device *vfe)
   */
  void vfe_pm_domain_off(struct vfe_device *vfe)
  {
+dev_info(camss->dev, "%s VFE %d genpd %pK genpd_link %pK\n",
+        __func__, vfe->id, vfe->genpd, vfe->genpd_link);
+
         if (!vfe->genpd)
                 return;

@@ -609,7 +612,8 @@ void vfe_pm_domain_off(struct vfe_device *vfe)
  int vfe_pm_domain_on(struct vfe_device *vfe)
  {
         struct camss *camss = vfe->camss;
-
+dev_info(camss->dev, "%s VFE %d genpd %pK genpd_link %pK\n",
+        __func__, vfe->id, vfe->genpd, vfe->genpd_link);
         if (!vfe->genpd)
                 return 0;

---
bod

