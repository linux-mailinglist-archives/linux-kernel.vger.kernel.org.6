Return-Path: <linux-kernel+bounces-277766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0833F94A622
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B153F28529D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94F91D174E;
	Wed,  7 Aug 2024 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j5Sb08Lg"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239B519066E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 10:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027573; cv=none; b=FEeNREmZhO4BpoIJVZPAskffVIKg7zqjcou0PuMA5tGUiJiJbkVZGtjjK1XTcmeTw4Z6VKEmu9CVkgFR5kxIZJoR5oqyV9ak1Mv8TGuhJAAAoXFyJmy645zOVLYi8fP/YFV9UGITSvKLXFaCnfu19DlNpA+QSqHe3P29zNvnFh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027573; c=relaxed/simple;
	bh=l1HgOodX/TVtOD0wCtcn/qd6n8AkKBtuNLop/rtKpnY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=aEWTPw5jdo8wu3CHf02KLBYs+hL6n+xXWZwwF8/IMOtYX0jWAvTEZ1I3VT3vzhuXYwodVEAEq0PDBlupTT5716Cwh3nvbNmb6a07rJ6zbEQlfnGUpkmKTXBaKGDKCR/jJkdo6j5OzuErhG9n/MRrUo9TGTiZNt+ZGw2eKcfRw0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j5Sb08Lg; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-1fc66fc35f2so5794845ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 03:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723027570; x=1723632370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DcfdKUXeiI0RflsU03nEHJTFXU6hNWDJiSM79+Zbsjk=;
        b=j5Sb08LgqeyeAF2epoDsHyW7uLdUZDjl94bOkIaQhjynMTNHoxfkCgSdBnAUc+fRKy
         IrTtXaa4Szz4DzELImCxRf54sEZK49aRVdgNRz8yX5kBaSqdX+IDSSURSt+OpppPJXCI
         1FmfQU36vhgyTSB0ABwslU3d1JpMTkAET6qiaQg7JT/nuSC08zqv1CgmManKw0hR7eMV
         BlxMDoNgFMi3FHsPuItjozFC29z0y3GsaYbApVhRn4VjI76PjJG/tUawkFAvWxk8uKfw
         MAZP7ly3cCSaOgVExFrGI1opjkX4rQViOzYSNejCeMTmZPNh7UcIExZAd2jdB2x8UK1I
         786A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723027570; x=1723632370;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DcfdKUXeiI0RflsU03nEHJTFXU6hNWDJiSM79+Zbsjk=;
        b=HVpHFfD53pBwg7axkTtpS74FrozGjc3pifx+SY2Ltm9rgvx7skNZ8siH6lyxBQcH1H
         DhH+fVibH4nD6WofXXV0ScN16FTuz674xB5eSpvJ3QxpyhnyPz9rha/URSYl8O9N2LPu
         abUUnAeNF/B2Nw2qGn2ZZ/PohBLQGgYKDCaRxWhCSaczNQpf2g9K+sPzJPifwpWIoY23
         RRnEi5KjeY9L2RHgyFq+zznONpDOT/B1WyhOvLN4QhOqY/suOX0hNZ4n3kCo/GVqjRar
         q+kkgNHQjSeRdfXy4fhcpeMU/zQDeOe0clbRSAAeq0UNEDaXBczLsuIKFnmHYfBX2rU0
         R2+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVG1P+fvReO6wm3TcXRYUIXZ8kXkc/NnUyt75saWzxgJVLfMujOwwr5RysQEzy2uIw+ZVqa4Oxoeondo5GDCXglheN6fbTzpPgcNlJO
X-Gm-Message-State: AOJu0YxXMX2mRhod8p5SHnRsxS5qU6I5gB88lMIGQTlph/hCY6dtepnP
	GVjiguGej6GcYw3Is06Q7u8rojOJpfJjWCEafuyRCt0ml2iQkvc3XKUBPqa1iC4=
X-Google-Smtp-Source: AGHT+IHj1q9mnqROH1Frx3vYDFQ/RJEPn1e6A0NiqFVGzeKu1qvj297UTqh1jOAY4F0eH5Xa+lNJlg==
X-Received: by 2002:a17:902:e5c6:b0:1fa:1be4:1e48 with SMTP id d9443c01a7336-20085418b8cmr23058915ad.11.1723027570477;
        Wed, 07 Aug 2024 03:46:10 -0700 (PDT)
Received: from [127.0.0.1] ([182.232.168.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592b3fa6sm102793885ad.304.2024.08.07.03.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 03:46:10 -0700 (PDT)
Date: Wed, 07 Aug 2024 17:46:03 +0700
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, Rob Clark <robdclark@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jeykumar Sankaran <jsanka@codeaurora.org>, stable@vger.kernel.org,
 Leonard Lausen <leonard@lausen.nl>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/2=5D_drm/msm/dpu1=3A_don=27t_c?=
 =?US-ASCII?Q?hoke_on_disabling_the_writeback_connector?=
User-Agent: K-9 Mail for Android
In-Reply-To: <800e03d2-01b0-4bde-816a-e45e1acdd039@quicinc.com>
References: <20240802-dpu-fix-wb-v2-0-7eac9eb8e895@linaro.org> <20240802-dpu-fix-wb-v2-1-7eac9eb8e895@linaro.org> <800e03d2-01b0-4bde-816a-e45e1acdd039@quicinc.com>
Message-ID: <42B219B7-01DE-47CC-9D31-E27E40C04428@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 6, 2024 2:19:46 AM GMT+07:00, Abhinav Kumar <quic_abhinavk@quicin=
c=2Ecom> wrote:
>
>
>On 8/2/2024 12:47 PM, Dmitry Baryshkov wrote:
>> During suspend/resume process all connectors are explicitly disabled an=
d
>> then reenabled=2E However resume fails because of the connector_status =
check:
>>=20
>> [ 1185=2E831970] [dpu error]connector not connected 3
>>=20
>> It doesn't make sense to check for the Writeback connected status (and
>> other drivers don't perform such check), so drop the check=2E
>>=20
>> Fixes: 71174f362d67 ("drm/msm/dpu: move writeback's atomic_check to dpu=
_writeback=2Ec")
>> Cc: stable@vger=2Ekernel=2Eorg
>> Reported-by: Leonard Lausen <leonard@lausen=2Enl>
>> Closes: https://gitlab=2Efreedesktop=2Eorg/drm/msm/-/issues/57
>> Signed-off-by: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_writeback=2Ec | 3 ---
>>   1 file changed, 3 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback=2Ec b/drivers/=
gpu/drm/msm/disp/dpu1/dpu_writeback=2Ec
>> index 16f144cbc0c9=2E=2E8ff496082902 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback=2Ec
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback=2Ec
>> @@ -42,9 +42,6 @@ static int dpu_wb_conn_atomic_check(struct drm_connec=
tor *connector,
>>   	if (!conn_state || !conn_state->connector) {
>>   		DPU_ERROR("invalid connector state\n");
>>   		return -EINVAL;
>> -	} else if (conn_state->connector->status !=3D connector_status_connec=
ted) {
>> -		DPU_ERROR("connector not connected %d\n", conn_state->connector->sta=
tus);
>> -		return -EINVAL;
>>   	}
>
>For this issue, do we hit the connector->force =3D DRM_FORCE_OFF path?

It was hit during the suspend/resume, so yes, it is a forced off, but by t=
he different means=2E

>
>Because otherwise, writeback does not implement =2Edetect() callback toda=
y so its always connected=2E

It is undefined/unkown (3), not connected (1)

>
>But if that was the case how come this error is only for writeback=2E Eve=
n DP has the same connected check in atomic_check()
>
>Change seems fine with me because ideally this seems like a no-op to me b=
ecause writeback connector is assumed to be always connected but the issue =
is missing some details here=2E
>
>>     	crtc =3D conn_state->crtc;
>>=20


--=20
With best wishes
Dmitry

