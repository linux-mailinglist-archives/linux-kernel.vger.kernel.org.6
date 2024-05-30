Return-Path: <linux-kernel+bounces-195529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4758D4E14
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B8CDB2433E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FE917C237;
	Thu, 30 May 2024 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iGtzQtqa"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F3B17C21D
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079685; cv=none; b=gUG6BCXUuksEegDwc8RWuPd/3TTedPtlgzQhxIIvaK27ZGCtONKR/nip0Iv5M9ffKUpqZpo5cZbinVy/I8SgLgBEFjGkjBo+8MbED/PXy7vpylOPbhF6lYf4FQU+AvMRcmO6Tjt+U+mZhTe5Fxw5kqZg4zNI3RkE7pT5FYv7ES8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079685; c=relaxed/simple;
	bh=1qCz4gxX5VkDo8qBKe707hsmEHKhe8QwQY8YDu0jtPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7lKRsoFeC9YM5j/4tmO478hH7AZ40x3+fuPoZzTtVLIiigRKNLV5b1ODcxGVADH7hYUnlo2HehhT32Sm1XX5exZ7SSWGWn0+/H00K0lIhKkrxVwvwMAnmDlqn7vq/7XmG0gWfiPTQns8Wzan5TRPmoWab89RKywxagfg7P8R4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iGtzQtqa; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52b7ca4ad02so1036789e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717079681; x=1717684481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nexbWWHw4HmMZ2rLkky2t/GA+e/X7pKJTR1LckTnZc4=;
        b=iGtzQtqa8/9qdkVe+zI+Bro/+LieWct6afUFkf5twAiIdRucll/62odIAnI1pM6P7y
         RE2I5WmO/Cc3SxyBd44XjvYy5ZWCir0E4KZgGSznLwm6idlu7l0h9Y0UDDYgcE+BW5JT
         FCn/1srK0wuN48CP06zYalTJYZkK8knUhfKHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717079681; x=1717684481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nexbWWHw4HmMZ2rLkky2t/GA+e/X7pKJTR1LckTnZc4=;
        b=gd77YQM4wk32A7u0Co9GoZE+SZwoNftOtlEOyJc+ESyf1d0W8/HOjPbfWqSZz242FR
         ka0BSMTq8tdNQZbCwsHHKagSaz995jRQeJ48q0j66bEj4EeeHDlCtE3jF1BYi1VTKASI
         3B0lSP8D63CLKzzSAHx7OdEoWJ5w5OG6irtDGb150NSXVBoxkf9VyTyId9HCliRcVV97
         /YbquqOCV2tj2wy9Tq10OmniCMMaQeVRqRL7K9GZZ1Sn4OZOQ/FDMba5C20DZ93sePSE
         tz5+VJFGYlepdbu4QrrHyuMkqtprDBP5TlxwZc16A49O5SwPcMmz+SnxXMqOjF8cPIUB
         UqMg==
X-Forwarded-Encrypted: i=1; AJvYcCW5EmCW3ZpESzk0x0aiLQfJ/R+deQQJaXE/FxjRnk2R295GsZaNFWBvtzIUWZw/+Pg3qm9HKniHSSFHMUS+uwkRcVQyHh8wvpq8IuOp
X-Gm-Message-State: AOJu0Yw0UvMJQCQ694oGCUxsA43a08KzmBuyN667RGjDsxq/0dkX6WeR
	WIhBiVADZ0NkXaA1LKkRR4+BmUigaa9CKZJGFONf01ka6pO8z3PsbiSByEJ7X6mVnPZAK65IuET
	iPg==
X-Google-Smtp-Source: AGHT+IEe85GxxwbDL6lC9aD1P5colNamdya51oT2ljoQmSdtkDgmRIylgmni5DfRG/zCvPD9RjCggA==
X-Received: by 2002:a05:6512:63:b0:528:649b:d7bb with SMTP id 2adb3069b0e04-52b7d3ad426mr1515606e87.0.1717079680993;
        Thu, 30 May 2024 07:34:40 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5785238bb59sm9962457a12.30.2024.05.30.07.34.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 07:34:40 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso16339a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:34:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVguzoiuB43KRItxskUpG5mZA31b2+5aSQeoOAmn9WuY9wZVF10zFw9QNDdAgdPWctCrA9Olaoe2UKDX29vk6qP895Yr9+dsatQE8GZ
X-Received: by 2002:aa7:c14a:0:b0:57a:2276:2a86 with SMTP id
 4fb4d7f45d1cf-57a22762bcfmr100726a12.4.1717079678834; Thu, 30 May 2024
 07:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529-edp-panel-drop-v2-0-fcfc457fc8dd@linaro.org> <20240529-edp-panel-drop-v2-3-fcfc457fc8dd@linaro.org>
In-Reply-To: <20240529-edp-panel-drop-v2-3-fcfc457fc8dd@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 30 May 2024 07:34:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VZCeawkF+c8yhwMuR3_LF3Z0swT1L-_r9kRccaxJqUTg@mail.gmail.com>
Message-ID: <CAD=FV=VZCeawkF+c8yhwMuR3_LF3Z0swT1L-_r9kRccaxJqUTg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/panel-edp: drop several legacy panels
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, Jeffrey Hugo <quic_jhugo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 28, 2024 at 4:53=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> The panel-edp driver supports legacy compatible strings for several eDP
> panels which were never used in DT files present in Linux tree and most
> likely have never been used with the upstream kernel. Drop compatibles
> for these panels in favour of using a generic "edp-panel" device on the
> AUX bus.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 173 ++------------------------------=
------
>  1 file changed, 7 insertions(+), 166 deletions(-)

All of these are fine as per my research [1].

Reviewed-by: Douglas Anderson <dianders@chromium.org>

[1] https://lore.kernel.org/r/CAD=3DFV=3DXz1VsF8jG0q-Ldk+p=3DNY-ChJkTk0iW8f=
q2bO=3DoRFvXRA@mail.gmail.com

