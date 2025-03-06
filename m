Return-Path: <linux-kernel+bounces-549493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D562FA55336
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B0E3B068F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDE325A33B;
	Thu,  6 Mar 2025 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U69zYXBg"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D43A19B5B4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741282706; cv=none; b=jeazmkicweIaF9mn4wt3nVlOd3StWzs6yCfiqeC+ORO8D+WijDozPwJa6Ontn6BVIgZZZ6sr2aFa18c7NRKS1mmNtGCfL5/2OkPRTc8XQ6BVVAV5pjGJPPJjc8tL+ULlhgD2OvJX+bwWYQh5+ee+bx84kbd+c4gNGAOyHwWCADg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741282706; c=relaxed/simple;
	bh=Nl8LrgKwogtQyQXiVUfTaPo6GNP5YIqwElIwd0S7ruQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sD2aW709RbkHj4YsofSR74546IXrsvVKJWmMx0cTYemMWVF4CQBiDzrs8zyYibQZH1Zc8GDk3ip5+Pom+qBY4Nlk9GTlPwVMvf2x4M9Oenxmy2KdQZiCt7EVweL+5fzCJeS0Z+riplI5QBcAlG+Ai13F/BZnAVPs77+UAv6SSBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U69zYXBg; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22349dc31bcso18063045ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 09:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741282704; x=1741887504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vOLh9gzLLTnBkEL+yV1uI1454538r2FfTEhP5HmpB1o=;
        b=U69zYXBggTGNHU5DZYG91QVEs7khjQo36fCwEzuaIE6tITCa4InCnWiKeAFP2BRBHc
         hflcSDIIdnOP0ZGTuNcoMM5sScKvOt544MNXSkP7sXuax4RqsCBF+Pkt5h12SEnqQo31
         ppMVyJPx3DvJxNOahjmW8zTITBLhy4aKhm+v6B0apJLGZyu2pqpae6ismvQCpeWBAmhw
         as+8X+Kak35OtAkfAj20PP0qR6Sc/Dig+jlp08N9lqSvhjJp8lJjfLEi4bRby0LMg4bm
         vtgvWHH4hAx8bJu8qKdlgjFezCSEkQ3Q7VZiL61ZoJPxoOL1cnD9RzvKvT29NCO7E5QC
         U7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741282704; x=1741887504;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vOLh9gzLLTnBkEL+yV1uI1454538r2FfTEhP5HmpB1o=;
        b=Mo77JKyqJ9KBpst6LhiLXOzkdzT0Fkyn+Fz1ruWrXwL0B4pmwxlWYMhJ8c56MOEYnN
         +JQKKsfLSafd9R8+QehZg9iG4STP3kKC7BOW/zRt3rt+j4kG75weBhBOSks9m1aSeayv
         ynpjEj1bl7DK3MpqMOIAT15dFvNx9apJpJZkp6y4gjDUi9bM+UDNO1ZSKuD8ZK/6Ckr4
         prmzGKXbLVpyVGdbRgAERRjBfMp5YqDI7rKlvHtVDzm50G13bAiVAUVci1SoUc8Fow/u
         OSRZM2jItTZ54BRmje9HsOOeXp+rQ6LEbmPW2/mRRYtXzKKEwmaBXBaakb9eIxwRtu4l
         7Few==
X-Forwarded-Encrypted: i=1; AJvYcCXl0HDq55YUClHW0FHudpNqLGtSaG0x/WBXawvplun8flfs4l+LAZT7JfdfyuOrokGMRMqzg5s1qJjVwnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy59X9KvF0op3I6LYIP8882B4IYpIC2D/PyOXMrCrFcQKwW9wnZ
	iWXn6g1yujOHwzU1jqYyRvGhlCj21nKuC39Cjo5oP4zKbxc16ljanHeIMw==
X-Gm-Gg: ASbGncvkRD/bjua2o1Tn4/IoRltF7wfd+KyCoxRfdd6ROwxk5NdoQOcvXRhF0/tfIeb
	IkJsbtGapxW71WPMNwCClFQFAA/5GFuN3Cnll8Xodq1YQHWuUnTp7orHID1RDW/hxcfClaeE8oj
	5kgLHeuIFLJRrO4IntW82KNI7dWk8S6HVvig1NmLh2i/X8UfkDUBlvNS4AUWVK2rWpw7yTAcWTC
	bQ9wHGAVC9450++ihuNrhrVmKDia1kvngNb2P4+IWGnKMCotIlWtB0PawbviMh9Lxxrxbc33jOD
	tXzpdsnuXhlGDn0YcMC+SzmGY0070FMrRseYKZQy5PtxQLOS
X-Google-Smtp-Source: AGHT+IE9qyV8d9/1YplE6bXK6QT01t3t9rgog6hxOfOk/24ZIViC5gY/auBymcqgFNZlpeaHkchN8g==
X-Received: by 2002:a05:6a00:1819:b0:736:53ce:a32c with SMTP id d2e1a72fcca58-736aaac644bmr192705b3a.17.1741282704310;
        Thu, 06 Mar 2025 09:38:24 -0800 (PST)
Received: from [10.3.72.248] ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7369844cfd8sm1636038b3a.83.2025.03.06.09.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 09:38:24 -0800 (PST)
Message-ID: <0d473dc1-cbbe-4a1e-933a-938438db24f5@gmail.com>
Date: Thu, 6 Mar 2025 23:08:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panel: novatek-nt36523: transition to mipi_dsi
 wrapped functions
To: Doug Anderson <dianders@chromium.org>, neil.armstrong@linaro.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 lujianhua000@gmail.com, quic_jesszhan@quicinc.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Anusha Srivatsa <asrivats@redhat.com>
References: <20250306134350.139792-1-tejasvipin76@gmail.com>
 <ca5b0825-a485-4bec-bd93-b57a8d7ced99@linaro.org>
 <CAD=FV=VoW-Zm5wY6Y9sr=GqnvfMP4urGw_zW8NJRHpdC4=rHXQ@mail.gmail.com>
Content-Language: en-US
From: Tejas Vipin <tejasvipin76@gmail.com>
In-Reply-To: <CAD=FV=VoW-Zm5wY6Y9sr=GqnvfMP4urGw_zW8NJRHpdC4=rHXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/6/25 10:58 PM, Doug Anderson wrote:
> Hi,
> 
> On Thu, Mar 6, 2025 at 6:05 AM <neil.armstrong@linaro.org> wrote:
>>
>> On 06/03/2025 14:43, Tejas Vipin wrote:
>>> Changes the novatek-nt36523 panel to use multi style functions for
>>> improved error handling.
>>>
>>> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
>>> ---
>>>   drivers/gpu/drm/panel/panel-novatek-nt36523.c | 1683 ++++++++---------
>>>   1 file changed, 823 insertions(+), 860 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
>>> index 04f1d2676c78..922a225f6258 100644
>>> --- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
>>> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
>>> @@ -23,10 +23,12 @@
>>>
>>>   #define DSI_NUM_MIN 1
>>>
>>> -#define mipi_dsi_dual_dcs_write_seq(dsi0, dsi1, cmd, seq...)        \
>>> -             do {                                                 \
>>> -                     mipi_dsi_dcs_write_seq(dsi0, cmd, seq);      \
>>> -                     mipi_dsi_dcs_write_seq(dsi1, cmd, seq);      \
>>> +#define mipi_dsi_dual_dcs_write_seq_multi(dsi_ctx0, dsi_ctx1, cmd, seq...)      \
>>> +             do {                                                            \
>>> +                     mipi_dsi_dcs_write_seq_multi(&dsi_ctx0, cmd, seq);      \
>>> +                     dsi_ctx1.accum_err = dsi_ctx0.accum_err;                \
>>> +                     mipi_dsi_dcs_write_seq_multi(&dsi_ctx1, cmd, seq);      \
>>> +                     dsi_ctx0.accum_err = dsi_ctx1.accum_err;                \
>>
>> Just thinking out loud, but can't we do :
>>
>> struct mipi_dsi_multi_context dsi_ctx = { .dsi = NULL };
>>
>> #define mipi_dsi_dual_dcs_write_seq_multi(dsi_ctx, dsi0, dsi1, cmd, seq...)      \
>>                 do {
>>                         dsi_ctx.dsi = dsi0;                                     \
>>                         mipi_dsi_dcs_write_seq_multi(&dsi_ctx, cmd, seq);       \
>>                         dsi_ctx.dsi = dsi1;                                     \
>>                         mipi_dsi_dcs_write_seq_multi(&dsi_ctx, cmd, seq);       \
>>
>> ?
>>
>> So we have a single accum_err.
> 
> Even though the code you used was what I suggested in IRC, I like
> Neil's suggestion better here. What do you think?

I like Dmitry's suggestion [1]. If we went ahead with this we'd also
only need to equate the accum_err for the few msleep calls. Since it
does change the behavior, I'd like to hear another opinion on it before
I go ahead with it.

[1]: https://lore.kernel.org/all/p2esqngynwfrshz5rqfnmx6qgwf4dclpkb3mphwg2vavx2jbcg@clqoy5tjh7bb/

> 
> Other than that, it looks good to me.
> 
> -Doug

-- 
Tejas Vipin

